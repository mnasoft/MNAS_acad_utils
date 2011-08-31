(vl-load-com)
(setq axis-default-value
       '(("start" . 0.0)
	 ("end" . 100.0)
	 ("type" . 0)
	 ("title" . "Íîâàÿ øêàëà")
	)
)

       

(vlax-ldata-put (car (entsel  "")) "shkala" axis-default-value)


(vlax-ldata-get (car (entsel  "")) "shkala")
(vlax-ldata-delete (car (entsel  "")) "shkala")
(vlax-ldata-list (car (entsel  "")) )
(vlax-ldata-test (car (entsel  "")))













;|«Visual LISP© Format Options»
(105 2 17 2 nil "end of" 90 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
