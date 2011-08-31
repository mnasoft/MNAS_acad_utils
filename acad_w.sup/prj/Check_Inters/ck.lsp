;;;;;;("ck_cl" "not defined" "not defined")
(defun c:ck_cl ()
  (setq
    set1 nil
    set2 nil
  )
)

;;;;;;("ck" "not defined" "not defined")
(defun c:ck()
  (if (null set1) (setq set1 (ssget)))
  (if (null set2) (setq set2 (ssget)))
	    (command "aminterfere" "No" set1 "" set2 "")
)
;|«Visual LISP© Format Options»
(72 2 5 2 nil "end of" 60 15 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
