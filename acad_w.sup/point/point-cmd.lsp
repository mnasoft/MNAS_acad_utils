;;;;;;("pd" "��������� �������� � ����� ����������� �����." "���������")
(defun c:pd () (command "pdmode" "35") (command "pdsize" "2"))

;;;;;;("xy" "����� �� �����������." "�����")
(defun c:xy  (/ p0 p1 dir_0 dx dy p3)
  (setq p0 (getpoint "\n������� �����:"))
  (setq p1 (getpoint p0 "\n�����������:"))
  (setq dir_0 (angle p0 p1))
  (setq dx (getreal "\n���������� �� X:"))
  (setq dy (getreal "\n���������� �� Y:"))
  (setq p3 (dxdy p0 dx dy dir_0))
  (command "_point" "_non" p3)
  (setq p3 p3))

;;;;;;("xy_sc" "����� �� ����������� � ���������." "�����")
(defun c:xy_sc  (/ dir_0 dx dy p0 p1 p3 scx scy)
  (setq p0 (getpoint "\n������� �����:"))
  (setq p1 (getpoint p0 "\n�����������:"))
  (setq dir_0 (angle p0 p1))
  (setq dx (getreal "\n���������� �� X:"))
  (setq dy (getreal "\n���������� �� Y:"))
  (setq scx (getreal "\n������� �� X:"))
  (setq scy (getreal "\n������� �� Y:"))
  (setq p3 (dxdy_sc_xy p0 dx dy scx scy dir_0))
  (command "_point" "_non" p3)
  (setq p3 p3))

;;;;;;("rot_p" "����� ���������� � ���������." "�����")
(defun c:rot_p  (/ p0 p1 point alfa dir_0 sc p3)
  (setq p0 (getpoint "\n������� �����:"))
  (setq p1 (getpoint p0 "\n�����������:"))
  (setq point (getpoint p0 "\n���� ��� ��������:"))
  (setq alfa (getangle "���� ��������:"))
  (setq dir_0 (angle p0 p1))
  (setq sc (getreal "\n������� :"))
  (setq p3 (rotate_sc p0 point alfa sc))
  (command "_point" "_non" p3)
  (setq p3 p3))
