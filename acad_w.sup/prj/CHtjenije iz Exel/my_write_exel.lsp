(setq
  ll_list
   '((10. 20. 1. 460.0)
     (10. 20. 2. 460.0)
     (10. 20. 3. 460.0)
     (10. 20. 4. 460.0)
     (10. 20. 5. 460.0)
    )
)

;;;;;;("write_exel" "Запись в таблицу Exel." "Обмен")
(defun c:write_exel
		    (/ oex		;"Excel.Application"
		     wbs		;"Workbooks"
		     cb			;Текущая книга
		     shs		;"Sheets"
		     csh		;Текущий лист
     		     r1			;"Range"
		     row		;Текущая выводимая строка
		     i_column		;i-товая колонка
		     i_rows		;i-товая строка
		     ll_temp		;
)
  (vl-load-com)
  (setq oex (vlax-get-or-create-object "Excel.Application"))
  (vlax-put-property oex "Visible" :vlax-true)
  (vlax-put-property oex "SheetsInNewWorkbook" 1)
  (setq wbs (vlax-get-property oex "Workbooks"))
  (setq cb (vlax-invoke-method wbs "Add"))
  (setq shs (vlax-get-property cb "Sheets"))
  (setq csh (vlax-get-property shs "Item" 1))
  (vlax-put-property csh "Name" "Cool name")
  (setq
    ll_temp ll_list
    i_rows  0
  )
  (repeat
    (length ll_temp)
     (setq
       row    (nth i_rows ll_temp)
       i_rows (1+ i_rows)
     )
     (setq i_column 0)
     (repeat
       (length row)
	(setq r1 (vlax-get-property
		   oex
		   "Range"
		   (strcat (chr (+ (ascii "A") i_column)) (itoa i_rows))
		 )
	)
	(vlax-put-property r1 "value2" (nth i_column row))
	(setq i_column (1+ i_column))
     )
  )
  (vlax-invoke-method
    cb
    "SaveAs"
    (getfiled "Заголовок" "" "xls" 1)
    -4143
    ""
    ""
    :vlax-false
    :vlax-false
    nil
  )
  (vlax-invoke-method oex "Quit")
)