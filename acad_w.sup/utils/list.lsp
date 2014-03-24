(defun value-list-multiplier  (value lst / len value_lst)
  (setq len (length lst))
  (while (>= (setq len (1- len)) 0) (setq value_lst (cons value value_lst))))

(defun not-nil-list-element  (lst / len value value_lst)
  (setq len (length lst))
  (while (>= (setq len (1- len)) 0)
    (if	(setq value (nth len lst))
      (setq value_lst (cons value value_lst))))value_lst)