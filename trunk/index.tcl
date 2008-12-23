#!/bin/sh
# \
exec tclsh "$0"  ${1+"$@"}

#
# Первая страница
# Предлагает пользователю выбрать Alt North East и тип расчета Проба или Участки и передает эту информацию скрипту расчета 
# Usage:
#	tclsh index.tcl
#	ilynva@ на гугле
#	12.12.2008
#

set dir [file dirname [info script]]
lappend auto_path $dir [file join $dir ../../cgi-bin]


Cgi_Parse


puts "HTTP/1.0 200 OK
Content-Type: text/html; charset=windows-1251
Expires: 0
Pragma: no-cache\n"

puts "<h2>Интерактивная дендроклиматическая система</h2>"
puts "<hr>"

puts "<FORM ACTION=\"/cgi-bin/arstan/select-fd.tcl\" METHOD=\"POST\">"
#Получаем координатам
puts "<INPUT TYPE=\"submit\" NAME=\"uchastok\" VALUE=\"Начать поиск\">" 
puts "<INPUT TYPE=\"reset\" NAME=\"proba\" VALUE=\"Очистить форму\"><p>"
# Создаем таблицу ассоциирующую координаты с именами файлов с данными
puts "<table border = '1'> "

puts "<tr>"
puts "<td>Первая точка СЕВЕР: </td><td><INPUT TYPE=\"text\" NAME=\"p1\"  value=66 SIZE=\"8\"></td>"
puts "<td>Вторая точка ВОСТОК: </td><td> <INPUT TYPE=\"text\" NAME=\"p2\" value=65 SIZE=\"1\"></td>"
puts "</tr><tr>"
puts "<td>Высота (м): </td><td><INPUT TYPE=\"text\" NAME=\"p3\" value=199 SIZE=\"8\"></td>"
puts "<td>расчет по ПРОБАМ (0)/ УЧАСТКАМ(1)</td><td>"
puts "<select name='mr' size=1> "
puts "<option>0"
puts "<option>1"
puts "</select>"
puts "</td>"
#puts "<td>по ПРОБАМ (0) по УЧАСТКАМ (1):  </td><td><INPUT TYPE=\"text\" NAME=\"p4\" value=0 SIZE=\"8\"></td>"
puts "</td>"

puts "</table>"


puts "</FORM>"

puts "<hr>"
#Получить текущюю дату в виде строки
set s1time [clock seconds]
set st [clock format $s1time]
puts "Page Generated: $st am EDT by ilynva"
puts "<br>Please see the <a href=\"/sd0809/arstan/contact.html\">Contact Page</a> if you have questions or comments."

Cgi_Tail
