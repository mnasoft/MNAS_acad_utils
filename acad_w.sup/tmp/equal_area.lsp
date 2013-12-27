;;;f;;;("equal_area_radius_n"  "����� ������ ����� ������������ �������� rb � ����������� �������� rm �� n ������������ �� ������� ������ � ������� �� �������.
;;;f;;; 
;;;f;;; rb > rm.
;;;f;;; �������, ��� ���� ����� ���������� ������� ��� ���������� 5-�� �������� ��� rm=802.0;   rb 871.5.
;;;f;;; ���������� ��������� ���������:
;;;f;;;(equal_area_radius_n 871.5 802.0 5)
;;;f;;;")
(defun equal_area_radius_n
			   (rb		; ������������ ������
			    rm		; ����������� ������
			    n		; ���������� ���������
			    / i	m rez_lst)
  (setq	m (* 2 n)
	i 1
  )
  (while (< i m)
    (setq
      rez_lst (cons (equal_area_radius rb rm i m) rez_lst)
      i	      (+ 2 i)
    )
  )
  rez_lst
)

;;;f;;;("equal_area_radius"
;;;f;;;  "����� ������ ����� ������������ �������� rb � ����������� �������� rm �� n ������������ �� ������� ������ � ������� i-����� ������.
;;;f;;; ��� �������� i=0 ��������� ���������� ������.
;;;f;;; ��� �������� i=n ��������� �������� ������.
;;;f;;; rb > rm.
;;;f;;; �������, ��� ���� ����� ���������� ������� ��� ���������� 5-�� �������� ��� rm=802.0;   rb 871.5.
;;;f;;; ���������� ��������� ���������:
;;;f;;; (equal_area_radius 871.5 802.0 1 10)
;;;f;;; (equal_area_radius 871.5 802.0 3 10)
;;;f;;; (equal_area_radius 871.5 802.0 5 10)
;;;f;;; (equal_area_radius 871.5 802.0 7 10)
;;;f;;; (equal_area_radius 871.5 802.0 9 10)"
;;;f;;;)
(defun equal_area_radius
			 (
			  rb		; ������������ ������
			  rm		; ����������� ������
			  i		; i-����� ������
			  n		; ���������� ���������
			 )
  (sqrt
    (+
      (* (- (* rb rb) (* rm rm)) i (/ 1.0 n))
      (* rm rm)
    )
  )
)

(defun equal_area_radius_n_mid
			       (rb	; ������������ ������
				rm	; ����������� ������
				n	; ���������� ���������
				/ i m rez_lst lst_1 lst_2)
  (setq
    i 0
  )
  (while (<= i n)
    (setq
      rez_lst (cons (equal_area_radius rb rm i n) rez_lst)
      i	      (1+ i)
    )
  )
  (setq
    lst_1 (cdr rez_lst)
    lst_2 (reverse (cdr (reverse rez_lst)))
  )
  (mapcar
    (function
      (lambda (el1 el2) (* 0.5 (+ el1 el2)))
    )
    lst_1
    lst_2
  )
)
;|�Visual LISP� Format Options�
(72 2 5 2 nil "end of" 60 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
