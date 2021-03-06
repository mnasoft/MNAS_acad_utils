(setq ll_ras_har_lic
       (list (cons "P_kontr" 3.0)
             (cons "G_kontr" 240.0)
             (cons "Ro_kontr" 835.0)
             (cons "Ro" 835.0)
             (cons "dP_min" 0.0)
             (cons "dP_max" 3.0)
             (cons "var_name" "aaaa")
             (cons "n_div" 100)
             (cons "fl" 0)))

;;;;;;("ras_har_lic"
;;;;;;"Вычисление расходной характеристики жидкостной форсунки." "Расчеты")
(defun c:ras_har_lic  (/ act dcl_id)
  (setq dcl_id (load_dialog (findfile "acad_w.sup/fors_rh/fors_rh.dcl")))
  (if (< dcl_id 0)
    (exit))
  (if (not (new_dialog "fors_lic" dcl_id))
    (exit))
  (ras_har_lic:setup)
  (ras_har_lic:ac_tile)
  (setq act (start_dialog))
  (cond ((= act 0) (ras_har_lic:cancel))
        ((= act 1) (ras_har_lic:ok)))
  (unload_dialog dcl_id))

(setq ll_ras_har_lic
       (list (cons "P_kontr" 3.0)
             (cons "G_kontr" 240.0)
             (cons "Ro_kontr" 835.0)
             (cons "Ro" 835.0)
             (cons "dP_min" 0.0)
             (cons "dP_max" 3.0)
             (cons "var_name" "aaaa")
             (cons "n_div" 100)
             (cons "fl" 0)))


(defun ras_har_lic:setup  ()
  (setq p_kontr  (cdr (assoc "P_kontr" ll_ras_har_lic))
        g_kontr  (cdr (assoc "G_kontr" ll_ras_har_lic))
        ro_kontr (cdr (assoc "Ro_kontr" ll_ras_har_lic))
        ro       (cdr (assoc "Ro" ll_ras_har_lic))
        dp_min   (cdr (assoc "dP_min" ll_ras_har_lic))
        dp_max   (cdr (assoc "dP_max" ll_ras_har_lic))
        var_name (cdr (assoc "var_name" ll_ras_har_lic))
        n_div    (cdr (assoc "n_div" ll_ras_har_lic))
        fl       (cdr (assoc "fl" ll_ras_har_lic)))
  (set_tile "fors_lic:P_kontr" (rtos p_kontr))
  (set_tile "fors_lic:G_kontr" (rtos g_kontr))
  (set_tile "fors_lic:Ro_kontr" (rtos ro_kontr))
  (set_tile "fors_lic:Ro" (rtos ro))
  (set_tile "fors_lic:dP_min" (rtos dp_min))
  (set_tile "fors_lic:dP_max" (rtos dp_max))
  (set_tile "fors_lic:var_name" var_name)
  (set_tile "fors_lic:n_div" (itoa n_div))
  (cond ((= fl 0) (set_tile "fors_lic:fl_pr" "1"))
        ((= fl 1) (set_tile "fors_lic:fl_log" "1"))))

(defun ras_har_lic:cancel () (princ "\nras_har_lic:cancel"))

(defun ras_har_lic:ok  (/ ras)
  (princ "\nras_har_lic:ok")
  (setq ll_ras_har_lic
         (list (cons "P_kontr" p_kontr)
               (cons "G_kontr" g_kontr)
               (cons "Ro_kontr" ro_kontr)
               (cons "Ro" ro)
               (cons "dP_min" dp_min)
               (cons "dP_max" dp_max)
               (cons "var_name" var_name)
               (cons "n_div" n_div)
               (cons "fl" fl)))
  (vl-doc-set
    (read var_name)
    (mapcar (function (lambda (el) (list el (g{p/p_k_ro/ro_k_g_k} el p_kontr ro ro_kontr g_kontr))))
            (sub_div dp_min dp_max n_div fl))))

(defun g{p/p_k_ro/ro_k_g_k} (p p_k ro ro_k g_k) (* g_k (sqrt (* (/ ro ro_k) (/ p p_k)))))

(defun ras_har_lic:ac_tile  ()
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
  (action_tile "fors_lic:fl_log" "(ras_har_lic:ac-fl_log)"))


(defun ras_har_lic:ac-p_kontr  ()
  (princ "\nras_har_lic:ac-P_kontr")
  (setq p_kontr (atof (get_tile "fors_lic:P_kontr"))))

(defun ras_har_lic:ac-g_kontr  ()
  (princ "\nras_har_lic:ac-G_kontr")
  (setq g_kontr (atof (get_tile "fors_lic:G_kontr"))))

(defun ras_har_lic:ac-ro_kontr  ()
  (princ "\nras_har_lic:ac-Ro_kontr")
  (setq ro_kontr (atof (get_tile "fors_lic:Ro_kontr"))))

(defun ras_har_lic:ac-ro () (princ "\nras_har_lic:ac-Ro") (setq ro (atof (get_tile "fors_lic:Ro"))))

(defun ras_har_lic:ac-dp_min  ()
  (princ "\nras_har_lic:ac-dP_min")
  (setq dp_min (atof (get_tile "fors_lic:dP_min"))))

(defun ras_har_lic:ac-dp_max  ()
  (princ "\nras_har_lic:ac-dP_max")
  (setq dp_max (atof (get_tile "fors_lic:dP_max"))))

(defun ras_har_lic:ac-var_name  ()
  (princ "\nras_har_lic:ac-var_name")
  (setq var_name (get_tile "fors_lic:var_name")))

(defun ras_har_lic:ac-n_div  ()
  (princ "\nras_har_lic:ac-n_div")
  (setq n_div (atoi (get_tile "fors_lic:n_div"))))

(defun ras_har_lic:ac-fl_pr () (princ "\nras_har_lic:ac-fl_pr") (setq fl 0))

(defun ras_har_lic:ac-fl_log () (princ "\nras_har_lic:ac-fl_log") (setq fl 1))
