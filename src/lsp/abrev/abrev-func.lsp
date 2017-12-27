;;;; abrev-func.lsp

(defun select-all-past-ename  (el / ss ed)
  (setq ss (ssadd))
  (while (and el (setq el (entnext el)))
    (setq ed (entget el))
    (if (= "INSERT" (cdr (assoc 0 ed)))
    (setq ss (ssadd el ss))))
  ss)

(defun explode-all  (ss / i)
  (setq i (sslength ss))
  (while (>= (setq i (1- i)) 0) (vl-cmdf "_.explode" (ssname ss i) "")))
