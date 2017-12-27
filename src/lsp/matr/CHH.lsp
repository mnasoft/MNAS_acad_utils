;;;;;;("chh" "Команда для изменения свойств примитива основываясь на DXF кодах." "Измени")
(defun c:chh (/ kw var str codes ed)
     ;Команда для изменения свойств примитива основываясь на DXF кодах.
  (setq	ed    (entget (car (entsel)))
	codes (cddr (mapcar 'car ed))
	str   ""
  )
  (mapcar
    (function
      (lambda (el)
       (if (/= el 100)
	 (setq str (strcat str (itoa el) " "))
       )
     ))
    codes
  )
  (setq str (strcat str "eXit"))
  (while (/= kw "eXit")
    (initget str)
    (setq kw (getkword (strcat "\n" str " :")))

    (cond
      ((= kw "210")
       (setq var (getpoint "Направление выдавливания:"))
       (setq ed (subst (cons 210 var) (assoc 210 ed) ed))
       (entmod ed)
      )

      ((= kw "10")
       (setq var (getpoint "Направление 10:"))
       (setq ed (subst (cons 10 var) (assoc 10 ed) ed))
       (entmod ed)
      )

      ((= kw "11")
       (setq var (getpoint "Направление 11:"))
       (setq ed (subst (cons 11 var) (assoc 11 ed) ed))
       (entmod ed)
      )

      ((= kw "50")
       (setq var (getangle "Угол в системе координат:"))
       (setq ed (subst (cons 50 var) (assoc 50 ed) ed))
       (entmod ed)
      )
    )
  )
)
;|«Visual LISP© Format Options»
(72 2 5 2 nil "end of" 60 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
