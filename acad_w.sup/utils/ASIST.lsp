;;;(princ "\nЗагружаю utils/asist         ")
(princ (strcat "\nЗагружаю " (acad_sup) "/" "utils/asist         "))

;;	dtr(a)				- Перевод градусов в радианы.
(defun dtr (a) (* pi (/ a 180.0)))

;;	rtd(a)				- Перевод радианов в градусы.
(defun rtd (a) (* 180. (/ a pi)))

;;	Производит нормализацию угла к диапазону [-pi ; pi].
(defun angle-normalize[-pi_pi] (a)
  (setq	n (fix (/ a (* pi 2)))
	a (- a (* n (* pi 2)))
  )
  (cond
    ((> a pi)
     (setq a (- a (* pi 2)))
    )
    ((< a (* -1 pi))
     (setq a (+ a (* pi 2)))
    )
  )
  a
)

;;	get_ss_list (li val code)	- Отсеивает из набора li примитивы у которых ЗНАЧЕНИЕ по dxf коду code не совпадает c val.
(defun get_ss_list (li val code / cur n_in_li new_l name)
  (setq new_l (ssadd))
  (setq cur 0)
  (setq n_in_li (sslength li))
  (while (< cur n_in_li)
    (setq name (ssname li cur))
    (if	(= val (get_dxf name code))
      (ssadd name new_l)
    )
    (setq cur (+ cur 1))
  )
  new_l
)

;;	subst_ss(li_1 li_2)		-  Исключает из набора li_1 набор li_2.					
(defun subst_ss	(li_1 li_2 / n_li_2 cur)
  (setq n_li_2 (sslength li_2))
  (setq cur 0)
  (while (< cur n_li_2)
    (ssdel (ssname li_2 cur) li_1)
    (setq cur (+ cur 1))
  )
  li_1
)

;;	sort_list(li code)		- Создает из набора li набор с неповторяющимися значениями примитивов по dxf коду - code.
(defun sort_list (li code / name l_new li_a val)
  (setq l_new (ssadd))
  (while (< 0 (sslength li))
    (setq val (get_dxf (setq name (ssname li 0)) code))
    (setq li_a (get_ss_list li val code))
    (setq li (subst_ss li li_a))
    (ssadd name l_new)
  )
  l_new
)

;;	dxdy (p0 dx dy dir_0)		- Возврвщает точку находящуюся от p0 по смещениям dx dy (dx имеет направление dir_0).
(defun dxdy (p0 dx dy dir_0 / p3 znx znxa zny)
  (if (< dx 0.)
    (setq znx -1.)
    (setq znx 1.)
  )
  (if (< dx 0.)
    (setq znxa 1.)
    (setq znxa 0.)
  )
  (if (< dy 0.)
    (setq zny -1.)
    (setq zny 1.)
  )
  (setq p3 (polar p0 (+ dir_0 (* zny pi 0.5)) (* zny dy)))
  (setq p3 (polar p3 (+ dir_0 (* znxa pi)) (* znx dx)))
)

;;	dxdy_sc_xy (p0 dx dy scx scy dir_0) - Возврвщает точку находящуюся от p0 по смещениям dx*scx dy*scy (dx имеет направление dir_0).
(defun dxdy_sc_xy (p0 dx dy scx scy dir_0)
  (dxdy p0 (* dx scx) (* dy scy) dir_0)
)

;;	rotate_sc(p0 point alfa sc )	- Поворот точки point вокруг p0 на угол alfa с масштабом sc.
(defun rotate_sc (p0 point alfa sc / a d)
  (setq a (+ alfa (angle p0 point)))
  (setq d (* (distance p0 point) sc))
  (polar p0 a d)
)

;;	polar_dir_0 (p0 ang r dir_0)	- Возвращает точку, лежащую на векторе p0<(angle+dir_0) на расстоянии r.	
(defun polar_dir_0 (p0 ang r dir_0)
  (polar p0 (+ ang dir_0) r)
)
 
;;	ins_block (p0 name sc dir_0)	- Производит вставку блока в чертеж
(defun ins_block (p0 name sc dir_0)
  (setq dir_0 (rtd dir_0))
  (command "._insert" name "_non" p0 sc sc dir_0)
)

;;	axis_(p0 r alfa dl dir_0)	- Проводит оси.
(defun axis_ (p0 r alfa dl dir_0 / pr sc p1 p2)
  (setq pr (rotate_sc p0 (polar p0 dir_0 r) alfa 1.0))
  (setq sc (+ (/ dl r) 1.0))
  (setq p1 (rotate_sc p0 pr 0.0 sc))
  (setq p2 (rotate_sc p0 pr pi sc))
  (command "_line" "_non" p1 "_non" p2 "")
  (setq p1 (rotate_sc p0 pr (/ pi 2.) sc))
  (setq p2 (rotate_sc p0 pr (/ pi -2.) sc))
  (command "_line" "_non" p1 "_non" p2 "")
)

;;	arc_(p0 r st_arc vertex_arc dir_0) - Построение дуги без осей.
(defun arc_ (p0 r st_arc vertex_arc dir_0 / p_st p_sc p_en)
  (setq p_st (polar_dir_0 p0 st_arc r dir_0))
  (setq p_sc (rotate_sc p0 p_st (/ vertex_arc 2.) 1.))
  (setq p_en (rotate_sc p0 p_st vertex_arc 1.))
  (command "_arc" "_non" p_st "_non" p_sc "_non" p_en)
)

;;	circle_arc (p0 rc ra dl ang_axis st_arc ver_arc dir_0) - Окружность и дуга с осями.
(defun circle_arc (p0 rc ra dl ang_axis st_arc ver_arc dir_0 / r)
  (if (< ra rc)
    (setq r rc)
    (setq r ra)
  )
  (arc_ p0 ra (+ st_arc ang_axis) ver_arc dir_0)
  (command "_circle" "_non" p0 rc)
  (axis_ p0 r ang_axis dl dir_0)
)

;;	ax (circ dl ang)		- Строит оси для дуги ИЛИ окружности circ выступающие на dl.
(defun ax (circ dl ang / p0 r)
  (setq p0 (get_dxf circ 10))
  (setq r (get_dxf circ 40))
  (setq p0 (trans p0 0 1))
  (axis_ p0 r ang dl 0)
)

;;	p_ax (circ dl polus)		- Строит оси, проходящие через полюс polus, для дуги ИЛИ окружности circ выступающие на dl.
(defun p_ax (circ dl polus / p0 r ang)
  (setq p0 (get_dxf circ 10))
  (setq r (get_dxf circ 40))
  (setq p0 (trans p0 0 1))
  (setq ang (angle p0 polus) )
  (axis_ p0 r ang dl 0)
)

;;	inters_c_l (cir lin)		- Возвращает точки пересечения окружности и линии. Первой возвращается точка в направлении p0->p1 - второй p1->p0 от точки p_per.
(defun inters_c_l (cir lin / l_pts P0 P1 PC P_PER R R1 l_pts)
  (setq
    r	  (cdr (assoc 40 cir))
    p0	  (cdr (assoc 10 lin))
    p1	  (cdr (assoc 11 lin))
    pc	  (cdr (assoc 10 cir))
    p_per (inters p0
		  p1
		  pc
		  (polar pc (+ (/ pi 2.0) (angle p0 p1)) 1.0)
		  nil
	  )
    r1	  (distance pc p_per)
    l_pts
	  (cond
	    (
	     (equal r1 r 0.000001)
	     (list p_per)
	    )
	    (
	     (< r1 r)
	     (list
	       (polar
		 p_per
		 (angle p0 p1)
		 (sqrt (- (* r r) (* r1 r1)))
	       )
	       (polar
		 p_per
		 (angle p1 p0)
		 (sqrt (- (* r r) (* r1 r1)))
	       )
	     )
	    )
	    ((> r1 r)
	     nil
	    )
	  )
  )
  l_pts
)

;;;inters_c_c (cir1 cir_2)
;;;Возвращает список точек пересечения двух окружностей.
;;;Первой в списке возвращается точка при повороте луча, соединяющего из центр первой окружности
;;;с центром второй в направлении против часовой стрелки, второй - по часовой. 

(defun inters_c_c (cir_1 cir_2 / ALFA A_P1_P2 D_PC_1-PC_2 PC_1 PC_2 P_INT_1 P_INT_2 P_PERIM R_1 R_2)
  (setq
    r_1	 (cdr (assoc 40 cir_1))
    pc_1 (cdr (assoc 10 cir_1))
    r_2	 (cdr (assoc 40 cir_2))
    pc_2 (cdr (assoc 10 cir_2))
  )
  (setq d_pc_1-pc_2 (distance pc_1 pc_2))
  (cond
    ((and (<= (- d_pc_1-pc_2 (+ r_1 r_2)) 0.0 )
	  (<= (- (max r_1 r_2) (+ d_pc_1-pc_2(min r_1 r_2))) 0.0 )
	  )
     (setq
       p_perim (* 0.5 (+ d_pc_1-pc_2 r_1 r_2))
       alfa    (* 2.0
		  (atan
		    (sqrt
		      (/
			(*
			  (- p_perim r_1)
			  (- p_perim d_pc_1-pc_2)
			)
			(* p_perim
			   (- p_perim r_2)
			)
		      )
		    )
		  )
	       )
       a_p1_p2 (angle pc_1 pc_2)
       p_int_1 (polar pc_1 (+ a_p1_p2 alfa) r_1)
       p_int_2 (polar pc_1 (- a_p1_p2 alfa) r_1)
     )
     (list p_int_1 p_int_2)
    )
    (t nil)
  )
)

;;;f;;;("ss_to_list" "Преобразует набор примитивов в список, содержащий имена примитивов.")
(defun ss_to_list (ss / ename_list i sslen)
  (setq
    sslen (sslength ss)
    i	  0
  )
  (while (< i sslen)
    (setq ename_list (cons (ssname ss i) ename_list)
	  i	    (1+ i)
    )
  )
  ename_list
)
;;;f;;;("list_to_ss" "Преобразует список, содержащий имена примитивов в набор примитивов.")
(defun list_to_ss (ename_list / ss)
  (setq ss (ssadd))
  (mapcar
    (function
      (lambda (el)
	(ssadd el ss)
      )
    )
    ename_list
  )
  ss
)
(princ "\t...загружен.\n")
;|«Visual LISP© Format Options»
(72 2 5 2 nil "end of" 60 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
	