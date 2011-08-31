;;	пловинное_деление (ff a b delta ll_par no) - Метод половинного деления
;;	ff	- функция нескольких переменных,
;;		нулевое значение котрой отыскивается на отрезке [a b];
;;	а	- левая граница отрезка поиска;
;;	b	- правая граница отрезка поиска;
;;	delta	- точность с которой отыскивается корень;
;;	ll_par	- список аргументов функции;
;;	no	- номер аргумента в списке, значение которого отыскивается
;;		на отрезке [a b], которое должно обращать значение функции ff в ноль.
;;Например:
;;	(defun x3_y (x y)
;;	  (+ (* 3.0 x x x) (* 2.0 x x) 1.0 y)
;;	)
;;	(пловинное_деление x3_y -100. 100.0 0.005 '(0.6666 t) 2)

(defun заменить_эл_списка (эл no ll / i)
  (setq i 0)
  (mapcar
    (function
      (lambda (el)
	(setq i (1+ i))
	(cond
	  ((= i no) эл)
	  ((/= i no) el)
	)
      )
    )
    ll
  )
)

(defun пловинное_деление (ff a b delta ll_par no / FA FB FX X)
  (setq
    fa (apply (function ff) (заменить_эл_списка a no ll_par))
    fb (apply (function ff) (заменить_эл_списка b no ll_par))
  )
  (if (> (* fa fb) 0)
    (progn
      (princ "\nПри вызове функции \n(пловинное_деление (")(princ " ")
      (princ ff)(princ " ")
      (princ a)
      (princ " ")
      (princ b)(princ " ")
      (princ delta)(princ " ")
      (princ ll_par)(princ " ")
      (princ no)(princ " ")
      (princ "))\nнет корней.")
      (exit)
    )
  )
  (while (> (abs(- b a)) delta)
    (setq
      x	 (* 0.5 (+ a b))
      fx (apply (function ff) (заменить_эл_списка x no ll_par))
    )
    (cond
      ((< (* fx fa) 0)
       (setq fb	fx
	     b	x
       )
      )
      ((> (* fx fa) 0)
       (setq fa	fx
	     a	x
       )
      )
      ((= 0.0 (* fx fa))
       (setq a	x
	     fa	fx
	     b	x
	     fb	fx
       )
      )
    )
  )
  (* 0.5 (+ a b))
)
;|«Visual LISP© Format Options»
(90 2 5 2 nil "end of" 60 30 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
