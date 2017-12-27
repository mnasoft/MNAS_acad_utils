;;;s;;;("axis:point-type-current"
;;;s;;;"Переменная, которая хранит номер предыдущий текущему блоку с изображением точки на графике.
;;;s;;;- axis:point-type;
;;;s;;;- axis:point-type-name;
;;;s;;;- axis:point-type-reset.")
(setq axis:point-type-current -1)

;;;s;;;("axis:point-type"
;;;s;;;"Переменная, содержит имена блоков, предназначенных для отображения точек на графиках.
;;;s;;;Используется совместно с:
;;;s;;;- axis:point-type-current;
;;;s;;;- axis:point-type-name;
;;;s;;;- axis:point-type-reset.")
(setq axis:point-type
       '("ci-01"    "tr-01"    "re-01"    "ro-01"    "ap-01"    "as-07"    "rm-01"    "pp-01"
         "ps-01"    "ci-02"    "ch-01"    "ch-02"    "tr-02"    "re-02"    "ro-02"    "ap-02"
         "as-02"    "rm-02"    "pp-02"    "ps-02"    "re-03"    "ro-03"    "ap-03"    "ap-04"
         "as-03"    "as-04"    "rm-03"    "rm-04"    "rm-05"    "ch-04"    "ap-05"    "as-05"
         "as-06"    "as-01"    "ci-03"    "ch-03"    "ci-04"    "cr-01"    "cr-02"    "cr-03"
         "ct-01"    "ct-02"    "ct-03"    "cl-01"    "cl-02"    "cl-03"    "cb-01"    "cb-02"
         "cb-03"))

;;;f;;;("load-point-types"
;;;f;;;"Выполняет вставку в текущий чертеж файла Point-Types,
;;;f;;;который содержит определения блоков, спользуемых как маркеры точек.")
(defun axis:load-point-types	()
  (command "_-insert" "./src/lsp/Point-Types.dwg")
  (command)
  (command "_-purge" "_b" "Point-Types" "_n"))

(defun axis:point-type-name (/ b-lst eb)
 (setq b-lst nil
	     eb	   (TBLNEXT "BLOCK" t))
       (while eb
	 (setq b-lst (cons eb b-lst))
	 (setq eb (TBLNEXT "BLOCK")))
       (mapcar (function (lambda (el) (cdr (assoc 2 el)))) (reverse b-lst)))

(defun axis:point-type-reset () (setq axis:point-type-current -1))

(defun axis:point-type-next  (/ rez)
  (setq axis:point-type-current
         (1+ axis:point-type-current)
        axis:point-type-current
         (if (< axis:point-type-current (length axis:point-type))
           axis:point-type-current
           -1)
        rez (nth axis:point-type-current axis:point-type)))