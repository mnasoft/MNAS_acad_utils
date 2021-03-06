(defun ep  (param / dcl_id do_dialog wid act)
  (ep:init)
  (setq dcl_id (load_dialog (findfile "acad_w.sup/axis/axis.dcl")))
  (if (< dcl_id 0)
    (exit))
  (setq do_dialog t)
  (while do_dialog
    (if (not (new_dialog "epline" dcl_id))
      (exit))
    (ep:setup)
    (setq act (start_dialog))
    (cond ((= act 0) (setq do_dialog nil))
          ((= act 1) (setq do_dialog nil))))
  (unload_dialog dcl_id))

(defun ep:init () (setq wid (cdr (assoc 40 param))))

(defun ep:setup () (set_tile "e41" (rtos wid)))
