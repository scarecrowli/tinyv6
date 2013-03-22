#ifndef _STDARG_H_
#define _STDARG_H_

typedef void *va_list[1];

void __va_start(va_list);

#define va_start(ap, parmN) __va_start(ap)
#define va_end(ap)            ((void) 0)

#define va_arg(ap,mode) \
  (sizeof(mode) < sizeof(int) ? (*(mode *)(*(int **)ap)++) : \
                       *(*(mode **) ap)++)

#endif
