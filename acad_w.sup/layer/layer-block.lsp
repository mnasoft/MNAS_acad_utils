;;;;;;("bl_off"
;;;;;;"Выключает слой, входящий в блок, при указании на объект в составе блока." "Слои")
(defun c:bl_off	(/ la)
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (setq	la
	 (cdr
	   (assoc 8
		  (entget
		    (car
		      (nentsel
			"\nВыберите элемент блока, слой которого будет выключен:"
		      )
		    )
		  )
	   )
	 )
  )
  (COMMAND "-layer" "off" la)
  (if_cmd_active)
  (err-handle "")
)


;;;;;;("bl_fr"
;;;;;;  "Замораживает слой, входящий в блок, при указании на объект в составе блока." "Слои")
(defun c:bl_fr (/ la)
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (setq	la
	 (cdr
	   (assoc 8
		  (entget
		    (car
		      (nentsel
			"\nВыберите элемент блока, слой которого будет заморожен:"
		      )
		    )
		  )
	   )
	 )
  )
  (COMMAND "-layer" "fr" la)
  (if_cmd_active)
  (err-handle "")
)

;;;;;;("bl_all_on" "Включает все слои, входящие в состав блока." "Слои")
(defun c:bl_all_on (/ bl_name ed ed_tbl en en_1 la la_lst)
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (setq str (bl_all))
  (COMMAND "-layer" "on" str)
  (if_cmd_active)
  (err-handle "")
)

;;;;;;("bl_all_th" "Размораживает все слои, входящие в состав блока." "Слои")
(defun c:bl_all_th (/ str)
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (setq str (bl_all))
  (COMMAND "-layer" "thaw" str)
  (if_cmd_active)
  (err-handle "")
)

;; Возвращает список слоев присутствующих в элементах, указываемого блока.
(defun bl_all (/ bl_name ed ed_tbl en en_1 la la_lst)
  (setq
    en	    (car (entsel "Выберите блок:"))
    ed	    (entget en)
    bl_name (cdr (assoc 2 ed))
    ed_tbl  (tblsearch "block" bl_name)
    en_1    (cdr (assoc -2 ed_tbl))
  )
  (while en_1
    (setq
      la     (cdr (assoc 8 (entget en_1)))
      la_lst (cons la la_lst)
      en_1   (entnext en_1)
    )
  )
  (setq la_lst (bin_or la_lst))
  (str_comma la_lst ",")
)

;; Создает из списка символьных строк lst строку, состоящую из этих строк
;; между которыми находятся разделительные строки comma.
;; Например:
;; (str_comma '("layer1" "2" "3" ) ",")
;; "layer1,2,3"
(defun str_comma (lst comma / str)
  (setq str (car lst))
  (mapcar
    (function
      (lambda (el)
	(setq str (strcat str comma el))
      )
    )
    (cdr lst)
  )
  str
)
