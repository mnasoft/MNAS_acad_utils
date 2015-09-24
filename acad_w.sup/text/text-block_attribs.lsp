(setq color_size '((0 . 14) ; 1.8
		   (1 . 34) ; 2.0
		   (2 . 54) ; 2.5
		   (3 . 74) ; 3.5
		   (4 . 94) ; 5.0
		   (5 . 114) ; 7.0
		   (6 . 134) ; 10.0
		   (7 . 154) ; 14.0
		   (8 . 174) ; 20.0
		   (9 . 194) ; 28.0
		   (10 . 214) ; 40.0
		   (11 . 234))) ; 56.0

(defun c:attrnorms  (/ ed en)
  (setq	en (car (entsel "Выберите блок с атрибутами:"))
	ed (entget en))
  (if (/= "INSERT" (cdr (assoc 0 ed)))
    (progn (princ "Объект не является блоком!") (exit)))
  (if (null (setq en (entnext en)))
    (exit)
    (setq ed (entget en)))
  (while (= "ATTRIB" (cdr (assoc 0 ed)))
    (setq ed (entget en))
    (princ ed)
    (setq en (entnext en))
    (ch_hight ed 1.0)))

(defun c:attrnorm  (/ ed en)
  (setq	en (car (nentsel "Выберите атрибут блока:"))
	ed (entget en))
  (if (is_text ed)
    (ch_hight ed 1.0)))

(defun is_text	(ed)
  (or (= "ATTRIB" (cdr (assoc 0 ed)))
      (= "TEXT" (cdr (assoc 0 ed)))
      (= "MTEXT" (cdr (assoc 0 ed)))
      (= "ATTDEF" (cdr (assoc 0 ed)))))

(defun ch_hight	 (ed sc / color_new size_new sz_ncol)
  (setq	sz_ncol	  (text_normalize (cdr (assoc 40 ed)) sc)
	size_new  (car sz_ncol)
	color_new (cdr (assoc (cadr sz_ncol) color_size))
	ed	  (dsubst ed (list (cons 62 color_new) (cons 40 size_new))))
  (entmod ed))

(defun text_size_lst  (/ rez)
  (setq	n  7
	sz 80.0)
  (while (< 0 (setq n (1- n)))
    (setq rez (cons sz rez)
	  sz  (* sz (/ 7.0 10.0))
	  rez (cons sz rez)
	  sz  (* sz (/ 5.0 7.0))))
  rez)

(defun text_normalize  (x
     ; Высота символов шрифта, которые необходимо нормализовать.
			sc
     ; Масштабный фактор нормализации шрифта д.б. sc = высота - 0,5 * толщина
			/ rez rez_i a b	i sg sizes xsc)
  (setq	rez   1.75
	rez_i 0
	sizes (text_size_lst)
	i     (length sizes)
	xsc   (/ x sc))
  (while (<= 1 (setq i (1- i)))
    (setq b  (nth i sizes)
	  a  (nth (1- i) sizes)
	  sg (sqrt (* a b)))
    (cond ((<= a sg xsc b)
	   (setq rez b
		 rez_i i))
	  ((<= a xsc sg b)
	   (setq rez   a
		 rez_i (1- i)))))
  (list (* rez sc) rez_i))


(defun c:textnorm  (/ ed en)
  (setq	en (car (nentsel "ТЕКСТ или МТЕКСТ:"))
	ed (entget en)
	sc (cond ((null (space)) 1.0)
		 ((= 0 (getvar "dimscale")) 1.0)
		 (t (getvar "dimscale"))))
  (if (is_text ed)
    (ch_hight ed sc)))

(defun add_block_attrib	 (en)
  (cond
    ((= "INSERT" (cdr (assoc 0 (entget en))))
     (ssdel en ss)
     (setq i (1- i))
     (setq en (entnext en))
     (while (and en (= "ATTRIB" (cdr (assoc 0 (entget en)))))
       (ssadd en ss)
       (setq en (entnext en))
       )))
  (sslength ss))


(defun c:textnorms  (/ ed en)
  (prompt "ТЕКСТ или МТЕКСТ:")
  (setq	ss (ssget '((-4 . "<OR")
		    (0 . "MTEXT")
		    (0 . "TEXT")
		    (0 . "INSERT")
		    (-4 . "OR>")))
	i  0)
  (while (< i (sslength ss))	
    (setq en (ssname ss i))
    (add_block_attrib en)
    (setq ed (entget en)
	  sc (cond ((null (space)) 1.0)
		   ((= 0 (getvar "dimscale")) 1.0)
		   (t (getvar "dimscale"))))
    (if	(is_text ed)
      (ch_hight ed sc))
    (setq i (1+ i))))

(defun c:tn () (c:textnorm))
(defun c:tns () (c:textnorms))

(defun c:tmatchprop  ()
  (setq	en (car (nentsel "\nSelect reference TEXT МТЕКСТ ATTRIB:"))
	ed (entget en))
  (princ "\nReference hight=") (princ (dxf-get 40 ed)) (princ "\n")
  (while (setq en1 (car (nentsel "\nSelect taget TEXT МТЕКСТ ATTRIB:")))
    (princ "\nReference hight=") (princ (dxf-get 40 ed)) (princ "\n")
    (setq ed1 (entget en1))
    (entmod (dxf-set 40 (dxf-get 40 ed) ed1))))

(defun c:tma () (c:tmatchprop))

;
;|«Visual LISP© Format Options»
(120 2 5 0 nil "end of" 100 9 0 0 0 T T nil T)
;*** НЕ добавляйте текст под комментариями! ***|;
