;;;;;;("de"
;;;;;;"�������� ������ ��� �������������� ������ ���������� ��������� �����:
;;;;;;MTEXT, TEXT, DIMENSION." "������")
(defun c:de  (/ en obj temp)
  (setq en   (car (entsel "\n�������� ��������:"))
        obj  (entget en)
        temp (cdr (assoc 0 obj)))
  (cond ((or (= "MTEXT" temp) (= "TEXT" temp) (= "DIMENSION" temp)) (command "ddedit" en))
        ((or (= "INSERT" temp)) (command "ddatte" en)))
  (princ))


;;;;;;("ate" "�������������� ��������." "������")
(defun c:ate  (/ en obj temp)
  (setq en   (car (nentsel "\n�������� ��������:"))
        obj  (entget en)
        temp (cdr (assoc 0 obj)))
  (cond ((or (= "MTEXT" temp) (= "TEXT" temp) (= "DIMENSION" temp)) (command "ddedit" en))
        ((or (= "ATTRIB" temp)) (command "attedit" "_y" "*" "*" "*" en)))
  (princ))
