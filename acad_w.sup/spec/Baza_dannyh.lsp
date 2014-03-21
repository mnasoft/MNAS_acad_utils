(defun ����_������  (/ ex_dialog action dcl_id)
  (setq	dcl_id
	 (load_dialog (findfile "acad_w.sup/������������/������.dcl")))
  (if (< dcl_id 0)
    (exit))
  (while (null ex_dialog)
    (if	(not (new_dialog "����_������" dcl_id))
      (exit))
    (����_������-setup_ac)
    (��_setup_dialog)
    (setq action (start_dialog))
    (cond ((= action 0) (setq ex_dialog t))
	  ((= action 1) (setq ex_dialog t))))
  (unload_dialog dcl_id))

(defun ����_������-setup_ac  ()
  (action_tile "help" "(��_ac_1_help)")
  (action_tile "info" "(��_ac_1_info)")
  (action_tile "b_5_1" "(��_ac_b_5_1)")
  (action_tile "b_5_2" "(��_ac_b_5_2)")
  (action_tile "b_5_3" "(��_ac_b_5_3)")
  (action_tile "b_5_4" "(��_ac_b_5_4)")
  (action_tile "b_5_5" "(��_ac_b_5_5)")
  (action_tile "l_5_1" "(��_ac_l_5_1 $value)"))

(defun ��_ac_l_5_1  (val)
  (���������_������...��������
    (nth (atoi val) ��_������������)))

(defun ���������_������...��������  (������)
  (set_tile "e_5_6" (cdr (assoc 3 ������)))
;;;������
  (set_tile "e_5_7" (cdr (assoc 1 ������)))
;;;�����������
  (set_tile "e_5_8" (cdr (assoc 2 ������)))
;;;������������
  (set_tile "e_5_9" (cdr (assoc 4 ������)))
;;;��������
  (set_tile "e_5_10" (cdr (assoc 5 ������)))
;;;����������
  (set_tile "e_5_11" (cdr (assoc 6 ������)))
;;;��������
  )



;;;  : edit_box  { label="����������"; key="e_5_9";}
;;;   : edit_box  { label="��������"; key="e_5_10";}

(defun ��_ac_1_help  ()
  (alert
    "���������� ������� �.�.,\nsite: http://www.mnasoft.mksat.net"))

(defun ��_ac_1_info  ()
  (alert
    "���������� ������� �.�.,\nsite: http://www.mnasoft.mksat.net"))


(defun ��_ac_b_5_1 () (alert "��������"))
(defun ��_ac_b_5_2 () (alert "�������"))

(defun ��_ac_b_5_3 () (alert "��������"))

(defun ��_ac_b_5_4 () (alert "���. ������"))

(defun ��_ac_b_5_5 () (alert "���������"))

(defun ��_setup_dialog	(/ str_in_l_box)
  (load (findfile "acad_w.sup/spec/bd_naimjenovanije.lsp"))
  (setq	str_in_l_box
	 (mapcar (function (lambda (el)
			     (setq �������.   (cdr (assoc 1 el))
				   ����.      (cdr (assoc 2 el))
				   ������     (cdr (assoc 3 el))
				   ��������   (cdr (assoc 4 el))
				   ���������� (cdr (assoc 5 el))
				   ��������   (cdr (assoc 6 el)))
			     (strcat ������    "\t"	 �������.
				     "\t"      ����.	 "\t"
				     ��������  "\t"	 ����������
				     "\t"      ��������)))
		 ��_������������))
  (start_list "l_5_1")
  (mapcar 'add_list str_in_l_box)
  (end_list)) ;setup_dialog

(defun ��_��_�����������_�_����_������������  ()
  (setq	fn (getfiled "�������� ����� ��� ���������� � ���� ������������"
		     ""
		     "txt"
		     0)
	fl (open fn "r"))
  (cond	((/= 'str (type fn))
	 (alert (princ "���������� fn �� �������� ����� �����.")))
	((null fl)
	 (alert (princ (strcat "�� ���� ������� ����: " fn ".")))
	 (exit)))
  (while (setq str (read-line fl))
    (setq l_str	(str_token str "|")
	  l_str	(mapcar	(function (lambda (el / str1)
				    (setq str1 el
					  str1 (vl-string-right-trim " " str1)
					  str1 (vl-string-left-trim " " str1))))
			l_str))
    (setq ������		 (nth 0 l_str)
	  ������������		 (nth 1 l_str)
	  �����������		 (nth 2 l_str)
	  ������������		 (nth 3 l_str)
	  ���-��		 (nth 4 l_str)
	  ����������		 (nth 5 l_str)
	  ��������		 (cond ((nth 6 l_str))
				       (t ""))
	  ������_��_������������ (list (cons 1 �����������)
				       (cons 2 ������������)
				       (cons 3 ������)
				       (cons 4 ��������)
				       (cons 5 ����������)
				       (cons 6 ""))
	  ��_������������	 (append ��_������������
					 (list ������_��_������������))))
  (close fl))

(defun ��_��_�����������_�_����_������������ () t)
