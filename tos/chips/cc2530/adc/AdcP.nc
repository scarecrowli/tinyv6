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

module AdcP {
    provides {
        interface Read<uint16_t> as Read[uint8_t client];
    }
    uses {
        interface Resource as ResourceRead[uint8_t client];
        interface AdcConfigure<cc2530adc_config_t*> as Config[uint8_t client];
        interface CC2530AdcSingleChannel as SingleChannel[uint8_t client];
    }
}
implementation
{
    enum {
        STATE_READ,
        STATE_READNOW,
        STATE_READNOW_INVALID_CONFIG,
    };

    norace uint8_t state;
    norace uint8_t owner;
    norace uint16_t value;

    error_t configure(uint8_t client)
    {
        error_t result = EINVAL;
        cc2530adc_config_t * config;
        config = call Config.getConfiguration[client]();
        result = call SingleChannel.configureSingle[client](config);
        return result;
    }

    command error_t Read.read[uint8_t client]()
    {
        return call ResourceRead.request[client]();
    }

    event void ResourceRead.granted[uint8_t client]() 
    {
        // signalled only for Read.read()
        error_t result = configure(client);
        if (result == SUCCESS){
            state = STATE_READ;
            result = call SingleChannel.getData[client]();
        } else {
            call ResourceRead.release[client]();
            signal Read.readDone[client](result, 0);
        }
    }

    void task readDone()
    {
        call ResourceRead.release[owner]();
        signal Read.readDone[owner](SUCCESS, value);
    }

    async event error_t SingleChannel.singleDataReady[uint8_t client](uint16_t data)
    {
        switch (state)
        {
            case STATE_READ:
                owner = client;
                value = data;
                post readDone();
                break;
            default:
                // error !
                break;
        }
        return SUCCESS;
    }


    default async command error_t ResourceRead.request[uint8_t client]() { return FAIL; }
    default async command error_t ResourceRead.immediateRequest[uint8_t client]() { return FAIL; }
    default async command error_t ResourceRead.release[uint8_t client]() { return FAIL; }
    default async command bool ResourceRead.isOwner[uint8_t client]() { return FALSE; }
    default event void Read.readDone[uint8_t client]( error_t result, uint16_t val ){}

    default async command error_t SingleChannel.getData[uint8_t client]()
    {
        return EINVAL;
    }

    cc2530adc_config_t defaultConfig = {0,0};
    default async command cc2530adc_config_t* Config.getConfiguration[uint8_t client]()
    { 
        return &defaultConfig;
    }  

    default async command error_t SingleChannel.configureSingle[uint8_t client](cc2530adc_config_t *config)
    {
        return FAIL; 
    }

} 
