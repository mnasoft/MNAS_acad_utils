;;;;;;("check_command_category_list" "Проверяет правильность написания справки в lsp-файлах. Выводит перечень неправильных описаний." "Справка")
(defun c:check_command_category_list (/ i command_category_list)
  (setq	command_category_list
	 (list
	   "not defined"   "Аббревиатуры"  "Большой шрифт" "Измени"	   "Настройка"
	   "Обмен"	   "Объекты"	   "Отверстия"	   "Размеры"	   "Расчеты"
	   "Слои"	   "Смеситель"	   "Справка"	   "Тексты"	   "Точки"
	   "Шкалы"
	  )
  )
  (load(strcat (acad_sup) "/prj/man/man_data_base.lsp" ))
  (setq i 0)
  (mapcar
    (function
      (lambda (el)
	(setq len (length el))
	(if (/= 4 len)
	  (progn
	    (print el)
	    (setq i (1+ i))
	  )
	)
	len
      )
    )
    MNAS_command_help
  )
  (princ (strcat "Разбор команд закончен. Найдено неправильных описаний = " (itoa i) " ." ))
  (princ)
)
;;;(vl-sort command_category_list (function <))
;|«Visual LISP© Format Options»
(105 2 15 2 nil "end of" 90 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
