(vl-arx-import 'acad_colordlg)

(defun c:pozition_set_text_scale  (/ reg_root setup_lst reg_val text_scale line-offset ed text)
  (select)
  (setq setup_lst '(("text" "1" ("edit_box"))
                    ("text-scale" "1.41421" ("edit_box")) ; 40
                    ("line-offset" "1" ("edit_box")) ; 41
                    ("text_color_image" "3" ("image_button")) ; 70
                    )
        reg_root  "HKEY_CURRENT_USER\\Software\\MNASoft\\MNAS\\Pozition"
        reg_val   (mapcar (function (lambda (el) (cons el (list (eval el))))) (list 'setup_lst)))
  (reg_read_default_lst reg_root reg_val)
  (setq text             (cadr (assoc "text" setup_lst))
        text_scale       (read (cadr (assoc "text-scale" setup_lst)))
        line-offset      (read (cadr (assoc "line-offset" setup_lst)))
        text_color_image (read (cadr (assoc "text_color_image" setup_lst))))
  (setq ed (subst (cons 1 text) (assoc 1 ed) ed)
        ed (subst (cons 40 text_scale) (assoc 40 ed) ed)
        ed (subst (cons 41 line-offset) (assoc 41 ed) ed)
        ed (subst (cons 70 text_color_image) (assoc 70 ed) ed))
  (entmod ed))


;;;;;;("edpos"
;;;;;;"
;;;;;;������ ��� �������������� �������. ������ MNASPozition.\n
;;;;;;   Select  - ����� ������� ��� ��������������;\n
;;;;;;   Apply   - ���������� ��� ������� ������������ ������� ���������, ����������� � �������;\n
;;;;;;   M_ApplY - ��������� ��������� �������� ������� ������� � ��������� ��������;\n
;;;;;;   On      - �������� ������� ���� ������� ��� ��������, ����������� �� M_Apply;\n
;;;;;;   Off     - ��������� ������� ���� ������� ��� ��������, ����������� �� M_Apply.
;;;;;; ���������� M_Apply ����� ����� Off �� ���������� ������� ������� ���������.\n
;;;;;;   Default - ���������� ���� ������, ������� ������, ��������� ������,
;;;;;; ��������� ��� ���������� �������� M_Aplly � �������� �� ���������.
;;;;;;" "�������")
(defun c:edpos  (/                      ;
                 en                     ; ���, ������������� �������
                 ed                     ; DXF ������, ������������� �������
                 action                 ; ��������, ������������ ��� �������� �������
                 arrow_type_lst         ; ������ ����� �������
                 arrow_type_n           ; �������� ���� �������
                 arrow_type_tile        ; tile ���� �������
                 dcl_id                 ; ���������� �������
                 dia_pos_pos            ; ��������� ���������� ��������� �������
                 dim_stl                ; ��� ���������� ����� � �������� ����������� �������
                 dim_stl_lst            ; ������ ��������� ������ �������
                 dim_stl_n              ; ����� ���������� ����� ������� ������� � ������ ������ ��������
                 do_dialog              ; ������� ����, ��� ������ ����� ����������� ����� ��������� �������
                 reg_root               ; ����� � ��������� �������, ��� ����� ����������� ��������� �������
                 reg_val                ; ��������� �������
                 setup_lst              ; ������, ����������� ������� ���������� �������
                 text-scale_n           ; ������� ������ ������ (������������ ������ ������ ���������� �����)
                 text-scale_tile        ; ������� ������ ������ � tile
                 text_color_n           ; ������ ����� ������ �������
                 text_n                 ; �����, ������������� �������
                 text_tile              ; tile ������ �������
                 )
  (setq setup_lst   '(("text_toggle" "0" ("toggle"))
                      ("text" "1" ("edit_box"))
                      ("arrow_type_toggle" "1" ("toggle"))
                      ("arrow_type" "0" ("Nothing" "Dot" "Arrow") ("popup_list"))
                      ("dim_style_toggle" "1" ("toggle"))
                      ("dim_style" "0" ("1" "2" "3") ("popup_list" "(ac_dim_style_post)"))
                      ("text_color_toggle" "1" ("toggle"))
                      ("text_color_image" "3" ("image_button"))
                      ("text-scale_toggle" "1" ("toggle"))
                      ("text-scale" "1.4" ("edit_box"))
                      ("text-size" "" ("edit_box"))
                      ("line-offset_toggle" "1" ("toggle"))
                      ("line-offset" "1" ("edit_box"))
                      ("error" "" ()))
        dia_pos_pos '(-1 -1)
        reg_root    "HKEY_CURRENT_USER\\Software\\MNASoft\\MNAS\\Pozition"
        reg_val     (mapcar (function (lambda (el) (cons el (list (eval el))))) (list 'setup_lst 'dia_pos_pos)))
  (reg_read_default_lst reg_root reg_val)
  (select)
  (select-init)
  (setq dcl_id (load_dialog "./src/lsp/MNAS/pozition/pozition.dcl"))
  (setq do_dialog t)
  (while do_dialog
    (if (not (new_dialog "mnas_pos_main" dcl_id "" dia_pos_pos))
      (exit))
    (init_dlg_key setup_lst)
    (action-tile_dlg "setup_lst" "setup_lst" "" "")
    (action_tile "accept" "(ac_accept)")
    (action_tile "apply_btn" "(ac_apply_btn)")
    (action_tile "select" "(setq dia_pos_pos (done_dialog 3))")
    (action_tile "match_apply" "(setq dia_pos_pos (done_dialog 4))")
    (action_tile "text_color_image" "(ac_text_color_image $key &x &y)")
    (action_tile "text_color" "(setq dia_pos_pos (done_dialog 5))")
    (action_tile "match_all_on" "(setq dia_pos_pos (done_dialog 6))")
    (action_tile "match_all_off" "(setq dia_pos_pos (done_dialog 7))")
    (action_tile "about" "(about)")
    (action_tile "default_settings" "(default_settings)")
    (action_tile "text_scale_+" "(ac_text_scale_+)")
    (action_tile "text_scale_-" "(ac_text_scale_-)")
    (action_tile "text-size" "(ac_text-size)")
    text-size
    (setq action (start_dialog))
    (cond
      ((= action 7)                     ; "match_all_off"
       (mapcar (function
                 (lambda (el)
                   (setq setup_lst (subst (list el "0" (last (assoc el setup_lst))) (assoc el setup_lst) setup_lst))))
               '("text_toggle"              "arrow_type_toggle"        "dim_style_toggle"
                 "text_color_toggle"        "text-scale_toggle"        "line-offset_toggle")))
      ((= action 6)                     ; "match_all_on"
       (mapcar (function
                 (lambda (el)
                   (setq setup_lst (subst (list el "1" (last (assoc el setup_lst))) (assoc el setup_lst) setup_lst))))
               '("text_toggle"              "arrow_type_toggle"        "dim_style_toggle"
                 "text_color_toggle"        "text-scale_toggle"        "line-offset_toggle")))
      ((= action 5)                     ;"text_color_image" "text_color"
       (setq text_color_n (acad_colordlg (atoi (cadr (assoc "text_color_image" setup_lst))))
             setup_lst    (subst (list "text_color_image" (itoa text_color_n) (last (assoc "text_color_image" setup_lst)))
                                 (assoc "text_color_image" setup_lst)
                                 setup_lst)
                          ;;	 ed	      (subst (cons 70 text_color_n) (assoc 70 ed) ed)
             ))
      ((= action 4)                     ;"match_apply"
       (ac_match_apply))
      ((= action 3)                     ;"select"
       (select)
       (select-init))
      ((= action 2)                     ;"apply_btn"
       (ac_apply_do))
      ((= action 1)                     ;"accept"
       (ac_apply_do)
       (setq do_dialog nil))
      ((= action 0) (setq do_dialog nil))
      (setq do_dialog nil)))
  (unload_dialog dcl_id))

(defun ac_accept  ()
  (setq dia_pos_pos (done_dialog 1))
  (setq reg_val (mapcar (function (lambda (el) (cons el (list (eval el))))) (list 'setup_lst 'dia_pos_pos)))
  (reg_write_default_lst reg_root reg_val))


(defun ac_apply_btn () (setq dia_pos_pos (done_dialog 2)))

;;;��������� � ������� ������������� ������� ���������, ����������� � �������
(defun ac_apply_do  ()
  (setq dim_stl_tile (assoc "dim_style" setup_lst)
        dim_stl      (nth (atoi (cadr dim_stl_tile)) (caddr dim_stl_tile))
        ed           (subst (cons 340 (tblobjname "dimstyle" dim_stl)) (assoc 340 ed) ed)
        ed           (subst (cons 91 (atoi (cadr (assoc "arrow_type" setup_lst)))) (assoc 91 ed) ed)
        ed           (subst (cons 1 (cadr (assoc "text" setup_lst))) (assoc 1 ed) ed)
        ed           (subst (cons 40 (atof (cadr (assoc "text-scale" setup_lst)))) (assoc 40 ed) ed)
        ed           (subst (cons 41 (atof (cadr (assoc "line-offset" setup_lst)))) (assoc 41 ed) ed)
        ed           (subst (cons 70 (atoi (cadr (assoc "text_color_image" setup_lst)))) (assoc 70 ed) ed))
  (entmod ed)
  (command "_redraw"))

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
             (progn (setq match_prop_ed (subst
;;;		     (assoc 1 ed)
                                               (cons 1 (cadr (assoc "text" setup_lst)))
                                               (assoc 1 match_prop_ed)
                                               match_prop_ed))))
           (if (= "1" (cadr (assoc "arrow_type_toggle" setup_lst)))
             (progn (setq match_prop_ed (subst
;;;		     (assoc 91 ed)
                                               (cons 91 (atoi (cadr (assoc "arrow_type" setup_lst))))
                                               (assoc 91 match_prop_ed)
                                               match_prop_ed))))
           (if (= "1" (cadr (assoc "dim_style_toggle" setup_lst)))
             (progn (setq dim_stl_tile  (assoc "dim_style" setup_lst)
                          dim_stl       (nth (atoi (cadr dim_stl_tile)) (caddr dim_stl_tile))
                          match_prop_ed (subst
;;;		              (assoc 340 ed)
                                               (cons 340 (tblobjname "dimstyle" dim_stl))
                                               (assoc 340 match_prop_ed)
                                               match_prop_ed))))
           (if (= "1" (cadr (assoc "text-scale_toggle" setup_lst)))
             (progn (setq match_prop_ed (subst
;;;		     (assoc 40 ed)
                                               (cons 40 (atof (cadr (assoc "text-scale" setup_lst))))
                                               (assoc 40 match_prop_ed)
                                               match_prop_ed))))
           (if (= "1" (cadr (assoc "line-offset_toggle" setup_lst)))
             (progn (setq match_prop_ed (subst
;;;		     (assoc 41 ed)
                                               (cons 41 (atof (cadr (assoc "line-offset" setup_lst))))
                                               (assoc 41 match_prop_ed)
                                               match_prop_ed))))
           (if (= "1" (cadr (assoc "text_color_toggle" setup_lst)))
             (progn (setq match_prop_ed (subst
;;;		     (assoc 70 ed)
                                               (cons 70 (atoi (cadr (assoc "text_color_image" setup_lst))))
                                               (assoc 70 match_prop_ed)
                                               match_prop_ed))))
           (entmod match_prop_ed)))
    (setq i (1+ i)))
  (command "_redraw"))

(defun ac_text_color_image (key x y) (done_dialog 5))

(defun about () (alert (strcat "�������������� �������" (about-gpl-string))))


;; ����� �������.
(defun select  (/ en)
  (setq en (car (entsel "\n�������� �������:"))
        ed (entget en))
  (check_type))

(defun check_type  ()
  (if (/= (cdr (assoc 0 ed)) "MNASPozition")
    (progn (alert "��������� ���� ������ �� ������������� ���� MNASPozition.") (exit))))


(defun init_dlg_key  (lst_setup / key)
  (mapcar (function
            (lambda (el)
              (setq key (car (last el)))
              (cond ((is_equal_one_in_list key '("toggle" "edit_box")) (set_tile (car el) (cadr el)))
                    ((is_equal_one_in_list key '("list" "popup_list"))
                     (start_list (car el))
                     (mapcar (function add_list) (caddr el))
                     (end_list)
                     (set_tile (car el) (cadr el)))
                    ((is_equal_one_in_list key '("image_button"))
                     (start_image (car el))
                     (fill_image 0 0 (dimx_tile (car el)) (dimy_tile (car el)) (atoi (cadr el)))
                     (end_image)))))
          lst_setup))

(defun is_equal_one_in_list  (val list_val / rez)
  (mapcar (function (lambda (el) (setq rez (or rez (= el val))))) list_val)
  rez)

(defun action-save_dlg_key  (setup_lst / key)
  (setq setup_lst (mapcar (function (lambda (el)
                                      (setq key (car (last el)))
                                      (cond ((is_equal_one_in_list key '("toggle" "edit_box"))
                                             (list (car el) (get_tile (car el)) (last el)))
                                            ((is_equal_one_in_list key '("list" "popup_list"))
                                             (list (car el) (get_tile (car el)) (caddr el) (last el)))
                                            (t el))))
                          setup_lst))
  (mapcar (function (lambda (el / el_last el_post_pros)
                      (setq el_last      (last el)
                            el_post_pros (cadr el_last))
                      (if el_post_pros
                        (eval (read el_post_pros)))))
          setup_lst)
  setup_lst)

(defun default_settings  ()
  (setq setup_lst (subst (list "text-scale" (rtos (sqrt 2.0)) (list "edit_box"))
                         (assoc "text-scale" setup_lst)
                         setup_lst)
        setup_lst (subst '("line-offset" "1" ("edit_box")) (assoc "line-offset" setup_lst) setup_lst))
  (set_tile "text-scale" (rtos (sqrt 2.0)))
  (set_tile "line-offset" "1")
  (dim_text_scale_to_text_size)
  (set_tile "text-size" (cadr (assoc "text-size" setup_lst))))

(defun select-init  ()
  ;; ������������� "dim_style" ������.
  (setq dim_stl_lst (search_table "DIMSTYLE")
        dim_stl     (cdr (assoc 2 (entget (cdr (assoc 340 ed)))))
        dim_stl_n   (- (length dim_stl_lst) (length (member dim_stl dim_stl_lst)))
        setup_lst   (subst (list "dim_style" (rtos dim_stl_n) dim_stl_lst (last (assoc "dim_style" setup_lst)))
                           (assoc "dim_style" setup_lst)
                           setup_lst))
  ;; ������������� "dim_style" �����.
  ;; ������������� "arrow_type" �����.
  (setq arrow_type_tile (assoc "arrow_type" setup_lst)
        arrow_type_lst  (caddr arrow_type_tile)
        arrow_type_n    (cdr (assoc 91 ed))
        setup_lst       (subst (list "arrow_type" (rtos arrow_type_n) arrow_type_lst (last (assoc "arrow_type" setup_lst)))
                               arrow_type_tile
                               setup_lst))
  ;; ������������� "arrow_type" �����.
  ;; ������������� "text-scale" �����.
  (setq text-scale_tile (assoc "text-scale" setup_lst)
        text-scale_n    (cdr (assoc 40 ed))
        setup_lst       (subst (list "text-scale" (rtos text-scale_n) (last (assoc "text-scale" setup_lst)))
                               text-scale_tile
                               setup_lst))
  ;; ������������� "text-scale" �����.
  ;; ������������� "text" ������.
  (setq text_tile (assoc "text" setup_lst)
        text_n    (cdr (assoc 1 ed))
        setup_lst (subst (list "text" text_n (last (assoc "text" setup_lst))) text_tile setup_lst))
  ;; ������������� "text" �����.
  ;; ������������� "text_color_image" ������.
  (setq text_color_image_tile (assoc "text_color_image" setup_lst)
        text_color_image_n    (cdr (assoc 70 ed))
        setup_lst             (subst (list "text_color_image" (itoa text_color_image_n) (last (assoc "text_color_image" setup_lst)))
                                     text_color_image_tile
                                     setup_lst))
  ;; ������������� "text_color_image" �����.
  ;; ������������� "line-offset" �����.
  (setq line-offset_tile (assoc "line-offset" setup_lst)
        line-offset_n    (cdr (assoc 41 ed))
        setup_lst        (subst (list "line-offset" (rtos line-offset_n) (last (assoc "line-offset" setup_lst)))
                                line-offset_tile
                                setup_lst))
  ;; ������������� "line-offset" �����.
  (dim_text_scale_to_text_size))

(defun dim_text_scale_to_text_size  (/ dim dim_ed dim_scale dim_scale_text dim_text_size text-scale text-size)
  (setq dim            (assoc "dim_style" setup_lst)
        dim_ed         (entget (tblobjname "dimstyle" (nth (atoi (cadr dim)) (caddr dim))))
        dim_text_size  (cdr (assoc 41 dim_ed))
        dim_scale      (cond ((cdr (assoc 40 dim_ed)))
                             (t 1.0))
        dim_scale_text (* dim_text_size dim_scale)
        text-scale     (atof (cadr (assoc "text-scale" setup_lst)))
        text-size      (rtos (* dim_scale_text text-scale))
        setup_lst      (subst (list "text-size" text-size (last (assoc "text-size" setup_lst)))
                              (assoc "text-size" setup_lst)
                              setup_lst)))

(defun ac_text_scale_+  ()
  (set_tile "text-scale" (rtos (* (atof (get_tile "text-scale")) (sqrt 2.0))))
  (setq setup_lst (subst (list "text-scale" (get_tile "text-scale") (list "edit_box"))
                         (assoc "text-scale" setup_lst)
                         setup_lst))
  (dim_text_scale_to_text_size)
  (set_tile "text-size" (cadr (assoc "text-size" setup_lst))))


(defun ac_text_scale_-  ()
  (set_tile "text-scale" (rtos (/ (atof (get_tile "text-scale")) (sqrt 2.0))))
  (setq setup_lst (subst (list "text-scale" (get_tile "text-scale") (list "edit_box"))
                         (assoc "text-scale" setup_lst)
                         setup_lst))
  (dim_text_scale_to_text_size)
  (set_tile "text-size" (cadr (assoc "text-size" setup_lst))))

(defun ac_text-size  ()
  (setq text-size (atof (get_tile "text-size")))
  (if (= 0.0 text-size)
    (progn (setq text-size 1.0) (set_tile "text-size" "1.0")))
  (setq dim            (assoc "dim_style" setup_lst)
        dim_ed         (entget (tblobjname "dimstyle" (nth (atoi (cadr dim)) (caddr dim))))
        dim_text_size  (cdr (assoc 41 dim_ed))
        dim_scale      (cond ((cdr (assoc 40 dim_ed)))
                             (t 1.0))
        dim_scale_text (* dim_text_size dim_scale)
        text-scale     (rtos (/ text-size dim_scale_text))
        setup_lst      (subst (list "text-scale" text-scale (last (assoc "text-scale" setup_lst)))
                              (assoc "text-scale" setup_lst)
                              setup_lst))
  (set_tile "text-scale" text-scale))

(defun ac_dim_style_post  ()
  (dim_text_scale_to_text_size)
  (set_tile "text-size" (cadr (assoc "text-size" setup_lst))))
