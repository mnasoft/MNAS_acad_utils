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
;;;f;;;("AcadAppDocSpace()" "Создает глобальные переменные содержащие vla-объекты:\n
;;;f;;;	1. Приложения Acad - *acad-App;\n
;;;f;;;	2. Активного документа - *acad-Doc;\n
;;;f;;;	3. Текущего пространства модели - *acad-M-Space;\n
;;;f;;;	4. Текущего пространства листа - *acad-P-Space.\n
;;;f;;;Возвращает указатель на текущее пространство (модели или листа).")
(defun AcadAppDocSpace  ()
  (if (null *acad-App)
    (setq *acad-App (vlax-get-acad-object)))
  (if (null *acad-Doc)
    (setq *acad-Doc (vla-get-ActiveDocument *acad-App)))
  (if (null *acad-M-Space)
    (setq *acad-M-Space (vla-get-ModelSpace *acad-Doc)))
  (if (null *acad-P-Space)
    (setq *acad-P-Space (vla-get-PaperSpace *acad-Doc)))
  (if (Space)
    *acad-M-Space
    *acad-P-Space))

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
(defun dr:point  (pt col / point)
  (setq point (vla-AddPoint (AcadAppDocSpace) (vlax-3d-point pt)))
  (if (and (>= col 0) (<= col 256))
    (vla-put-color point col))
  point)

(defun dr:points (pts col / pt) (mapcar (function (lambda (pt) (dr:point pt col))) pts))


;;;f;;;("dr:line(pt1 pl2 col)" "Создает отрезок в текущем пространстве.\n
;;;f;;;   pt1 - начальная точка отрезка;\n
;;;f;;;   pt2 - конечная точка отрезка;\n
;;;f;;;   col - цвет отрезка.\n
;;;f;;;_$ (dr:line '(0.0 0.0 0.0) '(10.0 10.0 0.0) 256)\n
;;;f;;;#<VLA-OBJECT IAcadLine 00f6c154>\n
;;;f;;;Возвращает vla-объект, соответствующий нарисованному отрезку.")
(defun dr:line  (pt1 pt2 col / line)
  (setq line (vla-AddLine (AcadAppDocSpace) (vlax-3d-point pt1) (vlax-3d-point pt2)))
  (if (and (>= col 0) (<= col 256))
    (vla-put-color line col))
  (vla-update line)
  line)


;;;f;;;("dr:pline(pts col)"
;;;f;;;"Создает полилинию в текущем пространстве.\n
;;;f;;;Эта полилиния может состоять только из прямолинейных сегментов.\n
;;;f;;;   pts - список 2d точек;\n
;;;f;;;   col - цвет полилинии.\n
;;;f;;;_$ (dr:pline '((0.0 0.0) (10.0 10.0)(20.0 15.0)(30.0 5.0)) 1 )\n
;;;f;;;#<VLA-OBJECT IAcadLWPolyline 0ed63ec4>\n
;;;f;;;Возвращает vla-объект, соответствующий нарисованной полилинии.")
(defun dr:pline  (pts col / arr len pline)
  (setq len (length pts)
        arr (vlax-make-safearray vlax-vbDouble (cons 0 (- (* 2 len) 1))))
  (while (>= (setq len (1- len)) 0)
    (vlax-safearray-put-element arr (+ 0 (* 2 len)) (car (nth len pts)))
    (vlax-safearray-put-element arr (+ 1 (* 2 len)) (cadr (nth len pts))))
  (setq pline (vla-AddLightweightPolyline (AcadAppDocSpace) arr))
  (if (and (>= col 0) (<= col 256))
    (vla-put-color pline col))
  (vla-update pline)
  pline)

;;;f;;;("dr:circle(pt r col)"
;;;f;;;"Создает окружность в текущем пространстве.\n
;;;f;;;   pt  - центр окружности;
;;;f;;;   r   - радиус окружности;
;;;f;;;   col - номер цвета  окружности.
;;;f;;;_$ (dr:circle '(0.0 0.0 0.0) 10.0 256)\n
;;;f;;;#<VLA-OBJECT IAcadCircle 0ed63fa4>\n
;;;f;;;Возвращает vla-объект, соответствующий нарисованной окружности.\n")
(defun dr:circle  (pt r col / circle)
  (setq circle (vla-AddCircle (AcadAppDocSpace) (vlax-3d-point pt) r))
  (if (and (>= col 0) (<= col 256))
    (vla-put-color circle col))
  (vla-update circle)
  circle)
 ;|	dr:arc (pt r a_start a_end col)	- Отрисовка дуги.
	(dr:arc '(0.0 0.0 0.0) 10.0 0.0 (* pi 0.5) 256)
|;
(defun dr:arc  (pt r a_start a_end col / arc)
  (setq arc (vla-AddArc (AcadAppDocSpace) (vlax-3d-point pt) r a_start a_end))
  (if (and (>= col 0) (<= col 256))
    (vla-put-color arc col))
  (vla-update arc)  
  arc)
 ;|	dr:xline(pt1 pt2 col)	- Отрисовка прямой, проходящей через две точки.
	(dr:xline '(5.0 4.0 3.0) '(8.0 2.0 0.0) 0)
	#<VLA-OBJECT IAcadXline 00f6db54>
|;
(defun dr:xline  (pt1 pt2 col / xline)
  (setq xline (vla-AddXline (AcadAppDocSpace) (vlax-3d-point pt1) (vlax-3d-point pt2)))
  (if (and (>= col 0) (<= col 256))
    (vla-put-color xline col))
  (vla-update xline)
  xline)
 ;|	dr:ray(pt1 pt2 col)	- Отрисовка луча.
	(dr:ray '(5.0 4.0 3.0) '(8.0 2.0 0.0) 0)
	#<VLA-OBJECT IAcadRay 00f7bd64>
|;
(defun dr:ray  (pt1 pt2 col / ray)
  (setq ray (vla-AddRay (AcadAppDocSpace) (vlax-3d-point pt1) (vlax-3d-point pt2)))
  (if (and (>= col 0) (<= col 256))
    (vla-put-color ray col))
  (vla-update ray)
  ray)

 ;|	dr:text(txt pt height rotation col Alignment)	- Отрисовка текста.
	(dr:text "Это пример текста" '(10.0 20. 10.) 20.0 (* pi 0.25) 4 0)
	#<VLA-OBJECT IAcadText 00f718e4>
|;
(defun dr:text  (txt pt height rotation col Alignment / v-text)
  (setq v-text (vla-AddText (AcadAppDocSpace) txt (vlax-3d-point pt) height))
  (if (and (>= col 0) (<= col 256))
    (vla-put-color v-text col))
  (vla-put-Rotation v-text rotation)
  (vla-put-Alignment v-text Alignment)
  (vla-put-TextAlignmentPoint v-text (vlax-3d-point pt))
  (vla-update v-text)
  v-text)

 ;|	dr:solid (point1 point2 point3 point4 a-color) - отрисовка области.
	(dr:solid '(0.0 0.0 0.0) '(10. 0.0 0.0) '(0.0 10. 0.0) '(10.0 10. 5.0) 5)
|;
(defun dr:solid  (point1 point2 point3 point4 a-color / solid)
  (setq solid (vla-AddSolid (AcadAppDocSpace)
                            (vlax-3d-point point1)
                            (vlax-3d-point point2)
                            (vlax-3d-point point3)
                            (vlax-3d-point point4)))
  (if (and (>= a-color 0) (<= a-color 256))
    (vla-put-color solid a-color))
  (vla-update solid)
  solid)

(defun dr:spline  (pts col / arr len spline)
  (setq len (length pts)
        arr (vlax-make-safearray vlax-vbDouble (cons 0 (- (* 3 len) 1))))
  (while (>= (setq len (1- len)) 0)
    (vlax-safearray-put-element arr (+ 0 (* 3 len)) (car (nth len pts)))
    (vlax-safearray-put-element arr (+ 1 (* 3 len)) (cadr (nth len pts)))
    (vlax-safearray-put-element arr (+ 2 (* 3 len)) (caddr (nth len pts))))
  (setq spline (vla-AddSpline (AcadAppDocSpace) arr (vlax-3d-point 0.0 0.0 0.0) (vlax-3d-point 0.0 0.0 0.0)))
  (if (and (>= col 0) (<= col 256))
    (vla-put-color spline col))
  (vla-update spline)
  spline)

(defun dr:layer-new(layer-name)
  (command "_-layer" "_new" layer-name ""))

(defun dr:layer-set(layer-name)
  (command "_-layer" "_new" layer-name "_set" layer-name ""))

;;;; (defun dr:insert  (pt block-name) (command "_-insert" block-name "_s" 1.0 "_r" 0.0 "_non" pt))

(defun dr:insert  (InsertionPoint Name Xscale Yscale ZScale Rotation / v-insert)
  (setq v-insert (vla-InsertBlock (AcadAppDocSpace) (vlax-3d-point InsertionPoint) Name Xscale Yscale ZScale Rotation))
  v-insert)

(defun dr:mtext  (InsertionPoint Width Text height rotation color AttachmentPoint / v-mtext)
  (setq v-mtext (vla-AddMText (AcadAppDocSpace) (vlax-3d-point InsertionPoint) Width Text))
  (if (and (>= color 0) (<= color 256))
    (vla-put-color v-mtext color))
  (vla-put-Rotation v-mtext rotation)
  (vla-put-Height v-mtext height)
  (vla-put-AttachmentPoint v-mtext AttachmentPoint)
  (vla-put-InsertionPoint v-mtext (vlax-3d-point InsertionPoint))
  (vla-update v-mtext)
  v-mtext)