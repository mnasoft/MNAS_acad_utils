(setq utils-locale "uk");; ru, uk

;;;f;;; ("utils-locale-string (key-strings default)"
;;;f;;;  "Возвращает строку, соответствующую действующей локали.\n
;;;f;;;    Аргументы:\n
;;;f;;;    key-strings  - точки;\n
;;;f;;;    default     - значение по умолчанию.\n
;;;f;;;    Пример использования:\n
;;;f;;; _$ (utils-locale-string '((\"ua\" \"Альбомна\") (\"ru\" \"Альбомная\")) \"Landscape\")\n
;;;f;;; ")

(defun utils-locale-string (key-strings default)
  (cond
    ((cadr (assoc utils-locale key-strings)))
     (t default)))

(defun utils-locale-data (key-data default)
  (cond
    ((cadr (assoc utils-locale key-data)))
     (t default)))
