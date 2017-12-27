;;; Программа расчета угла выхода струй воздуха для топливо-воздушной форсунки.
;;;


(setq
  beta (dtr 11.5)					    ; Угол раскрытия воздушного канала.
  alfa (dtr 45.)					    ; Угол потока в завихрителе.
)

(setq
  sin_alfa (sin alfa)
  sin_beta (sin beta)
  cos_beta (cos beta)
)


(setq
  sk   21.						    ; Выходная площадь воздушного канала.
  n*sn 45.						    ; Площадь поперечного сечения
  rb   11.8						    ; Радиус плеча закрутки пазов
  rm   6.9
)
(setq
  sk*rb/n*sn*rm*sin_alfa
   (/ (* sk rb sin_alfa) (* n*sn rm))
)

(setq gama
       (rtd
	 (atan
	   (/
	     (sqrt
	       (+ (* sin_beta sin_beta)
		  (* sk*rb/n*sn*rm*sin_alfa sk*rb/n*sn*rm*sin_alfa)
	       )
	     )
	     cos_beta
	   )
	 )
       )
)