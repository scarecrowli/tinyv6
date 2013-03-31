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


#include "cc2530.h"

module HplCC2530GeneralIOC
{
    provides {
        interface GeneralIO as Port00;
        interface GeneralIO as Port01;
        interface GeneralIO as Port02;
        interface GeneralIO as Port03;
        interface GeneralIO as Port04;
        interface GeneralIO as Port05;
        interface GeneralIO as Port06;
        interface GeneralIO as Port07;

        interface GeneralIO as Port10;
        interface GeneralIO as Port11;
        interface GeneralIO as Port12;
        interface GeneralIO as Port13;
        interface GeneralIO as Port14;
        interface GeneralIO as Port15;
        interface GeneralIO as Port16;
        interface GeneralIO as Port17;

        interface GeneralIO as Port20;
        interface GeneralIO as Port21;
        interface GeneralIO as Port22;
        interface GeneralIO as Port23;
        interface GeneralIO as Port24;
    }
}

implementation
{

    /* P0_0 */
    async command bool Port00.get()        { return P0_0; }
    async command void Port00.set()        { P0_0 = 1; }
    async command void Port00.clr()        { P0_0 = 0; }
    async command void Port00.toggle()     { P0_0 ^= 1; }

    async command void Port00.makeInput()   { P0SEL &= ~_BV(0); P0DIR &= ~_BV(0);  }
    async command bool Port00.isInput()     { return ~(P0DIR&_BV(0)); }
    async command void Port00.makeOutput()  { P0SEL &= ~_BV(0); P0DIR |= _BV(0);  }
    async command bool Port00.isOutput()    { return P0DIR&_BV(0); }

    /* P0_1 */
    async command bool Port01.get()        { return P0_1; }
    async command void Port01.set()        { P0_1 = 1; }
    async command void Port01.clr()        { P0_1 = 0; }
    async command void Port01.toggle()     { P0_1 ^= 1; }

    async command void Port01.makeInput()   { P0SEL &= ~_BV(1); P0DIR &= ~_BV(1);  }
    async command bool Port01.isInput()     { return ~(P0DIR&_BV(1)); }
    async command void Port01.makeOutput()  { P0SEL &= ~_BV(1); P0DIR |= _BV(1);  }
    async command bool Port01.isOutput()    { return P0DIR&_BV(1); }

    /* P0_2 */
    async command bool Port02.get()        { return P0_2; }
    async command void Port02.set()        { P0_2 = 1; }
    async command void Port02.clr()        { P0_2 = 0; }
    async command void Port02.toggle()     { P0_2 ^= 1; }

    async command void Port02.makeInput()   { P0SEL &= ~_BV(2); P0DIR &= ~_BV(2);  }
    async command bool Port02.isInput()     { return ~(P0DIR&_BV(2)); }
    async command void Port02.makeOutput()  { P0SEL &= ~_BV(2); P0DIR |= _BV(2);  }
    async command bool Port02.isOutput()    { return P0DIR&_BV(2); }

    /* P0_3 */
    async command bool Port03.get()        { return P0_3; }
    async command void Port03.set()        { P0_3 = 1; }
    async command void Port03.clr()        { P0_3 = 0; }
    async command void Port03.toggle()     { P0_3 ^= 1; }

    async command void Port03.makeInput()   { P0SEL &= ~_BV(3); P0DIR &= ~_BV(3);  }
    async command bool Port03.isInput()     { return ~(P0DIR&_BV(3)); }
    async command void Port03.makeOutput()  { P0SEL &= ~_BV(3); P0DIR |= _BV(3);  }
    async command bool Port03.isOutput()    { return P0DIR&_BV(3); }

    /* P0_4 */
    async command bool Port04.get()        { return P0_4; }
    async command void Port04.set()        { P0_4 = 1; }
    async command void Port04.clr()        { P0_4 = 0; }
    async command void Port04.toggle()     { P0_4 ^= 1; }

    async command void Port04.makeInput()   { P0SEL &= ~_BV(4); P0DIR &= ~_BV(4);  }
    async command bool Port04.isInput()     { return ~(P0DIR&_BV(4)); }
    async command void Port04.makeOutput()  { P0SEL &= ~_BV(4); P0DIR |= _BV(4);  }
    async command bool Port04.isOutput()    { return P0DIR&_BV(4); }

    /* P0_5 */
    async command bool Port05.get()        { return P0_5; }
    async command void Port05.set()        { P0_5 = 1; }
    async command void Port05.clr()        { P0_5 = 0; }
    async command void Port05.toggle()     { P0_5 ^= 1; }

    async command void Port05.makeInput()   { P0SEL &= ~_BV(5); P0DIR &= ~_BV(5);  }
    async command bool Port05.isInput()     { return ~(P0DIR&_BV(5)); }
    async command void Port05.makeOutput()  { P0SEL &= ~_BV(5); P0DIR |= _BV(5);  }
    async command bool Port05.isOutput()    { return P0DIR&_BV(5); }

    /* P0_6 */
    async command bool Port06.get()        { return P0_6; }
    async command void Port06.set()        { P0_6 = 1; }
    async command void Port06.clr()        { P0_6 = 0; }
    async command void Port06.toggle()     { P0_6 ^= 1; }

    async command void Port06.makeInput()   { P0SEL &= ~_BV(6); P0DIR &= ~_BV(6);  }
    async command bool Port06.isInput()     { return ~(P0DIR&_BV(6)); }
    async command void Port06.makeOutput()  { P0SEL &= ~_BV(6); P0DIR |= _BV(6);  }
    async command bool Port06.isOutput()    { return P0DIR&_BV(6); }

    /* P0_7 */
    async command bool Port07.get()        { return P0_7; }
    async command void Port07.set()        { P0_7 = 1; }
    async command void Port07.clr()        { P0_7 = 0; }
    async command void Port07.toggle()     { P0_7 ^= 1; }

    async command void Port07.makeInput()   { P0SEL &= ~_BV(7); P0DIR &= ~_BV(7);  }
    async command bool Port07.isInput()     { return ~(P0DIR&_BV(7)); }
    async command void Port07.makeOutput()  { P0SEL &= ~_BV(7); P0DIR |= _BV(7);  }
    async command bool Port07.isOutput()    { return P0DIR&_BV(7); }


    /* P1_0 */
    async command bool Port10.get()        { return P1_0; }
    async command void Port10.set()        { P1_0 = 1; }
    async command void Port10.clr()        { P1_0 = 0; }
    async command void Port10.toggle()     { P1_0 ^= 1; }

    async command void Port10.makeInput()   { P1SEL &= ~_BV(0); P1DIR &= ~_BV(0);  }
    async command bool Port10.isInput()     { return ~(P1DIR&_BV(0)); }
    async command void Port10.makeOutput()  { P1SEL &= ~_BV(0); P1DIR |= _BV(0);  }
    async command bool Port10.isOutput()    { return P1DIR&_BV(0); }

    /* P1_1 */
    async command bool Port11.get()        { return P1_1; }
    async command void Port11.set()        { P1_1 = 1; }
    async command void Port11.clr()        { P1_1 = 0; }
    async command void Port11.toggle()     { P1_1 ^= 1; }

    async command void Port11.makeInput()   { P1SEL &= ~_BV(1); P1DIR &= ~_BV(1);  }
    async command bool Port11.isInput()     { return ~(P1DIR&_BV(1)); }
    async command void Port11.makeOutput()  { P1SEL &= ~_BV(1); P1DIR |= _BV(1);  }
    async command bool Port11.isOutput()    { return P1DIR&_BV(1); }

    /* P1_2 */
    async command bool Port12.get()        { return P1_2; }
    async command void Port12.set()        { P1_2 = 1; }
    async command void Port12.clr()        { P1_2 = 0; }
    async command void Port12.toggle()     { P1_2 ^= 1; }

    async command void Port12.makeInput()   { P1SEL &= ~_BV(2); P1DIR &= ~_BV(2);  }
    async command bool Port12.isInput()     { return ~(P1DIR&_BV(2)); }
    async command void Port12.makeOutput()  { P1SEL &= ~_BV(2); P1DIR |= _BV(2);  }
    async command bool Port12.isOutput()    { return P1DIR&_BV(2); }

    /* P1_3 */
    async command bool Port13.get()        { return P1_3; }
    async command void Port13.set()        { P1_3 = 1; }
    async command void Port13.clr()        { P1_3 = 0; }
    async command void Port13.toggle()     { P1_3 ^= 1; }

    async command void Port13.makeInput()   { P1SEL &= ~_BV(3); P1DIR &= ~_BV(3);  }
    async command bool Port13.isInput()     { return ~(P1DIR&_BV(3)); }
    async command void Port13.makeOutput()  { P1SEL &= ~_BV(3); P1DIR |= _BV(3);  }
    async command bool Port13.isOutput()    { return P1DIR&_BV(3); }

    /* P1_4 */
    async command bool Port14.get()        { return P1_4; }
    async command void Port14.set()        { P1_4 = 1; }
    async command void Port14.clr()        { P1_4 = 0; }
    async command void Port14.toggle()     { P1_4 ^= 1; }

    async command void Port14.makeInput()   { P1SEL &= ~_BV(4); P1DIR &= ~_BV(4);  }
    async command bool Port14.isInput()     { return ~(P1DIR&_BV(4)); }
    async command void Port14.makeOutput()  { P1SEL &= ~_BV(4); P1DIR |= _BV(4);  }
    async command bool Port14.isOutput()    { return P1DIR&_BV(4); }

    /* P1_5 */
    async command bool Port15.get()        { return P1_5; }
    async command void Port15.set()        { P1_5 = 1; }
    async command void Port15.clr()        { P1_5 = 0; }
    async command void Port15.toggle()     { P1_5 ^= 1; }

    async command void Port15.makeInput()   { P1SEL &= ~_BV(5); P1DIR &= ~_BV(5);  }
    async command bool Port15.isInput()     { return ~(P1DIR&_BV(5)); }
    async command void Port15.makeOutput()  { P1SEL &= ~_BV(5); P1DIR |= _BV(5);  }
    async command bool Port15.isOutput()    { return P1DIR&_BV(5); }

    /* P1_6 */
    async command bool Port16.get()        { return P1_6; }
    async command void Port16.set()        { P1_6 = 1; }
    async command void Port16.clr()        { P1_6 = 0; }
    async command void Port16.toggle()     { P1_6 ^= 1; }

    async command void Port16.makeInput()   { P1SEL &= ~_BV(6); P1DIR &= ~_BV(6);  }
    async command bool Port16.isInput()     { return ~(P1DIR&_BV(6)); }
    async command void Port16.makeOutput()  { P1SEL &= ~_BV(6); P1DIR |= _BV(6);  }
    async command bool Port16.isOutput()    { return P1DIR&_BV(6); }

    /* P1_7 */
    async command bool Port17.get()        { return P1_7; }
    async command void Port17.set()        { P1_7 = 1; }
    async command void Port17.clr()        { P1_7 = 0; }
    async command void Port17.toggle()     { P1_7 ^= 1; }

    async command void Port17.makeInput()   { P1SEL &= ~_BV(7); P1DIR &= ~_BV(7);  }
    async command bool Port17.isInput()     { return ~(P1DIR&_BV(7)); }
    async command void Port17.makeOutput()  { P1SEL &= ~_BV(7); P1DIR |= _BV(7);  }
    async command bool Port17.isOutput()    { return P1DIR&_BV(7); }


    /* P2_0 */
    async command bool Port20.get()        { return P2_0; }
    async command void Port20.set()        { P2_0 = 1; }
    async command void Port20.clr()        { P2_0 = 0; }
    async command void Port20.toggle()     { P2_0 ^= 1; }

    async command void Port20.makeInput()   { P2SEL &= ~_BV(0); P2DIR &= ~_BV(0);  }
    async command bool Port20.isInput()     { return ~(P2DIR&_BV(0)); }
    async command void Port20.makeOutput()  { P2SEL &= ~_BV(0); P2DIR |= _BV(0);  }
    async command bool Port20.isOutput()    { return P2DIR&_BV(0); }

    /* P2_1 */
    async command bool Port21.get()        { return P2_1; }
    async command void Port21.set()        { P2_1 = 1; }
    async command void Port21.clr()        { P2_1 = 0; }
    async command void Port21.toggle()     { P2_1 ^= 1; }

    async command void Port21.makeInput()   { P2SEL &= ~_BV(1); P2DIR &= ~_BV(1);  }
    async command bool Port21.isInput()     { return ~(P2DIR&_BV(1)); }
    async command void Port21.makeOutput()  { P2SEL &= ~_BV(1); P2DIR |= _BV(1);  }
    async command bool Port21.isOutput()    { return P2DIR&_BV(1); }

    /* P2_2 */
    async command bool Port22.get()        { return P2_2; }
    async command void Port22.set()        { P2_2 = 1; }
    async command void Port22.clr()        { P2_2 = 0; }
    async command void Port22.toggle()     { P2_2 ^= 1; }

    async command void Port22.makeInput()   { P2SEL &= ~_BV(2); P2DIR &= ~_BV(2);  }
    async command bool Port22.isInput()     { return ~(P2DIR&_BV(2)); }
    async command void Port22.makeOutput()  { P2SEL &= ~_BV(2); P2DIR |= _BV(2);  }
    async command bool Port22.isOutput()    { return P2DIR&_BV(2); }

    /* P2_3 */
    async command bool Port23.get()        { return P2_3; }
    async command void Port23.set()        { P2_3 = 1; }
    async command void Port23.clr()        { P2_3 = 0; }
    async command void Port23.toggle()     { P2_3 ^= 1; }

    async command void Port23.makeInput()   { P2SEL &= ~_BV(3); P2DIR &= ~_BV(3);  }
    async command bool Port23.isInput()     { return ~(P2DIR&_BV(3)); }
    async command void Port23.makeOutput()  { P2SEL &= ~_BV(3); P2DIR |= _BV(3);  }
    async command bool Port23.isOutput()    { return P2DIR&_BV(3); }

    /* P2_4 */
    async command bool Port24.get()        { return P2_4; }
    async command void Port24.set()        { P2_4 = 1; }
    async command void Port24.clr()        { P2_4 = 0; }
    async command void Port24.toggle()     { P2_4 ^= 1; }

    async command void Port24.makeInput()   { P2SEL &= ~_BV(4); P2DIR &= ~_BV(4);  }
    async command bool Port24.isInput()     { return ~(P2DIR&_BV(4)); }
    async command void Port24.makeOutput()  { P2SEL &= ~_BV(4); P2DIR |= _BV(4);  }
    async command bool Port24.isOutput()    { return P2DIR&_BV(4); }


}

/* Generated by python script. C macro is ugly */
// #!/usr/bin/python
// ports = [0, 1, 2]
// pins = [range(8), range(8), range(5)]
// 
// provides_interfaces = ""
// commands = ""
// for port in ports:
//     for pin in pins[port]:
//         provides_interfaces += "        interface GeneralIO as Port%d%d;\n" % (port, pin)
// 
//         commands += """
//         /* P#port#_#pin# */
//         async command bool Port#port##pin#.get()        { return P#port#_#pin#; }
//         async command void Port#port##pin#.set()        { P#port#_#pin# = 1; }
//         async command void Port#port##pin#.clr()        { P#port#_#pin# = 0; }
//         async command void Port#port##pin#.toggle()     { P#port#_#pin# ^= 1; }
// 
//         async command void Port#port##pin#.makeInput()   { P#port#SEL &= ~_BV(#pin#); P#port#DIR &= ~_BV(#pin#);  }
//         async command bool Port#port##pin#.isInput()     { return ~(P#port#DIR&_BV(#pin#)); }
//         async command void Port#port##pin#.makeOutput()  { P#port#SEL &= ~_BV(#pin#); P#port#DIR |= _BV(#pin#);  }
//         async command bool Port#port##pin#.isOutput()    { return P#port#DIR&_BV(#pin#); }
//         """.replace("#port#", str(port)).replace("#pin#", str(pin))
//     provides_interfaces += "\n"
//     commands += "\n"
// 
// print """
// #include "cc2530.h"
// 
// module HplCC2530GeneralIOC
// {
//     provides {
// %s
//     }
// }
// 
// implementation
// {
// %s
// }
// """ % (provides_interfaces, commands)
