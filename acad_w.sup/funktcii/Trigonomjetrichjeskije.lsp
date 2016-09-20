(defun asin (a) (atan (/ a (sqrt (- 1.0 (* a a))))))

(defun acos (a) (atan (/ (sqrt (- 1.0 (* a a))) a)))
