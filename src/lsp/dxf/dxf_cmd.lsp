;;;;;;("obj" "���������� ������ ���������� ���������." "�������")
(defun c:obj () (vl-doc-set 'obj (entget (car (entsel "\n�������� ��������:")))))

;;;;;;("nobj" "���������� ������ ���������� ������������." "�������")
(defun c:nobj () (vl-doc-set 'nobj (entget (car (nentsel "\n�������� ��������:")))))

;;;;;;("objxd"
;;;;;;"���������� ������ � ����������� ������ ���������� ���������." "�������")
(defun c:objxd () (vl-doc-set 'objxd (entget (car (entsel "\n�������� ��������:")) (list "*"))))

;;;;;;("nobjxd"
;;;;;;"���������� ������ � ����������� ������ ���������� ������������." "�������")
(defun c:nobjxd () (vl-doc-set 'nobjxd (entget (car (nentsel "\n�������� ��������:")) (list "*"))))