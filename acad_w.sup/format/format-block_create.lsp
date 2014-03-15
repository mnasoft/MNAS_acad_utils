;;;;;;("make_ublock"
;;;;;;"Создает непоменованный блок" "Объекты")
(defun C:make_ublock  (/
		       ss ;
		       pt ; Точка назначения блока
		       pt_ref ; Ссылочная точка блока
		       )
  (setq	pt_ref (getpoint "Введите ссылочную точку:")
	pt     (getpoint "Введите точку назначения:")
	ss     (ssget))
  (make_ublock ss pt pt_ref))


(defun make_ublock  (ss ;
		     pt ; Точка назначения блока
		     pt_ref ; Ссылочная точка блока
		     / ed ; Данные текущего примитива
		     en ; Имя текущего примитива
		     len ; Длина списка примитивов
		     attrib_lst ; Спислк атрибутов
		     have_attrib ; Признак наличия атрибутов
) (setq	len (sslength ss)
	have_attrib 0)
  (ublock+attrib:start pt_ref)
  (while (>= (setq len (1- len)) 0)
    (setq en (ssname ss len)
	  ed (cdr (entget en)))
    (setq tp (cdr (assoc 0 ed)))
    (cond ((= tp "ATTDEF")
	   (setq attrib_lst
		  (cons ed attrib_lst)
		 have_attrib 1)))
    (entmake ed))
  (setq attrib_lst (reverse attrib_lst))
  (ublock:insert (ublock:end) pt 0.0 1.0 1.0 1.0 have_attrib)
  (if have_attrib
    (progn (mapcar (function ublock:attdef->attrib) attrib_lst) (ublock:end_attrib))))

(defun ublock:start  (pt) ;начало описания непоименованного блока
  (entmake (list (cons 0 "block") (cons 2 "*U") (cons 10 pt) (cons 70 1))))

(defun ublock+attrib:start  (pt) ;начало описания непоименованного блока с атрибутами
  (entmake (list (cons 0 "block") (cons 2 "*U") (cons 10 pt) (cons 70 3))))

(defun ublock:end  () ;конец описания непоименованного блока
  (entmake (list (cons 0 "ENDBLK"))))

(defun ublock:insert  (ublock_name ; имя непоименованного блока
		       pnt ; точка вставки блока
		       ang ; угол поворота блока
		       x_scale ; масштаб по оси x
		       y_scale ; масштаб по оси y
		       z_scale ; масштаб по оси z
		       have_attrib ;(0 - атрибутов за блоком нет 1 - атрибуты есть)
) (entmake (list (cons 0 "INSERT")
		 (cons 2 ublock_name)
		 (cons 10 pnt)
		 (cons 50 ang) ;(cons 41 x_scale)
	       ;(cons 42 y_scale)
	       ;(cons 43 z_scale)
		 (cons 66 have_attrib) ; За блоком следуют атрибуты
		 )))

(defun ublock:attdef->attrib ; Преобразование определения атрибута в атрибут.
			      (attdef / attrib)
  (setq	attdef attdef ; Убираем первй элемент
	attdef (subst '(0 . "ATTRIB") '(0 . "ATTDEF") attdef)
	attdef (subst '(100 . "AcDbAttribute") '(100 . "AcDbAttributeDefinition") attdef)
	attdef (subst '(70 . 0) (assoc 70 attdef) attdef)
	attdef (subst '(73 . 0) (assoc 73 attdef) attdef))
  (mapcar (function (lambda (el) ; Исключаем таг атрибута dxf=3
		      (if (/= (car el) 3)
			(setq attrib (append attrib (list el))))))
	  attdef)
  (entmake attrib))

(defun ublock:end_attrib  () ; конец последовательности атрибутов
  (entmake (list (cons 0 "SEQEND"))))
