;;;;;;("make_ublock"
;;;;;;"������� �������������� ����" "�������")
(defun C:make_ublock  (/
		       ss ;
		       pt ; ����� ���������� �����
		       pt_ref ; ��������� ����� �����
		       )
  (setq	pt_ref (getpoint "������� ��������� �����:")
	pt     (getpoint "������� ����� ����������:")
	ss     (ssget))
  (make_ublock ss pt pt_ref))


(defun make_ublock  (ss ;
		     pt ; ����� ���������� �����
		     pt_ref ; ��������� ����� �����
		     / ed ; ������ �������� ���������
		     en ; ��� �������� ���������
		     len ; ����� ������ ����������
		     attrib_lst ; ������ ���������
		     have_attrib ; ������� ������� ���������
) (setq	len (sslength ss)
	have_attrib 0)
  (ublock+attrib:start pt_ref)
  (while (>= (setq len (1- len)) 0)
    (setq en (ssname ss len)
	  ed (cdr (entget en)))
    (setq tp (cdr (assoc 0 ed)))
    (cond ((= tp "ATTDEF")
	   (setq attrib_lst
		  (cons ed attrib_lst)
		 have_attrib 1)))
    (entmake ed))
  (setq attrib_lst (reverse attrib_lst))
  (ublock:insert (ublock:end) pt 0.0 1.0 1.0 1.0 have_attrib)
  (if have_attrib
    (progn (mapcar (function ublock:attdef->attrib) attrib_lst) (ublock:end_attrib))))

(defun ublock:start  (pt) ;������ �������� ���������������� �����
  (entmake (list (cons 0 "block") (cons 2 "*U") (cons 10 pt) (cons 70 1))))

(defun ublock+attrib:start  (pt) ;������ �������� ���������������� ����� � ����������
  (entmake (list (cons 0 "block") (cons 2 "*U") (cons 10 pt) (cons 70 3))))

(defun ublock:end  () ;����� �������� ���������������� �����
  (entmake (list (cons 0 "ENDBLK"))))

(defun ublock:insert  (ublock_name ; ��� ���������������� �����
		       pnt ; ����� ������� �����
		       ang ; ���� �������� �����
		       x_scale ; ������� �� ��� x
		       y_scale ; ������� �� ��� y
		       z_scale ; ������� �� ��� z
		       have_attrib ;(0 - ��������� �� ������ ��� 1 - �������� ����)
) (entmake (list (cons 0 "INSERT")
		 (cons 2 ublock_name)
		 (cons 10 pnt)
		 (cons 50 ang) ;(cons 41 x_scale)
	       ;(cons 42 y_scale)
	       ;(cons 43 z_scale)
		 (cons 66 have_attrib) ; �� ������ ������� ��������
		 )))

(defun ublock:attdef->attrib ; �������������� ����������� �������� � �������.
			      (attdef / attrib)
  (setq	attdef attdef ; ������� ����� �������
	attdef (subst '(0 . "ATTRIB") '(0 . "ATTDEF") attdef)
	attdef (subst '(100 . "AcDbAttribute") '(100 . "AcDbAttributeDefinition") attdef)
	attdef (subst '(70 . 0) (assoc 70 attdef) attdef)
	attdef (subst '(73 . 0) (assoc 73 attdef) attdef))
  (mapcar (function (lambda (el) ; ��������� ��� �������� dxf=3
		      (if (/= (car el) 3)
			(setq attrib (append attrib (list el))))))
	  attdef)
  (entmake attrib))

(defun ublock:end_attrib  () ; ����� ������������������ ���������
  (entmake (list (cons 0 "SEQEND"))))
