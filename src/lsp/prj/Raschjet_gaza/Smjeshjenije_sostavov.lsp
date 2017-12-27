(defun смесь[масс.доля_состав] (g_состав[i] / temp g g[i] доли компоненты состав[i])
  (setq	g[i]	   (пересчет_на_доли (mapcar (function car) g_состав[i]))
	состав[i]  (mapcar (function cadr) g_состав[i])
	компоненты (bin_or
		     (apply
		       (function append)
		       (mapcar
			 (function компонент_1...n)
			 (mapcar (function cadr) g_состав[i])
		       )
		     )
		   )
	компоненты (reverse компоненты)
	доли	   (mapcar
		     (function
		       (lambda (g состав)
			 (mapcar (function (lambda (el) (* g (cdr el))))
				 (комп_доля_1...n компоненты состав)
			 )
		       )
		     )
		     g[i]
		     состав[i]
		   )
  )
  (while (car доли)
    (setq temp (append temp (list (apply (function +) (mapcar (function car)доли)))))
    (setq доли (mapcar (function cdr)доли))
  )
  (setq доли temp)
  (mapcar (function cons) компоненты доли)
)
;|«Visual LISP© Format Options»
(72 2 5 2 nil "end of" 60 15 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
