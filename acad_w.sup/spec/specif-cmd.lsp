(vl-arx-import 'acad_colordlg)

;;;;;;("spec" "Функция простановки позиций." "Размеры")
(defun c:spec
	      (/;
	       dcl_id ;
	       ex_dialog ; Последняя команда в спецификации
	       p_start ; Начало выноски
	       p_polka ; Начало полки
	       a_dir ; Направление полки
	       en_ins ;
	       num_dia ; Номер диалога для отображения
	       line_p0 ; Задает направление линий выравнивания позиций
	       line_p1 ; Задает направление линий выравнивания позиций
	       dlg_1_kv ; Простановка позиций
	       dlg_2_kv ; Настройка
	       dlg_3_kv ; Спецификация
	       dlg_4_kv ; Настройка цветов
	       sp_razd_lst ;
	      )
  (if (null (tblsearch "style" "t"))
    (stl)
  )
  (if (null docum_lst)
    (load
      (strcat (acad_sup) "/spec/Naimjenovanije.lsp")
      (strcat "Не удалось подключить файл с наименованиями документов "
	      (acad_sup)
	      "/spec/Naimjenovanije.lsp"
      )
    )
  )

  (regapp "POZ_SPEC")
  (load_settings)
  (setq
    num_dia	0
    name_dia	(list "позиция" "настройка" "спец" "цвет")
    sp_razd_lst
		(list
		  "Документация"	    "Комплексы"
		  "Сборочные единицы"	    "Детали"
		  "Стандартные изделия"	    "Прочие изделия"
		  "Материалы"		    "Комплекты"
		  "Переменные данные для исполнений"
		  "Снимаемые"
		 )
    dlg_1_kv
		(if
		  dlg_1_kv
		   dlg_1_kv
		   '(("e_1_0" . "")
		     ("e_1_1" . "")
		     ("e_1_2" . "")
		     ("e_1_4" . "")
		     ("e_1_5" . "")
		     ("e_1_6" . "")
		     ("e_1_7" . "")
		     ("e_1_8" . "")
		     ("e_1_9" . "")
		     ("e_1_10" . "")
		     ("e_1_11" . "1")
		     ("p_1_1" . "0")
		     ("p_1_2" . "0")
		    )
		)
    dlg_2_kv
		(if
		  dlg_2_kv
		   dlg_2_kv
		   '(("r_2_1" . "1")
		     ("r_2_2" . "")
		     ("r_2_3" . "")
		     ("r_2_4" . "")
		     ("r_2_5" . "")
		     ("r_2_6" . "1")
		     ("r_2_7" . "")
		     ("r_2_8" . "")
		     ("r_2_9" . "")
		     ("r_2_10" . "1")
		     ("r_2_11" . "")
		     ("t_2_1" . "1")
		     ("t_2_2" . "1")
		     ("t_2_3" . "1")
		    )
		)
    dlg_3_kv
		(if
		  dlg_3_kv
		   dlg_3_kv
		   '(("p_3_1" . "")
		     ("p_3_2" . "")
		     ("p_3_3" . "")
		     ("l_3_1" . "")
		    )
		)

    dlg_4_kv
		(if
		  dlg_4_kv
		   dlg_4_kv
		   '(("i_4_1" . 0) ("i_4_2" . 0) ("i_4_3" . 3) ("i_4_4" . 4))
		)

    d1_sp_curr
		(list
		  (cons 1 "e_1_1") ;Спецификация
		  (cons 2 "e_1_2") ;Вариант
		  (cons 3 "p_1_1") ;Раздел
		  (cons 4 "e_1_4") ;Формат
		  (cons 5 "e_1_5") ;Зона
		  (cons 6 "e_1_6") ;Позиция
		  (cons 7 "e_1_7") ;Обозначение
		  (cons 8 "e_1_8") ;Наименование
		  (cons 9 "e_1_9") ;Количество
		  (cons 10 "e_1_10") ;Примечание
		)
    a_dir	(if (null a_dir)
		  0
		  a_dir
		)
  )

  (setq dcl_id (load_dialog (strcat (acad_sup) "/spec/Specification.dcl")))
  (if (< dcl_id 0)
    (exit)
  )
  (while (null ex_dialog)
    (if	(not (new_dialog (nth num_dia name_dia) dcl_id))
      (exit)
    )
    (cond
      ((= num_dia 0) (func_1))
      ((= num_dia 1) (func_2))
      ((= num_dia 2) (func_3))
      ((= num_dia 3) (func_4))
    )
  )
  (unload_dialog dcl_id)
  (princ)
)


(defun f_naim_oboz (/ n_dial o_dial n_db o_db lst_db)
  (setq
    o_dial (cdr (assoc "e_1_7" dlg_1_kv))
    n_dial (cdr (assoc "e_1_8" dlg_1_kv))
    lst_db (assoc (cons 1 o_dial) docum_lst)
    o_db   (if lst_db
	     (cdr (assoc 1 lst_db))
	     nil
	   )
    n_db   (if lst_db
	     (cdr (assoc 2 lst_db))
	     nil
	   )
  )
  (cond
    ((and (null lst_db) (/= o_dial "") (/= n_dial ""))
     (setq
       docum_lst
	(cons
	  (list (cons 1 o_dial) (cons 2 n_dial))
	  docum_lst
	)
     )
    )
    ((and lst_db (/= o_dial "") (/= n_dial "") (/= n_dial n_db))
     (setq
       docum_lst
	(subst
	  (list (cons 1 o_dial) (cons 2 n_dial))
	  lst_db
	  docum_lst
	)
     )
    )

    ((and n_db (/= n_db "") (= n_dial ""))
     (setq dlg_1_kv (subst (cons "e_1_8" n_db)
			   (assoc "e_1_8" dlg_1_kv)
			   dlg_1_kv
		    )
     )
     (set_tile "e_1_8" (cdr (assoc "e_1_8" dlg_1_kv)))
    )
  )  ;cond
)

(defun strela (an sz / p0 p1)
  (setq
    p0 (polar p_start (- (angle p_start p_polka) an) sz)
    p1 (polar p_start (+ (angle p_start p_polka) an) sz)
  )
  (entmake (list (cons 0 "LINE")
		 (cons 10 p_start)
		 (cons 11 p0)
		 (s_col "i_4_1")
	   )
  )
  (entmake (list (cons 0 "LINE")
		 (cons 10 p_start)
		 (cons 11 p1)
		 (s_col "i_4_1")
	   )
  )
  (entmake (list (cons 0 "LINE")
		 (cons 10 p0)
		 (cons 11 p1)
		 (s_col "i_4_1")
	   )
  )
)

(defun s_col (i_x)
  (cons 62 (cdr (assoc i_x dlg_4_kv)))
)

(defun load_settings (/ temp_1 temp_2 temp_4)
  (if (null dlg_1_kv)
    (setq
      temp_1
       (load (strcat (acad_sup) "/spec/Dialog_Nastrojka.lsp")
	     "\nНе могу открыть \"spec/Dialog_Nastrojka.lsp\""
       )
    ) ;setq
  )  ;if
  (if (null dlg_2_kv)
    (setq
      temp_2
       (load (strcat (acad_sup) "/spec/Dialog_pozicija.lsp")
	     "\nНе могу открыть \"spec/Dialog_pozicija.lsp\""
       )
    ) ;setq
  )
  (if (null dlg_4_kv)
    (setq
      temp_4
       (load (strcat (acad_sup) "/spec/Dialog_Color.lsp ")
	     "\nНе могу открыть \"spec/Dialog_Color.lsp\""
       )
    ) 
  )

  (if (= (type temp_1) 'str)
    (princ temp_1)
  )
  (if (= (type temp_2) 'str)
    (princ temp_2)
  )
  (if (= (type temp_4) 'str)
    (princ temp_4)
  )
)
