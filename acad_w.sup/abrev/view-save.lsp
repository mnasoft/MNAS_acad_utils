;;;;;;("pur" "������� ���� �������������� ��������� �� ������ ������." "������������")
(defun c:save-view (/ v-name)
  (setq v-name (cdr (assoc 1 (entget(car(entsel "�������� ����� ��� ����������� ����:"))))))
  (command "_view" "_w" v-name))
