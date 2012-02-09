dnl CHECK_PATH_MYSQL([ACTION-IF-FOUND [, ACTION-IF-NOT-FOUNT]])
dnl Check for MySQL Libs
dnl
AC_DEFUN([CHECK_MYSQL],
[dnl
AC_ARG_WITH(
        mysql,
        [AC_HELP_STRING([--with-mysql=PATH],[Path to MySQL client library])],
        mysql_prefix="$withval",
        
    )
AC_ARG_ENABLE(
        mysqltest,
        [AC_HELP_STRING([--disble-mysqltest],[Do not try to compile and run mysql test program])],
        ,
        enable_mysqltest=yes)

    AC_REQUIRE([AC_CANONICAL_TARGET])

    testdirs="/usr /usr/local /usr/local /opt"
    if test "x$mysql_prefix" != "x" && test "x$mysql_prefix" != "xyes"; then
        testdirs="${testdirs} ${mysql_prefix}"
    fi
    for dir in $testdirs; do
      if test -e $dir/include/mysql.h; then
        MYSQL_CFLAGS=-I${dir}/include
        MYSQL_LDFLAGS=-L${dir}/lib${libsuff}
        MYSQL_LIBS="-lmysqlclient -lm -lz"
        break
      elif test -e $dir/include/mysql/mysql.h; then
        MYSQL_CFLAGS=-I${dir}/include/mysql
        MYSQL_LDFLAGS=-L${dir}/lib${libsuff}/mysql
        MYSQL_LIBS="-lmysqlclient -lm -lz"
        break
      fi
    done
    if test -z $MYSQL_CFLAGS; then
      echo "*** MySQL development files could not be found!"
    fi
    ac_save_CFLAGS=$CFLAGS
    ac_save_LDFLAGS=$LDFLAGS
    ac_save_LIBS=$LIBS
    CFLAGS="$CFLAGS $MYSQL_CFLAGS"
    LDFLAGS="$LDFLAGS $MYSQL_LDFLAGS"
    AC_CHECK_LIB(m, floor)
    AC_CHECK_LIB(z, gzclose)
    with_mysql="yes"
    AC_DEFINE(WITH_MYSQL,1,[Define to 1 if we are compiling with mysql])
    AC_CHECK_LIB(mysqlclient, mysql_init, ,
      [AC_MSG_ERROR(libmysqlclient is needed for MySQL support)])
    AC_CHECK_FUNCS(mysql_real_escape_string)
    AC_MSG_CHECKING(whether mysql clients can run)
    AC_TRY_RUN([
      #include <stdio.h>
      #include <mysql.h>    
      int main(void)
      {
          MYSQL *a = mysql_init(NULL);
          return 0;
      }
      ], , no_mysql=yes,[echo $ac_n "cross compiling; assumed OK.... $ac_c"])
      CFLAGS=$ac_save_CFLAGS
      LDFLAGS=$ac_save_LDFLAGS
      LIBS=$ac_save_LIBS
      if test "x$no_mysql" = x; then
        AC_MSG_RESULT(yes)
        ifelse([$1], , :, [$1])
      else
        AC_MSG_RESULT(no)
        echo "*** MySQL could not be found ***"
        MYSQL_CFLAGS=""
        MYSQL_LDFLAGS=""
        MYSQL_LIBS=""
        ifelse([$2], , :, [$2])
      fi
      AC_SUBST(MYSQL_LDFLAGS)
      AC_SUBST(MYSQL_CFLAGS)
      AC_SUBST(MYSQL_LIBS)
])
