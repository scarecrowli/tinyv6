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

#include "CC2430Timer.h"

module HplCC2530Timer1P {
    provides interface Counter<TMicro, uint16_t> as Counter;
    provides interface Alarm<TMicro, uint16_t> as Alarm;
    provides interface Init @exactlyonce();
    uses interface Leds;

} implementation {

#define T1_GET(now) { \
    now = T1CNTL; \
    now |= T1CNTH << 8; }

    /*
     * Argh.. Do we know if Timer1.init() has finished by this point?
     */
    command error_t Init.init() {

        atomic {
            T1CNTL = 0; T1CNTH = 0;
            //T1CTL  = ((T1CTL & ~CC2430_T1CTL_DIV_MASK) | CC2430_TIMER1_DIV_8);
            T1CTL  = ((T1CTL & ~CC2430_T1CTL_DIV_MASK) | CC2430_TIMER1_DIV_32);
            //T1CTL  = ((T1CTL & ~CC2430_T1CTL_DIV_MASK) | CC2430_TIMER1_DIV_128);
            //T1CTL  = ((T1CTL & ~CC2430_T1CTL_DIV_MASK) | CC2430_TIMER1_DIV_1);

            // Clear all interrupt flags
            //T1STAT &= ~CC2530_T1STAT_CH0IF & ~CC2530_T1STAT_OVFIF;

            // Compare register 0
            T1CCTL0 |= (1 << CC2430_T1CCTLx_MODE); // Mode = compare
            //T1CCTL0 |= (1 << CC2430_T1CCTLx_IM) | (1 << CC2430_T1CCTLx_MODE);

            // Start compare running
            T1IE   = 1;   // enable events
            TIMIF |= _BV(CC2430_TIMIF_OVFIM); // Enable overflow int
            T1CCTL0 |= 0x40; // Compare interrupt on
            T1CTL  = (T1CTL & ~CC2430_T1CTL_MODE_MASK) | CC2430_TIMER1_MODE_FREE;
            //T1CCTL0 &= ~0x40; // Compare int off
            //T1CTL |= 1; //CC2430_TIMER1_MODE_FREE
            //T1CTL &= ~2; //CC2430_TIMER1_MODE_FREE
        }

        return SUCCESS;
    }

    /*********************************************************************
     *                              Alarm 0                              *
     *********************************************************************/ 

    async command void Alarm.stop() {
        atomic {
            T1CCTL0 &= ~_BV(CC2430_T1CCTLx_IM);
        }
    }
    async command bool Alarm.isRunning() {
        bool ret;
        atomic {
            ret = T1CCTL0 & _BV(CC2430_T1CCTLx_IM);
        }
        return ret;
    }
    async command uint16_t Alarm.getAlarm(){
        uint16_t r;
        
        r = T1CC0L;
        r |= T1CC0H;

        return r; 
    }

    async command uint16_t Alarm.getNow(){
        uint16_t r;

        T1_GET(r);

        return r;
    }

    async command void Alarm.start(uint16_t dt){
        uint16_t now;

        T1_GET(now);

        call Alarm.startAt( now, dt );
    }

    async command void Alarm.startAt(uint16_t t0, uint16_t dt){
        uint16_t set, now, elapsed;

        atomic {
            T1_GET(now);

            elapsed = now - t0; // This number wraps if counter has wrapped

            if( elapsed >= dt )  {
                set = now + 5; // elapse in 5 tics
            } else {
                uint16_t remaining = dt - elapsed;
                if( remaining <= 5 )  {
                    set = now + 5; // elapse in 5 tics
                } else {
                    set = remaining + now;
                }
            }

            T1CC0L = (uint8_t) set;
            T1CC0H = (uint8_t) (set>>8);

            T1CCTL0 |= _BV(CC2430_T1CCTLx_IM);  // Enable interrupt mask
        }

        return;
    }


    /*********************************************************************
     *                              Counter                              *
     *********************************************************************/ 

    async command uint16_t Counter.get() {
        uint16_t r;

        T1_GET(r);

        return r;
    }
    async command bool Counter.isOverflowPending() {
        return( T1CTL & CC2430_T1_OVFIF );
    }
    async command void Counter.clearOverflow()     {
        T1CTL &= ~CC2430_T1_OVFIF;
    }

    /*********************************************************************
     *                              Interrupts                           *
     *********************************************************************/ 

    /*
     * The interrupt handler will be executed regardless of which
     * interrupt has been issued. Since the compare registers are likely
     * to fire with masks off - we need to check that this particular
     * interrupt is actually enabled.
     */

    CC2530_INTERRUPT(T1_VECTOR)
    { 
        //TIMIF &= ~(1<<6);
        atomic{
            if ( (T1CCTL0 & _BV(CC2430_T1CCTLx_IM)) && (T1STAT & CC2530_T1_CH0IF) ) {
                //T1STAT   &= ~_BV(CC2530_T1STAT_CH0IF);    // Clear IF
                T1CCTL0 &= ~_BV(CC2430_T1CCTLx_IM);     // Clear IM - startAt sets it
                signal Alarm.fired();
            }
            if (T1STAT & CC2530_T1STAT_OVFIF) {
                //T1STAT   &= ~_BV(CC2530_T1STAT_OVFIF);   // Clear IF
                signal Counter.overflow();
            }
        }
    }

    default async event void Counter.overflow() { }
    default async event void Alarm.fired() { }
}
