;;;;;;("pos_export"
;;;;;;"���������� �������� ������ ������� � ����." "������")
(defun c:pos_export  (/ fd              ; ���������� �����, � ������� �������������� ������
                      fn                ; ��� �����, � ������� �������������� ������
                      i                 ; �������
                      name              ; ��� �������� ��������������� �������
                      ss                ; ����� ������
                      txt)              ; ����������� �� �������� ���������������� �����
  (setq fn (getfiled "" "" "txt" 1)
        fd (open fn "W"))
  (cond ((/= 'str (type fn)) (alert (princ "���������� fn �� �������� ����� �����.")))
        ((null fd) (alert (princ (strcat "�� ���� ������� ����: " fn "."))) (exit)))
  (setq ss (ssget)
        i  (sslength ss))
  (while (>= (setq i (1- i)) 0)
    (setq name (ssname ss i))
    (cond ((= (cdr (assoc 0 (entget name))) "MNASPozition")
           (setq txt (cdr (assoc 1 (entget name))))
           (princ txt fd)
           (princ "\n" fd))))
  (close fd))
