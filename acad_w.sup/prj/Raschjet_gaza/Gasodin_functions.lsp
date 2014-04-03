(defun p_kr/p1 (k)
  (expt
    (/ 2.0
       (+ k 1.0)
    )
    (/ k (- k 1.0))
  )
)