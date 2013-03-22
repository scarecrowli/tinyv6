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

/*
 * 
 * Emulate a 1kHz Timer to make TMilli Alarm/Counter happy,
 * while CC2530's Sleep Timer doesn't interrupt when counter overflow
 *
 * TODO: but somehow a big waste of energy.
 */
module HplCC2530SleepTimerP {
    provides interface Alarm<TMilli, uint16_t>;
    provides interface Counter<TMilli, uint16_t>;
    provides interface Init @atleastonce(); 
}
implementation {

#define ST_GET(now) { \
    now = ST0; \
    now |= (uint32_t)ST1 <<  8; \
    now |= (uint32_t)ST2 << 16; }

#define ST_SET(t) { \
    ST2 = (uint8_t)(t >> 16); \
    ST1 = (uint8_t)(t >> 8); \
    ST0 = (uint8_t) t; }

    enum {
        S_IDLE,
        S_ALARM_RUNNING,
    } state;

    uint16_t counter;
    uint16_t m_alarm;

    command error_t Init.init()
    {
        uint32_t now;

        state = S_IDLE;
        counter = 0;
        STIF = 0;

        /* set next interrupt after 32 ticks */
        ST_GET(now);
        now += 32;
        ST_SET(now);
        STIE = 1;

        return SUCCESS;
    }

    async command void Alarm.stop() {
        atomic {
            state = S_IDLE;
        }
    }
    async command bool Alarm.isRunning() {
        atomic {
            return (state == S_ALARM_RUNNING);
        }
    }
    async command uint16_t Alarm.getAlarm(){
        atomic return m_alarm;
    }

    async command uint16_t Alarm.getNow(){
        atomic return counter;
    }

    async command void Alarm.start(uint16_t dt){
        call Alarm.startAt(counter, dt);
    }

    async command void Alarm.startAt(uint16_t t0, uint16_t dt){
        uint16_t set, now, elapsed;

        atomic {
            now = counter;

            elapsed = now - t0; // This number wraps if counter has wrapped

            if( elapsed >= dt )  {
                set = now + 1; // fire immediately, elapse in 3 tics, 
            } else {
                int16_t remaining = dt - elapsed;
                if( remaining <= 1 )  {
                    set = now + 1; // elapse in 3 tics
                } else {
                    set = remaining + now;
                }
            }

            m_alarm = set;
            state = S_ALARM_RUNNING;
        }
        return;
    }

    async command uint16_t Counter.get() {
        atomic return counter;
    }

    async command bool Counter.isOverflowPending() {
        return FALSE;
    }
    async command void Counter.clearOverflow()     {
    }

    CC2530_INTERRUPT(ST_VECTOR)
    { 
        atomic{
            uint32_t now;
            STIF = 0;

            /* set next interrupt after 32 ticks, emulate a 1kHz timer */
            ST_GET(now);
            now += 32;
            ST_SET(now);

            counter++;
            if (counter == 0) {
                signal Counter.overflow();
            }
            if (state == S_ALARM_RUNNING) {
                if (counter == m_alarm) {
                    state = S_IDLE;
                    signal Alarm.fired();
                }
            }
        }
    }

    default async event void Counter.overflow() { }
    default async event void Alarm.fired() { }

}
