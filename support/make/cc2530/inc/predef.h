#ifndef PREDEF_H
#define PREDEF_H

#ifdef __IAR_SYSTEMS_ICC__
  #include <ioCC2530.h>
  #pragma pack(1)
  #define __attribute__(...)
  #define __attribute(...)
#else
  #define __interrupt
#endif

#endif
