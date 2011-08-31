(defun ai_ffile (app)
  (or (findfile (strcat app ".vlx"));;; ��������� ����
      (findfile (strcat app ".fas"));;; ��������� ����
      (findfile (strcat app ".lsp"))
      (findfile (strcat app ".exp"))
      (findfile (strcat app ".exe"))
      (findfile (strcat app ".arx"))
      (findfile app)
  )
)



(load (strcat (acad_sup) "/utils/acad_sup_dir"))
;;; ����� ����������� ����������.
;;; ����� ����������� ����������.

;;; ����������, ���������� � ������������ ���� ���������.
(load "c:/vlx/f_otv" )
;;; ����������, ���������� � ������������ ���� ���������.

(autoload "prj/������/zav_1" '("�����������"))

(autoload "���/������/������" '("������"))

(defun-q
  my_startup
  ()
  (princ "\nStart my_startup")
;  (setvar "ucsicon" 1)
  (princ "\t\tmy_startup End.")
  (princ)
)

(setq s::startup (append s::startup my_startup))
;|�Visual LISP� Format Options�
(105 2 25 2 nil "end of" 60 25 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
