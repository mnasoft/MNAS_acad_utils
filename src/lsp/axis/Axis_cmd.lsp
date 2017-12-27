;;;;;;("a1"
;;;;;;"���������� ��������� � ����������� ���� ����.\n
;;;;;; ��������:\n
;;;;;; 1) ��� �;\n
;;;;;; 2) ��� Y;\n
;;;;;; 3) ��� ����������, ������� �������� ������ �����." "�����")
(defun c:a1  (/ scx scy str pts EL LST LST-I LST-LEN LST-REZ)
  (alert
    "���������� ��������� � ����������� ���� ����
��������:
1) ��� �;
2) ��� Y;
3) ��� ����������, ������� �������� ������ �����.
����� ������������� ������� � ��� ����� ��������������� �������� ea.")
  (setq scx (sh:get (sh:sel "��� X"))
        scy (sh:get (sh:sel "��� Y"))
        str (getstring "\n��� ���������� ���������� ������ �����:"))
  (print (vl-doc-ref (read str)))
  (setq pts (progn (setq lst     (vl-doc-ref (read str))
                         lst-len (length lst)
                         lst-i   -1)
                   (while (< (setq lst-i (1+ lst-i)) lst-len)
                     (setq el      (nth lst-i lst)
                           lst-rez (cons (progn (sc:pxy_pt el scx scy)) lst-rez)))
                   (setq lst-rez (reverse lst-rez))))
  (dr:points pts 256)
  (dr:pline pts 256))

(defun axis:draw-single-graph-by-axis-names
       (x-axis-name y-axis-name xy-point-name / scx scy str pts el lst lst-i lst-len lst-rez pnt-type)
  (setq scx (sh:get (sh:sel-by-name x-axis-name))
        scy (sh:get (sh:sel-by-name y-axis-name))
        str xy-point-name)
  (print (vl-doc-ref (read str)))
  (if (and scx scy)
    (progn (setq pts (progn (setq lst     (vl-doc-ref (read str))
                                  lst-len (length lst)
                                  lst-i   -1)
                            (while (< (setq lst-i (1+ lst-i)) lst-len)
                              (setq el      (nth lst-i lst)
                                    lst-rez (cons (progn (sc:pxy_pt el scx scy)) lst-rez)))
                            (setq lst-rez (reverse lst-rez))))
           (dr:layer-set xy-point-name)
           (dr:pline pts 256)
           (setq pnt-type (axis:point-type-next))
           (mapcar (function (lambda (pt) (dr:insert pt pnt-type))) pts))))

(defun axis:draw-multiple-graphs-by-axis-names
       (x-axis-name y-axis-name-lst)
  (mapcar (function
	    (lambda (el)
	      (axis:draw-single-graph-by-axis-names x-axis-name el el)))
	  y-axis-name-lst))

(defun axis:draw-multiple-graphs-on-same-axis
       (x-axis-name y-axis-name data-symbol-lst)
  (axis:load-point-types)
  (axis:point-type-reset)
  (mapcar (function (lambda (el)
		      (axis:draw-single-graph-by-axis-names
			x-axis-name
			y-axis-name
			(strcase (vl-symbol-name el) t))))
	  data-symbol-lst))

(defun c:a-l  (/ en te)
  (setq en (car (entsel "\n�������� ���:"))
        te (sh:get-sh-name en))
  (command "_CHANGE" en "" "_Properties" "_LAyer" te ""))

(defun c:pm-170  ()
  (axis:draw-multiple-graphs-by-axis-names
    "tau"
    '("Gas2Oil"  "Oil2Gas"  "GQ010"    "P02"      "EN1"      "EN2"      "FQ010"    "FQ110"
      "T04"	     "T04max"	"T04min"
      "FP230"
      "FP210"    "FP220"    "EB100"    "EB110"    "EB120"    "FT010"    "FT020"
      "PT250"    "PT240"    "PT230"
      "WP020"    "WP030"
      "WT100"
      "PT210"    "PT220"    "FT310"    "FT320"
      "PH066"    "PH076"
      "FH176"
      "FK200"    "FK201"    "FH206"    "FH207"
      "FK400"    "FK401"    "FH406"
      "FH407"    "FK250"    "FK251"    "FH256"    "FH257"    "FK260"    "FK261"    "FH266"    "FH267"
      "FK270"    "FK271"    "FH276"    "FH277"
      
      "FK280"    "FK281"    "FH286"    "FH287"
      "FK290"    "FK291"    "FH296"    "FH297"
      "FK300"    "FK301"    "FH306"    "FH307"
      "FK310"    "FK311"    "FH316"    "FH317"
      "WH010"    "WH011"    "WH016"    "WH017"
      "FK350"    "FH356"    "FH366"
      "FK370"    "FH376"    "FH386"
      "FK480"    "FH486"    "FH487"
      
      "FK230"    "FH236"    "FH226"
      "FH046"
      "FK010"    "FK020"    "FH036"    "FH016"    "FH028"    "FH027"    "FK211"    "FH336"
      "FH346"    "FH466"    "FH476"
      
;;;;      "Ready_23" "Ready_30"
      
      "FA011"    "FA012"    "FA010"    "FA016"
      
      "FM016"    "FU116"    "Hand_FM01" "FF116"
      "FA021"    "FA022"    "FA020"    "FA026"
      "FM026"    "FU016")))




;;;;;;("an" "���������� ��������� ��������� � ����������� ���� ����.\n
;;;;;;��������:\n
;;;;;; 1) ��� �;\n
;;;;;; 2) ��� Y;\n
;;;;;; 3) ��� ����������, ������� �������� ������ �����.\n
;;;;;;����������: ����� ������������� ������� � ��� ����� ��������������� �������� ea." "�����")
(defun c:an  (/ scx scy str pts x a i_colors colors)
  (alert
    "���������� ��������� ��������� � ����������� ���� ����
��������:
1) ��� �;
2) ��� Y;
3) ��� ����������, ������� �������� ������ �����.
����� ������������� ������� � ��� ����� ��������������� �������� ea.
"   )
  (setq scx (sh:get (sh:sel "��� X"))
        scy (sh:get (sh:sel "��� Y"))
        str (getstring "\n��� ���������� ���������� ������ �����:"))
  (setq i_colors 0
        colors   '(1 2 3 4 5 6 7 25 45 65 85 105 125 145 165 185 205 225 245))
  (print (vl-doc-ref (read str)))
  (setq pts (vl-doc-ref (read str)))
  (setq pts (transpon pts)
        x   (car pts)
        a   (cdr pts))
  (map-an-0 a colors i_colors scx scy x))


(defun map-an-0  (a colors i_colors scx scy x / EL LST LST-I LST-LEN LST-REZ P)
  (progn (setq lst     a
               lst-len (length lst)
               lst-i   -1)
         (while (< (setq lst-i (1+ lst-i)) lst-len)
           (setq el      (nth lst-i lst)
                 lst-rez (cons (progn (setq p (mapcar (function (lambda (el_x el_y) (list el_x el_y))) x el)
                                            p (map-an-0-1 scx scy p))
                                      (dr:pline p (nth i_colors colors))
                                      (setq i_colors (1+ i_colors)))
                               lst-rez)))
         (setq lst-rez (reverse lst-rez))))

;;;(macro-mapcar '(mapcar
;;;                (function
;;;                 (lambda (el)
;;;                   (setq
;;;                    p
;;;                    (mapcar (function (lambda (el_x el_y) (list el_x el_y))) x el)
;;;                    p
;;;                    (map-an-0-1 scx scy p))
;;;                   (dr:pline p (nth i_colors colors))
;;;                   (setq i_colors (1+ i_colors))))
;;;                a))




(defun map-an-0-1  (scx scy p / EL LST LST-I LST-LEN LST-REZ)
  (progn (setq lst     p
               lst-len (length lst)
               lst-i   -1)
         (while (< (setq lst-i (1+ lst-i)) lst-len)
           (setq el      (nth lst-i lst)
                 lst-rez (cons (progn (sc:pxy_pt el scx scy)) lst-rez)))
         (setq lst-rez (reverse lst-rez))))


;;;;;;("a2"
;;;;;;"���������� ����� � ����������� �����.\n
;;;;;; ��������:\n
;;;;;; 1) ��� �;\n
;;;;;; 2) ���������� X." "�����")
(defun c:a2  (/ sc x)
  (alert "���������� ����� � ����������� �����
��������:
1) ��� �;
2) ���������� X.")
  (setq sc (sh:get (sh:sel "�������� ���:")))
  (while (setq x (getreal "������� X :")) (dr:point (sc:val_pt x sc) 256))
  (princ))

;;;;;;("a2t"
;;;;;;"���������� ����� � ����������� ����� � ��������� ������.\n
;;;;;; ��������:\n
;;;;;; 1) ��� �;\n
;;;;;; 2) ���������� X." "�����")
(defun c:a2t  (/ sc pt x)
  (alert "���������� ����� � ����������� �����
��������:
1) ��� �;
2) ���������� X.")
  (setq sc (sh:get (sh:sel "�������� ���:")))
  (while (setq x (getreal "������� X :"))
    (setq pt (sc:val_pt x sc))
    (dr:point pt 256)
    (dr:text (rtos x) pt 3.5 0.0 256))
  (princ))

;;;;;;("a2xy_t"
;;;;;;"���������� ����� � ����������� ����� � ��������� ������.\n
;;;;;; ��������:\n
;;;;;; 1) ��� �;\n
;;;;;; 2) ��� Y;\n
;;;;;; 3) ���������� X." "�����")
(defun c:a2xy_t  (/ pt pt_0 pt_1 scx scx_end scx_st scy scy_end scy_st x)
  (setq scx (sh:get (sh:sel "��� X"))
        scy (sh:get (sh:sel "��� Y")))
  (while (setq x (getreal "������� X :"))
    (setq pt      (sc:val_pt x scx)
          scx_st  (cdr (assoc 10 scx))
          scx_end (cdr (assoc 11 scx))
          scy_st  (cdr (assoc 10 scy))
          scy_end (cdr (assoc 11 scy))
          pt_0    (inters pt
                          (polar pt (angle scy_st scy_end) 1.0)
                          scy_st
                          (polar scy_st (angle scx_st scx_end) 1.0)
                          nil)
          pt_1    (inters pt
                          (polar pt (angle scy_st scy_end) 1.0)
                          scy_end
                          (polar scy_end (angle scx_st scx_end) 1.0)
                          nil))
    (dr:line pt_0 pt_1 256)
    (dr:text (rtos x) pt 3.5 0.0 256))
  (princ))

;;;;;;("a2xyn_t"
;;;;;;"���������� ����� � ����������� 2-� ���� � ��������� ������.\n
;;;;;; ��������:\n
;;;;;; 1) ��� �;\n
;;;;;; 2) ��� Y;\n
;;;;;; 3) ���������� X." "�����")
(defun c:a2xyn_t  (/ n_div pt pt_0 pt_1 scx scx_end scx_st scy scy_end scy_st x_max x_min)
  (setq scx (sh:get (sh:sel "��� X"))
        scy (sh:get (sh:sel "��� Y")))
  (setq x_min (getreal "������� X_min :")
        x_max (getreal "������� X_max :")
        n_div (getint "������� n_div :"))
  (setq scx_st  (cdr (assoc 10 scx))
        scx_end (cdr (assoc 11 scx))
        scy_st  (cdr (assoc 10 scy))
        scy_end (cdr (assoc 11 scy)))
  (map-a2xyn_t-0 n_div pt pt_0 pt_1 scx scx_end scx_st scy_end scy_st x_max x_min)
  (princ))


(defun map-a2xyn_t-0
       (n_div pt pt_0 pt_1 scx scx_end scx_st scy_end scy_st x_max x_min / el lst lst-i lst-len lst-rez)
  (progn (setq lst     (sub_div x_min x_max n_div 0)
               lst-len (length lst)
               lst-i   -1)
         (while (< (setq lst-i (1+ lst-i)) lst-len)
           (setq el      (nth lst-i lst)
                 lst-rez (cons (progn (setq pt   (sc:val_pt el scx)
                                            pt_0 (inters pt
                                                         (polar pt (angle scy_st scy_end) 1.0)
                                                         scy_st
                                                         (polar scy_st (angle scx_st scx_end) 1.0)
                                                         nil)
                                            pt_1 (inters pt
                                                         (polar pt (angle scy_st scy_end) 1.0)
                                                         scy_end
                                                         (polar scy_end (angle scx_st scx_end) 1.0)
                                                         nil))
                                      (dr:line pt_0 pt_1 256)
                                      (dr:text (rtos el) pt 3.5 0.0 256))
                               lst-rez)))
         (setq lst-rez (reverse lst-rez))))




;;;(macro-mapcar '  (mapcar (function (lambda (el)
;;;                      (setq pt   (sc:val_pt el scx)
;;;                            pt_0 (inters pt
;;;                                         (polar pt (angle scy_st scy_end) 1.0)
;;;                                         scy_st
;;;                                         (polar scy_st (angle scx_st scx_end) 1.0)
;;;                                         nil)
;;;                            pt_1 (inters pt
;;;                                         (polar pt (angle scy_st scy_end) 1.0)
;;;                                         scy_end
;;;                                         (polar scy_end (angle scx_st scx_end) 1.0)
;;;                                         nil))
;;;                      (dr:line pt_0 pt_1 256)
;;;                      (dr:text (rtos el) pt 3.5 0.0 256)))
;;;          (sub_div x_min x_max n_div 0)))


;;;("a3"
;;;"���������� ����� � ����������� ���� ����.\n
;;; ��������:\n
;;; 1) ��� �;\n
;;; 2) ��� Y;\n
;;; 3) ���������� X.\n
;;; 4) ���������� Y." "�����")
(defun c:a3  (/ x y scx scy)
  (alert
    "���������� ����� � ����������� ���� ����
��������:
1) ��� �;
2) ��� Y;
3) ���������� X.
4) ���������� Y.")
  (setq scx (sh:get (sh:sel "��� X:")))
  (setq scy (sh:get (sh:sel "��� Y:")))
  (while (and (setq x (getreal "������� X :")) (setq y (getreal "������� Y :")))
    (dr:point (sc:pxy_pt (list x y 0.0) scx scy) 256)))

;;;;;;("a4"
;;;;;;"���������� ����� � ����������� ���� ����.\n
;;;;;; ��������:\n
;;;;;; 1) ��� �;\n
;;;;;; 2) ��� Y;\n
;;;;;; 3) ����� � ����������� ���� X-Y." "�����")
(defun c:a4  (/ p scx scy)
  (alert
    "���������� ����� � ����������� ���� ����
��������:
1) ��� �;
2) ��� Y;
3) ����� � ����������� ���� X-Y.")
  (setq scx (sh:get (sh:sel "��� X:"))
        scy (sh:get (sh:sel "��� Y:")))
  (while (setq p (getpoint "������� ����� P :")) (dr:point (sc:pxy_pt p scx scy) 256)))

;;;;;;("a5"
;;;;;;"������� ����� �� ��������� ���� ���� � ���������� ������.\n
;;;;;; ��������:\n
;;;;;; 1) ��� �;\n
;;;;;; 2) ��� Y;\n
;;;;;; 3) ����� � ����������� ���� X-Y." "�����")
(defun c:a5  (/ P SCX SCY)
  (alert
    "������� ����� �� ��������� ���� ���� � ���������� ������
��������:
1) ��� �;
2) ��� Y;
3) ����� � ����������� ���� X-Y.")
  (setq scx (sh:get (sh:sel "��� X:"))
        scy (sh:get (sh:sel "��� Y:")))
  (while (setq p (getpoint "������� ����� P :")
               p (sc:pt_pxy p scx scy))
    (print p)
    (dr:point p 256)))


;;;;;;("a6"
;;;;;;"������� ����� �� ��������� ����� ���� ����\n
;;;;;; � ���������� ������ ���� ����.\n
;;;;;; ��������:\n
;;;;;; 1) ��� � �� ������� ������� �����;\n
;;;;;; 2) ��� Y �� ������� ������� �����;\n
;;;;;; 3) ��� � � ������� �������� �����;\n
;;;;;; 4) ��� Y � ������� �������� �����;\n
;;;;;; 5) ����� � ����������� ���� X-Y." "�����")
(defun c:a6  (/ p scx0 scx1 scy0 scy1)
  (alert
    "������� ����� �� ��������� ����� ���� ����
� ���������� ������ ���� ����
��������:
1) ��� � �� ������� ������� �����;
2) ��� Y �� ������� ������� �����;
3) ��� � � ������� �������� �����;
4) ��� Y � ������� �������� �����;
5) ����� � ����������� ���� X-Y.")
  (setq scx0 (sh:get (sh:sel "��� X ��� �������� �����"))
        scy0 (sh:get (sh:sel "��� Y ��� �������� �����"))
        scx1 (sh:get (sh:sel "��� X ��� ���������� �����"))
        scy1 (sh:get (sh:sel "��� Y ��� ���������� �����")))
  (while (setq p (getpoint "������� ����� P :")
               p (sc:pt_pxy p scx0 scy0))
    (print p)
    (dr:point (sc:pxy_pt p scx1 scy1) 256)))

;;;;;;("c1" "���������� ����� �� ����� �� ��������." "�����")
(defun c:c1  (/ sx scx v pt)
  (setq sx  (sh:sel "����� x")
        scx (sh:get sx)
        v   (getreal "\n������� ��������:")
        pt  (sc:val_pt v scx))
  (dr:point pt 1)
  (princ v)
  (princ))

;;;;;;("c2" "����������� �������� �� ����� �� �����." "�����")
(defun c:c2  (/ sx scx v pt)
  (setq sx  (sh:sel "����� x")
        scx (sh:get sx)
        pt  (getpoint "\n������� ����� �� �����:")
        v   (sc:pt_val pt scx))
  (dr:point pt 1)
  (princ v)
  (princ))

;;;;;;("c3" "���������� ����� � ����������� 2-� ����." "�����")
(defun c:c3  (/ sx scx sy scy pxy pt)
  (setq sx  (sh:sel "����� x")
        scx (sh:get sx)
        sy  (sh:sel "����� y")
        scy (sh:get sy))
  (while (setq pxy (getpoint "\n ������� ����� � ����������� �����:"))
    (setq pt (sc:pxy_pt pxy scx scy))
    (princ "pxy")
    (princ pxy)
    (dr:point pt 1)))

;;;;;;("c4" "������� ���������� ���������� �����." "�����")
(defun c:c4  (/ sx scx sy scy pxy pt)
  (setq sx  (sh:sel "����� x")
        scx (sh:get sx)
        sy  (sh:sel "����� y")
        scy (sh:get sy))
  (while (setq pt (getpoint "\n ������� ����� � �� ������:"))
    (setq pxy (sc:pt_pxy pt scx scy))
    (princ "pxy")
    (princ pxy)
    (dr:point pt 2)))
