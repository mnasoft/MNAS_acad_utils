;;;(princ "\nÇàãğóæàş spec/func_4 ")
(princ (strcat "\nÇàãğóæàş " (acad_sup) "/" "spec/func_4 "))

(defun func_4 (/ fl_nm) ; Íàñòğîéêà öâåòîâ
  (setup_f4_dialog)
  (setup_f4_ac)
  (setq action_4 (start_dialog))
  (cond
    (
     (= action_4 0)
     (setq num_dia 0)
    )
    ((= action_4 1)
     (setq num_dia 0)
     (setq
       fl_nm (open
	       (strcat (acad_sup) "/spec/Dialog_Color.lsp")
	       "w"
	     )
     )
     (cond
       ((null fl_nm)
	(alert (princ (strcat "Íå ìîãó îòêğûòü ôàéë: " fn ".")))
	(exit)
       )
     )
     (prinf "dlg_4_kv" dlg_4_kv fl_nm)
     (close fl_nm)
    )
  )
)


(defun col_num_name (num)
  (if
    (/= 'int (type num))
     (setq num 0)
     (setq num (abs num))
  )
  (cond
    ((= num 0) "byblock")
    ((>= num 256) "bylayer")
    ((= num 1) "red")
    ((= num 2) "yellow")
    ((= num 3) "green")
    ((= num 4) "cyan")
    ((= num 5) "blue")
    ((= num 6) "magenta")
    ((= num 7) "white")
    ((and (> num 7) (< num 256)) (itoa num))
  )
)

(defun setup_f4_dialog ()
  (mapcar
    (function
      (lambda (el el2 / col)
	(setq col (cdr (assoc el dlg_4_kv)))
	(set_tile el2 (col_num_name col))
	(start_image el)
	(fill_image 0 0 (dimx_tile el) (dimy_tile el) col)
	(end_image)
      )
    )
    (list "i_4_1" "i_4_2" "i_4_3" "i_4_4")
    (list "t_4_1" "t_4_2" "t_4_3" "t_4_4")
  )
)


(defun set_color (ky / col)
  (setq	col
	 (acad_colordlg (cdr (assoc ky dlg_4_kv)))
  )		    ;setq

  (if col
    (progn
      (setq dlg_4_kv
	     (subst (cons ky col) (assoc ky dlg_4_kv) dlg_4_kv)
      )
      (setup_f4_dialog)
    )
  )

)

(defun setup_f4_ac ()
  (mapcar
    (function
      (lambda (el el2)
	(action_tile
	  el
	  (strcat "(set_color \"" el2 "\")")
	)
      )
    )
    (list "i_4_1" "i_4_2" "i_4_3" "i_4_4" "b_4_1" "b_4_2" "b_4_3"
	  "b_4_4")
    (list "i_4_1" "i_4_2" "i_4_3" "i_4_4" "i_4_1" "i_4_2" "i_4_3"
	  "i_4_4")
  )
)

(princ "\t...çàãğóæåí.\n")
;|«Visual LISP© Format Options»
(72 2 20 2 nil "end of" 60 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
