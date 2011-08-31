;;;;;;("read_exel" "„тение их Exel." "ќбмен")
(defun c:read_exel (/ xls_tbl_pathname						; ѕуть к открываемой таблице
		    sheet_no							; Ќомер считываемой из Exel станицы
		    cell_lt							; Ћева€ верхн€€ €чейка
		    cell_rb							; ѕрава€ нижн€€ €чейка
)
  (setq	xls_tbl_pathname
	 (getfiled "«аголовок" "" "xls" 0)
  )
  (setq sheet_no (getint "¬ведите номер страницы Exel:"))
  (setq	cell_lt	(getstring "Ћева€ верхн€€ €чейка<A1>:")
	cell_lt
		(cond
		  ((= "" cell_lt)
		   "A1"
		  )
		  (cell_lt)
		)
  )

  (setq	cell_rb	(getstring "ѕравую нижнюю €чейку из диапазона €чеек:")
	cell_rb
		(cond
		  ((= "" cell_rb)
		   "IV65536"
		  )
		  (cell_rb)
		)
  )
  (read_exel xls_tbl_pathname sheet_no cell_lt cell_rb)
)