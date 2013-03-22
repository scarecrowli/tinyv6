#ifndef _STDIO_H
#define _STDIO_H

#include "stdarg.h"

#ifndef NULL
#define NULL    ((void *) 0)
#endif

#ifndef EOF
#define EOF     (-1)
#endif

int  puts(const char *);
int  putchar(int);
int  getchar(void);
int  sprintf(char *,const char *,...);
int  vsprintf(char *,const char *,va_list);
int  printf(const char *,...);
int  vprintf(const char *,va_list);
int  scanf(const char *,...);
int  sscanf(const char *, const char *,...);
char *gets(char *);

#endif
