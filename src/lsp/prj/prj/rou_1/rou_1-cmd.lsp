'(("ru" "Шероховатость") ("uk" "Шорсткість") ("en" "Surface Roughness"))

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
         (setq setup_lst (rou_1-subst_title_assoc_list "pl_1_max_val" lst)
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
