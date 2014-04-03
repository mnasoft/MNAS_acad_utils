;;; Стрелка вида отрисовывается в повернутой системе координат не в том месте.

;;;;;;("look" "Построение обозначения вида." "Размеры")
(defun c:look  (/ ort os sc p1 p2 dir_0 str p3 la_st old_err)
  (if (null (tblsearch "style" "t"))
    (stl))
  (setq	old_err	*error*
	*error*	look:n_err
	ort	(getvar "orthomode")
	os	(getvar "osmode")
	sc	(getvar "dimscale"))
  (if (= sc 0)
    (setq sc (getreal "\nМасштаб:")))
  (setvar "osmode" 0)
  (setq p1 (getpoint "\nКонец стрелки:"))
  (setvar "orthomode" 0)
  (setvar "osmode" 128)
  (setq p2 (getpoint p1 "\nНаправление стрелки:"))
  (setq p1 (TRANS p1 1 0))
  (setq p2 (TRANS p2 1 0))
  (setq dir_0 (angle p2 p1))
;;;  (setq str (getstring "\nТекст вида:"))
  (setq str (index:string))
  (index:add)
  (look:draw p1 sc dir_0 str)
  (look:n_err ""))

(defun look:n_err  (msg)
  (setvar "orthomode" ort)
  (setvar "osmode" os)
  (setq *error* old_err)
  (if (/= msg "Function cancelled")
    (princ msg))
  (princ))

(defun look:draw  (pt	      sc	 dir_0	    str	       /	  acadSpace  arr_len1
		   arr_len2   arr_wid1	 arr_wid2   pl	       pt1	  pt2	     txt_hi
		   vid_text   vid_text_handle	    dir_text)
  (setq dir_text (angle (trans (list 0.0 0.0 0.0) 1 0) (trans (list 1.0 0.0 0.0) 1 0)))
  (setq	acadSpace     (AcadAppDocSpace)
	arr_len1      5.0 ; Длина заостряющейся части стрелки
	arr_len2      9.0 ; Длина всей стрелки
	txt_hi	      7.0 ; Высота текста
	txt_offset_sc 1.25 ; Коэффициент отстояния текста вида от стрелки
	arr_wid1      1.5 ; Наибольшая ширина стрелки
	arr_wid2      0.75 ; Ширина продолжения стрелки
	)
  (setq	pt1 (polar pt dir_0 (* sc arr_len1))
	pt2 (polar pt dir_0 (* sc arr_len2)))
  (setq vid_text (vla-AddText acadSpace str (vlax-3d-point (list 0.0 0.0 0.0)) (* sc txt_hi)))
  (vlax-put vid_text "VerticalAlignment" acVerticalAlignmentMiddle)
  (vlax-put vid_text "HorizontalAlignment" acHorizontalAlignmentCenter)
  (vlax-put vid_text "Color" 1)
  (vlax-put vid_text "Rotation" dir_text)
  (cond	((and (>= (angle (TRANS p2 0 1) (TRANS p1 0 1)) (* pi 0.5))
	      (<= (angle (TRANS p2 0 1) (TRANS p1 0 1)) (* pi 1.5))) ;dir_0
	 (vlax-put vid_text
		   "TextAlignmentPoint"
		   (polar pt1 (- dir_0 (* pi 0.5)) (* sc txt_hi txt_offset_sc))))
	(t
	 (vlax-put vid_text
		   "TextAlignmentPoint"
		   (polar pt1 (+ dir_0 (* pi 0.5)) (* sc txt_hi txt_offset_sc)))))
  (setq
    pl (vla-AddLightWeightPolyline
	 acadSpace
	 (vlax-safearray-fill
	   (vlax-make-safearray vlax-vbDouble '(1 . 6))
	   (apply (function append)
		  (mapcar (function (lambda (el) (list (car el) (cadr el)))) (list pt pt1 pt2))))))
  (vla-SetWidth pl 0 0.0 (* sc arr_wid1))
  (vla-SetWidth pl 1 (* sc arr_wid2) (* sc arr_wid2))
  (setq pl_handle (vla-get-Handle pl))
  (setq vid_text_handle (vla-get-Handle vid_text))
  (vlax-ldata-put vid_text "key_text" "look_arr_text") ;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  (vlax-ldata-put vid_text "scale" sc) ;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  (vlax-ldata-put vid_text "dwg_name" (vlax-ldata-get "Curr_dwg" "name" ""))
	       ;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  (vlax-ldata-put vid_text "text" str) ;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  (vlax-ldata-put vid_text "pl_handle" pl_handle) ;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  (vlax-ldata-put pl "key_text" "look_arrow") ;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  (vlax-ldata-put pl "look_pt" pt) ;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  (vlax-ldata-put pl "look_dir_0" dir_0) ;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  (vlax-ldata-put pl "vid_text_handle" vid_text_handle) ;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  )


;;;;;;("obj_data" "Возвращает ldata данные, связанные с выбранным примитивом, из расширенного словаря." "Объекты")
(defun c:obj_data  ()
  (vlax-ldata-list
    (vlax-ename->vla-object (car (entsel "Выберите примитив для просмотра его ldata :")))))

;;;;;;("dwg_put" "not defined" "not defined")
(defun c:dwg_put  (/ dwg_name dwg_scale)
  (setq	dwg_name  (getstring "Обозначение чертежа:")
	dwg_scale (getreal "Масштаб чертежа:"))
  (vlax-ldata-put "Curr_dwg" "name" dwg_name)
  (vlax-ldata-put "Curr_dwg" "scale" dwg_scale))

;;;;;;("dwg_get" "not defined" "not defined")
(defun c:dwg_get  ()
  (princ "\nCurr_dwg name:")
  (princ (vlax-ldata-get "Curr_dwg" "name" ""))
  (princ "\nCurr_dwg scale:")
  (princ (vlax-ldata-get "Curr_dwg" "scale" 1.0)))
