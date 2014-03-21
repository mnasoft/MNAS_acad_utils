(defun func_1  (/ action fl_nm)
  (setup_dialog_f1)
  (setup_ac_f1)
  (setq action (start_dialog))
  (cond	((= action 0) (setq ex_dialog t))
	((= action 1)
	 (setq ex_dialog t
	       fl_nm	 (open (findfile "acad_w.sup/spec/Naimjenovanije.lsp") "w"))
	 (cond ((null fl_nm) (alert (princ (strcat "Íå ìîãó îòêðûòü ôàéë."))) (exit)))
	 (prinf "docum_lst" docum_lst fl_nm)
	 (close fl_nm)
	 (setq fl_nm (open (findfile "acad_w.sup/spec/Dialog_pozicija.lsp") "w"))
	 (cond ((null fl_nm) (alert (princ (strcat "Íå ìîãó îòêðûòü ôàéë."))) (exit)))
	 (prinf "dlg_1_kv" dlg_1_kv fl_nm)
	 (close fl_nm))
	((= action 2) (ac_b_1_5))
	((= action 3) (ac_b_1_6))
	((= action 4) (ac_b_1_8))
	((= action 5) (ac_b_1_9))
	((= action 6) (ac_b_1_7))
	((= action 7) (ac_b_1_10))
	((= action 8) (ac_b_1_11))))

(defun ac_1_info () (alert "Ðàçðàáîòàë Ìàòâååâ Í.À.,\nsite: http://www.mnasoft.mksat.net"))

(defun ac_1_help  ()
  (help (findfile "acad_w.sup/spec/Specification.ahp" "ñïåöèôèêàöèÿ_ïðîñòàíîâêà_ïîçèöèé")))

(defun ac_b_1_1	 (/ nam_1 lst_3)
  (setq nam_1 (mapcar 'cons nm_lst_1 val_lst_1))
  (if (= "1" (cdr (assoc "t_2_2" dlg_2_kv)))
    (f_naim_oboz))
  (cond	((and (= "1" (cdr (assoc "t_2_1" dlg_2_kv))) (= "1" (cdr (assoc "r_2_10" dlg_2_kv))))
	 (setq dlg_1_kv
		(subst
		  (cons "e_1_0" (strcat (cdr (assoc "e_1_7" dlg_1_kv)) "..." (cdr (assoc "e_1_9" dlg_1_kv)) "øò."))
		  (assoc "e_1_0" dlg_1_kv)
		  dlg_1_kv))
	 (set_tile "e_1_0" (cdr (assoc "e_1_0" dlg_1_kv))))
	((and (= "1" (cdr (assoc "t_2_1" dlg_2_kv))) (= "1" (cdr (assoc "r_2_11" dlg_2_kv))))
	 (setq dlg_1_kv (subst (cons "e_1_0" (cdr (assoc "e_1_6" dlg_1_kv))) (assoc "e_1_0" dlg_1_kv) dlg_1_kv))
	 (set_tile "e_1_0" (cdr (assoc "e_1_0" dlg_1_kv))))))

(defun ac_b_1_2 () nil)
(defun ac_b_1_3 () nil)
(defun ac_b_1_4 () nil)

(defun set_points  (/ p_dir)
  (cond	((= (cdr (assoc "r_2_2" dlg_2_kv)) "1")
	 (if (or (null line_p0) (null line_p1))
	   (ac_b_2_1))
	 (while (null p_start) (setq p_start (getpoint "\nÍà÷àëî âûíîñêè:")))
	 (while (null p_dir) (setq p_dir (getpoint p_start "\nÍàïðàâëåíèå:")))
	 (setq p_polka (inters p_start p_dir line_p0 line_p1 nil))
	 (while (null a_dir) (setq a_dir (getangle p_polka "\nÍàïðàâëåíèå ïîëêè:"))))
	(t
	 (while (null p_start) (setq p_start (getpoint "\nÍà÷àëî âûíîñêè:")))
	 (while (null p_polka) (setq p_polka (getpoint p_start "\nÍà÷àëî ïîëêè:")))
	 (while (null a_dir) (setq a_dir (getangle p_polka "\nÍàïðàâëåíèå ïîëêè:"))))))

(defun ac_b_1_5	 (/ bl_name tb a_st_pol a_napr a_delta poz_scale nm_lst pos_lst val_lst sc_lst atr_lst)
  (setq	val_lst	(mapcar	(function (lambda (e) (cdr (assoc e dlg_1_kv))))
			(list "e_1_0" "e_1_1" "e_1_2" "e_1_4" "e_1_5" "e_1_6" "e_1_7" "e_1_8" "e_1_9" "e_1_10"))
	nm_lst	(list "ÒÅÊÑÒ"	       "ÑÏÅÖÈÔÈÊÀÖÈß"	"ÂÀÐÈÀÍÒ"	 "ÔÎÐÌÀÒ"	  "ÇÎÍÀ"
		      "ÏÎÇÈÖÈß"	       "ÎÁÎÇÍÀ×ÅÍÈÅ"	"ÍÀÈÌÅÍÎÂÀÍÈÅ"	 "ÊÎËÈ×ÅÑÒÂÎ"	  "ÏÐÈÌÅ×ÀÍÈÅ")
	pos_lst	(list -0.5 1.0 2.0 3.0 4.0 5.0 6.0 7.0 8.0 9.0)
	sc_lst	(list 2.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0)
	atr_lst	(list 0 1 1 1 1 1 1 1 1 1))
  (set_points)
  (setq	poz_scale (atof (cdr (assoc "e_1_11" dlg_1_kv)))
	a_s_p	  (angle p_start p_polka)
	a_delta	  (- a_s_p a_dir))
  (cond	((and (>= a_delta (* pi 0.5)) (<= a_delta (* pi 1.5)))
	 (setq t_jast (cons 72 2)
	       a_napr (+ pi a_dir)))
	(t
	 (setq t_jast (cons 72 0)
	       a_napr a_dir)))
  (entmake (list (cons 0 "block") (cons 2 "*U") (cons 10 p_polka) (cons 70 1)))
  (cond	((= (cdr (assoc "p_1_2" dlg_1_kv)) "1")
	 (entmake (list (cons 0 "CIRCLE") (cons 10 p_start) (cons 40 (* poz_scale 0.5)) (s_col "i_4_1"))))
	((= (cdr (assoc "p_1_2" dlg_1_kv)) "2") (strela (/ 5. (/ 180. pi)) (* 5.0 poz_scale))))
  (entmake (list (cons 0 "LINE") (cons 10 p_start) (cons 11 p_polka) (s_col "i_4_2")))
  (setq tb (textbox (list (cons 1 (cdr (car dlg_1_kv))) (cons 7 "T") (cons 40 (* 7.0 poz_scale)))))
  (if (null tb)
    (setq tb '((0.0 0.0 0.0) (10.0 3.5 0.0))))
  (entmake (list (cons 0 "LINE")
		 (cons 10 p_polka)
		 (cons 11 (polar p_polka a_napr (+ (caadr tb) (* poz_scale 5.0))))
		 (s_col "i_4_3")))
  (setq bl_name (entmake (list (cons 0 "ENDBLK"))))
  (entmake (list (cons 0 "INSERT")
		 (cons 2 bl_name)
		 (cons 10 p_polka)
		 (cons 50 0.0)
		 (cons 41 1.0)
		 (cons 42 1.0)
		 (cons 43 1.0)
		 (cons 66 1) ; Çà áëîêîì ñëåäóþò àòðèáóòû
		 (list -3
		       (list "POZ_SPEC"
			     (cons 1002 "{")
			     (cons 1011 p_start)
			     (cons 1011 p_polka)
			     (cons 1070 (atoi (cdr (assoc "p_1_1" dlg_1_kv))))
			     (cons 1070 (atoi (cdr (assoc "p_1_2" dlg_1_kv))))
			     (cons 1041 (atof (cdr (assoc "e_1_11" dlg_1_kv))))
			     (cons 1002 "}")))))
  (mapcar
    (function
      (lambda (el_1 el_2 el_3 el_4 el_5)
	(entmake
	  (list	(cons 0 "ATTRIB")
		(cons 10
		      (polar (polar p_polka (+ a_dir (/ pi -2.0)) (* el_3 7.0 poz_scale)) a_napr (* poz_scale 3.5)))
		(cons 40 (* 3.5 poz_scale el_4))
		(cons 1 el_1)
		(cons 50 a_dir)
		(cons 7 "T")
		t_jast
		(cons 2 el_2)
		(s_col "i_4_4")
		(cons 11
		      (polar (polar p_polka (+ a_dir (/ pi -2.0)) (* el_3 7.0 poz_scale)) a_napr (* poz_scale 3.5)))
		(cons 70 el_5)))))
    val_lst
    nm_lst
    pos_lst
    sc_lst
    atr_lst)
  (entmake (list (cons 0 "SEQEND")))
  (redraw (setq en_ins (entlast)) 1)
  (setq	p_start	nil
	p_polka	nil)
  (redraw))


(defun ac_b_1_6	 (/ en ed txt atr key ass_lst xdata pt_sta pt_pol razdel_sp str_type masht)
  (setq	ass_lst	(mapcar	'cons
			(list "ÒÅÊÑÒ"	       "ÑÏÅÖÈÔÈÊÀÖÈß"	"ÂÀÐÈÀÍÒ"	 "ÔÎÐÌÀÒ"	  "ÇÎÍÀ"
			      "ÏÎÇÈÖÈß"	       "ÎÁÎÇÍÀ×ÅÍÈÅ"	"ÍÀÈÌÅÍÎÂÀÍÈÅ"	 "ÊÎËÈ×ÅÑÒÂÎ"	  "ÏÐÈÌÅ×ÀÍÈÅ")
			(list "e_1_0" "e_1_1" "e_1_2" "e_1_4" "e_1_5" "e_1_6" "e_1_7" "e_1_8" "e_1_9" "e_1_10")))
  (setq	en	  (car (entsel))
	en_ins	  en
	n_xdata	  (assoc "POZ_SPEC" (cdr (assoc -3 (entget en_ins (list "*")))))
	app_nm	  (car n_xdata)
	xdata	  (cdr n_xdata)
	pt_sta	  (cdr (nth 1 xdata))
	pt_pol	  (cdr (nth 2 xdata))
	razdel_sp (cdr (nth 3 xdata))
	str_type  (cdr (nth 4 xdata))
	masht	  (cdr (nth 5 xdata)))
  (if (= app_nm "POZ_SPEC")
    (progn (setq dlg_1_kv (subst (cons "e_1_11" (rtos masht)) (assoc "e_1_11" dlg_1_kv) dlg_1_kv)
		 dlg_1_kv (subst (cons "p_1_1" (itoa razdel_sp)) (assoc "p_1_1" dlg_1_kv) dlg_1_kv)
		 dlg_1_kv (subst (cons "p_1_2" (itoa str_type)) (assoc "p_1_2" dlg_1_kv) dlg_1_kv))
	   (while (and en xdata)
	     (setq en (entnext en))
	     (cond (en
		    (setq ed (entget en))
		    (if	(= (cdr (assoc 0 ed)) "ATTRIB")
		      (progn (setq txt	    (cdr (assoc 1 ed))
				   atr	    (cdr (assoc 2 ed))
				   key	    (cdr (assoc atr ass_lst))
				   dlg_1_kv (subst (cons key txt) (assoc key dlg_1_kv) dlg_1_kv)))
		      (setq en nil)))
		   (t))))))

(defun ac_b_1_7	 (/ en)
  (if en_ins
    (progn (setq en en_ins) (redraw en 3)))
  (ac_b_1_5)
  (if en
    (entdel en))
  (redraw))
(defun ac_b_1_8	 ()
  (if en_ins
    (entdel en_ins)))

(defun ac_b_1_9 () (setq num_dia 1))

(defun ac_b_1_10 () (setq num_dia 2))

(defun ac_b_1_11 () (setq num_dia 3))

(defun ac_dlg_1	 ($key $value / temp_1)
  (cond	((= $key "e_1_7")
	 (setq dlg_1_kv (subst (cons "e_1_8" "") (assoc "e_1_8" dlg_1_kv) dlg_1_kv))
	 (set_tile "e_1_8" (cdr (assoc "e_1_8" dlg_1_kv))))
	((= $key "e_1_11")
	 (setq temp_1 (atof $value)
	       $value (if (<= temp_1 0.0)
			"1"
			(rtos temp_1)))
	 (set_tile $key $value)))
  (setq dlg_1_kv (subst (cons $key $value) (assoc $key dlg_1_kv) dlg_1_kv)))

(defun setup_dialog_f1	()
  (start_list "p_1_1")
  (mapcar (function (lambda (e) (add_list e))) sp_razd_lst)
  (end_list)
  (mapcar (function (lambda (e) (set_tile (car e) (cdr e)))) dlg_1_kv))

(defun setup_ac_f1  ()
  (action_tile "help" "(ac_1_help)")
  (action_tile "info" "(ac_1_info)")
  (action_tile "b_1_1" "(ac_b_1_1)")
  (action_tile "b_1_5" "(done_dialog 2)")
  (action_tile "b_1_6" "(done_dialog 3)")
  (action_tile "b_1_7" "(done_dialog 6)")
  (action_tile "b_1_8" "(done_dialog 4)")
  (action_tile "b_1_9" "(done_dialog 5)")
  (action_tile "b_1_10" "(done_dialog 7)")
  (action_tile "b_1_11" "(done_dialog 8)")
  (mapcar (function (lambda (e) (action_tile (car e) "(ac_dlg_1 $key $value)"))) dlg_1_kv))
