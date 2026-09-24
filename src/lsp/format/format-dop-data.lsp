;;; ./src/lsp/format/format-dop-data.lsp
;;; (format:locale-string '(("uk" "Альбомна") ("ru" "Альбомная") "Landscape"))
;;; format:locale-data


(defun make-3d-point (point)
  (cond
    ((null point) '(0.0 0.0 0.0))
    ((= 3 (length point)) point)
    ((= 2 (length point)) (list (car point) (cadr point) 0.0))
    ((= 1 (length point)) (list (car point) 0.0 0.0))))

(defun make-format-dop-sht (name f-name anchor-no p-lb p-rb p-rt p-lt)
  (list name
        (list
         (cons 2 f-name)
         (cons 70 anchor-no)
         (cons 11 (make-3d-point p-lb))
         (cons 12 (make-3d-point p-rb))
         (cons 13 (make-3d-point p-rt))
         (cons 14 (make-3d-point p-lt)))))

;;; (format:locale-string '(("uk" "Альбомна") ("ru" "Альбомная") "Landscape"))
'(("ru" "Русский")              ("uk" "Українська")            ("en" "English"))
'(("ru" "Спецификация")         ("uk" "Специфікація")          ("en" "Specification"))
'(("ru" "Первичное применение") ("uk" "Первинне застосування") ("en" "First Use"))
'(("ru" "Архив")                ("uk" "Архів")                 ("en" "Archive"))

(progn
  (setq format-dop-sht:speciph_n
        (make-format-dop-sht
         (format:locale-string '(("uk" "Специф.:N") ("ru" "Специф.:N")) "Specif.:N")
         (format:make-shtamp-path "speciph_n")
         3
         '(  20.0   20.0) '( 205.0  20.0) '(205.0 292.0)  '(  20.0 292.0)))
  (setq format-dop-sht:speciph_1
        (make-format-dop-sht
         (format:locale-string '(("uk" "Специф.:1") ("ru" "Специф.:1")) "Specif.:1")
         (format:make-shtamp-path "speciph_1")
         3
         '(  20.0   45.0) '( 205.0  45.0) '(205.0 292.0)  '(  20.0 292.0)))
  (setq format-dop-sht:DOP_PRM   (make-format-dop-sht "Л.рег.изм"    (format:make-shtamp-path "DOP_PRM")   0 '(-190.0  282.0) '(-190.0  20.0) '( -5.0 20.0)   '(  -5.0 292.0)))
  (setq format-dop-sht:DOP_TMV   (make-format-dop-sht "Тех.мет.вед"  (format:make-shtamp-path "DOP_TMV")   3 '(   0.0    5.0) '(   8.0   5.0) '(  8.0 115.0)  '(   0.0 115.0)))
  (setq format-dop-sht:DOP_G_LT  (make-format-dop-sht "Гр. л.верх"   (format:make-shtamp-path "DOP_G_LT")  2 '(  20.0  -27.0) '( 160.0 -27.0) '( 160.0 -5.0)  '(  20.0  -5.0)))
  (setq format-dop-sht:DOP_G_RB  (make-format-dop-sht "Гр.прав.низ." (format:make-shtamp-path "DOP_G_RB")  0 '(-125.0   60.0) '(  -5.0  60.0) '(  -5.0 68.0)  '(-125.0  68.0)))
  (setq format-dop-sht:DOP_TEXT  (make-format-dop-sht "Текст.доп"    (format:make-shtamp-path "DOP_TEXT")  0 '(-125.0   45.0) '(  -5.0  45.0) '(  -5.0 68.0)  '(-125.0  68.0)))
  (setq format-dop-sht:DOP_PRIM  (make-format-dop-sht "Перв.прим"    (format:make-shtamp-path "DOP_PRIM")  3 '(   8.0  182.0) '(  20.0 182.0) '(  20.0 292.0) '(   8.0 292.0)))
  (setq format-dop-sht:DOP_ARH
        (make-format-dop-sht
         (format:locale-string '(("ru" "Архив")("uk" "Архів")) "Archive")
         (format:make-shtamp-path "DOP_ARH")
         3
         '(   8.0    5.0) '(  20.0   5.0) '(  20.0 155.0) '(   8.0 155.0))))

(setq dop_dlg_registry
      (list
       (list
        'dsht_1_val
        (list
         format-dop-sht:speciph_n
         format-dop-sht:speciph_1
         format-dop-sht:DOP_PRM
         format-dop-sht:DOP_TMV
         format-dop-sht:DOP_G_LT
         format-dop-sht:DOP_G_RB
         format-dop-sht:DOP_TEXT
         format-dop-sht:DOP_PRIM
         format-dop-sht:DOP_ARH))
       '(dsht_1_no 7)
       (list
        'dsht_2_val
        (list
         format-dop-sht:DOP_G_LT
         format-dop-sht:DOP_G_RB
         format-dop-sht:DOP_ARH
         format-dop-sht:DOP_TMV
         format-dop-sht:DOP_PRIM))
       '(dsht_2_no nil)
       (list
        'dsht_3_val
        (list
         format-dop-sht:DOP_G_LT
         format-dop-sht:DOP_G_RB
         format-dop-sht:DOP_ARH
         format-dop-sht:DOP_TMV
         format-dop-sht:DOP_PRIM))))
