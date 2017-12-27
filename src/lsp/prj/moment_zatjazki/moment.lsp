(setq
  p	(* 100. 10. 2.0 2.0 pi 0.25)	; ������ �������, H
  d	0.010				; ����������� ������� ������, �
  s	0.0015				; ��� ������ (��� ��� ������������� ������), �
  f	0.1				; ����������� ������ � ������
  D_gol_sr 0.000			; ������� ������� �����, �
  f_01	0.1				; ����������� ������ � ������� �� ������������ �����������
)


;; ������, ������������� �� �������� ����.
(defun m_1
	   (p				; ����������� ����
	    d				; ������� ������� ������
	    s				; ��� ������
	   )
  (setq d_sr (d_sr_metr d s))
  (setq tg_phi (/ s d_sr pi))		; ������ ���� �������
  (* 0.5 p d_sr tg_phi)
)


;; ������ ������������� � �����
(defun m_2 (p				; ����������� ����
	    d				; ������� ����� �������� �� ������� �����
	    f				; ����������� ������
	   )
  (* 0.5 p d f)
)


;;
(defun m_3 (p				; ����������� ����
	    d				; ������� ������� ������
	    s				; ��� ������
	    f				; ����������� ������
	    / d_sr			; ������� ������� ������
	    alpha			; ���������� ���� �������, ����
)
  (setq alpha 30.0); ���� ����� �������� � ����������� � ���� ������, ����
  (setq d_sr (d_sr_metr d s))
  (* 0.5 p d_sr (/ f (cos (dtr alpha))))
)

(defun d_sr_metr(d ; ����������� �������
		 s ; ��� ������
		 )
    (- d (* 0.54 s))
)

(defun m_summ (p d s f D_gol_sr f_01)
  (+
    (m_1 p d s)
    (m_2 p D_gol_sr f_01)
    (m_3 p d s f)
  )
)

(defun m_out (p d s f D_gol_sr f_01)
  (princ "\nP=") (princ p) (princ "[H];")
  (princ "\nd=") (princ (* 1000. d)) (princ "[��];")
  (princ "\ns=") (princ (* 1000. s)) (princ "[��];")
  (princ "\nD_gol_sr=") (princ (* 1000. D_gol_sr)) (princ "[��];")
  (princ "\nf=") (princ f)
  (princ "\nf_01=") (princ f_01)
  
  (princ "\nm_1=")  (princ (m_1 p d s)) (princ "[H/�];")
  (princ "\nm_2=")  (princ (m_2 p D_gol_sr f_01)) (princ "[H/�];")
  (princ "\nm_3=")  (princ (m_3 p d s f)) (princ "H/�;")
  (princ "\nM=")  (princ (m_summ p d s f D_gol_sr f_01))   (princ "[H/�];")
)

(m_out p d s f D_gol_sr f_01)

;|�Visual LISP� Format Options�
(105 2 40 2 nil "end of" 90 9 0 0 0 T T nil T)
;*** �� ���������� ����� ��� �������������! ***|;
