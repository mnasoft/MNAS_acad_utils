(VL-LOAD-COM)

(defun load-w-arrows ()
  (command "_insert" "weld_arrow_bot" nil)					; ��������� ���� �� �������� ������ ������
  (command "_insert" "weld_arrow_top" nil)					; ��������� ���� �� �������� ������� ������
)


;;;;;;("wlc" "������� ��� �������� ����������� �������, ������������ ������." "�������")
(defun c:wlc (/	en								; ��� ��������� LEADER
	      p0								; ����� ������ �������
	      p1								; ����� ������ �����;
	      p2								; ����� ����� �����
)
  (load-w-arrows)

  (setq
    p0 (GETPOINT "������� ��������� ����� ����������� �������� ���:")
    p1 (GETPOINT p0 "������� ������ �����:")
    p2 (GETPOINT p1 "������� ����� �����:")
  )
  (command "_leader" "_non" p0 "_non" p1 "_non" p2 "" "" "_none")
  (setq en (entlast))
  (vlax-put-property (vlax-ename->vla-object en) 'ArrowheadBlock "weld_arrow_bot")
  (w-edit-arrow-dir en)
)


;;;;;;("wle" "������� ��� ������������� ����������� �������, ������������ ������." "�������")
(defun c:wle (/									;
	      en								; ��� �������������� ��������� LEADER
	      pnt								; ����� � ������� ��� ������ �������� LEADER
	      sel								; ���� ��� ��������� � ����� ������ ���������
	     )
  (load-w-arrows)
  (setq
    sel	(entsel "�������� �������, ������������� � ������:")
    en	(car sel)
    pnt	(cadr sel)
  )
  (w-edit-arrow-dir en)
)

;;;f;;;("w-edit-arrow-dir")
;;;�������������� ����������� ������� ��� �������� ��������� (LEADER � ������ ������)
(defun w-edit-arrow-dir	(en							; ��� �������������� ��������� LEADER
			 /							;
			 arrow							; ��� ����� �������
			 do							; ������� ����������� ���������� �����
			 key							; �������� �����
)
  (setq do t)
  (while do
    (setq arrow (vlax-get-property (vlax-ename->vla-object en) 'ArrowheadBlock))
    (initget "Flip Top Bot Arrow Points Exit")
    (setq key (getkword "\nEnter an option (Flip/Top/Bot/Arrow/Points)<Exit>: "))
    (cond
      ((= key "Flip")
       (cond
	 ((= arrow "weld_arrow_top")
	  (vlax-put-property (vlax-ename->vla-object en) 'ArrowheadBlock "weld_arrow_bot")
	 )
	 ((= arrow "weld_arrow_bot")
	  (vlax-put-property (vlax-ename->vla-object en) 'ArrowheadBlock "weld_arrow_top")
	 )
	 (t
	  (vlax-put-property (vlax-ename->vla-object en) 'ArrowheadBlock "weld_arrow_bot")
	 )
       )
      )
      ((= key "Top")
       (vlax-put-property (vlax-ename->vla-object en) 'ArrowheadBlock "weld_arrow_top")
      )
      ((= key "Bot")
       (vlax-put-property (vlax-ename->vla-object en) 'ArrowheadBlock "weld_arrow_bot")
      )
      ((= key "Arrow")
       (vlax-put-property (vlax-ename->vla-object en) 'ArrowheadBlock "")
      )
      ((= key "Points")
       (w-change-points en)
      )
      ((= key "Exit")
       (setq do nil)
      )
      (t
       (setq do nil)
      )
    )
  )
)

(defun create-point-list (/							;
			  DO							; ������� ��������� �����
			  LST							; ������ �����
			  P0							; ����� �����
			  P_LAST						; ����� ����������
)
  (setq
    lst	nil
    p_last nil
  )
  (setq do t)
  (while do
    (if	p_last
      (setq p0 (getpoint p_last "������� ����� �� �������:"))
      (setq p0 (getpoint "������� ����� �� �������:"))
    )
    (setq p_last p0)
    (if	p0
      (setq lst (cons p0 lst))
      (setq do nil)
    )
  )
  lst
)

(defun c:wpnt (/								;
	       en								; ��� ���������
	       pnt								; ����� ������ ���������
	       sel								; ���� ��� ��������� � ����� ��� ������
	      )
  (setq
    sel	(entsel "�������� �������, ������������� � ������:")
    en	(car sel)
    pnt	(cadr sel)
  )
  (w-change-points en)
)


(defun w-change-points (en							; ��� ���������
			/							;
			dd							; �������� �������������� ������, ������������� ������� 
			ed							; �������� ������ ���������
			i							; ������� ��� ������� �� ������ ���������
			lst							; ������ � ������ ��������� �������
			rez							; ��������������� ������ ���������
			ten_not_was						; ������� ����, ��� ������ ������� ��� �����������
)
  (setq ed (entget en))
  (setq lst (create-point-list))

  (setq rez nil)
  (setq i (length ed))
  (setq ten_not_was t)
  (while (>= (setq i (1- i)) 0)
    (setq dd (nth i ed))
    (cond
      (
       (and (= 10 (car dd)) ten_not_was)
       (setq ten_not_was nil)
       (mapcar
	 (function
	   (lambda (el)
	     (setq rez (cons (cons 10 el) rez))
	   )
	 )
	 lst
       )
      )
      ((= 10 (car dd)))
      (
       t
       (setq rez (cons dd rez))
      )
    )
  )
  (entmod rez)
)

(setq en (car (entsel "Enter object:")))


(defun get-leadred-point-list (en / rez-lst)

  (setq	pnt_coords (vlax-safearray->list
		     (vlax-variant-value (vlax-get-property (vlax-ename->vla-object en) 'Coordinates))
		   )
  )
  (setq len (/ (length pnt_coords) 3))
  (while (>= (setq len (1- len)) 0)
    (setq
      x	(nth (+ 0 (* len 3)) pnt_coords)
      y	(nth (+ 1 (* len 3)) pnt_coords)
      z	(nth (+ 2 (* len 3)) pnt_coords)
    )
    (setq rez-lst (cons (list x y z) rez-lst))
  )
  rez-lst
)

;;;�������� ������ ��� ������, ��������� �������� str_top � str_bot ��� ��������� en.
(defun w-draw-text (								;
		    en								;
		    str_top							;
		    str_bot /							;
		    pnt_list)
  (setq pnt_list (get-leadred-point-list en))
  (setq len (length pnt_list))
  (setq	p_last (nth (- len 1) pnt_list)
	p_pre_last (nth (- len 2) pnt_list)
	ang (angle p_pre_last p_last)
	di (distance p_last p_pre_last)
	p_mid (polar p_last ang (* 0.5 di))
  )
  (setq	scale	(vlax-get-property (vlax-ename->vla-object en) 'ScaleFactor)
	d_style	(vlax-get-property (vlax-ename->vla-object en) 'StyleName)
	t_style	(cdr (assoc 2 (entget (cdr (assoc 340 (tblsearch "dimstyle" d_style)))))) ; ��� ���������� �����
	t_hight	(cdr (assoc 140 (entget (cdr (assoc 340 (tblsearch "dimstyle" d_style)))))) ; ������ ������
  )
  (dr:text str_top p_mid t_hight 0.0 256)
  pnt_list
)


;;;(setq ac-obj (vlax-get-acad-object))
;;;(setq act-doc(vlax-get-property ac-obj 'ActiveDocument))
;;;(setq dim_stls (vlax-get-property act-doc 'DimStyles) )
;;;(setq dim_stl (vlax-invoke-method dim_stls 'Item "002_001"))

;;;((0 . "DIMSTYLE") (2 . "002_001")
;;;		  (70 . 0)
;;;		  (3 . "")
;;;		  (4 . "")
;;;		  (5 . "")
;;;		  (6 . "")
;;;		  (7 . "")
;;;		  (40 . 0.5)
;;;		  (41 . 5.0)
;;;		  (42 . 0.0)
;;;		  (43 . 10.0)
;;;		  (44 . 1.5)
;;;		  (45 . 0.0)
;;;		  (46 . 0.0)
;;;		  (47 . 0.0)
;;;		  (48 . 0.0)
;;;		  (140 . 5.666)
;;;		  (141 . 2.5)
;;;		  (142 . 0.0)
;;;		  (143 . 0.0393701)
;;;		  (144 . 1.0)
;;;		  (145 . 0.0)
;;;		  (146 . 1.0)
;;;		  (147 . 1.5)
;;;		  (71 . 0)
;;;		  (72 . 0)
;;;		  (73 . 0)
;;;		  (74 . 0)
;;;		  (75 . 0)
;;;		  (76 . 0)
;;;		  (77 . 1)
;;;		  (78 . 8)
;;;		  (170 . 0)
;;;		  (171 . 3)
;;;		  (172 . 1)
;;;		  (173 . 0)
;;;		  (174 . 0)
;;;		  (175 . 0)
;;;		  (176 . 0)
;;;		  (177 . 0)
;;;		  (178 . 0)
;;;		  (270 . 2)
;;;		  (271 . 2)
;;;		  (272 . 2)
;;;		  (273 . 2)
;;;		  (274 . 3)
;;;		  (340 . <Entity name: 7ef03410>)
;;;		  (275 . 1)
;;;		  (280 . 0)
;;;		  (281 . 0)
;;;		  (282 . 0)
;;;		  (283 . 1)
;;;		  (284 . 8)
;;;		  (285 . 0)
;;;		  (286 . 0)
;;;		  (287 . 2)
;;;		  (288 . 0)
;;;)








 ;|�Visual LISP� Format Options�
(130 2 80 2 nil "end of" 100 20 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
