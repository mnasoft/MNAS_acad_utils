(setq dopusk-str_specsymbol "\A1;H7 ({\A2\C1\H0.75x;\S�������_1^������_1;})\P%%c<>{\S            /;}   .\Pd8 ({\A0\H0.75x;\S�������_2^������_2;})")
"\A1;<>H7{\H1.5x(}{\H0.66x;\S+0.025^-0.001;}{\H1.5x)}"

;;;;;;("dop"
;;;;;;"���������� � ������ ���������� ���������
;;;;;; ����������� ��������� � �������� ���������� ����������." "�������")
(defun c:dop  (/ ss1 kval en ed p10 p13 p14 p15 a50 p0 l)
  (princ "\n�������� ��������� ��������� :")
  (setq ss1 (ssget))
  (setq kval (getstring "\n������� �������� :"))
  (if (null ss1)
    (exit))
  (while (> (sslength ss1) 0)
    (setq en (ssname ss1 0)
          ed (entget en))
    (print ed)
    (if (= (cdr (assoc 0 ed)) "DIMENSION")
      (cond ((= (rem (cdr (assoc 70 ed)) 32) 0)
             (princ "\n����������, ��������������, ������������:")
             (setq p10 (cdr (assoc 10 ed)))
             (setq p13 (cdr (assoc 13 ed)))
             (setq p14 (cdr (assoc 14 ed)))
             (setq a50 (cdr (assoc 50 ed)))
             (setq p0 (inters p13 (polar p13 a50 10.) p14 p10 nil))
             (setq l (dopusk-find_kv (distance p13 p0) kval))
             (entmod (dopusk-str_dop ed l kval "%%c")))
            ((= (rem (cdr (assoc 70 ed)) 32) 1)
             (princ "\n�����������:")
             (setq p13 (cdr (assoc 13 ed)))
             (setq p14 (cdr (assoc 14 ed)))
             (setq l (dopusk-find_kv (distance p13 p14) kval))
             (entmod (dopusk-str_dop ed l kval "%%c")))
            ((= (rem (cdr (assoc 70 ed)) 32) 2)
             (princ "\n������� ��� ������� :")
             (setq p10 (cdr (assoc 10 ed)))
             (setq p13 (cdr (assoc 13 ed)))
             (setq p14 (cdr (assoc 14 ed)))
             (setq p15 (cdr (assoc 15 ed)))
             (setq p16 (cdr (assoc 16 ed))))
            ((= (rem (cdr (assoc 70 ed)) 32) 3)
             (princ "\n�������:")
             (setq p10 (cdr (assoc 10 ed)))
             (setq p15 (cdr (assoc 15 ed)))
             (setq l (dopusk-find_kv (distance p10 p15) kval))
             (entmod (dopusk-str_dop ed l kval "")))
            ((= (rem (cdr (assoc 70 ed)) 32) 4)
             (princ "\n������:")
             (setq p10 (cdr (assoc 10 ed)))
             (setq p15 (cdr (assoc 15 ed)))
             (setq l (dopusk-find_kv (distance p10 p15) kval))
             (entmod (dopusk-str_dop ed l kval "")))
            ((= (rem (cdr (assoc 70 ed)) 32) 5)
             (princ "\n������� � ��������:")
             (setq p10 (cdr (assoc 10 ed)))
             (setq p13 (cdr (assoc 13 ed)))
             (setq p14 (cdr (assoc 14 ed)))
             (setq p15 (cdr (assoc 15 ed))))))
    (setq ss1 (ssdel en ss1)))
  (princ))

(defun dopusk-find_kv  (val kv / l1 l2 len el i)
  (if (null dopusk-dop_val)
    (progn (alert "(load \"dopusk\\dop_data_new_01\")") (exit)))
  (setq l1 (cadr (assoc kv dopusk-dop_val)))
  (if (null l1)
    (progn (princ (strcat "\n� ������� �������� ��� ��������� :" kv)) (exit)))
  (setq len (length l1)
        i   0)
  (while (< i len)
    (setq el (nth i l1))
    (if (and (> val (car el)) (<= val (cadr el)))
      (setq l2 el
            i  len))
    (setq i (1+ i)))
  l2)


(defun dopusk-str_dop  (ed l kval zn_dia / str t_pl t_ot zn_pl zn_ot)
  (if (null l)
    (progn (princ "\n������ �� ������.") (exit)))
  (setq t_pl (caddr l)
        t_ot (cadddr l))
  (setq str (strcat "\\A1;"
                    zn_dia
                    "<> "
                    kval
                    "{\\H1.6x(}"
                    "{\\H0.725x;\\S"
                    (cond ((< t_pl 0) (rtos (* 1.000 t_pl) 2 3))
                          ((= t_pl 0) "")
                          ((> t_pl 0) (strcat "+" (rtos (* 1.000 t_pl) 2 3))))
                    "^"
                    (cond ((< t_ot 0) (rtos (* 1.000 t_ot) 2 3))
                          ((= t_ot 0) "")
                          ((> t_ot 0) (strcat "+" (rtos (* 1.000 t_ot) 2 3))))
                    ";}"
                    "{\\H1.6x)}"))
  (setq ed (dsubst ed (list (cons 1 str)))))