#!/bin/sh
# \
exec tclsh "$0"  ${1+"$@"}

#
# Тестовая версия скрипта с использование expect
#
# Usage:
#	tclsh s-yux.tcl
#	ilynva@mail.ru
#	16.07.2008
#


puts "HTTP/1.0 200 OK
Content-Type: text/html; charset=windows-1251
Expires: 0
Pragma: no-cache\n"
puts "<h1>Выполняется s-tyx.tcl</h1>"
puts "<pre>$errorInfo</pre>"
puts "Печатем авто-путь (нужно для отладки)"
puts $auto_path
# Удаляем файлы результатов предыдущих запусков скрипта 


if ![catch {exec cmd.exe /c del {C:\TCLHTTPD3.5.1\htdocs\cgi-bin\yux\ind.txt}}] {
  puts "<br>Удаляем старый файл результатов - OK<br>"
} else {
  puts "<br>Удаляем старый файл результатов - ERR<br>"
  }
if ![catch {exec cmd.exe /c del {C:\TCLHTTPD3.5.1\htdocs\cgi-bin\yux\zz*.*}}] {
  puts "Удаляем промежуточный результат - OK<br>"
} else {
  puts "Удаляем промежуточный файл результатов - ERR<br>"
  }

puts "<h1>Выполнение!!!! Ждите!</h1>"
#exec cmd.exe /c del {C:\TCLHTTPD3.5.1\htdocs\cgi-bin\yux\zz*.*}



exec tclsh.exe {C:\TCLHTTPD3.5.1\htdocs\cgi-bin\yux\yux.tcl}


exec cmd.exe /c copy /y /a {C:\TCLHTTPD3.5.1\htdocs\cgi-bin\yux\ind.txt} {C:\TCLHTTPD3.5.1\htdocs\yux\ind.txt}


#get full pathname to file
#set file [file normalize $file]\n"
puts "<br> Выполнение успешно завершенно.\n<br><hr>"
puts "<br><a href='http://192.168.10.3:8015/yux/ind.txt'>Загрузить результат</a>\n"
puts "<br><a href='http://localhost:8015/cgi-bin/yux/s-yux.tcl'>Повторить</a>\n"
#flush ""

