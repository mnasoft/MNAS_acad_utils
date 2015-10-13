(defun c:edweld  (/                     ;
                  ed                    ; DXF ������, �������������� ���
                  action                ; ��������, ������������ ��� �������� �������
                  arrow_type_lst        ; ������ ����� �������
                  arrow_type_n          ; �������� ���� �������
                  arrow_type_tile       ; tile ���� �������
                  dcl_id                ; ���������� �������
                  dia_weld_pos          ; ��������� ���������� ��������� �������
                  dim_stl               ; ��� ���������� ����� � �������� ����������� �������
                  dim_stl_lst           ; ������ ��������� ������ �������
                  dim_stl_n             ; ����� ���������� ����� ������� ������� � ������ ������ ��������
                  do_dialog             ; ������� ����, ��� ������ ����� ����������� ����� ��������� �������
                  reg_root              ; ����� � ��������� �������, ��� ����� ����������� ��������� �������
                  reg_val               ; ��������� �������
                  setup_lst             ; ������, ����������� ������� ���������� �������
                  text-scale_n          ; ������� ������ ������ (������������ ������ ������ ���������� �����)
                  text-scale_tile       ; ������� ������ ������ � tile
                  text_color_n          ; ������ ����� ������ �������
                  text_n                ; �����, ������������� �������
                  text_tile             ; tile ������ �������
                  )
  (setq tile_wedl_standard "wedl_standard"
        tile_weld_type "weld_type"
        tile_weld_sposob "weld_sposob"
        tile_weld_kategory "weld_kategory"
        tile_weld_kontrol_group "weld_kontrol_group"
        weld_pp_list_str
         (list tile_wedl_standard tile_weld_type tile_weld_sposob tile_weld_kategory tile_weld_kontrol_group)
        weld_pp_list_code
         '(70 71 72 73 74))
  (setq weld_type_0  (append (litera-from-to-list "�" 1 30)
                             (litera-from-to-list "�" 1 10)
                             (litera-from-to-list "�" 1 10)
                             (litera-from-to-list "�" 1 10)) ;��� � = ���� 5264.
        weld_type_1  weld_type_0        ;��� � = ���� 11534.
        weld_type_2  (append (litera-from-to-list "�" 1 30)
                             (litera-from-to-list "�" 1 10)
                             (litera-from-to-list "�" 1 10)
                             (litera-from-to-list "�" 1 10))
        weld_type_3  weld_type_2        ;��� B = ���� 14771-76.
        weld_type_4  (append (litera-from-to-list "�" 1 30)
                             (litera-from-to-list "�" 1 10)
                             (litera-from-to-list "�" 1 10)
                             (litera-from-to-list "�" 1 10))
        weld_type_5  weld_type_4        ;��� � = ���� 23518.
        weld_type_6  (append (litera-from-to-list "�" 1 30)
                             (litera-from-to-list "�" 1 10)
                             (litera-from-to-list "�" 1 10)
                             (litera-from-to-list "�" 1 10))
        weld_type_7  weld_type_6        ;��� � = ���� 15878
        weld_type_8  (append (litera-from-to-list "�" 1 30)
                             (litera-from-to-list "�" 1 10)
                             (litera-from-to-list "�" 1 10)
                             (litera-from-to-list "�" 1 10))
        weld_type_9  weld_type_8        ;��� � = ���� 16037
        weld_type_10 (append (litera-from-to-list "�" 1 30)
                             (litera-from-to-list "�" 1 10)
                             (litera-from-to-list "�" 1 10)
                             (litera-from-to-list "�" 1 10))
        weld_type_11 weld_type_10       ;��� = � 255.105.111
        weld_type_12 (append (litera-from-to-list "�" 1 30)
                             (litera-from-to-list "�" 1 10)
                             (litera-from-to-list "�" 1 10)
                             (litera-from-to-list "�" 1 10))
        weld_type_13 weld_type_12       ;��� - ���� 15164
        weld_type_14 (append (litera-from-to-list "�" 1 30)
                             (litera-from-to-list "�" 1 10)
                             (litera-from-to-list "�" 1 10)
                             (litera-from-to-list "�" 1 10))
        weld_type_15 weld_type_14)
  "�������� ����, �������������� �������� � �������. Cas-shielded arc welding. Welded joints. Main types, design elements and dimensions"
  (setq setup_lst    (list '("top_text" "")
                           '("bot_text" "")
                           '("nomer" "")
                           '("kolichestvo" "")
                           '("dim_style" "0" nil)
                           '("tgl_ob_side" "0")
                           (list tile_wedl_standard
                                 "0"    ;(list "��� �" "��� �" "��� �" "��� �" "���" "���� 5264" "���� 11534" "���� 14771-76" "���� 23518" "���� 15878")
                                 (list "��� �"           "���� 5264-80"    "��� �"           "���� 11534-75"
                                       "��� �"           "���� 14771-76"   "��� �"           "���� 23518-79"
                                       "��� �"           "���� 15878-79"   "��� �"           "���� 16037-80"
                                       "���"             "���� 15164-78"   "���"             "� 255.105.111"))
                           (list tile_weld_type "0" weld_type_1)
                           (list tile_weld_sposob "" (list "��" "���" "��" "��" "�"))
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
        ;; ��������� ������� �� ������
        dia_weld_pos '(-1 -1)
        ;; ����� � ��������� ������� � ������� � �������.
        reg_root     "HKEY_CURRENT_USER\\Software\\MNASoft\\MNAS\\Welding"
        ;; 
        reg_val      (mapcar (function (lambda (el) (cons el (list (eval el))))) (list 'setup_lst 'dia_weld_pos)))
  ;;������������� ����������, ������������ ������� �����, ������������ ��� ���������� ������ � �������.
  (setup_bit_mask)
  (reg_read_default_lst reg_root reg_val)
  ;; ����� �������� ��� ��� �������������� .
  (select)
  ;; ������� ������ �� ��������� ������ ��� ������������ �������.
  (get_data ed)
  ;; �������� �������.
  (setq dcl_id (load_dcl "/MNAS/welding/welding.dcl"))
  (setq do_dialog t)
  (while do_dialog
    (if (not (new_dialog "mnas_weld_main" dcl_id "" dia_weld_pos))
      (exit))
    (init_dlg setup_lst)
    ;; ���������� �������
    (slide_setup)
    (action-tile_dlg "setup_lst" "setup_lst")
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
           (mapcar (function (lambda (el) (setq setup_lst (subst (list el "0") (assoc el setup_lst) setup_lst))))
                   '("text_toggle"              "arrow_type_toggle"        "dim_style_toggle"
                     "text_color_toggle"        "text-scale_toggle"        "line-offset_toggle")))
          ((= action 6)
           (mapcar (function (lambda (el) (setq setup_lst (subst (list el "1") (assoc el setup_lst) setup_lst))))
                   '("text_toggle"              "arrow_type_toggle"        "dim_style_toggle"
                     "text_color_toggle"        "text-scale_toggle"        "line-offset_toggle")))
          ((= action 5)
           (setq text_color_n (acad_colordlg (cdr (assoc 70 ed)))
                 ed           (subst (cons 70 text_color_n) (assoc 70 ed) ed)))
          ((= action 4) (ac_match_apply))
          ((= action 3) (select) (get_data ed))
          ((= action 2) (ac_apply_do))
          ((= action 1) (ac_accept_do) (setq do_dialog nil))
          ((= action 0) (setq do_dialog nil))
          (setq do_dialog nil)))
  (unload_dialog dcl_id))
































(defun ac_accept  ()
  (setq dia_weld_pos (done_dialog 1))
  (setq reg_val (mapcar (function (lambda (el) (cons el (list (eval el))))) (list 'setup_lst 'dia_weld_pos)))
  (reg_write_default_lst reg_root reg_val))

(defun ac_apply_btn () (setq dia_weld_pos (done_dialog 2)))

;;;��������� � ������� ������������� ������� ���������, ����������� � �������
(defun ac_accept_do  ()
  (mid_point_apply)
  (arrow_apply)                         ;(text_top_bot_apply)
  (text_list_apply)
  (tgl_list_apply)
  (setq dim_stl_tile (assoc "dim_style" setup_lst)
        dim_stl      (nth (atoi (cadr dim_stl_tile)) (caddr dim_stl_tile))
        ed           (subst (cons 340 (tblobjname "dimstyle" dim_stl)) (assoc 340 ed) ed))
  (weld_pp_list_apply)
  (entmod ed)
  (command "_redraw"))

;;;��������� � ������� ������������� ������� ���������, ����������� � �������
(defun ac_apply_do  ()
  (mid_point_apply)
  (arrow_apply)
  (text_top_bot_apply)
  (text_list_apply)
  (tgl_list_apply)
  (setq dim_stl_tile (assoc "dim_style" setup_lst)
        dim_stl      (nth (atoi (cadr dim_stl_tile)) (caddr dim_stl_tile))
        ed           (subst (cons 340 (tblobjname "dimstyle" dim_stl)) (assoc 340 ed) ed))
  (weld_pp_list_apply)
  (entmod ed)
  (command "_redraw"))

(defun arrow_apply  ()
  (setq group_40 (assoc 40 ed)
        group_41 (assoc 41 ed)
        val_40   (cdr (assoc 40 ed))
        val_41   (cdr (assoc 41 ed)))
  (cond ((and (get_tile_test "rb_clock") (> val_40 0.0))
         (setq ed (subst_dxf (list (cons 40 (* -1. val_40)) (cons 41 (* -1. val_41))) ed)))
        ((and (get_tile_test "rb_unclock") (< val_40 0.0))
         (setq ed (subst_dxf (list (cons 40 (* -1. val_40)) (cons 41 (* -1. val_41))) ed)))))

;;;��������� ���������� �������� mathprop ��� �������.
(defun ac_match_apply  (/ match_prop    ; ����� ������ 
                        match_prop_ed   ; DXF - ������ i - ���� �������� �� ������ ������
                        match_prop_en   ; ��� i-���� �������� ������ ������
                        match_prop_length ; ���������� ��������� � ������ ������
                        i               ; ������ ��� ������� �� ��������� ������ ������
) (setq match_prop (ssget))
  (setq match_prop_length (sslength match_prop)
        i                 0)
  (while (< i match_prop_length)
    (setq match_prop_en (ssname match_prop i)
          match_prop_ed (entget match_prop_en))
    (cond ((= "MNASPozition" (cdr (assoc 0 match_prop_ed)))
           (if (= "1" (cadr (assoc "text_toggle" setup_lst)))
             (progn (setq match_prop_ed (subst (assoc 1 ed) (assoc 1 match_prop_ed) match_prop_ed))))
           (if (= "1" (cadr (assoc "arrow_type_toggle" setup_lst)))
             (progn (setq match_prop_ed (subst (assoc 91 ed) (assoc 91 match_prop_ed) match_prop_ed))))
           (if (= "1" (cadr (assoc "dim_style_toggle" setup_lst)))
             (progn (setq match_prop_ed (subst (assoc 340 ed) (assoc 340 match_prop_ed) match_prop_ed))))
           (if (= "1" (cadr (assoc "text-scale_toggle" setup_lst)))
             (progn (setq match_prop_ed (subst (assoc 40 ed) (assoc 40 match_prop_ed) match_prop_ed))))
           (if (= "1" (cadr (assoc "line-offset_toggle" setup_lst)))
             (progn (setq match_prop_ed (subst (assoc 41 ed) (assoc 41 match_prop_ed) match_prop_ed))))
           (if (= "1" (cadr (assoc "text_color_toggle" setup_lst)))
             (progn (setq match_prop_ed (subst (assoc 70 ed) (assoc 70 match_prop_ed) match_prop_ed))))
           (entmod match_prop_ed)))
    (setq i (1+ i)))
  (command "_redraw"))

(defun ac_text_color_image (key x y) (done_dialog 5))

(defun about () (alert (strcat "�������������� ����������� ������� ����" (about-gpl-string))))


litera-from-to-list
(defun litera-from-to-list  (litera from to / i lst)
  (setq i to)
  (repeat (- to from -1)
    (setq lst (cons i lst)
          i   (1- i)))
  (mapcar (function (lambda (el) (strcat litera (rtos el)))) lst))


(defun slide_setup  ()
  (mapcar (function slide_show)
          '("img_katet"             "img_close_contur"      "img_open_contur"       "img_usilenie_top"
            "img_plavn_top"         "img_montaz"            "img_usilenie_bot"      "img_plavn_bot")))

(defun slide_show  (img_name)
  (start_image img_name)
  (setq dx (dimx_tile img_name)
        dy (dimy_tile img_name))
  (fill_image 0 0 dx dy 0)
  (slide_image 0 0 dx dy (strcat (acad_sup) "/MNAS/Welding/" img_name))
  (end_image))

(defun text_setup  (title dxf_code)
  (setq setup_lst (subst (list title (cdr (assoc dxf_code ed))) (assoc title setup_lst) setup_lst)))

(defun text_apply  (title dxf_code)
  (setq ed (subst (cons dxf_code (cadr (assoc title setup_lst))) (assoc dxf_code ed) ed)))

(defun setup_bit_mask  ()
  (setq mask_bleftjoin 1
        mask_bupsidedown 2
        mask_contourclosed 4
        mask_contouropend 8
        mask_montaz 16
        mask_usilenie_top 32
        mask_usilenie_bot 64
        mask_plavnpereh_top 128
        mask_plavnpereh_bot 256
        mask_disllinear 512
        mask_dislshahm 1024
        mask_katet 2048)
  (setq tgl_list  '("tgl_ob_side"         "tgl_katet"           "tgl_linear"          "tgl_shahm"
                    "tgl_close_contur"    "tgl_open_contur"     "tgl_usilenie_top"    "tgl_plavn_top"
                    "tgl_montaz"          "tgl_usilenie_bot"    "tgl_plavn_bot")
        mask_list (list mask_bupsidedown        mask_katet              mask_disllinear         mask_dislshahm
                        mask_contourclosed      mask_contouropend       mask_usilenie_top       mask_plavnpereh_top
                        mask_montaz             mask_usilenie_bot       mask_plavnpereh_bot)))

(defun bit_string  (title bit_mask)
  (list title
        (cond ((/= 0 (logand bits bit_mask)) "1")
              (t "0"))))

(defun setup_tgl  (/ bits)
  (setq bits (cdr (assoc 91 ed)))
  (setq setup_lst (subst_dxf (mapcar (function bit_string) tgl_list mask_list) setup_lst))
  (if (/= 0 (logand bits mask_bleftjoin))
    (setq setup_lst (subst_dxf '(("rb_prisoed_left" "1") ("rb_prisoed_right" "0")) setup_lst))
    (setq setup_lst (subst_dxf '(("rb_prisoed_left" "0") ("rb_prisoed_right" "1")) setup_lst))))

(defun text_list_apply  ()
  (mapcar (function text_apply)
          '("top_text" "bot_text" "str_katet" "str_provar" "str_provar_neprovar")
          '(300 301 302 303 304)))

(defun tgl_list_apply  (/ rez)
  (setq rez (apply (function +) (mapcar (function tgl_apply) tgl_list mask_list))
        rez (+ rez (atoi (cadr (assoc "rb_prisoed_left" setup_lst))))
        ed  (subst (cons 91 rez) (assoc 91 ed) ed)))

(defun tgl_apply  (title mask)
  (cond ((= "1" (cadr (assoc title setup_lst))) mask)
        (t 0)))

;;;"dim_style"


(defun weld_pp_list_elem  (title code / title_data code_val)
  (setq title_data (assoc title setup_lst)
        code_val   (itoa (cdr (assoc code ed))))
  (list title code_val (caddr title_data)))

(defun setup_weld_pp_list  ()
  (setq setup_lst (subst_dxf (mapcar (function weld_pp_list_elem) weld_pp_list_str weld_pp_list_code) setup_lst)))

(defun weld_pp_list_elem_apply  (title code / title_lst)
  (setq title_lst (assoc title setup_lst)
        ed        (subst (cons code (atoi (cadr title_lst))) (assoc code ed) ed)))



(defun weld_pp_list_apply  ()
  (mapcar (function weld_pp_list_elem_apply) weld_pp_list_str weld_pp_list_code))

(defun action_tgl_close_contur  ()
  (if (= (get_tile "tgl_close_contur") "1")
    (set_tile "tgl_open_contur" "0"))
  (save_setup_list))

(defun action_tgl_open_contur  ()
  (if (= (get_tile "tgl_open_contur") "1")
    (set_tile "tgl_close_contur" "0"))
  (save_setup_list))

(defun action_tgl_usilenie_top  ()
  (if (= (get_tile "tgl_usilenie_top") "1")
    (set_tile "tgl_plavn_top" "0"))
  (save_setup_list))

(defun action_tgl_plavn_top  ()
  (if (= (get_tile "tgl_plavn_top") "1")
    (set_tile "tgl_usilenie_top" "0"))
  (save_setup_list))


(defun action_tgl_usilenie_bot  ()
  (if (= (get_tile "tgl_usilenie_bot") "1")
    (set_tile "tgl_plavn_bot" "0"))
  (save_setup_list))


(defun action_tgl_plavn_bot  ()
  (if (= (get_tile "tgl_plavn_bot") "1")
    (set_tile "tgl_usilenie_bot" "0"))
  (save_setup_list))

(defun action_tgl_linear  ()
  (if (= (get_tile "tgl_linear") "1")
    (set_tile "tgl_shahm" "0"))
  (tile_modes_set)
  (save_setup_list))

(defun tile_modes_set  ()
  (if (and (= (get_tile "tgl_linear") "0") (= (get_tile "tgl_shahm") "0"))
    (progn (mode_tile "str_provar" 1) (mode_tile "str_provar_neprovar" 1))
    (progn (mode_tile "str_provar" 0) (mode_tile "str_provar_neprovar" 0)))
  (if (= (get_tile "tgl_katet") "0")
    (mode_tile "str_katet" 1)
    (mode_tile "str_katet" 0)))

(defun action_tgl_shahm  ()
  (if (= (get_tile "tgl_shahm") "1")
    (set_tile "tgl_linear" "0"))
  (tile_modes_set)
  (save_setup_list))

(defun action_tgl_katet () (tile_modes_set) (save_setup_list))

(defun action_text_home () (setq ed (subst_dxf '((14 0.0 1.0 0.0) (15 0.0 1.0 0.0)) ed)))


(defun save_setup_list  ()
  (setq setup_lst (mapcar (function (lambda (el)
                                      (cond ((= 2 (length el)) (list (car el) (get_tile (car el))))
                                            ((= 3 (length el)) (list (car el) (get_tile (car el)) (caddr el))))))
                          setup_lst)))

(defun text_top_bot_apply  (/ new_text_bot new_text_top)
  (setq new_text_top (strcat (get_tile_list tile_wedl_standard)
                             "-"
                             (get_tile_list tile_weld_type)
                             "-"
                             (get_tile_list tile_weld_sposob))
        new_text_bot (strcat (get_tile_list tile_weld_kategory) "-" (get_tile_list tile_weld_kontrol_group)))
  (if (get_tile_test "tgl_katet")
    (setq new_text_top (strcat new_text_top "-&p" (get_tile_str "str_katet"))))
  (if (get_tile_test "tgl_linear")
    (setq new_text_top (strcat new_text_top "-" (get_tile_str "str_provar") "/" (get_tile_str "str_provar_neprovar"))))
  (if (get_tile_test "tgl_shahm")
    (setq new_text_top (strcat new_text_top "-" (get_tile_str "str_provar") "Z" (get_tile_str "str_provar_neprovar"))))
  (cond ((get_tile_test "tgl_ob_side")
         (if (get_tile_test "tgl_usilenie_top")
           (setq new_text_top (strcat new_text_top " &r")))
         (if (get_tile_test "tgl_plavn_top")
           (setq new_text_top (strcat new_text_top " &t")))
         (if (get_tile_test "tgl_usilenie_bot")
           (setq new_text_bot (strcat new_text_bot " &q")))
         (if (get_tile_test "tgl_plavn_bot")
           (setq new_text_bot (strcat new_text_bot " &s"))))
        (t
         (if (get_tile_test "tgl_open_contur")
           (setq new_text_top (strcat new_text_top " &u")))
         (if (get_tile_test "tgl_usilenie_top")
           (setq new_text_top (strcat new_text_top " &q")))
         (if (get_tile_test "tgl_plavn_top")
           (setq new_text_top (strcat new_text_top " &s")))
         (if (get_tile_test "tgl_usilenie_bot")
           (setq new_text_bot (strcat new_text_bot " &r")))
         (if (get_tile_test "tgl_plavn_bot")
           (setq new_text_bot (strcat new_text_bot " &t")))))
  (setq setup_lst (subst_dxf (list (list "top_text" new_text_top) (list "bot_text" new_text_bot)) setup_lst)))



(defun get_tile_list  (key / key_tile)
  (setq key_tile (assoc key setup_lst))
  (nth (atoi (cadr key_tile)) (caddr key_tile)))

(defun get_tile_str (key) (cadr (assoc key setup_lst)))

(defun get_tile_test  (key)
  (cond ((= "1" (cadr (assoc key setup_lst))) t)
        (t nil)))

(defun mid_point_apply  ()
  (setq p0    (cdr (assoc 10 ed))
        p1    (if (get_tile_test "rb_prisoed_left")
                (cdr (assoc 12 ed))
                (cdr (assoc 13 ed)))
        p_mid (mapcar (function (lambda (el) (* 0.5 el))) (mapcar (function +) p0 p1))
        ed    (subst_dxf (list (cons 11 p_mid)) ed)))

(defun action_wedl_standard  (/ wt_str)
  (setq wt_str (w_type_string))
  ;; ���������� ������, ������� ����.
  (setq setup_lst (subst_dxf (list (list tile_wedl_standard wst (caddr (assoc tile_wedl_standard setup_lst)))
                                        ;	 (list tile_weld_type "0" (eval (read (strcat "weld_type_" wst))))
                                   (w_type_nomber-by-string wt_str wst))
                             setup_lst)))
;;;���������� ������ � ����� �������� ����������.
;;;setup_lst - ���������� ���������� ���������� ������ ��������� �������.
(defun w_type_string  (/ w_tyle_lst w_type w_type_no)
  (setq w_type     (assoc tile_weld_type setup_lst)
        w_type_no  (read (cadr w_type))
        w_tyle_lst (caddr w_type))
  (nth w_type_no w_tyle_lst))

;;;wst - ���������� ����������, ���������� ������ "0" "1" "2" � �.�.
(defun w_type_nomber-by-string  (str wst / len_curr len_full no_curr w_tyle_lst)
  (setq w_tyle_lst (eval (read (strcat "weld_type_" wst)))
        len_curr   (length (member str w_tyle_lst))
        len_full   (length w_tyle_lst)
        no_curr    (- len_full len_curr))
  (list tile_weld_type (itoa no_curr) (eval (read (strcat "weld_type_" wst)))))

(defun get_data  (ed)
  ;; ����� �� ������ ��������� ������ ����� ���������� ����� � �������� �� ���������
  ;; � ������������ ������� ��� ����������� ������� �� ����� "dim_style".
  (setq ;; ������� �� �������� ������� ���� ���� ��������� ������.
        dim_stl_lst (search_table "DIMSTYLE")
        ;; ������� �� ������ ��������� �������� ��� ����� ���������� ����� � �������� �� ���������.
        dim_stl     (cdr (assoc 2 (entget (cdr (assoc 340 ed)))))
        ;; ����������� ������ ���������� ����� ��������� ������ � ������ ���� ���� ��������� ������,
        ;; ��������� � ������� �������.
        dim_stl_n   (- (length dim_stl_lst) (length (member dim_stl dim_stl_lst)))
        ;; ������������ ������, ����������� � ���������� ����� ���������, ��� ����������� �������.
        setup_lst   (subst (list "dim_style" (rtos dim_stl_n) dim_stl_lst) (assoc "dim_style" setup_lst) setup_lst))
  ;; ������� �� ������ ��������� ������ ���������� � ������������ ������������ ����� ������� �
  ;; ������������ ������ ��� ����������� ������� �� ������ "rb_clock" "rb_unclock".
  (if (< (cdr (assoc 40 ed)) 0)
    (setq setup_lst (subst_dxf (list (list "rb_clock" "1") (list "rb_unclock" "0")) setup_lst))
    (setq setup_lst (subst_dxf (list (list "rb_clock" "0") (list "rb_unclock" "1")) setup_lst)))
  ;; ������� �� ������ ��������� ������ ���������� � ��������� ���������� �
  ;; ������������ ������, ������������ ��� ����������� �������.
  (mapcar (function text_setup)
          '("top_text" "bot_text" "str_katet" "str_provar" "str_provar_neprovar")
          '(300 301 302 303 304))
  ;; ������� �� ������ ��������� ������ ���������� � ��������, ����, ������� ������,
  ;; ��������� � ��������� �������� ��� �
  ;; ������������ ������ ��� ����������� �������.
  (setup_weld_pp_list)
  ;; ������� �� ������ ��������� ������ ���������� � ������� ����� �
  ;; ������������ ������ ��� ����������� �������.
  (setup_tgl))


;; ����� �������� ���.
(defun select  (/ en)
  (setq en (car (entsel "\n�������� ������� ���:"))
        ed (entget en))
  (check_type))

(defun check_type  ()
  (if (/= (cdr (assoc 0 ed)) "MNASWelding")
    (progn (alert "��������� ���� ������ �� ������������� ���� MNASWelding.") (exit))))
