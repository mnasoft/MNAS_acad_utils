;;;;;;("read_mea"
;;;;;;"Импортирование точек, заданных в формате mea (Измерительной машины MISTRAL)." "Обмен")
(defun c:read_mea (/ FL FN STR STR1 STR_X STR_Y STR_Z X Y Z)
  (setq
    fn (getfiled "Выбор имени файла для прорисовки точек:"
		 ""
		 "mea"
		 0
       )
    fl (open fn "r")
  )
  (if (null fl)
    (progn (alert (princ (strcat "Не могу открыть файл: " fn ".")))
	   (exit)
    )
  )
  (while
    (setq str (read-line fl))
     (setq str1 (car (str_token str " ")))
     (if (= str1 "#")
       (progn
	 (setq str_x (read-line fl)
	       x     (read (cadr (str_token str_x " ")))
	       str_y (read-line fl)
	       y     (read (cadr (str_token str_y " ")))
	       str_z (read-line fl)
	       z     (read (cadr (str_token str_z " ")))
	 )
	 (entmake
	   (list
	     (cons 0 "POINT")
	     (cons 10 (list x y z))
	   )
	 )
       )
     )
  )
  (close fl)
  (princ)
)
;|«Visual LISP© Format Options»
(72 2 5 2 nil "end of" 60 15 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
