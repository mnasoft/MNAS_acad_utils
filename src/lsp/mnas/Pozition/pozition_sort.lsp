;;; ���������� ������� �� ��������������
(setq
  s_list '("�7203295...10 ��."		  "��02-0643...10 ��."		 "��6-694...10 ��."
	   "��7-177...10 ��.&A*16"	  "��7-203...12 ��.&A*16"	 "��02-0720...12 ��.&A*28"
	   "��6-702...6 ��."		  "��10-1483...6 ��."		 "P59038009...6 ��."
	   "��2-582...12 ��.&A*28"	  "��7-179...12 ��.&A*16"
	  )
)

;;;1. ������� �������� �� ������������ �������.
;;;1.1 ��� ������� � ��������� `&` � `@` ��������� �� ���� ������ �� �������������.
;;;2. ��������� ������ ������� �� ������ �� ���� ���������.
;;;3. ���������� ������ �������� �������� ������� ����������.
;;;3.1 ��������� �� ������ ������ ������, ������� �������, ������, ������ ������.
;;;3.1.1 ���� ����� ������������� ������� "123456789-ab" ��� "123456789"
;;;������ ������������� ������� 
;;;4. ���������� � ������ �� ���� ��������� ������� �������.
;;;5. ����� ������ ������� � ����.

(defun translate_string(str)
  ()
)

(setq en (car (entsel ":"))
      ed (entget en)
)
(setq
  ed
   (subst_dxf '(
		(300 . "300")
		(301 . "301")
		(302 . "302")
		(303 . "303")
		(304 . "304")
		(14 0.0 1.0 0.0)
		(15 0.0 1.0 0.0)
	       )
	      ed
   )
)
(entmod ed)
(91 . 2968)
;|�Visual LISP� Format Options�
(72 2 5 2 nil "end of" 60 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;