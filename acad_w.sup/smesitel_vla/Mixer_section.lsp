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
(defun draw_sech_3
		   (p_0	      y_top	r_top	  y_bot	    r_bot
		    l_bok     alfa_bok	r_kt	  r_kb	    /
		    PB_KB     PB_KT	PC_BOT	  PC_KB	    PC_KT
		    PC_TOP    P_BOK	P_BOT	  P_TOP	    V_BOK
		    V_BOK_KB  V_BOK_KT	V_BOT	  V_BOT_KB  V_KB
		    V_KT      V_PLY	V_TOP	  V_TOP_KT  v_bot_mir
		    v_kb_mir  v_bok_mir	v_kt_mir  v_top_mir
		    color_bot color_top color_kt color_kb color_l
		   )
  (setq color_top 1
	color_bot 2
	color_kt 3
	color_kb 4
	color_l_bok 6
	color_ply 7
	)
  (setq
    p_top  (polar p_0 (/ pi 2) y_top)
    p_bot  (polar p_0 (/ pi 2) y_bot)
    pc_top (polar p_top (/ pi -2) R_top)
    pc_bot (polar p_bot (/ pi 2) R_bot)
    p_bok  (polar p_0 alfa_bok l_bok)
    pb_kb  (polar p_0 alfa_bok (- l_bok r_kb))
    pb_kt  (polar p_0 alfa_bok (- l_bok r_kt))

  )
  (setq v_top_kt (dr:arc pc_top (- r_top r_kt) 0.0 (/ pi 2) 15))
  (cond
    ((> r_bot 0.0)
     (setq v_bot_kb (dr:arc pc_bot (- r_bot r_kb) (/ pi -2) 0.0 25))
    )
    ((< r_bot 0.0)
     (setq
       v_bot_kb	(dr:arc pc_bot (+ (abs r_bot) r_kb) 0.0 (/ pi 2) 25)
     )
    )
  )
  (setq
    v_bok_kb (dr:line pb_kb
		      (polar pb_kb (+ alfa_bok (/ pi 2)) l_bok)
		      35
	     )
    v_bok_kt (dr:line pb_kt
		      (polar pb_kt (+ alfa_bok (/ pi 2)) l_bok)
		      45
	     )
  )
  (setq	pc_kb
	      (vlax-safearray->list
		(vlax-variant-value
		  (vlax-invoke-method
		    v_bot_kb
		    'IntersectWith
		    v_bok_kb
		    acExtendOtherEntity
		  )
		)
	      )
	pc_kt
	      (vlax-safearray->list
		(vlax-variant-value
		  (vlax-invoke-method
		    v_top_kt
		    'IntersectWith
		    v_bok_kt
		    acExtendOtherEntity
		  )
		)
	      )
  )

  (setq v_kt (dr:arc pc_kt r_kt alfa_bok (angle pc_top pc_kt) color_kt))
  (setq v_top (dr:arc pc_top r_top (angle pc_top pc_kt) (/ pi 2) color_top))
  (cond
    ((> r_bot 0.0)
     (setq v_kb	 (dr:arc pc_kb r_kb (angle pc_bot pc_kb) alfa_bok color_kb)
	   v_bot (dr:arc pc_bot r_bot (/ pi -2) (angle pc_bot pc_kb) color_bot)
     )
    )
    ((< r_bot 0.0)
     (setq v_kb	 (dr:arc pc_kb r_kb (angle pc_kb pc_bot) alfa_bok color_kb)
	   v_bot (dr:arc pc_bot
			 (abs r_bot)
			 (angle pc_bot pc_kb)
			 (/ pi 2)
			 color_bot
		 )
     )
    )
  )
  (setq
    v_bok
     (dr:line
       (vlax-safearray->list
	 (vlax-variant-value (vlax-get-property v_kb 'EndPoint))
       )
       (vlax-safearray->list
	 (vlax-variant-value (vlax-get-property v_kt 'StartPoint))
       )
       color_l_bok
     )
  )
  (mapcar
    (function
      (lambda (el)
	(vlax-invoke-method el 'Delete)
	(vlax-release-object el)
      )
    )
    (list v_top_kt v_bot_kb v_bok_kt v_bok_kb)
  )

  (mapcar
    (function
      (lambda (el)
	(VL-CMDF "_mirror"
		 (vlax-vla-object->ename (eval (read el)))
		 ""
		 p_top
		 p_bot
		 "_N"
	)
	(set (read (strcat el "_mir"))
	     (vlax-ename->vla-object (entlast))
	)
      )
    )
    (list "v_bot" "v_kb" "v_bok" "v_kt" "v_top")
  )

  (VL-CMDF "_pedit"
	   (vlax-vla-object->ename v_bot)
	   "_y"
	   "_j"
	   (vlax-vla-object->ename v_kb)
	   (vlax-vla-object->ename v_bok)
	   (vlax-vla-object->ename v_kt)
	   (vlax-vla-object->ename v_top)
	   ""
	   ""
  )
  (setq v_ply (vlax-ename->vla-object (entlast)))
  (vlax-put-property v_ply 'Color color_ply)
  (append
    (list v_ply)
    (mapcar
      (function
	(lambda	(el)
	  (eval (read (strcat el "_mir")))
	)
      )
      (list "v_bot" "v_kb" "v_bok" "v_kt" "v_top")
    )
  )
)

;;;;;;("prep:sm" "Подготовка данных для построения смесителя. См. команду dr:sm." "Смеситель")
(defun c:prep:sm ()
  (prompt
    "Выберите ось смесителя:"
  )
  (vla-obj "v_pl_axis")
  (prompt
    "Верхняя образующая смесителя:"
  )
  (vla-obj "v_spl_top")
  (prompt
    "Нижняя образующая смесителя:"
  )
  (vla-obj "v_spl_bot")
  (prompt
    "Ось абсцисс зависимостей, изображающих параметры смесителя:"
  )
  (vla-obj "v_l_axis")
  (prompt
    "Зависимость верхнего радиуса:"
  )
  (vla-obj "v_spl_r_top")
  (prompt
    "Зависимость кривизны нижнего радиуса*10000:"
  )
  (vla-obj "v_spl_kr_bot")
  (prompt
    "Зависимость радиуса перехода от верхней к боковой образующей:"
  )
  (vla-obj "v_spl_r_kt")
  (prompt
    "Зависимость радиуса перехода от нижней к боковой образующей:"
  )
  (vla-obj "v_spl_r_kb")
  (prompt
    "Зависимость боковой образующей:"
  )
  (vla-obj "v_spl_l_bok")
  (prompt
    "Зависимость угла боковой образующей:"
  )
  (vla-obj "v_spl_alfa_bok")
  (smesitel_vla_put_lst)
)


(defun smesitel_vla_put_lst ()
  (mapcar (function smesitel_vla_put)
	  '("v_pl_axis"	       "v_spl_top"	  "v_spl_bot"	     "v_l_axis"
	    "v_spl_r_top"      "v_spl_kr_bot"	  "v_spl_r_kt"	     "v_spl_r_kb"
	    "v_spl_l_bok"      "v_spl_alfa_bok"
	   )
  )
)


(defun smesitel_vla_put (v_name / handle)
  (setq handle (vlax-get-property (eval (read v_name)) "Handle"))
  (vlax-ldata-put "smesitel_vla" v_name handle )
)

(defun set_vla_name_handle_lst (/ lst handle_lst vla_name_lst)
  (setq
    lst	       (vlax-ldata-list "smesitel_vla" )
    handle_lst (mapcar (function cdr) lst)
    vla_name_lst(mapcar (function car) lst)
  )
  (mapcar (function set_vla_name_handle)
	  handle_lst
	  vla_name_lst
  )
)

(defun set_vla_name_handle(handle vla_name / ename)
  (setq	ename (find_ename_whis_handle handle))
  (set (read vla_name) (vlax-ename->vla-object ename))
)

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
(defun c:dr:sm (/								;
		div								; Количество промежутков между сечениями
		delta_l_axis-length						; Приращение вдоль оси зависимостей
		delta_pl_axis-length						; Приращение вдоль оси полилинии
		dist_l								; Текущая координата вдоль оси зависимостей
		dist_pl								; Текущая координата вдоль оси полилинии
		i								; Текущее сечение
		lst								; 
		param_alfa_bok							; Угол наклона воковой образующей
		param_l_bok							; Расстояние от центра сечения до боковой образующей
		param_r_kb							; Радиус перехода от боковой образующей к нижней образующей
		param_r_kt							; Радиус перехода от боковой образующей к верхней образующей
		param_top							; - Расстояние до верхней образующей
		param_bot							; - Расстояние до нижней образующей
		param_r_top							; - Верхний радиус
		param_kr_bot							; - Кривизна нижнего радиуса
		param_r_bot							; - Нижний радиус
		par_pl								; - Значение параметра в текущей точке на оси смесителя
		par_l								; - Значение параметра в текущей точке на оси зависимостей
		par_pnt								; 
		par_pntFD							;
	       )
  (setq	area_lst nil
	length_lst nil
  )

  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))

  (setq
    div	50
    delta_pl_axis-length
     (/ (vlax-get-property v_pl_axis 'Length) div)
    delta_l_axis-length
     (/ (vlax-get-property v_l_axis 'Length) div)
  )
  (setq i (1- div))
  (while (>= i 1)
    (setq
      dist_pl	     (* i delta_pl_axis-length)

      par_pl	     (vlax-curve-getParamAtDist v_pl_axis dist_pl)
      par_pnt	     (vlax-curve-getPointAtParam v_pl_axis par_pl)
      par_pntFD	     (vlax-curve-getFirstDeriv v_pl_axis par_pl)
      param_top	     (distance-from-curve-by-param-to-curve v_pl_axis par_pl v_spl_top)
      param_bot	     (distance-from-curve-by-param-to-curve v_pl_axis par_pl v_spl_bot)

      dist_l	     (* i delta_l_axis-length)
      par_l	     (vlax-curve-getParamAtDist v_l_axis dist_l)
      param_r_top    (distance-from-curve-by-param-to-curve v_l_axis par_l v_spl_r_top)
      param_kr_bot   (distance-from-curve-by-param-to-curve v_l_axis par_l v_spl_kr_bot)
      param_kr_bot   (/ param_kr_bot 10000.0)
      param_r_bot
		     (cond
		       ((<= (abs param_kr_bot) 0.0001)
			(if (minusp param_kr_bot)
			  -10000.0
			  10000.0
			)
		       )
		       (t (/ 1.0 param_kr_bot))
		     )
      param_r_kt     (distance-from-curve-by-param-to-curve v_l_axis par_l v_spl_r_kt)
      param_r_kb     (distance-from-curve-by-param-to-curve v_l_axis par_l v_spl_r_kb)
      param_l_bok    (distance-from-curve-by-param-to-curve v_l_axis par_l v_spl_l_bok)
      param_alfa_bok (distance-from-curve-by-param-to-curve v_l_axis par_l v_spl_alfa_bok)
      param_alfa_bok (/ param_alfa_bok (/ 180. pi))
      pnt_1	     (list 0.0 0.0 dist_pl)
    )
    (setq lst
	   (draw_sech_3
	     pnt_1 param_top param_r_top param_bot param_r_bot param_l_bok param_alfa_bok param_r_kt param_r_kb)
    )
    (mapcar
      (function
	(lambda	(el)								; Перенос сечений в место назначения
	  (vlax-invoke-method el 'Move (vlax-3D-point pnt_1) (vlax-3D-point par_pnt))
	  (vlax-invoke-method el 'Rotate (vlax-3D-point par_pnt) (angle '(0.0 0.0 0.0) par_pntFD))
	  (vlax-invoke-method el
			      'Rotate3D
			      (vlax-3D-point par_pnt)
			      (vlax-3D-point
				(polar par_pnt (+ (/ pi 2) (angle '(0.0 0.0 0.0) par_pntFD)) (distance '(0.0 0.0 0.0) par_pntFD))
			      )
			      (/ pi 2)
	  )
	)
      )
      lst
    )
    (setq
      area_lst
		 (cons (list dist_pl (vlax-get-property (nth 0 lst) 'Area)) area_lst)
      length_lst
		 (cons (list dist_pl (vlax-get-property (nth 0 lst) 'Length)) length_lst)
    )
    (setq i (1- i))
  )
  (smesitel_vla_put_lst)
  (mapcar
    (function (lambda (el) (vl-doc-set el (eval el))))
    '(area_lst length_lst)
  )
  (err-handle "")
)

;;	Знак величины
;;_$ (digit 10.5564)
;;1.0
;;_$ (digit -10.5564)
;;-1.0
(defun digit (val)
  (/ val (abs val))
)

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
"
)
(set_vla_name_handle_lst)
(princ)
;|«Visual LISP© Format Options»
(100 2 40 2 nil "end of" 60 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
