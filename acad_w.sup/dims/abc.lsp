;;;	index:abc() задает сторку из символов, допускаемых дл€
;;;	обозначени€ баз видов и сечений и поверхностей на чертеже √ќ—“ 2.316 п. 18.
(defun index:abc  (/ abc_str)
  (setq abc_str (vlax-ldata-get "index" "abc" "ru"))
  (cond	((= abc_str "ru") "јЅ¬√ƒ≈∆«» ЋћЌѕ–—“”‘÷„ЎўЁёя")
	((= abc_str "en") "ABCEFGHKMNPQSTW")
	(t "јЅ¬√ƒ≈∆«» ЋћЌѕ–—“”‘÷„ЎўЁёя")))
;;;	ѕроизводит сбрасывание индекса в начальное значение
;;;	
(defun index:0	()
  (setq last_index (list 1 0))
  (vlax-ldata-get "index" "last_index" last_index))
(defun index:getlast  ()
  (cond	((null last_index) (index:0))
	(t last_index)))
(defun index:abc_len () (strlen (index:abc)))

(defun index:++	 (/ index_A index_0)
  (setq	last_index (index:getlast)
	index_A	   (car last_index)
	index_0	   (cadr last_index))
  (cond	((< index_A (index:abc_len)) (setq index_A (1+ index_A)))
	((>= index_A (index:abc_len))
	 (setq index_A 1
	       index_0 (1+ index_0))))
  (setq last_index (list index_A index_0))
  (vlax-ldata-put "index" "last_index" last_index))

(defun index:string  (/ index_A index_0)
  (setq	last_index (index:getlast)
	index_A	   (car last_index)
	index_0	   (cadr last_index))
  (if (= index_0 0)
    (substr (index:abc) index_A 1)
    (strcat (substr (index:abc) index_A 1) "&A&B" (itoa index_0))))

	       ;(substr  (index:abc) (index:abc_len)  1)

(defun index:add  ()
  (cond	((null index:list) (setq index:list (cons (index:getlast) index:list)) (index:++))
	(t (setq index:list (cons (index:++) index:list)))))

(defun index:clear () (setq index:list nil) (index:0))
