;;;(princ "\nЗагружаю utils/dxf           ")
(princ (strcat "\nЗагружаю " (acad_sup) "/" "utils/dxf           "))

;;	get_dxf (name code) 	- Извлекает информацию о dxf-кодах примитива.
(defun get_dxf (name code)
  (cdr (assoc code (entget name)))
)

;;	dxf-get (code dxf_list)	- Извлекает информацию о dxf-коде code из списка dxf_list.
(defun dxf-get ( code dxf_list)
  (cdr (assoc code dxf_list))
)

;;	dxf-get-list (code-list dxf_list)
;; Извлекает информацию о dxf-кодах code-list из списка dxf_list.
;; Если значения, связанные с кодами, имеют значение nil то они в результат не включаются.
(defun dxf-get-list (code-list dxf_list / rez-list) 
  (mapcar
    (function
      (lambda (code / cd cd-val)
	(setq cd-val   (dxf-get code dxf_list)
	      rez-list (if cd-val
			 (cons (cons code cd-val) rez-list)
			 rez-list
		       )
	)
	t
      )
    )
    code-list
  )
  rez-list
)


;;	dxf-set (code val dxf_list)
;; Заменяет информацию о dxf-коде  из списка dxf_list, связанную с code, значением val.
(defun dxf-set ( code val dxf_list)
  (subst (cons code val)(assoc code dxf_list) dxf_list)
)

;;	ch_dxf(name code new_val)	- Изменяет информацию в dxf-коде примитива на новое значение.
(defun ch_dxf (name code new_val / edata li)
  (setq edata (entget name))
  (setq li (subst (cons code new_val) (assoc code edata) edata))
  (entmod li)
)

;;	dsubst(data ndata)		- Изменяет или добавляет данные data данными ndata.
(defun dsubst (data ndata / add_data)
  (mapcar
    (function
      (lambda
	(el / d1)
	 (setq d1 (assoc (car el) data))
	 (cond
	   (
	    d1
	    (setq data (subst el d1 data))
	   )
	   (
	    (null d1)
	    (setq add_data (cons el add_data))
	   )
	 )
	 nil
      )
    )
    ndata
  )
  (append data (reverse add_data))
)

(defun subst_dxf (list_new edata)
  (mapcar
    (function
      (lambda (el / code)
	(setq
	  code	(car el)
	  edata	(subst el (assoc code edata) edata)
	)
      )
    )
    list_new
  )
  edata
)
(princ "\t...загружен.\n")
