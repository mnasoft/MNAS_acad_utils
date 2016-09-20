(defun sh:SHCKALA () "SHCKALA")

(regapp (sh:SHCKALA))

;;;sh:sel(str)
;;;	Отображает запрос str; позволяет выбрать
;;;     примитив типа "SHCKALA" и возвращает имя примитива
;;;     с даными шкалы или nil, если ничего не выбрано.
;;;sh:sel("Шкала")
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
;;;	(1000 . "Некая шкала x")
;;;	(1002 . "}")
;;;      )
;;;  )
;;;)
(defun sh:sel  (str / ss)
  (princ (strcat "\n" str ":"))
  (setq ss (ssget (list (cons 0 "LINE") (list -3 (list (sh:SHCKALA))))))
  (if ss
    (entget (ssname ss 0) (list (sh:SHCKALA)))
    nil))

;;;sh:get(ed)
;;;	Принимает данные примитива с расширенными данными шкалы и
;;;	Возвращает список с данными шкалы.
;;;(sh:get
;;;  '((0 . "LINE")
;;;    (10 358.003 78.6892 0.0)
;;;    (11 558.003 78.6892 0.0)
;;;    (-3
;;;     ("SHCKALA"
;;;      (1002 . "{")
;;;      (1040 . 0.0)
;;;      (1040 . 100.0)
;;;      (1070 . 0)
;;;      (1000 . "Некая шкала x")
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
;;;  (1 . "Некая шкала x")
;;;)
(defun sh:get  (ed / xdt p0 p1 v0 v1 flag str)
  (setq xdt  (_xd_appget ed (sh:SHCKALA))
        v0   (cdr (nth 0 xdt))
        v1   (cdr (nth 1 xdt))
        flag (cdr (nth 2 xdt))
        str  (cdr (nth 3 xdt))
        p0   (cdr (assoc 10 ed))
        p1   (cdr (assoc 11 ed)))
  (list (cons 10 p0) (cons 11 p1) (cons 40 v0) (cons 41 v1) (cons 70 flag) (cons 1 str)))

;;;sh:upd(ed sh:data)
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
;;;   (1002 . "}")
;;;  )
;;; )
;;;)
;;;	sh:data - данные шкалы:
;;;((10 358.003 78.6892 0.0)
;;;  (11 558.003 78.6892 0.0)
;;;  (40 . 0.0)
;;;  (41 . 100.0)
;;;  (70 . 0)
;;;  (1 . "Некая шкала x")
;;;)
(defun sh:upd  (ed sh:data / pts xdt)
;;; не законЧена
  (setq pts (list (assoc 10 sh:data) (assoc 11 sh:data))
        xdt (list (cons 1040 (assoc 40 sh:data))
                  (cons 1040 (assoc 41 sh:data))
                  (cons 1070 (assoc 70 sh:data))
                  (cons 1000 (assoc 1 sh:data)))
        ed  (dsubst ed pts)
        ed  (_xdsubst_ xdt)
;;;место длЯ доработкИ.
        ))

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


