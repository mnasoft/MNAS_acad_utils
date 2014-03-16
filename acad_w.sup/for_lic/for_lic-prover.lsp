;;;(princ "\nЗагружаю For_lic/проверка    ")
(princ (strcat "\nЗагружаю " (acad_sup) "/" "For_lic/for_prover  "))

;;;;;;("for_prov"
;;;;;;  "Проверочный расчет жидкотопливной форсунки
;;;;;;Ввод данных выполняется в диалоговом режиме." "Расчеты" )
(defun c:for_prov
		  (/ ;
		   old_err ;
		   fn ; Имя файла
		   f1 ; Дескриптор файла
		   ALFA_EPS ;
		   ALFA_P ;
		   ALFA_TETA ;
		   A_ED ;
		   A_EPS ;
		   B ;
		   BETA ;
		   C ;
		   C_K ;
		   DBX ;
		   DC ;
		   DELTA_BX ;
		   DELTA_C ;
		   DELTA_K ;
		   DELTA_SIG ;
		   DP ;
		   EL ;
		   EPS ;
		   F1 ;
		   G ;
		   I_NO ;
		   LAMBDA_K ;
		   LL_FOR_PROVER_SETUP ;
		   MU_EPS ;
		   MU_P ;
		   MU_TETA ;
		   N ;
		   NU ;
		   PSI ;
		   R ;
		   RBX ;
		   RC ;
		   RE_BX ;
		   RO ;
		   STR ;
		   STR1 ;
		   TETA ;
		   _ALFA ;
		  )



  (setq	ll_for_prover_setup
	 '(
	   ("f_pr-dc" "1.")
	   ("f_pr-dbx" "0.5")
	   ("f_pr-n" "2")
	   ("f_pr-r" "2.5")
	   ("f_pr-beta" "90.0")
	   ("f_pr-psi" "60.0")
	   ("f_pr-dp" "30.0")
	   ("f_pr-ro" "835.0")
	   ("f_pr-nu" "3.0")
	  )
  )
  (setq str "Data Save RUn Load PRint EXit")
  (setvar "cmdecho" 0)
  (setq str1 "")
  (while (/= str1 "EXit")
    (initget str)
    (setq str1 (getkword (strcat "\n" str " : ")))
    (cond
      (
       (= Str1 "Save")
       (setq fn
	      (getfiled	"Открытие файла с исходными данными по форсунке"
			""
			"dat"
			1
	      )
       )
       (if (null fn)
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
       (mapcar
	 '(lambda (el) (print_file el f1))
	 '(dc dbx R ro dp beta nu c n Psi)
       )
       (close f1)
      )
      (
       (= Str1 "Load")
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
       (setq ll_for_prover_setup
	      (list
		(list "f_pr-dc" (rtos (* dc 1000.0)))
		(list "f_pr-dbx" (rtos (* dbx 1000.0)))
		(list "f_pr-n" (rtos n))
		(list "f_pr-r" (rtos (* r 1000.0)))
		(list "f_pr-beta" (angtos beta))
		(list "f_pr-psi" (rtos psi))
		(list "f_pr-dp" (rtos (* dp 0.00001)))
		(list "f_pr-ro" (rtos ro))
		(list "f_pr-nu" (rtos (* nu 1000000.0)))
	      )
       )
      )
      (
       (= Str1 "RUn")
       (setq i_no 0)
       (while (<= i_no 10)
	 (princ "\n\t\t\t")
	 (princ i_no)
	 (setq
	   rc	     (f_dr dc)
	   rbx	     (f_dr dbx)
	   B	     (/ R rbx)
	   Eps	     (half_div B_g Eps_g (/ 1.0 B))
	   A_eps     (/ (* R rc (sin beta)) (* Eps n rbx rbx))
	   mu_eps    (cond
		       ((= 0 i_no) (half_div A_g mu_g A_eps))
		       ((> i_no 0) mu_p)
		     )
	   alfa_eps  (cond
		       (
			(= 0 i_no)
			(half_div A_g alfa_g A_eps)
		       )
		       (
			(> i_no 0)
			alfa_p
		       )
		     ) 
	   G	     (* pi 0.25 dc dc mu_eps (sqrt (* 2.0 ro dp)))
	   Re_bx     (f_Rebx g ro nu dbx n)
	   Lambda_k  (half_div Rebx_g
			       Lambdak_g
			       (/ (log Re_bx) (log 10.))
		     )
	   C	     (/ R rc)
	   C_k	     (f_ck C rbx rc)
	   Teta	     (* Lambda_k 0.5 A_eps (- C_k 1))
	   A_ed	     (/ A_eps (+ 1 Teta))
	   Mu_Teta   (half_div A_g Mu_g A_ed)
	   Alfa_Teta (half_div A_g Alfa_g A_ed)
	   _Alfa     (half_div Teta_g _Alfa_g Teta)
	   Alfa_p    (* _Alfa Alfa_Teta)
	   delta_bx  (f_deltabx Re_bx n rc rbx)
	   delta_c   (f_deltac A_eps Psi)
	   delta_k   (f_deltak Lambda_k C_k A_eps)
	   delta_sig (+ delta_bx delta_k delta_c)
	   Mu_p	     (/ Mu_Teta (sqrt (+ 1 (* Delta_Sig Mu_Teta Mu_Teta))))
	   i_no	     (1+ i_no)
	 )
	 (foreach
		   @n
		     '(alfa_eps alfa_p mu_eps mu_p)
	   (princ "\n")
	   (princ @n)
	   (princ " = ")
	   (prin1 (eval @n))
	 )
       )
      )
      ((= Str1 "Data")
       (for_prover:data)
      )
      (
       (= Str1 "PRint")
       (foreach
		 @n
		   '(dc dbx R beta n Psi ro dp nu g alfa_p mu_p)
	 (princ "\n")
	 (princ @n)
	 (princ " = ")
	 (prin1 (eval @n))
       )
      )
    )
  )
  (setvar "cmdecho" 1)
  (princ)
)


(defun for_prover:data (/ act dcl_id ll_for_prover)
  (setq ll_for_prover ll_for_prover_setup)
  (setq	dcl_id (load_dialog
		 (strcat (acad_sup) "/for_lic/for_lic-prover.dcl")
	       )
  )
  (if (< dcl_id 0)
    (exit)
  )
  (if (not (new_dialog "for_prover" dcl_id))
    (exit)
  )

  (for_prover:setup)
  (for_prover:ac_tile)
  (setq act (start_dialog))
  (cond
    ((= act 0) (for_prover:cancel))
    ((= act 1) (for_prover:ok))
  )
  (unload_dialog dcl_id)
)


(defun for_prover:err (msg)
  (setvar "cmdecho" 1)
  (princ)
)


(defun for_prover:setup	()
  (mapcar
    '(lambda (el)
       (cond
	 (
	  (= 2 (length el))
	  (set_tile (car el) (cadr el))
	 )
	 (
	  (= 3 (length el))
	  (start_list (car el))
	  (mapcar (function add_list) (caddr el))
	  (end_list)
	  (set_tile (car el) (cadr el))
	 )
       )
     )
    ll_for_prover
  )
      
  (start_image "f_pr-image")
  (FILL_IMAGE
    0
    0
    (DIMX_TILE "f_pr-image")
    (DIMY_TILE "f_pr-image")
    250
  )
  (slide_image
    0
    0
    (DIMX_TILE "f_pr-image")
    (DIMY_TILE "f_pr-image")
    (strcat (acad_sup) "/for_lic/for")
  )
  (end_image)  
)

(defun for_prover:ac_tile ()
  (mapcar
    (function (lambda (el) (action_tile (car el) "(for_prover-all_ac)")))
    ll_for_prover
  )
)

(defun for_prover-all_ac()
  (setq
    ll_for_prover
     (mapcar
       (function
	 (lambda (el)
	   (cond
	     (
	      (= 2 (length el))
	      (list (car el) (get_tile (car el)))
	     )
	     (
	      (= 3 (length el))
	      (list (car el) (get_tile (car el)) (caddr el))
	     )
	   )
	 )
       )
       ll_for_prover
     )
  )
  (for_prover:validate)
  (for_prover:setup)
)

(defun for_prover:validate ()
  (princ "for_prover-validate")
)

(defun for_prover:cancel ()
  (princ "for_prover:cancel")
)

(defun for_prover:ok ()
  (princ "for_prover:ok")
  (setq	dc   (* 0.001 (atof (cadr (assoc "f_pr-dc" ll_for_prover))))
	dbx  (* 0.001 (atof (cadr (assoc "f_pr-dbx" ll_for_prover))))
	n    (atof (cadr (assoc "f_pr-n" ll_for_prover)))
	r    (* 0.001 (atof (cadr (assoc "f_pr-r" ll_for_prover))))
	beta (angtof (cadr (assoc "f_pr-beta" ll_for_prover)))
	Psi  (atof (cadr (assoc "f_pr-psi" ll_for_prover)))
	ro   (atof (cadr (assoc "f_pr-ro" ll_for_prover)))
	dp   (* 100000. (atof (cadr (assoc "f_pr-dp" ll_for_prover))))
	nu   (* 0.000001 (atof (cadr (assoc "f_pr-nu" ll_for_prover))))
  )
  (setq ll_for_prover_setup ll_for_prover)
)

(princ "\t...загружен.\n")
;|«Visual LISP© Format Options»
(72 2 5 2 nil "end of" 60 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
