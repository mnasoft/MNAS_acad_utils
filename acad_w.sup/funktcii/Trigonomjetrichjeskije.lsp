(defun asin (A) (atan (/ A (sqrt (- 1.0 (* A A))))))

(defun acos (A) (atan (/ (sqrt (- 1.0 (* A A))) A)))
