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
 * lowpan.h
 *
 * @author Qiu Ying <qiuying@mail.nwpu.edu.cn>
 * @author Wu Wen <wuwen21999@126.com>
 * @date 2011/11/14
 * @description
 *    structures and constants for LOWPAN
 */
#ifndef _LOWPAN_H
#define _LOWPAN_H

/* HC1 Header structure*/
typedef nx_struct {
	nx_uint8_t sprefix : 1;
	nx_uint8_t siden : 1;
	nx_uint8_t dprefix : 1;
	nx_uint8_t diden : 1;
	nx_uint8_t tcfl : 1;
	nx_uint8_t nxthdr : 2;
	nx_uint8_t ifhc2 :1;
}hc1_t;

/*HC2 Header Structure*/
typedef nx_struct {
	nx_uint8_t sport : 1;
	nx_uint8_t dport : 1;
	nx_uint8_t length : 1;
	nx_uint8_t reserve : 5;

}hc_udp_t;

/*Constant for HC1*/
enum{
    NON_COMPRESSED_HEADER = 0,
	UDP_HEADER = 1,
	ICMP_HEADER = 2,
	TCP_HEADER = 3,
};


/* Lowpan first fragment with dispatch LOWPAN_DISPATCH_FRAG1 */
nx_struct lowpan_frag1_hdr {
	nx_union {
		nx_uint8_t  lowpan_frag_un_dispatch;
		nx_uint16_t lowpan_frag_un_datagram_size;
	} lowpan_frag_un;
	nx_uint16_t lowpan_frag_datagram_tag;
	nx_uint8_t lowpan_frag_data[0];
};

/* Lowpan subsequent fragment with LOWPAN_DISPATCH_FRAGN */
nx_struct lowpan_fragn_hdr {
	nx_union {
		nx_uint8_t  lowpan_frag_un_dispatch;
		nx_uint16_t lowpan_frag_un_datagram_size;
	} lowpan_frag_un;
	nx_uint16_t lowpan_frag_datagram_tag;
	nx_uint8_t lowpan_frag_datagram_offset;
	nx_uint8_t lowpan_frag_data[0];
};
#define lowpan_frag_dispatch		lowpan_frag_un.lowpan_frag_un_dispatch
#define lowpan_frag_datagram_size	lowpan_frag_un.lowpan_frag_un_datagram_size

enum {
	LOWPAN_DISPATCH_NALP = 0x00, /* 00xxxxxx, should mask with 0xc0 */
	LOWPAN_DISPATCH_IPV6 = 0x41,
	LOWPAN_DISPATCH_HC1 = 0x42,
	LOWPAN_DISPATCH_BC0 = 0x50,
	LOWPAN_DISPATCH_ESC = 0x7f,
	LOWPAN_DISPATCH_MESH = 0x80, /* 10xxxxxx, should mask with 0xc0 */
	LOWPAN_DISPATCH_IPHC = 0x60, /* 011xxxxx, should mask with 0xe0, RFC6282*/
	LOWPAN_DISPATCH_FRAG1 = 0xc0, /* 11000xxx. should mask with 0xf8 */
	LOWPAN_DISPATCH_FRAGN = 0xe0, /* 11100xxx, should mask with 0xf8 */
};
#endif /* _LOWPAN_H */
