(defun get(key)
  (setq tmp (atof(get_tile key)))
  (set_tile key (rtos tmp))
  tmp
)

(defun put (key val)
  (set_tile key (rtos val))
)

(defun D1()
  (put "D1" (+(get "d") (get "D")))
)

(defun D()
  (put "D" (-(get "D1") (get "d")))
)

(defun i ()
  (put "i" (/ (get "D") (get "d")))
)

(defun L0 ()
  (put "L0" (+ (* (get "n" ) (get "t")) (* 1.5 (get "d"))))
)

(defun L4 ()
  (put "L4" (* (+ (get "n") 1.5) (get "d")))
)

(defun action_d	()
  (D1)
  (L4)
  (L0) 
)
;|«Visual LISP© Format Options»
(72 2 25 2 nil "end of" 60 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
