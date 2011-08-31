;;	���������_������� (ff a b delta ll_par no) - ����� ����������� �������
;;	ff	- ������� ���������� ����������,
;;		������� �������� ������ ������������ �� ������� [a b];
;;	�	- ����� ������� ������� ������;
;;	b	- ������ ������� ������� ������;
;;	delta	- �������� � ������� ������������ ������;
;;	ll_par	- ������ ���������� �������;
;;	no	- ����� ��������� � ������, �������� �������� ������������
;;		�� ������� [a b], ������� ������ �������� �������� ������� ff � ����.
;;��������:
;;	(defun x3_y (x y)
;;	  (+ (* 3.0 x x x) (* 2.0 x x) 1.0 y)
;;	)
;;	(���������_������� x3_y -100. 100.0 0.005 '(0.6666 t) 2)

(defun ��������_��_������ (�� no ll / i)
  (setq i 0)
  (mapcar
    (function
      (lambda (el)
	(setq i (1+ i))
	(cond
	  ((= i no) ��)
	  ((/= i no) el)
	)
      )
    )
    ll
  )
)

(defun ���������_������� (ff a b delta ll_par no / FA FB FX X)
  (setq
    fa (apply (function ff) (��������_��_������ a no ll_par))
    fb (apply (function ff) (��������_��_������ b no ll_par))
  )
  (if (> (* fa fb) 0)
    (progn
      (princ "\n��� ������ ������� \n(���������_������� (")(princ " ")
      (princ ff)(princ " ")
      (princ a)
      (princ " ")
      (princ b)(princ " ")
      (princ delta)(princ " ")
      (princ ll_par)(princ " ")
      (princ no)(princ " ")
      (princ "))\n��� ������.")
      (exit)
    )
  )
  (while (> (abs(- b a)) delta)
    (setq
      x	 (* 0.5 (+ a b))
      fx (apply (function ff) (��������_��_������ x no ll_par))
    )
    (cond
      ((< (* fx fa) 0)
       (setq fb	fx
	     b	x
       )
      )
      ((> (* fx fa) 0)
       (setq fa	fx
	     a	x
       )
      )
      ((= 0.0 (* fx fa))
       (setq a	x
	     fa	fx
	     b	x
	     fb	fx
       )
      )
    )
  )
  (* 0.5 (+ a b))
)
;|�Visual LISP� Format Options�
(90 2 5 2 nil "end of" 60 30 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
