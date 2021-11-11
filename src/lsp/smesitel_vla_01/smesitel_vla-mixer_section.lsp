(setq p-0  '(0.0 0.0 0.0)
      pi/2 (/ pi 2))

(setq R-in    (/ 523.0 2.0)
      L-1     -26.0
      L-2     42.5
      R-1     64.8
      R-2     47.0
      R-3     18.5
      R-4     (/ 636.0 2.0)
      R-5     58.4
      alpha-2 (dtr (+ 90.0 30.0))
      alpha-1 (dtr 15.0)
      delta   10.0)

(defun draw-points  ()
  (dr:point p-0 1)
  (dr:point p-1 2)
  (dr:point p-2 3)
  (dr:point p-3 6)
  (dr:point p-4 10)
  (dr:point p-5 20)
  (dr:point p-6 30)
  (dr:point p-7 40)
  (dr:point p-7-1 50)
  (dr:point p-8 60)
  (dr:point p-8-b 70)
  (dr:point p-8-e 80)
  (dr:point p-10 90)
  (dr:point p-11 100)
  (dr:point p-R1 4)
  (dr:point p-R2 5))

(defun draw-profile  ()
  (setq v-a-1 (vlax-vla-object->ename (dr:arc p-3 r-5 (+ alpha-2 pi/2) (* 3.0 pi/2) 1)))
  (setq v-l-2 (vlax-vla-object->ename (dr:line p-4 p-8-e 2)))
  (setq v-a-3 (vlax-vla-object->ename (dr:arc p-R1 R-1 pi/2 (+ alpha-2 pi/2) 1)))
  (setq v-l-4 (vlax-vla-object->ename (dr:line p-7 p-13 3)))
  (setq v-a-5 (vlax-vla-object->ename (dr:arc p-R2 R-2 (- alpha-1 pi/2) pi/2 1)))
  (setq v-l-6 (vlax-vla-object->ename (dr:line p-10 p-12-e 4)))
  (setq v-a-7 (vlax-vla-object->ename (dr:arc p-2 R-3 (+ alpha-1 pi/2) pi 1)))
  (list v-a-1 v-l-2 v-a-3 v-l-4 v-a-5 v-l-6 v-a-7))

(mapcar (function (lambda (el) (eval (read el))))
	  (list	"v-a-1"	"v-l-2"	"v-a-3"	"v-l-4"	"v-a-5"	"v-l-6"	"v-a-7"))

(defun draw-sech-4	(L-b	L-s     /      p-1    p-2    p-3	   p-4
		 p-5	p-6    p-7    p-7-1  p-8    p-8-b  p-R1
		 R-1	p-8-e  p-10   p-11   p-12   p-12-b p-13
		 p-13-1	p-R2   R-2    p-12-e)
  (setq p-1 (polar p-0 pi/2 R-in))
  (setq p-2 (polar p-1 pi/2 L-2))
  (setq p-3 (polar p-1 pi/2 R-5))
  (setq p-4 (polar p-3 (+ alpha-2 pi/2) R-5))
  (setq p-5 (polar p-4 alpha-2 delta))
  (setq p-6 (polar p-1 pi/2 L-b))
  (setq p-7 (polar p-6 0.0 L-1))
  (setq p-7-1 (polar p-7 pi/2 delta))
  (setq p-8 (INTERS p-4 p-5 p-6 p-7 nil))
  (setq p-8-b (polar p-8 (/ (- alpha-2 pi) 2.0) delta))
  (setq p-R1 (INTERS p-7 p-7-1 p-8 p-8-b nil))
  (setq R-1 (distance p-7 p-R1))
  (setq p-8-e (polar p-R1 (+ alpha-2 pi/2) R-1))
  (setq p-10 (polar p-2 (+ alpha-1 pi/2) R-3))
  (setq p-11 (polar p-10 alpha-1 delta))
  (setq p-12 (INTERS p-6 p-7 p-10 p-11 nil))
  (setq p-12-b (polar p-12 (/ alpha-1 2.0) delta))
  (setq p-13 (polar p-7 0.0 L-s))
  (setq p-13-1 (polar p-13 pi/2 delta))
  (setq p-R2 (INTERS p-13 p-13-1 p-12 p-12-b nil))
  (setq R-2 (distance p-13 p-R2))
  (setq p-12-e (polar p-R2 (- alpha-1 pi/2) R-2))
  (draw-profile))

;;(draw-sech-4 161.0 80.)
;;(setq L-b 181.0 L-s 114.0) (section L-b L-s)

;;===================================================================================================


;;(draw_sech_3 p_0 y_top r_top y_bot r_bot l_bok alfa_bok r_kt r_kb)
;;Производит отрисовку сечения по форме см. пример ниже
;;_$(draw_sech_3 '(0.0 0.0 0.0) 113.6705 229.4598 -86.6927 102.4201 80.0 (* -18.0 (/ pi 180.) ) 30.0 50.)
;;_$(draw_sech_3 '(0.0 0.0 0.0) 113.6705 229.4598 -86.6927 -102.4201 80.0 (* -18.0 (/ pi 180.) ) 30.0 50.)
;;Возвращает список из 6-ти элементов:
;;1. полилиния правой стороны смесителя;
;;2. нижняя дуга левой стороны сечения смесителя;
;;3. нижняя боковая дуга левой стороны сечения смесителя;
;;4. боковая линия левой стороны сечения смесителя;
;;5. правая боковая дуга левой стороны сечения смесителя;
;;6. верхняя дуга левой стороны сечения смесителя.
;;
;;;Глобальные переменные
;;;area_lst	- Накапливание полу-площадей поперечных сечений
;;;per-r_top	- Накапливание периметра r_top	(верхний радиус)
;;;per-r_kt	- Накапливание периметра r_kt	(переход от верхнего радиуса к боковой поверхности)	
;;;per-l_bok	- Накапливание периметра l_bok	(боковая поверхность)
;;;per-r_kb	- Накапливание периметра r_kb	(переход от боковой поверхности к нижнему радиусу
;;;per-r_bot	- Накапливание периметра r_bot	(нижний радиус)
;;;length_lst   - Накапливание полу-периметров поперечных сечений
(defun draw_sech_3  (p_0       y_top	 r_top	   y_bot     r_bot
		     l_bok     alfa_bok	 r_kt	   r_kb	     /
		     PB_KB     PB_KT	 PC_BOT	   PC_KB     PC_KT
		     PC_TOP    P_BOK	 P_BOT	   P_TOP     V_BOK
		     V_BOK_KB  V_BOK_KT	 V_BOT	   V_BOT_KB  V_KB
		     V_KT      V_PLY	 V_TOP	   V_TOP_KT  v_bot_mir
		     v_kb_mir  v_bok_mir v_kt_mir  v_top_mir color_bot
		     color_top color_kt	 color_kb  color_l)
  (setq	color_top 1
	color_bot 2
	color_kt 3
	color_kb 4
	color_l_bok 6
	color_ply 7)
  (setq	p_top  (polar p_0 (/ pi 2) y_top)
	p_bot  (polar p_0 (/ pi 2) y_bot)
	pc_top (polar p_top (/ pi -2) R_top)
	pc_bot (polar p_bot (/ pi 2) R_bot)
	p_bok  (polar p_0 alfa_bok l_bok)
	pb_kb  (polar p_0 alfa_bok (- l_bok r_kb))
	pb_kt  (polar p_0 alfa_bok (- l_bok r_kt)))
  (setq v_top_kt (dr:arc pc_top (- r_top r_kt) 0.0 (/ pi 2) 15))
  (cond	((> r_bot 0.0)
	 (setq v_bot_kb (dr:arc pc_bot (- r_bot r_kb) (/ pi -2) 0.0 25)))
	((< r_bot 0.0)
	 (setq v_bot_kb
		(dr:arc pc_bot (+ (abs r_bot) r_kb) 0.0 (/ pi 2) 25))))
  (setq	v_bok_kb (dr:line pb_kb
			  (polar pb_kb (+ alfa_bok (/ pi 2)) l_bok)
			  35)
	v_bok_kt (dr:line pb_kt
			  (polar pb_kt (+ alfa_bok (/ pi 2)) l_bok)
			  45))
  (setq	pc_kb (vlax-safearray->list
		(vlax-variant-value
		  (vlax-invoke-method
		    v_bot_kb
		    'IntersectWith
		    v_bok_kb
		    acExtendOtherEntity)))
	pc_kt (vlax-safearray->list
		(vlax-variant-value
		  (vlax-invoke-method
		    v_top_kt
		    'IntersectWith
		    v_bok_kt
		    acExtendOtherEntity))))
  (setq
    v_kt (dr:arc pc_kt r_kt alfa_bok (angle pc_top pc_kt) color_kt))
  (setq	v_top (dr:arc pc_top
		      r_top
		      (angle pc_top pc_kt)
		      (/ pi 2)
		      color_top))
  (cond	((> r_bot 0.0)
	 (setq v_kb  (dr:arc pc_kb r_kb (angle pc_bot pc_kb) alfa_bok color_kb)
	       v_bot (dr:arc pc_bot
			     r_bot
			     (/ pi -2)
			     (angle pc_bot pc_kb)
			     color_bot)))
	((< r_bot 0.0)
	 (setq v_kb  (dr:arc pc_kb r_kb (angle pc_kb pc_bot) alfa_bok color_kb)
	       v_bot (dr:arc pc_bot
			     (abs r_bot)
			     (angle pc_bot pc_kb)
			     (/ pi 2)
			     color_bot))))
  (setq	v_bok (dr:line (vlax-safearray->list
			 (vlax-variant-value
			   (vlax-get-property v_kb 'EndPoint)))
		       (vlax-safearray->list
			 (vlax-variant-value
			   (vlax-get-property v_kt 'StartPoint)))
		       color_l_bok))
  (mapcar (function (lambda (el)
		      (vlax-invoke-method el 'Delete)
		      (vlax-release-object el)))
	  (list v_top_kt v_bot_kb v_bok_kt v_bok_kb))
  (mapcar (function
	    (lambda (el)
	      (command-s "_mirror"
			 (vlax-vla-object->ename (eval (read el)))
			 ""
			 p_top
			 p_bot
			 "_N")
	      (set (read (strcat el "_mir"))
		   (vlax-ename->vla-object (entlast)))))
	  (list "v_bot" "v_kb" "v_bok" "v_kt" "v_top"))
  (command-s "_pedit"
	     (vlax-vla-object->ename v_bot)
	     "_y"
	     "_j"
	     (vlax-vla-object->ename v_kb)
	     (vlax-vla-object->ename v_bok)
	     (vlax-vla-object->ename v_kt)
	     (vlax-vla-object->ename v_top)
	     ""
	     "")
  (setq v_ply (vlax-ename->vla-object (entlast)))
  (vlax-put-property v_ply 'Color color_ply)
  (append
    (list v_ply)
    (mapcar (function (lambda (el) (eval (read (strcat el "_mir")))))
	    (list "v_bot" "v_kb" "v_bok" "v_kt" "v_top"))))


(defun smesitel_vla_put	 (v_name / handle)
  (setq handle (vlax-get-property (eval (read v_name)) "Handle"))
  (vlax-ldata-put "smesitel_vla" v_name handle))

(defun set_vla_name_handle_lst	(/ lst handle_lst vla_name_lst)
  (setq	lst	     (vlax-ldata-list "smesitel_vla")
	handle_lst   (mapcar (function cdr) lst)
	vla_name_lst (mapcar (function car) lst))
  (mapcar (function set_vla_name_handle)
	  handle_lst
	  vla_name_lst))

(defun set_vla_name_handle  (handle vla_name / ename)
  (setq ename (find_ename_whis_handle handle))
  (set (read vla_name) (vlax-ename->vla-object ename)))


(defun smesitel_vla_put_lst  ()
  (mapcar (function smesitel_vla_put)
	  '("v_pl_axis" "v_l_axis" "v_l-b" "v_l-s")))


;;;;;;("prep:sm" "Подготовка данных для построения смесителя. См. команду dr:sm." "Смеситель")
(defun c:prep:sm  ()
  (prompt "Выберите ось смесителя:")
  (vla-obj "v_pl_axis")
  (prompt
    "Ось абсцисс зависимостей, изображающих параметры смесителя:")
  (vla-obj "v_l_axis")
  (prompt "Зависимость для параметра L-b (высота смесителя):")
  (vla-obj "v_l-b")
  (prompt
    "Зависимость для параметра L-s (длина прямолинейного участка):")
  (vla-obj "v_l-s")
  (smesitel_vla_put_lst))

;;;;;;("dr:sm"
;;;;;;"Проект Smesitel_vla.\n
;;;;;;	Проект предназначен для проектирования линейчатого каркаса смесителя жаровой трубы.\n
;;;;;;	Проект определяет следующие команды:\n
;;;;;;		prep:sm    - подготовка данных для построения сместеля;\n
;;;;;;		dr:sm      - отрисовка смесителя по подготовленным данным;\n
;;;;;;		dr:sech    - отрисовка одиночного сечения по длине;\n
;;;;;;		clear:sm   - очистка списка образующий, сохраняемых в расширенном словаре;
;;;;;;		vla-obj    - предназначена для замены одной из образующих смесителя.\n
;;;;;;\n
;;;;;;	Проект определяет следующие переменные, используемые для хренения образующих и геометрических параметров смесителя:\n
;;;;;;		v_pl_axis      - ось смесителя;\n
;;;;;;\n
;;;;;;		v_spl_top      - верхняя образующая смесителя;\n
;;;;;;		v_spl_bot      - нижняя образующая смесителя;\n
;;;;;;\n
;;;;;;		v_l_axis       - ось абсцисс для зависимостей следующих ниже;\n
;;;;;;\n
;;;;;;		v_spl_l_bok    - боковая образующая смесителя;\n
;;;;;;		v_spl_r_top    - радиус верхней образующей;\n
;;;;;;		v_spl_kr_bot   - кривизна нижней образующей;\n
;;;;;;		v_spl_r_kt     - радиус перехода от боковой образующей к верхней образующей;\n
;;;;;;		v_spl_r_kb     - радиус перехода от боковой образующей к нижней образующей;\n
;;;;;;		v_spl_alfa_bok - зависимость угла, выраженную в градусах, между осью абсцисс сечения и перпендикуляром, опущенным из центра координат сечения на боковую образующую.\n
;;;;;;\n
;;;;;;		Площади поперечных сечений смесителя находятся в переменной area_lst.\n
;;;;;;		Длины полупериметров поперечных сечений находятся в переменной length_lst.\n
;;;;;;		Для построения графиков зависимостей площади поперечного сечения и полупериметров следует воспользоваться командой a1.\n
;;;;;;" "Смеситель")
(defun c:dr:sm	(/			;
		 div			; Количество промежутков между сечениями
		 delta_l_axis-length	; Приращение вдоль оси зависимостей
		 delta_pl_axis-length	; Приращение вдоль оси полилинии
		 dist_l			; Текущая координата вдоль оси зависимостей
		 dist_pl		; Текущая координата вдоль оси полилинии
		 i			; Текущее сечение
		 lst			; 
		 param_alfa_bok		; Угол наклона воковой образующей
		 param_l_bok		; Расстояние от центра сечения до боковой образующей
		 param_r_kb		; Радиус перехода от боковой образующей к нижней образующей
		 param_r_kt		; Радиус перехода от боковой образующей к верхней образующей
		 param_top		; - Расстояние до верхней образующей
		 param_bot		; - Расстояние до нижней образующей
		 param_r_top		; - Верхний радиус
		 param_kr_bot		; - Кривизна нижнего радиуса
		 param_r_bot		; - Нижний радиус
		 par_pl			; - Значение параметра в текущей точке на оси смесителя
		 par_l			; - Значение параметра в текущей точке на оси зависимостей
		 par_pnt		; 
		 par_pntFD		;
		 )
  (setq	area_lst nil
	length_lst nil)
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (setq	div 50
	delta_pl_axis-length
	 (/ (vlax-get-property v_pl_axis 'Length) div)
	delta_l_axis-length
	 (/ (vlax-get-property v_l_axis 'Length) div))
  (setq i (+ 1 div))
  (while (>= (setq i (1- i)) 1)
    (setq dist_pl   (* i delta_pl_axis-length)
	  par_pl    (vlax-curve-getParamAtDist v_pl_axis dist_pl)
	  par_pnt   (vlax-curve-getPointAtParam v_pl_axis par_pl)
	  par_pntFD (vlax-curve-getFirstDeriv v_pl_axis par_pl)
	  pl-dist   (vlax-curve-getDistAtParam v_pl_axis par_pl))
    (setq param_l-b (distance-from-curve-by-param-to-curve
		      v_l_axis
		      pl-dist
		      v_l-b))
    (setq param_l-s (distance-from-curve-by-param-to-curve
		      v_l_axis
		      pl-dist
		      v_l-s))
    (setq pnt_1 (list 0.0 261.5 0.0))
    (setq lst (draw-sech-4 param_l-b param_l-s))
    (mapcar
      (function
	(lambda	(el)			; Перенос сечений в место назначения
	  (setq v-el (vlax-ename->vla-object el))
	  (vlax-invoke-method
	    v-el
	    'Move
	    (vlax-3D-point pnt_1)
	    (vlax-3D-point par_pnt))
	  (vlax-invoke-method
	    v-el
	    'Rotate
	    (vlax-3D-point par_pnt)
	    (angle par_pntFD '(0.0 0.0 0.0)))
	  (vlax-invoke-method
	    v-el
	    'Rotate3D
	    (vlax-3D-point par_pnt)
	    (vlax-3D-point
	      (polar par_pnt
		     (- (angle '(0.0 0.0 0.0) par_pntFD) (/ pi 2))
		     100.0))
	    (/ pi -2))))
      lst)
    ;;(setq area_lst   (cons (list dist_pl (vlax-get-property (nth 0 lst) 'Area))   area_lst))
    ;;(setq length_lst (cons (list dist_pl (vlax-get-property (nth 0 lst) 'Length)) length_lst))
    )
  ;; (smesitel_vla_put_lst)
  ;; (mapcar (function (lambda (el) (vl-doc-set el (eval el))))	  '(area_lst length_lst))
  (err-handle ""))






	  

;;	Знак величины
;;_$ (digit 10.5564)
;;1.0
;;_$ (digit -10.5564)
;;-1.0
(defun digit (val) (/ val (abs val)))

(defun c:sm:help  ()
  (princ
    "Проект Smesitel_vla.
	Проект предназначен для проектирования линейчатого каркаса смесителя жаровой трубы.
	Проект определяет следующие команды:
		prep:sm    - подготовка данных для построения сместеля;
		dr:sm      - отрисовка смесителя по подготовленным данным;
		dr:sech    - отрисовка одиночного сечения по длине;
		clear:sm   - очистка списка образующий, сохраняемых в расширенном словаре;
		vla-obj    - предназначена для замены одной из образующих смесителя.
		
	Проект определяет следующие переменные, используемые для хренения образующих и геометрических параметров смесителя: 
		v_pl_axis      - ось смесителя;

		v_spl_top      - верхняя образующая смесителя; 
		v_spl_bot      - нижняя образующая смесителя;
		
		v_l_axis       - ось абсцисс для зависимостей следующих ниже;
		
		v_spl_l_bok    - боковая образующая смесителя;
		v_spl_r_top    - радиус верхней образующей;
		v_spl_kr_bot   - кривизна нижней образующей;
		v_spl_r_kt     - радиус перехода от боковой образующей к верхней образующей;
		v_spl_r_kb     - радиус перехода от боковой образующей к нижней образующей;
		v_spl_alfa_bok - зависимость угла, выраженную в градусах, между осью абсцисс сечения и перпендикуляром, опущенным из центра координат сечения на боковую образующую.

		Площади поперечных сечений смесителя находятся в переменной area_lst.
		Длины полупериметров поперечных сечений находятся в переменной length_lst.
		Для построения графиков зависимостей площади поперечного сечения и полупериметров следует воспользоваться командой a1.
"   ))

(set_vla_name_handle_lst)


