(VL-LOAD-COM)

;;;;;;("wlc" "Команда для создания обозначения выноски, обозначающей сварку." "Размеры")
(defun c:wlc  (/ en                     ; Имя примитива LEADER
	       p0                       ; Точка началя выноски
	       p1                       ; Точка начала полки;
	       p2                       ; Точка конца полки
               )
  (load-w-arrows)
  (setq	p0 (getpoint "Укажите начальную точку обозначения сварного шва:")
	p1 (getpoint p0 "Укажите начало полки:")
	p2 (getpoint p1 "Укажите конец полки:"))
  (command-s "_leader" "_non" p0 "_non" p1 "_non" p2 "" "" "_none")
  (setq en (entlast))
  (vlax-put-property (vlax-ename->vla-object en) 'ArrowheadBlock "weld_arrow_bot")
  (w-edit-arrow-dir en))

;;;;;;("wle" "Команда для редактировани обозначения выноски, обозначающей сварку." "Размеры")
(defun c:wle  (/         ;
	       en        ; Имя редактируемого примитива LEADER
	       pnt       ; Точка в которой был выбран примитив LEADER
	       sel       ; Пара имя примитива и точка выбора примитива
	       )
  (load-w-arrows)
  (setq	sel (entsel "Выберите выноску, преобразуемую в сварку:")
	en  (car sel)
	pnt (cadr sel))
  (w-edit-arrow-dir en))

;;;;;;("ed-weld-txt" "ToDo" "Размеры")
(defun c:ed-weld-txt (/ dcl_id en i ss_td str dcl_te_pos te_registry reg_root)
  (prompt "\nВыберите тексты или размеры :")
  (setq en (select) )
  (setq
   dcl_id
   (load_dialog
    (findfile
     (utils:path-src-lsp "mnas/testing/Welding_lsp/welding.dcl"))))
  
  (if (< dcl_id 0)    (exit)   )
  (if (not (new_dialog "mnas_weld_ch_text" dcl_id "" dcl_te_pos))    (exit)  )
  (setq	str
	(cdr (assoc 300  ed))
	str_1
	(cdr (assoc 301  ed))
        )
  (set_tile "dim_string" str)
  (set_tile "dim_string_1" str_1)
  
  (action_tile "accept" "(te_dlg_accept)")

  (start_dialog)
  (unload_dialog dcl_id)
  
  (ch_dxf (cdr (assoc -1 ed)) 300 str)
  (ch_dxf (cdr (assoc -1 ed)) 301 str_1))

;;;;;;("ewt" "ToDo" "Размеры")
(defun c:ewt ()
  (c:ed-weld-txt))

(setq obj
      (vlax-ename->vla-object
       (car (entsel ":"))))

(regapp "MNAS-WELDING")
(vla-setxdata obj
              (vlax-make-variant
               (vlax-make-safearray 
