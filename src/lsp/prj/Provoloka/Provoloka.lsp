(prompt "\nВыберите базовую кривую:")

(setq vobj
       (vlax-ename->vla-object
	 (car
	   (entsel)
	 )
       )
)
(setq
  n(GETINT "Введите количество оборотов проволоки:")
  d (getdist "Введите диаметр проволоки:")
  r (/ d 2.0)
  r_mid (* 1.25 r)
)

(setq
  start_param	(vlax-curve-getStartParam vobj)
  start_dist	(vlax-curve-getDistAtParam vobj start_param)
  end_param	(vlax-curve-getEndParam vobj)
  end_dist	(vlax-curve-getDistAtParam vobj end_param)
)

(setq
  i  12
  ni (* n i)
  j 0
)

(while (<= j ni)
  (setq
    dist (+ start_dist(/ (* (- end_dist start_dist) j) ni))
    param (vlax-curve-getParamAtDist vobj dist)
    p0 (vlax-curve-getPointAtParam vobj param)
    SecondDeriv (vlax-curve-getSecondDeriv vobj param)
    FirstDeriv (vlax-curve-getFirstDeriv vobj param)
  )
  (setq j(1+ j))
)


;|«Visual LISP© Format Options»
(105 2 15 2 nil "end of" 90 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
