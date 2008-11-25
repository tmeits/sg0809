#!/bin/sh
# \
exec tclsh "$0"  ${1+"$@"}

#
# Тестовая версия скрипта с использование expect
#
# Usage:
#	tclsh arstan.tcl -1
#	ilynva@mail.ru
#	12.11.2008
#

# This is required to declare that we will use Expect
package require Expect

#Правила использования скрипта
#В дальнейшем через параметры предполагается управлять генерацией выходного файла
#set arstan [lindex $argv 0]
#if {![string is integer -strict $yux] && $yux ne "-myarg"} {
 #   puts stderr "usage: $argv0 <argument> | -myarg"
 #   exit 1
#}


# Переменные
set file "russ001.rwl"


#Если expect не получит нужную команду он прерывается. -1 ждать вечно. 0 - не ждать
set timeout 1

#spawn cmd.exe /c {c:\shishov\test\run-ss.bat}
spawn  {c:\shishov\ARSTAN.EXE}
#ждем 
expect {"=>"}
send "ilynva\r"
expect {"=>"}
send "sg0809-dd.rwl\r"
expect {"=>"}
send "\r"
expect {"=>"}
send "\r"
expect {"=>"}
send "\r"
expect {"=>"}
send "\r"


expect eof

#flush ""

