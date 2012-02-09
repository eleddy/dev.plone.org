dnl Check for subversion client libraries
dnl CHECK_PATH_SUBVERSION(ACTION-IF-FOUND [, ACTION-IF-NOT-FOUND])
AC_DEFUN([CHECK_PATH_SUBVERSION],
[dnl

AC_ARG_WITH(
    svn,
    [AC_HELP_STRING([--with-svn=PATH],[Path subversion headers and libraries])],
    svn_path="$withval",
    :)

AC_LIBTOOL_SYS_DYNAMIC_LINKER

# Determine subversion include directory.
if test -z $svn_path; then
    test_paths="/usr/include /usr/include/subversion-1 
                /usr/local/include /usr/local/include/subversion-1"
else
    test_paths="${svn_path}/include ${svn_path}/include/subversion-1"
fi

for x in $test_paths ; do
    AC_MSG_CHECKING([for Subversion Includes in ${x}])
    if test -f ${x}/svn_version.h; then
        SVN_INCLUDES="-I$x"
        AC_MSG_RESULT([found it! Use --with-svn to specify another.])
        break
    else
        AC_MSG_RESULT(no)        
    fi
done

if test -z "$SVN_INCLUDES"; then
  ifelse([$2], , AC_MSG_ERROR([Subversion include files not found.]), $2)
fi

# Determine subversion lib directory
if test -z $svn_path; then
    test_paths="/usr/lib /usr/local/lib"
else
    test_paths="${svn_path}/lib"
fi

for x in $test_paths ; do
    svn_shlib="${x}/libsvn_repos-1${shrext_cmds}"
    AC_MSG_CHECKING([for Subversion library in ${x}])
    if test -f $svn_shlib; then
        AC_MSG_RESULT([yes])
        save_CFLAGS=$CFLAGS
        save_LDFLAGS=$LDFLAGS
        CFLAGS="$SVN_INCLUDES $CFLAGS"
        LDFLAGS="-L$x $LDFLAGS"
        AC_CHECK_LIB(svn_repos-1, svn_repos_open,
            SVN_LIBS="-R$x -L$x")
        dnl // TODO: Should we check for other libs here?
        CFLAGS=$save_CFLAGS
        LDFLAGS=$save_LDFLAGS
        break
    else
        AC_MSG_RESULT([no])
    fi
done
if test -z "$SVN_LIBS"; then
  ifelse([$2], , AC_MSG_ERROR([Subversion library not found.]), $2)
else
  AC_SUBST(SVN_LIBS)
  AC_SUBST(SVN_INCLUDES)
  ifelse([$1], , , $1)
fi
])
