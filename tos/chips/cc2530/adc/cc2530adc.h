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

#ifndef CC2530ADC_H
#define CC2530ADC_H

// The unique string for allocating ADC resource interfaces
#define CC2530ADC_RESOURCE "CC2530AdcC.Resource"

// The unique string for accessing HAL2
#define ADCC_SERVICE "AdcC.Service"

// The unique string for accessing HAL2 via ReadStream
#define ADCC_READ_STREAM_SERVICE "AdcC.ReadStream.Client"

typedef struct { 
  uint8_t channel;            // input channel 
  uint8_t adccon3;            // input channel 
} cc2530adc_config_t;

/* Input channel */
enum {
    ADC_AIN0        =   0x00,    // single ended P0_0
    ADC_AIN1        =   0x01,    // single ended P0_1
    ADC_AIN2        =   0x02,    // single ended P0_2
    ADC_AIN3        =   0x03,    // single ended P0_3
    ADC_AIN4        =   0x04,    // single ended P0_4
    ADC_AIN5        =   0x05,    // single ended P0_5
    ADC_AIN6        =   0x06,    // single ended P0_6
    ADC_AIN7        =   0x07,    // single ended P0_7
    ADC_GND         =   0x0C,    // Ground
    ADC_TEMP_SENS   =   0x0E,    // on-chip temperature sensor
    ADC_VDD_3       =   0x0F,    // (vdd/3)

/* Reference voltage */
    ADC_REF_1_25_V    = 0x00,    // Internal 1.25V reference
    ADC_REF_P0_7      = 0x40,    // External reference on AIN7 pin
    ADC_REF_AVDD      = 0x80,    // AVDD_SOC pin
    ADC_REF_P0_6_P0_7 = 0xC0,    // External reference on AIN6-AIN7 differential input

/* Resolution (decimation rate) */
    ADC_8_BIT     =     0x00,    //  64 decimation rate
    ADC_10_BIT    =     0x10,    // 128 decimation rate
    ADC_12_BIT    =     0x20,    // 256 decimation rate
    ADC_14_BIT    =     0x30,    // 512 decimation rate
};

#endif
