(defun c:nut (/ s h m p)
  (setq s (getdist "������� ������ ��� ����:"))
  (setq h (getdist "������� ������ �����:"))
  (setq m (getdist "������� ������� ������:"))
  (setq p (getdist "��� ������:"))
  (setq p0 (getpoint "������� ������������ �����:"))
  (command "_POLYGON" 6 "_non" p0 "_c" "_non" (polar p0 0 (/ s 2)))
  (command "_circle" "_non" p0 (- (*  m 0.5) (* 0.7 p) ))
  (command "_circle" "_non" p0  (*  m 0.5) )
  (setq dl (+ 3.0 (* s 0.57735)))
  (command "_line" "_non" (polar p0 pi dl ) "_non" (polar p0 0.0 dl) "")
  (command "_line" "_non" (polar p0 (* pi -0.5) dl ) "_non" (polar p0 (* pi 0.5) dl) "")
) 
;|�Visual LISP� Format Options�
(105 2 15 2 nil "end of" 90 9 0 0 0 T T nil T)
;*** �� ���������� ����� ��� �������������! ***|;
 