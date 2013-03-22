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

#ifndef __CC2530RADIO_H__
#define __CC2530RADIO_H__

#include <RadioConfig.h>
#include <TinyosNetworkLayer.h>
#include <Ieee154PacketLayer.h>
#include <ActiveMessageLayer.h>
#include <MetadataFlagsLayer.h>
#include <CC2530DriverLayer.h>
#include <TimeStampingLayer.h>
#include <LowPowerListeningLayer.h>
#include <PacketLinkLayer.h>

typedef nx_struct cc2530packet_header_t
{
	cc2530_header_t cc2530;
	ieee154_simple_header_t ieee154;
#ifndef TFRAMES_ENABLED
	network_header_t network;
#endif
#ifndef IEEE154FRAMES_ENABLED
	activemessage_header_t am;
#endif
} cc2530packet_header_t;

typedef nx_struct cc2530packet_footer_t
{
	// the time stamp is not recorded here, time stamped messaged cannot have max length
    nx_uint8_t notUsed;
} cc2530packet_footer_t;

typedef struct cc2530packet_metadata_t
{
#ifdef LOW_POWER_LISTENING
	lpl_metadata_t lpl;
#endif
#ifdef PACKET_LINK
	link_metadata_t link;
#endif
	timestamp_metadata_t timestamp;
	flags_metadata_t flags;
	cc2530_metadata_t cc2530;
} cc2530packet_metadata_t;

#endif//__CC2530RADIO_H__
