#!/bin/sh
# \
exec tclsh "$0"  ${1+"$@"}

#
# Версия скрипта с использование expect
# Предлагает пользователю выбрать из списка файл данных и передает эту информацию скрипту расчета 
# Usage:
#	tclsh select-fd.tcl
#	ilynva@ на гугле
#	12.11.2008
#

proc cfl {} {
return 1;
}

set dir [file dirname [info script]]
lappend auto_path $dir [file join $dir ../../cgi-bin]


Cgi_Parse


puts "HTTP/1.0 200 OK
Content-Type: text/html; charset=windows-1251
Expires: 0
Pragma: no-cache\n"

puts "<h2>Интерактивная дендроклиматическая система</h2>"
puts "<hr>"

puts "<FORM ACTION=\"/cgi-bin/arstan/sg0809-d1.tcl\" METHOD=\"POST\">"
#Получаем список файлов, которые соответсвуют координатам

set coord-file-list [cfl]

# Создаем таблицу ассоциирующую координаты с именами файлов с данными
puts "<table border = '1'> "
for {set x 0} {$x<10} {incr x} {
    puts "<tr> <td>russ190.rwl</td>  <td>....</td> <td>....</td></tr>"
}
puts "</table><p>"

# Создаем список с именами файлов с данными
puts "<select name='vpl' > "
for {set x 0} {$x<10} {incr x} {
    puts "<option> russ190.rwl"
}
puts "</select>"
puts "<p>"
puts "<INPUT TYPE=\"submit\" NAME=\"calcarstan\" VALUE=\"Провести расчет\">"
puts "</FORM>"

puts "<hr>"
#Получить текущюю дату в виде строки
set s1time [clock seconds]
#set s2time [clock seconds]
#puts "$s1time : $s2time"

set st [clock format $s1time]
puts "$st"

Cgi_Tail
