;;; Написать функцию выделяющую из списка указанные столбцы
;;;_$ (select_column '((0.0 -10.0 -1.0 -2.0)
;;;	      (1.0 -9.0 -0.9 -1.377)
;;;	      (2.0 -8.0 -0.8 -0.896)
;;;	      (3.0 -7.0 -0.7 -0.539)
;;;	      (4.0 -6.0 -0.6 -0.288)
;;;	      (5.0 -5.0 -0.5 -0.125)
;;;	     )
;;;	    '(3 1 3)
;;;)
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

;;;;;;("exelread" "Производит чтение из Exel." "Обмен")
(defun c:exelread
		  (/ do_dialog ; Признак выхода из диалога
		   dcl_id ; Идентификатор диалога
		   oex ;"Excel.Application"
		   wbs ;"Workbooks"
		   awb ;активная рабочая книга
		   shs ;"Sheets"
)
  (setq do_dialog t)
  (setq	dcl_id (load_dialog
		 (findfile "acad_w.sup/PRJ/CHtjenije iz Exel/graph.DCL")
	       )
  )
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
		  ((getfiled "Выберите таблицу Exel" "" "xls" 0))
		  (t "")
		)
		exelread::setup_lst
	      )
       )
      )
      ((= ac 3) ; open
       (setq exelread::setup_lst
	      (ac_open exelread::setup_lst)
       )
      )

      ((= ac 4) ; read
       (print "ac = 4")
       (setq exelread::setup_lst (ac_open exelread::setup_lst))
      )

      ((= ac 5) ; close
       (vlax-invoke-method oex "Quit")
      )
      ((= ac 6) ; bt_read
       (print "ac = 6")
       (setq shs (vlax-get-property awb "Worksheets"))
       (setq csh (vlax-get-property shs "Item" (1+ (atoi (cadr (assoc "sheets" exelread::setup_lst))))))
       (setq cell_lt (cadr (assoc "start_cell" exelread::setup_lst))
	     cell_rb (cadr (assoc "end_cell" exelread::setup_lst))
       )
       (set (read (cadr (assoc "autolisp_name" exelread::setup_lst))) (read_csh csh cell_lt cell_rb))
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

(defun exelread::ac_1 (setup_lst)
  (mapcar (function
	    (lambda (el)
	      (cond
		(
		 (= 2 (length el))
		 (list (car el) (get_tile (car el)))
		)
		(
		 (= 3 (length el))
		 (list (car el) (get_tile (car el)) (caddr el))
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
(defun subst_by_key (key new_val lst / old_val)
  (setq old_val (assoc key lst))
  (cond
    ((= 2 (length old_val))
     (subst (list key new_val) (assoc key lst) lst)
    )
    ((>= 3 (length old_val))
     (subst (append (list key) new_val) (assoc key lst) lst)
    )
  )
)


(defun ac_open (setup_lst ;
		/ sh ; переменный лист
		xls_tbl_pathname ; Путь к таблице Exel
		lst_sh ; Список имен листов
)

  (setq xls_tbl_pathname (cadr (assoc "xsl_file_name" setup_lst)))

  (vl-load-com)
  (setq oex (vlax-get-or-create-object "Excel.Application"))
  (vlax-put-property oex "Visible" :vlax-true)

  (setq wbs (vlax-get-property oex "Workbooks"))
  (setq	awb (vlax-invoke-method
	      wbs
	      "Open"
	      xls_tbl_pathname
	    )
  )
  (setq shs (vlax-get-property awb "Worksheets"))
  (vlax-for sh shs
    (setq lst_sh (cons (vlax-get-property sh "Name") lst_sh))
  )
  (setq lst_sh (reverse lst_sh))
  (subst_by_key "sheets" (list "0" lst_sh) setup_lst)
)