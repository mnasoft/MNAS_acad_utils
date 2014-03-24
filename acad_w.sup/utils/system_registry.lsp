	       ;(vl-registry-write "HKEY_CURRENT_USER\\MNASoft\\format" "key" "(list \"qwe\" \"asdf\")")
	       ;(VL-REGISTRY-DELETE "HKEY_CURRENT_USER\\MNASoft\\format" "key" )
	       ;(vl-registry-read "HKEY_CURRENT_USER\\MNASoft\\format" "key")

;;;f;;;("print-to-string" "Производит вывод цитируемого значения $val в строку,
;;;f;;;в виде пригодном для последующего восстановдения значения функцией load-from-string.
;;;f;;;
;;;f;;;(setq value 1.0) (print-to-string 'value)
;;;f;;;1.0
;;;f;;;(setq VALUE '1.0)")

(defun print-to-string	($val)
  (strcat "(setq " (vl-prin1-to-string $val) " '" (vl-prin1-to-string (eval $val)) ")"))

;;;("load-from-string" "(setq value nil)
;;;(load-from-string "(setq VALUE '1.0)") value")
(defun load-from-string (str) (eval (read str)))

(defun reg_read	 (root $val default)
  (setq tmp (vl-registry-read root (vl-prin1-to-string $val)))
  (if tmp
    (load-from-string tmp)))

(defun reg_read_default	 (root $val default / tmp)
  (set $val nil)
  (if (setq tmp (vl-registry-read root (vl-prin1-to-string $val)))
    (load-from-string tmp))
  (if (null (eval $val))
    (set $val default)
    (eval $val)))

;;;(defun value-list-multiplier  (value lst / len value_lst)
;;;  (setq len (length lst))
;;;  (while (>= (setq len (1- len)) 0) (setq value_lst (cons value value_lst))))

;;;(defun reg_read_lst  (root lst)
;;;  (mapcar (function (lambda (el) (reg_read root (car el) (cadr el)))) lst))
(defun reg_read_lst  (root lst / len root_lst)
  (mapcar (function (lambda (rt el) (reg_read rt (car el) (cadr el))))
	  (value-list-multiplier root lst)
	  lst))

;;;(setq reg_root	   "HKEY_CURRENT_USER\\Software\\MNASoft\\Demo"
;;;      rgb_registry '((code_val (("eb_1_2" . "0") ("eb_1_3" . "1"))) (code_val_1 (("1_2" . "0") ("1_3" . "1")))))
;;;(reg_read_default_lst reg_root rgb_registry)
;;;(reg_write_default_lst reg_root rgb_registry)

(defun reg_read_default_lst  (root lst)
  (mapcar (function (lambda (rt el) (reg_read_default rt (car el) (cadr el))))
	  (value-list-multiplier root lst)
	  lst))

(defun reg_write  (root $val default) ; По просьбе Давлеткужина
  (vl-registry-write root (vl-prin1-to-string $val) (print-to-string $val)))

(defun reg_write_lst  (root lst) ; По просьбе Давлеткужина
  (mapcar (function (lambda (rt el) (reg_write rt (car el) (cadr el))))(value-list-multiplier root lst) lst))

(defun reg_write_default  (root $val default)
  (if (null (eval $val))
    (set $val default))
  (vl-registry-write root (vl-prin1-to-string $val) (print-to-string $val)))

;;;(reg_write_default_lst "HKEY_CURRENT_USER\\MNASoft" '((P_START (0.0 0.0 0.0)) (SHT1_VAL ("Устройство горелочное" "В2М80009993СБ" "Дораб.черт. Н80038002СБ" "" "" "" "" "1:1" "" "1" "ЖАКИ" "Нач отд" "Матвеев   " "Матвеев   " "Дунаев   " "Ванцовский" "Матвеев   " "Спицын   " "" "")) (F_NO 0) (KR_NO 0) (FOR_NO 1) (DIR_SHT 1) (DIVZONE_NO 1) (ZONE_CH 65) (ZONE_DIG 1)))
(defun reg_write_default_lst  (root lst)
  (mapcar (function (lambda (rt el) (reg_write_default rt (car el) (cadr el))))
	  (value-list-multiplier root lst)
	  lst))