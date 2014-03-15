;;;(princ "\nЗагружаю Clock/clock         ")
(princ (strcat "\nЗагружаю " (acad_sup) "/" "Clock/clock         "))

;;;;;;("clock_off" "Выключение часов." "not defined")
(defun c:clock_off()
  (if
    (/= (getvar "users1") "")
     (setvar "modemacro" (getvar "users1"))
     (setvar "modemacro" "")
  )
  (princ)
)

;;;;;;("clock_on" "Включение часов." "not defined")
(defun c:clock_on ()
  (if
    (/= (getvar "modemacro") "")
     (setvar "users1" (getvar "modemacro"))
     (setvar
       "users1"
       (strcat
	 " La $(substr,$(getvar,clayer),1,20)"
	 "$(if,$(getvar,orthomode), O)"
	 "$(if,$(getvar,snapmode), S)"
	 "$(if,$(getvar,tabmode), T)"
	 "$(if,$(=,$(getvar,tilemode),0),$(if,$(=,$(getvar,cvport),1), P))"
	)
     )
  )
  (setvar "modemacro"
	  (strcat
	    "$(eval,$(getvar,users1))"
     ;Сообщение в течение 10 мин
     ;set 123=Сообщение  с 12:30:00 до 12:39:59
	    "$(getenv,$(substr,$(edtime,$(getvar,date),HHMM),1,3))"
     ;Сообщение на день месяц
     ;set 1207=С днем рожденья Коля!
	    "$(getenv,$(edtime,$(getvar,date),DDMO))"
     ;Сообщение на определннный день недели в определенное время
     ;
	    "$(getenv,$(edtime,$(getvar,date),DDDHHMM))"
     ;Сообщение в формате HHMM
     ;set 1730=Сообщение
     ;     "$(getenv,$(edtime,$(getvar,date),HHMM))"
     ;Часы включаются каждую минуту на 10с
	    "$(if,"
	    "$(eq,$(substr,$(edtime,$(getvar,date),SS),1,1),0),"
	    "$(edtime,$(getvar,date),"
	    " DDD DD/MON/YYYY HH:MM:SS))"
	   ) ;strcat
  )  ;setvar
  (princ)
)

(princ "\t...загружен.\n")

;|«Visual LISP© Format Options»
(72 2 5 2 nil "end of" 60 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
