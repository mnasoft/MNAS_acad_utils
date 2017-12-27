;;	sub_div (at-min at-max an a-fl) - ���������� ��������� ��������� [t_min;t_max]
;;		�� an  �����������.
;;	a-fl = 0 ��� �������� �����.
;;	a-fl = 1 ��� ��������������� �����.
(defun sub_div  (at-min at-max an a-fl / a-i a-l_pts a-tt)
  (setq a-i an)
  (while (>= a-i 0)
    (cond ((= a-fl 0) (setq a-tt (+ at-min (/ (* a-i (- at-max at-min)) an))))
          ((= a-fl 1) (setq a-tt (* at-min (exp (/ (* (log (/ at-max at-min)) a-i) an))))))
    (setq a-l_pts (cons a-tt a-l_pts))
    (setq a-i (1- a-i)))
  a-l_pts)

(defun sub-div-n  (an / a-i lst)
  (setq a-i 1)
  (setq lst nil)
  (while (<= a-i an) (setq lst (append lst (list a-i))) (setq a-i (1+ a-i)))
  lst)