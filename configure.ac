AC_INIT([FINANCEMCP], [1.0], [admin@punks.work])
AM_INIT_AUTOMAKE([-Wall -Werror foreign])
AC_CHECK_LIB([aws], [main], [],
[
  AC_MSG_ERROR([Could  not find AWS SDK library. Please install it and try again.])
])
AC_CHECK_LIB([gnatcoll_sql], [main], [],
[
  AC_MSG_ERROR([Could  not find GNATCOLL SQL library. Please install it and try again.])
])
AC_CHECK_LIB([pq], [main], [],
[
  AC_MSG_ERROR([Could  not find Postgres library. Please install it and try again.])
])

AC_CONFIG_FILES([
 Makefile

])
AC_OUTPUT
