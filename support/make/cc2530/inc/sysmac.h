#ifndef _SYSMAC_H_
#define _SYSMAC_H_

#ifndef __CHAR_SIZE__
#define __CHAR_SIZE__ sizeof(char)
#endif

#ifndef __SHORT_SIZE__
#define __SHORT_SIZE__ sizeof(short)
#endif

#ifndef __INT_SIZE__
#define __INT_SIZE__ sizeof(int)
#endif

#ifndef __LONG_SIZE__
#define __LONG_SIZE__ sizeof(long)
#endif

#ifndef __FLOAT_SIZE__
#define __FLOAT_SIZE__ sizeof(float)
#endif

#ifndef __DOUBLE_SIZE__
#define __DOUBLE_SIZE__ sizeof(double)
#endif

#ifndef __LONG_DOUBLE_SIZE__
#define __LONG_DOUBLE_SIZE__ sizeof(long double)
#endif

#define __SIZE_T_TYPE__ unsigned int

#define __PTRDIFF_T_TYPE__ unsigned int

#define __INTRINSIC

/* Macro for frmwri and frmrd */
#define VAPTR(T) (va_arg(ap, T *))

/* Typedefs put here to appear only once */
typedef __SIZE_T_TYPE__    size_t;
typedef __PTRDIFF_T_TYPE__ ptrdiff_t;

#endif /* _SYSMAC_H_ */
