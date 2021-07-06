(defun ccc  ()
;;; Задаем оси в которых будем строить осциллограммы
  (setq	sc_tau (axis:get (axis:sel "Ось времени"))
	sc_01  (axis:get (axis:sel "Ось канала 01"))
	sc_02  (axis:get (axis:sel "Ось канала 02"))
	sc_03  (axis:get (axis:sel "Ось канала 03"))
	sc_04  (axis:get (axis:sel "Ось канала 04"))
	sc_05  (axis:get (axis:sel "Ось канала 05")))
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
	       "C:\\Documents and Settings\\namatv\\Рабочий стол\\iz_nil6\\"
	       "zp"
	       str_file_no
	       "c_0"
	       str_kanal
	       ".dat"))
      (setq f_name (findfile name_file))
      (setq assa (read_assa f_name))
      (cond ((= int_kanal 1)
;;; Строим зависимость давления от времени
	     (setq pts
		    (mapcar
		      (function	(lambda (el) (sc:pxy_pt el sc_tau sc_01)))
		      assa))
	     (dr:pline pts 256)
	     (setq pt_move (list (* 150.0 int_file_no) 0.0 0.0))
	     (command-s "move" "l" "" pt_move ""))
	    ((= int_kanal 2)
;;; Строим зависимость давления от времени
	     (setq pts
		    (mapcar
		      (function	(lambda (el) (sc:pxy_pt el sc_tau sc_02)))
		      assa))
	     (dr:pline pts 256)
	     (setq pt_move (list (* 150.0 int_file_no) 0.0 0.0))
	     (command-s "move" "l" "" pt_move ""))
	    ((= int_kanal 3)
;;; Строим зависимость перемещения от времени
	     (setq pts
		    (mapcar
		      (function	(lambda (el) (sc:pxy_pt el sc_tau sc_03)))
		      assa))
	     (dr:pline pts 256)
	     (setq pt_move (list (* 150.0 int_file_no) 0.0 0.0))
	     (command-s "move" "l" "" pt_move ""))
	    ((= int_kanal 4)
;;; Строим зависимость напряжения на TP01 от времени
	     (setq pts
		    (mapcar
		      (function	(lambda (el) (sc:pxy_pt el sc_tau sc_04)))
		      assa))
	     (dr:pline pts 256)
	     (setq pt_move (list (* 150.0 int_file_no) 0.0 0.0))
	     (command-s "move" "l" "" pt_move ""))
	    ((= int_kanal 5)
;;; Строим зависимость  напряжения на TP01 от времени
	     (setq pts
		    (mapcar
		      (function	(lambda (el) (sc:pxy_pt el sc_tau sc_05)))
		      assa))
	     (dr:pline pts 256)
	     (setq pt_move (list (* 150.0 int_file_no) 0.0 0.0))
	     (command-s "move" "l" "" pt_move "")))
      (print name_file))))

(defun read_assa  (f_name / fl str val tau par lst assa)
  (setq fl (open f_name "r"))
  (cond	((/= 'str (type f_name))
	 (alert (princ "Переменная f_name не содержит имени файла.")))
	((null fl)
	 (alert (princ (strcat "Не могу открыть файл :" f_name ".")))
	 (exit)))
  (while (setq str (read-line fl))
    (setq str (strcat "(" str ")"))
    (setq val (read str))
    (setq tau  (car val)
	  par  (cadr val)
	  lst  (list (* tau 1.0) (* par 1.0))
	  assa (append assa (list lst))))
  (close fl)
  assa)
