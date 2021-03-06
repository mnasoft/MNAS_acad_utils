T-1 P-2 CP

(osr_func
  '(X1 X2 YY)
  '((X1) (X2) (X1 X1) (X1 X1 X1) (X2 X2) (X1 X2) (X1 X1 X2)  (1.0) (YY))
  '((50.0 0.0 0.5481)
    (100.0 0.0 0.5853)
    (150.0 0.0 0.6273)
    (200.0 0.0 0.6700)
    (250.0 0.0 0.7140)
    (300.0 0.0 0.7587)
    (400.0 0.0 0.8435)
    (500.0 0.0 0.9216)
    (600.0 0.0 0.9926)
    (700.0 0.0 1.057)
    
    (50.0 25.0 0.575)
    (100.0 25.0 0.604)
    (150.0 25.0 0.640) 
    (200.0 25.0 0.680)
    (250.0 25.0 0.722)
    (300.0 25.0 0.765)
    (400.0 25.0 0.848)
    (500.0 25.0 0.925)
    (600.0 25.0 0.996)
    (700.0 25.0 1.059)

    (50.0 50.0 0.613)
    (100.0 50.0 0.624)
    (150.0 50.0 0.655)
    (200.0 50.0 0.690)
    (250.0 50.0 0.730)
    (300.0 50.0 0.771)
    (400.0 50.0 0.852)
    (500.0 50.0 0.928)
    (600.0 50.0 0.998)
    (700.0 50.0 1.060)
    
   )
  'CP_��4
)




(mapcar	(function
	  (lambda (xxx)
	    (- 1
	       (/
		 (CP_��4 (car xxx) (cadr xxx))
		 (caddr xxx)
	       )
	    )
	  )
	)
	'((50.0 0.0 0.5481)
	  (100.0 0.0 0.5853)
	  (150.0 0.0 0.6273)
	  (200.0 0.0 0.6700)
	  (250.0 0.0 0.7140)
	  (300.0 0.0 0.7587)
	  (400.0 0.0 0.8435)
	  (500.0 0.0 0.9216)
	  (600.0 0.0 0.9926)
	  (700.0 0.0 1.057)

	  (50.0 25.0 0.575)
	  (100.0 25.0 0.604)
	  (150.0 25.0 0.640)
	  (200.0 25.0 0.680)
	  (250.0 25.0 0.722)
	  (300.0 25.0 0.765)
	  (400.0 25.0 0.848)
	  (500.0 25.0 0.925)
	  (600.0 25.0 0.996)
	  (700.0 25.0 1.059)

	  (50.0 50.0 0.613)
	  (100.0 50.0 0.624)
	  (150.0 50.0 0.655)
	  (200.0 50.0 0.690)
	  (250.0 50.0 0.730)
	  (300.0 50.0 0.771)
	  (400.0 50.0 0.852)
	  (500.0 50.0 0.928)
	  (600.0 50.0 0.998)
	  (700.0 50.0 1.060)
	 )
)

((0.547193 50.0 0.0 0.5481)
  (0.589312 100.0 0.0 0.5853)
  (0.631096 150.0 0.0 0.6273)
  (0.672545 200.0 0.0 0.67)
  (0.713658 250.0 0.0 0.714)
  (0.754437 300.0 0.0 0.7587)
  (0.834988 400.0 0.0 0.8435)
  (0.9142 500.0 0.0 0.9216)
  (0.992071 600.0 0.0 0.9926)
  (1.0686 700.0 0.0 1.057)
  (0.566681 50.0 25.0 0.575)
  (0.607 100.0 25.0 0.604)
  (0.646984 150.0 25.0 0.64)
  (0.686633 200.0 25.0 0.68)
  (0.725947 250.0 25.0 0.722)
  (0.764926 300.0 25.0 0.765)
  (0.841879 400.0 25.0 0.848)
  (0.917491 500.0 25.0 0.925)
  (0.991763 600.0 25.0 0.996)
  (1.06469 700.0 25.0 1.059)
  (0.587278 50.0 50.0 0.613)
  (0.625798 100.0 50.0 0.624)
  (0.663983 150.0 50.0 0.655)
  (0.701832 200.0 50.0 0.69)
  (0.739347 250.0 50.0 0.73)
  (0.776526 300.0 50.0 0.771)
  (0.84988 400.0 50.0 0.852)
  (0.921893 500.0 50.0 0.928)
  (0.992565 600.0 50.0 0.998)
  (1.0619 700.0 50.0 1.06)
)
;|�Visual LISP� Format Options�
(72 2 5 2 nil "end of" 60 15 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
