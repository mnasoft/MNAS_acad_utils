;;;;;;("welding" "���������� ����������� ��������� ����. �� ���������." "�������")
(defun c:welding (/ wt_exit_dialog)
  (setq	arrow_dcl_id
	 (load_dialog
	   (strcat (acad_sup) "/DIMS/welding/welding.dcl")
	 )
  )
  (if (< arrow_dcl_id 0)
    (exit)
  )
  (while (null wt_exit_dialog)
  (if (not (new_dialog "welding_text" arrow_dcl_id))
    (exit)
  )
  (wt:init)
  (wt:setup_ac)

  (setq act (start_dialog))
  (cond
    ((= act 0)  (setq wt_exit_dialog t ))
    ((= act 1) (setq wt_exit_dialog t ))
    ((= act 2) (princ "����������"))
    ((= act 3) (princ "���������"))
    ((= act 4) (princ "���������"))
    ((= act 5) (princ "�������"))
    ((= act 6) (princ "��������")(ac-��������))
  )
  )
  (unload_dialog arrow_dcl_id)
)

(defun wt:init ()
  (mapcar
    (function
      (lambda (el)
	(cond
	  (
	   (= 2 (length el))
	   (set_tile (car el) (cadr el))
	  )
	  (
	   (= 3 (length el))
	   (start_list (car el))
	   (mapcar (function add_list) (caddr el))
	   (end_list)
	   (set_tile (car el) (cadr el))
	  )
	)
      )
    )
    ll_welding_setup
  )
)


(defun wt:all_ac ()
  (setq
    ll_welding_setup
     (mapcar
       (function
	 (lambda (el)
	   (cond
	     (
	      (= 2 (length el))
	      (list (car el) (get_tile (car el)))
	     )
	     (
	      (= 3 (length el))
	      (list (car el) (get_tile (car el)) (caddr el))
	     )
	   )
	 )
       )
       ll_welding_setup
     )
  )
)

(defun wt:setup_ac ()
  (mapcar
    (function (lambda (el) (action_tile (car el) "(wt:all_ac)")))
    ll_welding_setup
  )
	   
  (action_tile "����������" "(done_dialog 2)")
  (action_tile "���������" "(done_dialog 3)")
  (action_tile "���������" "(done_dialog 4)")
  (action_tile "�������" "(done_dialog 5)")
  (action_tile "��������" "(done_dialog 6)")
)

(defun ac-��������(/ str_����������� str_�����������)
  (setq str_����������� "")
  (setq str_����������� "")
  (if (= "1"
	 (������_��������_��_�����
	   "wt:�����_���������"
	   ll_welding_setup
	 )
      )
    (setq str_�����������
	   (strcat str_�����������
		   (������_��������_��_�����
		     "wt:������_�����_���������p���"
		     ll_welding_setup
		   )
	   )
    )
  )
  (if (= "1"
	 (������_��������_��_�����
	   "wt:�����_���"
	   ll_welding_setup
	 )
      )
    (setq str_�����������
	   (strcat str_�����������
		   "-"
		   (������_��������_��_�����
		     "wt:������_�����_����"
		     ll_welding_setup
		   )
	   )
    )   
  )

  (if (= "1"
	 (������_��������_��_�����
	   "wt:����_������"
	   ll_welding_setup
	 )
      )
    (setq str_�����������
	   (strcat str_�����������
		   "-"
		   (������_��������_��_�����
		     "wt:������_����_������"
		     ll_welding_setup
		   )
	   )
    )   
  )  
  
  
  (setq	ll_welding_setup
	 (subst	(list "wt:�����������" str_�����������)
		(assoc "wt:�����������" ll_welding_setup)
		ll_welding_setup
	 )
  )

  
'(("wt:�����������" "")
  ("wt:�����������" "")
  ("wt:����_�������_��_�����" "1")
  ("wt:����_�������_������_�����" "0")
  ("wt:�������_�����������" "1")
  ("wt:�������_���������" "0")
  ("wt:��_�������_����������" "0")
  ("wt:��_�������_������������" "0")
  ("wt:��_�������_��_�����" "1")
  ("wt:���������_��" "0")
  ("wt:���������_���" "1")
  ("wt:�����_���������" "1")
  ("wt:������_�����_���������p���"
   "0"
   ("��� �" "��� �" "��� �" "��� �" "��� �")
  )
  ("wt:�����_���" "1")
  ("wt:������_�����_����"
   "0"
   ("�1"   "�2"	  "�3"	 "�4"	"�6"   "�7"   "�8"   "�9"   "�11"
    "�12"  "�15"  "�17"	 "�18"	"�20"  "�21"  "�25"  "�1"   "�3"
    "�4"   "�5"	  "�6"	 "�8"	"�9"   "�1"   "�2"   "�3"   "�4"
    "�6"   "�7"	  "�8"	 "�1"	"�2"
   )
  )
  ("wt:����_������" "1")
  ("wt:������_����_������" "0" ("�" "��" "���" "��" "��"))
  ("wt:�����_t" "0")
  ("wt:�����_eb" "1.5")
  ("wt:������_������_���_������"
   "0"
   ("��� ���. ��." "������. �����" "�����. �����.")
  )
  ("wt:������_�����_t" "0")
  ("wt:������_�����_eb" "20")
  ("wt:���������" "1")
  ("wt:������_���������" "0" ("I" "II" "III" "IV"))
  ("wt:��������" "1")
  ("wt:������_����������"
   "0"
   ("1"	"2" "3"	"4" "5"	"6" "7"	"8" "9"	"10" "11" "12" "13" "14" "15"
    "16" "17" "18")
  )
  ("wt:������_������_���_������"
   "0"
   ("��� ���. ��." "������. �����" "�����. �����.")
  )
  ("wt:������_�����_t" "0")
  ("wt:������_�����_eb" "20")
 )
)

(defun ������_��������_��_�����(���� ������-�������� / ����_������-�������� )
  (setq ����_������-�������� (assoc ���� ������-��������))
  (cond
    ((= 2 (length ����_������-��������))
      (cadr ����_������-��������)
    )
    ((= 3 (length ����_������-��������))
     (nth (atoi (cadr ����_������-��������))(caddr ����_������-��������))
    )
  )
)


'(("wg:����_���������_�������" "10.")
   ("wg:����_������_�������" "60.")
   ("wg:�����������_�������" "0")
   ("wg:������_������" "3.5")
   ("wg:�����_�����-�������_�����" "1.75")
   ("wg:�����_�����-������_�����" "1.75")
   ("wg:������_��_�������" "1.5")
 )
;|�Visual LISP� Format Options�
(72 2 5 2 nil "end of" 60 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
