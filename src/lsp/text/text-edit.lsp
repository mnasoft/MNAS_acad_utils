;;;;;;("de"
;;;;;;"�������� ������ ��� �������������� ������ ���������� ��������� �����:
;;;;;;MTEXT, TEXT, DIMENSION." "������")
(defun c:de  (/ en ed temp)
  (setq en   (car (entsel "\n�������� ��������:"))
        ed  (entget en)
        temp (cdr (assoc 0 ed)))
  (cond ((or (= "MTEXT" temp) (= "TEXT" temp) (= "DIMENSION" temp)) (command-s "_ddedit" en))
        ((or (= "INSERT" temp)) (command-s "_ddatte" en)))
  (princ))


;;;;;;("ate" "�������������� ��������." "������")
(defun c:ate  (/ en ed temp)
  (setq en   (car (nentsel "\n�������� ��������:"))
        ed  (entget en)
        temp (cdr (assoc 0 ed)))
  (cond ((or (= "MTEXT" temp) (= "TEXT" temp) (= "DIMENSION" temp)) (command-s "_ddedit" en))
        ((or (= "ATTRIB" temp)) (command-s "_attedit" "_y" "*" "*" "*" en)))
  (princ))

;;;;;;("t-tr" "��������� �������������� � ���������� ��������� � �������." "�������������� ������"
;;;;;;)
(defun c:t-tr  (/ ed es len ss txt)
  (prompt "�������� ����� ��� �������������� ���������.")
  (setq ss  (ssget)
        len (sslength ss))
  (while (<= 0 (setq len (1- len)))
    (setq es (ssname ss len))
    (setq ed (entget es))
    (setq txt (cdr (assoc 1 ed)))
    (if txt
      (progn (setq txt (vl-string-translate str_keyboard str_opchatka txt))
             (setq ed (subst (cons 1 txt) (assoc 1 ed) ed))
             (entmod ed)
             (entupd es)))))