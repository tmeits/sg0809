#!/bin/bash
function process_dir()
{
  #используем локальные переменные, ибо функция рекурсивна
  local dir=$1

local item
  for item in "$dir"/*
  do
    # пустая директория/* будет расширена '*', e.g.: /какаято/папка/*
    # делаем проверку на существование:
    [[ ! -e $item ]] && return    

    # если директория, обрабатываем рекурсивно
    [[ -d $item ]] && process_dir $item  

    # теперь отделим имя файла от пути и создадим
    # эквивалент имени файла "маленькими буквами"
    local path=${item%/*}
    local name=${item##*/}
    local lcase_name=$(tr 'A-Z' 'a-z' <<< $name)

    # для облегчения работы, проверим в нижнем ли регистре имя файла
    if [[ $name != $lcase_name ]]; then
      # если файл уже в нижнем регистре, то нам надо быть аккуратнее
      if [[ -e $path/$lcase_name ]]; then
        # если это директория и существующий файл - тоже директория, используем слияние
        if [[ -d $path/$lcase_name && -d $path/$name ]]; then
          # если мы все успешно переместили, удалим оставшиеся в большом регистре файлы
          local can_delete_dir=1
          local subdir_item
          for subdir_item in "$path/$name"/*
          do
            # если директория пустая, сразу удаляем
            [[ ! -e $subdir_item ]] && break
            local subdir_name=${subdir_item##*/}
            # проверяем также дублирование файлов
            if [[ -e $path/$lcase_name/$subdir_name ]]; then
              echo "CONFLICT: Cannot move item $subdir_item to $path/$lcase_name as that destination already exists"
              # тут мы не можем удалить файлы
              can_delete_dir=0
            else
              # у нас получится переместить файлы
              echo "MERGE: $subdir_item to $path/$lcase_name/$subdir_name"
              mv "$subdir_item" "$path/$lcase_name/"
            fi
          done
          # если мы все успешно переместили, удаляем директорию
          if [[ $can_delete_dir -eq 1 ]]; then
            echo "DELETE: $path/$name having merged all its contents elsewhere"
            rm $path/$name
          fi
        else
          # если такой же файл существует, не перезаписываем, а выводим сообщение об ошибке и продолжаем
          echo "CONFLICT: Cannot rename file $path/$name to $path/$lcase_name as that file already exists"
        fi
      else
        # в этой директории нет имен файлов, удовлетворяющих нашим условиям - переименовываем
        echo "RENAME: $path/$name to $path/$lcase_name"
        mv "$path/$name" "$path/$lcase_name"
      fi
    fi
  done
}

start_dir="$1"
[[ -n $start_dir && -e $start_dir ]] || { echo "Please supply the starting directory as a parameter to the script";
exit 1; }

# обрезать все окончания с '/'
start_dir=${start_dir%/}
process_dir "$start_dir"
