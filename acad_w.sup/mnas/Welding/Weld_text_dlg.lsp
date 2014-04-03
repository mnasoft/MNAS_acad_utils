(defun c:ed-weld-txt (/ dcl_id en i ss_td str dcl_te_pos te_registry reg_root)
  (prompt "\nВыберите тексты или размеры :")
  (setq en (select) )
  (setq
    dcl_id (load_dialog (findfile "acad_w.sup/mnas/Welding/welding.dcl"))
  )

  (if (< dcl_id 0)    (exit)   )
  (if (not (new_dialog "mnas_weld_ch_text" dcl_id "" dcl_te_pos))    (exit)  )
  (setq	str
	 (cdr (assoc 300  ed))
	str_1
	 (cdr (assoc 301  ed))
  )
  (set_tile "dim_string" str)
  (set_tile "dim_string_1" str_1)
  
  (action_tile "accept" "(te_dlg_accept)")

  (start_dialog)
  (unload_dialog dcl_id)
  
  (ch_dxf (cdr (assoc -1 ed)) 300 str)
  (ch_dxf (cdr (assoc -1 ed)) 301 str_1)
)

(defun te_dlg_accept ()
  (setq str (get_tile "dim_string"))
  (setq str_1 (get_tile "dim_string_1"))
  (setq dcl_te_pos (done_dialog 0))
)

(defun c:est ()(c:ed-weld-txt))
;|«Visual LISP© Format Options»
(72 2 5 2 nil "end of" 60 15 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
