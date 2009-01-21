#!/bin/sh
# \
exec tclsh "$0"  ${1+"$@"}

#
# Версия скрипта с использование expect
# Предлагает пользователю выбрать из списка файл данных и передает эту информацию скрипту расчета 
# Usage:
#	tclsh select-fd.tcl
#	ilynva@ на гугле
#	12.01.2009
#

# Моделируем базу данных с помощью массива
# Это нужно вынести в отдельный файл
# 

## CREATE TABLE "Uchastky" (
 #     "FILE" text,
 #     "NORTH" text,
 #     "EAST" text,
 #     "ALT" text,
 #     "START" integer,
 #     "END" integer,
 #     "ID STATION" text,
 #     "COUNTRY" text
 # );
 ##
 
#Структура эмулированной базы данных

proc Uch_AddRecord {ID File North East Alt Start End IDSite Country} {
global  UchID UchFile UchSite UchAlt UchNorth UchEast UchStart UchEnd UchCountry
   set UchFile($ID) $File
   set UchNorth($ID) $North
   set UchEast($ID) $East
   set UchAlt($ID) $Alt
   set UchStart($ID) $Start
   set UchEnd($ID) $End
   set UchIDSite($ID) $IDSite
   set UchCountry($ID) $Country
   set UchID($File) $ID
}

#INSERT INTO "Uchastky" VALUES ('22200020046', '80.60', '58.00', '22', 19580101, 20001231, 'POLAR_GMO_IM.E.T.KRENKELJ', 'RUS');
#INSERT INTO "Uchastky" VALUES ('22200020069', '79.50', '77.00', '11', 19451102, 20001231, 'OSTROV_VIZE', 'RUS');

#                  FILE          NORTH EAST  ALT START     END       ID STATION                   COUNTRY
#Uch_AddRecord 1  22200020046 80.60 58.00 22 19580101 20001231 POLAR_GMO_IM.E.T.KRENKELJ RUS
#Uch_AddRecord 2  22200020069 79.50 77.00 11 19451102 20001231 OSTROV_VIZE RUS

proc Uch_File {File} {
   global UchFile UchID
   set tmpID UchID($File)
   return $UchFile($tmpID)
}
proc Uch_File_ID {ID} {
   global UchFile 
   return $UchFile($ID)
}
proc Uch_ID {File} {
   global UchID
   return $UchID($File)
}
# Количество элементов в массиве
proc Uch_Index_Puts {} {
   global UchID
   set tmp1 [array size UchID]
   #puts $tmp1
   return $tmp1
}
# Элемент NORTH
proc Uch_Get_North {ID} {
   global UchNorth
   return $UchNorth($ID)
}

# Элемент East
proc Uch_Get_East {ID} {
   global UchEast
   return $UchEast($ID)
}

# Элемент Alt
proc Uch_Get_Alt {ID} {
   global UchAlt
   return $UchAlt($ID)
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

# Элемент Alt
proc Proba_Get_Alt {ID} {
   global probaAlt
   return $probaAlt($ID)
}

# Проверка попадания числа в диапазон
proc checking_falling_numbers_in_the_range { d1 d2 p1 p11 p2 p22 } {
set boolean_data_ret 0
#puts "***"
if { $d1 >= $p1 } {
      if { $d1 <= $p11 } {
         if { $d2 >= $p2 } {
            if { $d2 <= $p22 } {
               set boolean_data_ret  1
            }
         }
      }
   } 
   return $boolean_data_ret
}

source probadb.tcl


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

puts "<b>Расчет выполняется c данными:</b> <br>СЕВЕР1:$cgi(p1), СЕВЕР2:$cgi(p11), ВОСТОК1:$cgi(p2), ВОСТОК2:$cgi(p22), ВЫСОТА:$cgi(p3)<br> "

# Тестируем функции работы с массивами
#puts "*** Proba_File_ID [Proba_File_ID 1]"
#puts "*** Proba_File [Proba_File \"Russ001.rwl\"]"
#puts "*** Proba_ID [Proba_ID Russ001.rwl]"

#puts "*** Uch_File_ID [Uch_File_ID 1] <br>"
#puts "*** Uch_File_ID end [Uch_File_ID [Uch_Index_Puts]] <br>"

# Определим тип расчета

if { $cgi(deb) == 0 } {
   set d_vid 0 
} else {
   set d_vid 1
}

if { $cgi(varcalc) == 0 } {

puts "d_vid= $d_vid<br>"

if { $cgi(mr)==0 } { 
   puts "расчет по ПРОБАМ<p>" 
   #puts "[Proba_Index_Puts]"
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
   set boolean_data 0
   # Создаем таблицу ассоциирующую координаты с именами файлов с данными

   puts "<table border = '1'> "
   for {set x 1} {$x<=$for_count} {incr x} {
      if {   [Proba_Get_North $x] >= $cgi(p1)  } {
         if {  [Proba_Get_North $x] <= $cgi(p11)  } {
            if {   [Proba_Get_East $x] >= $cgi(p2)  } {
               if {  [Proba_Get_East $x] <= $cgi(p22)  } {
                  # Вывалим имя файла и остальное
                  puts "<tr>"
                  #puts "<td>$x</td>"
                  puts "<td>[Proba_File_ID $x]</td>"
                  puts "<td>[Proba_Get_North $x]</td>"
                  puts "<td>[Proba_Get_East $x]</td>"
                  puts "<td>[Proba_Get_Alt $x]</td>"
                  #puts "<tr> <td>russ190.rwl</td>  <td>[expr rand()]</td> <td>[expr rand()]</td></tr>"
                  puts "<td>[checking_falling_numbers_in_the_range [Proba_Get_North $x] [Proba_Get_East $x] $cgi(p1) $cgi(p11) $cgi(p2) $cgi(p22)]</td>"
                  puts "</tr>"
                  set boolean_data  1
               }
            }
         }
      } 
   }
   # Проверим булеву переменную на наличие попадания в диапазо присутствующий в базе. 
   if {$boolean_data == 0} {
      puts "Для вашего диапазона нет данных!!!"
   }
   puts "</table><p>"

   # Создаем список с именами файлов с данными
   puts "В ваш выбор попали несколько файлов - выберите один из списка.<p>"
   puts "<select name='vpl' > "
   for {set x 1} {$x<=$for_count} {incr x} {

      set var_equ [checking_falling_numbers_in_the_range [Proba_Get_North $x] [Proba_Get_East $x] $cgi(p1) $cgi(p11) $cgi(p2) $cgi(p22)]
      #puts "<option>1"
      if { $var_equ == 1 } {
            puts "<option> [Proba_File_ID $x]"
      }
      
   }
   puts "</select>"
   puts "<p>"
   puts "<INPUT TYPE=\"submit\" NAME=\"calcarstan\" VALUE=\"Расчитать стандартную хронологию\">"
   puts "</FORM>"
} else {
   puts "<font color=\"red\" size=+1><p>расчет по УЧАСТКАМ Будет реализован в дальнейшем!!!</font>"
   #
}

} else {
   puts "<p><font color=\"red\" size=+1> Другие виды расчета  будут реализованы в дальнейшем!!!</font><p>"
}
puts "<hr>"
#Получить текущюю дату в виде строки
set s1time [clock seconds]
#set s2time [clock seconds]
#puts "$s1time : $s2time"

set st [clock format $s1time]
puts "Page Generated: $st am EDT by ilynva"
puts "<br>Please see the <a href=\"/sd0809/arstan/contact.html\">Contact Page</a> if you have questions or comments."
Cgi_Tail
