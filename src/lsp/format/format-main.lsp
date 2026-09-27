;;;;;;("format" "Построение форматной рамки." "Размеры")
(defun c:format  (/             ;
                  p_start       ;
                  dir_sht       ;
                  divzone_no;
                  zone_ch;
                  zone_dig;
                  ;;
                  for_no        ; Индекс формата.
                  for_name      ; Список, содержащий имена форматов.
                  for_val       ; Список, содержащий размеры форматов.
                  ;;                  
                  f_key ; Список, содержащий ключи форм основных надписей: ("1" "2" "2аг" "2ат" "2бн" "2бч" "3")
                  f_val ; Список, содержащий наименования  форм основных надписей.
                  f_no  ; Индекс формы основной надписи.
                  ;;
                  sht1_key_key2_val  ; 
                  sht1_key           ; Ключи  тегов в основной надписи
                  sht1_key2    ; Наименования тегов в основной надписи
                  ;;
                  kr_key ; Список, содержащий допустимые кратности для форматов (строки).
                  kr_val ; Список, содержащий допустимые кратности для форматов (целочисленные).
                  kr_no  ; Индекс для нахождения кратности формата.
                  ;;
                  reg_root ; Корнь реестра для записи переменных параметров.
                  format_registry ; Список, содержащий значения параметров диалога по умолчанию.
                  )
  (setq p_start '(0.0 0.0 0.0))
  (setq dir_sht 1)
  (setq divzone_no 1)
  (setq zone_ch 65)
  (setq zone_dig 1)
  ;;
  (setq for_no 1)
  (setq for_name (list "А0" "А1" "А2" "А3" "А4"))
  (setq for_val '((1188 840) (840 594) (594 420) (420 297) (297 210)))
  ;;
  (setq kr_no 0)
  (setq kr_key (list "1" "3" "4" "5" "6" "7" "8" "9")) ;Кратность
  (setq kr_val (list 1 3 4 5 6 7 8 9))
  ;;
  (setq sht1_key_key2_val
        (list
         (list "sht1_1"    "NAIMEN" (format:locale-string '(("ru" "Устройство горелочное") ("uk" "Пристрій пальниковий")) "Burner"))
         (list "sht1_2"    "OBOZNACH" "010038001СБ")
         (list "sht1_3"    "MATERIAL" "12Х18Н10Т")
         (list "sht1_4_1"  "L_1" "")
         (list "sht1_4_2"  "L_2" "")
         (list "sht1_4_3"  "L_3" "")
         (list "sht1_5"    "MASS" "")
         (list "sht1_6"    "MASHT" "1:1")
         (list "sht1_7"    "PAPER" "")
         (list "sht1_8"    "PAPERS" "1")
         (list "sht1_9"    "FACTORY" "ЖАКИ")
         (list "sht1_10"   "RABOTA" (format:locale-string '(("ru" "Нач. отд.") ("uk" "Н. відділу")) "Dep. Chef"))
         (list "sht1_11_1" "RAZRAB" "Пивень      ")

         (list "sht1_11_2" "PROVER" "Пивень      ")
         (list "sht1_11_3" "TECHN_KONTROL" "")
         (list "sht1_11_4" "NACH_PODR" "Петельчиц   ")
         (list "sht1_11_5" "NORMO_KONTR" (format:locale-string '(("ru" "Матвеев    ") ("uk" "Матвєєв    ")) "Matvyeyev  "))
         (list "sht1_11_6" "UTVERD" "Склярський  ")
         (list "sht1_24"   "SPRAV_NO" "ХХХХХХХХХ")
         (list "sht1_25"   "PERV_PRIM" "ХХХХХХХХХ")))

  (setq sht1_key  (mapcar 'car   sht1_key_key2_val))
  (setq sht1_key2 (mapcar 'cadr  sht1_key_key2_val))
  (setq sht1_val  (mapcar 'caddr sht1_key_key2_val))
  
  (setq f_no 0)  
  (setq f_key (list "1" "2аг" "2" "2ат" "2б" "2бн" "2бч" "3")) ; Форма основной надписи
  (setq f_val (list
	       (format:locale-string
                '(("ru" "1 \t Граф.Констр.Док.  \t Лист:1")
                  ("uk" "1 \t Граф.Констр.Док.  \t Арк.:1"))
                "1 \t Graph.Design.Doc. \t Page:1")
               (format:locale-string
                '(("ru" "2аг \t Граф.Констр.Док.  \tЛист:N")
                  ("uk" "2аг \t Граф.Констр.Док.  \tАрк.:N"))
                "2аг \t Graph.Design.Doc. \tPage:N")
               (format:locale-string
                '(("ru" "2 \t Текст.Констр.Док. \tЛист:1")
                  ("uk" "2 \t Текст.Констр.Док. \tАрк.:1"))
                "2   \t Text.Design.Doc. \t Page:1")
               (format:locale-string
                '(("ru" "2ат \t Текст.Констр.Док. \tЛист:N")
                  ("uk" "2ат \t Текст.Констр.Док. \tАрк.:N"))
                "2ат \t Text.Design.Doc. \t Page:N")
               
               (format:locale-string
                '(("ru" "2б \t Текст.Констр.Док. \t Первая Стр.")
                  ("uk" "2б \t Текст.Констр.Док. \t Перша Стор."))
                "2б \t Text.Design.Doc. \t First Page")

               (format:locale-string
                '(("ru" "2бн \t Текст.Констр.Док. \t Нечетная Стр.")
                  ("uk" "2бн \t Текст.Констр.Док. \t Непарна Стор."))
                "2бн \t Text.Design.Doc. \t Odd Page")
               
               (format:locale-string
                '(("ru" "2бч \t Текст.Констр.Док. \t Четная Стр.")
                  ("uk" "2бч \t Текст.Констр.Док. \t Парна Стор."))
                "2б \t Text.Design.Doc. \t Even Page")
               
               (format:locale-string
                '(("ru" "3 \t Рамка \t Лист Утвеждения")
                  ("uk" "3 \t Рамка \t Аркуш Затвердження"))
                "3 \t Frame \t Approval Sheet")))
;;;;
  (setq reg_root (strcat "HKEY_CURRENT_USER\\Software\\MNASoft\\Format" "\\" format:locale))
  (setq	format_registry
	 (mapcar
	   (function
	     (lambda (sym)
	       (list sym (eval sym))))
	   '(p_start sht1_val f_no kr_no for_no	dir_sht	divzone_no zone_ch zone_dig)))
;;;;  
  (load_format)
  (main_format)
  (princ))
