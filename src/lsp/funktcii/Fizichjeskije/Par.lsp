;;;
;;;���������
(setq t-r '(
	    (0.01 2501.0)
	    (10.0 2477.4)
	    (20.0 2453.8)
	    (30.0 2430.2)
	    (40.0 2406.5)
	    (50.0 2382.5)
	    (60.0 2358.4)
	    (70.0 2333.8)
	    (80.0 2308.9)
	    (90.0 2283.4)
	    (100.0 2257.2)
	    (110.0 2230.5)
	    (120.0 2202.9)
	    (130.0 2174.4)
	    (140.0 2144.9)
	    (150.0 2114.1)
	    (160.0 2062.2)
	    (170.0 2048.0)
	    (180.0 2014.0)
	    (190.0 1977.4)
	    (200.0 1939.0)
	    (210.0 1898.6)
	    (220.0 1856.2)
	    (230.0 1811.4)
	    (240.0 1764.0)
	    (250.0 1713.7)
	    (260.0 1660.2)
	    (270.0 1602.9)
	    (280.0 1541.6)
	    (290.0 1475.1)
	    (300.0 1403.0)
	    (310.0 1323.9)
	    (320.0 1236.2)
	    (330.0 1138.0)
	    (340.0 1025.5)
	    (350.0 893.2)
	    (360.0 722.6)
	    (370.0 439.5)
	    (374.12 0.0)
	   )
)

(setq t-r '(
	    (0.01 2501.0)
	    
	    (50.0 2382.5)
	    
	    (100.0 2257.2)
	    
	    (150.0 2114.1)
	    
	    (200.0 1939.0)
	    
	    (250.0 1713.7)
	    
	    (300.0 1403.0)
	    
	    (350.0 893.2)
	    
	    (374.12 0.0)
	   )
)


(setq t-r '(
;;;	    (0.01 2501.0)
;;;	    (10.0 2477.4)
;;;	    (20.0 2453.8)
;;;	    (30.0 2430.2)
;;;	    (40.0 2406.5)
;;;	    (50.0 2382.5)
;;;	    (60.0 2358.4)
;;;	    (70.0 2333.8)
;;;	    (80.0 2308.9)
;;;	    (90.0 2283.4)
	    (100.0 2257.2)
	    (110.0 2230.5)
	    (120.0 2202.9)
	    (130.0 2174.4)
	    (140.0 2144.9)
	    (150.0 2114.1)
	    (160.0 2062.2)
	    (170.0 2048.0)
	    (180.0 2014.0)
	    (190.0 1977.4)
	    (200.0 1939.0)
	    (210.0 1898.6)
	    (220.0 1856.2)
	    (230.0 1811.4)
	    (240.0 1764.0)
	    (250.0 1713.7)
	    (260.0 1660.2)
	    (270.0 1602.9)
	    (280.0 1541.6)
	    (290.0 1475.1)
	    (300.0 1403.0)
;;;	    (310.0 1323.9)
;;;	    (320.0 1236.2)
;;;	    (330.0 1138.0)
;;;	    (340.0 1025.5)
;;;	    (350.0 893.2)
;;;	    (360.0 722.6)
;;;	    (370.0 439.5)
;;;	    (374.12 0.0)
	   )
)

(osr_func
  '(XX YY)
  '((XX XX XX XX XX) (XX XX XX XX)(XX XX XX) (XX XX) (XX) (1.0) (YY))
  t-r
  'ssaa
)
(mapcar
  (function
    (lambda (el)
      (list
	(car el)
	(ssaa
	  (car el)
	  
	)
	(cadr el)
      )
    )
  )
  t-r
)

'((100.0 2257.57 2257.2)
   (110.0 2230.99 2230.5)
   (120.0 2202.6 2202.9)
   (130.0 2172.88 2174.4)
   (140.0 2142.13 2144.9)
   (150.0 2110.54 2114.1)
   (160.0 2078.12 2062.2)
   (170.0 2044.8 2048.0)
   (180.0 2010.43 2014.0)
   (190.0 1974.76 1977.4)
   (200.0 1937.48 1939.0)
   (210.0 1898.26 1898.6)
   (220.0 1856.74 1856.2)
   (230.0 1812.54 1811.4)
   (240.0 1765.3 1764.0)
   (250.0 1714.71 1713.7)
   (260.0 1660.47 1660.2)
   (270.0 1602.38 1602.9)
   (280.0 1540.3 1541.6)
   (290.0 1474.18 1475.1)
   (300.0 1404.12 1403.0)
 )
((XX) (+ (* 1.4558e-009 XX XX XX XX XX)
	 (* -1.55177e-006 XX XX XX XX)
	 (* 0.000599702 XX XX XX)
	 (* -0.113563 XX XX)
	 (* 7.65256 XX)
	 (* 2168.87 1.0)
      )
)
;|�Visual LISP� Format Options�
(95 2 5 2 nil "end of" 85 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;