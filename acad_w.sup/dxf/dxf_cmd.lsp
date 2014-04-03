;;;;;;("obj" "Возвращает данные выбранного примитива." "Объекты")
(defun c:obj  ()
  (setq obj (entget (car (entsel "\nВыберите примитив:"))))
  (vl-doc-set 'obj obj))

;;;;;;("nobj" "Возвращает данные выбранного подпримитива." "Объекты")
(defun c:nobj  ()
  (setq nobj (entget (car (nentsel "\nВыберите примитив:"))))
  (vl-doc-set 'nobj nobj))

;;;;;;("objxd"
;;;;;;"Возвращает данные и расширенные данные выбранного примитива." "Объекты")
(defun c:objxd	()
  (setq objxd (entget (car (entsel "\nВыберите примитив:")) (list "*")))
  (vl-doc-set 'objxd objxd))

;;;;;;("nobjxd"
;;;;;;"Возвращает данные и расширенные данные выбранного подпримитива." "Объекты")
(defun c:nobjxd	 ()
  (setq nobjxd (entget (car (nentsel "\nВыберите примитив:")) (list "*")))
  (vl-doc-set 'nobjxd nobjxd))
