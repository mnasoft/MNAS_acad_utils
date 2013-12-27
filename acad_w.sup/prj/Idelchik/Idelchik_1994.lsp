;;;Ñèììåòğè÷íûé òğîéíèê

(defun Idl-7-29-2 (k w_b w_c)
  (+ 1.0 (* k (/ (* w_b w_b) (* w_c w_c))))
)




(defun Idl-6-1-1-A1 (delta_gradus)
  (cond
    ((and (<= delta_gradus 70.0))
     (* 0.9 (sin (/ delta_gradus (/ 180. pi))))
    )
    
    ((and (<= 70.0 delta_gradus) (<= delta_gradus 90.0))
     (+
       (* 0.9 (sin (/ delta_gradus (/ 180. pi))))
       (* (- 1.0 (* 0.9 (sin (/ delta_gradus (/ 180. pi)))))
	  (/ (- delta_gradus 70.0)(- 90.0 70.0) )
       )
     )
    )
    
    ((and (<= 90.0 delta_gradus) (<= delta_gradus 100.0))
     (+
       1.0
       (* (- (+ 0.7 (* 0.35 (/ delta_gradus 90.0)))1.0 )
	  (/ (- delta_gradus 90.0)(- 100.0 90.0) )
       )
     )
    )
    
    
    ((and (<= 100.0 delta_gradus) (<= delta_gradus 180.0))
     (+ 0.7 (* 0.35 (/ delta_gradus 90.0)))
    )
  )
)

(defun Idl-6-1-1-B1 (R0_D0)
  (cond
    ((and (<= 0.5 R0_D0) (<= R0_D0 1.0))
     (* 0.21 (expt R0_D0 -2.5))
    )
    ((and (<= 1.0 R0_D0) (<= R0_D0 100.0))
     (* 0.21 (expt R0_D0 -0.5))
    )
  )
)



(defun Idl-6-1-1-C1 (a0_b0)
  (cond
    ((and (<= a0_b0 4.0 ))
     (+ 0.85 (/ 0.125 a0_b0))
    )
    ((and (<= 4.0 a0_b0))
     (- 1.115 (/ 0.84 a0_b0 ))
    )
  )
)

(defun lg (x)
  (/(log x)(log 10.0))
)


(defun Idl-2-6-lambda (delta)
  (/ 1.0 (* 2.0 2.0 (lg (/ 3.7 delta))(lg (/ 3.7 delta))))
)

(defun Idl-2-5_dzeta (l D0 mikro)
  (* (/ l D0) (Idl-2-6-lambda (/ mikro D0)))
)
     
;; (Idl-2-5_dzeta 0.4 0.050 0.0025)

(defun Idl-6-1-1-dzeta_mu(delta_gradus R0_D0 a0_b0)
  (*
    (Idl-6-1-1-A1 delta_gradus)
    (Idl-6-1-1-B1 R0_D0)
    (Idl-6-1-1-C1 a0_b0)
  )
)

(defun Idl-6-1-1-dzeta (delta_gradus ; 
			   R0 ; [ì]
			   D0 ; [ì]
			   a0 ; [ì]
			   b0 ; [ì]
			   mikro_hight ; [ì] 0.02*0.001
)
  (+ (Idl-6-1-1-dzeta_mu delta_gradus (/ R0 D0) (/ a0 b0))
     (*	0.0175
	delta_gradus
	(Idl-2-6-lambda
	  (/ mikro_hight D0)
	)
	(/ R0 D0)
     )
  )
)

(defun d_otn_pred(Re)
  (* 17.85 (expt Re -0.875))
)

(defun Idl-5-23-1-dzeta	(D1 D0 l mikro / alfa_r)
  (setq
    alfa_r (* 2.0 (atan (/ (- D1 D0) 2.0 l)))
    n0	   (/ (* D0 D0) (* D1 D1))
    dzeta  (*
	     (+
	       (* n0 n0 n0 n0 -0.0125)
	       (* n0 n0 n0 0.0224)
	       (* n0 n0 -0.00723)
	       (* n0 0.00444)
	       -0.00745
	     )
	     (+ (* alfa_r alfa_r alfa_r) (* alfa_r alfa_r pi -2.0) (* alfa_r -10.0))
	   )
  )
  (+ dzeta (idl-5-6-dzeta-tr d1 d0 l mikro))
)

;(+ dzeta (idl-5-6-dzeta-tr d1 d0 l mikro))

(defun idl-5-6-dzeta-tr(d1 d0 l mikro)
  (setq
    alfa_r (* 2.0 (atan (/ (- d1 d0) 2.0 l)))
    n	   (/ (* d1 d1) (* d0 d0))
    delta  (/ mikro d1)
    lam    (idl-2-6-lambda delta)
  )
  (/ (* lam (- 1.0 (/ 1.0 (* n n)))  ) 8.0 (sin (* 0.5 alfa_r)))
)

(defun tg (x)
  (/ (sin x)( cos x))
)

(defun idl-5-5-dzeta( d1 d0 l mikro)
  (+
    (idl-5-5-dzeta-rash d1 d0 l)
    (idl-5-6-dzeta-tr d1 d0 l mikro)
   )
)

;(idl-5-5-dzeta (* 0.001 79) (* 0.001 49.) (* 0.001 60.) (* 0.001 0.02))
  
;(idl-5-5-dzeta-rash (* 0.001 79) (* 0.001 49.4) (* 0.001 60.))

(defun idl-5-5-dzeta-rash(d1 d0 l / alfa_r n)
  (setq
    alfa_r (* 2.0 (atan (/ (- d1 d0) 2.0 l)))
    n	   (/ (* d1 d1) (* d0 d0))
  )
  (* 3.2
     1.0
     (expt (tg (* alfa_r 0.5)) 1.25)
     (expt (- 1.0 (/ 1.0 n)) 2.0)
  )
)

;(idl-5-5-dzeta-rash (* 0.001 79) (* 0.001 49.4) (* 0.001 60.))

(defun idl-5-5-kd_piramid(d1 d0 l / alfa_r alfa)
  (setq
    alfa_r (* 2.0 (atan (/ (- d1 d0) 2.0 l)))
    alfa (* alfa_r (/ 180. pi))
  )
  (cond
    ((and (<= 4.0 alfa)(<=  alfa 12.0))
     (+ 0.66 (* 0.12 alfa))
     )
    ((and (<= 12.0 alfa)(<=  alfa 30.0))
     (- 3.3 (* 0.03 alfa))
     )
  )
)

(Idl-6-1-1-dzeta 45.0 0.250 0.0494 0.0494 0.0494 (* 0.001 0.02))


; (Idl-6-1-1-dzeta 90.0 0.0715 0.079 0.079 0.079 (* 0.02 0.001)) 0.283285
;(idl-5-6-dzeta-tr 0.079 0.049 0.060 0.00002)
;(Idl-5-23-1-dzeta (* 0.001 (- 83.0 4)) (* 0.001 (- 53.0 4))  (* 0.001 60.))
;(IDL-6-1-1-DZETA_MU 90.0 (/ 0.053 (- 0.053 0.0018 0.0018)) 1.0)
;(Idl-2-6-lambda (/ (* 0.001 0.02) 0.0494))
;(Idl-2-6-lambda (/ (* 0.001 0.02) 0.079))
;(Idl-6-1-1-dzeta 90.0 0.053 0.0494 0.0494 0.0494 (* 0.001 0.02))
;(Idl-6-1-1-dzeta 45.0 0.250 0.0494 0.0494 0.0494 (* 0.001 0.02))
;(Idl-6-1-1-dzeta 180.0 0.250 0.0494 0.0494 0.0494 (* 0.001 0.02))
;(mapcar 'Idl-6-1-1-B1 (list 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.4 1.6 1.8 2.0 3.0 4.0 5.0 6.0 8.0 10. 20. 30.))
;(mapcar 'Idl-6-1-1-A1 (list 0.0 10.0 20.0 30.0 40.0 50.0 60.0 70.0 80.0 90.0 95.0  100.0 110.0 120.0 130.0 140.0 150.0 160.0 170.0 180.0))
;(mapcar 'Idl-6-1-1-C1 (list 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.4 1.6 1.8 2.0 3.0 4.0 5.0 6.0 8.0 10.))
;(0.5 0.6     0.7     0.8     0.9      1.0   1.1      1.2      1.4      1.6      1.8      2.0    3.0      4.0     5.0   6.0   8.0   10.)
;(1.1 1.05833 1.02857 1.00625 0.988889 0.975 0.963636 0.954167 0.939286 0.928125 0.919444 0.9125 0.891667 0.88125 0.947 0.975 1.01 1.031)

;|«Visual LISP© Format Options»
(105 2 15 2 nil "end of" 90 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
