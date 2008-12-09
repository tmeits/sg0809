#!/bin/sh
# \
exec tclsh "$0"  ${1+"$@"}

#
# Тестовая версия скрипта с использование expect
#
# Usage:
#	tclsh arstan.tcl -1
#	ilynva@ на гугле
#	12.11.2008
#

# This is required to declare that we will use Expect
package require Expect

proc usage {} {
    puts stderr "usage: $::argv0 <timeInSecs> <DataFileName>"
    exit 1
}
proc delrez {dirpatch} {
# Удаляем файлы результатов предыдущих запусков скрипта 
if ![catch {exec cmd.exe /c del $dirpatch}] {
  return 1
} else {
 return 2
 }
}
if {$argc < 2} { usage }

# timeout value is first to be passed in
# Если expect не получит нужную команду он прерывается. -1 ждать вечно. 0 - не ждать
set timeout [lindex $argv 0]
if {![string is integer -strict $timeout]} {set timeout 10}
set datafile [lindex $argv 1]
# don't echo user output
exp_log_user 0

set dirpatch {ilynva*.*}
delrez $dirpatch
delrez {zz*}
# Переменные
#set datafile {sg0809-dd.rwl}

# Запуск проргарммы расчета
spawn  {c:\shishov\ARSTAN.EXE}
#ждем 
expect {"=>"}
send "ilynva\r"
expect {"=>"}
send "$datafile\r"
expect {"=>"}
send "\r"
expect {"=>"}
send "\r"
expect {"=>"}
send "\r"
expect {"=>"}
send "\r"

#exp_close
expect eof


#flush ""

