;;;;;;("ch_wid"
;;;;;;"Обводка примитивов.
;;;;;; Описание :
;;;;;; Производит обводку задаваемых примитивов полилиниями
;;;;;; с задаваемой толщиной.
;;;;;; Могут обводиться следующие типы примитивов:
;;;;;; LINE ARC CIRCLE SPLINE PLINE LWPLINE
;;;;;; При значении системной переменной \"delobj\"=1
;;;;;; Удаляются исходные примитивы типов : LINE; ARC; CIRCLE; SPLINE.
;;;;;; При значении системной переменной \"delobj\"=0
;;;;;; Исходные примитивы не удаляются.
;;;;;; При обводке примитивов типа SPLINE может измениться форма полилинии,
;;;;;; если точки исходного SPLINE имели различный вес или если он был замкнутым." "Измени")
(defun c:ch_wid	 (/ li w nli i en ed ty p1 p2 cen rad as ae ps pe di do del_elem)
  (setvar "cmdecho" 0)
  (command "_.redraw")
  (command "_.undo" "_begin")
  (prompt "\nОбъекты для обводки:")
  (setq li (ssget))
  (setq w (getdist "\nТолщина:"))
  (setq nli (- (sslength li) 1))
  (setq i 0)
  (command "_.ucs" "_w")
  (while (<= i nli)
    (setq en	   (ssname li i)
	  ed	   (entget en)
	  ty	   (cdr (assoc 0 ed))
	  del_elem nil)
    (cond ((= ty "LINE") (ch:ln_pl ed w) (setq del_elem t))
	  ((= ty "ARC") (ch:ar_pl ed w) (setq del_elem t))
	  ((= ty "CIRCLE") (ch:cl_pl ed w) (setq del_elem t))
	  ((= ty "SPLINE") (ch:sp_pl ed w) (setq del_elem t))
	  ((or (= ty "POLYLINE") (= ty "LWPOLYLINE")) (ch:lw_pl en w)))
    (if	(and del_elem (= (getvar "delobj") 1))
      (command "_.erase" en ""))
    (setq i (+ i 1)))
  (command "_.ucs" "_p")
  (command "_.undo" "_end")
  (setvar "cmdecho" 1)
  (if (= (getvar "delobj") 0)
    (command "select" li)))

;;	ch:sp_pl - преобразование сплайна в полилинию.
(defun ch:sp_pl	 (ed wid / tmp pt en)
  (mapcar (function
	    (lambda (el) (cond ((= (car el) 10) (setq tmp (cons (list (cadr el) (caddr el)) tmp)))) t))
	  (member (assoc 10 ed) ed))
  (dr:pline tmp 256)
  (setq	en (entlast)
	la (cdr (assoc 8 ed))
	co (cdr (assoc 62 ed))
	co (cond ((null co) "bylayer")
		 ((= 0 co) "byblock")
		 (t co))
	lt (cdr (assoc 6 ed))
	lt (cond ((null lt) "bylayer")
		 (t lt)))
  (command "chprop" en "" "c" co "la" la "lt" lt "")
  (command "_.pedit" en "_l" "_on" "_w" wid "s" ""))

(defun ch:ln_pl	 (ed wid / p1 p2)
  (setq	p1 (cdr (assoc 10 ed))
	p2 (cdr (assoc 11 ed)))
  (command "_.pline" "_non" p1 "_w" wid wid "_non" p2 "")
  (command "matchprop" (dxf-get -1 ed) (entlast) ""))

(defun ch:ar_pl	 (ed wid / cen rad as ae ps pe)
  (setq	cen (cdr (assoc 10 ed))
	rad (cdr (assoc 40 ed))
	as  (cdr (assoc 50 ed))
	ae  (cdr (assoc 51 ed))
	ps  (polar cen as rad)
	pe  (polar cen ae rad))
  (command "_.pline" "_non" ps "_w" wid wid "_a" "_ce" "_non" cen "_non" pe "")
  (command "matchprop" (dxf-get -1 ed) (entlast) ""))

(defun ch:cl_pl	 (ed wid / cen rad di do)
  (setq	cen (cdr (assoc 10 ed))
	rad (cdr (assoc 40 ed))
	di  (- (* rad 2.) wid)
	do  (+ (* rad 2.) wid))
  (command "_.donut" di do "_non" cen "")
  (command "matchprop" (dxf-get -1 ed) (entlast) ""))

(defun ch:lw_pl (en wid) (command "_.pedit" en "_w" wid "_x"))
