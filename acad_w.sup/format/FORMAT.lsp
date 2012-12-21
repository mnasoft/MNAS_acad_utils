;;;(princ "\n�������� FORMAT/format       ")
(princ (strcat "\n�������� " (acad_sup) "/" "FORMAT/format       "))

;;;;;;("format" "���������� ��������� �����." "�������")
(defun c:format	(/ ;
		 f_key ;		������, ���������� ����� �������� ��������: ("1" "2" "2��" "2��" "2��" "2��" "3")
		 f_val ;		������, ���������� ������ ������������ �������� ��������.
		 sht1_key ;		�����  ����� � �������� �������
		 sht1_key2 ;		������������ ����� � �������� �������
		 kr_key ;		������, ���������� ���������� ��������� ��� �������� (������).
		 kr_val ;		������, ���������� ���������� ��������� ��� �������� (�������������).
		 for_name ;		������, ���������� ����� ��������.
		 for_val ;		������, ���������� ������� ��������.
		 reg_root ;		����� ������� ��� ������ ���������� ����������.
		 format_registry ;	������, ���������� �������� ���������� ������� �� ���������.
		 f_no;			������ �������� �������.
		 kr_no;			������ ��� ���������� ��������� �������.
		)
  (setq reg_root "HKEY_CURRENT_USER\\Software\\MNASoft\\Format")
  (setq	format_registry
	 '((p_start (0.0 0.0 0.0))
	   (sht1_val
	    ("���������� ����������"	       "�2�80009993��"
	     "�����.����. �80038002��"	       ""
	     ""		      ""	       ""
	     "1:1"	      ""	       "1"
	     "����"	      "��� ���"	       "�������   "
	     "�������   "     "������   "      "����������"
	     "�������   "     "������   "      ""
	     ""
	    )
	   )
	   (f_no 0)
	   (kr_no 0)
	   (for_no 1)
	   (dir_sht 1)
	   (divzone_no 1)
	   (zone_ch 65)
	   (zone_dig 1)
	  )
  )
  (load_format)
  (main_format)
  (princ)
)

(defun about ()
  (alert
    (strcat
      "������� ��������� �����"
      (about-GPL-string)
    )
  )
)


(defun load_format ()

  (reg_read_default_lst reg_root format_registry)

  (setq f_key (list "1" "2��" "2" "2��" "2�" "2��" "2��" "3")) ;��� ������

  (setq	f_val
	 (list
	   "1   \t������� � �����    \t����=1"
	   "2�� \t������� � �����    \t����=n"
	   "2   \t�����.������.���.  \t����=1"
	   "2�� \t�����.������.���.  \t����=n"
	   "2�  \t�����.������.���.  \t���.=1"
	   "2�� \t�����.������.���.  \t���.=(2*n+1)"
	   "2�� \t�����.������.���.  \t���.=(2*n) "
	   "3   \t������ �����       \t���.=��"
	  )
  )

  (setq for_name (list "�0" "�1" "�2" "�3" "�4"))
  (setq for_val '((1188 840) (840 594) (594 420) (420 297) (297 210)))
  (setq kr_key (list "1" "3" "4" "5" "6" "7" "8" "9")) ;���������
  (setq kr_val (list 1 3 4 5 6 7 8 9))

  (setq
    sht1_key (list
	       "sht1_1"	      "sht1_2"	     "sht1_3"
	       "sht1_4_1"     "sht1_4_2"     "sht1_4_3"
	       "sht1_5"	      "sht1_6"	     "sht1_7"
	       "sht1_8"	      "sht1_9"	     "sht1_10"
	       "sht1_11_1"    "sht1_11_2"    "sht1_11_3"
	       "sht1_11_4"    "sht1_11_5"    "sht1_11_6"
	       "sht1_24"      "sht1_25"
	      )
  )
  (setq
    sht1_key2 (list
		"NAIMEN"      "OBOZNACH"    "MATERIAL"	  "L_1"
		"L_2"	      "L_3"	    "MASS"	  "MASHT"
		"PAPER"	      "PAPERS"	    "FACTORY"	  "RABOTA"
		"RAZRAB"      "PROVER"	    "TECHN_KONTROL"
		"NACH_PODR"   "NORMO_KONTR" "UTVERD"	  "SPRAV_NO"
		"PERV_PRIM"
	       )
  )
);defun load_format

(defun dir_ob (p1 p2 p3 / a1 a2)
     ;���������� ��������� ������������ �������� (p1->p2) � (p2->p3).
  (setq a1 (mapcar '- p2 p1))
  (setq a2 (mapcar '- p3 p2))
  (- (* (nth 0 a1) (nth 1 a2)) (* (nth 1 a1) (nth 0 a2)))
)

(defun assad (r1 r2 r3)
  (cond
    ((and (> r1 0.0) (> r2 0.0) (> r3 0.0)) 0)
    ((or (< r1 0.0) (< r2 0.0) (< r3 0.0)) 2)
    (
     (or
       (and (= r1 0.0) (>= r2 0.0) (>= r3 0.0))
       (and (= r2 0.0) (>= r1 0.0) (>= r3 0.0))
       (and (= r3 0.0) (>= r1 0.0) (>= r1 0.0))
     )
     1
    )
  )
)


(defun point_triang (p1 p2 p3 pt / d)
;;;���������� ��������� �� ����� pt ������ ������������ p1 p2 p3
;;;����������: ��������� ��� = 2 ;��������� �� ������� = 1 ; ������ = 0.
  (setq d (dir_ob p1 p2 p3))
  (cond
    ((= d 0.0) 2)
    ((> d 0.0)
     (assad (dir_ob p1 p2 pt)
	    (dir_ob p2 p3 pt)
	    (dir_ob p3 p1 pt)
     )
    )
    ((< d 0.0)
     (assad (dir_ob p2 p1 pt)
	    (dir_ob p3 p2 pt)
	    (dir_ob p1 p3 pt)
     )
    )
  )
)

(defun load_format_dcl ()
  (setq dcl_id (load_dialog (strcat (acad_sup) "/format/format.dcl")))
  (if (< dcl_id 0)
    (exit)
  )
)


(defun ac_ed_3 (/ f1 f_n)
  (reg_write_default_lst ; �� ������� ������������ �����
  ;(reg_write_lst  ; ; �� ������� ������������
    reg_root
    '((p_start (0.0 0.0 0.0))
      (sht1_val
       ("���������� ����������"		  "�2�80009993��"
	"�����.����. �80038002��"	  ""
	""		 ""		  ""
	"1:1"		 ""		  "1"
	"����"		 "��� ���"	  "�������   "
	"�������   "	 "������   "	  "����������"
	"�������   "	 "������   "	  ""
	""
       )
      )
      (f_no 0)
      (kr_no 0)
      (for_no 1)
      (dir_sht 1)
      (divzone_no 1)
      (zone_ch 65)
      (zone_dig 1)
     )
  );reg_write_default_lst
)

(defun zsht (k1 k2)
  (if (= str_1 k1)
    (entmod (subst (cons 1 k2) (assoc 1 ed) ed))
  )
)

;;;���������� ��������� ������
(defun zap_sht (en / str_1 ed enn do)
  (setq enn en)
  (setq do t)
  (while do
    (setq en (entnext en))
    (cond
      ((null en)
       (setq do nil)
      )
      ((= (cdr (assoc 0 (setq ed (entget en)))) "ATTRIB")
       (setq str_1 (cdr (assoc 2 ed)))
       (MAPCAR (function zsht) sht1_key2 sht1_val)
      )
      (t
       (setq do nil)
      )
    )
  )
  (entupd enn)
)

;;;���������� �������� FORMAT
(defun zap_form	(en / zsht str_1 ed do)
  (setq do t)
  (while do
    (setq en (entnext en))
    (cond
      ((null en)
       (setq do nil)
      )
      ((= (cdr (assoc 0 (entget en))) "ATTRIB")
       (setq str_1 (cdr (assoc 2 (setq ed (entget en)))))
       (if (= str_1 "FORMAT")
	 (progn
	   (if (= kr_no 0)
	     (entmod
	       (subst (cons 1 (nth for_no for_name)) (assoc 1 ed) ed)
	     )
	     (entmod
	       (subst
		 (cons
		   1
		   (strcat (nth for_no for_name) "x" (nth kr_no kr_key))
		 )
		 (assoc 1 ed)
		 ed
	       )
	     )
	   )
	   (entupd en)
	 )
       )
      )
      (t
       (setq do nil)
      )
    )
  )
)

(defun zval (k1 k2)
  (if (= str_1 k1)
    (cdr (assoc 1 ed))
    k2
  )
)

(defun zap_val (en / str_1 ed)
  (while
    (= (cdr (assoc 0 (entget (setq en (entnext en))))) "ATTRIB")
     (setq str_1 (cdr (assoc 2 (setq ed (entget en)))))
     (setq sht1_val (MAPCAR 'zval sht1_key2 sht1_val))
  )
)


(defun err (p) (print p) (setq *error* old_err) (princ))

(defun add_xdata (pick1 / i)
  (make_ublock pick1 p_start p_start)
  (command "_.erase" pick1 "")
  (princ "\n����� ���������.")
)


(defun F_sht1 (/ dcl_id)
  (load_format_dcl)
  (if (not (new_dialog "sht1" dcl_id))
    (exit)
  )
  (mapcar 'set_tile sht1_key sht1_val)
  (action_tile
    "accept"
    "(setq sht1_val(mapcar 'get_tile sht1_key) )(done_dialog)"
  )
  (start_dialog)
  (unload_dialog dcl_id)
)

;;; ������� ����� ������ �� ��������� ��������� �� en1 � �� ����� ����������� ��.
;;; ���� en1=nil � ����� ������ ���������� ��� �������� ��.
(defun ss_pick (en1 / ss1)
  (setq ss1 (ssadd))
  (if en1									;
    (setq en1 (entnext en1))
    (setq en1 (entnext))
  )
  (while en1
    (setq ss1 (ssadd en1 ss1)
	  en1 (entnext en1)
    )
  )
  ss1
)


(defun f_list_act_no (value)
  (setq f_no (atoi value))
)


(defun set_left	(/ for)
  (setq	for
	 (list
	   (nth 0 (nth for_no for_val))
	   (* (nth 1 (nth for_no for_val)) (nth kr_no kr_val))
	 )
  )
  (if (< (nth 0 for) (nth 1 for))
    (setq for (reverse for))
  )
  (if (= dir_sht 0)
    (setq for (reverse for))
  )
  (set_tile
    "format_text"
    (strcat
      "������ "
      (nth for_no for_name)
      "x"
      (nth kr_no kr_key)
      " = "
      (itoa (nth 0 for))
      " x "
      (itoa (nth 1 for))
    )
  )
  (if (= dir_sht 0)
    (set_tile "dir_sht" "����� �������� �������")
    (set_tile "dir_sht" "����� ������� �������")
  )
)

(defun draw_format ()
  (princ "\n������� ��������� ������...")
  (setq	for
	 (list
	   (nth 0 (nth for_no for_val))
	   (* (nth 1 (nth for_no for_val)) (nth kr_no kr_val))
	 )
  )
  (if (< (nth 0 for) (nth 1 for))
    (setq for (reverse for))
  )
  (if (= dir_sht 0)
    (setq for (reverse for))
  )
  (draw_rect for p_start 7)
  (cond
    ((= (nth f_no f_key) "2��")
     (draw_rect
       (mapcar '- for '(25.0 10.0))
       (mapcar '+ '(5.0 5.0 0.0) p_start)
       1
     )
    )
    (t
     (draw_rect
       (mapcar '- for '(25.0 10.0))
       (mapcar '+ '(20.0 5.0 0.0) p_start)
       1
     )
    )
  )
)




(defun draw_rect (for p0 col)
  (draw_line
    (mapcar '+ (list (nth 0 for) (nth 1 for) 0.0) p0)
    (mapcar '+ (list (nth 0 for) 0.0 0.0) p0)
    col
  )
  (draw_line
    (mapcar '+ (list (nth 0 for) (nth 1 for) 0.0) p0)
    (mapcar '+ (list 0.0 (nth 1 for) 0.0) p0)
    col
  )
  (draw_line
    (mapcar '+ (list 0.0 0.0 0.0) p0)
    (mapcar '+ (list (nth 0 for) 0.0 0.0) p0)
    col
  )
  (draw_line
    (mapcar '+ (list 0.0 0.0 0.0) p0)
    (mapcar '+ (list 0.0 (nth 1 for) 0.0) p0)
    col
  )
)


(defun form_dlg	(/ for_n kr_n dir_sh dcl_id)
  (load_format_dcl)
  (if (not (new_dialog "form" dcl_id))
    (exit)
  )
  (setq	for_n  for_no
	kr_n   kr_no
	dir_sh dir_sht
  )
  (start_list "kr_list")
  (mapcar 'add_list kr_key)
  (end_list)
  (start_list "for_list")
  (mapcar 'add_list for_name)
  (end_list)
  (if
    (eq (not for) nil)
     (set_tile
       "razmer"
       (strcat
	 (itoa (nth 0 for))
	 " x "
	 (itoa (nth 1 for))
       )
     )
  )
  (set_tile "for_list" (itoa for_n))
  (set_tile "for_edit" (nth for_n for_name))
  (set_tile "kr_list" (itoa kr_n))
  (set_tile "kr_edit" (nth kr_n kr_key))
  (if (= dir_sh 0)
    (progn
      (set_tile "long_side" "0")
      (set_tile "short_side" "1")
    )
    (progn
      (set_tile "long_side" "1")
      (set_tile "short_side" "0")
    )
  )
  (action_tile "kr_list" "(kr_list_act $value)")
  (action_tile "for_list" "(for_list_act $value)")
  (action_tile "long_side" "(ls_side 1)")
  (action_tile "short_side" "(ls_side 0)")
  (action_tile "accept" "(sht_ok)")
  (start_dialog)
  (unload_dialog dcl_id)
  (princ)
)

(defun sht_ok ()
  (done_dialog)
  (setq	for_no	for_n
	kr_no	kr_n
	dir_sht	dir_sh
  )
  (set_left)
)

(defun ls_side (i) (setq dir_sh i) (raz))

(defun raz (/ for)
  (if
    (and (/= for_n nil) (/= kr_n nil))
     (progn
       (setq for
	      (list
		(nth 0 (nth for_n for_val))
		(* (nth 1 (nth for_n for_val)) (nth kr_n kr_val))
	      )
       )
       (if (< (nth 0 for) (nth 1 for))
	 (setq for (reverse for))
       )
       (if (= dir_sh 0)
	 (setq for (reverse for))
       )
       (set_tile
	 "razmer"
	 (strcat
	   (itoa (nth 0 for))
	   " x "
	   (itoa (nth 1 for))
	 )
       )
     )	  ;progn
  )
)

(defun for_list_act (value)
  (setq for_n (atoi value))
  (set_tile "for_edit" (nth (atoi value) for_name))
  (raz)
)

(defun kr_list_act (value)
  (setq kr_n (atoi value))
  (set_tile "kr_edit" (nth (atoi value) kr_key))
  (raz)
)

(defun ed_4_do (/)
  (setq ename (car (entsel "\n�������� ����� :")))
  (if (not (eq ename nil))
    (zap_val ename)
  )
)

(defun uk_point	()
  (setq p_start (getpoint "\n������� ����� :"))
  (if
    (eq p_start nil)
     (setq p_start (list 0.0 0.0 0.0))
  )
)

(defun uk_X0Y0 (/ x y)
  (setq x (atof (get_tile "X0")))
  (setq y (atof (get_tile "Y0")))
  (setq p_start (list x y 0.0))
  (set_tile "X0" (rtos x))
  (set_tile "Y0" (rtos y))
  (princ "x0y0")
)

(defun zone_ac ()
  (setq zone_ch (ascii (get_tile "z_A")))
  (if (or (< zone_ch 65) (> zone_ch 90))
    (setq zone_ch (ascii "A"))
  )
  (setq zone_dig (atoi (get_tile "z_1")))
  (if (<= zone_dig 0)
    (setq zone_dig 1)
  )
  (set_tile "z_1" (itoa zone_dig))
  (set_tile "z_A" (chr zone_ch))
)

(defun main_format (/ en1 pick3 old_err do_dialog dcl_id)
  (if (null (tblsearch "style" "t"))
    (stl)
  )
  (setvar "cmdecho" 0)
     ;(reg_read_default_lst reg_root dop_dlg_registry) ; �� ������� ������������
  (reg_read_lst reg_root dop_dlg_registry) ; �� ������� ������������
  (load_format_dcl)
  (setq do_dialog t)
  (while do_dialog
    (if	(not (new_dialog "sht_main" dcl_id))
      (exit)
    )
    (set_left)
    (set_tile "z_1" (itoa zone_dig))
    (set_tile "z_A" (chr zone_ch))
    (set_tile "sht_text" (nth f_no f_val))
    (set_tile "X0" (rtos (car p_start)))
    (set_tile "Y0" (rtos (cadr p_start)))
    (set_tile "sht_list" (itoa f_no))
    (start_list "sht_list")
    (mapcar 'add_list f_val)
    (end_list)
    (cond
      ((= divzone_no 1) (set_tile "Dz_y" "1"))
      ((= divzone_no 0) (set_tile "Dz_n" "1"))
    )
    (if	dsht_3_val
      (progn
	(start_list "dop_list")
	(mapcar 'add_list (mapcar 'car dsht_3_val))
	(end_list)
      )
    )
    (action_tile "sht_list" "(f_list_act_no $value)")
    (action_tile "Dz_y" "(setq divzone_no 1)")
    (action_tile "Dz_n" "(setq divzone_no 0)")
    (action_tile "z_A" "(zone_ac)")
    (action_tile "z_1" "(zone_ac)")
    (action_tile "format" "(form_dlg)")
    (action_tile "sht_type" "(F_forma)")
    (action_tile "cancel" "(done_dialog 0)")
    (action_tile "pick" "(done_dialog 2)")
    (action_tile "X0" "(uk_X0Y0)")
    (action_tile "Y0" "(uk_X0Y0)")
    (action_tile "ed_1" "(F_sht1)")
    (action_tile "ed_3" "(ac_ed_3)")
    (action_tile "ed_4" "(done_dialog 3)")
    (action_tile "dop_edit" "(done_dialog 5)")
    (action_tile "for_zap" "(done_dialog 6)")
    (action_tile "about" "(about)")
;;;(action_tile "help"   "(acad_helpdlg \"user.hlp\" \"dform\")")
    (setq action (start_dialog))
    (cond
      (
       (= action 1)
       (setq en1 (util:entlast))
       (draw_format)
       (if (= 1 divzone_no)
	 (setq pick3 (draw_zona))
	 (setq pick3 (ssadd))
       )
       (draw_shtamp)
       (setq s1 (nth f_no f_key))
       (cond
	 (
	  (and dsht_3_val
	       (or (= s1 "1")
		   (= s1 "2")
		   (= s1 "2��")
		   (= s1 "2��")
		   (= s1 "2��")
		   (= s1 "3")
	       )
	  )
	  (draw_dop_sht pick3)
	 )
	 ((= s1 "2��")
	  t
	 )
       )
       (add_xdata (ss_pick en1))
       (zap_sht (entlast))
       (zap_form (entlast))
       (setq do_dialog nil)
      )
      ((= action 0) (setq do_dialog nil))
      ((= action 2) (uk_point))
      ((= action 3) (ed_4_do))
      ((= action 5) (dop_dlg))
      ((= action 6)
       (zap_sht (car (entsel "\n������� ����� ��� ���������� :")))
       (setq do_dialog nil)
      )
    )
  )
  (unload_dialog dcl_id)
  (setq *error* old_err)
  (command "_.undo" "_end")
  (setvar "cmdecho" 1)
)
(princ "\t...��������.\n")
;|�Visual LISP� Format Options�
(72 2 5 2 nil "end of" 60 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
