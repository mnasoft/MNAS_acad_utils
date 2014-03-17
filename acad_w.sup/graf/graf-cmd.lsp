;;;;;;("graf" "Построение графика." "Шкалы")
(defun c:graf  (/		cmdstr		str		lastent ;
		gr_t_str_val ; Значения заголовка, обозначений осей, подрисуночной подписи
		gr_t_str_key ; Ключи заголовка, обозначений осей, подрисуночной подписи
		gr_t_real_val ; Значения, определяющие расположение текста для оформления рисунка
		gr_t_real_key ; Ключи, определяющие расположение текста для оформления рисунка
		gr_n_str_val ; Тип линии и тип точки
		gr_n_str_key ; Ключи для типа линии и точки
		gr_n_real_val ; Значения параметры для отрисовки линий и точек
		gr_n_real_key ; Ключи параметры для отрисовки линий и точек
		action) ;dl_s - Элемент предыдущий первому элементу линии.
	       ;dl_e - Последний элемент линии.
	       ;dp_s - Элемент предыдущий точке.
	       ;dp_e - Элемент точка.
	       ;dn_s - Начальный элемент сетки
	       ;dn_e - Конечный элемент сетки
  (setq li_gr '()) ;Список с точками графика.
  (setq n_li_gr 0) ;Текущий элемент списка.
  (setq gr_t_str_val (list "Заголовок" "x" "y" "Рис. 1"))
  (setq	gr_t_str_key
	 (list "zagolovok" ;Текст заголовока.
	       "x_axis" ;Текст на оси X.
	       "y_axis" ;Текст на оси Y.
	       "risunok" ;Подрисуночный текст.
	       ))
  (setq gr_t_real_val (list 5.0 10.0 5.0 5.0 5.0 5.0 5.0 5.0 15.0))
  (setq	gr_t_real_key
	 (list "h_tt" ;Высота заголовка
	       "d_tt" ;Смещение заголовка
	       "h_axis" ;Высота текста на осях
	       "d_tx" ;Смещение текста оси X по оси X
	       "d_ty" ;Смещение текста оси Y по оси Y
	       "h_net" ;Высота текста на сетке
	       "d_net" ;Смещение текста от сетки
	       "h_tr" ;Высота прдрисуночной надписи
	       "d_tr" ;Смещение подрисуночной надписи
)	)
  (setq gr_n_str_val (list "CONTINUOUS" ""))
  (setq	gr_n_str_key
	 (list "l_type" ;Тип линии для графика.
	       "point_bl" ;Имя блока для точки.
	       ))
  (setq gr_n_real_val (list 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 1. 1. 0.0 0.0 7 0.0 0.0 7))
  (setq	gr_n_real_key
	 (list "min_x" ;Минимальная координата сетки по X
	       "max_x" ;Максимальная координата сетки по X
	       "min_y" ;Минимальная координата сетки по Y
	       "max_y" ;Максимальная координата сетки по Y
	       "dx" ;Приращение основных делений сетки по X
	       "dy" ;Приращение основных делений сетки по Y
	       "sub_x" ;Приращение вспомогательных делений сетки по X
	       "sub_y" ;Приращение вспомогательных делений сетки по Y
	       "ps_x" ;Коэффициент масштабирования сетки по X
	       "ps_y" ;Коэффициент масштабирования сетки по Y
	       "pp_x" ;Начало координат по X
	       "pp_y" ;Начало координат по Y
	       "l_color" ;Цвет линии
	       "sc_x_bl" ;Масштаб блока по оси Х
	       "sc_y_bl" ;Масштаб блока по оси Y
	       "color_bl" ;Цвет блока
	       ))
  (setvar "cmdecho" 0)
  (draw_point)
  (draw_line)
  (draw_net)
  (setq cmdstr "09 Home Tail Next Prev Flash APast ABefor EDit ERase TExt Net  Load Save Exit")
  (setq l_ent (entlast))
  (setq str "APast")
  (setq lastcmd str)
  (while (/= str "Exit")
    (setq poi (itoa n_li_gr))
    (setq li_len (length li_gr))
    (if	(> li_len 0)
      (progn (setq ptt (nth (- li_len n_li_gr) li_gr))
	     (setq str_1 (strcat "{" (rtos (car ptt)) "," (rtos (cadr ptt)) "}")))
      (setq str_1 ""))
    (setq ask (strcat "\n" cmdstr " < " str " > :{" poi "}" str_1))
    (initget cmdstr)
    (setq str (getkword ask))
    (if	(/= str nil)
      (setq lastcmd str)
      (setq str lastcmd))
    (cond ((= str "Save")
	   (setq s (getstring "\n Введите имя файла для сохранения:"))
	   (if (null s)
	     (progn (alert (princ (strcat "\nИмя файла не задано.\n"))) (exit)))
	   (setq ff (open s "w"))
	   (if (null ff)
	     (progn (alert (princ (strcat "Не могу отурыть файл :" s "."))))
	     (progn (foreach n	(list li_gr		n_li_gr		  gr_t_str_val
				      gr_t_str_key	gr_t_real_val	  gr_t_real_key
				      gr_n_str_val	gr_n_str_key	  gr_n_real_val
				      gr_n_real_key)
		      (print n ff))
		    (close ff))))
	  ((= str "Load")
	   (setq s (getstring "\n Введите имя файла для загрузки:"))
	   (setq ff (open s "r"))
	   (if (null ff)
	     (progn (princ "Ошибка! Файл ") (prin1 s) (princ " не существует."))
	     (progn (read-line ff)
		    (setq li_gr (read (read-line ff)))
		    (setq n_li_gr (read (read-line ff)))
		    (setq gr_t_str_val (read (read-line ff)))
		    (setq gr_t_str_key (read (read-line ff)))
		    (setq gr_t_real_val (read (read-line ff)))
		    (setq gr_t_real_key (read (read-line ff)))
		    (setq gr_n_str_val (read (read-line ff)))
		    (setq gr_n_str_key (read (read-line ff)))
		    (setq gr_n_real_val (read (read-line ff)))
		    (setq gr_n_real_key (read (read-line ff)))
		    (close ff)
		    (del_point)
		    (del_line)
		    (del_net)
		    (draw_net)
		    (draw_line)
		    (draw_point)
		    (princ "\nФайл ")
		    (prin1 s)
		    (princ " загружен..."))))
	  ((= str "TExt")
	   (gr_text)
	   (if (= action 1)
	     (progn (del_net) (draw_net)))
	   (setq action 0))
	  ((= str "09") (command "_zoom" "_e") (command "_zoom" "0.9x"))
	  ((= str "Net")
	   (gr_net)
	   (if (= action 1)
	     (progn (del_net) (del_line) (del_point) (draw_net) (draw_line) (draw_point)))
	   (setq action 0))
	  ((= str "Flash") (c:ff) (del_point) (draw_point) (del_line) (draw_line))
	  ((= str "Tail")
	   (if (< n_li_gr li_len)
	     (setq n_li_gr li_len))
	   (del_point)
	   (draw_point))
	  ((= str "Next")
	   (if (< n_li_gr li_len)
	     (setq n_li_gr (+ n_li_gr 1)))
	   (del_point)
	   (draw_point))
	  ((= str "Home")
	   (if (> n_li_gr 1)
	     (setq n_li_gr 1))
	   (del_point)
	   (draw_point))
	  ((= str "Prev")
	   (if (> n_li_gr 1)
	     (setq n_li_gr (- n_li_gr 1)))
	   (del_point)
	   (draw_point))
	  ((= str "EDit")
	   (if (/= n_gr_li 0)
	     (progn (setq po (getpoint "\nEnter point:"))
		    (if	(/= po nil)
		      (setq li_gr (subst po ptt li_gr)))
		    (del_point)
		    (draw_point)
		    (del_line)
		    (draw_line))))
	  ((= str "ERase")
	   (if (> (length li_gr) 0)
	     (progn (setq li_gr (ll_del_i li_gr n_li_gr))
		    (if	(> n_li_gr 1)
		      (setq n_li_gr (1- n_li_gr)))
		    (if	(= (length li_gr) 0)
		      (setq n_li_gr 0))
		    (del_point)
		    (draw_point)
		    (del_line)
		    (draw_line))))
	  ((= str "APast")
	   (setq n_counter li_len)
	   (setq s_2 '())
	   (while (> n_counter n_li_gr)
	     (setq ptt (car li_gr))
	     (setq s_2 (cons ptt s_2))
	     (setq li_gr (cdr li_gr))
	     (setq n_counter (- n_counter 1)))
	   (setq ptt nil)
	   (while (= ptt nil) (setq ptt (getpoint "\nВведите точку:")))
	   (setq li_gr (cons ptt li_gr))
	   (while (/= s_2 nil)
	     (setq ptt (car s_2))
	     (setq li_gr (cons ptt li_gr))
	     (setq s_2 (cdr s_2)))
	   (setq n_li_gr (+ n_li_gr 1))
	   (setq li_len (+ li_len 1))
	   (del_point)
	   (draw_point)
	   (del_line)
	   (draw_line))
	  ((= str "ABefor")
	   (setq n_counter li_len)
	   (setq s_2 '())
	   (while (and (>= n_counter n_li_gr) (/= 0 n_counter))
	     (setq ptt (car li_gr))
	     (setq s_2 (cons ptt s_2))
	     (setq li_gr (cdr li_gr))
	     (setq n_counter (- n_counter 1)))
	   (setq ptt nil)
	   (while (= ptt nil) (setq ptt (getpoint "\nВведите точку:")))
	   (setq li_gr (cons ptt li_gr))
	   (while (/= s_2 nil)
	     (setq ptt (car s_2))
	     (setq li_gr (cons ptt li_gr))
	     (setq s_2 (cdr s_2)))
	   (if (= n_li_gr 0)
	     (setq n_li_gr (+ n_li_gr 1)))
	   (del_point)
	   (draw_point)
	   (del_line)
	   (draw_line))))
  (del_point)
  (setvar "cmdecho" 1))




(defun gr_text	()
  (setq ted_dcl_id (load_dialog (findfile "acad_w.sup/graf/graf.dcl")))
  (if (< ted_dcl_id 0)
    (exit))
  (if (not (new_dialog "gr_text" ted_dcl_id))
    (exit))
  (mapcar 'set_str gr_t_str_key gr_t_str_val)
  (mapcar 'set_real gr_t_real_key gr_t_real_val)
  (action_tile "accept" "(gr_text_ok)")
  (start_dialog)
  (unload_dialog ted_dcl_id))

(defun gr_text_ok  ()
  (setq gr_t_str_val (mapcar 'get_str gr_t_str_key))
  (setq gr_t_real_val (mapcar 'get_real gr_t_real_key))
  (done_dialog)
  (setq action 1))

(defun set_str (a b) (set_tile a b))
(defun get_str (a) (get_tile a))
(defun set_real (a b) (set_tile a (rtos b)))
(defun get_real (a) (atof (get_tile a)))

(defun gr_net  ()
  (setq ted_dcl_id (load_dialog (findfile "acad_w.sup/graf/graf.dcl")))
  (if (< ted_dcl_id 0)
    (exit))
  (if (not (new_dialog "gr_net" ted_dcl_id))
    (exit))
  (mapcar 'set_str gr_n_str_key gr_n_str_val)
  (mapcar 'set_real gr_n_real_key gr_n_real_val)
  (action_tile "accept" "(gr_net_ok)")
  (start_dialog)
  (unload_dialog ted_dcl_id))

(defun gr_net_ok  ()
  (setq gr_n_str_val (mapcar 'get_str gr_n_str_key))
  (setq gr_n_real_val (mapcar 'get_real gr_n_real_key))
  (done_dialog)
  (setq action 1))

(defun del_net () (del_ent dn_s dn_e))

(defun draw_net	 (/ xmi xma yma ymi dx dy)
  (setq	xmi (find_by_key "min_x" gr_n_real_key gr_n_real_val)
	xma (find_by_key "max_x" gr_n_real_key gr_n_real_val)
	ymi (find_by_key "min_y" gr_n_real_key gr_n_real_val)
	yma (find_by_key "max_y" gr_n_real_key gr_n_real_val)
	dx  (find_by_key "dx" gr_n_real_key gr_n_real_val)
	dy  (find_by_key "dy" gr_n_real_key gr_n_real_val)
	sdx (find_by_key "sub_x" gr_n_real_key gr_n_real_val)
	sdy (find_by_key "sub_y" gr_n_real_key gr_n_real_val))
  (setq dn_s (entlast))
  (if (and (> xma xmi) (> yma ymi) (> dx 0) (> dy 0))
    (progn (setq a xmi)
	   (while (<= a xma)
	     (entmake (list (cons 0 "LINE")
			    (cons 62 1)
			    (cons 10 (preobr_pt (list a ymi 0.0)))
			    (cons 11 (preobr_pt (list a yma 0.0)))))
	     (entmake (list (cons 0 "TEXT")
			    (cons 10 (list 0.0 0.0 0.0)) ;Начальная точка
			    (cons 40 (find_by_key "h_net" gr_t_real_key gr_t_real_val)) ;Высота
			    (cons 1 (rtos a))
			    (cons 62 7) ;(cons 50 0.0)
			    (cons 71 0)
			    (cons 72 1)
			    (cons 11
				  (polar (preobr_pt (list a ymi 0.0))
					 (* pi 1.5)
					 (find_by_key "d_net" gr_t_real_key gr_t_real_val)))
			    (cons 73 3)) ;list
		      ) ;entmake
	     (if (> sdx 0.0)
	       (progn (setq b (+ a sdx))
		      (while (and (< b (+ a dx)) (< b xma))
			(entmake (list (cons 0 "LINE")
				       (cons 62 7)
				       (cons 10 (preobr_pt (list b ymi 0.0)))
				       (cons 11 (preobr_pt (list b yma 0.0)))) ;list
				 ) ;entmake
			(setq b (+ b sdx))) ;while
		      )) ;if
	     (setq a (+ a dx))) ;while
	   (setq a ymi)
	   (while (<= a yma)
	     (entmake (list (cons 0 "LINE")
			    (cons 62 1)
			    (cons 10 (preobr_pt (list xmi a 0.0)))
			    (cons 11 (preobr_pt (list xma a 0.0)))) ;list
		      ) ;entmake
	     (entmake (list (cons 0 "TEXT")
			    (cons 10 (list 0.0 0.0 0.0)) ;Начальная точка
			    (cons 40 (find_by_key "h_net" gr_t_real_key gr_t_real_val)) ;Высота
			    (cons 1 (rtos a))
			    (cons 62 7) ;(cons 50 0.0)
			    (cons 71 0)
			    (cons 72 2)
			    (cons 11
				  (polar (preobr_pt (list xmi a 0.0))
					 (* pi 1.)
					 (find_by_key "d_net" gr_t_real_key gr_t_real_val)))
			    (cons 73 2)) ;list
		      ) ;entmake
	     (if (> sdy 0.0)
	       (progn (setq b (+ a sdy))
		      (while (and (< b (+ a dy)) (< b yma))
			(entmake (list (cons 0 "LINE")
				       (cons 62 7)
				       (cons 10 (preobr_pt (list xmi b 0.0)))
				       (cons 11 (preobr_pt (list xma b 0.0)))) ;list
				 ) ;entmake
			(setq b (+ b sdy))) ;while
		      )) ;if
	     (setq a (+ a dy))) ;while
	   (entmake (list (cons 0 "TEXT")
			  (cons 10 (list 0.0 0.0 0.0)) ;Начальная точка
			  (cons 40 (find_by_key "h_tt" gr_t_real_key gr_t_real_val)) ;Высота
			  (cons 1 (find_by_key "zagolovok" gr_t_str_key gr_t_str_val))
			  (cons 72 1)
			  (cons	11
				(polar (preobr_pt (list (/ (+ xma xmi) 2.) yma 0.0))
				       (* pi 0.5)
				       (find_by_key "d_tt" gr_t_real_key gr_t_real_val)))
			  (cons 73 1))) ;entmake
	   (entmake (list (cons 0 "TEXT")
			  (cons 10 (list 0.0 0.0 0.0)) ;Начальная точка
			  (cons 40 (find_by_key "h_axis" gr_t_real_key gr_t_real_val)) ;Высота
			  (cons 1 (find_by_key "x_axis" gr_t_str_key gr_t_str_val))
			  (cons 72 0)
			  (cons	11
				(polar (preobr_pt (list xma ymi 0.0))
				       (* pi 0.0)
				       (find_by_key "d_tx" gr_t_real_key gr_t_real_val)))
			  (cons 73 2))) ;entmake
	   (entmake (list (cons 0 "TEXT")
			  (cons 10 (list 0.0 0.0 0.0)) ;Начальная точка
			  (cons 40 (find_by_key "h_axis" gr_t_real_key gr_t_real_val)) ;Высота
			  (cons 1 (find_by_key "y_axis" gr_t_str_key gr_t_str_val))
			  (cons 72 1)
			  (cons	11
				(polar (preobr_pt (list xmi yma 0.0))
				       (* pi 0.5)
				       (find_by_key "d_ty" gr_t_real_key gr_t_real_val)))
			  (cons 73 1))) ;entmake
	   (entmake (list (cons 0 "TEXT")
			  (cons 10 (list 0.0 0.0 0.0)) ;Начальная точка
			  (cons 40 (find_by_key "h_tr" gr_t_real_key gr_t_real_val)) ;Высота
			  (cons 1 (find_by_key "risunok" gr_t_str_key gr_t_str_val))
			  (cons 72 1)
			  (cons	11
				(polar (preobr_pt (list (/ (+ xmi xma) 2.0) ymi 0.0))
				       (* pi -0.5)
				       (find_by_key "d_tr" gr_t_real_key gr_t_real_val)))
			  (cons 73 3)))))
  (setq dn_e (entlast)))

(defun find  (val lis / i j)
  (setq	i (length lis)
	j nil)
  (while (/= i 0)
    (setq i (1- i))
    (if	(equal val (nth i lis))
      (progn (setq j i) (setq i 0))))
  (setq j j))

(defun find_by_key (key ll_key ll_find) (nth (find key ll_key) ll_find))

(defun del_ent	(name1 name2 / name)
  (if (not (eq name1 name2))
    (progn (setq name name1)
	   (while (and (not (eq (setq name (entnext name)) name2)) (not (eq name nil)))
	     (entdel name)) ;while
	   (if (and (not (eq name2 nil)) (not (eq name1 name2)))
	     (entdel name2)) ;if
	   )   ;progn
    )	       ;if
  )

(defun ll_del_i	 (ll1 i / name ll2 len j)
	       ;Функция предназначена для удаления из списка ll1 i-того элемента с конца.
	       ;Последний элемент - i=1.
  (setq len (length ll1))
  (setq j len)
  (setq ll2 nil)
  (while (> j 0)
    (if	(/= j i)
      (progn (setq name (nth (- len j) ll1)) (setq ll2 (cons name ll2))) ;progn
      )	       ;if
    (setq j (1- j))) ;while
  (reverse ll2))

(defun del_line () (del_ent dl_s dl_e))

(defun draw_line  (/ li_l)
  (setq dl_s (entlast))
  (setq li_l (length li_gr))
  (while (> li_l 1)
    (entmake (list (cons 0 "LINE")
		   (cons 6 (find_by_key "l_type" gr_n_str_key gr_n_str_val))
		   (cons 62 (find_by_key "l_color" gr_n_real_key gr_n_real_val))
		   (cons 10 (preobr_pt (nth (- li_l 1) li_gr)))
		   (cons 11 (preobr_pt (nth (- li_l 2) li_gr)))) ;list
	     ) ;entmake
    (setq li_l (1- li_l)))
  (setq dl_e (entlast)))

(defun preobr_pt  (pt / x y z)
  (setq x (car pt))
  (setq y (cadr pt))
  (setq z (caddr pt))
  (setq x_sc (find_by_key "ps_x" gr_n_real_key gr_n_real_val))
  (setq y_sc (find_by_key "ps_y" gr_n_real_key gr_n_real_val))
  (setq x0 (find_by_key "pp_x" gr_n_real_key gr_n_real_val))
  (setq y0 (find_by_key "pp_y" gr_n_real_key gr_n_real_val))
  (setq x (+ (* x x_sc) x0))
  (setq y (+ (* y y_sc) y0))
  (setq pt (list x y z)))

(defun del_point () (del_ent dp_s dp_e))

(defun draw_point  (/ li_l pt)
  (setq dp_s (entlast))
  (setq li_l (length li_gr))
  (if (> li_l 0)
    (progn (setq pt (preobr_pt (nth (- li_l n_li_gr) li_gr))) (command "_point" "_non" pt)))
  (setq dp_e (entlast)))
