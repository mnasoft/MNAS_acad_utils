(VL-LOAD-COM)
;;;;;;("razvertka" "Построение развертки тела выдавливания с обрезкой кромок." "Развертки")
(defun c:razvertka  (/                  ;
                     vo_1               ; Образующая листа, отображающая изгибы листа. (Полилиния).
                     vo_2               ; Первая линия реза.
                     vo_3               ; 
                     vo_4               ; Вторая линия реза.
                     n                  ;Количество точек для каждого сегмента полилинии.
                     a_23     a_43     dst      d_23     d_43     e_par    i        n_delen  par      pnt      p_bok_23 p_bok_43 p_mid    p_vo_2
                     p_vo_3   p_vo_4   start_pnt         s_par    vo_line  v_bok_23 v_bok_43 v_mid    v_pnt_2  v_pnt_3  v_pnt_4)
  (command "_vslide" (findfile "acad_w.sup/razvertka/razvertka.sld"))
  (prompt "\nКогда будете готовы нажмите ВВОД.")
  (command pause "_redraw")
  (setq vo_1      (vlax-ename->vla-object (car (entsel "\nВыберите серединную образующую (вид на торец листа):")))
        vo_2      (vlax-ename->vla-object (car (entsel "\nПервую линию обрезки:")))
        vo_3      (vlax-ename->vla-object (car (entsel "\nЛинию направления развертки:")))
        vo_4      (vlax-ename->vla-object (car (entsel "\nВторую линию обрезки:")))
        start_pnt (getpoint "\nУкажите точку начала развертки:")
        n         (getint "\nКоличество точек разбиения каждого сегмента полилинии <5> :")
        n         (cond ((null n) 5)
                        (t n))
        s_par     (vlax-curve-getStartParam vo_1)
        e_par     (vlax-curve-getEndParam vo_1)
        n_delen   (* (- e_par s_par) n)
        par       s_par
        i         0)
  (dr:point start_pnt 7)
  (while (<= par e_par)
    (print par)
    (setq pnt (vlax-curve-getPointAtParam vo_1 par)
          dst (vlax-curve-getDistAtParam vo_1 par))
    (setq vo_line (dr:line pnt (polar pnt 0 1.) 2))
    (setq p_vo_2   (vlax-safearray->list
                     (vlax-variant-value
                       (vlax-invoke-method
                         vo_line
                         'IntersectWith
                         vo_2           ;acExtendNone;  Does not extend either object.
                                        ;acExtendThisEntity ;	Extends the base object.
                                        ;acExtendOtherEntity	;	Extends the object passed as an argument.
                         acExtendBoth   ;Extends both objects.
                         )))
          p_vo_3   (vlax-safearray->list
                     (vlax-variant-value
                       (vlax-invoke-method
                         vo_line
                         'IntersectWith
                         vo_3           ;acExtendBoth
                                        ;acExtendNone;  Does not extend either object.
                         acExtendThisEntity ;	Extends the base object.
                                        ;acExtendOtherEntity	;	Extends the object passed as an argument.
                                        ;acExtendBoth	;	Extends both objects.
                         )))
          p_vo_4   (vlax-safearray->list
                     (vlax-variant-value
                       (vlax-invoke-method
                         vo_line
                         'IntersectWith
                         vo_4           ;acExtendBoth
                                        ;acExtendNone;  Does not extend either object.
                         acExtendThisEntity ;	Extends the base object.
                                        ;acExtendOtherEntity	;	Extends the object passed as an argument.
                                        ;acExtendBoth	;	Extends both objects.
                         )))
          d_23     (distance p_vo_2 p_vo_3)
          d_43     (distance p_vo_4 p_vo_3)
          a_23     (angle p_vo_3 p_vo_2)
          a_43     (angle p_vo_3 p_vo_4)
          p_mid    (polar start_pnt (* 0.5 pi) dst)
          p_bok_23 (polar p_mid a_23 d_23)
          p_bok_43 (polar p_mid a_43 d_43))
    (setq v_pnt_2  (dr:point p_vo_2 2)
          v_pnt_3  (dr:point p_vo_3 3)
          v_pnt_4  (dr:point p_vo_4 3)
          v_mid    (dr:point p_mid 3)
          v_bok_23 (dr:point p_bok_23 3)
          v_bok_43 (dr:point p_bok_43 3))
    (vlax-invoke-method vo_line 'Delete)
    (vlax-invoke-method v_pnt_2 'Delete)
    (vlax-invoke-method v_pnt_3 'Delete)
    (vlax-invoke-method v_pnt_4 'Delete)
    (setq i   (1+ i)
          par (/ (* i (- e_par s_par)) n_delen)))
  (princ "Развертка полностью построена!\n")
  (princ))

;;;;;;("r_cone" "Построение развертки конуса." "Развертки")
(defun c:r_cone  (/ A1 A2 L1 L2 P0 P01 P02 P1 P2 R1 R2)
  (setq p01 (getpoint "\nВведите первую точку на оси конуса:"))
  (setq p02 (getpoint p01 "\nВведите вторую точку на оси конуса:"))
  (setq p1 (getpoint "\nВведите первую точку на образующей конуса:"))
  (setq p2 (getpoint p1 "\nВведите вторую точку на оси конуса:"))
  (setq p0 (inters p01 p02 p1 p2 nil))
  (setq r1 (distance p0 p1)             ; Длина первой образующей
        r2 (distance p0 p2)             ; Длина второй образующей
        l1 (distance p1 (inters p1 (polar p1 (+ (* pi 0.5) (angle p01 p02)) (distance p01 p02)) p01 p02 nil))
        l2 (distance p2 (inters p2 (polar p2 (+ (* pi 0.5) (angle p01 p02)) (distance p01 p02)) p01 p02 nil))
        a1 (/ (* pi 2.0 l1) r1)
        a2 (/ (* pi 2.0 l2) r2))
  (dr:arc p0 r1 0 a1 2)
  (dr:arc p0 r2 0 a2 2))

;;;f;;;("list->3d-point-list" "Преобразует список, содержащий координаты xyz нескольких точек, в список точек.")
(defun list->3d-point-list  (lst / rez pnt el i)
  (setq i 0)
  (while (setq el (car lst))
    (setq lst (cdr lst))
    (setq i   (1+ i)
          pnt (cons el pnt))
    (if (>= i 3)
      (setq i   0
            rez (cons (reverse pnt) rez)
            pnt nil)))
  rez)

;;;---------------------------------------------------------------------------------------------------------

(defun get-min-length-point  (p lst)
  (cadar(vl-sort (mapcar (function (lambda (el) (list (distance el p) el))) lst)
           (function(lambda(el1 el2) (< (car el1) (car el2)))))))

;;;f;;; ("get-IntersectWith-points" "Возвращает список точек пересечения объекта vla-this с объектом vla-oter.
;;;f;;; Параметр tp - отвечает за удлинение объектов при поиске точек пересечения
;;;f;;; может принимать одно из следующих значений:
;;;f;;; acExtendNone=0;
;;;f;;; acExtendThisEntity=1;
;;;f;;; acExtendOtherEntity=2;
;;;f;;; acExtendBoth=3.")
(defun get-IntersectWith-points (vla-this vla-oter tp)
  (list->3d-point-list
                    (vlax-safearray->list
                      (vlax-variant-value (vlax-invoke-method vla-this 'IntersectWith vla-oter tp)))))

;;;f;;;("draw-riangle" "")
(defun draw-riangle  (vl       d1	d2	 cclock_dir
		      /	       a_delta	p_e	 p_ob1_ob2
		      p_s      v_c1	v_c2	 v_ob_1)
  (if cclock_dir
    (setq a_delta (/ pi 3.0))
    (setq a_delta (/ pi -3.0)))
  (setq	p_s	  (vlax-curve-getStartPoint vl)
	p_e	  (vlax-curve-getEndPoint vl)
	p	  (polar p_s (+ (angle p_s p_e) a_delta) (distance p_s p_e))
	v_c1	  (dr:circle p_s d1 1)
	v_c2	  (dr:circle p_e d2 2)
	p_ob1_ob2 (get-IntersectWith-points v_c1 v_c2 acExtendNone)
	p_rez	  (get-min-length-point p p_ob1_ob2))
;;;;  (dr:point p_rez 3)
  (command "_erase"
	   (vlax-vla-object->ename v_c1)
	   (vlax-vla-object->ename v_c2)
	   "")
  p_rez)


(defun c:draw-riangle-test  ()
  (draw-riangle
    (vlax-ename->vla-object (car (entsel "Выберите 1:")))
    (getdist "Введите первое расстояние:")
    (getdist "Введите второе расстояние:")
    t))

;;;;;;("r_triang" "Построение развертки переходного участка методом разбиения на треугольники." "Развертки")
(defun c:r-triang  (/ ccd p01 p02 p03 p1 p2 p3 vl)
  (setq p01 (getpoint "\np01:"))
  (setq p1 (getpoint "\np1:"))
  (setq p2 (getpoint "\np2:"))
  (setq p02 (polar p01 0.0 (distance p1 p2)))
  (setq vl (dr:line p01 p02 1))
  (dr:line p1 p2 256)
  (while (progn (setq p3 (getpoint "\np3:")))
    (dr:line p2 p3 256)
    (setq p03 (draw-riangle vl (distance p1 p3) (distance p2 p3) ccd))
    (setq vl (dr:line p02 p03 2))
    (dr:line p01 p03 3)
    (setq ccd (null ccd)
	  p1  p2
	  p2  p3
	  p01 p02
	  p02 p03)))

(defun c:r-triang-test  (/ v_ob_1 v_ob_2 p_ob1_ob2)
  (setq v_ob_1 (vlax-ename->vla-object (car (entsel "Выберите 1:"))))
  (setq v_ob_2 (vlax-ename->vla-object (car (entsel "Выберите 2:"))))
  (setq p_ob1_ob2 (vlax-safearray->list
                    (vlax-variant-value (vlax-invoke-method v_ob_1 'IntersectWith v_ob_2 acExtendNone))))
                                        ; acExtendNone acExtendThisEntity acExtendOtherEntity acExtendBoth
  (mapcar (function (lambda (el) (dr:point el 1))) (list->3d-point-list p_ob1_ob2)))

(defun p-val (val p-val-out)
  (princ (rtos val 2 2) p-val-out))

(defun c:get-pline-points  (/ fn ed rez-pts out rez-pts)
  (setq ed (c:obj)
        rez-pts nil)
  (setq fn  (getfiled "Имя  Shp-файла для вывода отсортированных форм" "" "html" 1)
        out (open fn "w"))
  (mapcar (function (lambda (el)
                      (if (= 10 (car el))
                        (setq rez-pts (cons (cdr el) rez-pts)))))
          ed)
  (setq rez-pts (reverse rez-pts))
  (princ "<table>\n" out)
  (princ "<tr>" out)
  (princ "<td>" out)
  (princ "X, мм" out)
  (princ "</td>" out)
  (princ "<td>" out)
  (princ "Y, мм" out)
  (princ "</td>" out)
  (princ "</tr>\n" out)
  (mapcar (function (lambda (el)
                      (princ "<tr>" out)
                      (princ "<td>" out)
                      (p-val (car el) out)
                      (princ "</td>" out)
                      (princ "<td>" out)
                      (p-val (cadr el) out)
                      (princ "</td>" out)
                      (princ "</tr>\n" out)
                      (if (= 10 (car el))
                        (setq rez-pts (cons (cdr el) rez-pts)))))
          rez-pts)
  (princ "</table>\n" out)
  (close out)
  (dr:pline rez-pts 256))

