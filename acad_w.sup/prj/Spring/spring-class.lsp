(defun get(key)
  (setq tmp (atof(get_tile key)))
  (set_tile key (rtos tmp))
  tmp
)

(defun put (key val)
  (atof(set_tile key (rtos val)))
)

(defun D()
  (put "D" (-(get "D1") (get "d")))
)

(defun D1()
  (put "D1" (+(get "d") (get "D")))
)

(defun _i ()
  (put "i" (/ (get "D") (get "d")))
)

(defun _i1 ()
  (put "i1" (/ (get "L0") (get "D")))
)

(defun L0 ()
  (put "L0" (+ (* (get "n" ) (get "t")) (* 1.5 (get "d"))))
)

(defun L1 ()
  (put "L1" (- (get "L0") (get "S1")))
)

(defun L2 ()
  (put "L2" (- (get "L0") (get "S2")))
)

(defun L3 ()
  (put "L3" (- (get "L0") (get "S3")))
)

(defun L4 ()
  (put "L4" (* (+ (get "n") 1.5) (get "d")))
)

(defun S1()
  (put "S1" (- (get "L0")(get "L1")))
)

(defun S2()
  (put "S2" (- (get "L0")(get "L2")))
)

(defun S3()
  (put "S3" (- (get "L0")(get "L3")))
)

(defun L (/ D _t)
  (setq	D  (get "D")
	_t (get "t")
  )
  (put "L" (* (get "n1") (sqrt (+ (* pi pi D D) (* _t _t)))))
)

(defun _n ()
  (put "n" (- (get "n1") 2.0))
)

(defun _n1 ()
  (put "n1" (+ (get "n") 2.0))
)

(defun _t()
  (put "t" (/ (- (get "L0") (* 1.5 (get "d"))) (get "n")))
)

(defun _h ()
  (put "h" (- (get "S2") (get "S1")))
)

(defun K1 (/ i)
  (setq i (_i))
  (put "K1" (+ (/ (- (* 4.0 i) 1.0) (- (* 4.0 i) 4.0)) (/ 0.615 i)))
)

(defun K2(/ i)
  (setq i (_i))
  (put "K2" (+ 1.0 (/ 1.0 2.0 i) (/ -1.0 2.0 i i)))
)

(defun F1 (/ D_big d_sm )
  (setq
    d_sm (get "d")
    D_big (get "D")
  )
  (put "F1" (/ (* (get "G") d_sm d_sm d_sm d_sm (get "S1")) 8.0 D_big D_big D_big (get "n") (K2)))
)

(defun F2 (/ D_big d_sm )
  (setq
    d_sm (get "d")
    D_big (get "D")
  )
  (put "F2" (/ (* (get "G") d_sm d_sm d_sm d_sm (get "S2")) 8.0 D_big D_big D_big (get "n") (K2)))
)

(defun F3 (/ D_big d_sm )
  (setq
    d_sm (get "d")
    D_big (get "D")
  )
  (put "F3" (/ (* (get "G") d_sm d_sm d_sm d_sm (get "S3")) 8.0 D_big D_big D_big (get "n") (K2)))
)

(defun _tau1()
   (setq d_sm (get "d"))
   (put "tau1" (/ (* 2.55 (get "F1") (get "D") (get "K1")) (* d_sm d_sm d_sm)))
)

(defun _tau2()
   (setq d_sm (get "d"))
   (put "tau2" (/ (* 2.55 (get "F2") (get "D") (get "K1")) (* d_sm d_sm d_sm)))
)
(defun _tau3()
   (setq d_sm (get "d"))
   (put "tau3" (/ (* 2.55 (get "F3") (get "D") (get "K1")) (* d_sm d_sm d_sm)))
)

(defun C()
  (put "C" (/ (- (get "F2") (get "F1")) (get "h")))
)

(defun m (/ _d _n1)
  (setq
    _d	(get "d")
    _n1	(get "n1")
  )
  (put
    "m"
    (* 8.0e-6 pi _d _d 0.25 (get "L") (/ (- _n1 0.5) _n1))
  )
)

(defun err()
  (set_tile "error" (strcat (cadr(assoc $key setup_msg)) " = " $value))
)


(defun action_d	() (err) (_t) (L4) (D1) (D) (_i1) (L) (_i) (K2) (F1) (F2) (F3) (K1) (_tau1) (_tau2) (_tau3) (C) (m)
  (stp_lst)
)

(defun actionD () (err) (D1) (_i1) (L) (_i) (K2) (F1) (F2) (F3) (K1) (_tau1) (_tau2) (_tau3) (C) (m)
  (stp_lst)
  )

(defun actionD1	() (err) (D) (_i1) (L) (_i) (K2) (F1) (F2) (F3) (K1) (_tau1) (_tau2) (_tau3) (C) (m)
  (stp_lst)
  )

(defun action_n1 () (err) (_n) (L4) (L0) (_t) (_i1) (L) (L1) (L2) (L3) (S1) (S2) (S3) (_h) (F1) (F2) (F3) (_tau1) (_tau2) (_tau3) (C) (m)
  (stp_lst)
  )

(defun action_n () (err) (_n1) (L4) (L0) (_t) (_i1) (L) (L1) (L2) (L3) (S1) (S2) (S3) (_h) (F1) (F2) (F3) (_tau1) (_tau2) (_tau3) (C) (m)
  (stp_lst)
  )

(defun action_t () (err) (L) (L0) (_t) (_i1) (L) (L1) (L2) (L3) (S1) (S2) (S3) (_h) (F1) (F2) (F3) (_tau1) (_tau2) (_tau3) (C) (m)
  (stp_lst)
  )

(defun actionL0	() (err) (_t) (_i1) (L) (L1) (L2) (L3) (S1) (S2) (S3) (_h) (F1) (F2) (F3) (_tau1) (_tau2) (_tau3) (C) (m)
  (stp_lst)
  )

(defun actionS1	() (err) (L1) (_h) (F1) (_tau1) (C) (m)
  (stp_lst))

(defun actionL1	() (err) (S1) (_h) (F1) (_tau1) (C) (m)
  (stp_lst)
)


(defun actionS2	() (err) (L2) (_h) (F2) (_tau2) (C) (m)
  (stp_lst)
)

(defun actionL2	() (err) (S2) (_h) (F2) (_tau2) (C) (m)
  (stp_lst)
)

(defun actionS3	() (err) (L3) (F3) (_tau3)
  (stp_lst)
) 

(defun actionL3	() (err) (S3) (F3) (_tau3)
  (stp_lst)
)

(defun actionG () (err) (F1) (F2) (F3) (_tau1) (_tau2) (_tau3) (C) (m)
  (stp_lst)
)

;|«Visual LISP© Format Options»
(72 2 25 2 nil "end of" 60 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
