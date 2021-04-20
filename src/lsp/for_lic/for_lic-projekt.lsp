;;;;;;("for_proect" "Проектиоровочный расчет жидкотопливной форсунки." "Расчеты")
(defun c:for_proect  (/
                      old_err
                      fn                ; Имя файла
                      f1                ; Дескриптор файла
                      )
  (setq str "Alfa G Ro dP Beta nu C N Psi pr1 pr2 RUn Save Load PRint EXit")
  (setvar "cmdecho" 0)
  (setq alfa0 105.
        g     1.e-3
        ro    805.
        dp    6.0e6
        beta  (/ 90. (/ 180. pi))
        nu    2.0e-6)
  (setq c   1.5
        n   4.00
        psi 90.0)
  (setq str1 "")
  (while (/= str1 "EXit")
    (initget str)
    (setq str1 (getkword (strcat "\n" str " : ")))
    (cond ((= str1 "Save")
           (setq fn (getfiled "Сохранение файла с исходными данными по форсунке" "" "dat" 1))
           (if (null fn)
             (setq fn "data.dat"))
           (setq f1 (open fn "w"))
           (if (null f1)
             (progn (alert (princ (strcat "\nНе могу открыть файл: " fn ".\n"))) (exit)))
           (mapcar '(lambda (el) (print_file el f1)) '(alfa0 g ro dp nu beta c n psi))
           (close f1))
          ((= str1 "Load")
           (setq fn (getfiled "Открытие файла с исходными данными по форсунке" "" "dat" 0))
           (if (null fn)
             (setq fn "data.dat"))
           (load fn))
          ((= str1 "RUn")
           (c:pr1)
           (c:pr2)
           (setq i_no 2)
           (while (> (abs (1- mu2p2)) 0.01) (c:rep) (c:pr2) (setq i_no (1+ i_no)) (princ "\h") (princ i_no)))
          ((= str1 "Alfa") (qw_real "Alfa" "d" 'alfa0))
          ((= str1 "G") (qw_real "G" "kg/s" 'g))
          ((= str1 "Ro") (qw_real "ro" "kg/m^3" 'ro))
          ((= str1 "dP") (qw_real "dP" "N/m^2" 'dp))
          ((= str1 "nu") (qw_real "Nu" "" 'nu))
          ((= str1 "Beta") (qw_angle "Beta" "dig" 'beta))
          ((= str1 "C") (qw_real "C" "mm/mm" 'c))
          ((= str1 "N") (qw_real "N" "" 'n))
          ((= str1 "Psi") (qw_real "Psi" "" 'psi))
          ((= str1 "pr1") (c:pr1))
          ((= str1 "pr2") (c:pr2) (c:rep))
          ((= str1 "PRint")
           (foreach @n  '(alfa0 g ro dp nu beta c n psi dc2 rc2 r2 dbx2 rbx2 alfa0p2 mu2p2 eps12)
             (princ "\n")
             (princ @n)
             (princ " = ")
             (prin1 (eval @n))))))
  (setvar "cmdecho" 1)
  (setq *error* old_err)
  (princ))

(defun for_proect:err (msg) (setvar "cmdecho" 1) (setq *error* old_err) (princ))

(defun qw_real  (st1 st2 @val / temp)
  (princ (strcat "\n" st1 " < "))
  (prin1 (eval @val))
  (setq temp (getreal (strcat " " st2 " > : ")))
  (if temp
    (set @val temp)))

(defun qw_angle  (st1 st2 @val / temp)
  (princ (strcat "\n" st1 " < "))
  (if (numberp (eval @val))
    (princ (strcat (angtos (eval @val) 1 2))))
  (setq temp (getangle (strcat " " st2 " > : ")))
  (if temp
    (set @val temp)))



(defun print_file  (@n f /)
  (princ "(setq " f)
  (prin1 @n f)
  (princ " " f)
  (prin1 (eval @n) f)
  (princ ")\n" f))

;;;;;;("gr" "Программа для построения графика." "Шкалы")
(defun c:gr  (/ strx stry xs ys)
  (setq str "Setup AX AY XScale YScale xmIn xmAx dElta Draw P0 EXit")
  (setvar "cmdecho" 0)
  (setq str1 "")
  (while (/= str1 "EXit")
    (initget str)
    (setq str1 (getkword (strcat str " : ")))
    (cond ((= str1 "AX") (setq strx (getstring (strcat "\nVariable name of X-Axsis < " strx " > :"))))
          ((= str1 "Setup")
           (setq strx  "A_g"
                 stry  "Mu_g"
                 xs    1.0
                 ys    1.0
                 p0    (list 0.0 0.0 0.0)
                 xmin  0.0
                 xmax  100.0
                 delta 1.0))
          ((= str1 "AY") (setq stry (getstring (strcat "\nVariable name of X-Axsis < " stry " > :"))))
          ((= str1 "XScale") (setq xs (getreal "\nX-scale :")))
          ((= str1 "YScale") (setq ys (getreal "\nY-scale :")))
          ((= str1 "dElta") (setq delta (getreal "\nDelte :")))
          ((= str1 "xmIn") (setq xmin (getreal "\nXmin :")))
          ((= str1 "xmAx") (setq xmax (getreal "\nXmax :")))
          ((= str1 "Draw")
           (setq xc xmin)
           (command-s "line")
           (while (<= xc xmax)
             (setq xgr (eval (read strx))
                   ygr (eval (read stry)))
             (setq yc (half_div xgr ygr xc)
                   p  (list (* xc xs) (* yc ys)))
             (command-s "non" p)
             (setq xc (+ xc delta)))
           (command-s ""))
          ((= str1 "P0") (setq p0 (getpoint "/np0 :")))))
  (setvar "cmdecho" 1))
