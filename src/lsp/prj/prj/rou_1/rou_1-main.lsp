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
  (setq dcl_id (load_dialog (findfile (utils:path-src-lsp "prj/prj/rou_1/rou_1.dcl"))))
  (while do_dialog
    (if (not (new_dialog "roughness" dcl_id "" rou_1-dia_sher_pos))
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
                    (command-s "_regen")
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
                             (command-s "_regen"))
                      (setq setup_lst (subst (list "error" "Необходимо выбрать знак шероховатости") (assoc "error" setup_lst) setup_lst))))
             (setq setup_lst (subst (list "error" "Ничего не выбрано") (assoc "error" setup_lst) setup_lst))))
          ((= ac 4)
           (if (and p1 p2)
             (progn (entdel en)
                    (rou_1-draw_sher p1 p2)
                    (setq en (entlast))
                    (command-s "_regen")
                    (setq setup_lst (subst (list "error" "") (assoc "error" setup_lst) setup_lst)))))))
  (unload_dialog dcl_id)
  (err-handle ""))
