(setq *lines-command-list* '("d_chamf" "d_off" "d_otv" "d_rez" "exl" "xt" "xtcen" "cxt" "ltp" "r_off" "z0" "j_lns"))
;;;;(opech_cmds-str *lines-command-list*)

(defun c:�_�����() (c:d_chamf))
(defun c:�_���() (c:d_off))
(defun c:�_���() (c:d_otv))
(defun c:�_���() (c:d_rez))
(defun c:���() (c:exl))
(defun c:��() (c:xt))
(defun c:�����() (c:xtcen))
(defun c:���() (c:cxt))
(defun c:���() (c:ltp))
(defun c:�_���() (c:r_off))
(defun c:�0() (c:z0))
(defun c:�_���() (c:j_lns))

(princ "Loaded project lines.\n")


'(("MNAS-CAD-UTILS-PATH" nil)
  ("LTP" t)
  ("R_OFF" t)                           ; �������
  ("D_OFF" t)                           ; �������
  ("D_OTV" t)                           ; ���������� � D_OTV
  ("D_CHAMF" t)                         ; ���������� � D_CHAMF
  ("D_REZ" t)                           ; ���������� � D_REZ
  ("XT" t)
  ("EXL" t)
  ("Z0" t)
  ("XTCEN" t)
  ("CXT" t)
  ("J_LNS" t) ;�������� ����������� ���������� �������� � ��������� �������
  ("J_ARCS" t) ;�������� ������ ���������� � ������������ ���������� ���� ��������
  )