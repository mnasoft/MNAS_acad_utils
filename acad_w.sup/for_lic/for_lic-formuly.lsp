(setq a_g    '(0.000    0.050    0.100    0.150    0.200    0.300    0.400    0.500    0.600    0.800    1.000    1.200    1.400    1.600    2.000
               2.400    2.800    3.200    3.600    4.000    4.500    5.000    6.000    7.000    8.000    9.000    10.00    12.00    14.00    16.00
               18.00    20.00    22.00    24.00    28.00    32.00    36.00    40.00    50.00    60.00    70.00    80.00    100.0)
      alfa_g '(0.000    8.000    14.00    20.00    26.00    33.00    39.00    44.00    48.00    56.00    62.00    67.00    71.00    75.00    80.00
               86.00    90.00    94.00    98.00    100.0    104.0    106.5    109.5    112.0    114.0    116.0    118.0    121.0    123.5    126.0
               127.0    129.0    131.5    132.5    135.0    136.5    138.0    139.5    143.0    144.0    146.0    147.0    149.0)
      mu_g   '(1.000    0.950    0.890    0.840    0.810    0.720    0.665    0.605    0.570    0.495    0.440    0.395    0.360    0.330    0.295
               0.260    0.230    0.210    0.190    0.175    0.160    0.147    0.127    0.110    0.100    0.090    0.084    0.072    0.064    0.057
               0.051    0.044    0.041    0.038    0.033    0.029    0.026    0.023    0.018    0.016    0.013    0.011    0.010)
      fi_g   '(1.000    0.975    0.940    0.915    0.890    0.850    0.815    0.770    0.730    0.680    0.640    0.610    0.575    0.545    0.505
               0.470    0.440    0.415    0.390    0.370    0.355    0.335    0.304    0.278    0.258    0.242    0.229    0.206    0.187    0.174
               0.162    0.152    0.144    0.137    0.126    0.116    0.107    0.101    0.087    0.078    0.070    0.065    0.056))
(setq rebx_g    '(2.7 2.8 2.9 3.0 3.1 3.2 3.3 3.4 3.5 3.6 3.7 3.8 3.9 4.0 4.3 4.6)
      lambdak_g '(0.237 0.193 0.168 0.142 0.118 0.099 0.083 0.072 0.064 0.059 0.054 0.050 0.046 0.043 0.033 0.025))
(setq reotv_g '(2.1 2.3 2.5 2.6 2.7 2.8 2.9 3.0 3.2 3.4 3.6 3.8 4.2 4.5 4.7)
      epsbx_g '(2.65 2.0 1.6 1.48 1.37 1.30 1.25 1.17 1.07 0.95 0.89 0.82 0.76 0.75 0.745))
(setq teta_g  '(0.00 0.10 0.20 0.30 0.40 0.50 0.60 0.70 0.80 1.00 1.20 1.50 2.00 2.50)
      _alfa_g '(1.00 0.95 0.90 0.86 0.83 0.81 0.795 0.78 0.77 0.75 0.74 0.72 0.695 0.68))
(setq eps_g '(1.00 0.91 0.85 0.82 0.795 0.78 0.77 0.7625 0.755 0.75 0.74)
      b_g   '(0.00 0.05 0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.75))
(setq epsc_g '(0.059 0.094 0.127 0.160)
      psi_g  '(60.0 80.0 100.0 120.0))

(defun f_dc (g mu ro p) (sqrt (/ (* 4. g) (* pi (sqrt (* 2. ro p)) mu))))
(defun f_dr (d) (* d 0.5))
(defun f_r (c rc) (* c rc))
(defun f_rebx (g ro nu d n) (/ (* 4. g) (* ro nu pi d (sqrt n))))
(defun f_ck (c rbx rc) (+ c (/ rbx rc)))

(defun f_deltabx  (rebx n rc rbx / reotv epsbx)
  (setq reotv (/ rebx (sqrt n))
        epsbx (half_div reotv_g epsbx_g (/ (log reotv) (log 10.))))
  (/ epsbx (expt (/ rbx rc) 4) (* n n)))

(defun f_deltac  (aeps psi / epsc fi)
  (setq epsc (half_div psi_g epsc_g psi)
        fi   (half_div a_g fi_g aeps))
  (/ epsc fi fi))

(defun f_deltak  (lambdak ck aeps / sigma)
  (setq sigma (+ (/ 1.0 aeps) (* lambdak 0.5 ck)) ;+
        )                               ;setq
  (* lambdak
     (/ 1.0 sigma sigma)
     (+ (/ (- 1.0 (/ 1.0 ck)) sigma)
        (* lambdak
           (+ (* (- (/ aeps 2.) (/ 1.0 (- (* 2 sigma) lambdak)))
                 (+ (/ 2. sigma) (/ aeps 2.) (/ 1.0 (- (* 2 sigma) lambdak))))
              (* 1.5 (/ 1.0 sigma sigma) (log (* (- (* 2 sigma) lambdak) aeps ck 0.5))))))))

(defun half_div  (lx ly x / l r i d y)
  (setq l 0
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
    (setq y (+ (nth l ly) (/ (* (- (nth r ly) (nth l ly)) (- x (nth l lx))) (- (nth r lx) (nth l lx))))))
  y)

;;;;;;("pr1" "Первый проход." "Расчеты")
(defun c:pr1  ()
  (setq alfa1     (/ alfa0 0.85)
        aeps1     (half_div alfa_g a_g alfa1)
        mu1       (half_div alfa_g mu_g alfa1)
        dc1       (f_dc g mu1 ro dp)
        rc1       (f_dr dc1)
        r1        (f_r c rc1)
        eps0      0.8
        dbx1      (* 2. (sqrt (/ (* r1 rc1 (sin beta)) (* eps0 n aeps1))))
        rbx1      (f_dr dbx1)
        rebx1     (f_rebx g ro nu dbx1 n)
        lambdak1  (half_div rebx_g lambdak_g (/ (log rebx1) (log 10.)))
        ck1       (f_ck c rbx1 rc1)
        teta1     (* lambdak1 0.5 aeps1 (- ck1 1.0))
        aed1      (/ aeps1 (+ 1 teta1))
        muteta1   (half_div a_g mu_g aed1)
        alfateta1 (half_div a_g alfa_g aed1)
        _alfa1    (half_div teta_g _alfa_g teta1)
        alfap1    (* _alfa1 alfateta1)
        deltabx1  (f_deltabx rebx1 n rc1 rbx1)
        deltac1   (f_deltac aeps1 psi)
        deltak1   (f_deltak lambdak1 ck1 aeps1)
        deltasig1 (+ deltabx1 deltak1 deltac1)
        mup1      (/ muteta1 (sqrt (+ 1 (* deltasig1 muteta1 muteta1))))
        b1        (/ r1 rbx1)
        eps1      (half_div b_g eps_g (/ 1. b1))
        alfa0p1   (/ alfa0 alfap1)
        mu1p1     (/ mu1 mup1)
        eps01     (/ eps0 eps1))
  (foreach @n  '(alfa0   g       ro      dp      beta    nu      c       n       psi     alfa1   aeps1   mu1     dc1     rc1     r1      eps0
                 dbx1    rbx1    rebx1   lambdak1        ck1     teta1   aed1    muteta1 alfateta1       _alfa1  alfap1  deltabx1        deltac1
                 deltak1 deltasig1       mup1    b1      eps1    alfa0p1 mu1p1   eps01)
    (princ "\n")
    (princ @n)
    (princ " = ")
    (prin1 (eval @n)))
  (princ))

;;;;;;("pr2" "Второй проход." "Расчеты")
(defun c:pr2  ()
  (setq alfa2     (/ alfa0 _alfa1)
        aeps_2    (half_div alfa_g a_g alfa2)
        mu2       (half_div a_g mu_g aeps_2)
        mu2_      (/ mu2 (sqrt (+ 1 (* deltasig1 mu2 mu2))))
        dc2       (f_dc g mu2_ ro dp)
        rc2       (f_dr dc2)
        r2        (f_r c rc2)
        dbx2      (* 2.0 (sqrt (* r2 rc2 (sin beta) (/ 1.0 eps1 n) (- (/ 1.0 aeps_2) (* lambdak1 0.5 (- ck1 1.0))))))
        rbx2      (f_dr dbx2)
        rebx2     (f_rebx g ro nu dbx2 n)
        lambdak2  (half_div rebx_g lambdak_g (/ (log rebx2) (log 10.)))
        ck2       (f_ck c rbx2 rc2)
        teta2     (* lambdak2 r2 rc2 0.5 (- ck2 1) (/ 1.0 eps1 n rbx2 rbx2))
        aed2      (/ (* r2 rc2) eps1 n rbx2 rbx2 (+ 1 teta2))
        muteta2   (half_div a_g mu_g aed2)
        alfateta2 (half_div a_g alfa_g aed2)
        _alfa2    (half_div teta_g _alfa_g teta2)
        alfap2    (* _alfa2 alfateta2)
        deltabx2  (f_deltabx rebx2 n rc2 rbx2)
        deltac2   (f_deltac aeps_2 psi)
        deltak2   (f_deltak lambdak2 ck2 aeps_2)
        deltasig2 (+ deltabx2 deltak2 deltac2)
        mup2      (/ muteta2 (sqrt (+ 1 (* deltasig2 muteta2 muteta2))))
        b2        (/ r2 rbx2)
        eps2      (half_div b_g eps_g (/ 1. b2))
        alfa0p2   (/ alfa0 alfap2)
        mu2p2     (/ mu2_ mup2)
        eps12     (/ eps1 eps2))
  (foreach @n  '(alfa2    aeps_2   mu2      mu2_     dc2      rc2      r2       dbx2     rbx2     rebx2    lambdak2 ck2      teta2    aed2
                 muteta2  alfateta2         _alfa2   alfap2   deltabx2 deltac2  deltak2  deltasig2         mup2     b2       eps2     alfa0p2
                 mu2p2    eps12)
    (princ "\n")
    (princ @n)
    (princ " = ")
    (prin1 (eval @n)))
  (princ))

;;;;;;("rep" "Формула повторений." "Расчеты")
(defun c:rep  ()
  (setq _alfa1   _alfa2
        eps1     eps2
        lambdak1 lambdak2
        ck1      ck2)
  (princ))
