(setq rou_1-rou_lists
       '(("Ra "
          ("0"
           ("Ra 50" "Ra 25" "Ra 12,5" "Ra 6,3" "Ra 3,2" "Ra 1,6" "Ra 0,8" "Ra 0,4" "Ra 0,2" "Ra 0,1" "Ra 0,05" "Ra 0,025" "Ra 0,012" "Ra 0,006"))
          ("1"
           ("Ra 80" "Ra 40" "Ra 20" "Ra 10" "Ra 5" "Ra 2,5" "Ra 1,25" "Ra 0,63" "Ra 0,32" "Ra 0,16" "Ra 0,08" "Ra 0,04" "Ra 0,02" "Ra 0,01"))
          ("2"
           ("Ra 63" "Ra 32" "Ra 16" "Ra 8" "Ra 4" "Ra 2" "Ra 1" "Ra 0,5" "Ra 0,25" "Ra 0,125" "Ra 0,063" "Ra 0,032" "Ra 0,016" "Ra 0,008"))
          ("3"
           ("Ra 40" "Ra 20" "Ra 10" "Ra 5" "Ra 2,5" "Ra 1,25" "Ra 0,63" "Ra 0,32" "Ra 0,16" "Ra 0,08" "Ra 0,04" "Ra 0,02" "Ra 0,01" "Ra 0,005")))
         ("Rz "
          ("0"
           ("Rz 320" "Rz 160" "Rz 80" "Rz 40" "Rz 20" "Rz 10" "Rz 6,3" "Rz 3,2" "Rz 1,6" "Rz 0,8" "Rz 0,4" "Rz 0,2" "Rz 0,1" "Rz 0,05"))
          ("1"
           ("Rz 250" "Rz 125" "Rz 63" "Rz 32" "Rz 16" "Rz 8" "Rz 5" "Rz 2,5" "Rz 1,25" "Rz 0,63" "Rz 0,32" "Rz 0,16" "Rz 0,08" "Rz 0,04"))
          ("2"
           ("Rz 200" "Rz 100" "Rz 50" "Rz 25" "Rz 12,5" "Rz 6,3" "Rz 4" "Rz 2" "Rz 1" "Rz 0,5" "Rz 0,25" "Rz 0,125" "Rz 0,063" "Rz 0,032"))
          ("3"
           ("Rz 160" "Rz 80" "Rz 40" "Rz 20" "Rz 10" "Rz 5" "Rz 3,2" "Rz 1,6" "Rz 0,8" "Rz 0,4" "Rz 0,2" "Rz 0,1" "Rz 0,05" "Rz 0,025")))))

(setq rou_1-setup_lst_bak0
       '(("eb_1_1" "10")                ; Значение
         ("eb_1_2" "")                  ; Способ получения
         ("eb_1_3" "1.0")               ; Маштаб
         ("rb_1_1" "1")                 ; Со снятием осн. м-ла
         ("rb_1_2" "0")                 ; Без снятия осн. м-ла
         ("rb_1_3" "0")                 ; Необработка
         ("tgl_1_1" "0")                ; В скобках
         ("tgl_1_2" "0")                ; По контуру
         ("tgl_1_3" "0")                ; Перевернутый
         ("tgl_1_11" "1")               ; Проставлять текст
         ("tgl_1_12" "0")               ; Проставлять способ получения
         ("ppl_1_1" "0")                ; Тип микронеровностей
         ("pl_1_1" "3" ("80" "40" "20" "10" "5" "2,5" "1,25" "0,63" "0,32" "0,16" "0,08")) ; Значения микронеровностей
         ("pl_1_2" "0" ("Притереть" "Полировать")) ;Способ получения шероховатости
         ("error" "")                   ; Поток ошибок
         ))
                                        ;"Шабрить" "Развертывать" "Протягивать" "Шлифовать" "Притереть" "Полировать" "Хонинговать" "Накатать"
(setq reg_root "HKEY_CURRENT_USER\\Software\\MNASoft\\Dims\\Rou")

;;;;;;("rou" "Простановка обозначения шероховатости." "Размеры")
(defun c:rou  (/ dcl_id do_dialog p1 p2 fl fl_nm old_err kw str_kw osm reg_root rou_registry)
  (err-init '("cmdecho" "osmode"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (setq reg_root "HKEY_CURRENT_USER\\Software\\MNASoft\\Dims\\Rou")
  (setq rou_registry
         '((rou_1-dia_sher_pos (-1 -1))
           (setup_lst
            (("rb_1_Ra" "1")            ;
             ("rb_1_Rz" "0")            ;
             ("pl_1_RaRz" "1" ("1" "2" "3" "4")) ;
             ("tgl_1_max_val" "1")      ;tgl_1_11  ; Проставлять текст
             ("eb_1_max_val" "10")      ;eb_1_1 ; Значение
             ("pl_1_max_val" "3" ("80" "40" "20" "10" "5" "2,5" "1,25" "0,63" "0,32" "0,16" "0,08")) ;pl_1_1 ; Значения микронеровностей
             ("tgl_1_min_val" "0")      ;
             ("eb_1_min_val" "5")       ;
             ("pl_1_min_val" "4" ("80" "40" "20" "10" "5" "2,5" "1,25" "0,63" "0,32" "0,16" "0,08")) ;
             ("tgl_1_spos_pol" "0")     ;tgl_1_12 ; Проставлять способ получения
             ("eb_1_spos_pol" "")       ;eb_1_2 ; Способ получения
             ("pl_1_spos_pol"
              "0"
              ("Шабрить" "Развертывать" "Протягивать" "Шлифовать" "Притереть" "Полировать" "Хонинговать" "Накатать"))
                                        ;pl_1_2 ; Способ получения шероховатости; "Притереть" "Полировать"
             ("rb_1_osn_ml_sn" "1")     ;rb_1_1 ; Со снятием осн. м-ла
             ("rb_1_osn_ml_nesn" "0")   ;rb_1_2 ; Без снятия осн. м-ла
             ("rb_1_osn_ml_neobr" "0")  ;rb_1_3 ; Необработка
             ("rb_1_bez_sk" "1")        ;rb_1_4 ; Без скобок
             ("rb_1_kr_sk" "0")         ;rb_1_5 ; В () скобках
             ("rb_1_kv_sk" "0")         ;rb_1_6 ; В [] скобках
             ("tgl_1_po_konturu" "0")   ;tgl_1_2 ; По контуру
             ("tgl_1_perevern" "0")     ;tgl_1_3 ; Перевернутый
             ("tgl_1_napr_miko_ner" "0")
             ("pl_1_napr_miko_ner"
              "0"
              ("Параллельное" "Перпендикулярное" "Скрещенное" "Кольчужное" "Концентричное" "Радиальное" "Точечное")) ;ppl_1_1
             ("eb_1_masht" "1")         ;eb_1_3 ; Маштаб
             ("pl_1_masht"
              "11"
              ("100:1" "50:1" "40:1" "25:1" "20:1" "15:1" "10:1" "5:1" "4:1" "2.5:1" "2:1" "1:1" "1:2" "1:2.5" "1:4" "1:5" "1:10" "1:15" "1:20" "1:25"
               "1:40" "1:50" "1:100"))  ;
             ("error" "")               ;error ; Поток ошибок
             ))))
  (reg_read_default_lst reg_root rou_registry)
  (if (null (tblsearch "style" "t"))
    (stl))
  (setq setup_lst (subst (list "eb_1_masht" (rtos (getvar "DIMSCALE") 2 4)) (assoc "eb_1_masht" setup_lst) setup_lst))
  (setq do_dialog t)
  (setq dcl_id (load_dialog (findfile (utils:path-src-lsp "dims/rou_1/rou_1.dcl"))))
  (while do_dialog
    (if (not (new_dialog "шероховатость" dcl_id "" rou_1-dia_sher_pos))
      (exit))
    (rou_1-init)
    (mapcar (function (lambda (el) (action_tile (car el) "(rou_1-ac_1)"))) setup_lst)
    (action_tile "cancel" "(setq rou_1-dia_sher_pos(done_dialog 0))")
    (action_tile "accept" "(setq rou_1-dia_sher_pos(done_dialog 1))")
    (action_tile "bt_1_1" "(setq rou_1-dia_sher_pos(done_dialog 2))")
    (action_tile "bt_1_2" "(setq rou_1-dia_sher_pos(done_dialog 3))")
    (action_tile "bt_1_3" "(setq rou_1-dia_sher_pos(done_dialog 4))")
    (action_tile "bt_1_masht" "(rou_1-ac_bt_1_masht)")
    (action_tile "rb_1_Ra" "(rou_1-ac_rb_1_Ra $value)")
    (action_tile "rb_1_Rz" "(rou_1-ac_rb_1_Rz $value)")
    (action_tile "pl_1_RaRz" "(rou_1-ac_pl_1_RaRz $value)")
    (action_tile "tgl_1_max_val" "(rou_1-ac_tgl_1_max_val $value)")
    (action_tile "tgl_1_min_val" "(rou_1-ac_tgl_1_min_val $value)")
    (action_tile "tgl_1_spos_pol" "(rou_1-ac_tgl_1_spos_pol $value)")
    (action_tile "eb_1_max_val" "(rou_1-ac_eb_1_max_val $value)")
    (action_tile "eb_1_min_val" "(rou_1-ac_eb_1_min_val $value)")
    (action_tile "eb_1_spos_pol" "(rou_1-ac_eb_1_spos_pol $value)")
    (action_tile "pl_1_max_val" "(rou_1-ac_pl_1_max_val $value)")
    (action_tile "pl_1_min_val" "(rou_1-ac_pl_1_min_val $value)")
    (action_tile "pl_1_masht" "(rou_1-ac_pl_1_masht $value)")
    (action_tile "pl_1_spos_pol" "(rou_1-ac_pl_1_spos_pol $value)")
    (action_tile "help" "(rou_1-help)")
    (setq ac (start_dialog))
    (cond ((= ac 0) (setq do_dialog nil))
          ((= ac 1) (rou_1-ac_ok))
          ((= ac 2)
           (setq p1 (getpoint "\nВерхняя точка на вертикали знака:"))
           (if p1
             (progn (setq osm (getvar "osmode"))
                    (setvar "osmode" 128)
                    (setq p2 (getpoint p1 "\nНижняя точка на вертикали знака:"))
                    (setvar "osmode" osm)))
           (if (and p1 p2)
             (progn (rou_1-draw_sher p1 p2)
                    (setq en (entlast))
                    (command "_regen")
                    (setq setup_lst (subst (list "error" "") (assoc "error" setup_lst) setup_lst)))
             (setq setup_lst (subst (cons "error" "Необходимо вводить две точки !") (assoc "error" setup_lst) setup_lst))))
          ((= ac 3)
           (setq en (car (entsel "\nВыберите шероховатость:")))
           (if en
             (progn (setq ob      (vlax-ename->vla-object en)
                          vl-data (vlax-ldata-get ob "rou"))
                    (if (and ob vl-data)
                      (progn (setq p2        (vlax-safearray->list (vlax-variant-value (vlax-get-property ob 'insertionpoint)))
                                   dp        (mapcar (function -) (vlax-ldata-get ob "rou-p_top") (vlax-ldata-get ob "rou-p_bas"))
                                   p1        (mapcar (function +) p2 dp)
                                   setup_lst (cond (vl-data (rou_1-update_ver_rou vl-data))
                                                   ((null vl-data) setup_lst)))
                             (command "_regen"))
                      (setq setup_lst (subst (list "error" "Необходимо выбрать знак шероховатости") (assoc "error" setup_lst) setup_lst))))
             (setq setup_lst (subst (list "error" "Ничего не выбрано") (assoc "error" setup_lst) setup_lst))))
          ((= ac 4)
           (if (and p1 p2)
             (progn (entdel en)
                    (rou_1-draw_sher p1 p2)
                    (setq en (entlast))
                    (command "_regen")
                    (setq setup_lst (subst (list "error" "") (assoc "error" setup_lst) setup_lst)))))))
  (unload_dialog dcl_id)
  (err-handle ""))


(defun rou_1-subst_title_assoc_list  (title lst)
  (subst (append (reverse (cdr (reverse (assoc title setup_lst)))) (list lst))
         (assoc title setup_lst)
         setup_lst))
(defun rou_1-eb_max_min  ()
  (set_tile "eb_1_max_val"
            (nth (atoi (get_tile "pl_1_max_val")) (caddr (assoc "pl_1_max_val" setup_lst))))
  (set_tile "eb_1_min_val"
            (nth (atoi (get_tile "pl_1_min_val")) (caddr (assoc "pl_1_min_val" setup_lst)))))

(defun rou_1-ac_rb_1_ra  (val / no_ryada lst)
  (cond ((= val "1")
         (setq no_ryada (cadr (assoc "pl_1_RaRz" setup_lst)))
         (setq lst (cadr (assoc no_ryada (cdr (assoc "Ra " rou_1-rou_lists)))))
         (setq setup_lst (rou_1-subst_title_assoc_list "pl_1_max_val" lst)
               setup_lst (rou_1-subst_title_assoc_list "pl_1_min_val" lst))))
  (rou_1-eb_max_min)
  (rou_1-ac_1))

(defun rou_1-ac_rb_1_rz  (val)
  (cond ((= val "1")
         (setq no_ryada (cadr (assoc "pl_1_RaRz" setup_lst)))
         (setq lst (cadr (assoc no_ryada (cdr (assoc "Rz " rou_1-rou_lists)))))
         (setq setup_lst (subst_title_assoc_list "pl_1_max_val" lst)
               setup_lst (rou_1-subst_title_assoc_list "pl_1_min_val" lst))))
  (rou_1-eb_max_min)
  (rou_1-ac_1))

(defun rou_1-ac_pl_1_rarz  (val / no_ryada lst)
  (cond ((= (get_tile "rb_1_Rz") "1")
         (setq no_ryada val)
         (setq lst (cadr (assoc no_ryada (cdr (assoc "Rz " rou_1-rou_lists)))))
         (setq setup_lst (rou_1-subst_title_assoc_list "pl_1_max_val" lst)
               setup_lst (rou_1-subst_title_assoc_list "pl_1_min_val" lst)))
        ((= (get_tile "rb_1_Ra") "1")
         (setq no_ryada val)
         (setq lst (cadr (assoc no_ryada (cdr (assoc "Ra " rou_1-rou_lists)))))
         (setq setup_lst (rou_1-subst_title_assoc_list "pl_1_max_val" lst)
               setup_lst (rou_1-subst_title_assoc_list "pl_1_min_val" lst))))
  (rou_1-eb_max_min)
  (rou_1-ac_1))

(defun rou_1-ac_tgl_1_max_val  (val)
  (cond ((and (= val "1") (/= "" (get_tile "eb_1_max_val"))))
        ((and (= val "1") (= "" (get_tile "eb_1_max_val")))
         (set_tile "tgl_1_max_val" "0")
         (set_tile "error" "Поле максимального значения должно быть не пустым")))
  (rou_1-ac_1))

(defun rou_1-ac_tgl_1_min_val  (val)
  (cond ((and (= val "1") (/= "" (get_tile "eb_1_min_val"))))
        ((and (= val "1") (= "" (get_tile "eb_1_min_val")))
         (set_tile "tgl_1_min_val" "0")
         (set_tile "error" "Поле минимального значения должно быть не пустым")))
  (rou_1-ac_1))


(defun rou_1-ac_tgl_1_spos_pol  (val)
  (cond ((and (= val "1") (/= "" (get_tile "eb_1_spos_pol"))))
        ((and (= val "1") (= "" (get_tile "eb_1_spos_pol")))
         (set_tile "tgl_1_spos_pol" "0")
         (set_tile "error" "Поле способа получения должно быть не пустым")))
  (rou_1-ac_1))

(defun rou_1-ac_eb_1_max_val  (val)
  (if (= val "")
    (set_tile "tgl_1_max_val" "0")
    (set_tile "tgl_1_max_val" "1"))
  (rou_1-ac_1))

(defun rou_1-ac_eb_1_min_val  (val)
  (if (= val "")
    (set_tile "tgl_1_min_val" "0")
    (set_tile "tgl_1_min_val" "1"))
  (rou_1-ac_1))

(defun rou_1-ac_eb_1_spos_pol  (val)
  (if (= val "")
    (set_tile "tgl_1_spos_pol" "0")
    (set_tile "tgl_1_spos_pol" "1"))
  (rou_1-ac_1))

(defun rou_1-ac_pl_1_max_val  (val / zn_sher)
  (setq zn_sher (nth (atoi val) (caddr (assoc "pl_1_max_val" setup_lst))))
  (set_tile "eb_1_max_val" zn_sher)
  (set_tile "tgl_1_max_val" "1")
  (rou_1-ac_1))

(defun rou_1-ac_pl_1_min_val  (val / zn_sher)
  (setq zn_sher (nth (atoi val) (caddr (assoc "pl_1_min_val" setup_lst))))
  (set_tile "eb_1_min_val" zn_sher)
  (set_tile "tgl_1_min_val" "1")
  (rou_1-ac_1))

(defun rou_1-ac_pl_1_masht  (val / first_sc poz sc second_sc zn_masht)
  (setq zn_masht  (nth (atoi val) (caddr (assoc "pl_1_masht" setup_lst)))
        poz       (vl-string-search ":" zn_masht)
        first_sc  (float (read (substr zn_masht 1 poz)))
        second_sc (float (read (substr zn_masht (+ 2 poz))))
        sc        (/ second_sc first_sc))
  (set_tile "eb_1_masht" (rtos sc 2 4))
  (rou_1-ac_1))


(defun rou_1-ac_pl_1_spos_pol  (val / sp_obr)
  (setq sp_obr (nth (atoi val) (caddr (assoc "pl_1_spos_pol" setup_lst))))
  (set_tile "eb_1_spos_pol" sp_obr)
  (set_tile "tgl_1_spos_pol" "1")
  (rou_1-ac_1))

(defun rou_1-point_box  (l_pts / x y)   ;Возвращает список состоящий из 2-х точек.
                                        ;Превая точка имеет левые и нижние координаты.
                                        ;Вторая - правые верхние.
  (setq x (mapcar 'car l_pts)
        y (mapcar 'cadr l_pts))
  (list (list (apply 'min x) (apply 'min y)) (list (apply 'max x) (apply 'max y))))

(defun rou_1-init  ()
  (mapcar (function (lambda (el)
                      (cond ((= 2 (length el)) (set_tile (car el) (cadr el)))
                            ((= 3 (length el))
                             (start_list (car el))
                             (mapcar (function add_list) (caddr el))
                             (end_list)
                             (set_tile (car el) (cadr el))))))
          setup_lst))

(defun rou_1-ac_1  (/ temp)
  (setq setup_lst (mapcar (function (lambda (el)
                                      (cond ((= 2 (length el)) (list (car el) (get_tile (car el))))
                                            ((= 3 (length el)) (list (car el) (get_tile (car el)) (caddr el))))))
                          setup_lst))
  (setq temp (distof (cadr (assoc "eb_1_masht" setup_lst))))
  (if (or (null temp) (= temp 0.0))
    (setq temp 1.0))
  (setq setup_lst (subst (list "eb_1_masht" (rtos temp 2 4)) (assoc "eb_1_masht" setup_lst) setup_lst))
  (rou_1-init))

(defun rou_1-ac_ok () (setq do_dialog nil) (reg_write_default_lst reg_root rou_registry))

(defun rou_1-ac_bt_1_masht () (set_tile "eb_1_masht" (rtos (getvar "dimscale") 2 4)) (rou_1-ac_1))

(defun rou_1-help () (help (strcat (acad_help) "/rou/rou.html")))