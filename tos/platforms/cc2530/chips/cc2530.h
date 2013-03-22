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


#ifndef CC2530_H
#define CC2530_H

/* NOTE: these declaration is just for CHEATING nesc compiler */

/* Port 0 */
norace volatile unsigned char P0 __attribute__((delete_this_line)); 
norace volatile unsigned char P0_7 __attribute__((delete_this_line)); 
norace volatile unsigned char P0_6 __attribute__((delete_this_line)); 
norace volatile unsigned char P0_5 __attribute__((delete_this_line)); 
norace volatile unsigned char P0_4 __attribute__((delete_this_line)); 
norace volatile unsigned char P0_3 __attribute__((delete_this_line)); 
norace volatile unsigned char P0_2 __attribute__((delete_this_line)); 
norace volatile unsigned char P0_1 __attribute__((delete_this_line)); 
norace volatile unsigned char P0_0 __attribute__((delete_this_line)); 
norace volatile unsigned char SP __attribute__((delete_this_line)); /* Stack Pointer */
norace volatile unsigned char DPL0 __attribute__((delete_this_line)); /* Data Pointer 0 Low Byte */
norace volatile unsigned char DPH0 __attribute__((delete_this_line)); /* Data Pointer 0 High Byte */
norace volatile unsigned char DPL1 __attribute__((delete_this_line)); /* Data Pointer 1 Low Byte */
norace volatile unsigned char DPH1 __attribute__((delete_this_line)); /* Data Pointer 1 High Byte */
norace volatile unsigned char U0CSR __attribute__((delete_this_line)); /* USART 0 Control and Status */
norace volatile unsigned char PCON __attribute__((delete_this_line)); /* Power Mode Control */

/* Interrupt Flags */
norace volatile unsigned char TCON __attribute__((delete_this_line)); 
norace volatile unsigned char URX1IF __attribute__((delete_this_line)); 
norace volatile unsigned char _TCON6 __attribute__((delete_this_line)); 
norace volatile unsigned char ADCIF __attribute__((delete_this_line)); 
norace volatile unsigned char _TCON4 __attribute__((delete_this_line)); 
norace volatile unsigned char URX0IF __attribute__((delete_this_line)); 
norace volatile unsigned char IT1 __attribute__((delete_this_line)); 
norace volatile unsigned char RFERRIF __attribute__((delete_this_line)); 
norace volatile unsigned char IT0 __attribute__((delete_this_line)); 
norace volatile unsigned char P0IFG __attribute__((delete_this_line)); /* Port 0 Interrupt Status Flag */
norace volatile unsigned char P1IFG __attribute__((delete_this_line)); /* Port 1 Interrupt Status Flag */
norace volatile unsigned char P2IFG __attribute__((delete_this_line)); /* Port 2 Interrupt Status Flag */
norace volatile unsigned char PICTL __attribute__((delete_this_line)); /* Port Interrupt Control */
norace volatile unsigned char P1IEN __attribute__((delete_this_line)); /* Port 1 Interrupt Mask */
norace volatile unsigned char _SFR8E __attribute__((delete_this_line)); /* not used */
norace volatile unsigned char P0INP __attribute__((delete_this_line)); /* Port 0 Input Mode */

/* Port 1 */
norace volatile unsigned char P1 __attribute__((delete_this_line)); 
norace volatile unsigned char P1_7 __attribute__((delete_this_line)); 
norace volatile unsigned char P1_6 __attribute__((delete_this_line)); 
norace volatile unsigned char P1_5 __attribute__((delete_this_line)); 
norace volatile unsigned char P1_4 __attribute__((delete_this_line)); 
norace volatile unsigned char P1_3 __attribute__((delete_this_line)); 
norace volatile unsigned char P1_2 __attribute__((delete_this_line)); 
norace volatile unsigned char P1_1 __attribute__((delete_this_line)); 
norace volatile unsigned char P1_0 __attribute__((delete_this_line)); 
norace volatile unsigned char RFIRQF1 __attribute__((delete_this_line)); /* RF Interrupt Flags MSB */
norace volatile unsigned char DPS __attribute__((delete_this_line)); /* Data Pointer Select */
norace volatile unsigned char MPAGE __attribute__((delete_this_line)); /* Memory Page Select */
norace volatile unsigned char T2CTRL __attribute__((delete_this_line)); /* Timer2 Control Register */
norace volatile unsigned char ST0 __attribute__((delete_this_line)); /* Sleep Timer 0 */
norace volatile unsigned char ST1 __attribute__((delete_this_line)); /* Sleep Timer 1 */
norace volatile unsigned char ST2 __attribute__((delete_this_line)); /* Sleep Timer 2 */

/* Interrupt Flags 2 */
norace volatile unsigned char S0CON __attribute__((delete_this_line)); 
norace volatile unsigned char _S0CON7 __attribute__((delete_this_line)); 
norace volatile unsigned char _S0CON6 __attribute__((delete_this_line)); 
norace volatile unsigned char _S0CON5 __attribute__((delete_this_line)); 
norace volatile unsigned char _S0CON4 __attribute__((delete_this_line)); 
norace volatile unsigned char _S0CON3 __attribute__((delete_this_line)); 
norace volatile unsigned char _S0CON2 __attribute__((delete_this_line)); 
norace volatile unsigned char ENCIF_1 __attribute__((delete_this_line)); 
norace volatile unsigned char ENCIF_0 __attribute__((delete_this_line)); 
norace volatile unsigned char _SFR99 __attribute__((delete_this_line)); /* reserved */
norace volatile unsigned char IEN2 __attribute__((delete_this_line)); /* Interrupt Enable 2 */
norace volatile unsigned char S1CON __attribute__((delete_this_line)); /* Interrupt Flags 3 */
norace volatile unsigned char T2CSPCFG __attribute__((delete_this_line)); /* Timer2 CSP Interface Configuration (legacy name) */
norace volatile unsigned char T2EVTCFG __attribute__((delete_this_line)); /* Timer2 Event Output Configuration */
norace volatile unsigned char SLEEPSTA __attribute__((delete_this_line)); /* Sleep Status */
norace volatile unsigned char CLKCONSTA __attribute__((delete_this_line)); /* Clock Control Status */
norace volatile unsigned char FMAP __attribute__((delete_this_line)); /* Flash Bank Map */

/* Port 2 */
norace volatile unsigned char P2 __attribute__((delete_this_line)); 
norace volatile unsigned char _P2_7 __attribute__((delete_this_line)); 
norace volatile unsigned char _P2_6 __attribute__((delete_this_line)); 
norace volatile unsigned char _P2_5 __attribute__((delete_this_line)); 
norace volatile unsigned char P2_4 __attribute__((delete_this_line)); 
norace volatile unsigned char P2_3 __attribute__((delete_this_line)); 
norace volatile unsigned char P2_2 __attribute__((delete_this_line)); 
norace volatile unsigned char P2_1 __attribute__((delete_this_line)); 
norace volatile unsigned char P2_0 __attribute__((delete_this_line)); 
norace volatile unsigned char T2IRQF __attribute__((delete_this_line)); /* Timer2 Interrupt Flags */
norace volatile unsigned char T2M0 __attribute__((delete_this_line)); /* Timer2 Multiplexed Register 0 */
norace volatile unsigned char T2M1 __attribute__((delete_this_line)); /* Timer2 Multiplexed Register 1 */
norace volatile unsigned char T2MOVF0 __attribute__((delete_this_line)); /* Timer2 Multiplexed Overflow Register 0 */
norace volatile unsigned char T2MOVF1 __attribute__((delete_this_line)); /* Timer2 Multiplexed Overflow Register 1 */
norace volatile unsigned char T2MOVF2 __attribute__((delete_this_line)); /* Timer2 Multiplexed Overflow Register 2 */
norace volatile unsigned char T2IRQM __attribute__((delete_this_line)); /* Timer2 Interrupt Mask */

/* Interrupt Enable 0 */
norace volatile unsigned char IEN0 __attribute__((delete_this_line)); 
norace volatile unsigned char EA __attribute__((delete_this_line)); 
norace volatile unsigned char _IEN06 __attribute__((delete_this_line)); 
norace volatile unsigned char STIE __attribute__((delete_this_line)); 
norace volatile unsigned char ENCIE __attribute__((delete_this_line)); 
norace volatile unsigned char URX1IE __attribute__((delete_this_line)); 
norace volatile unsigned char URX0IE __attribute__((delete_this_line)); 
norace volatile unsigned char ADCIE __attribute__((delete_this_line)); 
norace volatile unsigned char RFERRIE __attribute__((delete_this_line)); 
norace volatile unsigned char IP0 __attribute__((delete_this_line)); /* Interrupt Priority 0 */
norace volatile unsigned char _SFRAA __attribute__((delete_this_line)); /* not used */
norace volatile unsigned char P0IEN __attribute__((delete_this_line)); /* Port 0 Interrupt Mask */
norace volatile unsigned char P2IEN __attribute__((delete_this_line)); /* Port 2 Interrupt Mask */
norace volatile unsigned char STLOAD __attribute__((delete_this_line)); /* Sleep Timer Load Status */
norace volatile unsigned char PMUX __attribute__((delete_this_line)); /* Power Down Signal MUX */
norace volatile unsigned char T1STAT __attribute__((delete_this_line)); /* Timer 1 Status */
norace volatile unsigned char _SFRB0 __attribute__((delete_this_line)); /* not used */
norace volatile unsigned char ENCDI __attribute__((delete_this_line)); /* Encryption/Decryption Input Data */
norace volatile unsigned char ENCDO __attribute__((delete_this_line)); /* Encryption/Decryption Output Data */
norace volatile unsigned char ENCCS __attribute__((delete_this_line)); /* Encryption/Decryption Control and Status */
norace volatile unsigned char ADCCON1 __attribute__((delete_this_line)); /* ADC Control 1 */
norace volatile unsigned char ADCCON2 __attribute__((delete_this_line)); /* ADC Control 2 */
norace volatile unsigned char ADCCON3 __attribute__((delete_this_line)); /* ADC Control 3 */
norace volatile unsigned char _SFRB7 __attribute__((delete_this_line)); /* reserved */

/* Interrupt Enable 1 */
norace volatile unsigned char IEN1 __attribute__((delete_this_line)); 
norace volatile unsigned char _IEN17 __attribute__((delete_this_line)); 
norace volatile unsigned char _IEN16 __attribute__((delete_this_line)); 
norace volatile unsigned char P0IE __attribute__((delete_this_line)); 
norace volatile unsigned char T4IE __attribute__((delete_this_line)); 
norace volatile unsigned char T3IE __attribute__((delete_this_line)); 
norace volatile unsigned char T2IE __attribute__((delete_this_line)); 
norace volatile unsigned char T1IE __attribute__((delete_this_line)); 
norace volatile unsigned char DMAIE __attribute__((delete_this_line)); 
norace volatile unsigned char IP1 __attribute__((delete_this_line)); /* Interrupt Priority 1 */
norace volatile unsigned char ADCL __attribute__((delete_this_line)); /* ADC Data Low */
norace volatile unsigned char ADCH __attribute__((delete_this_line)); /* ADC Data High */
norace volatile unsigned char RNDL __attribute__((delete_this_line)); /* Random Number Generator Low Byte */
norace volatile unsigned char RNDH __attribute__((delete_this_line)); /* Random Number Generator High Byte */
norace volatile unsigned char SLEEPCMD __attribute__((delete_this_line)); /* Sleep Mode Control Command */
norace volatile unsigned char RFERRF __attribute__((delete_this_line)); /* RF Error Interrupt Flags */

/* Interrupt Flags 4 */
norace volatile unsigned char IRCON __attribute__((delete_this_line)); 
norace volatile unsigned char STIF __attribute__((delete_this_line)); 
norace volatile unsigned char _IRCON6 __attribute__((delete_this_line)); 
norace volatile unsigned char P0IF __attribute__((delete_this_line)); 
norace volatile unsigned char T4IF __attribute__((delete_this_line)); 
norace volatile unsigned char T3IF __attribute__((delete_this_line)); 
norace volatile unsigned char T2IF __attribute__((delete_this_line)); 
norace volatile unsigned char T1IF __attribute__((delete_this_line)); 
norace volatile unsigned char DMAIF __attribute__((delete_this_line)); 
norace volatile unsigned char U0DBUF __attribute__((delete_this_line)); /* USART 0 Receive/Transmit Data Buffer */
norace volatile unsigned char U0BAUD __attribute__((delete_this_line)); /* USART 0 Baud Rate Control */
norace volatile unsigned char T2MSEL __attribute__((delete_this_line)); /* Timer2 Multiplex Select */
norace volatile unsigned char U0UCR __attribute__((delete_this_line)); /* USART 0 UART Control */
norace volatile unsigned char U0GCR __attribute__((delete_this_line)); /* USART 0 Generic Control */
norace volatile unsigned char CLKCONCMD __attribute__((delete_this_line)); /* Clock Control Command */
norace volatile unsigned char MEMCTR __attribute__((delete_this_line)); /* Memory System Control */
norace volatile unsigned char _SFRC8 __attribute__((delete_this_line)); /* not used */
norace volatile unsigned char WDCTL __attribute__((delete_this_line)); /* Watchdog Timer Control */
norace volatile unsigned char T3CNT __attribute__((delete_this_line)); /* Timer 3 Counter */
norace volatile unsigned char T3CTL __attribute__((delete_this_line)); /* Timer 3 Control */
norace volatile unsigned char T3CCTL0 __attribute__((delete_this_line)); /* Timer 3 Channel 0 Capture/Compare Control */
norace volatile unsigned char T3CC0 __attribute__((delete_this_line)); /* Timer 3 Channel 0 Capture/Compare Value */
norace volatile unsigned char T3CCTL1 __attribute__((delete_this_line)); /* Timer 3 Channel 1 Capture/Compare Control */
norace volatile unsigned char T3CC1 __attribute__((delete_this_line)); /* Timer 3 Channel 1 Capture/Compare Value */
norace volatile unsigned char PSW __attribute__((delete_this_line)); 
norace volatile unsigned char CY __attribute__((delete_this_line)); 
norace volatile unsigned char AC __attribute__((delete_this_line)); 
norace volatile unsigned char F0 __attribute__((delete_this_line)); 
norace volatile unsigned char RS1 __attribute__((delete_this_line)); 
norace volatile unsigned char RS0 __attribute__((delete_this_line)); 
norace volatile unsigned char OV __attribute__((delete_this_line)); 
norace volatile unsigned char F1 __attribute__((delete_this_line)); 
norace volatile unsigned char P __attribute__((delete_this_line)); 
norace volatile unsigned char DMAIRQ __attribute__((delete_this_line)); /* DMA Interrupt Flag */
norace volatile unsigned char DMA1CFGL __attribute__((delete_this_line)); /* DMA Channel 1-4 Configuration Address Low Byte */
norace volatile unsigned char DMA1CFGH __attribute__((delete_this_line)); /* DMA Channel 1-4 Configuration Address High Byte */
norace volatile unsigned char DMA0CFGL __attribute__((delete_this_line)); /* DMA Channel 0 Configuration Address Low Byte */
norace volatile unsigned char DMA0CFGH __attribute__((delete_this_line)); /* DMA Channel 0 Configuration Address High Byte */
norace volatile unsigned char DMAARM __attribute__((delete_this_line)); /* DMA Channel Arm */
norace volatile unsigned char DMAREQ __attribute__((delete_this_line)); /* DMA Channel Start Request and Status */

/* Timers 1/3/4 Interrupt Mask/Flag */
norace volatile unsigned char TIMIF __attribute__((delete_this_line)); 
norace volatile unsigned char _TIMIF7 __attribute__((delete_this_line)); 
norace volatile unsigned char T1OVFIM __attribute__((delete_this_line)); 
norace volatile unsigned char T4CH1IF __attribute__((delete_this_line)); 
norace volatile unsigned char T4CH0IF __attribute__((delete_this_line)); 
norace volatile unsigned char T4OVFIF __attribute__((delete_this_line)); 
norace volatile unsigned char T3CH1IF __attribute__((delete_this_line)); 
norace volatile unsigned char T3CH0IF __attribute__((delete_this_line)); 
norace volatile unsigned char T3OVFIF __attribute__((delete_this_line)); 
norace volatile unsigned char RFD __attribute__((delete_this_line)); /* RF Data */
norace volatile unsigned char T1CC0L __attribute__((delete_this_line)); /* Timer 1 Channel 0 Capture/Compare Value Low Byte */
norace volatile unsigned char T1CC0H __attribute__((delete_this_line)); /* Timer 1 Channel 0 Capture/Compare Value High Byte */
norace volatile unsigned char T1CC1L __attribute__((delete_this_line)); /* Timer 1 Channel 1 Capture/Compare Value Low Byte */
norace volatile unsigned char T1CC1H __attribute__((delete_this_line)); /* Timer 1 Channel 1 Capture/Compare Value High Byte */
norace volatile unsigned char T1CC2L __attribute__((delete_this_line)); /* Timer 1 Channel 2 Capture/Compare Value Low Byte */
norace volatile unsigned char T1CC2H __attribute__((delete_this_line)); /* Timer 1 Channel 2 Capture/Compare Value High Byte */
norace volatile unsigned char ACC __attribute__((delete_this_line)); /* Accumulator */
norace volatile unsigned char RFST __attribute__((delete_this_line)); /* RF Command Strobe */
norace volatile unsigned char T1CNTL __attribute__((delete_this_line)); /* Timer 1 Counter Low */
norace volatile unsigned char T1CNTH __attribute__((delete_this_line)); /* Timer 1 Counter High */
norace volatile unsigned char T1CTL __attribute__((delete_this_line)); /* Timer 1 Control And Status */
norace volatile unsigned char T1CCTL0 __attribute__((delete_this_line)); /* Timer 1 Channel 0 Capture/Compare Control */
norace volatile unsigned char T1CCTL1 __attribute__((delete_this_line)); /* Timer 1 Channel 1 Capture/Compare Control */
norace volatile unsigned char T1CCTL2 __attribute__((delete_this_line)); /* Timer 1 Channel 2 Capture/Compare Control */

/* Interrupt Flags 5 */
norace volatile unsigned char IRCON2 __attribute__((delete_this_line)); 
norace volatile unsigned char _IRCON27 __attribute__((delete_this_line)); 
norace volatile unsigned char _IRCON26 __attribute__((delete_this_line)); 
norace volatile unsigned char _IRCON25 __attribute__((delete_this_line)); 
norace volatile unsigned char WDTIF __attribute__((delete_this_line)); 
norace volatile unsigned char P1IF __attribute__((delete_this_line)); 
norace volatile unsigned char UTX1IF __attribute__((delete_this_line)); 
norace volatile unsigned char UTX0IF __attribute__((delete_this_line)); 
norace volatile unsigned char P2IF __attribute__((delete_this_line)); 
norace volatile unsigned char RFIRQF0 __attribute__((delete_this_line)); /* RF Interrupt Flags LSB */
norace volatile unsigned char T4CNT __attribute__((delete_this_line)); /* Timer 4 Counter */
norace volatile unsigned char T4CTL __attribute__((delete_this_line)); /* Timer 4 Control */
norace volatile unsigned char T4CCTL0 __attribute__((delete_this_line)); /* Timer 4 Channel 0 Capture/Compare Control */
norace volatile unsigned char T4CC0 __attribute__((delete_this_line)); /* Timer 4 Channel 0 Capture/Compare Value */
norace volatile unsigned char T4CCTL1 __attribute__((delete_this_line)); /* Timer 4 Channel 1 Capture/Compare Control */
norace volatile unsigned char T4CC1 __attribute__((delete_this_line)); /* Timer 4 Channel 1 Capture/Compare Value */
norace volatile unsigned char B __attribute__((delete_this_line)); /* B Register */
norace volatile unsigned char PERCFG __attribute__((delete_this_line)); /* Peripheral I/O Control */
norace volatile unsigned char ADCCFG __attribute__((delete_this_line)); /* ADC Input Configuration (legacy name) */
norace volatile unsigned char APCFG __attribute__((delete_this_line)); /* Analog Periferal I/O Configuration */
norace volatile unsigned char P0SEL __attribute__((delete_this_line)); /* Port 0 Function Select */
norace volatile unsigned char P1SEL __attribute__((delete_this_line)); /* Port 1 Function Select */
norace volatile unsigned char P2SEL __attribute__((delete_this_line)); /* Port 2 Function Select */
norace volatile unsigned char P1INP __attribute__((delete_this_line)); /* Port 1 Input Mode */
norace volatile unsigned char P2INP __attribute__((delete_this_line)); /* Port 2 Input Mode */

/* USART 1 Control and Status */
norace volatile unsigned char U1CSR __attribute__((delete_this_line)); 
norace volatile unsigned char U1MODE __attribute__((delete_this_line)); 
norace volatile unsigned char U1RE __attribute__((delete_this_line)); 
norace volatile unsigned char U1SLAVE __attribute__((delete_this_line)); 
norace volatile unsigned char U1FE __attribute__((delete_this_line)); 
norace volatile unsigned char U1ERR __attribute__((delete_this_line)); 
norace volatile unsigned char U1RX_BYTE __attribute__((delete_this_line)); 
norace volatile unsigned char U1TX_BYTE __attribute__((delete_this_line)); 
norace volatile unsigned char U1ACTIVE __attribute__((delete_this_line)); 
norace volatile unsigned char U1DBUF __attribute__((delete_this_line)); /* USART 1 Receive/Transmit Data Buffer */
norace volatile unsigned char U1BAUD __attribute__((delete_this_line)); /* USART 1 Baud Rate Control */
norace volatile unsigned char U1UCR __attribute__((delete_this_line)); /* USART 1 UART Control */
norace volatile unsigned char U1GCR __attribute__((delete_this_line)); /* USART 1 Generic Control */
norace volatile unsigned char P0DIR __attribute__((delete_this_line)); /* Port 0 Direction */
norace volatile unsigned char P1DIR __attribute__((delete_this_line)); /* Port 1 Direction */
norace volatile unsigned char P2DIR __attribute__((delete_this_line)); /* Port 2 Direction */

norace volatile unsigned char SRCRESMASK0  __attribute__((delete_this_line));
norace volatile unsigned char SRCRESMASK1  __attribute__((delete_this_line));
norace volatile unsigned char SRCRESMASK2  __attribute__((delete_this_line));
norace volatile unsigned char SRCRESINDEX  __attribute__((delete_this_line));
norace volatile unsigned char SRCEXTPENDEN0  __attribute__((delete_this_line));
norace volatile unsigned char SRCEXTPENDEN1  __attribute__((delete_this_line));
norace volatile unsigned char SRCEXTPENDEN2  __attribute__((delete_this_line));
norace volatile unsigned char SRCSHORTPENDEN0  __attribute__((delete_this_line));
norace volatile unsigned char SRCSHORTPENDEN1  __attribute__((delete_this_line));
norace volatile unsigned char SRCSHORTPENDEN2  __attribute__((delete_this_line));
norace volatile unsigned char EXT_ADDR0  __attribute__((delete_this_line));
norace volatile unsigned char EXT_ADDR1  __attribute__((delete_this_line));
norace volatile unsigned char EXT_ADDR2  __attribute__((delete_this_line));
norace volatile unsigned char EXT_ADDR3  __attribute__((delete_this_line));
norace volatile unsigned char EXT_ADDR4  __attribute__((delete_this_line));
norace volatile unsigned char EXT_ADDR5  __attribute__((delete_this_line));
norace volatile unsigned char EXT_ADDR6  __attribute__((delete_this_line));
norace volatile unsigned char EXT_ADDR7  __attribute__((delete_this_line));
norace volatile unsigned char PAN_ID0  __attribute__((delete_this_line));
norace volatile unsigned char PAN_ID1  __attribute__((delete_this_line));
norace volatile unsigned char SHORT_ADDR0  __attribute__((delete_this_line));
norace volatile unsigned char SHORT_ADDR1  __attribute__((delete_this_line));
norace volatile unsigned char FRMFILT0  __attribute__((delete_this_line));
norace volatile unsigned char FRMFILT1  __attribute__((delete_this_line));
norace volatile unsigned char SRCMATCH  __attribute__((delete_this_line));
norace volatile unsigned char SRCSHORTEN0  __attribute__((delete_this_line));
norace volatile unsigned char SRCSHORTEN1  __attribute__((delete_this_line));
norace volatile unsigned char SRCSHORTEN2  __attribute__((delete_this_line));
norace volatile unsigned char SRCEXTEN0  __attribute__((delete_this_line));
norace volatile unsigned char SRCEXTEN1  __attribute__((delete_this_line));
norace volatile unsigned char SRCEXTEN2  __attribute__((delete_this_line));
norace volatile unsigned char FRMCTRL0  __attribute__((delete_this_line));
norace volatile unsigned char FRMCTRL1  __attribute__((delete_this_line));
norace volatile unsigned char RXENABLE  __attribute__((delete_this_line));
norace volatile unsigned char RXMASKSET  __attribute__((delete_this_line));
norace volatile unsigned char RXMASKCLR  __attribute__((delete_this_line));
norace volatile unsigned char FREQTUNE  __attribute__((delete_this_line));
norace volatile unsigned char FREQCTRL  __attribute__((delete_this_line));
norace volatile unsigned char TXPOWER  __attribute__((delete_this_line));
norace volatile unsigned char TXCTRL  __attribute__((delete_this_line));
norace volatile unsigned char FSMSTAT0  __attribute__((delete_this_line));
norace volatile unsigned char FSMSTAT1  __attribute__((delete_this_line));
norace volatile unsigned char FIFOPCTRL  __attribute__((delete_this_line));
norace volatile unsigned char FSMCTRL  __attribute__((delete_this_line));
norace volatile unsigned char CCACTRL0  __attribute__((delete_this_line));
norace volatile unsigned char CCACTRL1  __attribute__((delete_this_line));
norace volatile unsigned char RSSI  __attribute__((delete_this_line));
norace volatile unsigned char RSSISTAT  __attribute__((delete_this_line));
norace volatile unsigned char RXFIRST  __attribute__((delete_this_line));
norace volatile unsigned char RXFIFOCNT  __attribute__((delete_this_line));
norace volatile unsigned char TXFIFOCNT  __attribute__((delete_this_line));
norace volatile unsigned char RXFIRST_PTR  __attribute__((delete_this_line));
norace volatile unsigned char RXLAST_PTR  __attribute__((delete_this_line));
norace volatile unsigned char RXP1_PTR  __attribute__((delete_this_line));
norace volatile unsigned char _XREG61A0  __attribute__((delete_this_line));
norace volatile unsigned char TXFIRST_PTR  __attribute__((delete_this_line));
norace volatile unsigned char TXLAST_PTR  __attribute__((delete_this_line));
norace volatile unsigned char RFIRQM0  __attribute__((delete_this_line));
norace volatile unsigned char RFIRQM1  __attribute__((delete_this_line));
norace volatile unsigned char RFERRM  __attribute__((delete_this_line));
norace volatile unsigned char RFRND  __attribute__((delete_this_line));
norace volatile unsigned char MDMCTRL0  __attribute__((delete_this_line));
norace volatile unsigned char MDMCTRL1  __attribute__((delete_this_line));
norace volatile unsigned char FREQEST  __attribute__((delete_this_line));
norace volatile unsigned char RXCTRL  __attribute__((delete_this_line));
norace volatile unsigned char FSCTRL  __attribute__((delete_this_line));
norace volatile unsigned char FSCAL0  __attribute__((delete_this_line));
norace volatile unsigned char FSCAL1  __attribute__((delete_this_line));
norace volatile unsigned char FSCAL2  __attribute__((delete_this_line));
norace volatile unsigned char FSCAL3  __attribute__((delete_this_line));
norace volatile unsigned char AGCCTRL0  __attribute__((delete_this_line));
norace volatile unsigned char AGCCTRL1  __attribute__((delete_this_line));
norace volatile unsigned char AGCCTRL2  __attribute__((delete_this_line));
norace volatile unsigned char AGCCTRL3  __attribute__((delete_this_line));
norace volatile unsigned char ADCTEST0  __attribute__((delete_this_line));
norace volatile unsigned char ADCTEST1  __attribute__((delete_this_line));
norace volatile unsigned char ADCTEST2  __attribute__((delete_this_line));
norace volatile unsigned char MDMTEST0  __attribute__((delete_this_line));
norace volatile unsigned char MDMTEST1  __attribute__((delete_this_line));
norace volatile unsigned char DACTEST0  __attribute__((delete_this_line));
norace volatile unsigned char DACTEST1  __attribute__((delete_this_line));
norace volatile unsigned char DACTEST2  __attribute__((delete_this_line));
norace volatile unsigned char ATEST  __attribute__((delete_this_line));
norace volatile unsigned char PTEST0  __attribute__((delete_this_line));
norace volatile unsigned char PTEST1  __attribute__((delete_this_line));
norace volatile unsigned char TXFILTCFG  __attribute__((delete_this_line));
norace volatile unsigned char CSPPROG0  __attribute__((delete_this_line));
norace volatile unsigned char CSPPROG1  __attribute__((delete_this_line));
norace volatile unsigned char CSPPROG2  __attribute__((delete_this_line));
norace volatile unsigned char CSPPROG3  __attribute__((delete_this_line));
norace volatile unsigned char CSPPROG4  __attribute__((delete_this_line));
norace volatile unsigned char CSPPROG5  __attribute__((delete_this_line));
norace volatile unsigned char CSPPROG6  __attribute__((delete_this_line));
norace volatile unsigned char CSPPROG7  __attribute__((delete_this_line));
norace volatile unsigned char CSPPROG8  __attribute__((delete_this_line));
norace volatile unsigned char CSPPROG9  __attribute__((delete_this_line));
norace volatile unsigned char CSPPROG10  __attribute__((delete_this_line));
norace volatile unsigned char CSPPROG11  __attribute__((delete_this_line));
norace volatile unsigned char CSPPROG12  __attribute__((delete_this_line));
norace volatile unsigned char CSPPROG13  __attribute__((delete_this_line));
norace volatile unsigned char CSPPROG14  __attribute__((delete_this_line));
norace volatile unsigned char CSPPROG15  __attribute__((delete_this_line));
norace volatile unsigned char CSPPROG16  __attribute__((delete_this_line));
norace volatile unsigned char CSPPROG17  __attribute__((delete_this_line));
norace volatile unsigned char CSPPROG18  __attribute__((delete_this_line));
norace volatile unsigned char CSPPROG19  __attribute__((delete_this_line));
norace volatile unsigned char CSPPROG20  __attribute__((delete_this_line));
norace volatile unsigned char CSPPROG21  __attribute__((delete_this_line));
norace volatile unsigned char CSPPROG22  __attribute__((delete_this_line));
norace volatile unsigned char CSPPROG23  __attribute__((delete_this_line));
norace volatile unsigned char _XREG61D8  __attribute__((delete_this_line));
norace volatile unsigned char _XREG61D9  __attribute__((delete_this_line));
norace volatile unsigned char _XREG61DA  __attribute__((delete_this_line));
norace volatile unsigned char _XREG61DB  __attribute__((delete_this_line));
norace volatile unsigned char _XREG61DC  __attribute__((delete_this_line));
norace volatile unsigned char _XREG61DD  __attribute__((delete_this_line));
norace volatile unsigned char _XREG61DE  __attribute__((delete_this_line));
norace volatile unsigned char _XREG61DF  __attribute__((delete_this_line));
norace volatile unsigned char CSPCTRL  __attribute__((delete_this_line));
norace volatile unsigned char CSPSTAT  __attribute__((delete_this_line));
norace volatile unsigned char CSPX  __attribute__((delete_this_line));
norace volatile unsigned char CSPY  __attribute__((delete_this_line));
norace volatile unsigned char CSPZ  __attribute__((delete_this_line));
norace volatile unsigned char CSPT  __attribute__((delete_this_line));
norace volatile unsigned char _XREG61E6  __attribute__((delete_this_line));
norace volatile unsigned char _XREG61E7  __attribute__((delete_this_line));
norace volatile unsigned char _XREG61E8  __attribute__((delete_this_line));
norace volatile unsigned char _XREG61E9  __attribute__((delete_this_line));
norace volatile unsigned char _XREG61EA  __attribute__((delete_this_line));
norace volatile unsigned char RFC_OBS_CTRL0  __attribute__((delete_this_line));
norace volatile unsigned char RFC_OBS_CTRL1  __attribute__((delete_this_line));
norace volatile unsigned char RFC_OBS_CTRL2  __attribute__((delete_this_line));
norace volatile unsigned char OBSSEL0  __attribute__((delete_this_line));
norace volatile unsigned char OBSSEL1  __attribute__((delete_this_line));
norace volatile unsigned char OBSSEL2  __attribute__((delete_this_line));
norace volatile unsigned char OBSSEL3  __attribute__((delete_this_line));
norace volatile unsigned char OBSSEL4  __attribute__((delete_this_line));
norace volatile unsigned char OBSSEL5  __attribute__((delete_this_line));
norace volatile unsigned char TR0  __attribute__((delete_this_line));
norace volatile unsigned char CHVER  __attribute__((delete_this_line));
norace volatile unsigned char CHIPID  __attribute__((delete_this_line));
norace volatile unsigned char DBGDATA  __attribute__((delete_this_line));
norace volatile unsigned char FCTL  __attribute__((delete_this_line));
norace volatile unsigned char FADDRL  __attribute__((delete_this_line));
norace volatile unsigned char FADDRH  __attribute__((delete_this_line));
norace volatile unsigned char FWDATA  __attribute__((delete_this_line));
norace volatile unsigned char _XREG6274  __attribute__((delete_this_line));
norace volatile unsigned char _XREG6275  __attribute__((delete_this_line));
norace volatile unsigned char CHIPINFO0  __attribute__((delete_this_line));
norace volatile unsigned char CHIPINFO1  __attribute__((delete_this_line));
norace volatile unsigned char CLD  __attribute__((delete_this_line));
norace volatile unsigned char T1CCTL3  __attribute__((delete_this_line));
norace volatile unsigned char T1CCTL4  __attribute__((delete_this_line));
norace volatile unsigned char T1CC3L  __attribute__((delete_this_line));
norace volatile unsigned char T1CC3H  __attribute__((delete_this_line));
norace volatile unsigned char T1CC4L  __attribute__((delete_this_line));
norace volatile unsigned char T1CC4H  __attribute__((delete_this_line));
norace volatile unsigned char XX_T1CCTL0  __attribute__((delete_this_line));
norace volatile unsigned char XX_T1CCTL1  __attribute__((delete_this_line));
norace volatile unsigned char XX_T1CCTL2  __attribute__((delete_this_line));
norace volatile unsigned char XX_T1CCTL3  __attribute__((delete_this_line));
norace volatile unsigned char XX_T1CCTL4  __attribute__((delete_this_line));
norace volatile unsigned char XX_T1CC0L  __attribute__((delete_this_line));
norace volatile unsigned char XX_T1CC0H  __attribute__((delete_this_line));
norace volatile unsigned char XX_T1CC1L  __attribute__((delete_this_line));
norace volatile unsigned char XX_T1CC1H  __attribute__((delete_this_line));
norace volatile unsigned char XX_T1CC2L  __attribute__((delete_this_line));
norace volatile unsigned char XX_T1CC2H  __attribute__((delete_this_line));
norace volatile unsigned char XX_T1CC3L  __attribute__((delete_this_line));
norace volatile unsigned char XX_T1CC3H  __attribute__((delete_this_line));
norace volatile unsigned char XX_T1CC4L  __attribute__((delete_this_line));
norace volatile unsigned char XX_T1CC4H  __attribute__((delete_this_line));
norace volatile unsigned char STCC  __attribute__((delete_this_line));
norace volatile unsigned char STCS  __attribute__((delete_this_line));
norace volatile unsigned char STCV0  __attribute__((delete_this_line));
norace volatile unsigned char STCV1  __attribute__((delete_this_line));
norace volatile unsigned char STCV2  __attribute__((delete_this_line));
norace volatile unsigned char OPAMPC  __attribute__((delete_this_line));
norace volatile unsigned char OPAMPS  __attribute__((delete_this_line));
norace volatile unsigned char CMPCTL  __attribute__((delete_this_line));
norace volatile unsigned char _NA_SP  __attribute__((delete_this_line));
norace volatile unsigned char _NA_DPL0  __attribute__((delete_this_line));
norace volatile unsigned char _NA_DPH0  __attribute__((delete_this_line));
norace volatile unsigned char _NA_DPL1  __attribute__((delete_this_line));
norace volatile unsigned char _NA_DPH1  __attribute__((delete_this_line));
norace volatile unsigned char _NA_PCON  __attribute__((delete_this_line));
norace volatile unsigned char _NA_TCON  __attribute__((delete_this_line));
norace volatile unsigned char _NA_SFR8E  __attribute__((delete_this_line));
norace volatile unsigned char _NA_DPS  __attribute__((delete_this_line));
norace volatile unsigned char _NA_S0CON  __attribute__((delete_this_line));
norace volatile unsigned char _NA_SFR99  __attribute__((delete_this_line));
norace volatile unsigned char _NA_IEN2  __attribute__((delete_this_line));
norace volatile unsigned char _NA_S1CON  __attribute__((delete_this_line));
norace volatile unsigned char _NA_IEN0  __attribute__((delete_this_line));
norace volatile unsigned char _NA_IP0  __attribute__((delete_this_line));
norace volatile unsigned char _NA_SFRAA  __attribute__((delete_this_line));
norace volatile unsigned char _NA_SFRB0  __attribute__((delete_this_line));
norace volatile unsigned char _NA_SFRB7  __attribute__((delete_this_line));
norace volatile unsigned char _NA_IEN1  __attribute__((delete_this_line));
norace volatile unsigned char _NA_IP1  __attribute__((delete_this_line));
norace volatile unsigned char _NA_IRCON  __attribute__((delete_this_line));
norace volatile unsigned char _NA_SFRC8  __attribute__((delete_this_line));
norace volatile unsigned char _NA_PSW  __attribute__((delete_this_line));
norace volatile unsigned char _NA_ACC  __attribute__((delete_this_line));
norace volatile unsigned char _NA_IRCON2  __attribute__((delete_this_line));
norace volatile unsigned char _NA_B  __attribute__((delete_this_line));
#endif
