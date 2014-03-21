;;matr:name()	-	���������� ������ "Matr".

;;matr:idx (i j m)
;;��������� ������ (i,j) �������� ������� ������� ���������� � ����.
;;m-�������� �� �������� � �������.

;;matr:new(n m )
;; �������� ������� �������� n-����� �� m-��������.
;;_$ (matr:new 2 3)
;;("Matr" 2 3 ((0 . 0.0) (1 . 0.0) (2 . 0.0) (3 . 0.0) (4 . 0.0) (5 . 0.0)))

;;matr:row (matr)
;;���������� ���������� ����� � �������.
;;_$ (matr:row '("Matr" 2 3 ((0 . 0.0) (1 . 0.0) (2 . 0.0) (3 . 0.0) (4 . 0.0) (5 . 0.0))))
;;2

;;matr:col (matr)
;;���������� ���������� �������� � �������.
;;_$ (matr:col '("Matr" 2 3 ((0 . 0.0) (1 . 0.0) (2 . 0.0) (3 . 0.0) (4 . 0.0) (5 . 0.0))))
;;3

;;matr:ij(matr i j)
;; ������ � ij �������� ������� matr �������� ���������� � ����.

;;matr:set_ij (matr elem i j)
;;���������� �������� elem �������� ������� matr(i j) �������� ���������� � ����.

;;matr_eval (matr)
;;

;;matr_mult(a b)
;;������������ ������.

;;matr_to_point(matr)
;;������� ������� � �����
;;_$ (matr_to_point '("Matr" 1 3 ((0 . 1.0) (1 . 2.0) (2 . 3.0))))
;;(1.0 2.0 3.0)

;;point_to_matr (p )
;;������� ����� � �������:
;;_$ (point_to_matr '(10.0 11.0 12.0 13.0) )
;;("Matr" 1 4 ((0 . 10.0) (1 . 11.0) (2 . 12.0) (3 . 13.0)))

;;matr:mnk(vv ff ex_pts)
;;��������� ����� ��� ������� ������������� �� ������ ���������� ���������.
;;vv	- '(xx yy)
;;������ ��������� ���� �������� ������� � ����� ������� �������;
;;ff	- '(xx yy) '((xx xx) (xx) (1.0) (yy))
;;������ ��� �������������� �����������;
;;ex_pts - '((-1.0 1.0) (2.0 4.0) (3.0 9.0));
;;�������� �������� ������� � �������� ������� �������.

;;matr:triang(matr)
;; �������� �������  � ������������ ���� ������� (��� ������� ������� �� ������� ������).
;;_$ (matr:triang '("Matr" 3 4 ((0 . 1.0) (1 . 0.0) (2 . 1.0) (3 . 4.0) (4 . 0.0) (5 . 1.0) (6 . 0.0) (7 . 2.0) (8 . 0.0) (9 . 0.0) (10 . 1.0) (11 . 3.0))))
;;("Matr" 3 2 ((0 . 1.0) (1 . 0.0) (2 . 1.0) (3 . 4.0) (4 . 0.0) (5 . 1.0) (6 . 0.0) (7 . 2.0) (8 . 0.0) (9 . 0.0) (10 . 1.0) (11 . 3.0)))

;;matr:obrhod (matr)
;;�������� ��� ��� ���������� ������� ������� �������� ���������.
;;������� matr ������ ���� ��������� � ����������.

;|
matr:sys_lu (matr)
������� ������� �������� ��������� ������� ������.
������� ������� � ������� ������� �������� �������� �������������.

��������:
(matr:sys_lu  '("Matr" 3 4 ((0 . 2.0) (1 . 0.0) (2 . 2.0) (3 . 8.0) (4 . 0.0) (5 . 2.0) (6 . 0.0) (7 . 4.0) (8 . 2.0) (9 . 0.0) (10 . 3.0) (11 . 11.0))))

������� ����������� � ����������:
1.0 0.0 1.0 4.0 
0.0 1.0 0.0 2.0 
0.0 0.0 1.0 3.0 
����� ������� ���������:
1.0 2.0 3.0
("Matr" 1 3 ((0 . 1.0) (1 . 2.0) (2 . 3.0)))
|;
	       
(defun matr:name () "Matr")

(defun matr:idx (i j m) (+ (* i m) j))

(defun matr:row (matr) (cadr matr))

(defun matr:col (matr) (caddr matr))

(defun matr:set_row(matr i pts / j n m )
  (setq
    n (matr:row matr)
    m (matr:col matr)
    j 0
  )
  (while (< j m)
    (setq
      matr (matr:set_ij matr (nth j pts)i j)
      j	  (1+ j)
    )
  )
  matr
)

(defun matr:get_row (matr i / j n m pts)
  (setq
    n (matr:row matr)
    m (matr:col matr)
    j 0
  )
  (while (< j m)
    (setq
      pts (cons (matr:ij matr i j) pts)
      j	  (1+ j)
    )
  )
  (reverse pts)
)

(defun matr:set_col(matr j pts / i n m )
  (setq
    n (matr:row matr)
    m (matr:col matr)
    i 0
  )
  (while (< i n)
    (setq
      matr (matr:set_ij matr (nth i pts)i j)
      i	  (1+ i)
    )
  )
  matr
)

(defun matr:get_col (matr j / i n m pts)
  (setq
    n (matr:row matr)
    m (matr:col matr)
    i 0
  )
  (while (< i n)
    (setq
      pts (cons (matr:ij matr i j) pts)
      i	  (1+ i)
    )
  )
  (reverse pts)
)

(defun matr:new	(n m / size li)
  (setq size (* n m))
  (repeat size
    (setq
      size (1- size)
      li   (cons (cons size 0.0) li)
    )
  )
  (list (matr:name) n m li)
)

;;;����������.
(defun matr:new:lst (n m lst / size li)
  (setq size (* n m))
  (repeat size
    (setq
      size (1- size)
      li   (cons (cons size 0.0) li)
    )
  )
  (list (matr:name) n m li)
)


(defun matr:ind_err (i j n m)
  (strcat
    "������ ��� ������� � ��. �������:"
    "\nM[i,j] = M["
    (itoa i)
    ","
    (itoa j)
    "]"
    "\nn x m = "
    (itoa n)
    " x "
    (itoa m)
  )
)

(defun matr:ij (matr i j / n m li)
  (setq
    n  (cadr matr)
    m  (caddr matr)
    li (cadddr matr)
  )
  (cond
    (
     (or (< i 0) (>= i n))
     (alert (matr:ind_err i j n m))
    )
    (
     (or (< j 0) (>= j m))
     (alert (matr:ind_err i j n m))
    )
    (t
     (cdr (assoc (matr:idx i j m) li))
    )
  )
)

(defun matr:set_ij (matr elem i j / n m li)
  (setq
    n  (cadr matr)
    m  (caddr matr)
    li (cadddr matr)
    li (subst
	 (cons (matr:idx i j m) elem)
	 (assoc (matr:idx i j m) li)
	 li
       )
  )
  (list (matr:name) n m li)
)

(defun matr_eval (matr / n m li EL FUNC_START)
  (mapcar 'eval func_start)
  (setq
    n  (cadr matr)
    m  (caddr matr)
    li (cadddr matr)
    li (mapcar (function (lambda (el) (cons (car el) (eval (cdr el))))) li)
  )
  (list (matr:name) n m li)
)

(defun matr_mult (a b / a_n a_m a_n b_m a_li b_li i j k sum c_li)
  (setq
    a_n	 (cadr a)
    a_m	 (caddr a)
    a_li (cadddr a)

    b_n	 (cadr b)
    b_m	 (caddr b)
    b_li (cadddr b)
  )
  (cond
    (
     (/= a_m b_n)
     (alert
       (strcat
	 "����������� ������� ������ ���"
	 "\n ������������: A("
	 (itoa a_n)
	 " x "
	 (itoa a_m)
	 ") x B("
	 (itoa b_n)
	 " x "
	 (itoa b_m)
	 ")"
       )
     )
    )
  )

  (setq i a_n)
  (repeat a_n
    (setq i (1- i)
	  j b_m
    )
    (repeat b_m
      (setq j	(1- j)
	    k	a_m
	    sum	0.0
      )
      (repeat a_m
	(setq k	   (1- k)
	      a_el (cdr (assoc (matr:idx i k a_m) a_li))
	      b_el (cdr (assoc (matr:idx k j b_m) b_li))
	      sum  (+ sum (* a_el b_el))
	)
      )
      (setq c_li (cons (cons (matr:idx i j b_m) sum) c_li))
    )
  )
  (list (matr:name) a_n b_m c_li)
)

(defun matr_to_point (matr / n m li)
  (setq
    n  (cadr matr)
    m  (caddr matr)
    li (cadddr matr)
  )
  (mapcar 'cdr li)
)

(defun point_to_matr (p / i li n)
  (setq
    n (length p)
    i -1
  )
  (list
    (matr:name)
    1
    n
    (mapcar
      (function
	(lambda	(el)
	  (cons (setq i (1+ i)) el)
	)
      )
      p
    )
  )
)

(defun matr:print (matr / i j)
  (setq
    i 0
  )
  (while (< i (matr:row matr))
    (setq j 0)
    (princ "\n")
    (while (< j (matr:col matr))
      (princ (matr:ij matr i j))
      (princ " ")
      (setq j (1+ j))
    )
    (setq i (1+ i))
  )
  (princ)
)

(defun matr:mnk(vv ff ex_pts / mtr n m nv)
  (setq
    m	(length ff)
    n	(1- m)
    nv	(length vv)
    mtr	(matr:new n m)
  )
  (mapcar
    (function
      (lambda (el / i j)
	(setq i 0)
	(while (< i nv)
	  (set (nth i vv) (nth i el))
	  (setq i (1+ i))
	)
	(setq i 0)
	(while (< i n)
	  (setq j 0)
	  (while (< j m)
	    (setq
	      pr  (apply
		    '*
		    (mapcar
		      'eval
		      (append (nth i ff) (nth j ff))
		    )
		  )
	      mtr (matr:set_ij mtr (+ pr (matr:ij mtr i j)) i j)
	    )
	    (setq j (1+ j))
	  )
	  (setq i (1+ i))
	)
      )
    )
    ex_pts
  )
  mtr
)

(defun matr:triang (matr / n m i j k matr_i_k row_i row_k)
  (setq
    n (matr:row matr)
    m (matr:col matr)
  )
  (setq j 0)
  (while (< j n) ;���� �� ��������
    (setq
      ie (1- n)
      i	 j
    )
    (while (<= i ie) ;���� �� ������� ��� ������� 
      (setq
	row_i	 (matr:get_row matr i)
	matr_ij  (matr:ij matr i j)
      )
      (cond
	(
	 (= matr_ij 0)
	 (setq
	   row_ie (matr:get_row matr ie)
	   matr	  (matr:set_row matr i row_ie)
	   matr	  (matr:set_row matr ie row_i)
	   ie	  (1- ie)
	 )
	)
	(
	 (/= matr_ij 0)
	 (setq
	   row_i
		 (mapcar
		   (function
		     (lambda (el)
		       (/ el matr_ij)
		     )
		   )
		   row_i
		 )
	   matr	 (matr:set_row matr i row_i)
	   i	 (1+ i)
	 )
	)
      )
    )
    (setq row_j (matr:get_row matr j));������ ������� ���������� ������� �� ������ �����.
    (setq i (1+ j))
    (while (<= i ie) ;���� �� ������� ��� ������� 
      (setq
	row_i (matr:get_row matr i)
	row_i
	      (mapcar
		(function
		  (lambda (el1 el2)
		    (- el1 el2)
		  )
		)
		row_i
		row_j
	      )
	matr  (matr:set_row matr i row_i)
      )
      (setq i (1+ i))
    )
    (setq j (1+ j))
  )
  matr
)

(defun matr:obrhod (matr / i j m n summ x)
  (setq
    n (matr:row matr)
    m (matr:col matr)
    x (matr:new 1 n)
  )
  (setq i 0)
  (while (< i n)
    (setq x (matr:set_ij x 1.0 0 i))
    (setq i (1+ i))
  )
  (setq i n)
  (while (<= 0 (setq i (1- i)))
    (setq j (1+ i)
	  summ 0.0
	  )
    (while (< j  n)
      (setq summ (+ summ(* (matr:ij matr i j) (matr:ij x 0 j))))
      (setq j (1+ j))
    )
    (setq x (matr:set_ij x (/ (- (matr:ij matr i n) summ)(matr:ij matr i i)) 0 i))
  )
  x
)

(defun matr:sys_lu(matr / x)
  (setq matr (matr:triang matr)	)
  (princ "\n������� ����������� � ����������:")
  (matr:print matr)
  (princ "\n����� ������� ���������:")
  (setq x(matr:obrhod matr))
  (matr:print x)
  x
)

