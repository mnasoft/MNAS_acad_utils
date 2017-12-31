(setq �����_���������������_������_lsp t)
					;���������� ����� ��������� ������� f, ��������� �� ������ ����������

(defun spusk  (f			;	- ��� �������, ������������ �������� ������� ������������ 
	       x			;	- ������ ���������� � ������� �����
	       h			;	- ������ ���������� ��� ����� �� ������� �� ����������
	       k_u			;	- ������ ������������� �������� ��� ������� �� ���������� (�� > 1.0)
	       k_o			;	- ������ ������������� ���������� ��� ������� �� ���������� (�� < 1.0)
	       n_iter			;	- ���������� ���������
	       /     y			;	- �������� ������� ��� ���������� x
	       x_temp			;	- ������� ���������
	       y_temp			;	- �������� ������� ��� ���������� x_temp
	       iter			;	- ��������
	       i			;	- ����� ���������� �� ������� ������������ ����� (���������� �� 0 �� n-1)
	       n			;	- ���������� ����������
	       x+			;	- ������� ���������� ������ x_temp ��� ���� �� x �� i-���� ����������� � +
	       x-			;	- ������� ���������� ������ x_temp ��� ���� �� x �� i-���� ����������� � -
	       apl			;	- ��������� ���������� ������� ������� f ��� ���������� x_temp
	       h+			;	- ���������� ���������� ���� ��� i-���� ���������
	       h-			;	- ���������� ���������� ���� ��� i-���� ���������
	       y+			;	- �������� ������� � ��� ���������� x+
	       y-			;	- �������� ������� � ��� ���������� x-
	       )
  (defun apl () (setq y_temp (apply 'f x_temp)))
  (defun x+  (/
	      xx			;	- �������� i-���� ���������
	      hh			;	- ��� �� i-���� ���������
	      )
    (setq xx	 (nth i x)
	  hh	 (nth i h)
	  xx	 (+ xx hh)
	  x_temp x)
    (upd 'xx 'i 'x_temp))
  (defun x-  (/
	      xx			;	- �������� i-���� ���������
	      hh			;	- ��� �� i-���� ���������
	      )
    (setq xx	 (nth i x)
	  hh	 (nth i h)
	  xx	 (- xx hh)
	  x_temp x)
    (upd 'xx 'i 'x_temp))
  (defun h+  (/
	      hh			;	- ��� �� i-���� ���������
	      kk			;	- ����������� �������� �� i-���� ���������
	      )
    (setq hh (nth i h)
	  kk (nth i k_u)
	  hh (* hh kk))
    (upd 'hh 'i 'h))
  (defun h-  (/
	      hh			;	- ��� �� i-���� ���������
	      kk			;	- ����������� ���������� �� i-���� ���������
	      )
    (setq hh (nth i h)
	  kk (nth i k_o)
	  hh (* hh kk))
    (upd 'hh 'i 'h))
  (if (null red_list_lsp)
    (load (findfile (utils:path-src-lsp "UTILS/red_list.lsp"))))
  (setq	n      (length x)
	iter   0
	x_temp x
	y      (apl))
  (while (<= iter n_iter)
    (setq i 0)
    (while (< i n)
      (x+)
      (apl)
      (setq y+ y_temp)
      (x-)
      (apl)
      (setq y- y_temp)
      (cond ((<= y- y+)
	     (if (> y+ y)
	       (progn (x+)
		      (setq y y+
			    x x_temp)
		      (h+))
	       (h-))			;if 
	     )
	    ((> y- y+)
	     (if (> y- y)
	       (progn (x-)
		      (setq y y-
			    x x_temp)
		      (h+))
	       (h-))			;if
	     ))				;cond
      (setq i (1+ i)))			;while
    (setq iter (1+ iter)))		;while
  (princ "\niter= ")
  (prin1 iter)
  (princ " ")
  (princ "\ny= ")
  (prin1 y)
  (princ " ")
  (princ "\nx= ")
  (prin1 x)
  (princ " ")
  (princ "\nh= ")
  (prin1 h)
  (princ " ")
  x)
