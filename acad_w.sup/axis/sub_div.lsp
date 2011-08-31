;;	sub_div (t-min t-max n fl) - ���������� ��������� ��������� [t_min;t_max]
;;		�� n  �����������.
;;	fl = 0 ��� �������� �����.
;;	fl = 1 ��� ��������������� �����.
(defun sub_div (t-min t-max n fl / i l_pts tt)
  (setq i n)
  (while (>= i 0)
    (cond
      ((= fl 0)
       (setq tt (+ t-min (/ (* i (- t-max t-min)) n)))
      )
      ((= fl 1)
       (setq tt (* t-min (exp (/ (* (log (/ t-max t-min)) i) n))))
      )
    )
    (setq l_pts (cons tt l_pts))
    (setq i (1- i))
  )
  l_pts
)