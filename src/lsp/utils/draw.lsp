(vl-load-com)

(defun mid-point (p1 p2)
  (polar p1  (angle p1 p2) (* (distance p1 p2) 0.5 )))


;;;f;;;("Space()" "Space определяет какое пространство (модели или листа) является текущим.\n
;;;f;;;Возвращает:\n
;;;f;;;1. nil - если текущим является пространство листа;\n
;;;f;;;2. t   - если текущим является пространство модели.")
(defun Space  ()
  (cond ((= 1 (caar (VPORTS))) nil)
        (t)))

(defun clean-vla-object-list  (lst)
  (mapcar (function (lambda (el)
		      (if (and (eq 'VLA-OBJECT (type el)) (null (vlax-object-released-p el)))
			(vlax-release-object el))))
	  lst)
  t)

(defun clean-Acad-App-Doc-Space	 ()
  (clean-vla-object-list (list *acad-App *acad-Doc *acad-M-Space *acad-P-Space)))

;;;f;;;("AcadAppDocSpace()" "Создает глобальные переменные содержащие vla-объекты:\n
;;;f;;;	1. Приложения Acad - *acad-App;\n
;;;f;;;	2. Активного документа - *acad-Doc;\n
;;;f;;;	3. Текущего пространства модели - *acad-M-Space;\n
;;;f;;;	4. Текущего пространства листа - *acad-P-Space.\n
;;;f;;;Возвращает указатель на текущее пространство (модели или листа).")

(defun AcadAppDocSpace	()
  (clean-Acad-App-Doc-Space)
  (progn (setq *acad-App (vlax-get-acad-object))
	 (setq *acad-Doc (vla-get-activedocument *acad-App))
	 (setq *acad-M-Space (vla-get-modelspace *acad-Doc))
	 (setq *acad-P-Space (vla-get-paperspace *acad-Doc)))
  (if (Space)
    (progn (vlax-release-object *acad-P-Space) *acad-M-Space)
    (progn (vlax-release-object *acad-M-Space) *acad-P-Space)))

;;;f;;;("dr:ch_prop(prop)" "dr:ch_prop(prop) - изменение свойств последнего созданного объекта.\n
;;;f;;;(dr:ch_prop  '(( 8 . "1")(62 . 1)))")
(defun dr:ch_prop  (prop / en ed)
  (setq en (entlast)
        ed (entget en)
        ed (dsubst ed prop))
  (entmod ed))

;;;f;;;("dr:point(pt col)"
;;;f;;;"Создает точку в текущем прострпнстве.\n
;;;f;;;   p - список, содержащий координаты точки;\n
;;;f;;;   col - номер цвета, создаваемой точки.\n
;;;f;;;(dr:point '(0.0 0.0 0.0) 2)\n
;;;f;;;#<VLA-OBJECT IAcadPoint 0ed61fa4>")
(defun dr:point	 (pt col)
  (clean-vla-object-list (list *vla-point))
  (setq *vla-point (vla-addpoint (AcadAppDocSpace) (vlax-3d-point pt)))
  (clean-Acad-App-Doc-Space)
  (if (and (>= col 0) (<= col 256))
    (vla-put-color *vla-point col))
  *vla-point)

(defun dr:points  (pts col / pt)
  (clean-vla-object-list (mapcar (function (lambda (pt) (dr:point pt col))) pts)))

;;;f;;;("dr:line(pt1 pl2 col)" "Создает отрезок в текущем пространстве.\n
;;;f;;;   pt1 - начальная точка отрезка;\n
;;;f;;;   pt2 - конечная точка отрезка;\n
;;;f;;;   col - цвет отрезка.\n
;;;f;;;_$ (dr:line '(0.0 0.0 0.0) '(10.0 10.0 0.0) 256)\n
;;;f;;;#<VLA-OBJECT IAcadLine 00f6c154>\n
;;;f;;;Возвращает vla-объект, соответствующий нарисованному отрезку.")
(defun dr:line  (pt1 pt2 col)
  (clean-vla-object-list (list *vla-line))
  (setq *vla-line (vla-AddLine (AcadAppDocSpace) (vlax-3d-point pt1) (vlax-3d-point pt2)))
  (clean-Acad-App-Doc-Space)
  (if (and (>= col 0) (<= col 256))
    (vla-put-color *vla-line col))
  (vla-update *vla-line)
  *vla-line)

;;;f;;;("dr:pline(pts col)"
;;;f;;;"Создает полилинию в текущем пространстве.\n
;;;f;;;Эта полилиния может состоять только из прямолинейных сегментов.\n
;;;f;;;   pts - список 2d точек;\n
;;;f;;;   col - цвет полилинии.\n
;;;f;;;_$ (dr:pline '((0.0 0.0) (10.0 10.0)(20.0 15.0)(30.0 5.0)) 1 )\n
;;;f;;;#<VLA-OBJECT IAcadLWPolyline 0ed63ec4>\n
;;;f;;;Возвращает vla-объект, соответствующий нарисованной полилинии.")
(defun dr:pline  (pts col / arr len )
  (clean-vla-object-list (list *vla-pline))
  (setq len (length pts)
        arr (vlax-make-safearray vlax-vbDouble (cons 0 (- (* 2 len) 1))))
  (while (>= (setq len (1- len)) 0)
    (vlax-safearray-put-element arr (+ 0 (* 2 len)) (car (nth len pts)))
    (vlax-safearray-put-element arr (+ 1 (* 2 len)) (cadr (nth len pts))))
  (setq *vla-pline (vla-AddLightweightPolyline (AcadAppDocSpace) arr))
  (clean-acad-app-doc-space)
  (if (and (>= col 0) (<= col 256))
    (vla-put-color *vla-pline col))
  (vla-update *vla-pline)
  *vla-pline)

;;;f;;;("dr:circle(pt r col)"
;;;f;;;"Создает окружность в текущем пространстве.\n
;;;f;;;   pt  - центр окружности;
;;;f;;;   r   - радиус окружности;
;;;f;;;   col - номер цвета  окружности.
;;;f;;;_$ (dr:circle '(0.0 0.0 0.0) 10.0 256)\n
;;;f;;;#<VLA-OBJECT IAcadCircle 0ed63fa4>\n
;;;f;;;Возвращает vla-объект, соответствующий нарисованной окружности.\n")
(defun dr:circle  (pt r col)
  (clean-vla-object-list (list *vla-circle))
  (setq *vla-circle (vla-addcircle (AcadAppDocSpace) (vlax-3d-point pt) r))
  (clean-acad-app-doc-space)
  (if (and (>= col 0) (<= col 256))
    (vla-put-color *vla-circle col))
  (vla-update *vla-circle)
  *vla-circle)


 ;|	dr:arc (pt r a_start a_end col)	- Отрисовка дуги.
	(dr:arc '(0.0 0.0 0.0) 10.0 0.0 (* pi 0.5) 256)
|;
(defun dr:arc  (pt r a_start a_end col )
  (clean-vla-object-list (list *vla-arc))
  (setq *vla-arc (vla-AddArc (AcadAppDocSpace) (vlax-3d-point pt) r a_start a_end))
  (clean-acad-app-doc-space)
  (if (and (>= col 0) (<= col 256))
    (vla-put-color *vla-arc col))
  (vla-update *vla-arc)  
  *vla-arc)

 ;|	dr:xline(pt1 pt2 col)	- Отрисовка прямой, проходящей через две точки.
	(dr:xline '(5.0 4.0 3.0) '(8.0 2.0 0.0) 0)
	#<VLA-OBJECT IAcadXline 00f6db54>
|;
(defun dr:xline  (pt1 pt2 col)
  (clean-vla-object-list (list *vla-xline))
  (setq *vla-xline (vla-AddXline (AcadAppDocSpace) (vlax-3d-point pt1) (vlax-3d-point pt2)))
  (clean-acad-app-doc-space)
  (if (and (>= col 0) (<= col 256))
    (vla-put-color *vla-xline col))
  (vla-update *vla-xline)
  *vla-xline)
 ;|	dr:ray(pt1 pt2 col)	- Отрисовка луча.
	(dr:ray '(5.0 4.0 3.0) '(8.0 2.0 0.0) 0)
	#<VLA-OBJECT IAcadRay 00f7bd64>
|;
(defun dr:ray  (pt1 pt2 col )
  (clean-vla-object-list (list *vla-ray))
  (setq ray (vla-AddRay (AcadAppDocSpace) (vlax-3d-point pt1) (vlax-3d-point pt2)))
  (clean-acad-app-doc-space)
  (if (and (>= col 0) (<= col 256))
    (vla-put-color *vla-ray col))
  (vla-update *vla-ray)
  *vla-ray)

 ;|	dr:text(txt pt height rotation col Alignment)	- Отрисовка текста.
	(dr:text "Это пример текста" '(10.0 20. 10.) 20.0 (* pi 0.25) 4 0)
	#<VLA-OBJECT IAcadText 00f718e4>
|;
(defun dr:text  (txt pt height rotation col Alignment)
  (clean-vla-object-list (list *vla-text))
  (setq *vla-text (vla-AddText (AcadAppDocSpace) txt (vlax-3d-point pt) height))
  (clean-acad-app-doc-space)
  (if (and (>= col 0) (<= col 256))
    (vla-put-color *vla-text col))
  (vla-put-Rotation *vla-text rotation)
  (vla-put-Alignment *vla-text Alignment)
  (if (/= 0 Alignment) (vla-put-TextAlignmentPoint *vla-text (vlax-3d-point pt)))
  (vla-update *vla-text)
  *vla-text)

 ;|	dr:solid (point1 point2 point3 point4 a-color) - отрисовка области.
	(dr:solid '(0.0 0.0 0.0) '(10. 0.0 0.0) '(0.0 10. 0.0) '(10.0 10. 5.0) 5)
|;
(defun dr:solid	 (point1 point2 point3 point4 a-color)
  (clean-vla-object-list (list *vla-solid))
  (setq	*vla-solid
	 (vla-addsolid
	   (AcadAppDocSpace)
	   (vlax-3d-point point1)
	   (vlax-3d-point point2)
	   (vlax-3d-point point3)
	   (vlax-3d-point point4)))
  (clean-acad-app-doc-space)
  (if (and (>= a-color 0) (<= a-color 256))
    (vla-put-color *vla-solid a-color))
  (vla-update *vla-solid)
  *vla-solid)

(defun dr:spline  (pts col / arr len)
  (clean-vla-object-list (list *vla-spline))
  (setq	len (length pts)
	arr (vlax-make-safearray vlax-vbdouble (cons 0 (- (* 3 len) 1))))
  (while (>= (setq len (1- len)) 0)
    (vlax-safearray-put-element arr (+ 0 (* 3 len)) (car (nth len pts)))
    (vlax-safearray-put-element arr (+ 1 (* 3 len)) (cadr (nth len pts)))
    (vlax-safearray-put-element arr (+ 2 (* 3 len)) (caddr (nth len pts))))
  (setq *vla-spline (vla-addspline (AcadAppDocSpace) arr (vlax-3d-point 0.0 0.0 0.0) (vlax-3d-point 0.0 0.0 0.0)))
  (clean-acad-app-doc-space)
  (if (and (>= col 0) (<= col 256))
    (vla-put-color *vla-spline col))
  (vla-update *vla-spline)
  *vla-spline)


(defun dr:layer-new(layer-name)
  (command-s "_-layer" "_new" layer-name ""))

(defun dr:layer-set(layer-name)
  (command-s "_-layer" "_new" layer-name "_set" layer-name ""))

;;;; (defun dr:insert  (pt block-name) (command-s "_-insert" block-name "_s" 1.0 "_r" 0.0 "_non" pt))

(defun dr:insert  (InsertionPoint Name Xscale Yscale ZScale Rotation )
  (clean-vla-object-list (list *vla-insert))
  (setq *vla-insert (vla-InsertBlock (AcadAppDocSpace) (vlax-3d-point InsertionPoint) Name Xscale Yscale ZScale Rotation))
  (clean-acad-app-doc-space)
  *vla-insert)

(defun dr:mtext  (InsertionPoint Width Text height rotation color AttachmentPoint )
  (clean-vla-object-list (list *vla-mtext))
  (setq *vla-mtext (vla-AddMText (AcadAppDocSpace) (vlax-3d-point InsertionPoint) Width Text))
  (clean-acad-app-doc-space)
  (if (and (>= color 0) (<= color 256))
    (vla-put-color *vla-mtext color))
  (vla-put-Rotation *vla-mtext rotation)
  (vla-put-Height *vla-mtext height)
  (vla-put-AttachmentPoint *vla-mtext AttachmentPoint)
  (vla-put-InsertionPoint *vla-mtext (vlax-3d-point InsertionPoint))
  (vla-update *vla-mtext)
  *vla-mtext)

(defun mnas-lines:load-line-types  ()
  (command-s "_ltscale" "1")
  (command-s "_psltscale" "1")
  (command-s "_-linetype" "_load" "*" (findfile (utils:path-src-lsp "lines/eskd.lin")))
  (while (= 1 (getvar "CMDACTIVE")) (command-s ""))
  (command-s "_regen")
  (princ))

(defun c:z-point (/ р)
  (setq p (getpoint "Укажите точку"))
  (command-s "_point" ".z" "*0,0,0" ".xy" p ))