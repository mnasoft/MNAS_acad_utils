(defun rename_files (rez_comb_lst)
  (mapcar (function do_rename) rez_comb_lst)
)

;;;Производит переименование файлов, содержащихся в списке переименования
(defun do_rename (el / fn_from fn_to dir_nm)
  (setq fn_from	(form_fname (cadr el))
	dir_nm (get_pathnm fn_from)
	fn_to	(strcat dir_nm(GET_FILENM+EXT(form_fname (caddr el))))
  )
  (vl-file-rename  fn_from  fn_to)
)

;;;(get_filenm+ext "C:/acad_w.sup/Add_prefix/Add_prefix.lsp")
(defun get_filenm+ext (str)
  (setq
    fnm	(cond
	  ((VL-FILENAME-BASE str))
	  ("")
	)
    ext	(cond
	  ((VL-FILENAME-EXTENSION str))
	  ("")
	)
  )
  (strcat fnm ext)
)

;;;(get_pathnm "C:/acad_w.sup/PRJ/prj/func_prj.lsp")
;;;(get_pathnm "C:/acad_w.sup")
(defun get_pathnm (str)
  (setq
    pathnm	(VL-FILENAME-DIRECTORY str)
  )
  (cond
    ((= 3 (strlen pathnm)) pathnm)
    (t (strcat pathnm "/"))
  )
)
