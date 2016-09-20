(defun A{fi}(fi)
 (/
   (*
     (- 1.0 fi)
     (sqrt 2.0)
   )
   (* fi (sqrt fi))
 )
)

(defun fi{A} (A / y{fi,A})
  (defun y{fi,A} (fi A) (- (A{fi} fi) A))
  (половинное_деление y{fi,A} (list t A) 1 0.01 0.99 0.0005)
)

(defun mu{fi} (fi)
  (sqrt
    (/
      (expt fi 3.0)
      (- 2.0 fi)
    )
  )
)


(defun mu{A} (A / fi)
  (setq    fi (fi{A} A)  )
  (mu{fi} fi)
)

(defun SMUA (S MU A)
  (-
    (* S S)
    (* MU MU A A)
  )
)


(defun S_mu_A (S mu A)
  (+
    mu
    (* S (sqrt (SMUA S MU A)))
    (* mu
       mu
       A
       A
       (log (/ (+ 1.0 (sqrt (SMUA 1.0 mu A)))
	       (+ S (sqrt (SMUA S MU A)))
	    )
       )
    )
    (* -1.0 (sqrt(SMUA 1.0 mu A)))
  )
)


(defun alfa{A} (A / mu S)
  (setq
    mu (mu{A} A)	
    S  (половинное_деление S_mu_A (list t mu A) 1 (+ 0.01(sqrt(* mu mu A A))) 0.99 0.0001)
    tg_al_2 (/ (* 2.0 mu A)
	       (sqrt (-(* (+ 1.0 S) (+ 1.0 S)) (* 4.0 mu mu A A)))
	    )
  )
  (rtd (* 2.0 1.0 (atan tg_al_2)))
)	
'(
tg_al_2
     (*
       (/ (* 2.0 mu A)
	  (- 1.0 (* S S) (* -2.0 mu mu A A (log S)))
       )
       (+ (sqrt(SMUA 1.0 mu A))
	  (sqrt(SMUA S mu A))
	  (* -1.0 mu A (- (acos (* mu A)) (acos (/ (* mu A) S))))
       )
     ))


(defun ch_by_no	(ll no x)
  (setq i 0)
  (mapcar
    (function
      (lambda (el / ll_x)
	(setq
	  i    (1+ i)
	  ll_x
	       (cond
		 ((= i no) x)
		 ((/= i no) el)
	       )
	)
	ll_x
      )
    )
    ll
  )
)

(defun половинное_деление(ff XX n a b delta / FA FB FX X)
  (setq
    fa (apply (function ff) (ch_by_no XX n a))
    fb (apply (function ff) (ch_by_no XX n b))
  )
  (while (> (- b a) delta)
    (setq
      x	 (* 0.5 (+ a b))
      fx (apply 'ff (ch_by_no XX n x))
    )
    (cond
      ((< (* fx fa) 0)
       (setq
	 fb fx
	 b  x
       )
      )
      ((> (* fx fa) 0)
       (setq
	 fa fx
	 a  x
       )
      )
      ((= 0.0 (* fx fa))
       (setq
	 a  x
	 fa fx
	 b  x
	 fb fx
       )
      )
    )
  )
  (* 0.5 (+ a b))
)
;|«Visual LISP© Format Options»
(72 2 5 2 nil "end of" 60 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
