;;��  - ������ ��������� ������ � ������������ ������� ���������
;;((0 . "LINE") (10 ...) (11 ...) (-3 ("SHCKALA" ...)("AXIS" ...)))
;;��� - ����������� ������ ���������
;;(-3 ("SHCKALA" ...)("AXIS" ...))
;;���-��� - ����������� ������ ���������, ��������� � �����������
;;("SHCKALA" ...)
;;���-��� ��� ���� - ����������� ������ ���������, ��������� � �����������
;;((1040 . 0.0) (1040 . 100.0) (1070 . 0) (1000 . "�������� Y"))

;;_$ (sh:sel "������� �����")
;;((-1 . <Entity name: 149d218>) (0 . "LINE") (330 . <Entity name: 14938c0>) (5 . "11323") (100 . "AcDbEntity") (67 . 0) (410 . "Model") (8 . "TMP") (62 . 1) (100 . "AcDbLine") (10 358.003 78.6892 0.0) (11 558.003 78.6892 0.0) (210 0.0 0.0 1.0) (-3 ("SHCKALA" (1002 . "{") (1040 . 0.0) (1040 . 100.0) (1070 . 0) (1000 . "����� ����� x") (1002 . "}"))))

;;xdgetn(data app n)
;;	�������� �� �� data, ������ ����������� �� n-��� �����, ��������� � ����������� app
;;_$ (xdgetn (sh:sel "������� �����") (sh:shckala) 1)
;;100.0

;;xdgetassoc(data app code)
;;	�������� �� �� data, ������ ������������� � code, ��������� � ����������� app
;;_$ (xdgetassoc (sh:sel "������� �����")(sh:shckala) 1000) 
;;"����� ����� x"

;;xdget(data)
;;	������� ���������� ��� �� ��.
;;_$ (xdget (sh:sel "������� �����"))
;;(-3 ("SHCKALA" (1002 . "{") (1040 . 0.0) (1040 . 100.0) (1070 . 0) (1000 . "����� ����� x") (1002 . "}")))


;;xdappget(data app)
;;������� ���������� ���-��� �� ��.
;;_$ (xdappget (sh:sel "������� �����") (sh:shckala))
;;("SHCKALA" (1002 . "{") (1040 . 0.0) (1040 . 100.0) (1070 . 0) (1000 . "����� ����� x") (1002 . "}"))

;; _xd_appget(data app)
;;	������� ���������� �� �� ���-��� ��� ����
;;_$ (xdapp_xd_ '("SHCKALA" (1002 . "{") (1040 . 0.0) (1040 . 100.0) (1070 . 0) (1000 . "����� ����� x") (1002 . "}")))
;;(1040 . 0.0) (1040 . 100.0) (1070 . 0) (1000 . "����� ����� x") 

;; _xd_applength(data app)
;;	������� ����������� ����� ���-��� ��� ����
;;_$ (_xd_applength (sh:sel "sss") (sh:shckala))
;;4

;; _xd_xdapp (da app)
;;	������� ���������� ���� � ���-��� ��� ����
;;_$ (_xd_xdapp '((1040 . 0.0) (1040 . 100.0) (1070 . 0) (1000 . "�������� Y")) (sh:shckala))
;;("SHCKALA" (1002 . "{") (1040 . 0.0) (1040 . 100.0) (1070 . 0) (1000 . "�������� Y") (1002 . "}"))


;; xdapp_xd_(dapp)
;;	������� �������������� ���-��� � ���� � ��� ��� ����
;;_$ (xdapp_xd_ '("SHCKALA" (1002 . "{") (1040 . 0.0) (1040 . 100.0) (1070 . 0) (1000 . "����� ����� x") (1002 . "}")))
;;((1040 . 0.0) (1040 . 100.0) (1070 . 0) (1000 . "����� ����� x"))

;;xdapplength (data)
;;	������� ����������� ���������� ����������
;;_$ (xdapplength (sh:sel "������� �����"))
;;1

;;xdxdapp(xdata app)
;;	������� ���������� �� ��� ���-���
;;_$ (xdxdapp (assoc -3 (sh:sel "������� �����")) (sh:shckala))
;;("SHCKALA" (1002 . "{") (1040 . 0.0) (1040 . 100.0) (1070 . 0) (1000 . "����� ����� x") (1002 . "}"))

(defun xdgetn (data app n) (cdr (nth n (_xd_appget data app))))

(defun xdgetassoc (data app code) (cdr (assoc code (_xd_appget data app))))

(defun xdget (data) (assoc -3 data))

(defun xdappget (data app) (xdxdapp (xdget data) app))

(defun _xd_appget (data app) (xdapp_xd_ (xdappget data app)))

(defun _xd_applength (data app / xd old_err) (length (_xd_appget data app)))

(defun _xd_xdapp  (da app)
  (if (not (listp da))
    (progn (setq da nil) (princ "\n _xd_xdapp da-������ ���� �������.")))
  (append (list app (cons 1002 "{")) da (list (cons 1002 "}"))))

(defun xdapp_xd_ (dapp) (reverse (cdr (reverse (cddr dapp)))))

(defun xdapplength (data) (length (cdr (xdget data))))

(defun xdappsubst  (data app xdapp / d dapp xd)
  (setq d    (xdget data)
        dapp (xdappget data app)
        xd   (cond ((and d dapp) (subst (subst xdapp dapp d) d data))
                   ((null d) (append data (list (list -3 xdapp))))
                   ((and d (null dapp)) (subst (append d (list xdapp)) d data))))
  xd)

(defun _xd_appsubst (data app xda) (xdappsubst data app (_xd_xdapp xda app)))

(defun xdxdapp (xdata app) (assoc app (cdr xdata)))

