(defun ins_lit(p_ins st_1 st_2)
	(command-s "_insert" "litera" "non" p_ins "1" "1" "0" st_1 st_2)
	(princ)
)
;;;;;;("ins_lit" "not defined" "Большой шрифт")
(defun c:ins_lit (/ p0 st i)
  (setq
    p0 (getpoint "\nВведите начальную точку:")
    st (getstring "\nВведите символ:")
  )

  (setq
    i 0
    j 65
  )

  (repeat 26
    (ins_lit
      (polar p0 0 (* 15 i))
      (strcat
	(itoa (ascii st))
	"+"
	(chr (+ i j))
      )
      (strcat
	st
	(chr (+ i j))
      )
    )
    (setq i (1+ i))
  )
  (setq
    i 0
    j 97
  )

  (repeat 26
    (ins_lit
      (polar (polar p0 0 (* 15 i)) (/ pi -2.0) 15)
      (strcat
	(itoa (ascii st))
	"+"
	(chr (+ i j))
      )
      (strcat
	st
	(chr (+ i j))
      )
    )
    (setq i (1+ i))
  )
)