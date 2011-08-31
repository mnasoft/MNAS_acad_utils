(setq
  spring_1
	   '(
	     ("d_provoloka" 2.5)	; ������� ��������� �������, ��.
	     ("D_sredn" 24.5)		; ������� ������� �������, ��.
	     ("l0_svobodn" 39.75)	; ����� ������� � ��������� ���������.��.
	     ("n_vitkov" 4.0)		; ���������� ������ ������ �������.
	     ("G_sdviga" 76200.0)	; ������ ���� ������� ����, ���.
	    )
  spring_2
	   '(
	     ("d_provoloka" 4.5)	; ������� ��������� �������, ��.
	     ("D_sredn" 40.0)		; ������� ������� �������, ��.
	     ("l0_svobodn" 45.0)	; ����� ������� � ��������� ���������.��.
	     ("n_vitkov" 4.0)		; ���������� ������ ������ �������.
	     ("G_sdviga" 76200.0)	; ������ ���� ������� ����, ���.
	    )
  spring_3i5
	   '(
	     ("d_provoloka" 3.5)	; ������� ��������� �������, ��.
	     ("D_sredn" 40.0)		; ������� ������� �������, ��.
	     ("l0_svobodn" 46.05)	; ����� ������� � ��������� ���������.��.
	     ("n_vitkov" 3.0)		; ���������� ������ ������ �������.
	     ("G_sdviga" 76200.0)	; ������ ���� ������� ����, ���.
	    )
)

(setq
  klapan
   (list
     (list "l_hod" 13.0)
     (list "springs"
	   (list
	     (list "l_open" 32.9)
	     (list "spring" spring_1)
	   )
	   (list
	     (list "l_open" 36.9)
	     (list "spring" spring_2)
	   )
     )
   )
)

(defun culc_klapan (Si klapan / l_open)
  (setq
    springs_lst
     (cdr (assoc "springs" klapan))
  )
  (setq
    f_summ
    
    (mapcar
      (function
	(lambda	(el)
	  (f_f_klap Si el)
	)
      )
      springs_lst
    )
    f_summ (apply (function +) f_summ)
  )
)

(defun f_f_klap (Si kl_string / l_open spring si_spring)
  (setq
    l_open (cadr (assoc "l_open" kl_string))
    spring (cadr (assoc "spring" kl_string))
    si_spring (- (f_l0 spring) (- l_open Si))
  )
  (f_Fi si_spring spring)
)

; ����������� ������� ��������� �������.
(defun f_d (spring)  (cadr (assoc "d_provoloka" spring)))

; ������� ������� �������, ��.
(defun f_D_sr (spring)  (cadr (assoc "D_sredn" spring)))

; ����� ������� � ��������� ���������.��.
(defun f_l0 (spring)  (cadr (assoc "l0_svobodn" spring)))

; ���������� ������ ������ �������.
(defun f_n (spring)  (cadr (assoc "n_vitkov" spring)))

; ������ ���� ������� ����, ���.
(defun f_G (spring)  (cadr (assoc "G_sdviga" spring)))

; ������ ������ �� �������, �.
(defun f_Fi (Si spring / n d D_sr G l0 n)
  (setq
    d	 (f_d spring)
    D_sr (f_D_sr spring)
    G	 (f_G spring)
    l0	 (f_L0 spring)
    n	 (f_n spring)
  )
  (/ (* G d d d d Si) (* 8.0 D_sr D_sr D_sr n (f_k2 spring)))
)

; ������ ������� ��� ��������������� ������, ��.
(defun f_l4(spring / d n)
  (setq
    d	 (f_d spring)
    n	 (f_n spring)
  )
  (* d (+ n 1.5))
)


; ��� ������� � ��������� ���������,  ��.
(defun f_tsh (spring / l0 d n)
  (setq
    d	 (f_d spring)
    l0	 (f_L0 spring)
    n	 (f_n spring)
  )
  (/ (- l0 (* 1.5 d)) n)
)
; ������ �������.
(defun f_c (spring)
  (/ (f_D_sr spring) (f_d spring) )
)

; ����������� k1.
(defun f_k1 (spring / c)
  (setq c (f_c spring) )
  (+
    (/
      (- (* 4.0 c) 1.0)
      (- (* 4.0 c) 4.0)
    )
    (/ 0.615 c)
  )
)

; ����������� k2.
(defun f_k2 (c)
  (setq c (f_c spring) )
  (+ 1.0 (/ 1.0 2.0 c) (/ -1.0 2.0 c c))
)

; ���������� ��������, ���.
(defun f_Tau (Si spring / d D_sr Fi)
  (setq
    d	 (f_d spring)
    D_sr (f_D_sr spring)
    Fi	 (f_Fi Si spring)
  )
  (/
    (* 2.55 Fi D_sr (f_k1 spring))
    (* d d d)
  )
)

