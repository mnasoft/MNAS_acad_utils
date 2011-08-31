;;;f;;;("g_usp()" "��������� ���������� �������[�/�^2].")
(defun g_usp () 9.80665)

;;;f;;;("T_abs0[C] ()"	"���������� ���� � �������� ��������.")
(defun T_abs0[C] () -273.15)

;;;f;;; ("T[K]->t[C] ( T[K] )" "������� ����������� �� ��������� � ������� �������.")
(defun T[K]->t[C](T[K]) (+ T[K] (T_abs0[C])))

;;;f;;; ("t[C]->T[K] (t[C])"  "������� ����������� �� �������� ������� � ��������.")
(defun t[C]->T[K] (t[C]) (- t[C] (T_abs0[C])))

;;;f;;; ("p_atm ()" "���������� ����������� �������� [��].")
(defun p_atm () 101325.0)

;;;f;;; ("kg/cm2->Pa (kg/cm2)" "������� �������� �� ��/��^2 � ��.")
(defun kg/cm2->Pa(kg/cm2) (* kg/cm2 (g_usp) 10000.0))

;;;f;;; ("Pa->kg/cm2 (Pa)" "������� �������� �� �� � ��/��^2.")
(defun Pa->kg/cm2(Pa) (/ Pa (g_usp) 10000.0))

;;;f;;; ("p_izb->p_abs( p_izb )" "������� ����������� �������� � ���������� [��].")
(defun p_izb->p_abs(p_izb) (+ p_izb (p_atm)))

;;;f;;; ("p_izb[kg/cm2]->p_abs[Pa] ( p_izb )" "������� ����������� �������� [��/��^2] � ���������� [��].")
(defun p_izb[kg/cm2]->p_abs[Pa](p_izb)
  (+ (kg/cm2->Pa p_izb) (p_atm))
)

;;;f;;; ("ro(P mu Rmu Temperatura)" "��������� �� P mu Rmu Temperatura")
(defun ro(P mu Rmu Temperatura)
  (/(* P mu)(* Rmu Temperatura))
)
;|�Visual LISP� Format Options�
(150 2 5 2 nil "end of" 60 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
