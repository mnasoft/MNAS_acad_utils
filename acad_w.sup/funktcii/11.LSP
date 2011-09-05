(defun set_SED (r s e d / e_oct e_off o_oct r_big r_small s_oct s_off tmp_o_oct)
  (setq
    r_big     (/ r 256)
    r_small   (- r (* r_big 256))
    s_oct     (cicle_range (/ (+ s (* d 360)) 45) 0 8)
    e_oct     (cicle_range (/ (+ e (* d -360)) 45) 0 8)
    s_off     (fix (* (cicle_range (* d (- s (* s_oct 45))) 0 45) (/ 256. 45.)))
    e_off     (fix (* (cicle_range (* d (- e (* e_oct 45))) 0 45) (/ 256. 45.)))
    o_oct     (cicle_range (* d (- e_oct s_oct) ) 0 8)
  )
  (princ "11,(")
  (princ s_off)
  (princ ",")
  (princ e_off)
  (princ ",")
  (princ r_big)
  (princ ",")
  (princ r_small)
  (princ ",")
  (if (= d -1)
    (progn (princ "-0"))
    (progn (princ "+0"))
  )
  (princ s_oct)
  (princ o_oct)
  (princ "),")
  (princ)
)


(defun cicle_range (value base delta / n rez test)
  (setq
    n	 (/ (- value base) delta)
    rez	 (- value (* n delta))
    test (/ (* (- rez base) delta) (abs delta))
  )
  (if (< test 0)
    (setq rez (+ rez delta))
  )
  rez
)
;(set_SED 10 200 0 1)

;;;(set_SED 10 200 0 1)		11,(113,0,0,10,+044),
;;;(set_SED 10 200 315 1)	11,(113,0,0,10,+043),
;;;(set_SED 10 200 210 1)	11,(113,170,0,10,+041),
;;;(set_SED 10 200 190 1)	11,(113,56,0,10,+041),
;;;(set_SED 10 200 220 1)	11,(113,227,0,10,+041),
;;;(set_SED 10 315 0 1)		11,(0,0,0,10,+071),

;;;(set_SED 10 200 0 -1)
;;;11,(142,0,0,10,-055),

;;;(set_SED 10 200 75 -1)
;;;11,(142,85,0,10,-054),

;|«Visual LISP© Format Options»
(105 2 15 2 nil "end of" 90 15 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
