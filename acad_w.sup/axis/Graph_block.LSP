;;;(princ "\nЗагружаю Axis/Graph_block    ")
(princ (strcat "\nЗагружаю " (acad_sup) "/" "Axis/Graph_block    "))

(defun eb (param / dcl_id do_dialog n-bl x-sc y-sc)
  (eb:init)
  (setq dcl_id (load_dialog (strcat (acad_sup) "/axis/axis.dcl")))
  (if (< dcl_id 0)
    (exit)
  )
  (setq do_dialog t)
  (while do_dialog
    (if	(not (new_dialog "eblock" dcl_id))
      (exit)
    )
    (eb:setup)
    (setq act (start_dialog))
    (cond
      ((= act 0) (setq do_dialog nil))
      ((= act 1) (setq do_dialog nil))
    )
  )
  (unload_dialog dcl_id)
)

(defun eb:init ()
  (setq
    n-bl (cdr (assoc 2 param))
    x-sc (cdr (assoc 40 param))
    y-sc (cdr (assoc 41 param))
  )
)

(defun eb:setup	()
  (set_tile "e61" n-bl)
  (set_tile "e62" (rtos x-sc))
  (set_tile "e63" (rtos y-sc))
)


(princ "\t...загружен.\n")
;|«Visual LISP© Format Options»
(105 2 15 2 nil "end of" 90 15 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;