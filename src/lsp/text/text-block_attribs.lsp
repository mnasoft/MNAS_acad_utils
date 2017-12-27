(setq color_size
       '((0 . 14)                       ; 1.8
         (1 . 34)                       ; 2.0
         (2 . 54)                       ; 2.5
         (3 . 74)                       ; 3.5
         (4 . 94)                       ; 5.0
         (5 . 114)                      ; 7.0
         (6 . 134)                      ; 10.0
         (7 . 154)                      ; 14.0
         (8 . 174)                      ; 20.0
         (9 . 194)                      ; 28.0
         (10 . 214)                     ; 40.0
         (11 . 234)))                   ; 56.0

;;;;;;("attrnorm"
;;;;;;"Производит нормализацию и раскрашивание одного из атрибутов вставки блока." "Тексты")
(defun c:attrnorm  (/ ed en)
  (setq en (car (nentsel "Выберите атрибут блока:"))
        ed (entget en))
  (if (is_text ed)
    (ch_hight ed 1.0)))

(defun is_text  (ed)
  (or (= "ATTRIB" (cdr (assoc 0 ed)))
      (= "TEXT" (cdr (assoc 0 ed)))
      (= "MTEXT" (cdr (assoc 0 ed)))
      (= "ATTDEF" (cdr (assoc 0 ed)))))

(defun ch_hight  (ed sc / color_new size_new sz_ncol)
  (setq sz_ncol   (text_normalize (cdr (assoc 40 ed)) sc)
        size_new  (car sz_ncol)
        color_new (cdr (assoc (cadr sz_ncol) color_size))
        ed        (dsubst ed (list (cons 62 color_new) (cons 40 size_new))))
  (entmod ed))

(defun text_size_lst  (/ rez n sz)
  (setq n  7
        sz 80.0)
  (while (< 0 (setq n (1- n)))
    (setq rez (cons sz rez)
          sz  (* sz (/ 7.0 10.0))
          rez (cons sz rez)
          sz  (* sz (/ 5.0 7.0))))
  (mapcar (function(lambda (el) (* 0.9 el))) rez))

(defun text_normalize  (x               ; Высота символов шрифта, которые необходимо нормализовать.
                        sc              ; Масштабный фактор нормализации шрифта д.б. sc = высота - 0,5 * толщина
                        / rez rez_i a b i sg sizes xsc)
  (setq rez   1.75
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

;;;;;;("textnorm"
;;;;;;"Производит нормализацию высоты и раскрашивание одиночного текста, мультитекста, атрибута вставки блока." "Тексты")
(defun c:textnorm  (/ ed en sc)
  (setq en (car (nentsel "ТЕКСТ или МТЕКСТ:"))
        ed (entget en)
        sc (cond ((null (space)) 1.0)
                 ((= 0 (getvar "dimscale")) 1.0)
                 (t (getvar "dimscale"))))
  (if (is_text ed)
    (ch_hight ed sc)))

(defun add_block_attrib  (en ss i)
  (cond ((= "INSERT" (cdr (assoc 0 (entget en))))
         (ssdel en ss)
         (setq i (1- i))
         (setq en (entnext en))
         (while (and en (= "ATTRIB" (cdr (assoc 0 (entget en))))) (ssadd en ss) (setq en (entnext en)))))
  i)

;;;;;;("textnorms"
;;;;;;"Производит нормализацию высоты и раскрашивание текстов, мультитекстов, атрибутов вставки блока." "Тексты")
(defun c:textnorms  (/ ed en ss i sc)
  (prompt "ТЕКСТ или МТЕКСТ:")
  (setq ss (ssget '((-4 . "<OR") (0 . "MTEXT") (0 . "TEXT") (0 . "INSERT") (-4 . "OR>")))
        i  0)
  (while (< i (sslength ss))
    (setq en (ssname ss i))
    (setq i (add_block_attrib en ss i))
    (setq ed (entget en)
          sc (cond ((null (space)) 1.0)
                   ((= 0 (getvar "dimscale")) 1.0)
                   (t (getvar "dimscale"))))
    (if (is_text ed)
      (ch_hight ed sc))
    (setq i (1+ i))))


;;;;;;("textnorm"
;;;;;;"Производит нормализацию высоты и раскрашивание одиночного текста, мультитекста, атрибута вставки блока
;;;;;;Является аббревиатурой команды  textnorm." "Тексты")
(defun c:tn () (c:textnorm))

;;;;;;("tns"
;;;;;;"Производит нормализацию высоты и раскрашивание текстов, мультитекстов, атрибутов вставки блока.
;;;;;;Является аббревиатурой команды  textnorms." "Тексты")
(defun c:tns () (c:textnorms))

;;;;;;("tmatchprop"
;;;;;;"Устанавливет высоту для отдельного текса, мультитекста, атрибута вставки блока по высоте ссылочного объекта." "Тексты")
(defun c:tmatchprop  (/ ed ed1 en en1)
  (setq en (car (nentsel "\nSelect reference TEXT МТЕКСТ ATTRIB:"))
        ed (entget en))
  (princ "\nReference hight=")
  (princ (dxf-get 40 ed))
  (princ "\n")
  (while (setq en1 (car (nentsel "\nSelect taget TEXT МТЕКСТ ATTRIB:")))
    (princ "\nReference hight=")
    (princ (dxf-get 40 ed))
    (princ "\n")
    (setq ed1 (entget en1))
    (entmod (dxf-set 40 (dxf-get 40 ed) ed1))))

;;;;;;("tma"
;;;;;;"Устанавливет высоту для отдельного текса, мультитекста, атрибута вставки блока по высоте ссылочного объекта.
;;;;;;Является аббревиатурой команды  tmatchprop." "Тексты")
(defun c:tma () (c:tmatchprop))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;("textnorm"
;;;;;;"Производит нормализацию высоты и раскрашивание одиночного текста, мультитекста, атрибута вставки блока." "Тексты")

(defun sh-ob-nm-pr  (en / ed)
  (setq en (entnext en)
        ed (entget en))
  (cond ((= (cdr (assoc 2 ed)) "ОБОЗНАЧЕНИЕ") (setq e_ob ed))
        ((= (cdr (assoc 2 ed)) "НАИМЕНОВАНИЕ") (setq e_nm ed))
        ((= (cdr (assoc 2 ed)) "ПРИМЕЧАНИЕ") (setq e_pr ed)))
  en)

(defun c:sh_hide  (/ en ed e_ob e_nm e_pr)
  (setq en (car (entsel "Выберите элемент схемы"))
        en (sh-ob-nm-pr en)
        en (sh-ob-nm-pr en)
        en (sh-ob-nm-pr en))
  (if (and (> (strlen (cdr (assoc 1 e_ob))) 2) (= (cdr (assoc 2 e_ob)) "ОБОЗНАЧЕНИЕ"))
    (progn (setq e_pr (subst (assoc 1 e_ob) (assoc 1 e_pr) e_pr)
                 e_nm (subst (assoc 1 e_ob) (assoc 1 e_nm) e_nm)
                 e_ob (subst (cons 1 "") (assoc 1 e_ob) e_ob))
           (entmod e_ob)
           (entmod e_nm)
           (entmod e_pr))))

(defun c:sh_ma  (/ ref refd en e_ob e_nm e_pr)
  (setq ref  (car (entsel "Выберите ссылочный текст:"))
        refd (entget ref)
        en   (car (entsel "Выберите элемент схемы:"))
        en   (sh-ob-nm-pr en)	
        en   (sh-ob-nm-pr en)
        en   (sh-ob-nm-pr en))
  (if (and (> (strlen (cdr (assoc 1 refd))) 2) (= (cdr (assoc 2 e_ob)) "ОБОЗНАЧЕНИЕ"))
    (progn (setq e_ob (subst (assoc 1 refd) (assoc 1 e_ob) e_ob)) (entmod e_ob) (entdel ref))))
