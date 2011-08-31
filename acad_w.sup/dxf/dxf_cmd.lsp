;;;(princ "\n�������� Axis/Dxf            ")
(princ (strcat "\n�������� " (acad_sup) "/" "Axis/Dxf            "))

;;;;;;("obj" "���������� ������ ���������� ���������." "�������")
(defun c:obj ()
  (setq obj (entget (car (entsel "\n�������� ��������:"))))
  (vl-doc-set 'obj obj)
)

;;;;;;("nobj" "���������� ������ ���������� ������������." "�������")
(defun c:nobj ()
  (setq nobj (entget (car (nentsel "\n�������� ��������:"))))
  (vl-doc-set 'nobj nobj)
)

;;;;;;("objxd"
;;;;;;"���������� ������ � ����������� ������ ���������� ���������." "�������")
(defun c:objxd ()
  (setq
    objxd (entget (car (entsel "\n�������� ��������:")) (list "*"))
  )
  (vl-doc-set 'objxd objxd)
)

;;;;;;("nobjxd"
;;;;;;"���������� ������ � ����������� ������ ���������� ������������." "�������")
(defun c:nobjxd	()
  (setq
    nobjxd (entget (car (nentsel "\n�������� ��������:")) (list "*"))
  )
  (vl-doc-set 'nobjxd nobjxd)
)

(princ "\t...��������.\n")
;|�Visual LISP� Format Options�
(105 2 15 2 nil "end of" 90 15 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;