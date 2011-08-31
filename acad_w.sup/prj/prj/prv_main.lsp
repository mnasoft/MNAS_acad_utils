;;;;;;("prv_main"
;;;;;;"
;;;;;;��������� ������ ��� ������� � ���� C:/Acad.mnu/acad_setup/VLISP_make_prv.js,\n
;;;;;;�������� ��� �������� �������������� prv-�������� prv.\n
;;;;;;�������� � ����������.\n
;;;;;;1) ��������� ��������� ������� Shell ��� ��������, ����������� ����� prv-��������:\n
;;;;;;DIR /S /B *.prv >list_prv\n
;;;;;;2) ��������� ������� prv_main. � ��������� ���� �������� ������������ ����� ���� list_prv.\n
;;;;;;� ���������� ���������� ������� �� ������� ACAD ����� ������� ������ ������,\n
;;;;;;���������� ������ ����� ������ ��������. ����� ������ ����� ��������� � ������� � ��������� ��� ����� �������.\n
;;;;;;3) ���������� ��������� ������ �� ������� ACAD � ���� C:/Acad.mnu/acad_setup/VLISP_make_prv.js.
;;;;;;4) ��������� �� ���������� C:/Acad.mnu/acad_setup/VLISP_make_prv.js.
;;;;;;5) ��������� � ������� Visual Lisp ������� (make_lst g:fn_full_prj_lst).
;;;;;;" "not defined")

(defun c:prv_main (/ fn_list_prj do fl_list_prj path)
  (setq	fn_list_prj (getfiled "�������� ����, ���������� �������" (strcat (acad_sup) "/list_prv") "" 0)
	fl_list_prj (open fn_list_prj "r")
	do t
  )
  (cond
    ((/= 'str (type fn_list_prj))
     (alert (princ "���������� fn_list_prj �� �������� ����� �����."))
    )
    ((null fl_list_prj)
     (alert
       (princ
	 (strcat "�� ���� ������� ����: " fn_list_prj ".")
       )
     )
     (exit)
    )
  )
  (while (setq path (READ-LINE fl_list_prj))
    (princ "    MakePrv(")
    (prin1 path)
    (princ ");\n")
  )
  (close fl_list_prj)
  (princ)
)
