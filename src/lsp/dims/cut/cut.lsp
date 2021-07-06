;;;;;;("cut" "Построение обозначения разреза или сечения." "Размеры")
(defun c:cut  (/ pts                    ;Точки ломаной
               pt_last                  ;Предпоследняя введенная точка
               pt                       ;Последняя введенная точка
                                        ;
               OLD_ERR                  ;
               ORT                      ;
               OS                       ;
               PT_DIR                   ;
               SC                       ;
               STR)
  (if (null (tblsearch "style" "t"))
    (stl))
  (setq old_err *error*
        *error* CUT:N_ERR
        ort     (getvar "orthomode")
        os      (getvar "osmode")
        sc      (getvar "dimscale"))
  (if (= sc 0)
    (setq sc (getreal "\nМасштаб:")))
;;;  (setq str (getstring "\nТекст вида:"))
  (setq str (index:string))
  (index:add)
  (while (cond (pt_last (setq pt (getpoint pt_last "\nТочка:")))
               (t (setq pt (getpoint "\nТочка:"))))
    (if (and pt pt_last)
      (grvecs (list 1 pt pt_last)))
    (setq pts     (cons pt pts)
          pt_last pt))
  (setq pt_dir (getpoint pt_last "\nСторона с которой рисуются стрелки:")
        pts    (reverse pts))
  (setq pts    (mapcar (function (lambda (el) (trans el 1 0))) pts)
        pt_dir (trans pt_dir 1 0))
  (draw:cut pts str sc pt_dir)
  (cut:n_err ""))


(defun cut:n_err  (msg)
  (setvar "orthomode" ort)
  (setvar "osmode" os)
  (setq *error* old_err)
  (if (/= msg "Function cancelled")
    (princ msg))
  (command-s "redraw")
  (princ))

(defun dr:arrow  (p_0 p_1 dang / p00 pl ang p_ar1 p_ar2 p_ar3 arr dir_text PTXT P_00 VID_TEXT ; ARR_LEN1
                                        ; ARR_LEN2
                                        ; ARR_LEN3
                                        ; ARR_WID1
                                        ; ARR_WID2
                                        ; LEN_TX1
                                        ; LEN_TX2
                                        ; LIN_BIG
                                        ; LIN_WID
                                        ; STR
                                        ; TXT_HI
) (setq p_00 (polar p_0 (angle p_1 p_0) lin_big)
        pl   (vla-AddLightWeightPolyline
               acadSpace
               (vlax-safearray-fill
                 (vlax-make-safearray vlax-vbDouble '(1 . 4))
                 (list (car p_00) (cadr p_00) (car p_0) (cadr p_0)))))
  (vlax-put pl "ConstantWidth" lin_wid)
  (setq ang   (+ (angle p_1 p_0) dang)
        p_ar1 (polar p_0 (angle p_1 p_0) arr_len3)
        p_ar2 (polar p_ar1 ang arr_len1)
        p_ar3 (polar p_ar1 ang arr_len2)
        arr   (vla-AddLightWeightPolyline
                acadSpace
                (vlax-safearray-fill
                  (vlax-make-safearray vlax-vbDouble '(1 . 6))
                  (list (car p_ar1) (cadr p_ar1) (car p_ar2) (cadr p_ar2) (car p_ar3) (cadr p_ar3)))))
  (vla-SetWidth arr 0 0.0 arr_wid1)
  (vla-SetWidth arr 1 arr_wid2 arr_wid2)
  (setq ptxt     (polar p_00 ang len_tx1)
        ptxt     (polar ptxt
                        (angle p_1 p_0) ; len_tx2
                        (- len_tx2 (- lin_big arr_len3)))
        vid_text (vla-AddText acadSpace str (vlax-3d-point (list 0.0 0.0 0.0)) txt_hi))
  (vlax-put vid_text "VerticalAlignment" acVerticalAlignmentMiddle)
  (vlax-put vid_text "HorizontalAlignment" acHorizontalAlignmentCenter)
  (vlax-put vid_text "Color" 1)
  (vlax-put vid_text "TextAlignmentPoint" ptxt)
  (setq dir_text (angle (trans (list 0.0 0.0 0.0) 1 0) (trans (list 1.0 0.0 0.0) 1 0)))
  (vlax-put vid_text "Rotation" dir_text)
  vid_text)                             ; end dr:arrow

(defun draw:cut  (pts                   ; Список точек
                  str                   ; Строка обозначения сечения
                  sc                    ; Масштаб
                  pt_dir                ; Точка, определяющая направление сечения
                  /                     ;
                  acadSpace             ; Пространство в котором следует рисовать примитивы
                  arr_len1              ; Длина заостряющейся части стрелки
                  arr_len2              ; Длина всей стрелки
                  arr_len3              ; Расстояние до острия стрелки вдоль плоскости сечения
                  arr_wid1              ;
                  arr_wid2              ;
                  i                     ;
                  k                     ;
                  lin_big               ; Длина обозначения плоскости сечения
                  lin_small             ; Длина обозначения излома сечения
                  lin_wid               ; Ширина секущей линии
                  pl                    ;
                  p_dr_k                ;
                  p_dr_k+1              ;
                  p_dr_k-1              ;
                  p_k                   ;
                  p_k+1                 ;
                  p_k-1                 ;
                  txt_hi                ; Высота текста
                  txt_1                 ;
                  txt_2                 ;
                  reactor               ;
                  txt_lst               ;
                  DANG                  ; Направление расположения текста от сечения
                  len_tx1               ; Отстояние текста от плоскости сечения
                  len_tx2               ; Отстояние текста от стрелки
                  LIN_ARR_ST            ;
                  p_e0                  ; Последняя точка из списка точек сечения
                  p_e1                  ; Предпоследняя точка из списка точек сечения
                  p_s0                  ; Первая точка из списка точек сечения
                  p_s1                  ; Вторая точка из списка точек сечения
                  )
  (setq acadSpace  (AcadAppDocSpace)    ; Пространство в котором следует рисовать примитивы
        lin_big    (* sc 10.0)          ; Длина обозначения плоскости сечения
        lin_small  (* sc 3.0)           ; Длина обозначения излома сечения
        lin_wid    (* sc 0.75)          ; Ширина секущей линии
        lin_arr_st (* sc 7.0)           ;
        arr_len1   (* sc 5.0)           ; Длина заостряющейся части стрелки
        arr_len2   (* sc 9.0)           ; Длина всей стрелки
        arr_len3   (* sc 8.0)           ; Расстояние до острия стрелки вдоль плоскости сечения
        txt_hi     (* sc 7.0)           ; Высота текста
        len_tx1    (* txt_hi 1.25)      ; Отстояние текста от плоскости сечения
        len_tx2    (* txt_hi 1.25)      ; Отстояние текста от стрелки + (lin_big-arr_len3)
        arr_wid1   (* sc 1.5)           ; Наибольшая ширина стрелки
        arr_wid2   (* sc 0.75)          ; Ширина продолжения стрелки
        )
  (setq i (length pts)
        k 0)
  (while (< k i)
    (cond ((= k 0)
           (setq p_s0 (nth k pts)
                 p_s1 (nth (1+ k) pts)))
          ((= k (1- i))
           (setq p_e1 (nth (1- k) pts)
                 p_e0 (nth k pts))
           (setq dang (- (angle (inters p_e1 p_e0 pt_dir (polar pt_dir (+ (* 0.5 pi) (angle p_e1 p_e0)) 1.0) nil) pt_dir)
                         (angle p_e1 p_e0))))
          (t
           (setq p_k-1    (nth (1- k) pts)
                 p_k      (nth k pts)
                 p_k+1    (nth (1+ k) pts)
                 p_dr_k-1 (polar p_k (angle p_k p_k-1) lin_small)
                 p_dr_k+1 (polar p_k (angle p_k p_k+1) lin_small))
           (setq pl (vla-AddLightWeightPolyline
                      acadSpace
                      (vlax-safearray-fill
                        (vlax-make-safearray vlax-vbDouble '(1 . 6))
                        (list (car p_dr_k-1) (cadr p_dr_k-1) (car p_k) (cadr p_k) (car p_dr_k+1) (cadr p_dr_k+1)))))
           (vlax-put pl "ConstantWidth" lin_wid)))
    (setq k (1+ k)))
  (setq txt_1   (dr:arrow p_e0 p_e1 dang) ; Для реактора изменения текста
        txt_2   (dr:arrow p_s0 p_s1 (- 0.0 dang))
        txt_lst (list txt_1 txt_2))
;;;  (vlax-ldata-put txt_1 "txt_vid" "TextString")
;;;  (vlax-ldata-put txt_2 "txt_vid" "TextString")
;;;  (setq	reactor
;;;	 (VLR-Object-reactor
;;;	   txt_lst
;;;	   txt_lst
;;;	   '((:vlr-modified . reactor-text))
;;;	 )
;;;  )
;;;  (vlr-pers reactor) ; Для реактора изменения текста
  (command-s "redraw"))

(defun reactor-text  (notifier reactor arg-list)
  (_reactor-make-association-properties-list notifier (VLR-Data reactor) '("txt_vid")))
