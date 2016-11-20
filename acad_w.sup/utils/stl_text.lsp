;;	stl()		- Устанавливает в зависимости от платформы ситль текста T на основании шрифтов: "es_***,my_b_f".
(defun stl  (/ os_ver msg-01 msg-02)
  (setq msg-01 (r-e-m "Не могу найти файл " "Can not find file ")
        msg-02 (r-e-m "\nДобавьте путь к этому файлу в список Путей доступа к вспомогательным файлам"
                      "\nAdd path to that file in Support Files Search Path")
        msg-03 (r-e-m "\nТекущий стиль:\n" "\nCurrent style\n"))
  (if (null (findfile "es_dos.shx"))
    (progn (alert (strcat msg-01 "\"es_dos.shx\"" msg-02)) (exit)))
  (if (null (findfile "es_win.shx"))
    (progn (alert (strcat msg-01 "\"es_win.shx\"" msg-02)) (exit)))
  (if (null (findfile "my_b_f.shx"))
    (progn (alert (strcat msg-01 "\"es_win.shx\"" msg-02)) (exit)))
  (setq os_ver (cadr (str_token (getvar "platform") " ")))
  (cond ((= os_ver "DOS") (vl-cmdf "_style" "t" "es_dos,my_b_f" "0" "1" "0" "_N" "_N" "_N"))
        ((= os_ver "Windows") (vl-cmdf "_style" "t" "es_win,my_b_f" "0" "1" "0" "_N" "_N" "_N")))
  (princ msg-03)
  (princ (tblsearch "style" "t")))

