/*
 * Copyright (c) 2013 Northwestern Polytechnical University, China
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * - Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 *
 * - Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in the
 *   documentation and/or other materials provided with the
 *   distribution.
 *
 * - Neither the name of the copyright holders nor the names of
 *   its contributors may be used to endorse or promote products derived
 *   from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL
 * THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 */

/*
 * @author Qiu Ying <qiuying@mail.nwpu.edu.cn>
 * @date 2013/03/22
 * @description
 */

#include <CC2530DriverLayer.h>
#include <Tasklet.h>
#include <RadioAssert.h>
#include <TimeSyncMessageLayer.h>
#include <RadioConfig.h>

module CC2530DriverLayerP
{
    provides {
        interface Init as PlatformInit @exactlyonce();
        interface Init as SoftwareInit @exactlyonce();

        interface RadioState;
        interface RadioSend;
        interface RadioReceive;
        interface RadioCCA;
        interface RadioPacket;

        interface PacketField<uint8_t> as PacketTransmitPower;
        interface PacketField<uint8_t> as PacketRSSI;
        interface PacketField<uint8_t> as PacketTimeSyncOffset;
        interface PacketField<uint8_t> as PacketLinkQuality;
        interface LinkPacketMetadata;
        interface PacketAcknowledgements;
    }
    uses {
        interface BusyWait<TMicro, uint16_t>;
        interface LocalTime<TRadio>;

        interface CC2530DriverConfig as Config;

        interface PacketFlag as TransmitPowerFlag;
        interface PacketFlag as RSSIFlag;
        interface PacketFlag as TimeSyncFlag;

        interface PacketTimeStamp<TRadio, uint32_t>;

        interface Tasklet;
        interface Ieee154PacketLayer;
        interface PacketFlag as AckReceivedFlag;

#ifdef RADIO_DEBUG
        interface DiagMsg;
#endif
    }
}

implementation
{
    message_t m_message;
    uint8_t m_channel;

    norace uint8_t sig;

    enum {
        SIG_NONE,
        SIG_RADIO_STATE_DONE,
        SIG_RADIO_CCA_DONE,
    };

    enum {
        S_IDLE,
        S_SENDING,
    };

    enum {
        /* channel */
        MIN_CHANNEL = 11,   // 2405 MHz
        MAX_CHANNEL = 26,   // 2480 MHz
        CHANNEL_SPACING = 5,// MHz

        /* radio settings */
        AUTO_ACK = 0x20,
        AUTO_CRC = 0x40,

        /* RF interrupt flags */
        IRQ_RXPKTDONE = _BV(6),

        IRQ_TXDONE = _BV(1),
        IRQ_RFIDLE = _BV(2),

        /* selected strobes */
        ISRXON    = 0xE3,
        ISTXON    = 0xE9,
        ISTXONCCA = 0xEA,
        ISRFOFF   = 0xEF,
        ISFLUSHRX = 0xEC,
        ISFLUSHTX = 0xEE,

    };

    cc2530_header_t* getHeader(message_t* msg)
    {
        return (cc2530_header_t*)((uint8_t*)msg + call Config.headerLength(msg));
    }

    void* getPayload(message_t* msg)
    {
        return ((uint8_t*)msg) + call RadioPacket.headerLength(msg);
    }

    cc2530_metadata_t* getMeta(message_t* msg)
    {
        return (cc2530_metadata_t*)((uint8_t*)msg + sizeof(message_t) - call RadioPacket.metadataLength(msg));
    }

    command error_t PlatformInit.init()
    {
        return SUCCESS;
    }

    command error_t SoftwareInit.init()
    {

        FRMCTRL0 |= AUTO_ACK|AUTO_CRC;

        /* Recommended RX settings */
        TXFILTCFG = 0x09;
        AGCCTRL1 = 0x15;
        FSCAL1 = 0x00;

        /* enable general RF interrupts */
        IEN2 |= _BV(0);

        /* set channel */
        call RadioState.setChannel(CC2530_DEF_CHANNEL);

        SHORT_ADDR0 = TOS_NODE_ID&0xff;
        SHORT_ADDR1 = (TOS_NODE_ID>>8)&0xff;
        PAN_ID0 = TOS_AM_GROUP&0xff;
        PAN_ID1 = (TOS_AM_GROUP>>8)&0xff;

        /* enable RXPKTDONE interrupt */
        RFIRQM0 |= IRQ_RXPKTDONE;
        RFIRQM1 |= IRQ_TXDONE;

        return SUCCESS;
    }

    /*----------------- CHANNEL -----------------*/
    tasklet_async command uint8_t RadioState.getChannel()
    {
        return (FREQCTRL - MIN_CHANNEL)/CHANNEL_SPACING + MIN_CHANNEL;
    }

    tasklet_async command error_t RadioState.setChannel(uint8_t c)
    {
        if (c >= MIN_CHANNEL && c <= MAX_CHANNEL) {
            FREQCTRL = MIN_CHANNEL + CHANNEL_SPACING*(c - MIN_CHANNEL);
            return SUCCESS;
        } else {
            return FAIL;
        }
    }

    /*----------------- TURN ON/OFF -----------------*/
    tasklet_async command error_t RadioState.turnOff()
    {
        RFST = ISRFOFF;

        return SUCCESS;
    }

    tasklet_async command error_t RadioState.standby()
    {
        // TODO: ...  
        return SUCCESS;
    }

    tasklet_async command error_t RadioState.turnOn()
    {
        RFST = ISFLUSHRX;
        RFST = ISRXON;

        sig = SIG_RADIO_STATE_DONE;
        call Tasklet.schedule();
        return SUCCESS;
    }

    default tasklet_async event void RadioState.done() { }

    /*----------------- TRANSMIT -----------------*/

    tasklet_async command error_t RadioSend.send(message_t* msg)
    {
        uint8_t i;
        uint8_t len;
        uint8_t* data;

        atomic { 
            data = getPayload(msg);
            len = getHeader(msg)->length;

            /* wait for SFD not active and TX_Active not active */
            while (FSMSTAT1 & (_BV(1) | _BV(5))); /* TX_ACTIVE | SFD */

            RFST = ISFLUSHTX;
            RFIRQF1 &= ~IRQ_TXDONE; /* clear TXDONE interrupt */

            RFD = len; /* the first byte to TX is the length of the frame */
            for (i = 0; i < len; i++) {
                RFD = data[i];
            }

            RFST = ISTXON;

            return SUCCESS;
        }
    }

    tasklet_async event void Tasklet.run()
    {
        switch(sig) {
            case SIG_RADIO_STATE_DONE:
                signal RadioState.done();
                sig = SIG_NONE;
                break;
            case SIG_RADIO_CCA_DONE:
                signal RadioCCA.done(SUCCESS);
                sig = SIG_NONE;
                break;
            default:
                break;
        }
    }

    default tasklet_async event void RadioSend.sendDone(error_t error) { }
    default tasklet_async event void RadioSend.ready() { }

    /*----------------- CCA -----------------*/

    tasklet_async command error_t RadioCCA.request()
    {
        sig = SIG_RADIO_CCA_DONE;
        call Tasklet.schedule();
        return SUCCESS;
    }

    default tasklet_async event void RadioCCA.done(error_t error) { }

    /*----------------- RECEIVE -----------------*/

    CC2530_INTERRUPT(RF_VECTOR)
    {
        atomic {

            if (RFIRQF1 & IRQ_TXDONE) {
                /*
                if( call Ieee154PacketLayer.getAckRequired(txMsg) )
                    call AckReceivedFlag.setValue(txMsg, temp != RF230_TRAC_NO_ACK);
                    */

                signal RadioSend.sendDone(SUCCESS);
                S1CON = 0; /* clear general RF interrupt flag */
                RFIRQF1 &= ~IRQ_TXDONE; /* clear TXDONE interrupt */
            }

            if (RFIRQF0 & IRQ_RXPKTDONE) {
                uint8_t i;
                uint8_t *data;
                uint8_t len;
                static message_t *msg = &m_message;

                data = getPayload(msg);
                len = RFD;
                len &= 0x7f;
                for (i = 0; i < len; i++) {
                    data[i] = RFD;
                };

                /* | length(1B) |        MPDU(n-2 B)         | FCS1(1B) |     FCS2(1B)     |
                   |     n      | MPDU_1 MPDU_2 .. MPDU_n-2  | RSSI | CRC_OK(1b), CORR(7b) |
                 */
                getHeader(msg)->length = len;
                call PacketRSSI.set(msg, data[len - 2]); 

                msg = signal RadioReceive.receive(msg);

#ifdef RADIO_DEBUG
                if( call DiagMsg.record() )
                {
                    call DiagMsg.str("receive");
                    call DiagMsg.uint8(len);
                    call DiagMsg.send();
                }
#endif
                S1CON = 0; /* clear general RF interrupt flag */
                RFIRQF0 &= ~IRQ_RXPKTDONE; /* clear RXPKTDONE interrupt */
            }
        }
    }

    default tasklet_async event bool RadioReceive.header(message_t* msg)
    {
        return TRUE;
    }

    default tasklet_async event message_t* RadioReceive.receive(message_t* msg)
    {
        return msg;
    }


    /*----------------- RadioPacket -----------------*/

    async command uint8_t RadioPacket.headerLength(message_t* msg)
    {

        return call Config.headerLength(msg) + sizeof(cc2530_header_t);
    }

    async command uint8_t RadioPacket.payloadLength(message_t* msg)
    {
        return getHeader(msg)->length - 2;
    }

    async command void RadioPacket.setPayloadLength(message_t* msg, uint8_t length)
    {
        // we add the length of the CRC, which is automatically generated
        getHeader(msg)->length = length + 2;
    }

    async command uint8_t RadioPacket.maxPayloadLength()
    {
        return call Config.maxPayloadLength() - sizeof(cc2530_header_t);
    }

    async command uint8_t RadioPacket.metadataLength(message_t* msg)
    {
        return call Config.metadataLength(msg) + sizeof(cc2530_metadata_t);
    }

    async command void RadioPacket.clear(message_t* msg)
    {
        // all flags are automatically cleared
    }

    /*----------------- PacketTransmitPower -----------------*/

    async command bool PacketTransmitPower.isSet(message_t* msg)
    {
        return TRUE;
    }

    async command uint8_t PacketTransmitPower.get(message_t* msg)
    {
        return getMeta(msg)->power;
    }

    async command void PacketTransmitPower.clear(message_t* msg)
    {
    }

    async command void PacketTransmitPower.set(message_t* msg, uint8_t value)
    {
        getMeta(msg)->power = value;
    }

    /*----------------- PacketRSSI -----------------*/

    async command bool PacketRSSI.isSet(message_t* msg)
    {
        return TRUE;
    }

    async command uint8_t PacketRSSI.get(message_t* msg)
    {
        return getMeta(msg)->rssi;
    }

    async command void PacketRSSI.clear(message_t* msg)
    {
    }

    async command void PacketRSSI.set(message_t* msg, uint8_t value)
    {
        getMeta(msg)->rssi = value;
    }

    /*----------------- PacketTimeSyncOffset -----------------*/

    async command bool PacketTimeSyncOffset.isSet(message_t* msg)
    {
        return TRUE;
    }

    async command uint8_t PacketTimeSyncOffset.get(message_t* msg)
    {
        return call RadioPacket.headerLength(msg) + call RadioPacket.payloadLength(msg) - sizeof(timesync_absolute_t);
    }

    async command void PacketTimeSyncOffset.clear(message_t* msg)
    {
    }

    async command void PacketTimeSyncOffset.set(message_t* msg, uint8_t value)
    {
    }

    /*----------------- PacketLinkQuality -----------------*/

    async command bool PacketLinkQuality.isSet(message_t* msg)
    {
        return TRUE;
    }

    async command uint8_t PacketLinkQuality.get(message_t* msg)
    {
        return getMeta(msg)->lqi;
    }

    async command void PacketLinkQuality.clear(message_t* msg)
    {
    }

    async command void PacketLinkQuality.set(message_t* msg, uint8_t value)
    {
        getMeta(msg)->lqi = value;
    }

    /*----------------- LinkPacketMetadata -----------------*/

    async command bool LinkPacketMetadata.highChannelQuality(message_t* msg)
    {
        return TRUE;
    }

    /*----------------- PacketAcknowledgements -----------------*/

    async command error_t PacketAcknowledgements.requestAck(message_t* msg)
    {
        call Ieee154PacketLayer.setAckRequired(msg, TRUE);

        return SUCCESS;
    }

    async command error_t PacketAcknowledgements.noAck(message_t* msg)
    {
        call Ieee154PacketLayer.setAckRequired(msg, FALSE);

        return SUCCESS;
    }

    async command bool PacketAcknowledgements.wasAcked(message_t* msg)
    {
        //TODO:
        return TRUE;
        //return call AckReceivedFlag.get(msg);
    }
}
