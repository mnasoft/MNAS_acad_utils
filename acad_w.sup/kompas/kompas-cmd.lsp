(vl-arx-import 'startapp)

;;;;;;("kompas_in" "Импорт из сиситемы КОМПАС V4." "Обмен")
(defun c:kompas_in  (/ l_str l_func fn fl fn_wo_ext exten eof no_view curr_color)
;;;km:read-from-file - Ввод строки  
;;;km:atrib_for_ent - Возвращает номер атрибута для примитива
;;;km:atr_dwg - Установка текущего атрибута пера атрибут пера - номер цвета
;;;no_view - Номер слоя для данного вида  
;;;curr_color - Текущий цвет
  (setq	no_view	"0"
	curr_color 1)
  (setq	l_func	  (list	(cons "ARC" km:arc_dwg)
			(cons "LINE" km:line_dwg)
			(cons "CIRCLE" km:circle_dwg)
			(cons "HATCH" km:hatch_dwg)
			(cons "ATR" km:atr_dwg))
	fn	  (getfiled "Им sf - файла" "" "sf;frg;cad" 0)
	exten	  (car (reverse (str_token fn ".")))
	fn_wo_ext (substr fn 1 (- (strlen fn) (strlen exten))))
  (cond	((or (= (strcase exten t) "frg") (= (strcase exten t) "cad"))
	 (startapp (findfile "acad_w.sup/kompas/cad_sf.bat") fn)
	 (getstring "<>")))
  (setq fl (open (strcat fn_wo_ext "sf") "r"))
  (if (null fl)
    (progn (alert (princ (strcat "" fn_wo_ext "sf" "."))) (exit)))
  (while (null eof)
    (setq l_str (str_token (km:read-from-file) " ,=\t\n"))
    (if	(car l_str)
      (setq f_nm (cdr (assoc (strcase (car l_str)) l_func)))
      (setq f_nm nil))
    (if	f_nm
      (f_nm)
      (progn (cond ((null l_str))
		   ((= "View" (substr (car l_str) 1 4)) (setq no_view (substr (car l_str) 5)))))))
  (close fl)
  (princ))


;;;;;;("kompas_out" "Экспорт в систему КОМПАС V4." "Обмен")
(defun c:kompas_out  (/ echo ed ed_0 en fl fn f_nm l_func old_err ss)
  (setq	echo	(getvar "cmdecho")
	old_err	*error*
	*error*	out_my_err
	l_func	(list (cons "LINE" line_sf)
		      (cons "CIRCLE" circle_sf)
		      (cons "ARC" arc_sf)
		      (cons "INSERT" insert_sf)
		      (cons "LWPOLYLINE" pline_sf)
		      (cons "POLYLINE" pline_sf)))
  (setvar "cmdecho" 0)
  (command "_point" "0,0")
  (command "_undo" "_begin")
  (setq	ss (ssget)
	fn (getfiled "Имя SF-файла" "default" "sf" 1))
  (if (null fn)
    (progn (alert (princ "Имя файла не задано.")) (exit)))
  (setq fl (open fn "w"))
  (if (null fl)
    (progn (alert (princ "Не могу открыть файл :" fl ".")) (exit)))
  (while (> (sslength ss) 0)
    (setq en   (ssname ss 0)
	  ed   (entget en)
	  ss   (ssdel en ss)
	  ed_0 (cdr (assoc 0 ed))
	  f_nm (cdr (assoc ed_0 l_func)))
    (if	f_nm
      (f_nm)))
  (out_my_err " ")
  (startapp (findfile "acad_w.sup/kompas/sf_cad.bat") fn))
