;; Некоторые формулы из Справочника гидравлических сопротивлений Идельчика
;; относящиеся к истечению сжимаемой жидкости через сопло.

(setq
  Rmu 8.314
)

(defun f_ro (p1 t1 mu)
  (/ (* mu p1) (* t1 Rmu))
)


(defun f_G (F  ; Площадь сопла, м2
	    k  ; Коэффициент адиабаты
	    mu ; Молекулярная масса
	    P1 ; Давление перед соплом
	    P0 ; Давление за соплом
	    t1 ; 
	    / ro1 kv_sk	root b)
  (setq
    ro1	  (f_ro p1 t1 mu)
    b	  (max (/ p0 p1)
	       (expt (/ 2.0 (+ k 1.0)) (/ k (- k 1.0)))
	  )
    kv_sk
	  (- (expt b (/ 2.0 k))
	     (expt b (/ (+ k 1.0) k))
	  )
    root
	  (* (/ (* 2.0 k) (- k 1.0)) (* ro1 p1) kv_sk)
  )
  (* F (sqrt root))
)

(defun f_F (G k mu P1 P0 t1 / ro1 kv_sk root b)
  (setq
    ro1	  (f_ro p1 t1 mu)
    b	  (max (/ p0 p1)
	       (expt (/ 2.0 (+ k 1.0)) (/ k (- k 1.0)))
	  )
    kv_sk (- (expt b (/ 2.0 k))
	     (expt b (/ (+ k 1.0) k))
	  )
    root  (* (/ (* 2.0 k) (- k 1.0)) (* ro1 p1) kv_sk)
  )
  (/ G (sqrt root))
)

(defun f_P1 (G F k mu P0 t1 / a b x fa fb fx)
  (setq
    a P0
    b (* P0 1.8)
  )
  (setq
    fa (- G (f_G F k mu a P0 t1))
    fb (- G (f_G F k mu b P0 t1))
  )
  (while (> (abs(- b a)) 0.001 )
    (setq
      x	 (* 0.5 (+ a b))
      fx (- G (f_G F k mu x P0 t1))
    )
    (if	(> (* fa fx) 0.0)
      (setq a  x
	    fa fx
      )
      (setq b  x
	    fb fx
      )
    )
  )
  (* 0.5 (+ a b))
)

(setq
  k   1.4
  mu  0.029
  T1  288.0
  T2  288.0
  P3  101325.
  p2  (+ 101325. 2000.)
  p1  (+ P2 5000.)
  G_min 0.0555
  G_max 0.0585
)

	       ;(setq
	       ;  ro1 (f_ro p1 t1 mu)
	       ;  ro2 (f_ro p2 t2 mu)
	       ;)

	       ;(f_G 0.000792708 1.4  0.029 p2 p3 288.)
	       ;(f_F 0.0555 1.4  0.029 p1 p2 288.)
	       ;(f_G 0.000496986 1.4  0.029 p1 p2 288.)
	       ;(f_P1 0.0555 0.000496986 1.4 0.029 101325.0 288.0)
(setq
  f_min (f_F G_min 1.4 0.029 p2 p3 288.);;Площадь завихрителя с минимальным расходом при температуре 15С и перепаде давления 200 мм вод.ст.
  f_max (f_F G_max 1.4 0.029 p2 p3 288.);;Площадь завихрителя с максимальным расходом при температуре 15С и перепаде давления 200 мм вод.ст.
)

(setq
  f_sopl (f_F G_min 1.4 0.029 p1 p2 288.);;Площадь в сопле мерного участка
  f_sopl (f_otv 0.025);;Принимаем диаметр сопла 25мм
)

(defun culc_dp (t_res ;Температура воздуха в ресивере.
		t_sopla ;Температура воздуха перед соплом
		f_sopl ;Площадь сопла
		G_min ; Минимальная эквивалентная площадь завихрителя
		G_max ; Минимальная эквивалентная площадь завихрителя
		pa ;Атмосферное давление
		/
		f_min
		f_max
		P3 P2
		G_min_t_res
		G_max_t_res
		dp_min
		dp_max
)
  (setq
    f_min (f_F G_min 1.4 0.029 (+ 2000.0 101325.) 101325. 288.)    
    f_max (f_F G_max 1.4 0.029 (+ 2000.0 101325.) 101325. 288.)
  )

  (setq
    P3 Pa
    P2 (+ Pa 2000.)
  )
  (setq
    G_min_t_res	(f_G f_min k mu P2 P3 t_res)
    G_max_t_res	(f_G f_max k mu P2 P3 t_res)
    dp_min	(- (f_P1 G_min_t_res f_sopl 1.4 0.029 p2 t_sopla) p2)
    dp_max	(- (f_P1 G_max_t_res f_sopl 1.4 0.029 p2 t_sopla) p2)
  )

  (princ "dp_min=")
  (princ dp_min)
  (princ "Па\t")
  (princ "dp_max=")
  (princ dp_max)
  (princ "Па\n")
  (princ)
)

;(culc_dp t_res t_sopla f_sopl f_min f_max pa)
(culc_dp 288.0 288.0  (* pi 0.025 0.025 0.25) 0.0555 0.0585 101325.0)
(culc_dp 288.0 293.0  (* pi 0.025 0.025 0.25) 0.0555 0.0585 101325.0)
(culc_dp 293.0 293.0  (* pi 0.025 0.025 0.25) 0.0555 0.0585 101325.0)

dp_min=5125.74Па	dp_max=5697.1Па
dp_min=5215.05Па	dp_max=5796.41Па
dp_min=5125.74Па	dp_max=5697.1Па