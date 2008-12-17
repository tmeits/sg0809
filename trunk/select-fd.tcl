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

# Моделируем базу данных с помощью массива
# Это нужно вынести в отдельный файл

#CREATE TABLE proba (
#    "FILE" text,
#    "SITE NAME" text,
#    "ALT" text,
#    "NORTH" text,
#    "EAST" text,
#    "START" integer,
#    "END" integer,
#    "SPECIES" text
#);
# INSERT INTO proba VALUES ('Russ001.rwl', 'Polar-Urals', '-999', '66.00', '65.00', 1541, 1968, 'LASI');

proc Proba_AddRecord {ID File Site Alt North East Start End Species} {
global  probaID probaFile probaSite probaAlt probaNorth probaEast probaStart probaEnd probaSpecies
   set probaFile($ID) $File
   set probaSite($ID) $Site
   set probaAlt($ID) $Alt
   set probaNorth($ID) $North
   set probaEast($ID) $East
   set probaStart($ID) $Start
   set probaEnd($ID) $End
   set probaSpecies($ID) $Species
   set probaID($File) $ID
}

proc Proba_File {File} {
   global probaFile probaID
   set tmpID probaID($File)
   return $probaFile($tmpID)
}

proc Proba_File_ID {ID} {
   global probaFile 
   return $probaFile($ID)
}

proc Proba_ID {File} {
   global probaID
   return $probaID($File)
}
# Таким макаром нужно вставить весь файл подготовленный для базы данных

Proba_AddRecord 1 Russ001.rwl Polar-Urals -999 66.00 65.00 1541 1968 LASI

#puts "*** Proba_File_ID [Proba_File_ID 1]"
#puts "*** Proba_File [Proba_File \"Russ001.rwl\"]"
#puts "*** Proba_ID [Proba_ID Russ001.rwl]"

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
puts "<a href=\"/cgi-bin/arstan/index.tcl\">\[Домой\]</a>"
puts "<hr>"

# Координаты переданы в переменные p1 p2 p3 p4
#puts "<INPUT TYPE=\"submit\" NAME=\"uchastok\" VALUE=\"Провести расчет по УЧАСТКАМ\">" 
#puts "<INPUT TYPE=\"submit\" NAME=\"proba\" VALUE=\"Провести расчет по ПРОБАМ\"><p>"

puts "<b>Расчет выполняется c данными</b> СЕВЕР:$cgi(p1), ВОСТОК:$cgi(p2), ВЫСОТА:$cgi(p3), "
if { $cgi(mr)==0 } { 
 puts "расчет по ПРОБАМ<p>" 
} else {
 puts "расчет по УЧАСТКАМ<p>" 
}
puts "<FORM ACTION=\"/cgi-bin/arstan/sg0809-d1.tcl\" METHOD=\"POST\">"
#Получаем список файлов, которые соответсвуют координатам

set coord-file-list [cfl]
set rnd1 [expr rand()]

# Создаем таблицу ассоциирующую координаты с именами файлов с данными
puts "<table border = '1'> "
for {set x 0} {$x<10} {incr x} {
    puts "<tr> <td>russ190.rwl</td>  <td>[expr rand()]</td> <td>[expr rand()]</td></tr>"
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
puts "Page Generated: $st am EDT by ilynva"
puts "<br>Please see the <a href=\"/sd0809/arstan/contact.html\">Contact Page</a> if you have questions or comments."
Cgi_Tail
