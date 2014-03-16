;;;(princ "\nЗагружаю For_lic/проект      ")
(princ (strcat "\nЗагружаю " (acad_sup) "/" "For_lic/проект      "))

;;;;;;("for_proect" "Проектиоровочный расчет жидкотопливной форсунки." "Расчеты")
(defun c:for_proect
		    (/
		     old_err
		     fn ; Имя файла
		     f1 ; Дескриптор файла
		    )
  (setq	str
	 "Alfa G Ro dP Beta nu C N Psi pr1 pr2 RUn Save Load PRint EXit"
  )

  (setvar "cmdecho" 0)
  (setq
    alfa0 105.
    g	  1.e-3
    ro	  805.
    dp	  6.0e6
    beta  (/ 90. (/ 180. pi))
    nu	  2.0e-6
  )

  (setq
    c	1.5
    n	4.00
    Psi	90.0
  )

  (setq str1 "")
  (while (/= str1 "EXit")
    (initget str)
    (setq str1 (getkword (strcat "\n" str " : ")))
    (cond
      ((= Str1 "Save")
       (setq
	 fn
	  (getfiled "Сохранение файла с исходными данными по форсунке"
		    ""
		    "dat"
		    1
	  )
       )
       (if
	 (null fn)
	  (setq fn "data.dat")
       )

       (setq f1 (open fn "w"))
       (if (null f1)
	 (progn
	   (alert
	     (princ
	       (strcat
		 "\nНе могу открыть файл: "
		 fn
		 ".\n"
	       )
	     )
	   )
	   (exit)
	 )
       )
       
       (mapcar '(lambda (el) (print_file el f1))
	       '(Alfa0 G Ro dP Nu Beta C N Psi)
       )
       (close f1)
      )
      ((= Str1 "Load")
       (setq
	 fn (getfiled "Открытие файла с исходными данными по форсунке"
		      ""
		      "dat"
		      0
	    )
       )
       (if
	 (null fn)
	  (setq fn "data.dat")
       )
       (load fn)
      )
      ((= Str1 "RUn")
       (c:pr1)
       (c:pr2)
       (setq i_no 2)
       (while (> (abs (1- mu2p2)) 0.01)
	 (c:rep)
	 (c:pr2)
	 (setq i_no (1+ i_no))
	 (princ "\h")
	 (princ i_no)
       )
      )

      ((= Str1 "Alfa") (qw_real "Alfa" "d" 'Alfa0))
      ((= Str1 "G") (qw_real "G" "kg/s" 'G))
      ((= Str1 "Ro") (qw_real "ro" "kg/m^3" 'Ro))
      ((= Str1 "dP") (qw_real "dP" "N/m^2" 'dP))
      ((= Str1 "nu") (qw_real "Nu" "" 'Nu))
      ((= Str1 "Beta") (qw_angle "Beta" "dig" 'Beta))
      ((= Str1 "C") (qw_real "C" "mm/mm" 'C))
      ((= Str1 "N") (qw_real "N" "" 'N))
      ((= Str1 "Psi") (qw_real "Psi" "" 'Psi))
      ((= Str1 "pr1") (c:pr1))
      ((= Str1 "pr2") (c:pr2) (c:rep))
      ((= Str1 "PRint")
       (foreach
		 @n
		   '(Alfa0 G	 Ro    dP    Nu	   Beta	 C     N
		     Psi   dc2	 rc2   R2    dbx2  rbx2	 Alfa0p2
		     Mu2p2 Eps12
		    )
	 (princ "\n")
	 (princ @n)
	 (princ " = ")
	 (prin1 (eval @n))
       )
      )

    )
  )
  (setvar "cmdecho" 1)
  (setq *error* old_err)
  (princ)
)

(defun for_proect:err (msg)
  (setvar "cmdecho" 1)
  (setq *error* old_err)
  (princ)
)

(defun qw_real (st1 st2 @Val / temp)
  (princ (strcat "\n" st1 " < "))
  (prin1 (eval @Val))
  (setq temp (getreal (strcat " " st2 " > : ")))
  (if temp
    (set @Val temp)
  )
)

(defun qw_angle	(st1 st2 @Val / temp)
  (princ (strcat "\n" st1 " < "))
  (if
    (numberp (eval @Val))
     (princ (strcat (angtos (eval @Val) 1 2)))
  )
  (setq temp (getangle (strcat " " st2 " > : ")))
  (if temp
    (set @Val temp)
  )
)



(defun print_file (@n f /)
  (princ "(setq " f)
  (prin1 @n f)
  (princ " " f)
  (prin1 (eval @n) f)
  (princ ")\n" f)
)

;;;;;;("gr" "Программа для построения графика." "Шкалы")
(defun c:gr (/ StrX StrY Xs Ys)
  (setq str "Setup AX AY XScale YScale xmIn xmAx dElta Draw P0 EXit")

  (setvar "cmdecho" 0)
  (setq str1 "")
  (while (/= str1 "EXit")
    (initget str)
    (setq str1 (getkword (strcat str " : ")))
    (cond
      ((= Str1 "AX")
       (setq
	 StrX (getstring
		(strcat "\nVariable name of X-Axsis < " StrX " > :")
	      )
       )
      )
      ((= Str1 "Setup")
       (setq
	 StrX  "A_g"
	 StrY  "Mu_g"
	 Xs    1.0
	 Ys    1.0
	 p0    (list 0.0 0.0 0.0)
	 xmin  0.0
	 xmax  100.0
	 delta 1.0
       )
      )
      ((= Str1 "AY")
       (setq
	 StrY (getstring
		(strcat "\nVariable name of X-Axsis < " StrY " > :")
	      )
       )
      )
      ((= Str1 "XScale") (setq Xs (getreal "\nX-scale :")))
      ((= Str1 "YScale") (setq Ys (getreal "\nY-scale :")))
      ((= Str1 "dElta") (setq delta (getreal "\nDelte :")))
      ((= Str1 "xmIn") (setq Xmin (getreal "\nXmin :")))
      ((= Str1 "xmAx") (setq Xmax (getreal "\nXmax :")))
      ((= Str1 "Draw")
       (setq xc xmin)
       (command "line")
       (while (<= xc xmax)
	 (setq
	   xgr (eval (read StrX))
	   ygr (eval (read StrY))
	 )
	 (setq
	   yc (half_div xgr ygr xc)
	   p  (list (* xc Xs) (* yc Ys))
	 )
	 (command "non" p)
	 (setq xc (+ xc delta))
       )
       (command "")
      )
      ((= Str1 "P0")
       (setq P0 (getpoint "/np0 :"))
      )
    )
  )
  (setvar "cmdecho" 1)
)

(princ "\t...загружен.\n")
;|«Visual LISP© Format Options»
(72 2 5 2 nil "end of" 60 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
