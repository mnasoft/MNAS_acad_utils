(setq A_g    '(0.000	0.050	 0.100	  0.150	   0.200    0.300    0.400    0.500    0.600	0.800
	       1.000	1.200	 1.400	  1.600	   2.000    2.400    2.800    3.200    3.600	4.000
	       4.500	5.000	 6.000	  7.000	   8.000    9.000    10.00    12.00    14.00	16.00
	       18.00	20.00	 22.00	  24.00	   28.00    32.00    36.00    40.00    50.00	60.00
	       70.00	80.00	 100.0)
      Alfa_g '(0.000	8.000	 14.00	  20.00	   26.00    33.00    39.00    44.00    48.00	56.00
	       62.00	67.00	 71.00	  75.00	   80.00    86.00    90.00    94.00    98.00	100.0
	       104.0	106.5	 109.5	  112.0	   114.0    116.0    118.0    121.0    123.5	126.0
	       127.0	129.0	 131.5	  132.5	   135.0    136.5    138.0    139.5    143.0	144.0
	       146.0	147.0	 149.0)
      Mu_g   '(1.000	0.950	 0.890	  0.840	   0.810    0.720    0.665    0.605    0.570	0.495
	       0.440	0.395	 0.360	  0.330	   0.295    0.260    0.230    0.210    0.190	0.175
	       0.160	0.147	 0.127	  0.110	   0.100    0.090    0.084    0.072    0.064	0.057
	       0.051	0.044	 0.041	  0.038	   0.033    0.029    0.026    0.023    0.018	0.016
	       0.013	0.011	 0.010)
      Fi_g   '(1.000	0.975	 0.940	  0.915	   0.890    0.850    0.815    0.770    0.730	0.680
	       0.640	0.610	 0.575	  0.545	   0.505    0.470    0.440    0.415    0.390	0.370
	       0.355	0.335	 0.304	  0.278	   0.258    0.242    0.229    0.206    0.187	0.174
	       0.162	0.152	 0.144	  0.137	   0.126    0.116    0.107    0.101    0.087	0.078
	       0.070	0.065	 0.056))
(setq Rebx_g	'(2.7 2.8 2.9 3.0 3.1 3.2 3.3 3.4 3.5 3.6 3.7 3.8 3.9 4.0 4.3 4.6)
      Lambdak_g	'(0.237	0.193 0.168 0.142 0.118	0.099 0.083 0.072 0.064	0.059 0.054 0.050 0.046	0.043
		  0.033	0.025))
(setq Reotv_g '(2.1 2.3 2.5 2.6 2.7 2.8 2.9 3.0 3.2 3.4 3.6 3.8 4.2 4.5 4.7)
      Epsbx_g '(2.65 2.0 1.6 1.48 1.37 1.30 1.25 1.17 1.07 0.95 0.89 0.82 0.76 0.75 0.745))
(setq Teta_g  '(0.00 0.10 0.20 0.30 0.40 0.50 0.60 0.70 0.80 1.00 1.20 1.50 2.00 2.50)
      _Alfa_g '(1.00 0.95 0.90 0.86 0.83 0.81 0.795 0.78 0.77 0.75 0.74 0.72 0.695 0.68))
(setq Eps_g '(1.00 0.91 0.85 0.82 0.795 0.78 0.77 0.7625 0.755 0.75 0.74)
      B_g   '(0.00 0.05 0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.75))
(setq Epsc_g '(0.059 0.094 0.127 0.160)
      Psi_g  '(60.0 80.0 100.0 120.0))

(defun f_dc (g mu ro p) (sqrt (/ (* 4. g) (* pi (sqrt (* 2. ro p)) mu))))
(defun f_dr (d) (* d 0.5))
(defun f_r (c rc) (* c rc))
(defun f_Rebx (g ro nu d n) (/ (* 4. g) (* ro nu pi d (sqrt n))))
(defun f_ck (c rbx rc) (+ c (/ rbx rc)))

(defun f_deltabx  (Rebx n rc rbx / Reotv Epsbx)
  (setq	Reotv (/ Rebx (sqrt n))
	Epsbx (half_div Reotv_g Epsbx_g (/ (log Reotv) (log 10.))))
  (/ Epsbx (expt (/ rbx rc) 4) (* n n)))

(defun f_deltac	 (Aeps psi / Epsc Fi)
  (setq	Epsc (half_div Psi_g Epsc_g Psi)
	Fi   (half_div A_g Fi_g Aeps))
  (/ Epsc Fi Fi))

(defun f_deltak	 (Lambdak Ck Aeps / sigma)
  (setq	sigma (+ (/ 1.0 Aeps) (* Lambdak 0.5 Ck)) ;+
	)      ;setq
  (* Lambdak
     (/ 1.0 sigma sigma)
     (+	(/ (- 1.0 (/ 1.0 Ck)) sigma)
	(* Lambdak
	   (+ (* (- (/ Aeps 2.) (/ 1.0 (- (* 2 sigma) Lambdak)))
		 (+ (/ 2. sigma) (/ Aeps 2.) (/ 1.0 (- (* 2 sigma) Lambdak))))
	      (* 1.5 (/ 1.0 sigma sigma) (log (* (- (* 2 sigma) Lambdak) Aeps Ck 0.5))))))))

(defun half_div	 (lx ly x / l r i d y)
  (setq	l 0
	r (1- (length lx)))
  (if (> (nth l lx) (nth r lx))
    (setq lx (reverse lx)
	  ly (revrse ly)))
  (while (> (- r l) 1)
    (setq d (cond ((= d 1) 0)
		  ((= d 0) 1)
		  (t 1))
	  i (/ (+ r l) 2))
    (cond ((= (nth i lx) x)
	   (setq r i
		 l i
		 y (nth i ly)))
	  ((> (nth i lx) x) (setq r i))
	  ((< (nth i lx) x) (setq l i))))
  (if (null y)
    (setq y (+ (nth l ly)
	       (/ (* (- (nth r ly) (nth l ly)) (- x (nth l lx))) (- (nth r lx) (nth l lx))))))
  y)

;;;;;;("pr1" "Первый проход." "Расчеты")
(defun c:pr1  ()
  (setq	alfa1	  (/ alfa0 0.85)
	Aeps1	  (half_div Alfa_g A_g Alfa1)
	mu1	  (half_div Alfa_g Mu_g Alfa1)
	dc1	  (f_dc g mu1 ro dp)
	rc1	  (f_dr dc1)
	R1	  (f_r c rc1)
	Eps0	  0.8
	dbx1	  (* 2. (sqrt (/ (* R1 rc1 (sin beta)) (* Eps0 n Aeps1))))
	rbx1	  (f_dr dbx1)
	Rebx1	  (f_Rebx g ro nu dbx1 n)
	Lambdak1  (half_div Rebx_g Lambdak_g (/ (log Rebx1) (log 10.)))
	Ck1	  (f_ck C rbx1 rc1)
	Teta1	  (* Lambdak1 0.5 Aeps1 (- Ck1 1.0))
	Aed1	  (/ Aeps1 (+ 1 Teta1))
	MuTeta1	  (half_div A_g Mu_g Aed1)
	AlfaTeta1 (half_div A_g Alfa_g Aed1)
	_Alfa1	  (half_div Teta_g _Alfa_g Teta1)
	Alfap1	  (* _Alfa1 AlfaTeta1)
	deltabx1  (f_deltabx Rebx1 n rc1 rbx1)
	deltac1	  (f_deltac Aeps1 Psi)
	deltak1	  (f_deltak Lambdak1 Ck1 Aeps1)
	deltasig1 (+ deltabx1 deltak1 deltac1)
	Mup1	  (/ MuTeta1 (sqrt (+ 1 (* DeltaSig1 MuTeta1 Muteta1))))
	B1	  (/ R1 rbx1)
	Eps1	  (half_div B_g Eps_g (/ 1. B1))
	Alfa0p1	  (/ Alfa0 Alfap1)
	Mu1p1	  (/ Mu1 Mup1)
	Eps01	  (/ Eps0 Eps1))
  (foreach @n  '(alfa0	 g	 ro	 dp	 beta	 nu	 c	 n	 Psi	 alfa1	 Aeps1
		 mu1	 dc1	 rc1	 R1	 Eps0	 dbx1	 rbx1	 Rebx1	 Lambdak1	 Ck1
		 Teta1	 Aed1	 MuTeta1 AlfaTeta1	 _Alfa1	 Alfap1	 deltabx1	 deltac1 deltak1
		 deltasig1	 Mup1	 B1	 Eps1	 Alfa0p1 Mu1p1	 Eps01)
    (princ "\n")
    (princ @n)
    (princ " = ")
    (prin1 (eval @n)))
  (princ))

;;;;;;("pr2" "Второй проход." "Расчеты")
(defun c:pr2  ()
  (setq	Alfa2	  (/ Alfa0 _Alfa1)
	AEPS_2	  (half_div Alfa_g A_g Alfa2)
	Mu2	  (half_div A_g Mu_g AEPS_2)
	Mu2_	  (/ Mu2 (sqrt (+ 1 (* deltaSig1 Mu2 Mu2))))
	dc2	  (f_dc g mu2_ ro dp)
	rc2	  (f_dr dc2)
	R2	  (f_r c rc2)
	dbx2	  (* 2.0
		     (sqrt (* R2 rc2 (sin beta) (/ 1.0 Eps1 n) (- (/ 1.0 AEPS_2) (* Lambdak1 0.5 (- ck1 1.0))))))
	rbx2	  (f_dr dbx2)
	Rebx2	  (f_Rebx g ro nu dbx2 n)
	Lambdak2  (half_div Rebx_g Lambdak_g (/ (log Rebx2) (log 10.)))
	ck2	  (f_ck c rbx2 rc2)
	Teta2	  (* Lambdak2 R2 rc2 0.5 (- ck2 1) (/ 1.0 eps1 n rbx2 rbx2))
	Aed2	  (/ (* R2 rc2) Eps1 n rbx2 rbx2 (+ 1 teta2))
	MuTeta2	  (half_div A_g Mu_g Aed2)
	AlfaTeta2 (half_div A_g Alfa_g Aed2)
	_Alfa2	  (half_div Teta_g _Alfa_g Teta2)
	Alfap2	  (* _Alfa2 AlfaTeta2)
	deltabx2  (f_deltabx Rebx2 n rc2 rbx2)
	deltac2	  (f_deltac AEPS_2 Psi)
	deltak2	  (f_deltak Lambdak2 Ck2 AEPS_2)
	deltasig2 (+ deltabx2 deltak2 deltac2)
	Mup2	  (/ MuTeta2 (sqrt (+ 1 (* DeltaSig2 MuTeta2 Muteta2))))
	B2	  (/ R2 rbx2)
	Eps2	  (half_div B_g Eps_g (/ 1. B2))
	Alfa0p2	  (/ Alfa0 Alfap2)
	Mu2p2	  (/ Mu2_ Mup2)
	Eps12	  (/ Eps1 Eps2))
  (foreach @n  '(Alfa2	  AEPS_2   Mu2	    Mu2_     dc2      rc2      R2	dbx2	 rbx2
		 Rebx2	  Lambdak2 ck2	    Teta2    Aed2     MuTeta2  AlfaTeta2	 _Alfa2
		 Alfap2	  deltabx2 deltac2  deltak2  deltasig2	       Mup2	B2	 Eps2
		 Alfa0p2  Mu2p2	   Eps12)
    (princ "\n")
    (princ @n)
    (princ " = ")
    (prin1 (eval @n)))
  (princ))

;;;;;;("rep" "Формула повторений." "Расчеты")
(defun c:rep  ()
  (setq	_Alfa1	 _Alfa2
	Eps1	 Eps2
	Lambdak1 Lambdak2
	Ck1	 Ck2)
  (princ))
