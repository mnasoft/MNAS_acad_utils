;;;;;;("for_prover" "����������� ������ �������������� ��������." "�������")
(defun c:for_prover  (/
                      old_err
                      fn                ; ��� �����
                      f1                ; ���������� �����
                      )
  (setq str "DC Dbx N R Psi Beta Ro dP nu Save RUn Load PRint EXit")
  (setvar "cmdecho" 0)                  ;(setq old_err *error* *error* err)
  (setq dc   0.0002
        dbx  0.00005
        r    0.0005
        beta (/ 90. (/ 180. pi))
        n    4.00
        psi  90.0)
  (setq ro 805.
        dp 6.0e6
        nu 2.0e-6)
  (setq str1 "")
  (while (/= str1 "EXit")
    (initget str)
    (setq str1 (getkword (strcat "\n" str " : ")))
    (cond ((= str1 "Save")
           (setq fn (getfiled "�������� ����� � ��������� ������� �� ��������" "" "dat" 1))
           (if (null fn)
             (setq fn "data.dat"))
           (setq f1 (open fn "w"))
           (if (null f1)
             (progn (alert (princ (strcat "\n�� ���� ������� ����: " fn ".\n"))) (exit)))
           (mapcar '(lambda (el) (print_file el f1)) '(dc dbx r ro dp beta nu c n psi))
           (close f1))
          ((= str1 "Load")
           (setq fn (getfiled "�������� ����� � ��������� ������� �� ��������" "" "dat" 0))
           (if (null fn)
             (setq fn "data.dat"))
           (load fn))
          ((= str1 "RUn")
           (setq i_no 0)
           (while (<= i_no 10)
             (princ "\n\t\t\t")
             (princ i_no)
             (setq rc        (f_dr dc)
                   rbx       (f_dr dbx)
                   b         (/ r rbx)
                   eps       (half_div b_g eps_g (/ 1.0 b))
                   a_eps     (/ (* r rc (sin beta)) (* eps n rbx rbx))
                   mu_eps    (cond ((= 0 i_no) (half_div a_g mu_g a_eps))
                                   ((> i_no 0) mu_p))
                   alfa_eps  (cond ((= 0 i_no) (half_div a_g alfa_g a_eps))
                                   ((> i_no 0) alfa_p)) ;cond
                   g         (* pi 0.25 dc dc mu_eps (sqrt (* 2.0 ro dp)))
                   re_bx     (f_rebx g ro nu dbx n)
                   lambda_k  (half_div rebx_g lambdak_g (/ (log re_bx) (log 10.)))
                   c         (/ r rc)
                   c_k       (f_ck c rbx rc)
                   teta      (* lambda_k 0.5 a_eps (- c_k 1))
                   a_ed      (/ a_eps (+ 1 teta))
                   mu_teta   (half_div a_g mu_g a_ed)
                   alfa_teta (half_div a_g alfa_g a_ed)
                   _alfa     (half_div teta_g _alfa_g teta)
                   alfa_p    (* _alfa alfa_teta)
                   delta_bx  (f_deltabx re_bx n rc rbx)
                   delta_c   (f_deltac a_eps psi)
                   delta_k   (f_deltak lambda_k c_k a_eps)
                   delta_sig (+ delta_bx delta_k delta_c)
                   mu_p      (/ mu_teta (sqrt (+ 1 (* delta_sig mu_teta mu_teta))))
                   i_no      (1+ i_no)) ;setq
             (foreach @n '(alfa_eps alfa_p mu_eps mu_p) (princ "\n") (princ @n) (princ " = ") (prin1 (eval @n))) ;foreach
             )                          ;while
           )
          ((= str1 "DC") (qw_real "Dc" "m" 'dc))
          ((= str1 "Dbx") (qw_real "Dbx" "m" 'dbx))
          ((= str1 "N") (qw_real "N" "" 'n))
          ((= str1 "R") (qw_real "R" "m" 'r))
          ((= str1 "Psi") (qw_real "Psi" "" 'psi))
          ((= str1 "Beta") (qw_angle "Beta" "dig" 'beta))
          ((= str1 "Ro") (qw_real "ro" "kg/m^3" 'ro))
          ((= str1 "dP") (qw_real "dP" "N/m^2" 'dp))
          ((= str1 "nu") (qw_real "Nu" "" 'nu))
          ((= str1 "PRint")
           (foreach @n  '(dc dbx r beta n psi ro dp nu g alfa_p mu_p)
             (princ "\n")
             (princ @n)
             (princ " = ")
             (prin1 (eval @n)))))       ;cond
    )                                   ;while
  (setvar "cmdecho" 1)
  (setq *error* old_err)
  (princ))

(defun for_prover:err (msg) (setvar "cmdecho" 1) (setq *error* old_err) (princ))