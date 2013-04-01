#ifndef _INTTYPES_H
#define _INTTYPES_H

typedef signed   char   int8_t;
typedef unsigned char   uint8_t;
typedef signed   short  int16_t;
typedef unsigned short  uint16_t;

/* define int->int32 to make 64bit systems happy,
   but int in IAR only have 2 bytes, iar.py will treat this */
typedef signed   int int32_t __attribute__((delete_this_line));
typedef unsigned int uint32_t __attribute__((delete_this_line));

//typedef signed   long long int64_t;
//typedef unsigned long long uint64_t;

#endif
