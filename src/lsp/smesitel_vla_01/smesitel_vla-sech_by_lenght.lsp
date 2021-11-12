;;;;;;("dr:sech"
;;;;;; "¬ыполн€ет отрисовку одиночного сечени€ по углу его расположени€."
;;;;;; "—меситель")
(defun c:dr:sech  (/			; area_lst - площади сечений смесител€ (доделать);
					; length_lst - периметры сечений смесител€ (доделать);
					; div -  оличество промежутков между сечени€ми
		     delta_pl_axis-length
					; ѕриращение вдоль оси полилинии
		     delta_l_axis-length; ѕриращение вдоль оси зависимостей
		     i			; “екущее сечение
		     dist_pl		; “екуща€ координата вдоль оси полилинии
		     par_pl		; «начение параметра в текущей точке на оси смесител€
		     par_pnt		;
		     par_pntFD		; ѕерва€ производна€ на оси сечений смесител€
		     pl-dist		;
		     param_l-b		; «начение параметра L-b
		     param_l-s		; «начение параметра L-s
		     pnt_1		;
		     lst		; —писок ename примитивов, вход€щих в сечение
		     ang-sech		; ”гол расположени€ сечени€
		     )
  (init-vars)
  (if (not (and v-pl-axis v-l-axis v_l-b v-l-s))
    (c:prep:sm))
  (setq ang-sech (GETANGLE "¬ведите угол расположени€ сечени€:"))
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (setq	dist_pl	  (* R-in (- ang-sech pi/2))
	par_pl	  (vlax-curve-getParamAtDist v-pl-axis dist_pl)
	par_pnt	  (vlax-curve-getPointAtParam v-pl-axis par_pl)
	par_pntFD (vlax-curve-getFirstDeriv v-pl-axis par_pl)
	pl-dist	  (vlax-curve-getDistAtParam v-pl-axis par_pl))
  (setq	param_l-b (distance-from-curve-by-param-to-curve
		    v-l-axis
		    pl-dist
		    v_l-b))
  (setq	param_l-s (distance-from-curve-by-param-to-curve
		    v-l-axis
		    pl-dist
		    v-l-s))
  (setq pnt_1 (list 0.0 261.5 0.0))
  (setq lst (draw-sech-4 param_l-b param_l-s))
  (err-handle ""))

