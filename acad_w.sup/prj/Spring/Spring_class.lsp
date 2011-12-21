(defun get(key)
  (setq tmp (atof(get_tile key)))
  (set_tile key (rtos tmp))
  tmp
)

(defun D1()
  (get_tile "d"
)