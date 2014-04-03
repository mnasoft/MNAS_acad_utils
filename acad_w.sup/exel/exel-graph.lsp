;;;f;;;("select_column" "Выполняет выборку из списка, указанных столбцыов.\n
;;;f;;;Аргументы:
;;;f;;;matrix - список, состояший из списков.\n
;;;f;;;lst    - список, содержащий номера отбираемых столбцов.\n
;;;f;;;Пример использования:
;;;f;;;_$ (select_column '((0.0 -10.0 -1.0 -2.0)
;;;f;;;	      (1.0 -9.0 -0.9 -1.377)
;;;f;;;	      (2.0 -8.0 -0.8 -0.896)
;;;f;;;	      (3.0 -7.0 -0.7 -0.539)
;;;f;;;	      (4.0 -6.0 -0.6 -0.288)
;;;f;;;	      (5.0 -5.0 -0.5 -0.125)
;;;f;;;	     )
;;;f;;;	    '(3 1)
;;;f;;;)
;;;f;;;")
(defun select_column (matrix lst)
  (mapcar
    (function
      (lambda (el)
	(mapcar
	  (function
	    (lambda (el1)
	      (nth el1 el)
	    )
	  )
	  lst
	)
      )
    )
    matrix
  )
)

;;;;;;("exel_read" "Чтение данных из Exel" "Обмен")
(defun c:exel_read
		   (/			;
		    do_dialog		; - Признак выхода из диалога
		    dcl_id		; - Идентификатор диалога
		    oex			; - "Excel.Application"
		    wbs			; - "Workbooks"
		    awb			; - Активная рабочая книга
		    shs			; - "Sheets"
		    csh			; -		
		    ac			; - Акция диалога
		    cell_lt		; - Левая верхняя ячейка
		    cell_rb		; - Правая нижняя ячейка
;;; Globals:
;;; EXELREAD::DIA_POS - Координаты диалога.
;;; EXELREAD::SETUP_LST - Список с настройками диалога.
)
  (setq do_dialog t)
  (setq dcl_id (load_dialog (findfile "acad_w.sup/exel/graph.DCL")))
  (while do_dialog
    (if	(not (new_dialog "exelread" dcl_id "" exelread::dia_pos))
      (exit)
    )
    (exelread::init exelread::setup_lst)
    (mapcar
      (function
	(lambda	(el)
	  (action_tile
	    (car el)
	    "(setq exelread::setup_lst (exelread::ac_1 exelread::setup_lst))"
	  )
	)
      )
      exelread::setup_lst
    )
    (action_tile "cancel" "(setq exelread::dia_pos(done_dialog 0))")
    (action_tile "accept" "(setq exelread::dia_pos(done_dialog 1))")
    (action_tile "..." "(setq exelread::dia_pos(done_dialog 2))")
    (action_tile "open" "(setq exelread::dia_pos(done_dialog 3))")
    (action_tile "read" "(setq exelread::dia_pos(done_dialog 4))")
    (action_tile "close" "(setq exelread::dia_pos(done_dialog 5))")
    (action_tile "bt_read" "(setq exelread::dia_pos(done_dialog 6))")

    (setq ac (start_dialog))
    (cond
      ((= ac 0) (setq do_dialog nil))
      ((= ac 1) (setq do_dialog nil))
      ((= ac 2)
       (setq exelread::setup_lst
	      (subst_by_key
		"xsl_file_name"
		(cond
		  ((getfiled "Выберите таблицу Exel" "" "xls;xlsx" 0))
		  (t "")
		)
		exelread::setup_lst
	      )
       )
      )
      ((= ac 3)				; open
       (setq exelread::setup_lst
	      (ac_open exelread::setup_lst)
       )
      )

      ((= ac 4)				; read
       (print "ac = 4")
       (setq exelread::setup_lst (ac_open exelread::setup_lst))
      )

      ((= ac 5)				; close
       (vlax-invoke-method oex "Quit")
      )
      ((= ac 6)				; bt_read
       (print "ac = 6")
       (setq shs (vlax-get-property awb "Worksheets"))
       (setq csh (vlax-get-property shs "Item" (1+ (atoi (cadr (assoc "sheets" exelread::setup_lst))))))
       (setq cell_lt (cadr (assoc "start_cell" exelread::setup_lst))
	     cell_rb (cadr (assoc "end_cell" exelread::setup_lst))
       )
       (vl-doc-set
	 (read (cadr (assoc "autolisp_name" exelread::setup_lst)))
	 (read_csh csh cell_lt cell_rb)
       )
      )
    )
  )
  (unload_dialog dcl_id)
)

(defun exelread::init (setup_lst)
  (mapcar
    (function
      (lambda (el)
	(cond
	  (
	   (= 2 (length el))
	   (set_tile (car el) (cadr el))
	  )
	  (
	   (= 3 (length el))
	   (start_list (car el))
	   (mapcar (function add_list) (caddr el))
	   (end_list)
	   (set_tile (car el) (cadr el))
	  )
	)
      )
    )
    setup_lst
  )
)

(DEFUN exelread::ac_1 (setup_lst)
  (MAPCAR
    (FUNCTION
      (LAMBDA (el)
	(COND
	  (
	   (= 2 (LENGTH el))
	   (LIST (CAR el) (GET_TILE (CAR el)))
	  )
	  (
	   (= 3 (LENGTH el))
	   (LIST (CAR el) (GET_TILE (CAR el)) (CADDR el))
	  )
	)
      )
    )
    setup_lst
  )
)

;;;_$ (subst_by_key "xsl_file_name" "D:\\Documents and Settings\\namatv\\Рабочий стол\\1.xls" '(("xsl_file_name" "") ("ByRow" "0") ("ByColumn" "1") ("start_cell" "A1") ("end_cell" "IV65536") ("autolisp_name" "Alsp_nm") ("sheets" "0" ("")) ("error" "")))
;;;(("xsl_file_name" "D:\\Documents and Settings\\namatv\\Рабочий стол\\1.xls") ("ByRow" "0") ("ByColumn" "1") ("start_cell" "A1") ("end_cell" "IV65536") ("autolisp_name" "Alsp_nm") ("sheets" "0" ("")) ("error" ""))
;;;_$ (subst_by_key "sheets" (list "0" (list "" "1" "2" "3" "4")) '(("xsl_file_name" "") ("ByRow" "0") ("ByColumn" "1") ("start_cell" "A1") ("end_cell" "IV65536") ("autolisp_name" "Alsp_nm") ("sheets" "0" ("")) ("error" "")))
;;;(("xsl_file_name" "") ("ByRow" "0") ("ByColumn" "1") ("start_cell" "A1") ("end_cell" "IV65536") ("autolisp_name" "Alsp_nm") ("sheets" "0" ("" "1" "2" "3" "4")) ("error" ""))
(DEFUN subst_by_key (key new_val lst / old_val)
  (SETQ old_val (ASSOC key lst))
  (COND
    ((= 2 (LENGTH old_val))
     (SUBST (LIST key new_val) (ASSOC key lst) lst)
    )
    ((>= 3 (LENGTH old_val))
     (SUBST (APPEND (LIST key) new_val) (ASSOC key lst) lst)
    )
  )
)

(DEFUN ac_open (setup_lst		;
		/ sh			; переменный лист
		xls_tbl_pathname	; Путь к таблице Exel
		lst_sh			; Список имен листов
)

  (SETQ xls_tbl_pathname (CADR (ASSOC "xsl_file_name" setup_lst)))

  (VL-LOAD-COM)
  (SETQ oex (VLAX-GET-OR-CREATE-OBJECT "Excel.Application"))
  (VLAX-PUT-PROPERTY oex "Visible" :VLAX-TRUE)

  (SETQ wbs (VLAX-GET-PROPERTY oex "Workbooks"))
  (SETQ awb (VLAX-INVOKE-METHOD wbs "Open" xls_tbl_pathname))
  (SETQ shs (VLAX-GET-PROPERTY awb "Worksheets"))
  (VLAX-FOR sh shs
    (SETQ lst_sh (CONS (VLAX-GET-PROPERTY sh "Name") lst_sh))
  )
  (SETQ lst_sh (REVERSE lst_sh))
  (subst_by_key "sheets" (LIST "0" lst_sh) setup_lst)
)

(DEFUN select_colunm (lst n1 n2)
  (MAPCAR
    (FUNCTION
      (LAMBDA (el)
	(LIST (NTH n1 el) (NTH n2 el))
      )
    )
    lst
  )
)

(DEFUN select_by_type (lst / lst_rez)
  (MAPCAR
    (FUNCTION
      (LAMBDA (el)
	(IF
	  (APPLY (FUNCTION =) (CONS T (MAPCAR (FUNCTION is_real) el)))
	   (SETQ lst_rez (APPEND lst_rez (LIST el)))
	)
      )
    )
    lst
  )
  lst_rez
)

(DEFUN is_real (n)
  (= 'real (TYPE n))
)
  
(SETQ a0 (select_by_type (select_colunm alsp_nm 4 0)))
(SETQ a1 (select_by_type (select_colunm alsp_nm 4 1)))
(SETQ a2 (select_by_type (select_colunm alsp_nm 4 2)))
(SETQ a3 (select_by_type (select_colunm alsp_nm 4 3)))
(SETQ a5 (select_by_type (select_colunm alsp_nm 4 5)))
(SETQ a6 (select_by_type (select_colunm alsp_nm 4 6)))
(SETQ a7 (select_by_type (select_colunm alsp_nm 4 7)))
(SETQ a8 (select_by_type (select_colunm alsp_nm 4 8)))
(SETQ a9 (select_by_type (select_colunm alsp_nm 4 9)))
;|«Visual LISP© Format Options»
(120 2 40 2 nil "end of" 100 9 2 1 0 T T nil T)
;*** НЕ добавляйте текст под комментариями! ***|;
