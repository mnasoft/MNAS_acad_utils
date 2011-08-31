(osr_func
  '(x y температура)
  '((x x x) (x x) (x) (y y y) (y y) (y) (1.0) (температура))
  '(
    (-2.0 -2.0 40.0)
    (-1.0 -2.0 45.0)
    (0.0 -2.0 50.0)
    (1.0 -2.0 45.0)
    (2.0 -2.0 30.)

    (-2.0 -1.0 40.0)
    (-1.0 -1.0 45.0)
    (0.0 -1.0 50.0)
    (1.0 -1.0 45.0)
    (2.0 -1.0 30.)

    (-2.0 0.0 40.0)
    (-1.0 0.0 45.0)
    (0.0 0.0 50.0)
    (1.0 0.0 45.0)
    (2.0 0.0 30.)

    (-2.0 0.0 40.0)
    (-1.0 0.0 45.0)
    (0.0 0.0 50.0)
    (1.0 0.0 45.0)
    (2.0 0.0 30.)

    (-2.0 1.0 40.0)
    (-1.0 1.0 45.0)
    (0.0 1.0 50.0)
    (1.0 1.0 45.0)
    (2.0 1.0 30.)

    (-2.0 2.0 40.0)
    (-1.0 2.0 45.0)
    (0.0 2.0 50.0)
    (1.0 2.0 45.0)
    (2.0 2.0 30.)


   )
  'апроксимация
)

(defun pnt_equal_dist (x_min x_max i / rez)
  (setq	n	i
	delta_x	(- x_max x_min)
  )
  (while (>= i 0)
    (setq zn  (+ x_min
		 (* (/ delta_x n) i)
	      )
	  i   (1- i)
	  rez (cons zn rez)
    )
  )
  rez
)


(defun x_line (y_min y_max i x_const / y x_y)
  (setq	y     (pnt_equal_dist y_min y_max i)
	x_y   (mapcar
		(function
		  (lambda (el)
		    (list x_const el)
		  )
		)
		y
	      )
	x_y_t (mapcar
		(function
		  (lambda (el)
		    (apply (function апроксимация) el)
		  )
		)
		x_y
	      )
  )
)