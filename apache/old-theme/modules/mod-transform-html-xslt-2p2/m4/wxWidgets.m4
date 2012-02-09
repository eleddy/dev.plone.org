dnl Check for wxWidget libraries
dnl CHECK_WX(MINIMUM-VERSION, ACTION-IF-FOUND [, ACTION-IF-NOT-FOUND])
AC_DEFUN([CHECK_WX],
[dnl

AC_ARG_WITH(
    wx,
    [AC_HELP_STRING([--with-wx=PATH],[Path to your wx-config])],
    wx_path="$withval",
    wx_path="/usr"
    )

    if test -x wx_path -a ! -d $wx_path; then
        WX_BIN=$wx_path
    else
        test_paths="$wx_path:$wx_path/bin:$wx_path/sbin"
        test_paths="${test_paths}:/usr/bin:/usr/sbin"
        test_paths="${test_paths}:/usr/local/bin:/usr/local/sbin"
        AC_PATH_PROG(WX_BIN, wx-config, no, [$test_paths])
    fi

    if test "$WX_BIN" = "no"; then
        AC_MSG_ERROR([*** The wx-config binary installed by wxWidgets could not be found!])
        AC_MSG_ERROR([*** Use the --with-wx option with the full path to wx-config])
        ifelse([$3], , AC_MSG_ERROR([wxWidgets >=$1 is not installed.]), $3)
    else
        dnl TODO: Do a wxWidgets Version check here...
        WX_LIBS="`$WX_BIN --libs 2>/dev/null`"
        WX_FLAGS="`$WX_BIN --cxxflags 2>/dev/null`"
        AC_SUBST(WX_LIBS)
        AC_SUBST(WX_FLAGS)
        ifelse([$2], , AC_MSG_RESULT([yes]), $2)
    fi
])
