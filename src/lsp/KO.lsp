(princ "\nЗагружаю KO.LSP")

;;;;;;("ptt" "Функция по проецированию на конус" "not defined")
(defun c:ptt ()
  (setq p1 (getpoint "P1 : "))
  (setq p2 (getpoint p1 "P2 : "))
  (setq d1 (distance p1 p2))
  (setq p3 (getpoint "P3 : "))
  (setq p4 (getpoint p3 "P4 : "))
  (setq d2 (distance p3 p4))
  (setq p5 (getpoint "P5 : "))
  (setq p6 (getpoint p5 "P6 : "))
  (while (setq p7 (getpoint "P7 : "))
    (entmake (list (cons 0 "POINT") (cons 10 p7)))
    (setq
      p8
       (inters p1
	       p2
	       p7
	       (polar p7 (+ (angle p1 p2) (/ pi 2)) d1)
	       nil
       )
    )
    (setq p9 (inters p7 p8 p5 p6 nil))
    (setq r (distance p8 p9))
    (entmake (list (cons 0 "POINT") (cons 10 p9)))
    (setq
      p10
       (inters p3
	       p4
	       p7
	       (polar p7 (+ (angle p3 p3) (/ pi 2)) d2)
	       nil
       )
    )
    (entmake (list (cons 0 "POINT") (cons 10 p10)))
    (setq a (distance p7 p10))
    (if
      (>= r a)
       (progn
	 (setq p11 (polar p8 (angle p8 p9) (sqrt (- (* r r) (* a a)))))
	 (entmake (list (cons 0 "POINT") (cons 10 p11)))
       )
       (print "Point outside cone!")
    )
  )
)

(princ "\t...загружен.\n")
;|«Visual LISP© Format Options»
(72 2 5 2 nil "end of" 60 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
