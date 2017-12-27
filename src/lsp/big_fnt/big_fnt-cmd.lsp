;;;;;;("ins_lit"
;;;;;;"��������� �������� �������� ������,
;;;;;; ��������� � ������������ �������� ��� ���� ���������� ��������." "������� �����")
(defun c:ins_lit  (/ p0                 ; - ��������� ����� 
                   st                   ; - ������ ������ � ���������� �� 2-�
                   i                    ; - �������
                   j                    ; - ����� ���������� �������
) (setq v-nm-val (m_ch_var v-nm-val)    ; ��������� �������� ��������� ����������
        p0       (getpoint "\n������� ��������� �����:")
        st       (getstring "\n������� ������:"))
  (setq i 0
        j 65)
  (repeat 26
    (ins_lit (polar p0 0 (* 15 i)) (strcat st (chr (+ i j))) (strcat st (chr (+ i j))))
    (setq i (1+ i)))                    ;repeat
  (setq i 0
        j 97)
  (repeat 26
    (ins_lit (polar (polar p0 0 (* 15 i)) (/ pi -2.0) 15)
             (strcat st (chr (+ i j)))
             (strcat st (chr (+ i j))))
    (setq i (1+ i)))                    ;repeat
  (setq v-nm-val (m_ch_var v-nm-val))   ; ��������������� �������� ��������� ����������
  (princ))




;;;;;;("draw_font"
;;;;;;"��������� �������� ������ (256 ��������)." "������� �����")
(defun c:draw_font  (/
                     p0                 ; - ��������� �����
                     i                  ; - �-�� ��������� � ������
                     j                  ; - �-�� �����
                     )
  (setq v-nm-val (m_ch_var v-nm-val)    ; ��������� �������� ��������� ����������
        p0       (getpoint "\n������� ��������� �����:")
        j        0)
  (while (< j 8)
    (setq i 0)
    (while (< i 32)
      (ins_lit (mapcar '+ p0 (list (* 15 i) (* j -15) 0.0)) (itoa (+ i (* j 32))) (chr (+ i (* j 32)))) ;ins_lit
      (setq i (1+ i)))
    (setq j (1+ j)))                    ;while
  (setq v-nm-val (m_ch_var v-nm-val))   ; ��������������� �������� ��������� ����������
  (princ))

;;	m_ch_var(vnm v_val)		- ������������� ��������� ���������� �� ������ vnm ����������� �� v_val; ������ �������� �� �������� � v_val.
(defun m_ch_var  (vnm-v_val)
  (mapcar (function
            (lambda (el / tmp) (setq tmp (getvar (car el))) (setvar (car el) (cadr el)) (list (car el) tmp)))
          vnm-v_val))

(setq v-nm-val (list (list "attdia" 0) (list "cmdecho" 0)))

(defun *error*  (msg)
  (if (/= "Function cancelled" msg)
    (alert msg))
  (setq v-nm-val (m_ch_var v-nm-val))
  (princ))

;;	ins_lit(p_ins st_1 st_2)	- ������� ��� ������� ����� ����������� ������.
(defun ins_lit  (p0 str1 str2 / BL_NAME ED)
  (entmake (list (cons 0 "block") (cons 2 "*U") (list 10 0.0 0.0 0.0) (cons 70 1)))
  (dr:line (list 0.0 0.0 0.0) (list 15.0 0.0 0.0) 256)
  (dr:line (list 15.0 0.0 0.0) (list 15.0 -15.0 0.0) 256)
  (dr:line (list 15.0 -15.0 0.0) (list 0.0 -15.0 0.0) 256)
  (dr:line (list 0.0 -15.0 0.0) (list 0.0 0.0 0.0) 256)
  (entmake (list (cons 0 "TEXT")
                 (cons 1 str1)
                 (cons 7 "STANDARD")
                 (cons 10 (list 0.0 0.0 0.0))
                 (cons 11 (list 7.5 -5.25 0.0))
                 (cons 40 4.0)
                 (cons 50 0.0)
                 (cons 62 256)
                 (cons 71 0)
                 (cons 72 1)))
  (entmake (list (cons 0 "TEXT")
                 (cons 1 str2)
                 (cons 7 (getvar "TEXTSTYLE"))
                 (cons 10 (list 0.0 0.0 0.0))
                 (cons 11 (list 7.5 -13.25 0.0))
                 (cons 40 4.0)
                 (cons 50 0.0)
                 (cons 62 256)
                 (cons 71 0)
                 (cons 72 1)))
  (setq bl_name (entmake (list (cons 0 "ENDBLK"))))
  (setq ed (list (cons 0 "insert")
                 (cons 2 bl_name)
                 (cons 10 p0)
                 (cons 50 0.0)
                 (cons 41 1.0)
                 (cons 42 1.0)
                 (cons 43 1.0)
                 (cons 210 '(0.0 0.0 0.0))))
  (entmake ed))