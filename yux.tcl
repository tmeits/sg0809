#!/bin/sh
# \
exec tclsh "$0"  ${1+"$@"}

#
# Тестовая версия скрипта с использование expect
#
# Usage:
#	tclsh yux.tcl -1
#	ilynva@
#	30.06.2008
#   28.11.2008

# This is required to declare that we will use Expect
package require Expect

# Переменные
set file "ilynvars.crn"
#set filerez "ind.rez"

#Если expect не получит нужную команду он прерывается. -1 ждать вечно. 0 - не ждать
set timeout 1

#spawn cmd.exe /c {c:\shishov\test\run-ss.bat}
spawn  {c:\shishov\test\YUX.EXE}
#ждем 
expect {"=>"}
send "\r"
expect {"=>"}
send "\r"
expect {"=>"}
send "\r"
expect {"=>"}
send "\r"
expect {"=>"}
send "\r"
expect {"=>"}
send "ilynvars.crn\r"
expect {"=>"}
send "\r"
expect {"=>"}
send "ind.txt\r"
expect {"=>"}
send "All\r"
expect {"=>"}
send "\r"
#

expect eof

#flush ""

