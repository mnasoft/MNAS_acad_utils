;;;   AKIMA.LSP
;;;   Copyright (c)1993-95 Christoph Candido, Vienna, Austria
;;;
;;;   Rev.:  01.04.93
;;;
;;;   AKIMA-Interpolation for AutoCAD 2d-Polylines.
;;;   Calculates interpolation curves that look much better than
;;;   fitted curves or splines. It was developed to simulate the
;;;   process of connecting points by hand, like a professional
;;;   draftsman would do.
;;;
;;;   While drawing the interpolation curve, the setting of the sysvar
;;;   SPLINESEGS will be considered. The interpolation can be undone
;;;   with the command _.PEDIT _DECURVE.
;;;
;;;   Restriction:
;;;
;;;    The routine can't be used with closed polylines.
;;;    The X-Values of the Vertexes must continually increase or
;;;    decrease.
;;;
;;;--------------------------------------------------------------------
;;;  Permission to use, copy, modify, and distribute this software
;;;  for any purpose and without fee is hereby granted, provided
;;;  that the above copyright notice appears in all copies and that
;;;  both that copyright notice and this permission notice appear in
;;;  all supporting documentation.
;;;
;;;  THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED
;;;  WARRANTY.  ALL IMPLIED WARRANTIES OF FITNESS FOR ANY PARTICULAR
;;;  PURPOSE AND OF MERCHANTABILITY ARE HEREBY DISCLAIMED.
;;;
(defun extra_pol  (/     n     x1	   x2	 x4    x5    xn
		   xn+1	 xn+2  xn+3  xn+4  i	 st    l     y1
		   y2	 yn+2  yn+3  yn+4  st1	 st2   stn+2 stn+3)
  (setq	n      (length vlist)
	xlist  '()
	ylist  '()
	stlist '())
  (setq	xlist (mapcar 'car vlist)
	ylist (mapcar 'cadr vlist))
  ;; *** Calculate the extrapolated X-Values right and left ***
  (setq	x3   (car xlist)
	x4   (cadr xlist)
	x5   (caddr xlist)
	xn+2 (last xlist)
	xn+1 (nth (- n 2) xlist)
	xn   (nth (- n 3) xlist)
	x2   (- (+ x3 x4) x5)
	x1   (- (+ x2 x3) x4)
	xn+3 (- (+ xn+2 xn+1) xn)
	xn+4 (- (+ xn+3 xn+2) xn+1)
	i    0)
  ;; *** Calculate the gradients ***
  (while (< i (1- n))
    (setq st	 (/ (- (nth (1+ i) ylist) (nth i ylist))
		    (- (nth (1+ i) xlist) (nth i xlist)))
	  i	 (1+ i)
	  stlist (cons st stlist)))
  (setq stlist (reverse stlist))
  ;; *** Calculate the extrapolated Y-Values and gradients
  ;;     left and right ***
  (setq	l      (length stlist)
	y3     (car ylist)
	y2     (+ (* (- x3 x2) (- (cadr stlist) (* 2 (car stlist)))) y3)
	st2    (/ (- y3 y2) (- x3 x2))
	y1     (+ (* (- x2 x1) (- (car stlist) (* 2 st2))) y2)
	st1    (/ (- y2 y1) (- x2 x1))
	yn+2   (last ylist)
	yn+3   (+ (* (- (* 2 (last stlist)) (nth (- l 2) stlist))
		     (- xn+3 xn+2))
		  yn+2)
	stn+2  (/ (- yn+3 yn+2) (- xn+3 xn+2))
	yn+4   (+ (* (- (* 2 stn+2) (last stlist)) (- xn+4 xn+3)) yn+3)
	stn+3  (/ (- yn+4 yn+3) (- xn+4 xn+3))
	stlist (append (list st1 st2) stlist (list stn+2 stn+3))))

(defun akima  (vlist  /	     i	    l	   tlist  alist	 blist	clist
	       dlist  nenner j	    segs   x_ab	  x	 y	z)
  (extra_pol)
  (setq	i     0
	tlist '()
	alist '()
	blist '()
	clist '()
	dlist '())
  (while (< i (setq l (length vlist))) ; (<= i (+ n 2))
    (if	(and (= (nth i stlist) (nth (1+ i) stlist))
	     (= (nth (+ i 2) stlist) (nth (+ i 3) stlist)))
      (setq tlist
	     (cons (* 0.5
		      (+ (nth (+ i 3) stlist) (nth (+ i 2) stlist)))
		   tlist))
      (setq tlist
	     (cons
	       (/
		 (+
		   (* (abs (- (nth (+ i 3) stlist)
			      (nth (+ i 2) stlist)))
		      (nth (1+ i) stlist))
		   (*
		     (abs (- (nth (1+ i) stlist) (nth i stlist)))
		     (nth (+ i 2) stlist)))
		 (+ (abs (- (nth (+ i 3) stlist)
			    (nth (+ i 2) stlist)))
		    (abs (- (nth (1+ i) stlist) (nth i stlist)))))
	       tlist)))
    (setq i (1+ i)))
  (setq tlist (reverse tlist))
  (setq i 0)
  (while (< i (1- l))
    (setq alist	 (cons (nth i ylist) alist)
	  blist	 (cons (nth i tlist) blist)
	  nenner (- (nth (1+ i) xlist) (nth i xlist))
	  clist	 (if (= 0 nenner)
		   (cons 1000000.0 clist)
		   (cons (/ (- (* 3 (nth (+ i 2) stlist))
			       (* 2 (nth i tlist))
			       (nth (1+ i) tlist))
			    nenner)
			 clist))
	  nenner (* (- (nth (1+ i) xlist) (nth i xlist))
		    (- (nth (1+ i) xlist) (nth i xlist)))
	  dlist	 (if (= 0 nenner)
		   (cons 1000000.0 dlist)
		   (cons (/ (- (+ (nth i tlist) (nth (1+ i) tlist))
			       (* 2 (nth (+ i 2) stlist)))
			    nenner)
			 dlist))
	  i	 (1+ i)))
  (setq	alist (reverse alist)
	blist (reverse blist)
	clist (reverse clist)
	dlist (reverse dlist)
	i     0
	j     1
	vlist '()
	vlist (cons (list x3 y3) vlist)
	segs  (getvar "SPLINESEGS"))
  (while (< i (1- l))
    (setq x_ab (/ (- (nth (1+ i) xlist) (nth i xlist)) segs))
    (while (<= j segs)
      (setq x	  (+ (nth i xlist) (* j x_ab))
	    y	  (+ (nth i alist)
		     (* (nth i blist) (- x (nth i xlist)))
		     (* (nth i clist) (expt (- x (nth i xlist)) 2))
		     (* (nth i dlist) (expt (- x (nth i xlist)) 3)))
	    z	  0.0
	    j	  (1+ j)
	    vlist (cons (list x y z) vlist)))
    (setq j 1
	  i (1+ i)))
  (reverse vlist))
;;---------------------------------------------------------------------------
(defun C:AKIMA	(/ *akima_err* oerr vlist elist en alist head)
  (defun *akima_err* (s) (setq *error* oerr) (princ))
  (setq	oerr	*error*
	*error*	*akima_err*)
  (princ (strcat "\nAkima-Interpolation (SPLINESEGS == "
		 (itoa (getvar "SPLINESEGS"))
		 "): "))
  (setq	vlist '()
	elist '())
  (princ "\nPick 2d-Polyline/<Exit>: ")
  (initget " ")
  (while (null (setq en (entsel ""))) (princ "\007"))
  (if (/= "" en)
    (progn
      (setq en	  (car en)
	    alist (entget en '("*")) ; read all XED's  '("*")
	    )
      ;; Entity is a closed 2d-Polyline?:
      (if (and (= "POLYLINE" (cdr (assoc 0 alist)))
	       (= 0 (logand 89 (cdr (assoc 70 alist)))))
	(progn
	  (setq	head  alist
		en    (entnext en)
		alist (entget en '("*")))
	  ;; Create list of Vertexes:
	  (while (/= "SEQEND" (cdr (assoc 0 alist)))
	    (if	(or (= 0 (cdr (assoc 70 alist)))
		    (= 16 (cdr (assoc 70 alist))))
	      (setq vlist (cons
			    (reverse
			      (cdr (reverse (cdr (assoc 10 alist)))))
			    vlist)
		    elist (cons alist elist)))
	    (setq en	(entnext en)
		  alist	(entget en '("*"))))
	  (setq	elist (reverse elist)
		vlist (reverse vlist))
	  ;; Akima-Interpolation:
	  (setq vlist (akima vlist))
	  ;; Actualize Group 70 and 75 Bit-Codes:
	  (setq	head (subst '(70 . 4) (assoc 70 head) head)
		head (subst '(75 . 6) (assoc 75 head) head))
	  ;; Delete old Polyline:
	  (entdel (cdar head))
	  ;; Create new Polyline:
	  (entmake head)
	  (foreach n  vlist
	    (entmake (list '(0 . "VERTEX") (cons 10 n) '(70 . 8))))
	  (foreach n  elist
	    (entmake (subst '(70 . 16) (assoc 70 n) n)))
	  (entmake '((0 . "SEQEND")))
	  (princ))
	(princ "\007 * invalid entity * "))))
  (setq *error* *akima_err*)
  (princ))
(princ "\nAKIMA-Interpolation")
(princ "\n(c)1995  Christoph Candido, 1070 Vienna")
(princ "\nE-Mail: h8540418@edv1.boku.ac.at")
(princ
  "\nUniversity of Agricultural Sciences, Vienna, Austria")
(princ "\nStart command with AKIMA.")
(princ)

(defun c:akima_1  (/ data assa)
  (setq	vlist nil
	assa (entget (car (entsel "Выберите полилинию:"))))
  (mapcar (function (lambda (el)
		      (if (= 10 (car el))
			(setq vlist (cons (cdr el) vlist)))))
	  assa)
  (extra_pol)
  (dr:pline (akima  vlist) 2))


