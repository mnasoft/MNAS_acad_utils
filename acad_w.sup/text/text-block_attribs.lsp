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
		 ((= 0 (getvar "dimscale")) 1.0 )
		 (t (getvar "dimscale"))))
  (if (is_text ed)
    (ch_hight ed sc)))

(defun c:tn () (c:textnorm))

     ;