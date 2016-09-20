(setq
  matr_rotate_fi
   (list
     matr_name
     3
     3
     (list
       '(0 cos fi)     '(1 sin fi)     '(2 . 0.0)
       '(3 . (- 0 (sin fi)))	       '(4 cos fi)     '(5 . 0.0)
       '(6 . 0.0)      '(7 . 0.0)      '(8 . 1.0)
      )
   )
)

(setq
  matr_move_ab
   (list
     matr_name
     3
     3
     (list
       '(0 . 1.0) '(1 . 0.0) '(2 . 0.0)	'(3 . 0.0) '(4 . 1.0) '(5 . 0.0)
       '(6 . a)	'(7 . b) '(8 . 1.0))
   )
)

(setq
  matr_scale_xy
   (list
     matr_name
     3
     3
     (list
       '(0 . x)	'(1 . 0.0) '(2 . 0.0) '(3 . 0.0) '(4 . y) '(5 . 0.0)
       '(6 . 0.0) '(7 . 0.0) '(8 . 1.0))
   )
)
;|«Visual LISP© Format Options»
(72 2 5 2 nil "end of" 60 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
