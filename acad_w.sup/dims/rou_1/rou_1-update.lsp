(defun rou_1-update_ver_rou  (stp_lst / bak0 cur)
;;; Обновить версию для шероховатости.
  (setq	bak0 (mapcar (function car) rou_1-setup_lst_bak0)
	cur  (mapcar (function car) stp_lst))
  (cond	((equal cur bak0)
	 (setq
	   stp_lst (list (list "rb_1_Ra" "1")
			 (list "rb_1_Rz" "0")
			 (list "pl_1_RaRz" "1" (list "1" "2" "3" "4"))
			 (append (list "tgl_1_max_val") (cdr (assoc "tgl_1_11" stp_lst)))
			 (append (list "eb_1_max_val") (cdr (assoc "eb_1_1" stp_lst)))
			 (append (list "pl_1_max_val") (cdr (assoc "pl_1_1" stp_lst)))
			 (list "tgl_1_min_val" "0")
			 (list "eb_1_min_val" "5")
			 (list "pl_1_min_val"
			       "4"
			       (list "80" "40" "20" "10" "5" "2,5" "1,25" "0,63" "0,32" "0,16" "0,08"))
			 (append (list "tgl_1_spos_pol") (cdr (assoc "tgl_1_12" stp_lst)))
			 (append (list "eb_1_spos_pol") (cdr (assoc "eb_1_2" stp_lst)))
			 (append (list "pl_1_spos_pol") (cdr (assoc "pl_1_2" stp_lst)))
			 (append (list "rb_1_osn_ml_sn") (cdr (assoc "rb_1_1" stp_lst)))
			 (append (list "rb_1_osn_ml_nesn") (cdr (assoc "rb_1_2" stp_lst)))
			 (append (list "rb_1_osn_ml_neobr") (cdr (assoc "rb_1_3" stp_lst)))
			 (list "rb_1_bez_sk"
			       (cond ((= "0" (cadr (assoc "tgl_1_1" stp_lst))) "1")
				     (T "0")))
			 (list "rb_1_kr_sk"
			       (cond ((= "1" (cadr (assoc "tgl_1_1" stp_lst))) "1")
				     (T "0")))
			 (list "rb_1_kv_sk" "0")
			 (append (list "tgl_1_po_konturu") (cdr (assoc "tgl_1_2" stp_lst)))
			 (append (list "tgl_1_perevern") (cdr (assoc "tgl_1_3" stp_lst)))
			 (list "tgl_1_napr_miko_ner" "0")
			 (append (list "pl_1_napr_miko_ner") (cdr (assoc "ppl_1_1" stp_lst)))
			 (append (list "eb_1_masht") (cdr (assoc "eb_1_3" stp_lst)))
			 (list "pl_1_masht"
			       "11"
			       (list "100:1"   "50:1"	 "40:1"	   "25:1"    "20:1"    "15:1"
				     "10:1"    "5:1"	 "4:1"	   "2.5:1"   "2:1"     "1:1"
				     "1:2"     "1:2.5"	 "1:4"	   "1:5"     "1:10"    "1:15"
				     "1:20"    "1:25"	 "1:40"	   "1:50"    "1:100"))
			 (append (list "error") (cdr (assoc "error" stp_lst)))))))
  stp_lst)