(defun eb  (param / dcl_id do_dialog n-bl x-sc y-sc act)
  (eb:init)
  (setq dcl_id (load_dialog (findfile "acad_w.sup/axis/axis.dcl")))
  (if (< dcl_id 0)
    (exit))
  (setq do_dialog t)
  (while do_dialog
    (if (not (new_dialog "eblock" dcl_id))
      (exit))
    (eb:setup)
    (setq act (start_dialog))
    (cond ((= act 0) (setq do_dialog nil))
          ((= act 1) (setq do_dialog nil))))
  (unload_dialog dcl_id))

(defun eb:init  ()
  (setq n-bl (cdr (assoc 2 param))
        x-sc (cdr (assoc 40 param))
        y-sc (cdr (assoc 41 param))))

(defun eb:setup () (set_tile "e61" n-bl) (set_tile "e62" (rtos x-sc)) (set_tile "e63" (rtos y-sc)))
