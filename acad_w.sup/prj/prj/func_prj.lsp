;;; Центровая функция проекта.
;;;(make_lst g:fn_full_prj_lst)
(defun make_lst	(fn_full_prj_lst	;
		 /			;
		 VL_prj_lst		;
		 renamed		; Список переименованных файлов
		 renamed_exp		;
		 renaming		; Список файлов для переименования
		 renaming_exp		;
		 comb_lst		;
		 rez_comb_lst		; Список с файлами для переименования
)
  (setq	VL_prj_lst   (get_VL_prj_data fn_full_prj_lst)
	renamed	     (get_renamed_fn VL_prj_lst)
	renamed_exp  (explode_path renamed)
	renaming     (get_fn_for_renaming VL_prj_lst)
	renaming_exp (explode_path renaming)
	comb_lst     (mapcar (function (lambda (el1 el2) (list (length el1) el1 el2))) renaming_exp renamed_exp)
	comb_lst     (VL-SORT comb_lst (function is_less))
	comb_lst     (del_dublicats comb_lst)
	comb_lst     (del_non_renaming comb_lst)
	rez_comb_lst (append rez_comb_lst (reverse comb_lst))
  )
  (while comb_lst
    (setq comb_lst     (del_last_fn comb_lst)
	  comb_lst     (del_dublicats comb_lst)
	  comb_lst     (del_non_renaming comb_lst)
	  rez_comb_lst (append rez_comb_lst (reverse comb_lst))
    )
  )
  (redefine_prj VL_prj_lst)
  (rename_files rez_comb_lst)
  (princ)
)

;;; Производит считывание файла проекта VLISP.
;;; Возвращает список с данными о проекте VLISP.
(defun read_prj_items
		      (fn_prj		; полное имя файла-проекта
		       / FL_PRJ		; дескриптор открываемого файла-проекта
		       STR_LINE		; строка, считываемая из файла-проекта
		       STR_REZ		;результирующая строка
)
  (setq	fl_prj	(open fn_prj "r")
	str_rez	""
  )
  (cond
    ((/= 'str (type fn_prj))
     (alert (princ "Переменная fn_prj не содержит имени файла."
	    )
     )
     
    )
    ((null fl_prj)
     (alert
       (princ
	 (strcat "Не могу открыть файл: " fn_prj ".")
       )
     )
     (exit)
    )
  )
  (while (setq str_line (read-line fl_prj))
    (setq str_line (vl-string-left-trim " 	" str_line))
    (if	(/= ";" (substr str_line 1 1))
      (setq str_rez (strcat str_rez str_line " "))
    )
  )
  (close fl_prj)
  (read str_rez)
)


;;;"C:/acad_w.sup/ЮЛЯ/УСАДКИ/USADKA.PRJ"
;;;(build_list_of_lsp_files "C:/acad_w.sup/ЮЛЯ/УСАДКИ/USADKA.PRJ")
;;;(build_list_of_lsp_files "C:/acad_w.sup/ABREV/ABREV.PRJ")
(defun build_list_of_lsp_files (fn_prj / vl_prj ; Список проекта  проекта
				lst_file_name ; Список файлов в проекте
				lst_file_renamed ; Список переименованых файлов
				dir_prj	; Путь к файлу проекта
)
  (setq vl_prj (read_prj_items fn_prj))
  (setq lst_file_name (nth 4 vl_prj))
  (setq dir_prj (VL-FILENAME-DIRECTORY fn_prj))
  (setq	lst_file_name
	 (mapcar
	   (function
	     (lambda (el / file_dir file_name file_ext)
	       (setq file_dir  (VL-FILENAME-DIRECTORY el)
		     file_name (VL-FILENAME-BASE el)
		     file_ext  (VL-FILENAME-EXTENSION el)
	       )
	       (cond
		 ((= file_dir "")
		  (setq file_dir dir_prj)
		 )
		 ((and (>= (strlen file_dir) 3)
		       (= (substr file_dir 1 3) "../")
		  )
		  (setq file_dir (strcat dir_prj (substr file_dir 3)))
		 )
	       )
	       (setq file_ext
		      (cond
			((null file_ext)
			 ".lsp"
			)
			((= "." file_ext) "")
			(file_ext)
		      )
	       )
	       (strcat file_dir "/" file_name file_ext)
	     )
	   )
	   lst_file_name
	 )
  )
  (setq lst_file_renamed (mapcar (function rename_ru_eng) lst_file_name))
  (list fn_prj (subst lst_file_renamed lst_file_name vl_prj) lst_file_name lst_file_renamed)
)

;;;(explode_filename "C:/acad_w.sup/Add_prefix/Add_prefix.lsp")
(defun explode_filename	(filename / dir_list do file_dir file_name)
  (setq do t)
  (while do
    (setq file_dir  (VL-FILENAME-DIRECTORY filename)
	  file_name (strcat (VL-FILENAME-BASE filename)
			    (cond
			      ((VL-FILENAME-EXTENSION filename))
			      ("")
			    )
		    )
    )
    (cond
      ((= file_name "")
       (setq do nil)
       (setq dir_list (cons file_dir dir_list))
      )
      (t
       (setq filename file_dir)
       (setq dir_list (cons file_name dir_list))
      )
    )
  )
  dir_list
)

;;;(get_VL_prj_data g:fn_full_prj_lst)
;;;Выдает список с данными о проектах
(defun get_VL_prj_data (fn_full_prj_lst)
  (mapcar (function build_list_of_lsp_files) fn_full_prj_lst)
)

;;;Выдает список всех переименуемых файлов в проектах
;;;(get_renamed_fn g:fn_full_prj_lst)
(defun get_renamed_fn (VL_prj_lst)
  (apply (function append) (mapcar (function cadddr) VL_prj_lst))
)
;;;(get_fn_for_renaming VL_prj_lst)
(defun get_fn_for_renaming (VL_prj_lst)
  (apply (function append) (mapcar (function caddr) VL_prj_lst))
)

;;; Удаляет дубликаты для совпадающих элементов списка
(defun del_dublicats (lst		;
		      /			;
		      lst_res		;
		      curr_el		;
		      i_el		;
		      len_lst		;
)
  (setq
    len_lst (length lst)
    curr_el (nth 0 lst)
    lst_res (append lst_res (list curr_el))
    i	    1
  )
  (while (< i len_lst)
    (setq i_el (nth i lst))
    (if	(null (is_equal curr_el i_el))
      (setq lst_res (append lst_res (list i_el))
	    curr_el i_el
      )
    )
    (setq i (1+ i))
  )
  lst_res
)

(defun del_non_renaming	(lst		;
			 /		;
			 rez_lst
			)
  (mapcar
    (function
      (lambda (el)
	(if (is_renaming el)
	  (setq rez_lst (append rez_lst (list el)))
	)
	t
      )
    )
    lst
  )
  rez_lst
)


(defun is_renaming (el			;
		    /			;
		    resval		;
		   )
  (setq
    str1 (strcase (form_fname (cadr el)))
    str2 (strcase (form_fname (caddr el)))
  )
  (cond
    ((/= str1 str2)
     (setq resval t)
    )
  )
  resval
)


;;;(explode_path g:fn_full_prj_lst)
(defun explode_path (lst) (mapcar (function explode_filename) lst))

;;;(form_fname '("C:/" "acad_w.sup" "ABREV" "Текстовый документ"))
;;;"C:/acad_w.sup/ABREV/Текстовый документ"
(defun form_fname (list_exp / str)
  (setq str (substr (car list_exp) 1 2))
  (mapcar (function (lambda (el) (setq str (strcat str "/" el)) t)) (cdr list_exp))
  str
)

(defun is_equal	(el1 el2 / resval str1 str2)
  (setq
    str1 (strcase (form_fname (cadr el1)))
    str2 (strcase (form_fname (cadr el2)))
  )
  (cond
    ((= str1 str2)
     (setq resval t)
    )
  )
  resval
)

(defun is_less (el1 el2 / resval str1 str2)
  (setq
    str1 (strcase (form_fname (cadr el1)))
    str2 (strcase (form_fname (cadr el2)))
  )
  (cond
    ((< (car el1) (car el2))
     (setq resval t)
    )
    ((and (= (car el1) (car el2))
	  (= str1 str2)
     )
     (setq resval nil)
    )
    ((and (= (car el1) (car el2))
	  (< str1 str2)
     )
     (setq resval t)
    )
  )
  resval
)


;;; Удаление имени из пути
(defun del_last_fn (lst			;
		    /			;
		   )
  (mapcar (function do_delete) lst)
)

(defun do_delete (el			;
		  /			;
		  len			;
		  lst_old		;
		  lst_new		;
)
  (setq	len	(car el)
	lst_old	(cadr el)
	lst_new	(caddr el)
  )
  (if (> len 1)
    (setq len	  (1- len)
	  lst_old (reverse (cdr (reverse lst_old)))
	  lst_new (reverse (cdr (reverse lst_new)))
    )
  )
  (list len lst_old lst_new)
)
 