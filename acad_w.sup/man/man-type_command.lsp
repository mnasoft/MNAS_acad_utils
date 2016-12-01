;;;;;;("check_command_category_list"
;;;;;;"Проверяет правильность написания справки в lsp-файлах. Выводит перечень неправильных описаний."
;;;;;;"Справка")
(defun c:check_command_category_list  (/ i command_category_list a-el)
  (setq command_category_list
         (list "not defined"   "Аббревиатуры"  "Большой шрифт" "Измени"        "Настройка"     "Обмен"
               "Объекты"       "Отверстия"     "Размеры"       "Расчеты"       "Слои"          "Смеситель"
               "Справка"       "Тексты"        "Точки"         "Шкалы"))
  (load (findfile "acad_w.sup/man/man-data_base.lsp"))
  (setq i 0
        i (foreach a-el  mnas_command_help
            (if (/= 4 (length a-el))
              (progn (print a-el) (princ "\n") (setq i (1+ i))))
            i))
  (princ "\nРазбор команд закончен.")
  (if (= i 0)
    (princ "\nНеправильных описаний не найдено."))
  (princ (strcat "\nНайдено " (itoa i) " неправильных описаний."))
  (princ))

;;;(mapcar (function (lambda (el)
;;;                      (setq len (length el))
;;;                      (if (/= 4 len)
;;;                        (progn (print el) (princ "\n") (setq i (1+ i))))
;;;                      len))
;;;          mnas_command_help)







