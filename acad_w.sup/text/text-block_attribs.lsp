(setq color_size
       '((0 . 14)
	 (1 . 24)
	 (2 . 34)
	 (3 . 44)
	 (4 . 54)
	 (5 . 64)
	 (6 . 74)
	 (7 . 84)
	 (8 . 94)
	 (9 . 104)
	 (10 . 114)
	 (11 . 124)))

(defun c:normalize_attrib (/ ed en)
  (setq	en (car (entsel "Выберите блок с атрибутами:"))
	ed (entget en))
  (if (/= "INSERT" (cdr (assoc 0 ed)))
    (progn (princ "Объект не является блоком!") (exit)))
  (normalize_attrib en))

(defun normalize_attrib	 (en / ed)
  (if (null (setq en (entnext en)))
    (exit)
    (setq ed (entget en)))
  (while (= "ATTRIB" (cdr (assoc 0 ed)))
    (setq ed (entget en))
    (princ ed)
    (setq en (entnext en))
    (ch_hight ed 1.0)))

(defun c:norm_attr  (/ ed en)
  (setq	en (car (nentsel "Выберите атрибут блока:"))
	ed (entget en))
  (if	(is_text ed)
      (ch_hight ed 1.0)))


(defun c:normalaize  (/ ed en)
  (prompt "Выберите текстовые объекты:")
  (setq	ss (ssget)
	i  (sslength ss))
  (while (<= 0 (setq i (1- i)))
    (setq en (ssname ss i)
	  ed (entget en))
    (cond ((is_text ed) (ch_hight ed 1.0))
	  ((is_insert ed) (normalize_attrib en)))))


(defun is_text (ed) (or (= "ATTRIB" (cdr (assoc 0 ed))) (= "TEXT" (cdr (assoc 0 ed)))))
(defun is_insert (ed) (= "INSERT" (cdr (assoc 0 ed))))
  
(defun ch_hight	 (ed sc / color_new size_new sz_ncol)
  (setq	sz_ncol	  (text_normalize (cdr (assoc 40 ed)) sc)
	size_new  (car sz_ncol)
	color_new (cdr (assoc (cadr sz_ncol) color_size ))
        ed (dsubst  ed (list (cons 62 color_new))))
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

(defun text_normalize  (x sc / rez rez_i a b ia ib i sg sizes)
  (setq	rez   1.75
	rez_i 0
	sizes (scaled_text_size_lst sc)
	i     (length sizes))
  (while (<= 1 (setq i (1- i)))
    (setq ib i
	  ia (1- i)
	  b  (nth ib sizes)
	  a  (nth ia sizes)
	  sg (sqrt (* a b)))
    (cond ((<= a sg x b)
	   (setq rez b
		 rez_i ib))
	  ((<= a x sg b)
	   (setq rez a
		 rez_i ia))))
  (list rez rez_i))


(defun scaled_text_size_lst  (scl / tsz)
  (setq tsz (text_size_lst))
  (mapcar (function (lambda (sc el) (* el sc)))
	  (value-list-multiplier scl tsz)
	  tsz))
