#!/bin/sh
# \
exec tclsh "$0"  ${1+"$@"}

#
# �������� ������ ������� � ������������� expect
#
# Usage:
#	tclsh arstan.tcl -1
#	ilynva@mail.ru
#	12.11.2008
#

# This is required to declare that we will use Expect
package require Expect

#������� ������������� �������
#� ���������� ����� ��������� �������������� ��������� ���������� ��������� �����
#set yux [lindex $argv 0]
#if {![string is integer -strict $yux] && $yux ne "-myarg"} {
 #   puts stderr "usage: $argv0 <argument> | -myarg"
 #   exit 1
#}


# ����������
set file "russ001.rwl"


#���� expect �� ������� ������ ������� �� �����������. -1 ����� �����. 0 - �� �����
set timeout 1

#spawn cmd.exe /c {c:\shishov\test\run-ss.bat}
spawn  {c:\shishov\ARSTAN.EXE}
#���� 
expect {"=>"}
send "ilynva\r"
expect {"=>"}
send "russ001.rwl\r"
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

