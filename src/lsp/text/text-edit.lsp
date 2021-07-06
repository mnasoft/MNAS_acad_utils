;;;;;;("de"
;;;;;;"Вызывает диалог для редактирования текста примитивов следуюших типов:
;;;;;;MTEXT, TEXT, DIMENSION." "Тексты")
(defun c:de  (/ en ed temp)
  (setq en   (car (entsel "\nВыберите примитив:"))
        ed  (entget en)
        temp (cdr (assoc 0 ed)))
  (cond ((or (= "MTEXT" temp) (= "TEXT" temp) (= "DIMENSION" temp)) (command-s "_ddedit" en))
        ((or (= "INSERT" temp)) (command-s "_ddatte" en)))
  (princ))


;;;;;;("ate" "Редактирование атрибута." "Тексты")
(defun c:ate  (/ en ed temp)
  (setq en   (car (nentsel "\nВыберите примитив:"))
        ed  (entget en)
        temp (cdr (assoc 0 ed)))
  (cond ((or (= "MTEXT" temp) (= "TEXT" temp) (= "DIMENSION" temp)) (command-s "_ddedit" en))
        ((or (= "ATTRIB" temp)) (command-s "_attedit" "_y" "*" "*" "*" en)))
  (princ))

;;;;;;("t-tr" "Выполняет транслитерацию с английской раскладки в русскую." "Редактирования текста"
;;;;;;)
(defun c:t-tr  (/ ed es len ss txt)
  (prompt "Выберите текст для преобразования кодировки.")
  (setq ss  (ssget)
        len (sslength ss))
  (while (<= 0 (setq len (1- len)))
    (setq es (ssname ss len))
    (setq ed (entget es))
    (setq txt (cdr (assoc 1 ed)))
    (if txt
      (progn (setq txt (vl-string-translate str_keyboard str_opchatka txt))
             (setq ed (subst (cons 1 txt) (assoc 1 ed) ed))
             (entmod ed)
             (entupd es)))))