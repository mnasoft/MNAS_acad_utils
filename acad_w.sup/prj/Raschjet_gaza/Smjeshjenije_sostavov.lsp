(defun �����[����.����_������] (g_������[i] / temp g g[i] ���� ���������� ������[i])
  (setq	g[i]	   (��������_��_���� (mapcar (function car) g_������[i]))
	������[i]  (mapcar (function cadr) g_������[i])
	���������� (bin_or
		     (apply
		       (function append)
		       (mapcar
			 (function ���������_1...n)
			 (mapcar (function cadr) g_������[i])
		       )
		     )
		   )
	���������� (reverse ����������)
	����	   (mapcar
		     (function
		       (lambda (g ������)
			 (mapcar (function (lambda (el) (* g (cdr el))))
				 (����_����_1...n ���������� ������)
			 )
		       )
		     )
		     g[i]
		     ������[i]
		   )
  )
  (while (car ����)
    (setq temp (append temp (list (apply (function +) (mapcar (function car)����)))))
    (setq ���� (mapcar (function cdr)����))
  )
  (setq ���� temp)
  (mapcar (function cons) ���������� ����)
)
;|�Visual LISP� Format Options�
(72 2 5 2 nil "end of" 60 15 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
