;;;;;;("add_3d_prefix"
;;;;;;"Добавление к именам файлов каталога приставки \"3d_\",
;;;;;; кроме файлов начинающихся с \"am_*\", \"sol_*\", \"dwg_*\", \"3d_*\"."
;;;;;; "not defined")
(defun c:add_3d_prefix	()
  (setq	fn    (getfiled "Выберите файл в каталоге для добавления префикса 3d_" "" "dwg" 1)
	dir   (vl-filename-directory fn)
	f_lst (vl-directory-files dir "*.dwg" 1))
  (mapcar (function (lambda (old_fn / new_fn)
		      (setq new_fn (cond ((wcmatch old_fn "am_*") (strcat "3d_" (substr old_fn 4)))
					 ((wcmatch old_fn "3d_*") (strcat "3d_" (substr old_fn 4)))
					 ((wcmatch old_fn "sol_*") old_fn)
					 ((wcmatch old_fn "dwg_*") old_fn)
					 (t (strcat "3d_" old_fn)))
			    new_fn (strcat dir "\\" new_fn)
			    old_fn (strcat dir "\\" old_fn))
		      (list old_fn new_fn (vl-file-rename old_fn new_fn))))
	  f_lst))
