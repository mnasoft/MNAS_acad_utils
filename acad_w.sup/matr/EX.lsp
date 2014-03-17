;;;;;;("sc_sl" "not defined" "not defined")
(defun c:sc_sl (/ a b fi x y)
  (setq	a	     (getreal "\nÂâåäèòå ñìåùåíèå ïî îñè x a= ")
	b	     (getreal "\nÂâåäèòå ñìåùåíèå ïî îñè y b= ")
	fi	     (getangle "\nÂâåäèòå óãîë ïîâîðîòà îñåé fi=")
	x	     (getreal "\nÌàñøòàá ïî îñè x= ")
	y	     (getreal "\nÌàñøòàá ïî îñè y= ")
	screen_slide (matr_screen_slide a b fi x y)
	slide_screen (matr_slide_screen a b fi x y)
  )
)



;;;;;;("test" "not defined" "not defined")
(defun c:test (/ dcl_id p0 px py matr ac ss)
  (setq
    p0 '(0.0 0.0)
    px '(10.0 0.0)
    py '(0.0 10.0)
  )
  (setq
    p0 (point_preobr p0 screen_slide)
    px (point_preobr px screen_slide)
    py (point_preobr py screen_slide)
  )

  (setq dcl_id (load_dialog (findfile "acad_w.sup/sher.dcl")))
  (while (/= ac 1)
    (if	(not (new_dialog "test_window" dcl_id))
      (exit)
    )
    (draw p0 px py)
    (action_tile "b_3_1" "(done_dialog 2)")
    (action_tile "b_3_2" "(draw_2)")
    (setq ac (start_dialog))
    (cond
      (
       (= ac 2)
       (setq ss (ssget))
      )
    )

  )
  (unload_dialog dcl_id)
)

(defun draw_2 (/ en ed p0 p1 col la i n_arc i_arc ll ladt)
  (if (null ss)
    (setq ss (ssadd))
  )
  (start_image "i_3_1")
  (fill_image 0 0 500 500 0)
  (setq
    ll (sslength ss)
    i  ll
  )
  (repeat ll
    (setq
      i	   (1- i)
      en   (ssname ss i)
      ed   (entget en)
      la   (cdr (assoc 8 ed))
      ladt (tblsearch "LAYER" la)
      col
	   (cond
	     ((cdr (assoc 62 ed)))
	     ((cdr (assoc 62 ladt)))
	     (t 7)
	   )
    )

    (cond
      (
       (= "LINE" (cdr (assoc 0 ed)))
       (setq
	 p0 (cdr (assoc 10 ed))
	 p1 (cdr (assoc 11 ed))
       )
       (image_line
	 (point_preobr p0 screen_slide)
	 (point_preobr p1 screen_slide)
	 col
       )
      )
      (
       (= "CIRCLE" (cdr (assoc 0 ed)))
       (setq
	 p0    (cdr (assoc 10 ed))
	 r     (cdr (assoc 40 ed))
	 n_arc 30
	 delta (/ (+ pi pi) n_arc)
       )
       (repeat n_arc
	 (setq
	   ps	 (polar p0 (* delta n_arc) r)
	   pe	 (polar p0 (* delta (1- n_arc)) r)
	   n_arc (1- n_arc)
	 )
	 (image_line
	   (point_preobr ps screen_slide)
	   (point_preobr pe screen_slide)
	   col
	 )

       ) ;repeat
      )
      (
       (= "ARC" (cdr (assoc 0 ed)))
       (setq
	 p0    (cdr (assoc 10 ed))
	 r     (cdr (assoc 40 ed))
	 ang0  (cdr (assoc 50 ed))
	 ang1  (cdr (assoc 51 ed))
	 n_arc 15
	 i_arc n_arc
	 delta
	       (cond
		 (
		  (> ang1 ang0)
		  (/ (- ang1 ang0) n_arc)
		 )
		 (
		  (> ang0 ang1)
		  (/ (- (+ ang1 pi pi) ang0) n_arc)
		 )
	       )
       )
       (repeat n_arc
	 (setq
	   ps	 (polar p0 (+ ang0 (* delta n_arc)) r)
	   pe	 (polar p0 (+ ang0 (* delta (1- n_arc))) r)
	   n_arc (1- n_arc)
	 )
	 (image_line
	   (point_preobr ps screen_slide)
	   (point_preobr pe screen_slide)
	   col
	 )

       ) ;repeat
      )
    ) ;cond
  )
  (end_image)
)

(defun draw (p0 px py)
  (start_image "i_3_1")
  (vector_image 50 0 50 100 7)
  (vector_image 0 50 100 50 7)
  (image_line p0 px 1)
  (image_line p0 py 2)
  (image_line px py 3)
  (end_image)
)
 ;|«Visual LISP© Format Options»
(72 2 5 2 nil "end of" 60 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
