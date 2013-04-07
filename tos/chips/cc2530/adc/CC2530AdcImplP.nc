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
 * @date 2013/04/07
 * @description
 */

#include <cc2530adc.h>

module CC2530AdcImplP
{
    provides {
        interface Init;
        interface CC2530AdcSingleChannel as SingleChannel[uint8_t id];
    }
    uses {
        interface ArbiterInfo as ADCArbiterInfo;
        interface HplCC2530Adc;
    }
}
implementation
{ 

    norace uint8_t m_id;
    norace cc2530adc_config_t *m_config;
    norace uint16_t m_val;

    command error_t Init.init()
    {
        return SUCCESS;
    }

    async command error_t SingleChannel.configureSingle[uint8_t id](cc2530adc_config_t *config)
    {
        error_t result = ERESERVE;
        if (call ADCArbiterInfo.userId() == id) {
            m_config = config;
            call HplCC2530Adc.enableChannel(config->channel);
            call HplCC2530Adc.singleConversion(config->adccon3);
            result = SUCCESS;
        } 
        return result;
    }

    task void signalSingleDataReady()
    {
        call HplCC2530Adc.disableChannel(m_config->channel);
        signal SingleChannel.singleDataReady[m_id](m_val);
    }

    async command error_t SingleChannel.getData[uint8_t id]()
    {
        atomic {
            if (call ADCArbiterInfo.userId() == id){
                call HplCC2530Adc.sampleSingle();
                while(!call HplCC2530Adc.sampleReady());

                m_val = call HplCC2530Adc.data();
                m_id = id;
                post signalSingleDataReady();

                return SUCCESS;
            }
        }
        return FAIL;
    }

    default async event error_t SingleChannel.singleDataReady[uint8_t id](uint16_t data)
    {
        return FAIL;
    }
}

