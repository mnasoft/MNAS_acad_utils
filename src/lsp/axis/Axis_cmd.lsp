(setq mnas-axis:mode-setup '((alert-mode . t) (prompt-mode . t)))
     
(defun mnas-axis:alert-mode  ()
  (cdr (assoc 'alert-mode mnas-axis:mode-setup)))

(defun mnas-axis:alert-mode-set	 (val)
  (setq	mnas-axis:mode-setup
	 (subst
	   (cons 'alert-mode val)
	   (assoc 'alert-mode mnas-axis:mode-setup)
	   mnas-axis:mode-setup)))

(defun mnas-axis:prompt-mode  ()
  (cdr (assoc 'prompt-mode mnas-axis:mode-setup)))

(defun mnas-axis:prompt-mode-set  (val)
  (setq	mnas-axis:mode-setup
	 (subst
	   (cons 'prompt-mode val)
	   (assoc 'prompt-mode mnas-axis:mode-setup)
	   mnas-axis:mode-setup)))

(defun c:mnas-axis-mode-setup  (/ am pm)
  (initget 1 "Yes No")
  (setq am (getkword "Alert-mode (Yes No):"))
  (initget 1 "Yes No")
  (setq pm (getkword "Prompt-mode (Yes No):"))
  (if (= am "Yes")
    (mnas-axis:alert-mode-set t)
    (mnas-axis:alert-mode-set nil))
  (if (= pm "Yes")
    (mnas-axis:prompt-mode-set t)
    (mnas-axis:prompt-mode-set nil))
  mnas-axis:mode-setup)

(defun mnas-axis:show-prompt  (prompt-string)
  (if (mnas-axis:prompt-mode)
    (prompt prompt-string))
  (if (mnas-axis:alert-mode)
    (alert prompt-string)))
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;("mnas-axis-graph-xy"
;;;;;;"���������� ��������� � ����������� ���� ����.\n
;;;;;; ��������:\n
;;;;;; 1) ��� �;\n
;;;;;; 2) ��� Y;\n
;;;;;; 3) ��� ����������, ������� �������� ������ �����.\n
;;;;;;����� ������������� ������� � ��� ����� ��������������� �������� mnas-axis-edit." "�����")
(defun c:mnas-axis-graph-xy  ()
  (axis:load-reset-point-types)
  (mnas-axis:show-prompt mnas-axis:graph-xy-prompt)
  (axis:draw-single-graph-by-axis-data
    (axis:get (axis:sel "��� X"))
    (axis:get (axis:sel "��� Y"))
    (getstring "\n��� ���������� ���������� ������ �����:")))

;;;;;;("a1" "��. mnas-axis-graph-xy" "�����")
(defun c:a1 () (c:mnas-axis-graph-xy))

(defun c:a-l  (/ en te)
  (setq en (car (entsel "\n�������� ���:"))
        te (axis:get-sh-name en))
  (command "_CHANGE" en "" "_Properties" "_LAyer" te ""))


;;;;;;("c:mnas-axis-graph-xy-n" "���������� ��������� ��������� � ����������� ���� ����.\n
;;;;;;��������:\n
;;;;;; 1) ��� �;\n
;;;;;; 2) ��� Y;\n
;;;;;; 3) ��� ����������, ������� �������� ������ �����.\n
;;;;;;����������: ����� ������������� ������� � ��� ����� ��������������� �������� ea." "�����")
(defun c:mnas-axis-graph-xy-n  (/ x-axis-data y-axis-data str pts x-dt y-dt-lst)
  (axis:load-reset-point-types)
  (mnas-axis:show-prompt mnas-axis:graph-xyn-prompt)
  (setq	x-axis-data (axis:get (axis:sel "��� X"))
	y-axis-data (axis:get (axis:sel "��� Y"))
	str	    (getstring "\n��� ���������� ���������� ������ �����:"))
  (print (vl-doc-ref (read str)))
  (setq pts (vl-doc-ref (read str)))
  (setq	pts	 (transpon pts)
	x-dt	 (car pts)
	y-dt-lst (cdr pts)
	y-str	 (make-list-str y-dt-lst))
  (mapcar (function (lambda (y-values y-la-ext)
		      (axis:draw-single-graph-by-axis-xy-val-data
			x-axis-data
			y-axis-data
			(mapcar (function list) x-dt y-values)
			(strcat str "-" y-la-ext))))
	  y-dt-lst
	  y-str))

(defun make-list-int	 (lst)
  (setq	i 0
	times 10
	lst nil)
  (while (<= (setq i (1+ i)) times) (setq lst (cons i lst)))
  (reverse lst))

(defun make-list-str (lst) (mapcar (function itoa) (make-list-int lst)))

(defun c:an () (c:mnas-axis-graph-xy-n))

;;;;;;;;;;;;

(defun c:mnas-axis-graph-xy-names  (/  names-str str x-axis-data xy-point-name y-axis-data)
  (axis:load-reset-point-types)
  (mnas-axis:show-prompt mnas-axis:graph-xy-names-prompt)
  (setq x-axis-data (axis:get (axis:sel "��� X"))
        y-axis-data (axis:get (axis:sel "��� Y"))
        str         (getstring "\n��� ���������� ���������� ������ �����:"))
  (print (vl-doc-ref (read str)))
  (setq names-str (vl-doc-ref (read str)))
  (mapcar (function (lambda (nm) (axis:draw-single-graph-by-axis-data x-axis-data y-axis-data nm)))
          names-str))

;;;;;;;;;;;;

;;;;;;("mnas-axis-point"
;;;;;;"���������� ����� � ����������� �����.\n
;;;;;; ��������:\n
;;;;;; 1) ��� �;\n
;;;;;; 2) ���������� X." "�����")
(defun c:mnas-axis-point  (/ sc x)
  (mnas-axis:show-prompt mnas-axis:point-prompt)
  (setq sc (axis:get (axis:sel "�������� ���:")))
  (while (setq x (getreal "������� X :")) (dr:point (sc:val_pt x sc) 256))
  (princ))

;;;;;;("a2" "��. mnas-axis-point." "�����")
(defun c:a2 () (c:mnas-axis-point))

;;;;;;("mnas-axis-point-text"
;;;;;;"���������� ����� � ����������� ����� � ��������� ������.\n
;;;;;; ��������:\n
;;;;;; 1) ��� �;\n
;;;;;; 2) ���������� X." "�����")
(defun c:mnas-axis-point-text  (/ sc pt x)
  (mnas-axis:show-prompt mnas-axis:point-text-prompt)
  (setq sc (axis:get (axis:sel "�������� ���:")))
  (while (setq x (getreal "������� X :"))
    (setq pt (sc:val_pt x sc))
    (dr:point pt 256)
    (dr:text (rtos x) pt 3.5 0.0 256))
  (princ))

;;;;;;("a2t" "��. mnas-axis-point-text." "�����")
(defun c:a2t () (c:mnas-axis-point-text))

;;;;;;("mnas-axis-tick"
;;;;;;"���������� ����� ����� � ����������� ����� � ��������� ������.\n
;;;;;; ��������:\n
;;;;;; 1) ��� �;\n
;;;;;; 2) ��� Y;\n
;;;;;; 3) ���������� X." "�����")
(defun c:mnas-axis-tick  (/ pt pt_0 pt_1 scx scx_end scx_st scy scy_end scy_st x)
  (setq scx (axis:get (axis:sel "��� X"))
        scy (axis:get (axis:sel "��� Y")))
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

;;;;;;("a2xy_t" "��. mnas-axis-tick." "�����")
(defun c:a2xy_t () (c:mnas-axis-tick))

;;;;;;("mnas-axis-ticks" a2xyn_t
;;;;;;"���������� ����� � ����������� 2-� ���� � ��������� ������.\n
;;;;;; ��������:\n
;;;;;; 1) ��� �;\n
;;;;;; 2) ��� Y;\n
;;;;;; 3) ���������� X." "�����")
(defun c:mnas-axis-ticks  (/ n_div pt pt_0 pt_1 scx scx_end scx_st scy scy_end scy_st x_max x_min)
  (setq	scx (axis:get (axis:sel "��� X"))
	scy (axis:get (axis:sel "��� Y")))
  (setq	x_min (getreal "������� X_min :")
	x_max (getreal "������� X_max :")
	n_div (getint "������� n_div :"))
  (setq	scx_st	(cdr (assoc 10 scx))
	scx_end	(cdr (assoc 11 scx))
	scy_st	(cdr (assoc 10 scy))
	scy_end	(cdr (assoc 11 scy)))
  (map-a2xyn_t-0 n_div pt pt_0 pt_1 scx scx_end scx_st scy_end scy_st x_max x_min)
  (princ))

;;;;;;("a2xyn_t" "��. mnas-axis-ticks." "�����")
(defun c:a2xyn_t () (c:mnas-axis-ticks))

(defun map-a2xyn_t-0  (n_div pt pt_0 pt_1 scx scx_end scx_st scy_end scy_st x_max x_min / el lst lst-i lst-len lst-rez)
  (progn (setq lst     (sub_div x_min x_max n_div 0)
	       lst-len (length lst)
	       lst-i   -1)
	 (while	(< (setq lst-i (1+ lst-i)) lst-len)
	   (setq el	 (nth lst-i lst)
		 lst-rez (cons (progn (setq pt	 (sc:val_pt el scx)
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


;;;;;;("mnas-axis-draw-xy"
;;;;;;"���������� ����� � ����������� ���� ����.\n
;;;;;; ��������:\n
;;;;;; 1) ��� �;\n
;;;;;; 2) ��� Y;\n
;;;;;; 3) ���������� X.\n
;;;;;; 4) ���������� Y." "�����")
(defun c:mnas-axis-draw-xy  (/ x y scx scy)
  (mnas-axis:show-prompt mnas-axis:draw-xy-prompt)  
  (setq scx (axis:get (axis:sel "��� X:")))
  (setq scy (axis:get (axis:sel "��� Y:")))
  (while (and (setq x (getreal "������� X :")) (setq y (getreal "������� Y :")))
    (dr:point (sc:pxy_pt (list x y 0.0) scx scy) 256)))

;;;;;;("a3" "��. mnas-axis-draw-xy." "�����")
(defun c:a3 () (c:mnas-axis-draw-xy))

;;;;;;("mnas-axis-draw-point"
;;;;;;"���������� ����� � ����������� ���� ����.\n
;;;;;; ��������:\n
;;;;;; 1) ��� �;\n
;;;;;; 2) ��� Y;\n
;;;;;; 3) ����� � ����������� ���� X-Y." "�����")
(defun c:mnas-axis-draw-point  (/ p scx scy)
  (mnas-axis:show-prompt mnas-axis:draw-point-prompt)
  (setq	scx (axis:get (axis:sel "��� X:"))
	scy (axis:get (axis:sel "��� Y:")))
  (while (setq p (getpoint "������� ����� P :")) (dr:point (sc:pxy_pt p scx scy) 256)))

;;;;;;("a4" "��. mnas-axis-draw-point." "�����")
(defun c:a4 () (c:mnas-axis-draw-point))

;;;;;;("mnas-axis-point-to-screen"
;;;;;;"������� ����� �� ��������� ���� ���� � ���������� ������.\n
;;;;;; ��������:\n
;;;;;; 1) ��� �;\n
;;;;;; 2) ��� Y;\n
;;;;;; 3) ����� � ����������� ���� X-Y." "�����")
(defun c:mnas-axis-point-to-screen  (/ p scx scy)
    (mnas-axis:show-prompt mnas-axis:point-to-screen-prompt)
  (setq scx (axis:get (axis:sel "��� X:"))
        scy (axis:get (axis:sel "��� Y:")))
  (while (setq p (getpoint "������� ����� P :")
               p (sc:pt_pxy p scx scy))
    (print p)
    (dr:point p 256)))

;;;;;;("a5" "��. mnas-axis-point-to-screen." "�����")
(defun c:a5 () (c:mnas-axis-point-to-screen))

;;;;;;("mnas-axis-point-to-another-axis"
;;;;;;"������� ����� �� ��������� ����� ���� ����\n
;;;;;; � ���������� ������ ���� ����.\n
;;;;;; ��������:\n
;;;;;; 1) ��� � �� ������� ������� �����;\n
;;;;;; 2) ��� Y �� ������� ������� �����;\n
;;;;;; 3) ��� � � ������� �������� �����;\n
;;;;;; 4) ��� Y � ������� �������� �����;\n
;;;;;; 5) ����� � ����������� ���� X-Y." "�����")
(defun c:mnas-axis-point-to-another-axis  (/ p scx0 scx1 scy0 scy1)
  (mnas-axis:show-prompt mnas-axis:point-to-another-axis-prompt)
  (setq	scx0 (axis:get (axis:sel "��� X_from"))
	scy0 (axis:get (axis:sel "��� Y_from"))
	scx1 (axis:get (axis:sel "��� X_to"))
	scy1 (axis:get (axis:sel "��� Y_to")))
  (while (setq p (getpoint "������� ����� P:"))
    (setq p (sc:pt_pxy p scx0 scy0))
    (dr:point (sc:pxy_pt p scx1 scy1) 256)))

;;;;;;("a6" "��. mnas-axis-point-to-another-axis" "�����")
(defun c:a6 () (c:mnas-axis-point-to-another-axis))

;;;;;;("mnas-axis-point-value" "����������� �������� �� ����� �� �����." "�����")
(defun c:mnas-axis-point-value  (/ sx scx v pt)
  (mnas-axis:show-prompt mnas-axis:point-value-prompt)
  (setq	sx  (axis:sel "��� X:")
	scx (axis:get sx)
	pt  (getpoint "\n������� �����:")
	v   (sc:pt_val pt scx))
  (dr:point pt 1)
  (princ v)
  (princ))

;;;;;;("c2" "��. mnas-axis-point-value." "�����")
(defun c:c2 () (c:mnas-axis-point-value))

;;;;;;("mnas-axis-point-value-xy" "������� ���������� ���������� �����." "�����")
(defun c:mnas-axis-point-value-xy  (/ sx scx sy scy pxy pt)
  (mnas-axis:show-prompt mnas-axis:point-value-xy-prompt )
  (setq	sx  (axis:sel "����� x")
	scx (axis:get sx)
	sy  (axis:sel "����� y")
	scy (axis:get sy))
  (while (setq pt (getpoint "\n ������� ����� � �� ������:"))
    (setq pxy (sc:pt_pxy pt scx scy))
    (princ "pxy")
    (princ pxy)
    (dr:point pt 2)))

;;;;;;("c4" "��. mnas-axis-point-value-xy" "�����")
(defun c:c4 () (c:mnas-axis-point-value-xy))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defun c:mnas-axis-graph-xy-names  (/  names-str str x-axis-data xy-point-name y-axis-data)
  (axis:load-reset-point-types)
  (mnas-axis:show-prompt mnas-axis:graph-xy-names-prompt)
  (setq x-axis-data (axis:get (axis:sel "��� X"))
        y-axis-data (axis:get (axis:sel "��� Y"))
        str         (getstring "\n��� ���������� ���������� ������ �����:"))
  (print (vl-doc-ref (read str)))
  (setq names-str (vl-doc-ref (read str)))
)

(defun c:mnas-axis-multiple-graph  (/ str-x str-y-n)
  (setq str-x   (vl-doc-ref (read (getstring "\n��� ����������, ���������� ��� ��� �:")))
        str-y-n (vl-doc-ref (read (getstring "\n��� ����������, ���������� ������:"))))
  (axis:draw-multiple-graphs-by-axis-names str-x str-y-n))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun c:mnas-axis-text-podp  (/ axis-data ang p0 p1 txt)
;;;;
  (setq axis-data (axis:get (axis:sel "�������� ���:"))
        p0        (cdr (assoc 10 axis-data))
        p1        (cdr (assoc 11 axis-data))
        txt       (cdr (assoc 1 axis-data))
        ang       (angle p0 p1))
  (dr:text txt (mid-point p0 p1) "3.15" ang 256))

(defun c:mnas-axis-select-by-name () (axis:get (axis:sel-by-name (getstring "��� ���:"))))


(defun c:mnas-axis-mathprop   (/ axis-data ang p0 p1 txt)
;;;; (40 . 0.0) (41 . 2000.0) (70 . 0)
  (setq axis-from        (axis:sel "��� ��� ������������� �������")
        axis-data (axis:get axis-from)
	axis-to        (axis:sel "��� ��� ������������� �������")
        p0        (cdr (assoc 10 axis-data))
        p1        (cdr (assoc 11 axis-data))
        txt       (cdr (assoc 1 axis-data))
        ang       (angle p0 p1))
  (dr:text txt (mid-point p0 p1) "3.15" ang 256))

 
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