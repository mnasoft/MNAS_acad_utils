(defun база_данных  (/ ex_dialog action dcl_id)
  (setq	dcl_id
	 (load_dialog (findfile "acad_w.sup/Спецификация/Специф.dcl")))
  (if (< dcl_id 0)
    (exit))
  (while (null ex_dialog)
    (if	(not (new_dialog "база_данных" dcl_id))
      (exit))
    (база_данных-setup_ac)
    (бд_setup_dialog)
    (setq action (start_dialog))
    (cond ((= action 0) (setq ex_dialog t))
	  ((= action 1) (setq ex_dialog t))))
  (unload_dialog dcl_id))

(defun база_данных-setup_ac  ()
  (action_tile "help" "(бд_ac_1_help)")
  (action_tile "info" "(бд_ac_1_info)")
  (action_tile "b_5_1" "(бд_ac_b_5_1)")
  (action_tile "b_5_2" "(бд_ac_b_5_2)")
  (action_tile "b_5_3" "(бд_ac_b_5_3)")
  (action_tile "b_5_4" "(бд_ac_b_5_4)")
  (action_tile "b_5_5" "(бд_ac_b_5_5)")
  (action_tile "l_5_1" "(бд_ac_l_5_1 $value)"))

(defun бд_ac_l_5_1  (val)
  (заполнить_формат...описание
    (nth (atoi val) бд_наименование)))

(defun заполнить_формат...описание  (список)
  (set_tile "e_5_6" (cdr (assoc 3 список)))
;;;Формат
  (set_tile "e_5_7" (cdr (assoc 1 список)))
;;;Обозначение
  (set_tile "e_5_8" (cdr (assoc 2 список)))
;;;Наименование
  (set_tile "e_5_9" (cdr (assoc 4 список)))
;;;Материал
  (set_tile "e_5_10" (cdr (assoc 5 список)))
;;;Примечание
  (set_tile "e_5_11" (cdr (assoc 6 список)))
;;;Описание
  )



;;;  : edit_box  { label="Примечание"; key="e_5_9";}
;;;   : edit_box  { label="Описание"; key="e_5_10";}

(defun бд_ac_1_help  ()
  (alert
    "Разработал Матвеев Н.А.,\nsite: http://www.mnasoft.mksat.net"))

(defun бд_ac_1_info  ()
  (alert
    "Разработал Матвеев Н.А.,\nsite: http://www.mnasoft.mksat.net"))


(defun бд_ac_b_5_1 () (alert "Добавить"))
(defun бд_ac_b_5_2 () (alert "Удалить"))

(defun бд_ac_b_5_3 () (alert "Обновить"))

(defun бд_ac_b_5_4 () (alert "Вып. запрос"))

(defun бд_ac_b_5_5 () (alert "Сохранить"))

(defun бд_setup_dialog	(/ str_in_l_box)
  (load (findfile "acad_w.sup/spec/bd_naimjenovanije.lsp"))
  (setq	str_in_l_box
	 (mapcar (function (lambda (el)
			     (setq обознач.   (cdr (assoc 1 el))
				   наим.      (cdr (assoc 2 el))
				   формат     (cdr (assoc 3 el))
				   материал   (cdr (assoc 4 el))
				   примечание (cdr (assoc 5 el))
				   описание   (cdr (assoc 6 el)))
			     (strcat формат    "\t"	 обознач.
				     "\t"      наим.	 "\t"
				     материал  "\t"	 примечание
				     "\t"      описание)))
		 бд_наименование))
  (start_list "l_5_1")
  (mapcar 'add_list str_in_l_box)
  (end_list)) ;setup_dialog

(defun бд_от_расшифровки_к_базе_наименование  ()
  (setq	fn (getfiled "Открытие файла для добавления в базу наименование"
		     ""
		     "txt"
		     0)
	fl (open fn "r"))
  (cond	((/= 'str (type fn))
	 (alert (princ "Переменная fn не содержит имени файла.")))
	((null fl)
	 (alert (princ (strcat "Не могу открыть файл: " fn ".")))
	 (exit)))
  (while (setq str (read-line fl))
    (setq l_str	(str_token str "|")
	  l_str	(mapcar	(function (lambda (el / str1)
				    (setq str1 el
					  str1 (vl-string-right-trim " " str1)
					  str1 (vl-string-left-trim " " str1))))
			l_str))
    (setq Формат		 (nth 0 l_str)
	  Спецификация		 (nth 1 l_str)
	  Обозначение		 (nth 2 l_str)
	  Наименование		 (nth 3 l_str)
	  Кол-во		 (nth 4 l_str)
	  Примечание		 (nth 5 l_str)
	  Материал		 (cond ((nth 6 l_str))
				       (t ""))
	  запись_бд_наименование (list (cons 1 Обозначение)
				       (cons 2 Наименование)
				       (cons 3 Формат)
				       (cons 4 Материал)
				       (cons 5 Примечание)
				       (cons 6 ""))
	  бд_наименование	 (append бд_наименование
					 (list запись_бд_наименование))))
  (close fl))

(defun бд_от_расшифровки_к_базе_спецификация () t)
