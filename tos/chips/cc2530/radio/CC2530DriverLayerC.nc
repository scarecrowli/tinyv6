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

#include <RadioConfig.h>
#include <CC2530DriverLayer.h>

configuration CC2530DriverLayerC
{
	provides
	{
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

		interface LocalTime<TRadio> as LocalTimeRadio;
		interface Alarm<TRadio, tradio_size>;
        interface PacketAcknowledgements;
	}

	uses
	{
		interface CC2530DriverConfig as Config;
		interface PacketTimeStamp<TRadio, uint32_t>;

		interface PacketFlag as TransmitPowerFlag;
		interface PacketFlag as RSSIFlag;
		interface PacketFlag as TimeSyncFlag;

        interface Ieee154PacketLayer;
        interface PacketFlag as AckReceivedFlag;

	}
}

implementation
{
	components CC2530DriverLayerP, BusyWaitMicroC, TaskletC,
		LocalTime32khzC, new Alarm32khz16C();

	RadioState = CC2530DriverLayerP;
	RadioSend = CC2530DriverLayerP;
	RadioReceive = CC2530DriverLayerP;
	RadioCCA = CC2530DriverLayerP;
	RadioPacket = CC2530DriverLayerP;

	LocalTimeRadio = LocalTime32khzC;

	Config = CC2530DriverLayerP;

	PacketTransmitPower = CC2530DriverLayerP.PacketTransmitPower;
	TransmitPowerFlag = CC2530DriverLayerP.TransmitPowerFlag;

	PacketRSSI = CC2530DriverLayerP.PacketRSSI;
	RSSIFlag = CC2530DriverLayerP.RSSIFlag;

	PacketTimeSyncOffset = CC2530DriverLayerP.PacketTimeSyncOffset;
	TimeSyncFlag = CC2530DriverLayerP.TimeSyncFlag;

	PacketLinkQuality = CC2530DriverLayerP.PacketLinkQuality;
	PacketTimeStamp = CC2530DriverLayerP.PacketTimeStamp;
	LinkPacketMetadata = CC2530DriverLayerP;

	CC2530DriverLayerP.LocalTime -> LocalTime32khzC;

	Alarm = Alarm32khz16C;

	CC2530DriverLayerP.Tasklet -> TaskletC;
	CC2530DriverLayerP.BusyWait -> BusyWaitMicroC;

	components MainC, RealMainP;
	RealMainP.PlatformInit -> CC2530DriverLayerP.PlatformInit;
	MainC.SoftwareInit -> CC2530DriverLayerP.SoftwareInit;

#ifdef RADIO_DEBUG
    components DiagMsgC;
    CC2530DriverLayerP.DiagMsg -> DiagMsgC;
#endif

    AckReceivedFlag = CC2530DriverLayerP.AckReceivedFlag;
    PacketAcknowledgements = CC2530DriverLayerP;
    Ieee154PacketLayer = CC2530DriverLayerP;

}
