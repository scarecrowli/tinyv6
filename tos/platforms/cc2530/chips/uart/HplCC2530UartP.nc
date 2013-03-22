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

module HplCC2530UartP {
    provides interface Init as Uart0Init;
    provides interface StdControl as Uart0TxControl;
    provides interface StdControl as Uart0RxControl;
    provides interface HplCC2530Uart as HplUart0;

    uses interface McuPowerState;
}
implementation {
    enum {
        TX_BYTE = _BV(1),
        RX_BYTE = _BV(2),
    };
    command error_t Uart0Init.init() {
        /* Peripheral I/O control, bit 0 = U0CFG,
         * 0: Alternative 1 location
         * 1: Alternative 2 location */
        PERCFG &= ~0x01;

        /* Port 0 Function Select, for usart0 */
        P0SEL = 0x3c; // 0011 1100

        /* USART 0 Control and Status
         * UART mode, Receiver enabled */
        U0CSR |= 0x80 | 0x40; 

        /*             (256+BAUD_M)*2^BAUD_E
           BaudRate = ----------------------- * f
                             2^28
         */

        /* USART 0 Generic Control, BAUD_E */
        U0GCR = 0x0b; // 0000 1011;
        /* USART 0 Baud-Rate Control, BAUD_M */
        U0BAUD = 216; // set baudrate 57600, due to clk is 16MHz
        // TODO: should set to PLATFORM_BAUDRATE
        

        return SUCCESS;
    }

    command error_t Uart0TxControl.start() {
        return SUCCESS;
    }

    command error_t Uart0TxControl.stop() {
        return SUCCESS;
    }

    command error_t Uart0RxControl.start() {
        return SUCCESS;
    }

    command error_t Uart0RxControl.stop() {
        return SUCCESS;
    }

    async command error_t HplUart0.enableTxIntr() {
        /*
          USART 0 TX interrupt enable
          0: Interrupt disabled
          1: Interrupt enabled

          UTX0IE = 1;
          UTX0IE is bit 2
         */
        atomic {
            IEN2 |= _BV(2);
        }
        return SUCCESS;
    }

    async command error_t HplUart0.disableTxIntr(){
        atomic {
            IEN2 &= ~_BV(2);
        }
        return SUCCESS;
    }

    async command error_t HplUart0.enableRxIntr(){
        /*
           USART0 RX interrupt enable
           0: Interrupt disabled
           1: Interrupt enabled
         */
        atomic {
            URX0IE = 1;
        }
        return SUCCESS;
    }

    async command error_t HplUart0.disableRxIntr(){
        atomic {
            URX0IE = 0;
        }
        return SUCCESS;
    }

    async command bool HplUart0.isTxEmpty(){
        if (U0CSR&TX_BYTE) {
            return TRUE;
        } else {
            return FALSE;
        }
    }

    async command bool HplUart0.isRxEmpty(){
        if (U0CSR&RX_BYTE) {
            return FALSE;
        } else {
            return TRUE;
        }
    }

    async command uint8_t HplUart0.rx(){
        uint8_t ch;

        ch = U0DBUF;

        return ch;
    }

    async command void HplUart0.tx(uint8_t data) {
        atomic {
            U0DBUF = data;
        }
    }

    CC2530_INTERRUPT(URX0_VECTOR)
    {
        uint8_t ch;

        atomic {
            URX0IF = 0;
            ch = U0DBUF;
            signal HplUart0.rxDone(ch);
        }
    }

    CC2530_INTERRUPT(UTX0_VECTOR)
    {
        atomic {
            UTX0IF = 0;
            signal HplUart0.txDone();
        }
    }
}
