dnl CHECK_APR([MINIMUM-VERSION [, ACTION-IF-FOUND [, ACTION-IF-NOT-FOUND]])
dnl Test for APR

AC_DEFUN([CHECK_APR],
[dnl
AC_ARG_WITH(
    apr,
    [AC_HELP_STRING([--with-apr=PATH],[Path to apr-config or apr-1-config])],
    apr_prefix="$withval",
    apr_prefix=""
    )

    if test -x "$apr_prefix" -a ! -d "$apr_prefix"; then
        APR_CONFIG=$apr_prefix
        AC_MSG_NOTICE([Using APR Config: $apr_prefix])
    else
        test_paths="$apr_prefix:$apr_prefix/bin:$apr_prefix/sbin"
        test_paths="${test_paths}:/usr/bin:/usr/sbin"
        AC_PATH_PROGS(APR_CONFIG, [apr-1-config apr-config], no, [$test_paths])
    fi
    if test "$APR_CONFIG" = "no"; then
        AC_MSG_ERROR([*** apr-config could not be found!])
        AC_MSG_ERROR([*** Use the --with-apr option with the full path to apr-config/apr-1-config])
    else
        APR_INCLUDES=`$APR_CONFIG --includes 2>/dev/null`
        APR_INCLUDEDIR=`$APR_CONFIG --includedir 2>/dev/null`
        APR_LDFLAGS=`$APR_CONFIG --link-ld 2>/dev/null`
        APR_LIBS=`$APR_CONFIG --libs 2>/dev/null`
        APR_LIBTOOL=`$APR_CONFIG --link-libtool 2>/dev/null`
        APR_CPPFLAGS=`$APR_CONFIG --cppflags 2>/dev/null`
        APR_CFLAGS=`$APR_CONFIG --cflags 2>/dev/null`
        APR_VERSION=`$APR_CONFIG --version 2>/dev/null`
        AC_SUBST(APR_CONFIG)
        AC_SUBST(APR_INCLUDES)
        AC_SUBST(APR_INCLUDEDIR)
        AC_SUBST(APR_LDFLAGS)
        AC_SUBST(APR_LIBS)
        AC_SUBST(APR_LIBTOOL)
        AC_SUBST(APR_CPPFLAGS)
        AC_SUBST(APR_CFLAGS)
        AC_SUBST(APR_VERSION)
    fi
])

dnl CHECK_APU([MINIMUM-VERSION [, ACTION-IF-FOUND [, ACTION-IF-NOT-FOUND]])
dnl Test for APR-Util

AC_DEFUN([CHECK_APU],
[dnl
AC_ARG_WITH(
    apr-util,
    [AC_HELP_STRING([--with-apr-util=PATH],[Path to apu-config or apu-1-config])],
    apu_prefix="$withval",
    apu_prefix=""
    )

    if test -x "$apu_prefix" -a ! -d "$apu_prefix"; then
        APU_CONFIG=$apu_prefix
        AC_MSG_NOTICE([Using APU Config: $apu_prefix])
    else
        test_paths="$apu_prefix:$apu_prefix/bin:$apu_prefix/sbin"
        test_paths="${test_paths}:/usr/bin:/usr/sbin"
        AC_PATH_PROGS(APU_CONFIG, [apu-1-config apu-config], no, [$test_paths])
    fi
    if test "$APU_CONFIG" = "no"; then
        AC_MSG_ERROR([*** apu-config could not be found!])
        AC_MSG_ERROR([*** Use the --with-apr-util option with the full path to apu-config/apu-1-config])
    else
        APU_INCLUDES=`$APU_CONFIG --includes 2>/dev/null`
        APU_INCLUDEDIR=`$APU_CONFIG --includedir 2>/dev/null`
        APU_LDFLAGS=`$APU_CONFIG --link-ld 2>/dev/null`
        APU_LIBS=`$APU_CONFIG --libs 2>/dev/null`
        APU_LIBTOOL=`$APU_CONFIG --link-libtool 2>/dev/null`
        APU_VERSION=`$APU_CONFIG --version 2>/dev/null`
        AC_SUBST(APU_CONFIG)
        AC_SUBST(APU_INCLUDES)
        AC_SUBST(APU_INCLUDEDIR)
        AC_SUBST(APU_LDFLAGS)
        AC_SUBST(APU_LIBS)
        AC_SUBST(APU_LIBTOOL)
        AC_SUBST(APU_VERSION)
    fi
])

dnl CHECK_APR_HEADER(HEADER-FILE [, ACTION-IF-FOUND [, ACTION-IF-NOT-FOUND]])
dnl Test if the given APR header file exists

AC_DEFUN([CHECK_APR_HEADERS],
[dnl
    CFLAGS="$ac_save_CFLAGS $APR_CPPFLAGS $APR_CFLAGS $APR_INCLUDES"
    AC_CHECK_HEADERS([$1],[$2],[$3],
    [#include "apr.h"
    ])
    CFLAGS="$ac_save_CFLAGS"
])

dnl CHECK_APR_HEADER(HEADER-FILE [, ACTION-IF-FOUND [, ACTION-IF-NOT-FOUND]])
dnl Test if the given APR-UTIL header file exists

AC_DEFUN([CHECK_APU_HEADERS],
[dnl
    CFLAGS="$ac_save_CFLAGS $APR_CPPFLAGS $APR_CFLAGS $APR_INCLUDES $APU_INCLUDES"
    AC_CHECK_HEADERS([$1],[$2],[$3],
    [#include "apu.h"
#include "apr_pools.h"
#include "apr_lib.h"
    ])
    CFLAGS="$ac_save_CFLAGS"
])

dnl CHECK_APR_FUNCS(FUNC [, ACTION-IF-FOUND [, ACTION-IF-NOT-FOUND]])
dnl Test if the given APR header file exists

AC_DEFUN([CHECK_APR_FUNC],
[dnl
    LDFLAGS="$ac_save_LDFLAGS $APR_LDFLAGS"
    AC_CHECK_FUNCS([$1],[$2],[$3])
    LDFLAGS="$ac_save_LDFLAGS"
])

dnl CHECK_APR_FUNCS(FUNC [, ACTION-IF-FOUND [, ACTION-IF-NOT-FOUND]])
dnl Test if the given APR-UTIL header file exists

AC_DEFUN([CHECK_APU_FUNCS],
[dnl
    LDFLAGS="$ac_save_LDFLAGS $APR_LDFLAGS $APU_LDFLAGS"
    AC_CHECK_FUNCS([$1],[$2],[$3])
    LDFLAGS="$ac_save_LDFLAGS"
])
