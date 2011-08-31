;;;(princ "\nЗагружаю Fors_rh/ras_har_lic")
(princ (strcat "\nЗагружаю " (acad_sup) "/" "Fors_rh/ras_har_lic"))

(setq
  ll_ras_har_lic
   (list
     (cons "P_kontr" 3.0)
     (cons "G_kontr" 240.0)
     (cons "Ro_kontr" 835.0)
     (cons "Ro" 835.0)
     (cons "dP_min" 0.0)
     (cons "dP_max" 3.0)
     (cons "var_name" "aaaa")
     (cons "n_div" 100)
     (cons "fl" 0)
   )
)

;;;;;;("ras_har_lic"
;;;;;;"Вычисление расходной характеристики жидкостной форсунки." "Расчеты")
(defun c:ras_har_lic(/ act dcl_id)
  (setq	dcl_id
	 (load_dialog (strcat (acad_sup) "/fors_rh/fors_rh.dcl"))
  )
  (if (< dcl_id 0)
    (exit)
  )
  (if (not (new_dialog "fors_lic" dcl_id))
    (exit)
  )
  (ras_har_lic:setup)
  (ras_har_lic:ac_tile)
  (setq act (start_dialog))
  (cond
    ((= act 0)     (ras_har_lic:cancel)    )
    ((= act 1)     (ras_har_lic:ok)    )
  )
  (unload_dialog dcl_id)
)

(setq
  ll_ras_har_lic
   (list
     (cons "P_kontr" 3.0)
     (cons "G_kontr" 240.0)
     (cons "Ro_kontr" 835.0)
     (cons "Ro" 835.0)
     (cons "dP_min" 0.0)
     (cons "dP_max" 3.0)
     (cons "var_name" "aaaa")
     (cons "n_div" 100)
     (cons "fl" 0)
   )
)


(defun ras_har_lic:setup ()
  (setq
    P_kontr  (cdr (assoc "P_kontr" ll_ras_har_lic))
    G_kontr  (cdr (assoc "G_kontr" ll_ras_har_lic))
    Ro_kontr (cdr (assoc "Ro_kontr" ll_ras_har_lic))
    Ro	     (cdr (assoc "Ro" ll_ras_har_lic))
    dP_min   (cdr (assoc "dP_min" ll_ras_har_lic))
    dP_max   (cdr (assoc "dP_max" ll_ras_har_lic))
    var_name (cdr (assoc "var_name" ll_ras_har_lic))
    n_div    (cdr (assoc "n_div" ll_ras_har_lic))
    fl	     (cdr (assoc "fl" ll_ras_har_lic))
  )

  (set_tile "fors_lic:P_kontr" (rtos P_kontr))
  (set_tile "fors_lic:G_kontr" (rtos G_kontr))
  (set_tile "fors_lic:Ro_kontr" (rtos Ro_kontr))
  (set_tile "fors_lic:Ro" (rtos Ro))
  (set_tile "fors_lic:dP_min" (rtos dP_min))
  (set_tile "fors_lic:dP_max" (rtos dP_max))
  (set_tile "fors_lic:var_name" var_name)
  (set_tile "fors_lic:n_div" (itoa n_div))
  (cond
    ((= fl 0) (set_tile "fors_lic:fl_pr" "1"))
    ((= fl 1) (set_tile "fors_lic:fl_log" "1"))
  )
)

(defun ras_har_lic:cancel ()
  (princ "\nras_har_lic:cancel")
)

(defun ras_har_lic:ok ( / ras)
  (princ "\nras_har_lic:ok")
  (setq
    ll_ras_har_lic
     (list
       (cons "P_kontr" P_kontr)
       (cons "G_kontr" G_kontr)
       (cons "Ro_kontr" Ro_kontr)
       (cons "Ro" Ro)
       (cons "dP_min" dP_min)
       (cons "dP_max" dP_max)
       (cons "var_name" var_name)
       (cons "n_div" n_div)
       (cons "fl" fl)
     )
  )
  (vl-doc-set
    (read var_name)
    (mapcar
      (function
	(lambda	(el)
	  (list el (G{P/P_k_Ro/Ro_k_G_k} el P_kontr Ro Ro_kontr G_kontr))
	)
      )
      (sub_div dP_min dP_max n_div fl)
    )
  )
)

(defun G{P/P_k_Ro/Ro_k_G_k} (P P_k Ro Ro_k G_k)
  (* G_k (sqrt (* (/ Ro Ro_k) (/ P P_k))))
)

(defun ras_har_lic:ac_tile ()
  (princ "\nras_har_lic:ac_tile")
  (action_tile "fors_lic:P_kontr" "(ras_har_lic:ac-P_kontr)")
  (action_tile "fors_lic:G_kontr" "(ras_har_lic:ac-G_kontr)")
  (action_tile "fors_lic:Ro_kontr" "(ras_har_lic:ac-Ro_kontr)")
  (action_tile "fors_lic:Ro" "(ras_har_lic:ac-Ro)")
  
  (action_tile "fors_lic:dP_min" "(ras_har_lic:ac-dP_min)")
  (action_tile "fors_lic:dP_max" "(ras_har_lic:ac-dP_max)")
  
  (action_tile "fors_lic:var_name" "(ras_har_lic:ac-var_name)")
  (action_tile "fors_lic:n_div" "(ras_har_lic:ac-n_div)")
  (action_tile "fors_lic:fl_pr" "(ras_har_lic:ac-fl_pr)")
  (action_tile "fors_lic:fl_log" "(ras_har_lic:ac-fl_log)")
)


(defun ras_har_lic:ac-P_kontr ()
  (princ "\nras_har_lic:ac-P_kontr")
  (setq	P_kontr (atof (get_tile "fors_lic:P_kontr"))
  )
)

(defun ras_har_lic:ac-G_kontr ()
  (princ "\nras_har_lic:ac-G_kontr")
  (setq	G_kontr (atof (get_tile "fors_lic:G_kontr"))
  )
)

(defun ras_har_lic:ac-Ro_kontr ()
  (princ "\nras_har_lic:ac-Ro_kontr")
  (setq	Ro_kontr (atof (get_tile "fors_lic:Ro_kontr"))
  )
)

(defun ras_har_lic:ac-Ro ()
  (princ "\nras_har_lic:ac-Ro")
  (setq	Ro (atof (get_tile "fors_lic:Ro"))
  )
)

(defun ras_har_lic:ac-dP_min()
  (princ "\nras_har_lic:ac-dP_min")
  (setq	dP_min (atof (get_tile "fors_lic:dP_min")))
)

(defun ras_har_lic:ac-dP_max ()
  (princ "\nras_har_lic:ac-dP_max")
  (setq dP_max (atof (get_tile "fors_lic:dP_max")))
)

(defun ras_har_lic:ac-var_name ()
  (princ "\nras_har_lic:ac-var_name")
  (setq var_name  (get_tile "fors_lic:var_name"))
)

(defun ras_har_lic:ac-n_div	()
  (princ "\nras_har_lic:ac-n_div")
  (setq n_div (atoi (get_tile "fors_lic:n_div")))
)

(defun ras_har_lic:ac-fl_pr()
  (princ "\nras_har_lic:ac-fl_pr")
  (setq fl 0)
)

(defun ras_har_lic:ac-fl_log()
  (princ "\nras_har_lic:ac-fl_log")
  (setq fl 1)
)

(princ "\t...загружен.\n")
;|«Visual LISP© Format Options»
(105 2 15 2 nil "end of" 90 15 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;