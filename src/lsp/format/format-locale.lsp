(setq format:locale "uk");; ru, uk

;;;f;;; ("format:locale-string (key-strings default)"
;;;f;;;  "Возвращает строку, соответствующую действующей локали.\n
;;;f;;;    Аргументы:\n
;;;f;;;    key-strings  - точки;\n
;;;f;;;    default     - значение по умолчанию.\n
;;;f;;;    Пример использования:\n
;;;f;;; _$ (format:locale-string '((\"ua\" \"Альбомна\") (\"ru\" \"Альбомная\")) \"Landscape\")\n
;;;f;;; ")

(defun format:locale-string (key-strings default)
  (cond
    ((cadr (assoc format:locale key-strings)))
     (t default)))

(defun format:locale-data (key-data default)
  (cond
    ((cadr (assoc format:locale key-data)))
     (t default)))
