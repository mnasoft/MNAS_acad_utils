;;;;;;("stl"
;;;;;;"������������� � ����������� �� ��������� ����� ������ T �� ��������� �������:\n
;;;;;;\"es_***,my_b_f\"." "���������")
(defun c:stl  ()
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (stl)
  (err-handle ""))
