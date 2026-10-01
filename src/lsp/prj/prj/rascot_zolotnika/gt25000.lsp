(setq
  n2[об/мин]_n1[об/мин]_t04[С]_Ne[лс]_nтв[об/мин]_Gt[кг/ч]_dp02[кгс/см^2]
   '(
     (6000.0 3000.0 nil 0.0 nil 550.0 2.2)
     (6900.0 4200.0 nil 1250.0 nil 800.0 4.0)
     (7400.0 5000.0 nil 2800.0 nil 1200.0 5.7)
     (8070.0 5990.0 522.0 6710.0 1916.0 1960.8 8.32)
     (8454.0 6540.0 583.0 11368.0 2276.0 2716.4 10.78)
     (8690.0 6690.0 626.0 17146.0 2616.0 3538.0 13.44)
     (8980.0 6930.0 683.0 23024.0 2895.0 4418.9 15.81)
     (9110.0 7070.0 707.0 26119.0 3020.0 4865.0 16.92)
     (9235.0 7270.0 731.0 29578.0 3150.0 5341.2 18.27)
     (9406.0 7535.0 766.0 34146.0 3305.0 6015.4 19.83)
    )
)

(osr_func
  '(XX YY)
  '((XX XX XX)(XX XX) (XX) (1.0) (YY))
  (mapcar
    (function
      (lambda (el)
	(list (/ (nth 3 el) 33000.0) (nth 6 el) )
      )
    )
    n2[об/мин]_n1[об/мин]_t04[С]_Ne[лс]_nтв[об/мин]_Gt[кг/ч]_dp02[кгс/см^2]
  )
  'dp02[Ne_otn]
)

(osr_func
  '(XX YY)
  '((XX XX XX)(XX XX) (XX) (1.0) (YY))
  (mapcar
    (function
      (lambda (el)
	(list (/ (nth 3 el) 33000.0) (nth 5 el) )
      )
    )
    n2[об/мин]_n1[об/мин]_t04[С]_Ne[лс]_nтв[об/мин]_Gt[кг/ч]_dp02[кгс/см^2]
  )
  'Gt[Ne_otn]
)

(osr_func
  '(XX YY)
  '((XX XX XX)(XX XX) (XX) (1.0) (YY))
  (mapcar
    (function
      (lambda (el)
	(list (/ (nth 3 el) 33000.0) (nth 0 el) )
      )
    )
    n2[об/мин]_n1[об/мин]_t04[С]_Ne[лс]_nтв[об/мин]_Gt[кг/ч]_dp02[кгс/см^2]
  )
  'n2[Ne_otn]
)

(osr_func
  '(XX YY)
  '((XX XX XX)(XX XX) (XX) (1.0) (YY))
  (mapcar
    (function
      (lambda (el)
	(list (/ (nth 3 el) 33000.0) (nth 1 el) )
      )
    )
    n2[об/мин]_n1[об/мин]_t04[С]_Ne[лс]_nтв[об/мин]_Gt[кг/ч]_dp02[кгс/см^2]
  )
  'n1[Ne_otn]
)

(osr_func
  '(XX YY)
  '((XX XX XX)(XX XX) (XX) (1.0) (YY))
  (mapcar
    (function
      (lambda (el)
	(list (/ (nth 3 el) 33000.0) (nth 2 el) )
      )
    )
    (cdr(cdr(cdr n2[об/мин]_n1[об/мин]_t04[С]_Ne[лс]_nтв[об/мин]_Gt[кг/ч]_dp02[кгс/см^2])))
  )
  't04[Ne_otn]
)

(osr_func
  '(XX YY)
  '((XX XX XX)(XX XX) (XX) (1.0) (YY))
  (mapcar
    (function
      (lambda (el)
	(list (/ (nth 3 el) 33000.0) (nth 4 el) )
      )
    )
    (cdr(cdr(cdr n2[об/мин]_n1[об/мин]_t04[С]_Ne[лс]_nтв[об/мин]_Gt[кг/ч]_dp02[кгс/см^2])))
  )
  'nтв[Ne_otn]
)


;;;	dp02[Ne_otn]
;;;	Gt[Ne_otn]
;;;	n2[Ne_otn]
;;;	n1[Ne_otn]
;;;	t04[Ne_otn]
;;;	nтв[Ne_otn]

(defun Зависимости_от_Neotn ()
  (setq	Neotn_lst (sub_div 0.0 1.1 1100 0)
	Gt_lst	  (mapcar (function Gt[Ne_otn]) Neotn_lst)
	dp02_lst  (mapcar (function dp02[Ne_otn]) Neotn_lst)
	n2_lst	  (mapcar (function n2[Ne_otn]) Neotn_lst)
	n1_lst	  (mapcar (function n1[Ne_otn]) Neotn_lst)
	t04_lst	  (mapcar (function t04[Ne_otn]) Neotn_lst)
	nтв_lst	  (mapcar (function nтв[Ne_otn]) Neotn_lst)
	P...	  (mapcar (function распределение_топлива_и_давления)
			  dp02_lst
			  Gt_lst
		  )
  )
)


(setq assa(mapcar (function (lambda(el1 el2) (list el1 el2))) Neotn_lst Gt_lst))
(setq assa(mapcar (function (lambda(el1 el2) (list el1 el2))) Neotn_lst dp02_lst))
(setq assa(mapcar (function (lambda(el1 el2) (list el1 el2))) Neotn_lst t04_lst))
(setq assa(mapcar (function (lambda(el1 el2) (list el1 el2))) Neotn_lst nтв_lst))
(setq assa(mapcar (function (lambda(el1 el2) (list el1 el2))) Neotn_lst n1_lst))
(setq assa(mapcar (function (lambda(el1 el2) (list el1 el2))) Neotn_lst n2_lst))

(setq assa(mapcar (function (lambda(el1 el2) (list el1 el2))) Neotn_lst (mapcar (function (lambda(el)(nth 0 el) ))p...)))
(setq assa(mapcar (function (lambda(el1 el2) (list el1 el2))) Neotn_lst (mapcar (function (lambda(el)(nth 1 el) ))p...)))
(setq assa(mapcar (function (lambda(el1 el2) (list el1 el2))) Neotn_lst (mapcar (function (lambda(el)(nth 2 el) ))p...)))
(setq assa(mapcar (function (lambda(el1 el2) (list el1 el2))) Neotn_lst (mapcar (function (lambda(el)(nth 5 el) ))p...)))
(setq assa(mapcar (function (lambda(el1 el2) (list el1 el2))) Neotn_lst (mapcar (function (lambda(el)(nth 6 el) ))p...)))