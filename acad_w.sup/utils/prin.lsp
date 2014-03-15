;;prins (str val)
;;	������� ��� � ������� ����������� �� �����.

;; util:entlast()
;;	���������� ��� ���������� ������������ ������������
;;	(������� ���������, ������� �����) � ���� ������
;;	��� nil ����, ����������� ���������� � ���� ������ ���.
;;	_$ (util:entlast)
;;	nil
;;	_$ (util:entlast)
;;	<Entity name: 14815a8>

(defun util:entlast  (/ tmp en)
  (setq	tmp (entlast)
	en  tmp)
  (while tmp
    (setq en  tmp
	  tmp (entnext tmp)))
  en)

;;prins (str val)
;;	������� ��� � ������� ����������� �� �����.
;;_$ (prins "lst_p1" 112.1323)
;;lst_p1 = 112.132
(defun prins (str val) (princ str) (princ " = ") (prin1 val) (princ))
