(setq
  setup_lst
   '(
     ("d" "1.0")	 ; ������� ���������, ��
     ("D1" "24.0")	 ; ������� ������� ��������, ��
     ("D" "23.0")	 ; ������� ������� �������, ��
     ("L0" "32")	 ; ������ ������� � ��������� ���������, ��
     ("L1" "30.0")	 ; ������ ������� ��� ��������������� ����������, ��
     ("L2" "25.0")	 ; ������ ������� ��� ������� ����������, ��
     ("L3" "22.0")	 ; ������ ������� ��� ������������ ����������, ��
     ("L4" "5.5")	 ; ������ ������� ��� ��������������� ������, ��
     ("S1" "30.0")	 ; ��������������� ���������� �������, ��
     ("S2" "25.0")	 ; ������� ���������� �������, ��
     ("S3" "22.0")	 ; ������������ ���������� �������, ��
     ("t" "8.125")	 ; ��� ������� � ��������� ���������, ��
     ("Sk" "0.5")	 ; ������� ����� �������� ����� �������, ��
     ("h" "10.0")	 ; ������� ��� �������, ��
     ("L" "200.0")	 ; ����� ��������� ����������� �������, ��
     ("n" "4.0")	 ; ����� ������ �������
     ("n1" "6.0")	 ; ������ ����� ������ �������
     ("i" "")		 ; ������ �������
     ("K1" "")		 ; �����������, ����������� ������� �������� �����
     ("K2" "")		 ; �����������, ����������� ������� ���������� ����
     ("F1" "")		 ; ���� ������� ��� ��������������� ����������, �
     ("F2" "")		 ; ���� ������� ��� ������� ����������, �
     ("F3" "")		 ; ���� ������� ��� ������������ ����������, �
     ("tau1" "")	 ; ���������� ��� �������� ��� ��������������� ����������, ���
     ("tau2" "")	 ; ���������� ��� �������� ��� ������� ����������, ���
     ("tau3" "")	 ; ���������� ��� �������� ��� ������������ ����������, ���
     ("[tau]" "640.0")	 ; ����������� ���������� ��� ��������
     ("C" "")		 ; ��������� �������, �/��
     ("G" "72600.0")	 ; ������ ������, ���
     ("i1" "")		 ; ��������� ����� ������� � ��������� ��������� � � �������� ��������
    )
)




(defun spring-dlg ()
  (load_dcl "/prj/spring/Spring.DCL")
  (setq do_dialog t)
  (while do_dialog
    (if	(not (new_dialog "spring" dcl_id))
      (exit)
    )
    (init_dlg setup_lst)
    (action-tile_dlg "setup_lst" "setup_lst")

    (action_tile "d" "(action_d)")
    (action_tile "D" "(actionD)")
    (action_tile "D1" "(actionD1)")

    (action_tile "n1" "(action_n1)")
    (action_tile "n" "(action_n)")
    (action_tile "t" "(action_t)")
    (action_tile "L0" "(actionL0)")

    (action_tile "S1" "(actionS1)")
    (action_tile "L1" "(actionL1)")
    (action_tile "S2" "(actionS2)")
    (action_tile "L2" "(actionL2)")
    (action_tile "S3" "(actionS3)")
    (action_tile "L3" "(actionL3)")

    (action_tile "for_zap" "(done_dialog 6)")
    (action_tile "about" "(about)")

    (setq action (start_dialog))
    (cond
      ((= action 0) (setq do_dialog nil))
      ((= action 1) (setq do_dialog nil))
    )
  )
  (unload_dialog dcl_id)
			 ;  (setq *error* old_err)
			 ;  (command "_.undo" "_end")
			 ;  (setvar "cmdecho" 1)
)

(defun actionD (/ D D1 _d)
  (setq _d (read (get_tile "d")))
  (setq D (read (get_tile "D")))
  (setq D1 (+ D _d))
  (set_tile "D1" (rtos D1))

  (show_d)
)

(defun actionD1	(/ D D1 _d)
  (setq _d (read (get_tile "d")))
  (setq D1 (read (get_tile "D1")))
  (setq D (- D1 _d))
  (set_tile "D" (rtos D))

  (show_d)
)

(defun action_n1 (/ L4 _d _n _n1)
  (setq _n1 (read (get_tile "n1")))
  (setq _n (- _n1 2))
  (set_tile "n" (rtos _n))

  (setq _d (read (get_tile "d")))
  (setq L4 (* (+ _n 1.5) _d))
  (set_tile "L4" (rtos L4))
)

(defun action_n	(/ L4 _d _n _n1)
  (setq _n (read (get_tile "n")))
  (setq _n1 (+ _n 2))
  (set_tile "n1" (rtos _n1))

  (setq _d (read (get_tile "d")))
  (setq L4 (* (+ _n 1.5) _d))
  (set_tile "L4" (rtos L4))
)

(defun action_t	(/ L0 _d _n _t)
  (setq _t (read (get_tile "t")))
  (setq _d (read (get_tile "d")))
  (setq _n (read (get_tile "n")))

  (setq L0 (+ (* _n _t) (* 1.5 _d)))
  (set_tile "L0" (rtos L0))
)

(defun actionL0	(/ L0 _d _n _t)
  (setq L0 (read (get_tile "L0")))
  (setq _d (read (get_tile "d")))
  (setq _n (read (get_tile "n")))

  (setq _t (/ (- L0 (* 1.5 _d)) _n))
  (set_tile "t" (rtos _t))
)

(defun actionS1	(/ L0 L1 S1)
  (setq L0 (read (get_tile "L0")))
  (setq S1 (read (get_tile "S1")))

  (setq L1 (- L0 S1))
  (set_tile "L1" (rtos L1))

  (show_h)
  (show_F1)
)

(defun actionL1	(/ L0 L1 S1)
  (setq L0 (read (get_tile "L0")))
  (setq L1 (read (get_tile "L1")))

  (setq S1 (- L0 L1))
  (set_tile "S1" (rtos S1))

  (show_h)
  (show_F1)
)

(defun actionS2	(/ L0 L2 S2)
  (setq L0 (read (get_tile "L0")))
  (setq S2 (read (get_tile "S2")))

  (setq L2 (- L0 S2))
  (set_tile "L2" (rtos L2))

  (show_h)
  (show_F2)
)

(defun actionL2	(/ L0 L2 S2)
  (setq L0 (read (get_tile "L0")))
  (setq L2 (read (get_tile "L2")))

  (setq S2 (- L0 L2))
  (set_tile "S2" (rtos S2))

  (show_h)
  (show_F2)
)

(defun actionS3	(/ L0 L3 S3)
  (setq L0 (read (get_tile "L0")))
  (setq S3 (read (get_tile "S3")))

  (setq L3 (- L0 S3))
  (set_tile "L3" (rtos L3))
)

(defun actionL3	(/ L0 L3 S3)
  (setq L0 (read (get_tile "L0")))
  (setq L3 (read (get_tile "L3")))

  (setq S3 (- L0 L3))
  (set_tile "S3" (rtos S3))
)

(defun show_h ()
  (set_tile
    "h"
    (rtos (- (read (get_tile "S2")) (read (get_tile "S1"))))
  )
)

(defun show_L (/ _n1 D _t L)
  (setq
    _n1	(read (get_tile "n1"))
    D	(read (get_tile "D"))
    _t	(read (get_tile "_t"))
  )
  (setq L (* _n1 (sqrt (+ (* pi pi D D) (* _t _t)))))
  (set_tile "L" (rtos L))
)

(defun show_d ()
  (show_lst (list "d"))
)



(defun show_lst	(lst)
  (mapcar
    (function
      (lambda (el)
	(set_tile el (rtos (read (get_tile el))))
      )
    )
    lst
  )
)

(defun show_F1 (/ D F1 G i K1 K2 S1 _d _n _tau1)
  (setq
    G  (read (get_tile "G"))
    _d (read (get_tile "d"))
    S1 (read (get_tile "S1"))
    D  (read (get_tile "D"))
    _n (read (get_tile "n"))
    i  (/ D _d)
    K2 (f_K2 i)
    F1 (/ (* G _d _d _d _d S1) 8.0 D D D _n K2)
    K1 (f_K1 i)
    _tau1(/ (* 2.55 F1 D K1)(* _d _d _d))
  )
  (set_tile "K2" (rtos K2))
  (set_tile "F1" (rtos F1))
  (set_tile "tau1" (rtos _tau1))
)

(defun show_F2 (/ D F2 G i K1 K2 S2 _d _n _tau2)
  (setq
    G	  (read (get_tile "G"))
    _d	  (read (get_tile "d"))
    S2	  (read (get_tile "S2"))
    D	  (read (get_tile "D"))
    _n	  (read (get_tile "n"))
    i	  (/ D _d)
    K2	  (f_K2 i)
    F2	  (/ (* G _d _d _d _d S2) 8.0 D D D _n K2)
    K1	  (f_K1 i)
    _tau2 (/ (* 2.55 F2 D K1) (* _d _d _d))
  )
  (set_tile "K2" (rtos K2))
  (set_tile "F2" (rtos F2))
  (set_tile "tau2" (rtos _tau2))
)

(defun f_K2 (i)
  (+ 1.0 (/ 1.0 2.0 i) (/ -1.0 2.0 i i))
)

(defun f_K1 (i)
  (+ (/ (- (* 4.0 i) 1.0)(- (* 4.0 i) 4.0)) (/ 0.615 i))
)


;|�Visual LISP� Format Options�
(72 2 25 2 nil "end of" 60 9 0 0 0 T T nil T)
;*** �� ���������� ����� ��� �������������! ***|;
