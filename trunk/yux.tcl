#!/bin/sh
# \
exec tclsh "$0"  ${1+"$@"}

#
# Тестовая версия скрипта с использование expect
#
# Usage:
#	tclsh yux.tcl -1
#	ilynva@mail.ru
#	30.06.2008
#

# This is required to declare that we will use Expect
package require Expect

#Правила использования скрипта
#В дальнейшем через параметры предполагается управлять генерацией выходного файла
#set yux [lindex $argv 0]
#if {![string is integer -strict $yux] && $yux ne "-myarg"} {
 #   puts stderr "usage: $argv0 <argument> | -myarg"
 #   exit 1
#}


# Переменные
set file "ind.rwl"
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
send "ind.rwl\r"
expect {"=>"}
send "\r"
expect {"=>"}
send "ind.txt\r"
expect {"=>"}
send "All\r"
expect {"=>"}
send "\r"
#expect "Password:"
#send "expect@nist.gov\r"
#expect "ftp>"
#send "binary\r"
#expect "ftp>"
#send "cd inet/rfc\r"
#expect "550*ftp>" exit "250*ftp>"
#send "get $file\r"
#expect "550*ftp>" exit "200*226*ftp>"
#close
#wait

expect eof

#flush ""

