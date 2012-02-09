dnl Check for google's coredumper library
dnl CHECK_GOOGLE_COREDUMPER(ACTION-IF-FOUND [, ACTION-IF-NOT-FOUND])
AC_DEFUN([CHECK_GOOGLE_COREDUMPER],
[dnl

AC_ARG_WITH(
    coredumper,
    [AC_HELP_STRING([--with-coredumper=PATH],[Path to Google's Coredumper libraries])],
    cd_path="$withval",
    :)

AC_LIBTOOL_SYS_DYNAMIC_LINKER

if test -z $cd_path; then
    test_paths="/usr /usr/local"
else
    test_paths="${cd_path}"
fi

for x in $test_paths ; do
        gcd_shlib="${x}/libcoredumper${shrext_cmds}"
        AC_MSG_CHECKING([for ${gcd_shlib}])
        if test -f ${gcd_shlib}"; then
            AC_MSG_RESULT([yes])
            save_CFLAGS=$CFLAGS
            save_LDFLAGS=$LDFLAGS
            CFLAGS="$CFLAGS"
            LDFLAGS="-L${x}/lib $LDFLAGS"
            AC_CHECK_LIB(coredumper, GetCoreDump,
                COREDUMPER_LIBS="-R${x}/lib -L${x}/lib -lcoredumper")
            CFLAGS=$save_CFLAGS
            LDFLAGS=$save_LDFLAGS
            if test ! -z "${COREDUMPER_LIBS}"; then
                 AC_MSG_CHECKING([for coredumper includes in ${x}/include])
                 if test -e $x/include/google/coredumper.h; then 
                     COREDUMPER_CFLAGS=-I${x}/include
                     AC_MSG_RESULT([yes])
                 else
                     AC_MSG_RESULT([no])
                fi
                break
            fi
        else
            AC_MSG_RESULT([no])
        fi
done

AC_SUBST(COREDUMPER_CFLAGS)
AC_SUBST(COREDUMPER_LIBS)

if test -z "${COREDUMPER_LIBS}"; then
  AC_MSG_NOTICE([*** coredumper library not found.])
  ifelse([$2], , AC_MSG_ERROR([coredumper library is required]), $2)
else
  AC_MSG_NOTICE([using '${COREDUMPER_LIBS}' for coredumper])
  ifelse([$1], , , $1) 
fi 
])
