;;;(princ "\n�������� CIRCLES/Circles_2   ")
(princ (strcat "\n�������� " (acad_sup) "/" "CIRCLES/Circles_2   "))
	       
;;;;;;("c_ex" "���������� ���������� ���� ����������� ������� ��������." "���������")
(defun c:c_ex (/ rad c1 r1 c2 r2 en_c1 en_c2)
  (setq
    rad	(GETDIST "������� ������:")
    c1	(entget (car (entsel "����������:")))
    r1	(cdr (assoc 40 c1))
    c2	(entget (car (entsel "����������:")))
    r2	(cdr (assoc 40 c2))
    c1	(list (cons 0 "CIRCLE")
	      (assoc 10 c1)
	      (cons 40 (abs (- rad r1)))
	      (cons 62 55)
	)
    c2	(list (cons 0 "CIRCLE")
	      (assoc 10 c2)
	      (cons 40 (abs (- rad r2)))
	      (cons 62 55)
	)
  )
  (entmake c1)
  (setq en_c1 (entlast))
  (entmake c2)
  (setq en_c2 (entlast))
  (command "_circle" pause rad)
  (command "_erase" en_c1 en_c2 "")
)

;;;("c_sc" "��������������� ����������, ����� ������� ������ ���������������
;;; � �� ��������� �������.")
(defun c:c_sc (/ ed rad echo)
  (setq
    ed	(entget (car (entsel "����������:")))
    rad	(cdr (assoc 40 ed))
    pt	(getpoint "����� ���������������:")
  )
  (princ (strcat "\n������ ������ ="(rtos rad) "\n"))
  (setq echo (getvar "cmdecho"))
  (setvar "cmdecho" 0)
  (getvar "cmdech")
  (command "_scale"
	   (cdr (assoc -1 ed))
	   ""
	   "_non"
	   pt
	   "_r"
	   rad
	   pause
  )
  (setvar "cmdecho" echo)
)
(princ "\t...��������.\n")
;|�Visual LISP� Format Options�
(72 2 5 2 nil "end of" 60 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;