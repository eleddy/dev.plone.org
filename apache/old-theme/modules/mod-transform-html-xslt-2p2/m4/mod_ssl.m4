dnl CHECK_PATH_MOD_SSL([ACTION-IF-FOUND [, ACTION-IF-NOT-FOUND]])
dnl Test for mod_ssl and openssl header directory.
dnl
AC_DEFUN([CHECK_MOD_SSL],
[dnl
AC_ARG_ENABLE(
        ssl,
        [AC_HELP_STRING([--disable-ssl],[Do not compile in SSL support])],
        ssl_val=no,
        ssl_val=yes
    )
AC_ARG_WITH(
        ssl-inc,
        [AC_HELP_STRING([--with-ssl-inc=PATH],[Location of SSL header files])],
        ssl_incdir="$withval",
    )
AC_ARG_WITH(
        db-inc,
        [AC_HELP_STRING([--with-db-inc=PATH],[Location of DB header files])],
        db_incdir="$withval",
        db_incdir="/usr/include/db1"
    )

AC_PATH_PROG(PKG_CONFIG, pkg-config, no)

if test x$PKG_CONFIG = xno ; then
    ifelse([$3], , AC_MSG_WARN([pkg-config not found. pkg-config is recommended for mod_ssl detection]), $3)
fi

    if test "x$ssl_val" = "xyes"; then
        ac_save_CFLAGS=$CFLAGS
        ac_save_CPPFLAGS=$CPPFLAGS
        MOD_SSL_CFLAGS="-I/usr/include/openssl"
        if test "x$ssl_incdir" != "x"; then
            MOD_SSL_CFLAGS="-I$ssl_incdir -I$ssl_incdir/openssl $MOD_SSL_CFLAGS"
        fi
        if test "x$db_incdir" != "x"; then
            MOD_SSL_CFLAGS="-I$db_incdir $MOD_SSL_CFLAGS"
        fi
        if test x$PKG_CONFIG != xno && $PKG_CONFIG openssl; then
            MOD_SSL_CFLAGS="`$PKG_CONFIG openssl --cflags` $MOD_SSL_CFLAGS"
        fi
        CFLAGS="$AP_CFLAGS $MOD_SSL_CFLAGS $CFLAGS"
        CPPFLAGS="$AP_CFLAGS $MOD_SSL_CFLAGS $CPPFLAGS"
        AC_CHECK_HEADERS([mod_ssl.h],
            mod_ssl_h=yes
        )
        CFLAGS=$ac_save_CFLAGS
        CPPFLAGS=$ac_save_CPPFLAGS
        if test "x$mod_ssl_h" = "x"; then
            ifelse([$2], , :, [$2])
        else
            AC_SUBST(MOD_SSL_CFLAGS)
            ifelse([$1], , :, [$1])
        fi
    else
        ifelse([$2], , :, [$2])
    fi
])
