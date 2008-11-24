#!/bin/sh
# \
exec tclsh "$0"  ${1+"$@"}

#
# Тестовая версия скрипта с использование expect
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
puts "<h1>Выполняется sg0809-d1.tcl</h1>"
puts "<pre>$errorInfo</pre>"
puts "Печатем авто-путь (нужно для отладки)<br>"
puts $auto_path
# Удаляем файлы результатов предыдущих запусков скрипта 
if ![catch {exec cmd.exe /c del {C:\TCLHTTPD3.5.1\htdocs\arstan\rez\ilynva*.*}}] {
  puts "<br>OK\n"
} else {
 puts "<br> Удалять нечего!\n"
 }
if ![catch {exec cmd.exe /c del {C:\TCLHTTPD3.5.1\htdocs\cgi-bin\arstan\zz*.*}}] {
 puts "OK\n"
} else {
 puts "<br> Удалять нечего!\n"
}

exec tclsh.exe {C:\TCLHTTPD3.5.1\htdocs\cgi-bin\arstan\arstan.tcl}

exec cmd.exe /c copy /y /a {C:\TCLHTTPD3.5.1\htdocs\cgi-bin\arstan\ilynva*.*} {C:\TCLHTTPD3.5.1\htdocs\sd0809\arstan\rez\*.*}

if ![catch {exec cmd.exe /c del {C:\TCLHTTPD3.5.1\htdocs\cgi-bin\arstan\ilynva*.*}}] {
  puts "<br>OK\n"
} else {
 puts "<br> Удалять нечего!\n"
 }
if ![catch {exec cmd.exe /c del {C:\TCLHTTPD3.5.1\htdocs\cgi-bin\arstan\zz*.*}}] {
 puts "OK\n"
} else {
 puts "<br> Удалять нечего!\n"
}

puts "<br> Выполнение успешно завершенно!!!\n<br><hr>"
puts "<br><a href='http://192.168.10.3:8015/sd0809/arstan/rez/'>Загрузить результат</a>\n"
puts "<br><a href='http://192.168.10.3:8015/sd0809/arstan/arstan.html'>Повторить</a>\n"
#flush ""

Cgi_Tail
