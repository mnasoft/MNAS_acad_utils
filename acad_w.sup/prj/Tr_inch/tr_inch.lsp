;;;;;;("tr_inch" "not defined" "not defined")
(defun c:tr_inch(/ tr)
  (setq tr (getdist "������� ������� ���� � ������:")
	dia (d_ek (* tr (* 25.4 25.4)))
	)
)