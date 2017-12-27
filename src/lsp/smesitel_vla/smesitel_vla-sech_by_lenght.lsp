;;;;;;("dr:sech" "Построение одиночного сечения смесителя." "Смеситель")
(defun c:dr:sech  (/                    ;
                   delta_l_axis-length  ; Приращение вдоль оси зависимостей
                   delta_pl_axis-length ; Приращение вдоль оси полилинии
                   dist_l               ; Текущая координата вдоль оси зависимостей
                   dist_pl              ; Текущая координата вдоль оси полилинии
                   lst                  ; 
                   param_alfa_bok       ; Угол наклона воковой образующей
                   param_l_bok          ; Расстояние от центра сечения до боковой образующей
                   param_r_kb           ; Радиус перехода от боковой образующей к нижней образующей
                   param_r_kt           ; Радиус перехода от боковой образующей к верхней образующей
                   param_top            ; - Расстояние до верхней образующей
                   param_bot            ; - Расстояние до нижней образующей
                   param_r_top          ; - Верхний радиус
                   param_kr_bot         ; - Кривизна нижнего радиуса
                   param_r_bot          ; - Нижний радиус
                   par_pl               ; - Значение параметра в текущей точке на оси смесителя
                   par_l                ; - Значение параметра в текущей точке на оси зависимостей
                   par_pnt              ; 
                   par_pntfd            ;
                   )
  (setq area_lst nil
        length_lst nil)
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (setq delta_pl_axis-length (getdist "Введите расстояние от начала смесителя вдоль его оси по ходу газа:"))
  (setq delta_l_axis-length
         (* delta_pl_axis-length
            (/ (vlax-get-property v_l_axis 'length) (vlax-get-property v_pl_axis 'length))))
  (setq dist_pl        (* delta_pl_axis-length 1.0)
        par_pl         (vlax-curve-getparamatdist v_pl_axis dist_pl)
        par_pnt        (vlax-curve-getpointatparam v_pl_axis par_pl)
        par_pntfd      (vlax-curve-getfirstderiv v_pl_axis par_pl)
        param_top      (distance-from-curve-by-param-to-curve v_pl_axis par_pl v_spl_top)
        param_bot      (distance-from-curve-by-param-to-curve v_pl_axis par_pl v_spl_bot)
        dist_l         (* delta_l_axis-length 1.0)
        par_l          (vlax-curve-getparamatdist v_l_axis dist_l)
        param_r_top    (distance-from-curve-by-param-to-curve v_l_axis par_l v_spl_r_top)
        param_kr_bot   (distance-from-curve-by-param-to-curve v_l_axis par_l v_spl_kr_bot)
        param_kr_bot   (/ param_kr_bot 10000.0)
        param_r_bot    (cond ((<= (abs param_kr_bot) 0.0001)
                              (if (minusp param_kr_bot)
                                -10000.0
                                10000.0))
                             (t (/ 1.0 param_kr_bot)))
        param_r_kt     (distance-from-curve-by-param-to-curve v_l_axis par_l v_spl_r_kt)
        param_r_kb     (distance-from-curve-by-param-to-curve v_l_axis par_l v_spl_r_kb)
        param_l_bok    (distance-from-curve-by-param-to-curve v_l_axis par_l v_spl_l_bok)
        param_alfa_bok (distance-from-curve-by-param-to-curve v_l_axis par_l v_spl_alfa_bok)
        param_alfa_bok (/ param_alfa_bok (/ 180. pi))
        pnt_1          (list 0.0 0.0 dist_pl))
  (setq lst (draw_sech_3
              pnt_1 param_top param_r_top param_bot param_r_bot param_l_bok param_alfa_bok param_r_kt param_r_kb))
  (mapcar (function
            (lambda (el)                ; Перенос сечений в место назначения
              (vlax-invoke-method el 'move (vlax-3d-point pnt_1) (vlax-3d-point par_pnt))
              (vlax-invoke-method el 'rotate (vlax-3d-point par_pnt) (angle '(0.0 0.0 0.0) par_pntfd))
              (vlax-invoke-method
                el
                'rotate3d
                (vlax-3d-point par_pnt)
                (vlax-3d-point
                  (polar par_pnt (+ (/ pi 2) (angle '(0.0 0.0 0.0) par_pntfd)) (distance '(0.0 0.0 0.0) par_pntfd)))
                (/ pi 2))))
          lst)
  (setq area_lst   (cons (list dist_pl (vlax-get-property (nth 0 lst) 'area)) area_lst)
        length_lst (cons (list dist_pl (vlax-get-property (nth 0 lst) 'length)) length_lst))
  (smesitel_vla_put_lst)
  (err-handle ""))

