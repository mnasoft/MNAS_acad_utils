(defun ccc ()
;;; ������ ��� � ������� ����� ������� �������������
  (setq
    sc_tau (sh:get (sh:sel "��� �������"))
    sc_01  (sh:get (sh:sel "��� ������ 01"))
    sc_02  (sh:get (sh:sel "��� ������ 02"))
    sc_03  (sh:get (sh:sel "��� ������ 03"))
    sc_04  (sh:get (sh:sel "��� ������ 04"))
    sc_05  (sh:get (sh:sel "��� ������ 05"))
  )

  (setq int_file_no 61)
  (repeat 12
    (setq int_file_no (1+ int_file_no))
    (setq str_file_no (itoa int_file_no))
    (setq int_kanal 0)
    (repeat 5
      (setq int_kanal (1+ int_kanal))
      (setq str_kanal (itoa int_kanal))
      (setq name_file
	     (strcat
	       "C:\\Documents and Settings\\namatv\\������� ����\\iz_nil6\\"
	       "zp"
	       str_file_no
	       "c_0"
	       str_kanal
	       ".dat"
	      )
      )
      (setq f_name (findfile name_file))
      (setq assa (read_assa f_name))
      (cond
	((= int_kanal 1)
;;; ������ ����������� �������� �� �������
	 (setq
	   pts (mapcar
		 (function (lambda (el) (sc:pxy_pt el sc_tau sc_01)))
		 assa
	       )
	 )
	 (dr:pline pts 256)
	 (setq pt_move (list (* 150.0 int_file_no) 0.0 0.0))
	 (command "move" "l" "" pt_move "")
	)
	((= int_kanal 2)
;;; ������ ����������� �������� �� �������
	 (setq
	   pts (mapcar
		 (function (lambda (el) (sc:pxy_pt el sc_tau sc_02)))
		 assa
	       )
	 )
	 (dr:pline pts 256)
	 (setq pt_move (list (* 150.0 int_file_no) 0.0 0.0))
	 (command "move" "l" "" pt_move "")
	)
	((= int_kanal 3)
;;; ������ ����������� ����������� �� �������
	 (setq
	   pts (mapcar
		 (function (lambda (el) (sc:pxy_pt el sc_tau sc_03)))
		 assa
	       )
	 )
	 (dr:pline pts 256)
	 (setq pt_move (list (* 150.0 int_file_no) 0.0 0.0))
	 (command "move" "l" "" pt_move "")
	)
	((= int_kanal 4)
;;; ������ ����������� ���������� �� TP01 �� �������
	 (setq
	   pts (mapcar
		 (function (lambda (el) (sc:pxy_pt el sc_tau sc_04)))
		 assa
	       )
	 )
	 (dr:pline pts 256)
	 (setq pt_move (list (* 150.0 int_file_no) 0.0 0.0))
	 (command "move" "l" "" pt_move "")
	)
	((= int_kanal 5)
;;; ������ �����������  ���������� �� TP01 �� �������
	 (setq
	   pts (mapcar
		 (function (lambda (el) (sc:pxy_pt el sc_tau sc_05)))
		 assa
	       )
	 )
	 (dr:pline pts 256)
	 (setq pt_move (list (* 150.0 int_file_no) 0.0 0.0))
	 (command "move" "l" "" pt_move "")
	)
      )
      (print name_file)
    )
  )
)




(defun read_assa (f_name / fl str val tau par lst assa)
  (setq fl (open f_name "r"))
  (cond
    ((/= 'str (type f_name))
     (alert (princ "���������� f_name �� �������� ����� �����."
	    )
     )
     
    )
    ((null fl)
     (alert
       (princ
	 (strcat "�� ���� ������� ���� :" f_name ".")
       )
     )
     (exit)
    )
  )
  (while
    (setq str (read-line fl))
     (setq str (strcat "(" str ")"))
     (setq val (read str))
     (setq tau	(car val)
	   par	(cadr val)
	   lst	(list (* tau 1.0) (* par 1.0))
	   assa	(append assa (list lst))
     )
  )
  (close fl)
  assa
)
;|�Visual LISP� Format Options�
(72 2 5 2 nil "end of" 60 15 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
