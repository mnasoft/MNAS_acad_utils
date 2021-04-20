(defun f_otv (d) (* 0.25 pi d d))

(defun d_ek (f) (sqrt (/ (* 4.0 f) pi)))

;;; ������� �������

(defun f_zikl  (f_e                     ; - ������������� ������� ���� ������������� ������� ���������� �������� �� ���� ��������� �������.
                f_1                     ; - ������������� ������� ���� ��������� �������������.
                )
  (sqrt (/ 1.0 (- (/ 1.0 (* f_e f_e)) (/ 1.0 (* f_1 f_1))))))

;;; ��������� �������, ������������� ������� ��������������� ������������� �������������.
;;; ��������������, ��� ����� ����������� ����� ������� �� ���������.
(defun f_ek_zikl  (l_f                  ; - ������, ���������� ��������� �������.
                   /                    ;
                   zero                 ;
                   )
  (mapcar (function (lambda (el)
                      (if (zerop el)
                        (setq zero t))))
          l_f)
  (cond (zero 0.0)
        (t (sqrt (/ 1.0 (apply (function +) (mapcar (function (lambda (el) (/ 1.0 (* el el)))) l_f)))))))


;;;;;;("f_kolca" "���������� ������� ������." "�������")
(defun c:f_kolca (/ area p1 p1-p2 p2 p_mid p_mid-p_os p_os) (f_kolca) (princ))

(defun f_kolca  (/ area p1 p1-p2 p2 p_mid p_mid-p_os p_os)
  (setq p1         (getpoint "������� 1 ����� �� ������:")
        p2         (getpoint p1 "������� 2 ����� �� ������:")
        p_mid      (mapcar (function (lambda (el1 el2) (/ (+ el1 el2) 2.0))) p1 p2)
        p_os       (getpoint p_mid "���������� ���������� �� ���:")
        p1-p2      (distance p1 p2)
        p_mid-p_os (distance p_mid p_os)
        area       (* p1-p2 p_mid-p_os 2. pi))
  (princ "\n����� ������ p1-p2: ")
  (princ p1-p2)
  (princ "\n������ ������ p_mid-p_os: ")
  (princ p_mid-p_os)
  (princ "\n�������������� �������: ")
  (princ (/ area p_mid-p_os pi))
  (princ "\n������� ������������: ")
  (princ (sqrt (/ area 0.25 pi)))
  (princ "\n�������: ")
  (princ area)
  area)

(defun c:d_hydravlic  (/ en)
  (setq en (car (entsel)))
  (command-s "_area" "_Object" en)
  (/ (* (getvar "AREA") 4.0) (getvar "PERIMETER")))

(defun c:d_hydravlic_diff  (/ en1 en2 area-1 area-2 perim-1 perim-2)
  (setq en1 (car (entsel)))
  (setq en2 (car (entsel)))
  (command-s "_area" "_Object" en1)
  (setq	area-1	(getvar "AREA")
	perim-1	(getvar "PERIMETER"))
  (command-s "_area" "_Object" en2)
  (setq	area-2	(getvar "AREA")
	perim-2	(getvar "PERIMETER"))
  (/ (* (- area-1 area-2) 4.0) (+ perim-1 perim-2)))

(defun c:f_zavihr  (/ area p1 p1-p2 p2 p_mid p_mid-p_os p_os)
  (setq p1         (getpoint "\n������� 1 ����� �� ������:")
        p2         (getpoint p1 "\n������� 2 ����� �� ������:")
        p_mid      (mapcar (function (lambda (el1 el2) (/ (+ el1 el2) 2.0))) p1 p2)
        p_os       (getpoint p_mid "\n���������� ���������� �� ���:")
        p1-p2      (distance p1 p2)
        p_mid-p_os (distance p_mid p_os)
        area       (* p1-p2 p_mid-p_os 2. pi)
        n_lop      (getreal "\n���������� ������� �����������:")
        delta_lop  (getreal "\n������� ������� �����������:")
        alfa       (getangle p_os "\n���� ������ �������:"))
  (princ "\n����� ������ p1-p2: ")
  (princ p1-p2)
  (princ "\n������ ������ p_mid-p_os: ")
  (princ p_mid-p_os)
  (princ "\n������� ��� ����� ������ ������: ")
  (princ area)
  (princ "\n������� �����������: ")
  (princ (- (* area (cos alfa)) (* n_lop delta_lop p1-p2)))
  (princ))
