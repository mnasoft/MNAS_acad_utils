(setq
  setup_lst
   '(
     ("d" "1.0")	 ; ������� ���������, ��
     ("D1" "24.0")	 ; ������� ������� ��������, ��
     ("D" "23.0")	 ; ������� ������� �������, ��
     ("L0" "32")	 ; ������ ������� � ��������� ���������, ��
     ("L1" "30.0")	 ; ������ ������� ��� ��������������� ����������, ��
     ("L2" "25.0")	 ; ������ ������� ��� ������� ����������, ��
     ("L3" "22.0")	 ; ������ ������� ��� ������������ ����������, ��
     ("L4" "5.5")	 ; ������ ������� ��� ��������������� ������, ��
     ("S1" "30.0")	 ; ��������������� ���������� �������, ��
     ("S2" "25.0")	 ; ������� ���������� �������, ��
     ("S3" "22.0")	 ; ������������ ���������� �������, ��
     ("t" "8.125")	 ; ��� ������� � ��������� ���������, ��
     ("Sk" "0.5")	 ; ������� ����� �������� ����� �������, ��
     ("h" "10.0")	 ; ������� ��� �������, ��
     ("L" "200.0")	 ; ����� ��������� ����������� �������, ��
     ("n" "4.0")	 ; ����� ������ �������
     ("n1" "6.0")	 ; ������ ����� ������ �������
     ("i" "")		 ; ������ �������
     ("K1" "")		 ; �����������, ����������� ������� �������� �����
     ("K2" "")		 ; �����������, ����������� ������� ���������� ����
     ("F1" "")		 ; ���� ������� ��� ��������������� ����������, �
     ("F2" "")		 ; ���� ������� ��� ������� ����������, �
     ("F3" "")		 ; ���� ������� ��� ������������ ����������, �
     ("tau1" "")	 ; ���������� ��� �������� ��� ��������������� ����������, ���
     ("tau2" "")	 ; ���������� ��� �������� ��� ������� ����������, ���
     ("tau3" "")	 ; ���������� ��� �������� ��� ������������ ����������, ���
     ("[tau]" "640.0")	 ; ����������� ���������� ��� ��������
     ("C" "")		 ; ��������� �������, �/��
     ("G" "72600.0")	 ; ������ ������, ���
     ("i1" "")		 ; ��������� ����� ������� � ��������� ��������� � � �������� ��������
     ("m" "")		 ; ����� �������, ��
    )
)


(setq
  setup_msg
   '(
     ("d" "������� ���������, ��")
     ("D1" "������� ������� ��������, ��")
     ("D" "������� ������� �������, ��")
     ("L0" "������ ������� � ��������� ���������, ��")
     ("L1" "������ ������� ��� ��������������� ����������, ��")
     ("L2" "������ ������� ��� ������� ����������, ��")
     ("L3" "������ ������� ��� ������������ ����������, ��")
     ("L4" "������ ������� ��� ��������������� ������, ��")
     ("S1" "��������������� ���������� �������, ��")
     ("S2" "������� ���������� �������, ��")
     ("S3" "������������ ���������� �������, ��")
     ("t" "��� ������� � ��������� ���������, ��")
     ("Sk" "������� ����� �������� ����� �������, ��")
     ("h" "������� ��� �������, ��")
     ("L" "����� ��������� ����������� �������, ��")
     ("n" "����� ������ �������")
     ("n1" "������ ����� ������ �������")
     ("i" "������ �������")
     ("K1" "�����������, ����������� ������� �������� �����")
     ("K2" "�����������, ����������� ������� ���������� ����")
     ("F1" "���� ������� ��� ��������������� ����������, �")
     ("F2" "���� ������� ��� ������� ����������, �")
     ("F3" "���� ������� ��� ������������ ����������, �")
     ("tau1" "���������� ��� �������� ��� ��������������� ����������, ���")
     ("tau2" "���������� ��� �������� ��� ������� ����������, ���")
     ("tau3" "���������� ��� �������� ��� ������������ ����������, ���")
     ("[tau]" "����������� ���������� ��� ��������, ���")
     ("C" "��������� �������, �/��")
     ("G" "������ ������, ���")
     ("i1" "��������� ����� ������� � ��������� ��������� � � �������� ��������")
     ("m" "����� �������, ��")
    )
)

(defun c:spring ()
  (load_dcl "/prj/spring/Spring.DCL")
  (setq do_dialog t)
  (while do_dialog
    (if	(not (new_dialog "spring" dcl_id))
      (exit)
    )
    (init_dlg setup_lst)
    (action-tile_dlg-spring "setup_lst" "setup_lst")

    (action_tile "d" "(action_d)")
    (action_tile "D" "(actionD)")
    (action_tile "D1" "(actionD1)")

    (action_tile "n1" "(action_n1)")
    (action_tile "n" "(action_n)")
    (action_tile "t" "(action_t)")
    (action_tile "L0" "(actionL0)")

    (action_tile "S1" "(actionS1)")
    (action_tile "L1" "(actionL1)")
    (action_tile "S2" "(actionS2)")
    (action_tile "L2" "(actionL2)")
    (action_tile "S3" "(actionS3)")
    (action_tile "L3" "(actionL3)")
    (action_tile "G"  "(actionG)")

    (action_tile "about" "(about)")
    (action_tile "help"  "(help (strcat (acad_sup) \"/prj/spring/spring.html\"))")
    (action_tile "Print" "(Print_html)")
    (action_tile "Draw" "(done_dialog 2)")
    

    (setq action (start_dialog))
    (cond
      ((= action 0) (setq do_dialog nil))
      ((= action 1) (setq do_dialog nil))
      ((= action 2) (draw))
    )
  )
  (unload_dialog dcl_id)
;;;  (setq *error* old_err)
;;;  (command "_.undo" "_end")
;;;  (setvar "cmdecho" 1)
)

;;������� ��� ���������� ������ ���������� � ���������� setup_lst.
(defun stp_lst ()
  (setq setup_lst (action-save_dlg setup_lst))
)

;;������� ��������� ����������� ������ ����������� �� setup_lst
;;� ��������� ������ ������� (��� error) �������.
(defun action-tile_dlg-spring (@setup_lst @setup_lst_name)
  (mapcar
    (function (lambda (el)
		(action_tile
		  (car el)
		  (strcat "(err)"	    "(setq "
			  @setup_lst_name   " (action-save_dlg "
			  @setup_lst	    "))"
			 )
		)
	      )
    )
    (eval (read @setup_lst))
  )
)

(action-tile_dlg "setup_lst" "setup_lst")

(defun about ()
  (alert (strcat "������ ������� ������ " (about-GPL-string)))
)
;|�Visual LISP� Format Options�
(72 2 25 2 nil "end of" 60 9 0 0 0 T T nil T)
;*** �� ���������� ����� ��� �������������! ***|;