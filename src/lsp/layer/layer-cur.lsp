;;;;;;("vl_s_d"
;;;;;;"�������� ������������� �� ���� ������ ��������� � (���)\n
;;;;;;��������� � ������� �������� ����,\n
;;;;;;� ������ ���� ����������� ��������� + \"_d\"." "����")
(defun c:vl_s_d  (/ tm)
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (setq en   (car (entsel "\n�������� ��������:"))
        ed   (entget en)
        la   (cdr (assoc 8 ed))
        la_d (strcat la "_d")
        tm   (getvar "tilemode"))
  (cond ((wcmatch (strcase la) (strcase "*_d")) (command-s "_.layer" "_set" la))
        ((tblsearch "layer" la_d) (command-s "_.layer" "_set" la_d))
        ((null (tblsearch "layer" la_d))
         (setvar "tilemode" 0)
         (command-s "_.vplayer" "_new" la_d)
         (if_cmd_active)
         (command-s "_.layer" "_set" la_d)))
  (if_cmd_active)
  (setvar "tilemode" tm)
  (err-handle ""))


;;	if_cmd_active()	- ������� ���������� ���� � ��������� ������ �������� ����� ��� ����
;;			������� ��������� � �������� ���������.
(defun if_cmd_active () (while (= 1 (getvar "CMDACTIVE")) (command-s "")))

;;;;;;("cl_s_d"
;;;;;;"�������� � (���) ��������� � ������� �������� ����
;;;;;;� ������ ����, ����������� ��������� + \"_d\"." "����")
(defun c:cl_s_d  (/ en ed la la_d)
  (setq en   (car (entsel "\n�������� ��������:"))
        ed   (entget en)
        la   (cdr (assoc 8 ed))
        la_d (strcat la "_d"))
  (cond ((wcmatch (strcase la) (strcase "*_d")) (command-s "_.layer" "_set" la))
        ((tblsearch "layer" la_d) (command-s "_.layer" "_set" la_d))
        ((null (tblsearch "layer" la_d)) (command-s "_.layer" "_new" la_d "_set" la_d)))
  (if_cmd_active)
  (err-handle ""))

;;;;;;("cl_sw_d"
;;;;;;"��������� � ������� �������� ���� � ������ ����,\n
;;;;;;����������� ��������� ��� ��������� \"_d\"." "����")
(defun c:cl_sw_d  (/ en ed la la_d)
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (setq en   (car (entsel "\n�������� ��������:"))
        ed   (entget en)
        la_d (cdr (assoc 8 ed)))
  (command-s "_.layer" "_set")
  (if (wcmatch (strcase la_d) (strcase "*_d"))
    (progn (setq la (substr la_d 1 (- (strlen la_d) (strlen "_d"))))
           (if (tblsearch "layer" la)
             (command-s la)
             (command-s la_d)))
    (command-s la_d))
  (if_cmd_active)
  (err-handle ""))
