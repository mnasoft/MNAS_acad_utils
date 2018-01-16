;;;Cadalyst CAD Tips www.cadalyst.com/cadtips December 2008 (c) by the Author and Cadalyst

;;;Author: Pedro Miguel da Silva Ferreira Email:pedro_ferreira@netcabo.pt or pferreira@wsatkins.pt
;;;Web page: http://pwp.netcabo.pt/pedro_ferreira
;;;Location: Portugal, Lisboa
;;;RDS: PMSF
;;;Command Name: txt2xls
;;;Date: 10 of May 2008
;;;Version: 1.0
;;;Description: Visual Lisp Routine that writes to an excel file the selected text

(defun c:txt2xls () (vl-load-com) (init-excel) (selecttext) (princ))

(defun selecttext  ()
  (princ "\nSelect text: ")
  (setq pt1 (getpoint "\nSpecify first corner: "))
  (setq pt2 (getcorner pt1 "Specify opposite corner:"))
  (setq sstext (ssget "_w" pt1 pt2 '((0 . "text"))))
  (setq lengthsstext (sslength sstext))
  (setq count 0)
  (setq textlist nil)
  (repeat lengthsstext
    (setq Text	     (vlax-ename->vla-object (cdr (car (entget (ssname sstext count)))))
	  TextPoint  (vlax-get-property Text 'insertionpoint)
	  textString (vlax-get-property Text 'textstring)
	  listText   (append (vlax-safearray->list (vlax-variant-value textpoint)) (list textstring))
	  textlist   (append textlist (list listtext))
	  count	     (1+ count)))
  (alert "Length and Heigth error calculation, select two entities in the same column!")
  (setq	pt1 (vlax-safearray->list
	      (vlax-variant-value
		(vlax-get-property (vlax-ename->vla-object (cdr (car (entget (car (entsel)))))) 'insertionpoint))))
  (setq	pt2 (vlax-safearray->list
	      (vlax-variant-value
		(vlax-get-property (vlax-ename->vla-object (cdr (car (entget (car (entsel)))))) 'insertionpoint))))
  (setq	calY (- (abs (- (cadr pt1) (cadr pt2))) 0.001)
	calX (- (abs (- (car pt1) (car pt2))) 0.001))
  (setq fuzzY (getreal (strcat "\nHeigth error value <" (rtos calY) ">, select other: ")))
  (if (= fuzzY nil)
    (setq fuzzY calY))
  (setq fuzzX (getreal (strcat "\nLength error value <" (rtos calX) ">, select other: ")))
  (if (= fuzzX nil)
    (setq fuzzX calX))
;;;ordenado por x
  (setq textlist (vl-sort textlist (function (lambda (e1 e2) (< (car e1) (car e2))))))
  (setq textlistlength (length textlist))
  (setq count 0)
  (setq countcol 1)
  (while (< count textlistlength)
    (progn (setq smalllist  (nth count textlist)
		 valuex	    (car (nth count textlist))
		 nextvaluex (car (nth (1+ count) textlist)))
	   (setq smalllist (subst (itoa countcol) valuex smalllist))
	   (setq textlist (subst smalllist (nth count textlist) textlist))
	   (while (equal nextvaluex valuex fuzzX)
	     (progn (setq count (1+ count))
		    (setq smalllist  (nth count textlist)
			  valuex     (car (nth count textlist))
			  nextvaluex (car (nth (1+ count) textlist)))
		    (setq smalllist (subst (itoa countcol) valuex smalllist))
		    (setq textlist (subst smalllist (nth count textlist) textlist))
		    (if	(= nextvaluex nil)
		      (setq nextvaluex (1+ valuex)))))
	   (if (> nextvaluex valuex)
	     (progn (setq count (1+ count)) (setq countcol (1+ countcol))))))
;;;ordenado por y
  (setq textlist (vl-sort textlist (function (lambda (e1 e2) (> (cadr e1) (cadr e2))))))
  (setq textlistlength (length textlist))
  (setq count 0)
  (setq countrow 1)
  (while (< count textlistlength)
    (progn (setq smalllist  (nth count textlist)
		 valuey	    (cadr (nth count textlist))
		 nextvaluey (cadr (nth (1+ count) textlist)))
	   (setq smalllist (subst (itoa countrow) valuey smalllist))
	   (setq textlist (subst smalllist (nth count textlist) textlist))
	   (while (equal nextvaluey valuey fuzzY)
	     (progn (setq count (1+ count))
		    (setq smalllist  (nth count textlist)
			  valuey     (cadr (nth count textlist))
			  nextvaluey (cadr (nth (1+ count) textlist)))
		    (setq smalllist (subst (itoa countrow) valuey smalllist))
		    (setq textlist (subst smalllist (nth count textlist) textlist))
		    (if	(= nextvaluey nil)
		      (setq nextvaluey (1+ valuey)))))
	   (if (< nextvaluey valuey)
	     (progn (setq count (1+ count)) (setq countrow (1+ countrow))))))
  (setq textlistlength (length textlist))
  (setq count 0)
  (while (< count textlistlength)
    (progn (setq colstring (cadddr (nth count textlist)))
	   (setq posx (atoi (car (nth count textlist)))
		 posy (atoi (cadr (nth count textlist))))
	   (write-row-column posy posx colstring)
	   (setq count (1+ count))))
  (princ))

(defun init-excel  (/ excel-app wb-collection workbook sheets sheet1)
  (setq excel-app (vlax-create-object "excel.application"))
  (setq wb-collection (vlax-get excel-app "workbooks"))
  (setq workbook (vlax-invoke-method wb-collection "add"))
  (setq sheets (vlax-get workbook "sheets"))
  (setq sheet1 (vlax-get-property sheets "item" 1))
  (setq *excel-cells* (vlax-get sheet1 "cells"))
  (vlax-put excel-app "visible" 1))

(defun write-row-column	 (row col x)
  (vlax-put-property *excel-cells* 'Item row col (vl-princ-to-string x)))

(alert
  "Type [txt2xls] in the command line\n\nAuthor: Pedro Ferreira
  web page: http://pwp.netcabo.pt/pedro_Ferreira
  THIS PROGRAM IS PROVIDED \"AS IS\" AND WITH ALL FAULTS.
  Press OK to continue.")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





