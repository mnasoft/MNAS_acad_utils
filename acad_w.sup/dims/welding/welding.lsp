;;;;;;("welding" "Построение обозначения сварочных швов. Не закончена." "Размеры")
(defun c:welding (/ acadSpace p0 p1 str_top str_bot ln_1)
  (setq
    acadSpace(AcadAppDocSpace)
    p0	    (getpoint "\nОстрие стрелки:")
    p1	    (getpoint p0 "\nОстрие стрелки:")
    str_top (getstring "\nВерхний текст:")
    str_bot (getstring "\nНижний текст:")
  )
  (setq
    ar_sz_b 5.0	 ;Размер стрелки на продолжении линии выноски
    ar_s_an (dtr 10.0) ;Угол раскрытия стрелки
    ar_e_an (dtr 60.0) ;Угол хвоста стрелки
    tx_h    3.5	 ;Высота текста
    tx_t_bl 1.75 ;Расстояние между верхним текстом и базовой линией
    tx_b_bl 1.75 ;Расстояние между нижним текстом и базовой линией
  )
  (setq
    a_p0_p1 (angle p0 p1)
    p_a_b   (polar p0 a_p0_p1 ar_sz_b)
    p_a_s   (inters p0
		    (polar p0 (+ a_p0_p1 ar_s_an) 1.0)
		    p_a_b
		    (polar p_a_b (+ a_p0_p1 ar_e_an) 1.0)
		    nil
	    )
  )
  (setq
    ln_1    (vla-AddLine acadSpace (vlax-3d-point p0) (vlax-3d-point p1))
    ln_ar_1 (vla-AddLine acadSpace (vlax-3d-point p0) (vlax-3d-point p_a_s))
    ln_ar_2 (vla-AddLine acadSpace (vlax-3d-point p_a_b) (vlax-3d-point p_a_s))

    tx_top  (vla-AddText acadSpace str_top (vlax-3d-point p1) tx_h)
    tx_bot  (vla-AddText acadSpace str_bot (vlax-3d-point p1) tx_h)
;;;    ln_2 (vla-AddLine acadSpace (vlax-3d-point p0) (vlax-3d-point p1))
  )
  (vlax-put tx_top "Alignment" acAlignmentCenter)
  (vlax-put tx_top "TextAlignmentPoint" (mapcar '+ p1 (list 0.0 tx_t_bl 0.0)))

  (vla-getboundingbox tx_top 'tx_top_min_sa 'tx_top_max_sa)
  (setq
    tx_top_min_pt (vlax-safearray->list tx_top_min_sa)
    tx_top_max_pt (vlax-safearray->list tx_top_max_sa)
    tx_top_wid	  (mapcar '- tx_top_max_pt tx_top_min_pt)
  )
  (vlax-put tx_bot "Alignment" acAlignmentTopCenter)
  (vlax-put tx_bot "TextAlignmentPoint" (mapcar '- p1 (list 0.0 tx_b_bl 0.0)))
  (vla-getboundingbox tx_bot 'tx_bot_min_sa 'tx_bot_max_sa)
  (setq
    tx_bot_min_pt (vlax-safearray->list tx_bot_min_sa)
    tx_bot_max_pt (vlax-safearray->list tx_bot_max_sa)
    tx_bot_wid	  (mapcar '- tx_bot_max_pt tx_bot_min_pt)
  )
  (dr:line tx_top_min_pt tx_top_max_pt 1)
  (dr:line tx_bot_min_pt tx_bot_max_pt 2)
)
;|«Visual LISP© Format Options»
(105 2 17 2 nil "end of" 90 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
