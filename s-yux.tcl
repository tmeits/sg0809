#!/bin/sh
# \
exec tclsh "$0"  ${1+"$@"}

#
# Тестовая версия скрипта с использование expect
#
# Usage:
#	tclsh s-yux.tcl
#	ilynva@
#	16.07.2008
#

#set dir [file dirname [info script]]
#lappend auto_path $dir [file join $dir ../cgi-bin]

set dir [file dirname [info script]]
lappend auto_path $dir [file join $dir ../../cgi-bin]


Cgi_Parse


puts "HTTP/1.0 200 OK
Content-Type: text/html; charset=windows-1251
Expires: 0
Pragma: no-cache\n"
puts "<h1>Выполняется s-tyx.tcl</h1>"
puts "<pre>$errorInfo</pre>"
puts "Печатем авто-путь (нужно для отладки)"
puts $auto_path


# Удаляем файлы результатов предыдущих запусков скрипта 

if ![catch {exec cmd.exe /c del {C:\TCLHTTPD3.5.1\htdocs\cgi-bin\arstan\ind.txt}}] {
  puts "<br>1)Удаляем старый файл результатов yux - OK\n"
} else {
  puts "<br>2)Удаляем старый файл результатов yux - ERR\n"
  }
if ![catch {exec cmd.exe /c del {C:\TCLHTTPD3.5.1\htdocs\cgi-bin\arstan\zz*.*}}] {
  puts "<br>1) Удаляем промежуточный результат tcl - OK\n"
} else {
  puts "<br>2) Удаляем промежуточный результат tcl - ERR\n"
  }


puts "<h1>Выполнение!!!! Ждите!</h1>"


exec tclsh.exe {C:\TCLHTTPD3.5.1\htdocs\cgi-bin\arstan\yux.tcl}


#Копируем файл результатов работы программы YUX
if ![catch {exec cmd.exe /c copy /y /a  {C:\TCLHTTPD3.5.1\htdocs\cgi-bin\arstan\ind.txt} {C:\TCLHTTPD3.5.1\htdocs\sd0809\arstan\rez\ind.txt}}] {
 puts "<br>Файл данных <b>und.txt</b> подготовлен для просмотра...\n"
} else {
 puts "<br> Ошибка копирования файла ind.txt !\n"
}

#get full pathname to file
#set file [file normalize $file]\n"
#puts "<img src=tayga.jpg> <br>"
puts "<br> Выполнение успешно завершенно!!!\n<br><hr>"
puts "<br><a href='http://firewall.kgtei.ru:8015/sd0809/arstan/rez/'>Загрузить результат</a>\n"
puts "<br><a href='index.tcl'>Повторить</a>\n<br><hr>"

#Получить текущюю дату в виде строки
set s1time [clock seconds]
set st [clock format $s1time]
puts "Page Generated: $st am EDT by ilynva"
puts "<br>Please see the <a href=\"/sd0809/arstan/contact.html\">Contact Page</a> if you have questions or comments."
#flush ""

Cgi_Tail
