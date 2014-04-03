(defun redefine_prj(VL_prj_lst)
  (mapcar(function do_redefine_prj) VL_prj_lst)
)

(defun do_redefine_prj (el / fl_prj prj_data prj_files prj_files_new prj_fnm prj_dir)
  (setq	prj_fnm	(nth 0 el)
	prj_dir	(VL-FILENAME-DIRECTORY prj_fnm)
	fl_prj	(open prj_fnm "w")
  )
  (cond
    ((/= 'str (type prj_fnm))
     (alert (princ "Переменная fn не содержит имени файла."
	    )
     )
     
    )
    ((null fl_prj)
     (alert
       (princ
	 (strcat "Не могу открыть файл: " prj_fnm ".")
       )
     )
     (exit)
    )
  )
  (setq	prj_data      (nth 1 el)
	prj_files     (nth 4 prj_data)
	prj_files_new (mapcar (function rename_ru_eng) prj_files)
	prj_files_new
		      (mapcar
			(function
			  (lambda (el)
			    (find_relative_path prj_dir (find_absolute_path prj_dir el))
			  )
			)
			prj_files_new
		      )
	prj_data      (subst prj_files_new prj_files prj_data)
  )
  (print prj_data)
  (print prj_data fl_prj)
  (close fl_prj)
)


























;|«Visual LISP© Format Options»
(135 2 40 2 nil "end of" 100 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
