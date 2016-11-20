;;	str_token(str div)
;;	Разбивает строку str на список подстрок по символам- разделителям
;;	находящимся в строке div. Символы-разделители исключаются из строки.
;;	(str_token "55.050 5.05 5650.05 07.0 " " .")
;;	("55" "050" "5" "05" "5650" "05" "07" "0")
(defun str_token  (token-str div / add i k s1 d1 stmp lstr)
  (setq i    0
        stmp "")
  (repeat (strlen token-str)
    (setq i   (1+ i)
          s1  (substr token-str i 1)
          k   0
          add t)
    (repeat (strlen div)
      (setq k  (1+ k)
            d1 (substr div k 1))
      (if (= s1 d1)
        (setq add nil)))
    (if add
      (setq stmp (strcat stmp s1))
      (progn (if (/= stmp "")
               (setq lstr (cons stmp lstr)))
             (setq stmp ""))))
  (if (/= stmp "")
    (setq lstr (cons stmp lstr)))
  (reverse lstr))

(defun get-locale  ()
  ;; Возвращает локаль, запущенного сеанса AutoCAD
  (last (str_token (getvar "LOCALROOTPREFIX") "\\")))

(defun get-localized-message  (lst)
  ;; Возвращает строку, на языке соответствующей локали
  ;; Пример использования:
  ;; (get-localized-message '(("enu" . "File is not") ("rus" . "Файл не")))
  (cdr (assoc (get-locale) lst)))

(defun g-l-m  (lst)
  ;; Возвращает строку, на языке соответствующей локали
  ;; Пример использования:
  ;; (g-l-m '(("enu" . "File is not") ("rus" . "Файл не")))
  (get-localized-message lst))

(defun r-e-m  (string-rus string-enu)
  ;; Возвращает строку, на языке соответствующей локали
  ;; Пример использования:
  ;; (r-e-m  "Файл не" "File is not")
  (get-localized-message (list (cons "rus" string-rus) (cons "enu" string-enu))))

(defun e-r-m  (string-enu string-rus)
  ;; Возвращает строку, на языке соответствующей локали
  ;; Пример использования:
  ;; (e-r-m  "File is not" "Файл не")
  (get-localized-message (list (cons "enu" string-enu) (cons "rus" string-rus))))

(defun string-subst-all  (new-str pattern string / do)
  (setq do t)
  (while do
    (setq str-rez (vl-string-subst new-str pattern string))
    (if (/= str-rez string)
      (setq string str-rez)
      (setq do nil)))
  string)
