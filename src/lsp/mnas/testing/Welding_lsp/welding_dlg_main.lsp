(defun c:edweld  (/                                                             ;
                  ed                                                            ; DXF данные, редактируемого шва
                  action                                                        ; Значение, возвращаемое при закрытии диалога
                  arrow_type_lst                                                ; Список типов стрелок
                  arrow_type_n                                                  ; Значение типа стрелки
                  arrow_type_tile                                               ; tile типа стрелки
                  dcl_id                                                        ; Дескриптор диалога
                  dia_weld_pos                                                  ; Кооринаты следующего появления диалога
                  dim_stl                                                       ; Имя размерного стиля к которому принадлежит позиция
                  dim_stl_lst                                                   ; Список размерных стилей чертежа
                  dim_stl_n                                                     ; Номер размерного стиля текущей позиции в списке стилей размеров
                  do_dialog                                                     ; Признак того, что диалог будет возобновлен после обработки события
                  reg_root                                                      ; Место в системном реестре, где будут сохраняться настройки диалога
                  reg_val                                                       ; Настройки диалога
                  setup_lst                                                     ; Список, сохраняющий зачения переменных диалога
                  text-scale_n                                                  ; Масштаб высоты текста (относительно высоты текста размерного стиля)
                  text-scale_tile                                               ; Масштаб высоты текста и tile
                  text_color_n                                                  ; Индекс цвета текста позиции
                  text_n                                                        ; Текст, редактируемой позиции
                  text_tile                                                     ; tile текста позиции
                  )
  (setq tile_wedl_standard      "wedl_standard"
        tile_weld_type          "weld_type"
        tile_weld_sposob        "weld_sposob"
        tile_weld_kategory      "weld_kategory"
        tile_weld_kontrol_group "weld_kontrol_group"
        weld_pp_list_str        (list tile_wedl_standard         tile_weld_type
                                      tile_weld_sposob           tile_weld_kategory
                                      tile_weld_kontrol_group)
        weld_pp_list_code       '(70 71 72 73 74))
  (setq weld_type_0                                                             ;Тип А = ГОСТ 5264.
                     (append (litera-from-to-list "С" 1 30)
                             (litera-from-to-list "У" 1 10)
                             (litera-from-to-list "Т" 1 10)
                             (litera-from-to-list "Н" 1 10))
        weld_type_1  weld_type_0                                                ;Тип Б = ГОСТ 11534.
        weld_type_2  (append (litera-from-to-list "С" 1 30)
                             (litera-from-to-list "У" 1 10)
                             (litera-from-to-list "Т" 1 10)
                             (litera-from-to-list "Н" 1 10))
        weld_type_3  weld_type_2                                                ;Тип B = ГОСТ 14771-76.
        weld_type_4  (append (litera-from-to-list "С" 1 30)
                             (litera-from-to-list "У" 1 10)
                             (litera-from-to-list "Т" 1 10)
                             (litera-from-to-list "Н" 1 10))
        weld_type_5  weld_type_4                                                ;Тип Г = ГОСТ 23518.
        weld_type_6  (append (litera-from-to-list "С" 1 30)
                             (litera-from-to-list "У" 1 10)
                             (litera-from-to-list "Т" 1 10)
                             (litera-from-to-list "Н" 1 10))
        weld_type_7  weld_type_6                                                ;Тип Д = ГОСТ 15878
        weld_type_8  (append (litera-from-to-list "С" 1 30)
                             (litera-from-to-list "У" 1 10)
                             (litera-from-to-list "Т" 1 10)
                             (litera-from-to-list "Н" 1 10))
        weld_type_9  weld_type_8                                                ;Тип Е = ГОСТ 16037
        weld_type_10 (append (litera-from-to-list "С" 1 30)
                             (litera-from-to-list "У" 1 10)
                             (litera-from-to-list "Т" 1 10)
                             (litera-from-to-list "Н" 1 10))
        weld_type_11 weld_type_10                                               ;ЭЛС = И 255.105.111
        weld_type_12 (append (litera-from-to-list "С" 1 30)
                             (litera-from-to-list "У" 1 10)
                             (litera-from-to-list "Т" 1 10)
                             (litera-from-to-list "Н" 1 10))
        weld_type_13 weld_type_12                                               ;ЭШС - ГОСТ 15164
        weld_type_14 (append (litera-from-to-list "С" 1 30)
                             (litera-from-to-list "У" 1 10)
                             (litera-from-to-list "Т" 1 10)
                             (litera-from-to-list "Н" 1 10))
        weld_type_15 weld_type_14)
  (setq setup_lst    (list '("top_text" nil)
                           '("bot_text" "")
                           '("nomer" "")
                           '("kolichestvo" "")
                           '("dim_style" "0" nil)
                           '("tgl_ob_side" "0")
                           (list tile_wedl_standard
                                 "0"
                                 (list "Тип А"           "ГОСТ 5264-80"         ;
                                       "Тип Б"           "ГОСТ 11534-75"        ;
                                       "Тип В"           "ГОСТ 14771-76"        ;
                                       "Тип Г"           "ГОСТ 23518-79"        ;
                                       "Тип Д"           "ГОСТ 15878-79"        ;
                                       "Тип Е"           "ГОСТ 16037-80"        ;
                                       "ЭШС"             "ГОСТ 15164-78"        ;
                                       "ЭЛС"             "И 255.105.111"        ;
                                       ))
                           (list tile_weld_type "0" weld_type_1)
                           (list tile_weld_sposob "" (list "ИН" "ИНп" "ИП" "УП" "Э"))
                           (list tile_weld_kategory "3" (list "I" "II" "III" "IV"))
                           (list tile_weld_kontrol_group "17" (litera-from-to-list "" 1 19))
                           '("tgl_katet" "")
                           '("str_katet" "")
                           '("str_provar" "")
                           '("tgl_linear" "0")
                           '("tgl_shahm" "")
                           '("str_provar_neprovar" "")
                           '("tgl_close_contur" "0")
                           '("tgl_open_contur" "")
                           '("tgl_usilenie_top" "0")
                           '("tgl_plavn_top" "")
                           '("tgl_montaz" "")
                           '("tgl_usilenie_bot" "")
                           '("tgl_plavn_bot" "")
                           '("rb_clock" "1")
                           '("rb_unclock" "0")
                           '("rb_prisoed_left" "1")
                           '("rb_prisoed_right" "0")
                           '("error" ""))
        dia_weld_pos '(-1 -1)                                                   ; Положение диалога на экране
        reg_root     "HKEY_CURRENT_USER\\Software\\MNASoft\\MNAS\\Welding"      ; Место в системном реестре с данными о диалоге.
        reg_val      (mapcar (function (lambda (el) (cons el (list (eval el)))))
                             (list 'setup_lst 'dia_weld_pos)))
  (setup_bit_mask)                                                              ;Инициализация переменных, определяющих битовые маски, используемые для заполнения данных о диалоге.
  (reg_read_default_lst reg_root reg_val)
;;;(select)	; Выбор сварного шва для редактирования .
;;;(get_data ed)	; Выборка данных из примитива сварки для формирования диалога.
  (setq dcl_id (load_dialog "./src/lsp/MNAS/welding/welding.dcl"))              ; Загрузка диалога.
  (setq do_dialog t)
  (while do_dialog
    (if (not (new_dialog "mnas_weld_main" dcl_id "" dia_weld_pos))
      (exit))
    (init_dlg setup_lst)
    (slide_setup)                                                               ; Заполнение слайдов
    (action-tile_dlg "setup_lst" "setup_lst" "" "")
    (action_tile "accept" "(ac_accept)")
    (action_tile "apply_btn" "(ac_apply_btn)")
    (action_tile "select" "(setq dia_weld_pos (done_dialog 3))")
    (action_tile "tgl_close_contur" "(action_tgl_close_contur)")
    (action_tile "tgl_open_contur" "(action_tgl_open_contur)")
    (action_tile "tgl_usilenie_top" "(action_tgl_usilenie_top)")
    (action_tile "tgl_plavn_top" "(action_tgl_plavn_top)")
    (action_tile "tgl_usilenie_bot" "(action_tgl_usilenie_bot)")
    (action_tile "tgl_plavn_bot" "(action_tgl_plavn_bot)")
    (action_tile "tgl_shahm" "(action_tgl_shahm)")
    (action_tile "tgl_linear" "(action_tgl_linear)")
    (action_tile "tgl_katet" "(action_tgl_katet)")
    (action_tile "text_home" "(action_text_home)")
    (action_tile tile_wedl_standard
                 "(setq wst (get_tile tile_wedl_standard) dia_weld_pos (done_dialog 8))")
    (action_tile "about" "(about)")
    (tile_modes_set)
    (setq action (start_dialog))
    (cond ((= action 8) (action_wedl_standard))
          ((= action 7)
           (mapcar (function
                     (lambda (el)
                       (setq setup_lst (subst (list el "0") (assoc el setup_lst) setup_lst))))
                   '("text_toggle"              "arrow_type_toggle"
                     "dim_style_toggle"         "text_color_toggle"
                     "text-scale_toggle"        "line-offset_toggle")))
          ((= action 6)
           (mapcar (function
                     (lambda (el)
                       (setq setup_lst (subst (list el "1") (assoc el setup_lst) setup_lst))))
                   '("text_toggle"              "arrow_type_toggle"
                     "dim_style_toggle"         "text_color_toggle"
                     "text-scale_toggle"        "line-offset_toggle")))
          ((= action 5)
           (setq text_color_n (acad_colordlg (cdr (assoc 70 ed)))
                 ed           (subst (cons 70 text_color_n) (assoc 70 ed) ed)))
          ((= action 4) (ac_match_apply))
          ((= action 3) (select) (get_data ed))
          ((= action 2) (ac_apply_do))
          ((= action 1) (ac_accept_do) (setq do_dialog nil))
          ((= action 0) (setq do_dialog nil))
          (setq do_dialog nil)))
  (unload_dialog dcl_id)
  setup_lst)

(defun c:welding ()
  (c:edweld))
