;;;;;;("pur" "Очистка всех неиспользуемых элементов из секции таблиц." "Аббревиатуры")
(defun c:save-view (/ v-name)
  (setq v-name (cdr (assoc 1 (entget(car(entsel "Выберите текст для обозначения вида:"))))))
  (command "_view" "_w" v-name))
