dnl Check for libdbi libraries
dnl CHECK_LIBDBI(ACTION-IF-FOUND [, ACTION-IF-NOT-FOUND])
AC_DEFUN([CHECK_LIBDBI],
[dnl

AC_ARG_WITH(
    dbi,
    [AC_HELP_STRING([--with-dbi=PATH],[Path libdbi headers and libraries])],
    dbi_path="$withval",
    :)

# Determine dbi include directory.
if test -z $dbi_path; then
    test_paths="/usr/include /usr/local/include"
else
    test_paths="${dbi_path}/include"
fi

for x in $test_paths ; do
    AC_MSG_CHECKING([for dbi Includes in ${x}])
    if test -f ${x}/dbi/dbi.h; then
        DBI_CFLAGS="-I$x"
        AC_MSG_RESULT([found it! Use --with-dbi to specify another.])
        break
    else
        AC_MSG_RESULT(no)        
    fi
done

if test -z "$DBI_CFLAGS"; then
  ifelse([$2], , AC_MSG_ERROR([libdbi include files not found.]), $2)
fi

# Determine libdbi lib directory
if test -z $dbi_path; then
    test_paths="/usr/lib /usr/local/lib"
else
    test_paths="${dbi_path}/lib"
fi

for x in $test_paths ; do
    AC_MSG_CHECKING([for libdbi library in ${x}])
    if test -f ${x}/libdbi.so; then
        AC_MSG_RESULT([yes])
        save_CFLAGS=$CFLAGS
        save_LDFLAGS=$LDFLAGS
        CFLAGS="$DBI_CFLAGS $CFLAGS"
        LDFLAGS="-L$x $LDFLAGS"
        AC_CHECK_LIB(dbi, dbi_version,
            DBI_LDFLAGS="-L$x")
        dnl // TODO: Should we check for other libs here?
        CFLAGS=$save_CFLAGS
        LDFLAGS=$save_LDFLAGS
        break
    else
        AC_MSG_RESULT([no])
    fi
done
if test -z "$DBI_LDFLAGS"; then
  ifelse([$2], , AC_MSG_ERROR([libdbi library not found.]), $2)
else
  AC_SUBST(DBI_LDFLAGS)
  DBI_LIBS=-ldbi
  AC_SUBST(DBI_LIBS)
  AC_SUBST(DBI_CFLAGS)
  ifelse([$1], , , $1)
fi
])
