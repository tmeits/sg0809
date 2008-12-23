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
# 

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
# Количество элементов в массиве
proc Proba_Index_Puts {} {
   global probaID
   set tmp1 [array size probaID]
   #puts $tmp1
   return $tmp1
}

# Элемент NORTH
proc Proba_Get_North {ID} {
   global probaNorth
   return $probaNorth($ID)
}

# Элемент East
proc Proba_Get_East {ID} {
   global probaEast
   return $probaEast($ID)
}

# Элемент East
proc Proba_Get_Alt {ID} {
   global probaAlt
   return $probaAlt($ID)
}
# Таким макаром нужно вставить весь файл подготовленный для базы данных
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
# INSERT INTO proba VALUES ('BOL.rwl', NULL, '450', '66.30', '165.40', 1407, 1991, 'LADA');

#Proba_AddRecord 1 Russ001.rwl Polar-Urals -999 66.00 65.00  1541 1968 LASI
#Proba_AddRecord 2 BOL.rwl     NULL         450 66.30 165.40 1407 1991 LADA

source probadb.tcl


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

#Proba_Index_Puts
#puts "[Proba_Index_Puts]"
#puts "[Proba_Get_North 2]"
#puts "[Proba_Get_East 1]"
#puts "size= $s111"

puts "<FORM ACTION=\"/cgi-bin/arstan/sg0809-d1.tcl\" METHOD=\"POST\">"
#Получаем список файлов, которые соответсвуют координатам

set coord-file-list [cfl]
set rnd1 [expr rand()]
# Определяем количество элементов (вдруг все попадут в выбор)
set for_count [Proba_Index_Puts]
# Создаем таблицу ассоциирующую координаты с именами файлов с данными

puts "<table border = '1'> "
for {set x 1} {$x<=$for_count} {incr x} {
   if { $cgi(p1) >= [Proba_Get_North $x]  } {
      if { $cgi(p2) <= [Proba_Get_East $x]  } {
         # Вывалим имя файла и остальное
         puts "<tr>"
         puts "<td>[Proba_File_ID $x]</td>"
         puts "<td>[Proba_Get_North $x]</td>"
         puts "<td>[Proba_Get_East $x]</td>"
         puts "<td>[Proba_Get_Alt $x]</td>"
         #puts "<tr> <td>russ190.rwl</td>  <td>[expr rand()]</td> <td>[expr rand()]</td></tr>"
         puts "</tr>"
         }
    } 
    #else { puts "Нет данных для расчета из вашего диапазона" }
}
puts "</table><p>"

# Создаем список с именами файлов с данными
puts "В ваш выбор попали несколько файлов - выберите один из списка.<p>"
puts "<select name='vpl' > "
for {set x 1} {$x<=$for_count} {incr x} {
    puts "<option> [Proba_File_ID $x]"
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
