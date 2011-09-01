;;	h_div (ff a b delta)	- Метод половинного деления
;;	ff	- функция одной переменной,
;;		нулевое значение котрой отыскивается на отрезке [a;b];
;;	а	- левая граница отрезка поиска;
;;	b	- правая граница отрезка поиска;
;;	delta	- точность с которой отыскивается корень.
;;
;;	(defun x3 (x)
;;	  (+ (* 3.0 x x x) (* 2.0 x x) 1.0)
;;	)
;;	(h_div  x3 -100.0 100.0 0.001)

(defun h_div (ff a b delta / FA FB FX X)
  (setq
    fa (apply (function ff) (list a))
    fb (apply (function ff) (list b))
  )
  (while (> (- b a) delta)
    (setq
      x	 (* 0.5 (+ a b))
      fx (apply 'ff (list x))
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
(100 2 5 2 nil "end of" 60 30 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
