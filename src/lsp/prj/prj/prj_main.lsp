;;;;;;("prj_main"
;;;;;;"Проект предназначен\n
;;;;;;для переименования всех файлов входящих в проект\n
;;;;;;и каталогов в которых они находятся из русской кодировки в латинскую\n
;;;;;;и сохранения путей к файлам проекта в относительном виде.\n
;;;;;;\n
;;;;;;Указания к применению.\n
;;;;;;1) Выполните следующую команду Shell для каталога, содержащего файлы проектов:\n
;;;;;;DIR /S /B *.prj >list_prj\n
;;;;;;2) Выполните команду prj_main. В далоговом окне выберите образованный вновь файл list_prj.\n
;;;;;;В результате выполнения команды на консоль ACAD будет выведен список файлов,\n
;;;;;;содержащий полные имена файлов проектов. Имена фойлов будут заключены в кавычки.
;;;;;;3) Скопируйте имена файлов проектов из консоли ACAD в файл projects.lsp взамен находящегося там списка.
;;;;;;После загрузки projects.lsp файла глобальная переменная g:fn_full_prj_lst должна содержать список проектов.\n
;;;;;;4) Загрузите все файлы проекта rename_vl_prj.prj.\n
;;;;;;5) Выполните в консоли Visual Lisp функцию (make_lst g:fn_full_prj_lst)." "not defined")

(defun c:prj_main (/ fn_list_prj do fl_list_prj path)
  (setq	fn_list_prj (getfiled "Откройте файл, содержащий проекты" (findfile "src/lsp/prj/prj/list_prj") "" 0)
	fl_list_prj (open fn_list_prj "r")
	do t
  )
  (cond
    ((/= 'str (type fn_list_prj))
     (alert (princ "Переменная fn_list_prj не содержит имени файла."
	    )
     )
    )
    ((null fl_list_prj)
     (alert
       (princ
	 (strcat "Не могу открыть файл: " fn_list_prj ".")
       )
     )
     (exit)
    )
  )
  (while (setq path (READ-LINE fl_list_prj))
    (while (/= path (setq path (vl-string-subst "/" "\\"  path)))
    )
    (prin1 path) (princ "\n")
  )
  (close fl_list_prj)
  (princ)
)

(defun path_deep (str)
  (setq	i	0
	str_lst	(vl-string->list str)
  )
  (mapcar
    (function
      (lambda (el)
	(if (or (= (ascii "/") el) (= (ascii "\\") el))
	  (setq i (1+ i))
	)
      )
    )
    str_lst
  )
  (1- i)
)

;;; (find_absolute_path "C:/src/lsp/PRJ/CHtjenije iz Exel" "c:/UTILS/Sistjemy schisljenija" )
(defun find_absolute_path(directory relative_path / directory-lst relative_path-lst)
  (setq
    directory-lst     (devide_file_name directory)
    directory-lst     (reverse directory-lst)
    relative_path-lst (devide_file_name relative_path)
  )
  (cond
    ((VL-STRING-POSITION (ascii ":")(car relative_path-lst))
     (form_fname relative_path-lst)
    )
    (t
      (mapcar
	(function
	  (lambda (el)
	    (cond
	      ((= el ".")
	      )
	      ((= el "..")
	       (setq  directory-lst (cdr directory-lst))
	      )
	      (t
	       (setq directory-lst (cons el directory-lst))
	      )
	    )
	  )
	)
	relative_path-lst
      )
     (form_fname (reverse directory-lst))
    )
  )
)


;;; (devide_file_name "../../UTILS/Sistjemy schisljenija")
;;; Производит разделение пути на составляющие.
(defun devide_file_name	(filename / do str-lst base base_ext dir ext)
  (setq do t)
  (while do
    (setq
      base     (vl-filename-base filename)
      ext      (vl-filename-extension filename)
      ext      (if (null ext)
		 ""
		 ext
	       )
      dir      (VL-FILENAME-DIRECTORY filename)
      base_ext (strcat base ext)
    )
    (cond
      ((/= base_ext "")
       (setq str-lst (cons base_ext str-lst))
       (setq filename dir)
      )
      ((and (= base_ext "") (/= dir ""))
       (setq str-lst (cons (substr dir 1 (1- (strlen dir))) str-lst))
       (setq do nil)
      )
      ((= dir "")
       (setq filename dir
	     do	nil
       )
      )
    )
  )
  str-lst
)




;;; (FIND_RELATIVE_PATH "C:/src/lsp/PRJ/CHtjenije iz Exel" "c:/src/lsp/UTILS/Sistjemy schisljenija")
(defun find_relative_path (directory full_path / el_lst prj_fnm_lst str_fn)
  (setq
    el_lst (devide_file_name full_path)
  )
  (setq prj_fnm_lst (devide_file_name directory))
  (while (and prj_fnm_lst (= (STRCASE (car prj_fnm_lst)) (STRCASE (car el_lst))))
    (setq prj_fnm_lst (cdr prj_fnm_lst)
	  el_lst      (cdr el_lst)
    )
  )
  (setq str_fn "")
  (mapcar
    (function
      (lambda (el)
	(setq str_fn (strcat str_fn "../"))
      )
    )
    prj_fnm_lst
  )
  (mapcar
    (function
      (lambda (el)
	(setq str_fn (strcat str_fn el "/"))
      )
    )
    el_lst
  )
  (substr str_fn 1 (1- (strlen str_fn)))
)