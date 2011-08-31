;;;;;;("bl_pur" "not defined" "not defined")
(defun c:bl_pur(/ b_p)
  (setq
    b_p (getvar "insbase")
    name (getvar "dwgname")
  )
  (command "_wblock" name "_y" "" b_p "_all" "" "_open" "_y" "~")
)

