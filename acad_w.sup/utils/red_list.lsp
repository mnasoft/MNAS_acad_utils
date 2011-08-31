;;;(princ "\nЗагружаю utils/red_list      ")
(princ (strcat "\nЗагружаю " (acad_sup) "/" "utils/red_list      "))


;| Функции работы со списками для управления диалогами.			
									
	Замечания к проекту лучше написать аналогичные функции по:	
	1) вставке объекта в список после определенной позиции;		
	2) вставке  объекта в список перед определенной позицией;	
	3) обновлению определенной позиции в списке;			
	4) удалению позиции из списка;					
	5) обновлению списка;						
	("list_tile" "no" '("var_1" "var_2" "var_3" ... "var_n"))	
	не используя передачу данных по ссылке.				
	
|;

(setq red_list_lsp t)
	       
;;	prinf(str var f)	- Вывод в файл f значения переменной var под именем str.
;;	Для последующей загрузки переменной при помощи функции LOAD.
(defun prinf (str var f)
  (princ (strcat "(setq " str " '") f)
  (prin1 var f)
  (princ ")\n" f)
)

;;	ins_befor ($obj $no $li) 
;;	Вставка объекта $obj в список $li перед объектом c номером $no
;;	После вставки $no возрастает.
;;	Все парамерты передаются по ссылке.
;;	Например:
;;	(setq ob 45.0 no 1 li '(60. 70. 80. 90.))
;;      (ins_befor 'ob  'no 'li)
;;
;;	li = (60.0 45.0 70.0 80.0 90.0)
;;	no = 2
(defun ins_befor ($obj $no $li / $i $temp)
  (set
    $no
    (cond
      ((< (eval $no) 0) 0)
      ((and (>= (eval $no) 0) (<= (eval $no) (length (eval $li))))
       (eval $no)
      )
      ((> (eval $no) (length (eval $li))) (length (eval $li)))
      (T 0)
    )
  )
  (setq $i 0)
  (mapcar
    (function
      (lambda (el)
	(if (= $i (eval $no))
	  (setq $temp (cons (eval $obj) $temp))
	)
	(setq
	  $temp	(cons el $temp)
	  $i	(1+ $i)
	)
      )
    )
    (eval $li)
  )
  (if (= $i (eval $no))
    (setq $temp (cons (eval $obj) $temp))
  )
  (set $no (1+ (eval $no)))
  (set $li (reverse $temp))
)

;;ins_after  ($obj $no $li) 
;;	Вставка объекта $obj в список $li после объекта c номером $no
;;	После вставки $no возрастает.
;;	Все парамерты передаются по ссылке.
;;	Например:
;;	(setq ob 45.0 no 1 li '(60. 70. 80. 90.))
;;	(ins_after 'ob  'no 'li)
;;
;;	li = (60.0 70.0 45.0 80.0 90.0)
;;	no = 2
(defun ins_after ($obj $no $li / $i $temp)
  (set
    $no
    (cond
      ((< (eval $no) 0) 0)
      ((and (>= (eval $no) 0) (<= (eval $no) (length (eval $li))))
       (eval $no)
      )
      ((> (eval $no) (length (eval $li))) (length (eval $li)))
      (T 0)
    )
  )
  (setq $i 0)
  (mapcar
    (function
      (lambda (el)
	(setq $temp (cons el $temp))
	(if (= $i (eval $no))
	  (setq $temp (cons (eval $obj) $temp))
	)
	(setq $i (1+ $i))
      )
    )
    (eval $li)
  )
  (if (= $i (eval $no))
    (setq $temp (cons (eval $obj) $temp))
  )
  (set $no (1+ (eval $no)))
  (set $li (reverse $temp))
)

;;	del($no $li)	- Удаление объекта под номером $no из списка $li.
(defun del ($no $li / $i $temp)
  (setq $i 0)
  (mapcar
    (function
      (lambda (el)
	(if (/= $i (eval $no))
	  (setq $temp (cons el $temp))
	)
	(setq $i (1+ $i))
      )
    )
    (eval $li)
  )

  (set
    $no
    (cond
      ((< (eval $no) 0) 0)
      ((and (> (eval $no) 0) (< (eval $no) (length (eval $li))))
       (1- (eval $no))
      )
      ((>= (eval $no) (length (eval $li))) (length (eval $li)))
      ((null $temp) nil)
      (T 0)
    )
  )
  (set $li (reverse $temp))
)

;;	upd($obj $no $li)	- Замена объекта под номером $no из списка $li объектом $obj.
(defun upd ($obj $no $li / $i $temp)
  (setq $i 0)
  (mapcar
    (function
      (lambda (el)
	(if (= $i (eval $no))
	  (setq $temp (cons (eval $obj) $temp))
	  (setq $temp (cons el $temp))
	)
	(setq $i (1+ $i))
      )
    )
    (eval $li)
  )
  (set $li (reverse $temp))
)

(princ "\t...загружен.\n")
 ;|«Visual LISP© Format Options»
(72 2 5 2 nil "end of" 60 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
