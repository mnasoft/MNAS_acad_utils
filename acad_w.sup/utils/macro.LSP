(defun macro-mapcar  (mc-lst / body lam lam-body lsts)
  (setq lam-body (cddr (cadadr mc-lst))
        lam      (car (cadadr (nth 1 mc-lst)))
        lsts     (car (cddr mc-lst))
        body     (list 'progn
                       (list 'setq 'lst lsts 'lst-len '(length lst) 'lst-i -1)
                       (list 'while
                             (list '< (list 'setq 'lst-i (list '1+ 'lst-i)) 'lst-len)
                             (list 'setq 'el '(nth lst-i lst) 'lst-rez (list 'cons (cons 'progn lam-body) 'lst-rez)))
                       '(setq lst-rez (reverse lst-rez))))
  body)

(setq *checked-prj* (list "abrev" "acad_pgp" "add_prefix" "axis")
(setq *skip-prj* (list "atoms"))