;;;;;;("a1"
;;;;;;"���������� ��������� � ����������� ���� ����.\n
;;;;;; ��������:\n
;;;;;; 1) ��� �;\n
;;;;;; 2) ��� Y;\n
;;;;;; 3) ��� ����������, ������� �������� ������ �����." "�����")
(defun c:a1 (/ scx scy str pts)
  (alert
    "���������� ��������� � ����������� ���� ����
��������:
1) ��� �;
2) ��� Y;
3) ��� ����������, ������� �������� ������ �����.
����� ������������� ������� � ��� ����� ��������������� �������� ea." 
  )
  (setq	scx (sh:get (sh:sel "��� X"))
	scy (sh:get (sh:sel "��� Y"))
	str (getstring "\n��� ���������� ���������� ������ �����:")
  )
  (print (vl-doc-ref(read str)))
  (setq
	pts
	    (mapcar
	      (function
		(lambda	(el)
		  (sc:pxy_pt el scx scy)
		)
	      )
	      (vl-doc-ref(read str))
	    )
  )
  (dr:pline pts 256)
)

;;;;;;("an" "���������� ��������� ��������� � ����������� ���� ����.\n
;;;;;;��������:\n
;;;;;; 1) ��� �;\n
;;;;;; 2) ��� Y;\n
;;;;;; 3) ��� ����������, ������� �������� ������ �����.\n
;;;;;;����������: ����� ������������� ������� � ��� ����� ��������������� �������� ea." "�����")
(defun c:an (/ scx scy str pts x a i_colors colors)
  (alert
    "���������� ��������� ��������� � ����������� ���� ����
��������:
1) ��� �;
2) ��� Y;
3) ��� ����������, ������� �������� ������ �����.
����� ������������� ������� � ��� ����� ��������������� �������� ea.
" )
  (setq	scx (sh:get (sh:sel "��� X"))
	scy (sh:get (sh:sel "��� Y"))
	str (getstring "\n��� ���������� ���������� ������ �����:")
  )

  (setq
    i_colors 0
    colors
     '(1 2 3 4 5 6 7 25 45 65 85 105 125 145 165 185 205 225 245)
  )
  (print (vl-doc-ref (read str)))
  (setq pts (vl-doc-ref (read str)))

  (setq	pts (transpon pts)
	x   (car pts)
	a   (cdr pts)
  )

  (mapcar
    (function
      (lambda (el / p)
	(setq
	  p
	    (mapcar (function (lambda (el_x el_y) (list el_x el_y)))
		    x
		    el
	    )
	  p
	    (mapcar
	      (function
		(lambda	(el)
		  (sc:pxy_pt el scx scy)
		)
	      )
	      p
	    )
	)
	(dr:pline p (nth i_colors colors))
	(setq i_colors (1+ i_colors))
      )
    )
    a
  )
)


;;;;;;("a2"
;;;;;;"���������� ����� � ����������� �����.\n
;;;;;; ��������:\n
;;;;;; 1) ��� �;\n
;;;;;; 2) ���������� X." "�����")
(defun c:a2 (/ sc)
  (alert
    "���������� ����� � ����������� �����
��������:
1) ��� �;
2) ���������� X."
  )
  (setq sc (sh:get (sh:sel "�������� ���:")))
  (while (setq x (getreal "������� X :"))
    (dr:point (sc:val_pt x sc) 256)
  )
  (princ)
)

;;;;;;("a2t"
;;;;;;"���������� ����� � ����������� ����� � ��������� ������.\n
;;;;;; ��������:\n
;;;;;; 1) ��� �;\n
;;;;;; 2) ���������� X." "�����")
(defun c:a2t (/ sc pt)
  (alert
    "���������� ����� � ����������� �����
��������:
1) ��� �;
2) ���������� X."
  )
  (setq sc (sh:get (sh:sel "�������� ���:")))
  (while (setq x (getreal "������� X :"))
    (setq pt  (sc:val_pt x sc) )
    (dr:point pt 256)
    (dr:text (rtos x) pt 3.5 0.0 256)
  )
  (princ)
)

;;;;;;("a2xy_t"
;;;;;;"���������� ����� � ����������� ����� � ��������� ������.\n
;;;;;; ��������:\n
;;;;;; 1) ��� �;\n
;;;;;; 2) ��� Y;\n
;;;;;; 3) ���������� X." "�����")
(defun c:a2xy_t (/ pt pt_0 pt_1 scx scx_end scx_st scy scy_end scy_st x)
  (setq	scx (sh:get (sh:sel "��� X"))
	scy (sh:get (sh:sel "��� Y"))
  )
  
  (while (setq x (getreal "������� X :"))
    (setq
      pt	(sc:val_pt x scx)
      scx_st	(cdr (assoc 10 scx))
      scx_end	(cdr (assoc 11 scx))
      scy_st	(cdr (assoc 10 scy))
      scy_end	(cdr (assoc 11 scy))
      pt_0	(inters	pt
			(polar pt (angle scy_st scy_end) 1.0)
			scy_st
			(polar scy_st (angle scx_st scx_end) 1.0)
			nil
		)
      pt_1	(inters	pt
			(polar pt (angle scy_st scy_end) 1.0)
			scy_end
			(polar scy_end (angle scx_st scx_end) 1.0)
			nil
		)
    )
    (dr:line pt_0 pt_1 256)
    (dr:text (rtos x) pt 3.5 0.0 256)
  )
  (princ)
)

;;;;;;("a2xyn_t"
;;;;;;"���������� ����� � ����������� 2-� ���� � ��������� ������.\n
;;;;;; ��������:\n
;;;;;; 1) ��� �;\n
;;;;;; 2) ��� Y;\n
;;;;;; 3) ���������� X." "�����")
(defun c:a2xyn_t (/)
  (setq	scx (sh:get (sh:sel "��� X"))
	scy (sh:get (sh:sel "��� Y"))
  )

  (setq	x_min (getreal "������� X_min :")
	x_max (getreal "������� X_max :")
	n_div (getint "������� n_div :")

  )
  (setq
    scx_st  (cdr (assoc 10 scx))
    scx_end (cdr (assoc 11 scx))
    scy_st  (cdr (assoc 10 scy))
    scy_end (cdr (assoc 11 scy))
  )
  (mapcar
    (function
      (lambda (el)
	(setq
	  pt   (sc:val_pt el scx)
	  pt_0 (inters pt
		       (polar pt (angle scy_st scy_end) 1.0)
		       scy_st
		       (polar scy_st (angle scx_st scx_end) 1.0)
		       nil
	       )
	  pt_1 (inters pt
		       (polar pt (angle scy_st scy_end) 1.0)
		       scy_end
		       (polar scy_end (angle scx_st scx_end) 1.0)
		       nil
	       )
	)
	(dr:line pt_0 pt_1 256)
	(dr:text (rtos el) pt 3.5 0.0 256)
      )
    )
    (sub_div x_min x_max n_div 0)
  )
  (princ)
)

;;;("a3"
;;;"���������� ����� � ����������� ���� ����.\n
;;; ��������:\n
;;; 1) ��� �;\n
;;; 2) ��� Y;\n
;;; 3) ���������� X.\n
;;; 4) ���������� Y." "�����")
(defun c:a3 (/ x y scx scy)
  (alert
    "���������� ����� � ����������� ���� ����
��������:
1) ��� �;
2) ��� Y;
3) ���������� X.
4) ���������� Y."
  )
  (setq scx (sh:get (sh:sel "��� X:")))
  (setq scy (sh:get (sh:sel "��� Y:")))
  (while
    (and
      (setq x (getreal "������� X :"))
      (setq y (getreal "������� Y :"))
    )
     (dr:point (sc:pxy_pt (list x y 0.0) scx scy) 256)
  )
)

;;;;;;("a4"
;;;;;;"���������� ����� � ����������� ���� ����.\n
;;;;;; ��������:\n
;;;;;; 1) ��� �;\n
;;;;;; 2) ��� Y;\n
;;;;;; 3) ����� � ����������� ���� X-Y." "�����")
(defun c:a4 (/ p scx scy)
  (alert
    "���������� ����� � ����������� ���� ����
��������:
1) ��� �;
2) ��� Y;
3) ����� � ����������� ���� X-Y."
  )
  (setq
    scx	(sh:get (sh:sel "��� X:"))
    scy	(sh:get (sh:sel "��� Y:"))
  )
  (while
    (setq p (getpoint "������� ����� P :"))
     (dr:point (sc:pxy_pt p scx scy) 256)
  )
)

;;;;;;("a5"
;;;;;;"������� ����� �� ��������� ���� ���� � ���������� ������.\n
;;;;;; ��������:\n
;;;;;; 1) ��� �;\n
;;;;;; 2) ��� Y;\n
;;;;;; 3) ����� � ����������� ���� X-Y." "�����")
(defun c:a5 (/ P SCX SCY)
  (alert
    "������� ����� �� ��������� ���� ���� � ���������� ������
��������:
1) ��� �;
2) ��� Y;
3) ����� � ����������� ���� X-Y."
  )
  (setq
    scx	(sh:get (sh:sel "��� X:"))
    scy	(sh:get (sh:sel "��� Y:"))
  )
  (while
    (setq p (getpoint "������� ����� P :")
	  p (sc:pt_pxy p scx scy)
    )
     (print p)
     (dr:point p 256)
  )
)


;;;;;;("a6"
;;;;;;"������� ����� �� ��������� ����� ���� ����\n
;;;;;; � ���������� ������ ���� ����.\n
;;;;;; ��������:\n
;;;;;; 1) ��� � �� ������� ������� �����;\n
;;;;;; 2) ��� Y �� ������� ������� �����;\n
;;;;;; 3) ��� � � ������� �������� �����;\n
;;;;;; 4) ��� Y � ������� �������� �����;\n
;;;;;; 5) ����� � ����������� ���� X-Y." "�����")
(defun c:a6 (/ p scx0 scx1 scy0 scy1)
  (alert
    "������� ����� �� ��������� ����� ���� ����
� ���������� ������ ���� ����
��������:
1) ��� � �� ������� ������� �����;
2) ��� Y �� ������� ������� �����;
3) ��� � � ������� �������� �����;
4) ��� Y � ������� �������� �����;
5) ����� � ����������� ���� X-Y."
  )
  (setq
    scx0 (sh:get (sh:sel "��� X ��� �������� �����"))
    scy0 (sh:get (sh:sel "��� Y ��� �������� �����"))
    scx1 (sh:get (sh:sel "��� X ��� ���������� �����"))
    scy1 (sh:get (sh:sel "��� Y ��� ���������� �����"))
  )
  (while
    (setq p (getpoint "������� ����� P :")
	  p (sc:pt_pxy p scx0 scy0)
    )
     (print p)
     (dr:point (sc:pxy_pt p scx1 scy1) 256)
  )
)

;;;;;;("c1" "���������� ����� �� ����� �� ��������." "�����")
(defun c:c1 (/ sx scx v pt)
  (setq
    sx	(sh:sel "����� x")
    scx	(sh:get sx)
    v	(getreal "\n������� ��������:")
    pt	(sc:val_pt v scx)
  )
  (dr:point pt 1)
  (princ v)
  (princ)
)

;;;;;;("c2" "����������� �������� �� ����� �� �����." "�����")
(defun c:c2 (/ sx scx v pt)
  (setq
    sx	(sh:sel "����� x")
    scx	(sh:get sx)
    pt	(getpoint "\n������� ����� �� �����:")
    v	(sc:pt_val pt scx)
  )
  (dr:point pt 1)
  (princ v)
  (princ)
)

;;;;;;("c3" "���������� ����� � ����������� 2-� ����." "�����")
(defun c:c3 (/ sx scx sy scy pxy pt)
  (setq
    sx	(sh:sel "����� x")
    scx	(sh:get sx)
    sy	(sh:sel "����� y")
    scy	(sh:get sy)
  )
  (while
    (setq pxy (getpoint "\n ������� ����� � ����������� �����:"))
     (setq pt (sc:pxy_pt pxy scx scy))
     (princ "pxy")(princ pxy)
     (dr:point pt 1)
  )
)

;;;;;;("c4" "������� ���������� ���������� �����." "�����")
(defun c:c4  (/ sx scx sy scy pxy pt)
  (setq
    sx	(sh:sel "����� x")
    scx	(sh:get sx)
    sy	(sh:sel "����� y")
    scy	(sh:get sy))
  (while (setq pt (getpoint "\n ������� ����� � �� ������:"))
    (setq pxy (sc:pt_pxy pt scx scy))
    (princ "pxy")
    (princ pxy)
    (dr:point pt 2)))
