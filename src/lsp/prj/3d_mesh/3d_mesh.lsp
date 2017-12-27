
(defun c:m3d  ()
  (setq	m 30
	n 30
	i 0)
  (command "3dmesh" m n)
  (while (< i m)
    (setq j 0)
    (while (< j n)
      (command (list (xi i) (yj j) (zij i j)))
      (setq j (1+ j)))
    (setq i (1+ i))))

(defun xi (i) i)

(defun yj (j) j)

(defun zij (i j) (/ (+ (* i i) (* j j)) 60.))


(defun make-3dmesh (ml m nl n sl) t)

;;;f;;; ("l_int" "Функция линейной интерполяции")
(defun l_int  (x x0 x1 y0 y1)
  (+ y0 (/ (* (- x x0) (- y1 y0)) (- x1 x0))))

(defun f_alfas	(v d sl)
  (cond	((or (= sl 1) (= sl 2)) 8.55e-6)
	((= sl 3) 11.5e-6)))

(defun f_ks  (v d sl)
  (cond	((= sl 1) (l_int v 0.1 0.5 0.3e9 0.35e9))
	((or (= sl 2) (= sl 3)) 41.72e9)))

(defun f_cv  (v d sl)
  (cond	((or (= sl 1) (= sl 2)) 0.67e3)
	((= sl 3) 0.89e3)))

(defun f_vi  (v d sl)
  (* pi (/ 4.0 3.0) (expt (* d 0.5) 3)))


(defun gamma_ef  (v d sl)
  (setq	
	v_i    (f_vi v d sl)
	alfa_s (f_alfas	v d sl)
	cv     (f_cv  v d sl)
	k_s    (f_ks  v d sl))
  (/ (* v_i alfa_s) (* k_s cv)))

(gamma_ef 0.1 20.e-6 1)
