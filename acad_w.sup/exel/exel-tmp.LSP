(VL-LOAD-COM)
(DEFUN exel-open (xls_tbl_pathname	;
		  sheet_name		;
		  /			;
		  awb			;
		  lst_sh		;
		  oex			;
		  shs			;
		  wbs			;
		  sh_name		;
		  sh_lenth		;
		  shs_item		;
)
  (SETQ oex (VLAX-GET-OR-CREATE-OBJECT "Excel.Application"))
  (VLAX-PUT-PROPERTY oex "Visible" :VLAX-TRUE)
  (SETQ wbs (VLAX-GET-PROPERTY oex "Workbooks"))
  (SETQ awb (VLAX-INVOKE-METHOD wbs "Open" xls_tbl_pathname))
  (SETQ shs (VLAX-GET-PROPERTY awb "Worksheets"))
  (VLAX-FOR sh shs
    (SETQ
      sh_name (VLAX-GET-PROPERTY sh "Name")
      lst_sh  (APPEND lst_sh (LIST sh_name))
    )
  )
  (SETQ
    shs_lenth (LENGTH lst_sh)
    shs_item (- shs_lenth (LENGTH (MEMBER sheet_name lst_sh)) -1)
  )
  (VLAX-GET-PROPERTY shs "Item" shs_item)
)

(setq rng(vlax-get-property (exel-open "C:\\Develop\\MNAS_acad_utils\\acad_w.sup\\exel\\Book.xlsx" "Лист1") "UsedRange"))
;;;(exel-open "C:\\Develop\\MNAS_acad_utils\\acad_w.sup\\exel\\Book.xlsx" "Лист1")
;|«Visual LISP© Format Options»
(120 2 40 2 nil "end of" 100 9 2 1 0 T T nil T)
;*** НЕ добавляйте текст под комментариями! ***|;
