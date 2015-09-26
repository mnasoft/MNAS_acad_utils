;;	get_dxf (name code) 	- Извлекает информацию о dxf-кодах примитива.
(defun get_dxf (name code) (cdr (assoc code (entget name))))

;;	dxf-get (code dxf_list)	- Извлекает информацию о dxf-коде code из списка dxf_list.
(defun dxf-get (code dxf_list) (cdr (assoc code dxf_list)))

;;	dxf-get-list (code-list dxf_list)
;; Извлекает информацию о dxf-кодах code-list из списка dxf_list.
;; Если значения, связанные с кодами, имеют значение nil то они в результат не включаются.
(defun dxf-get-list  (code-list dxf_list / rez-list a_code len lst value_lst)
  (setq len (length dxf_list))
  (while (>= (setq len (1- len)) 0)
    (if (setq a_code (assoc (nth len code-list) dxf_list))
      (setq value_lst (cons a_code value_lst))))
  value_lst)

;;	dxf-set (code val dxf_list)
;; Заменяет информацию о dxf-коде  из списка dxf_list, связанную с code, значением val.
(defun dxf-set (code val dxf_list) (subst (cons code val) (assoc code dxf_list) dxf_list))

;;	ch_dxf(name code new_val)	- Изменяет информацию в dxf-коде примитива на новое значение.
(defun ch_dxf  (name code new_val / edata li)
  (setq edata (entget name))
  (setq li (subst (cons code new_val) (assoc code edata) edata))
  (entmod li))

;;;dsubst(data ndata)		- Изменяет или добавляет данные data данными ndata.
(defun dsubst  (edata list_new / len code lst_el data_code)
  (setq len (length list_new))
  (while (>= (setq len (1- len)) 0)
    (setq lst_el    (nth len list_new)
          code      (car lst_el)
          data_code (assoc code edata)
          edata     (cond (data_code (subst lst_el (assoc code edata) edata))
                          ((null data_code) (append edata (list lst_el)))))))

(defun subst_dxf  (list_new edata / len code lst_el)
  (setq len (length list_new))
  (while (>= (setq len (1- len)) 0)
    (setq lst_el (nth len list_new)
          code   (car lst_el)
          edata  (subst lst_el (assoc code edata) edata))))
