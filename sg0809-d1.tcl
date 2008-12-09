#!/bin/sh
# \
exec tclsh "$0"  ${1+"$@"}

#
# Тестовая версия скрипта с использование expect
#
# Usage:
#	tclsh s-arstan.tcl
#	ilynva@ на гугле
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

#На данный момент выбор файла пользователя представлен сриском из которого он делает выбор

puts "<h4>Расчет выполняется c данными $cgi(vpl)!!!! Ждите!</h4>"

set copydatafile1 {C:\TCLHTTPD3.5.1\htdocs\sd0809\arstan\dat}
set copydatafile2 "$cgi(vpl)"
set copydatafile "$copydatafile1\\$copydatafile2"
puts $copydatafile

#Копируем файл данных
if ![catch {exec cmd.exe /c copy /y /a $copydatafile {C:\TCLHTTPD3.5.1\htdocs\cgi-bin\arstan\sg0809-dd.rwl}}] {
 puts "<br>Файл данных $cgi(vpl) подготовлен для расчета...\n"
} else {
 puts "<br> Ошибка копирования файла $cgi(vpl)!\n"
}

exec tclsh.exe {C:\TCLHTTPD3.5.1\htdocs\cgi-bin\arstan\arstan.tcl} 1 sg0809-dd.rwl

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

puts "<br><h4> Выполнение успешно завершенно!!!</h4>\n<br><hr>"
# Копируем файл данных для yux.exec
set copydatafileyux {C:\TCLHTTPD3.5.1\htdocs\sd0809\arstan\rez\ilynvars.crn}
if ![catch {exec cmd.exe /c copy /y /a $copydatafileyux {C:\TCLHTTPD3.5.1\htdocs\cgi-bin\arstan}}] {
 puts "<br>Файл данных ilynvars.crn подготовлен для расчета программой YUX...\n"
} else {
 puts "<br> Ошибка копирования файла ilynvars.crn !\n"
}

puts "<FORM ACTION=http://192.168.10.3:8015/cgi-bin/arstan/s-yux.tcl METHOD=POST>"
puts "<INPUT TYPE=\"submit\" NAME=\"calcyux\" VALUE=\"Провести расчет YUX\">"
puts "</FORM>"
puts "<hr>"
puts "<br><a href='http://192.168.10.3:8015/sd0809/arstan/rez/'>Загрузить результат</a>\n"
puts "<br><a href='http://192.168.10.3:8015/sd0809/arstan/arstan.html'>Повторить</a>\n"
#flush ""

Cgi_Tail
