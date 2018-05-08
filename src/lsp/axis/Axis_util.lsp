(defun axis:app-name () "SHCKALA")

(regapp (axis:app-name))

(defun enamep (var)
  (eq (type var) 'ename))

(defun axis:filter-list () (list (cons 0 "LINE") (list -3 (list (axis:app-name)))))

;;;axis:sel(str)
;;;	Отображает запрос str; позволяет выбрать
;;;     примитив типа "SHCKALA" и возвращает имя примитива
;;;     с даными шкалы или nil, если ничего не выбрано.
;;;axis:sel("Шкала")
;;;Шкала:
;;;((-1 . <Entity name: 149d218>)
;;;  (0 . "LINE")
;;;  (330 . <Entity name: 14938c0>)
;;;  (5 . "11323")
;;;  (100 . "AcDbEntity")
;;;  (67 . 0)
;;;  (410 . "Model")
;;;  (8 . "TMP")
;;;  (62 . 1)
;;;  (100 . "AcDbLine")
;;;  (10 358.003 78.6892 0.0)
;;;  (11 558.003 78.6892 0.0)
;;;  (210 0.0 0.0 1.0)
;;;  (-3 ("SHCKALA"
;;;	(1002 . "{")
;;;	(1040 . 0.0)
;;;	(1040 . 100.0)
;;;	(1070 . 0)
;;;	(1000 . "Имя шкалы")
;;;	(1000 . "Заголовок")
;;;	(1000 . "Размерность")
;;;	(1002 . "}")
;;;      )
;;;  )
;;;)

(defun axis:sel  (str / ss)
  (princ (strcat "\n" str ":"))
  (setq ss (ssget (axis:filter-list)))
  (if ss
    (entget (ssname ss 0) (list (axis:app-name)))
    nil))

(defun axis:ename  (str / ss)
  (princ (strcat "\n" str ":"))
  (setq ss (ssget (axis:filter-list)))
  (if ss
    (ssname ss 0)
    nil))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun axis:get-sh-name	 (en-or-ed)
  (cond	((listp en-or-ed) (dxf-get 1 (axis:get en-or-ed)))
	((enamep en-or-ed) (dxf-get 1 (axis:get (entget en-or-ed (list (axis:app-name))))))))

(defun axis:get-sh-caption  (en-or-ed)
  (cond	((listp en-or-ed) (dxf-get 2 (axis:get en-or-ed)))
	((enamep en-or-ed) (dxf-get 2 (axis:get (entget en-or-ed (list (axis:app-name))))))))

(defun axis:get-sh-dimension  (en-or-ed)
  (cond	((listp en-or-ed) (dxf-get 3 (axis:get en-or-ed)))
	((enamep en-or-ed) (dxf-get 3 (axis:get (entget en-or-ed (list (axis:app-name))))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun axis:sel-by-name  (name / en i rez ss)
  (princ (strcat "\n" name ":"))
  (setq ss  (ssget "X" (axis:filter-list))
        i   (sslength ss)
        rez nil)
  (while (<= 0 (setq i (1- i)))
    (setq en (ssname ss i))
    (if (= (axis:get-sh-name en) name)
      (setq rez en)))
  (if rez
    (entget rez (list (axis:app-name)))
    nil))

;;;;(setq tol (axis:sel-by-name "FA010"))

;;;axis:get(ed)
;;;	Принимает данные примитива с расширенными данными шкалы и
;;;	Возвращает список с данными шкалы.
;;;(axis:get
;;;  '((0 . "LINE")
;;;    (10 358.003 78.6892 0.0)
;;;    (11 558.003 78.6892 0.0)
;;;    (-3
;;;     ("SHCKALA"
;;;      (1002 . "{")
;;;      (1040 . 0.0)
;;;      (1040 . 100.0)
;;;      (1070 . 0)
;;;      (1000 . "Имя шкалы")
;;;      (1000 . "Подпись шкалы")
;;;      (1000 . "Размерность")
;;;      (1002 . "}")
;;;     )
;;;    )
;;;   )
;;;)
;;;((10 358.003 78.6892 0.0)
;;;  (11 558.003 78.6892 0.0)
;;;  (40 . 0.0)
;;;  (41 . 100.0)
;;;  (70 . 0)
;;;  (1 . "Имя шкалы")
;;;  (2 . "Подпись")
;;;  (3 . "Рзмерность")
;;;)
(defun axis:get	 (ed / xdt p0 p1 v0 v1 flag name caption dimension)
  (setq	xdt	  (_xd_appget ed (axis:app-name))
	v0	  (cdr (nth 0 xdt))
	v1	  (cdr (nth 1 xdt))
	flag	  (cdr (nth 2 xdt))
	name	  (cdr (nth 3 xdt))
	caption	  (cdr (nth 4 xdt))
	caption   (if  (null caption)   "" caption)
	dimension (cdr (nth 5 xdt))
	dimension (if  (null dimension) "" dimension)
	p0	  (cdr (assoc 10 ed))
	p1	  (cdr (assoc 11 ed)))
  (list	(cons 10 p0)
	(cons 11 p1)
	(cons 40 v0)
	(cons 41 v1)
	(cons 70 flag)
	(cons 1 name)
	(cons 2 caption)
	(cons 3 dimension)))

(defun axis:make-axis-initial-data ()
  '((10 0.0 0.0 0.0)
    (11 100.0 0.0 0.0)
    (40 . 0.0)
    (41 . 100.0)
    (70 . 0)
    (1 . "name")
    (2 . "caption")
    (3 . "dimension")))


(defun axis:make-axis-data (p0 p1 start-value end-value flag name caption dimension)
  (list	(cons 10 p0)
	(cons 11 p1)
	(cons 40 start-value)
	(cons 41 end-value)
	(cons 70 flag)
	(cons 1 name)
	(cons 2 caption)
	(cons 3 dimension)))

(defun axis:extract-axis-points  (axis-data)
  (list	(assoc 10 axis-data)
	(assoc 11 axis-data)))

(defun axis:extract-axis-xdt  (axis-data)
  (list	(cons 1040 (cdr (assoc 40 axis-data)))
	(cons 1040 (cdr (assoc 41 axis-data)))
	(cons 1070 (cdr (assoc 70 axis-data)))
	(cons 1000 (cdr (assoc 1 axis-data)))
	(cons 1000 (cdr (assoc 2 axis-data)))
	(cons 1000 (cdr (assoc 3 axis-data)))))


;;;axis:upd(ed axis-data)
;;;	Обновляет данные примитива (0 . "LINE") с расширенными данными 
;;;	шкалы данными шкалы.
;;;	ed - данные примитива линии;
;;;((0 . "LINE")
;;; (10 358.003 78.6892 0.0)
;;; (11 558.003 78.6892 0.0)
;;; (-3
;;;  ("SHCKALA"
;;;   (1002 . "{")
;;;   (1040 . 0.0)
;;;   (1040 . 100.0)
;;;   (1070 . 0)
;;;   (1000 . "Некая шкала x")
;;;   (1000 . "Заголовок")
;;;   (1000 . "Размерность")
;;;   (1002 . "}")
;;;  )
;;; )
;;;)
;;;	axis-data - данные шкалы:
;;;((10 358.003 78.6892 0.0)
;;;  (11 558.003 78.6892 0.0)
;;;  (40 . 0.0)
;;;  (41 . 100.0)
;;;  (70 . 0)
;;;  (1 . "Некая шкала x")
;;;  (2 . "Заголовок")
;;;  (3 . "Размерность")
;;;)
(defun axis:upd	 (ed axis-data / pts)
  (setq	pts (list (assoc 10 axis-data) (assoc 11 axis-data))
	ed  (dsubst ed pts)
	ed  (_xd_appsubst ed (axis:app-name) (axis:extract-axis-xdt axis-data)))
  (entmod ed))


;;;f;;;("dr:axis (start-pt end-pt start-value end-value flag name)" "Создает ось (axis) в текущем пространстве.\n
;;;f;;;   start-pt    - начальная точка отрезка;\n
;;;f;;;   end-pt      - конечная точка отрезка;\n
;;;f;;;   start-value - значение в начальной точке шкалы;\n
;;;f;;;   end-value   - значение в конечной точке шкалы;\n
;;;f;;;   flag        - признак, если 0 - шкала пропорциональная, если 1 - шкала гогарифмическая;\n
;;;f;;;   name        - имя шкалы.\n
;;;f;;;_$ (dr:axis '(0 0 0) '(100 0 0) 50 100 0 "COOL_axis")\n
;;;f;;;((0 . "LINE") (10 0 0 0) (11 100 0 0) (-3 ("SHCKALA" (1002 . "{") (1040 . 50) (1040 . 100) (1070 . 0)
;;;f;;; (1000 . "COOL_axis")(1001 . "COOL&A&Baxis") (1003 . "кПа") (1002 . "}"))))\n
;;;f;;;")
(defun dr:axis	(start-pt end-pt start-value end-value flag name caption dimension / ed ed1)
  (regapp (axis:app-name))
  (setq	ax-data	(axis:make-axis-data start-pt end-pt start-value end-value flag name caption dimension)
	ed	(append (list (cons 0 "LINE")) (axis:extract-axis-points ax-data))
	ed1	(_xd_appsubst ed (axis:app-name) (axis:extract-axis-xdt ax-data)))
  (entmake ed1))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;	sc:val_pt_porp(x)	- Функция преобразования значения в точку для пропорциональной шкалы.
(defun sc:val_pt_porp (x) x)

;;	sc:val_pt_porp(x)	- Функция преобразования точки в значение для пропорциональной шкалы.
(defun sc:pt_val_porp (x) x)

;;	sc:val_pt_log(x)	- Функция преобразования значения в точку для логарифмической шкалы.
(defun sc:val_pt_log (x) (log x))

;;	sc:pt_val_log(x)	- Функция преобразования точки в значение для логарифмической шкалы.
(defun sc:pt_val_log (x) (exp x))

;;	sc:pt_val (pt sc)	- Определение значения в координатах шкалы по точке лежащей на этой шкале.
(defun sc:pt_val  (pt sc / sc_flag sc_p0 sc_p1 sc_v0 sc_v1 v_rez p1-p0 a_max)
  (setq sc_p0   (cdr (assoc 10 sc))
        sc_p1   (cdr (assoc 11 sc))
        sc_v0   (cdr (assoc 40 sc))
        sc_v1   (cdr (assoc 41 sc))
        sc_flag (cdr (assoc 70 sc))
        p1-p0   (mapcar '- sc_p1 sc_p0)
        p1-p0   (mapcar 'abs p1-p0)
        a_max   (apply 'max p1-p0)
        f_pr    (cond ((= 0 sc_flag) sc:val_pt_porp)
                      ((= 1 sc_flag) sc:val_pt_log))
        f_obr   (cond ((= 0 sc_flag) sc:pt_val_porp)
                      ((= 1 sc_flag) sc:pt_val_log)))
  (cond ((= a_max (car p1-p0)) (setq f_cord car))
        ((= a_max (cadr p1-p0)) (setq f_cord cadr))
        ((= a_max (caddr p1-p0)) (setq f_cord caddr)))
  (f_obr (+ (f_pr sc_v0)
            (* (- (f_pr sc_v1) (f_pr sc_v0))
               (/ (- (f_cord pt) (f_cord sc_p0)) (- (f_cord sc_p1) (f_cord sc_p0)))))))

;;	sc:val_pt(vt sc)	- Определение точки на шкале по значению на шкале.
(defun sc:val_pt  (vt sc / sc_p0 sc_p1 sc_v0 sc_v1 sc_flag v_factor p_rez)
  (setq sc_p0    (cdr (assoc 10 sc))
        sc_p1    (cdr (assoc 11 sc))
        sc_v0    (cdr (assoc 40 sc))
        sc_v1    (cdr (assoc 41 sc))
        sc_flag  (cdr (assoc 70 sc))
        f_pr     (cond ((= 0 sc_flag) sc:val_pt_porp)
                       ((= 1 sc_flag) sc:val_pt_log))
        v_factor (/ (- (f_pr vt) (f_pr sc_v0)) (- (f_pr sc_v1) (f_pr sc_v0))))
  (mapcar (function (lambda (el0 el1) (+ el0 (* (- el1 el0) v_factor)))) sc_p0 sc_p1))

;;	sc:pxy_pt(pxy scx scy)	- Переводит точку из координат шкал scx и scy в координаты экрана.
(defun sc:pxy_pt  (pxy scx scy / SCX_P0 SCX_P1 SCY_P0 SCY_P1 px py p_rez)
  (setq px     (sc:val_pt (car pxy) scx)
        py     (sc:val_pt (cadr pxy) scy)
        scx_p0 (cdr (assoc 10 scx))
        scx_p1 (cdr (assoc 11 scx))
        scy_p0 (cdr (assoc 10 scy))
        scy_p1 (cdr (assoc 11 scy))
        p_rez  (inters px (polar px (angle scy_p0 scy_p1) 1.0) py (polar py (angle scx_p0 scx_p1) 1.0) nil))
  p_rez)

;;	sc:pt_pxy(pt scx scy)	- Переводит точку из координат экрана  в координаты шкал scx и scy.
(defun sc:pt_pxy  (pt scx scy / scx_p0 scx_p1 scy_p0 scy_p1 px py p_rez)
  (setq scx_p0 (cdr (assoc 10 scx))
        scx_p1 (cdr (assoc 11 scx))
        scy_p0 (cdr (assoc 10 scy))
        scy_p1 (cdr (assoc 11 scy))
        px     (inters scx_p0 scx_p1 pt (polar pt (angle scy_p0 scy_p1) 1.0) nil)
        py     (inters scy_p0 scy_p1 pt (polar pt (angle scx_p0 scx_p1) 1.0) nil)
        p_rez  (list (sc:pt_val px scx) (sc:pt_val py scy) 0.0)))

;;Транспонирование списка представляющего из себя матрицу.
;;(transpon '((1 2 3)(4 5 6)(7 8 9)(10 11 12)))
(defun transpon (m) (apply 'mapcar (cons 'list m)))


