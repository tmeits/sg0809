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

# Отладочная переменная (1 есть вывод!)
set d_vid 0

# Печать отладочной информации
proc d_puts {d_string} {
 global d_vid
 if { $d_vid == 1 } {
  puts $d_string
 } else {
  return 
 }
}

Cgi_Parse


puts "HTTP/1.0 200 OK
Content-Type: text/html; charset=windows-1251
Expires: 0
Pragma: no-cache\n"

#puts "<h1>Выполняется sg0809-d1.tcl</h1>"
puts "<h2>Интерактивная дендроклиматическая система</h2>"
d_puts "<pre>$errorInfo</pre>"
d_puts "Печатем авто-путь (нужно для отладки)<br>"
d_puts $auto_path

# Удаляем файлы результатов предыдущих запусков скрипта 
if ![catch {exec cmd.exe /c del {C:\TCLHTTPD3.5.1\htdocs\arstan\rez\ilynva*.*}}] {
  d_puts "<br>OK\n"
} else {
 d_puts "<br> Удалять нечего!\n"
 }
if ![catch {exec cmd.exe /c del {C:\TCLHTTPD3.5.1\htdocs\cgi-bin\arstan\zz*.*}}] {
 d_puts "OK\n"
} else {
 d_puts "<br> Удалять нечего!\n"
}

#На данный момент выбор файла пользователя представлен сриском из которого он делает выбор

puts "<h4>Расчет выполняется c данными $cgi(vpl)!!!! Ждите!</h4>"

set copydatafile1 {C:\TCLHTTPD3.5.1\htdocs\sd0809\arstan\dat}
set copydatafile2 "$cgi(vpl)"
set copydatafile "$copydatafile1\\$copydatafile2"

d_puts $copydatafile

#Копируем файл данных
if ![catch {exec cmd.exe /c copy /y /a $copydatafile {C:\TCLHTTPD3.5.1\htdocs\cgi-bin\arstan\sg0809-dd.rwl}}] {
 puts "<br>Файл данных $cgi(vpl) подготовлен для расчета...\n"
} else {
 puts "<br> Ошибка копирования файла $cgi(vpl)!\n"
}

exec tclsh.exe {C:\TCLHTTPD3.5.1\htdocs\cgi-bin\arstan\arstan.tcl} 1 sg0809-dd.rwl

exec cmd.exe /c copy /y /a {C:\TCLHTTPD3.5.1\htdocs\cgi-bin\arstan\ilynva*.*} {C:\TCLHTTPD3.5.1\htdocs\sd0809\arstan\rez\*.*}

if ![catch {exec cmd.exe /c del {C:\TCLHTTPD3.5.1\htdocs\cgi-bin\arstan\ilynva*.*}}] {
  d_puts "<br>OK\n"
} else {
 d_puts "<br> Удалять нечего!\n"
 }
if ![catch {exec cmd.exe /c del {C:\TCLHTTPD3.5.1\htdocs\cgi-bin\arstan\zz*.*}}] {
 d_puts "OK\n"
} else {
 d_puts "<br> Удалять нечего!\n"
}

puts "<br><h4> Выполнение успешно завершенно!!!</h4>\n<br><hr>"
# Копируем файл данных для yux.exec
set copydatafileyux {C:\TCLHTTPD3.5.1\htdocs\sd0809\arstan\rez\ilynvars.crn}
if ![catch {exec cmd.exe /c copy /y /a $copydatafileyux {C:\TCLHTTPD3.5.1\htdocs\cgi-bin\arstan}}] {
 puts "<br>Файл данных ilynvars.crn подготовлен для расчета программой YUX...\n<p>"
} else {
 puts "<br> Ошибка копирования файла ilynvars.crn !\n"
}

puts "<FORM ACTION=\"s-yux.tcl\" METHOD=POST>"
puts "<INPUT TYPE=\"submit\" NAME=\"calcyux\" VALUE=\"Провести расчет YUX\">"
puts "</FORM>"
puts "<hr>"
puts "<br><a href=\"http://firewall.kgtei.ru:8015/sd0809/arstan/rez/\">Загрузить результат</a>\n"
puts "<br><a href=\"index.tcl\">Повторить</a>\n<p>"
#Получить текущюю дату в виде строки
set s1time [clock seconds]
set st [clock format $s1time]
puts "Page Generated: $st am EDT by ilynva"
puts "<br>Please see the <a href=\"sd0809/arstan/contact.html\">Contact Page</a> if you have questions or comments."
#flush ""

Cgi_Tail
