#!/bin/sh
# \
exec tclsh "$0"  ${1+"$@"}

#
# �������� ������ ������� � ������������� expect
#
# Usage:
#	tclsh s-arstan.tcl
#	ilynva@mail.ru
#	12.11.2008
#

set dir [file dirname [info script]]
lappend auto_path $dir [file join $dir ../../cgi-bin]


Cgi_Parse


puts "HTTP/1.0 200 OK
Content-Type: text/html; charset=windows-1251
Expires: 0
Pragma: no-cache\n"
puts "<h1>����������� s-arstan.sgi</h1>"
puts "<pre>$errorInfo</pre>"
puts "������� ����-���� (����� ��� �������)<br>"
puts $auto_path
# ������� ����� ����������� ���������� �������� ������� 
if ![catch {exec cmd.exe /c del {C:\TCLHTTPD3.5.1\htdocs\arstan\rez\*ars*.*}}] {
  puts "<br>OK\n"
} else {
 puts "<br> ������� ������!\n"
 }
if ![catch {exec cmd.exe /c del {C:\TCLHTTPD3.5.1\htdocs\cgi-bin\arstan\zz*.*}}] {
 puts "OK\n"
} else {
 puts "<br> ������� ������!\n"
}

exec tclsh.exe {C:\TCLHTTPD3.5.1\htdocs\cgi-bin\arstan\arstan.tcl}
exec cmd.exe /c copy /y /a {C:\TCLHTTPD3.5.1\htdocs\cgi-bin\arstan\*ars*.*} {C:\TCLHTTPD3.5.1\htdocs\arstan\rez\}


puts "<br> ���������� ������� ����������!!!\n<br><hr>"
puts "<br><a href='http://192.168.10.3:8015/sd0809/arstan/rez/'>��������� ���������</a>\n"
puts "<br><a href='http://192.168.10.3:8015/sd0809/arstan/arstan.html'>���������</a>\n"
#flush ""

Cgi_Tail
