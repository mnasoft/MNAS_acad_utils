;; Производит выборку из набора элементов ss1 имен слоев и возвращает строку,
;; содержащую имена слоев разделенную запятыми.
(defun layer_list  (ss1 / en1 la1 str1 lli1)
  (while (setq en1 (ssname ss1 0))
    (setq la1 (cdr (assoc 8 (entget en1))))
    (if (not (assoc la1 lli1))
      (progn (setq lli1 (cons (list la1) lli1))
             (setq str1 (if str1
                          (strcat str1 la1 ",")
                          (strcat la1 ",")))))
    (setq ss1 (ssdel en1 ss1)))
  (substr str1 1 (1- (strlen str1))))
;; Производит выборку из набора элементов ss1 имен слоев и возвращает строку,
;; содержащую имена слоев разделенную запятыми, слой с именем cl из строки исключается.
(defun layer_cl  (ss1 cl / en1 la1 str1 lli1)
  (while (setq en1 (ssname ss1 0))
    (setq la1 (cdr (assoc 8 (entget en1))))
    (if (and (not (assoc la1 lli1)) (/= la1 cl))
      (progn (setq lli1 (cons (list la1) lli1))
             (setq str1 (if str1
                          (strcat str1 la1 ",")
                          (strcat la1 ",")))))
    (setq ss1 (ssdel en1 ss1)))
  (if str1
    (substr str1 1 (1- (strlen str1)))
    str1))

;;;;;;("lay" "Команда управления слоями\n
;;;;;; В зависимости от опций позволяет:\n
;;;;;; 1)  Set - устанавливать текущий слой;\n
;;;;;; 2)  OFF - выключать отмеченные слои слои,\n
;;;;;; 3)  WO	 - выключать все слои за исключением отмеченных;\n
;;;;;; 4)  FR	 - замораживать отмеченные слои;\n
;;;;;; 5)  WFr - замораживать все слои за исключением отмеченных;\n
;;;;;; 6)  LO	 - блокировать отмеченные слои;\n
;;;;;; 7)  WL  - блокировать все слои за исключением отмеченных;\n
;;;;;; 8)  Un	 - разблокировать отмеченные слои;\n
;;;;;; 9)  Col	 - задавать цвет для отмеченных слоев;\n
;;;;;; 10) AO  - включать все слои;\n
;;;;;; 11) AT	 - размораживать все слои;\n
;;;;;; 12) AU	 - разблокировать все слои;\n
;;;;;; 13) Exit - выходить из команды управления слоями." "Слои")
(defun c:lay  (/ str cmdstr ask la_l la lastcmd name col cl)
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (setq cmdstr "Set OFF WO FR WFr LO WL Un Col AO AT AU Exit")
  (setq str "Set")
  (setq lastcmd str)
  (while (/= str "Exit")
    (setq ask (strcat "\n" cmdstr " < " str " > :"))
    (initget cmdstr)
    (setq str (getkword ask))
    (if (/= str nil)
      (setq lastcmd str)
      (setq str lastcmd))
    (cond ((= str "Set")
           (setq la_l (ssget))
           (if la_l
             (progn (setq la (cdr (assoc 8 (entget (ssname la_l 0))))) (command "_.layer" "_set" la ""))))
          ((= str "Un")
           (setq la_l (ssget))
           (if la_l
             (command "_.layer" "_Unlock" (layer_list la_l) "")))
          ((= str "LO")
           (setq la_l (ssget))
           (if la_l
             (command "_.layer" "_lock" (layer_list la_l) "")))
          ((= str "OFF")
           (setq la_l (ssget))
           (if la_l
             (if (setq la (layer_cl la_l (getvar "clayer")))
               (command "_.layer" "_OFF" la ""))))
          ((= str "Col")
           (setq la_l (ssget))
           (setq col (getstring "\nEnter color : "))
           (if (and (/= col nil) la_l)
             (command "_.layer" "_Color" col (layer_list la_l) "")))
          ((= str "WL")
           (setq la_l (ssget))
           (if la_l
             (command "_.layer"
                      "_Set"
                      (cdr (assoc 8 (entget (ssname la_l 0))))
                      "_lock"
                      "~"
                      "_unlock"
                      (layer_list la_l)
                      "")))
          ((= str "WO")
           (setq la_l (ssget))
           (if la_l
             (command "_.layer"
                      "_Set"
                      (cdr (assoc 8 (entget (ssname la_l 0))))
                      "_Off"
                      "~"
                      ""
                      "_on"
                      (layer_list la_l)
                      "")))
          ((= str "WFr")
           (setq la_l (ssget))
           (if la_l
             (command "_.layer"
                      "_Set"
                      (cdr (assoc 8 (entget (ssname la_l 0))))
                      "_freeze"
                      "~"
                      "_thaw"
                      (layer_list la_l)
                      "")))
          ((= str "FR")
           (setq la_l (ssget))
           (if la_l
             (if (setq la (layer_cl la_l (getvar "clayer")))
               (command "_.layer" "_freeze" la ""))))
          ((= str "AO") (command "_.layer" "_on" "~" ""))
          ((= str "AU") (command "_.layer" "_unlock" "~" ""))
          ((= str "AT") (command "_.layer" "_Thaw" "~" ""))))
  (err-handle ""))


;; (выборка_слоев)
;; (((0 . "LAYER") (2 . "0") (70 . 0) (62 . 1) (6 . "Continuous")) ((0 . "LAYER") (2 . "Layer1") (70 . 0) (62 . 2) (6 . "Continuous")) ((0 . "LAYER") (2 . "Layer2") (70 . 0) (62 . 3) (6 . "Continuous")) ((0 . "LAYER") (2 . "Layer3") (70 . 0) (62 . 4) (6 . "Continuous")) ((0 . "LAYER") (2 . "Layer4") (70 . 0) (62 . 6) (6 . "Continuous")) ((0 . "LAYER") (2 . "Layer5") (70 . 0) (62 . 1) (6 . "Continuous")) ((0 . "LAYER") (2 . "Layer1_d") (70 . 0) (62 . -7) (6 . "Continuous")))
(defun выборка_слоев  (/ ln l1)
  (setq ln (append ln (list (tblnext "LAYER" t))))
  (while (setq l1 (tblnext "LAYER")) (setq ln (append ln (list l1)))))
;; Производит выборку имен слоев из списка, возвращаемого таблицей слоев.
;;(имена_слоев '(((0 . "LAYER") (2 . "0") (70 . 0) (62 . 1) (6 . "Continuous")) ((0 . "LAYER") (2 . "Layer1") (70 . 0) (62 . 2) (6 . "Continuous")) ((0 . "LAYER") (2 . "Layer2") (70 . 0) (62 . 3) (6 . "Continuous")) ((0 . "LAYER") (2 . "Layer3") (70 . 0) (62 . 4) (6 . "Continuous")) ((0 . "LAYER") (2 . "Layer4") (70 . 0) (62 . 6) (6 . "Continuous")) ((0 . "LAYER") (2 . "Layer5") (70 . 0) (62 . 1) (6 . "Continuous")) ((0 . "LAYER") (2 . "Layer1_d") (70 . 0) (62 . -7) (6 . "Continuous"))))
;;("0" "Layer1" "Layer2" "Layer3" "Layer4" "Layer5" "Layer1_d")
(defun имена_слоев (т_слоев) (mapcar (function (lambda (el) (cdr (assoc 2 el)))) т_слоев))
;; Производит выборку из таблицы слоев, удовлетворяющиих шаблону шабл имени слоя.
;|(выборка_слоев_удовл_шабл
  '(((0 . "LAYER") (2 . "0") (70 . 0) (62 . 1) (6 . "Continuous"))
    ((0 . "LAYER") (2 . "Layer1") (70 . 0) (62 . 2) (6 . "Continuous"))
    ((0 . "LAYER") (2 . "Layer2") (70 . 0) (62 . 3) (6 . "Continuous"))
    ((0 . "LAYER") (2 . "Layer3") (70 . 0) (62 . 4) (6 . "Continuous"))
    ((0 . "LAYER") (2 . "Layer4") (70 . 0) (62 . 6) (6 . "Continuous"))
    ((0 . "LAYER") (2 . "Layer5") (70 . 0) (62 . 1) (6 . "Continuous"))
    ((0 . "LAYER") (2 . "Layer1_d") (70 . 0) (62 . -7) (6 . "Continuous"))
   )
  "*_d"
)
(((0 . "LAYER") (2 . "Layer1_d") (70 . 0) (62 . -7) (6 . "Continuous")))
|;
(defun выборка_слоев_удовл_шабл  (т_слоев шабл / таб_сл)
  (mapcar (function (lambda (ln)
                      (if (wcmatch (strcase (cdr (assoc 2 ln))) (strcase шабл))
                        (setq таб_сл (append таб_сл (list ln))))))
          т_слоев)
  таб_сл)

;; Производит выборку из таблицы слоев, не удовлетворяющиих шаблону шабл имени слоя.
;;
;|(выборка_слоев_неудовл_шабл
  '(((0 . "LAYER") (2 . "0") (70 . 0) (62 . 1) (6 . "Continuous"))
    ((0 . "LAYER") (2 . "Layer1") (70 . 0) (62 . 2) (6 . "Continuous"))
    ((0 . "LAYER") (2 . "Layer2") (70 . 0) (62 . 3) (6 . "Continuous"))
    ((0 . "LAYER") (2 . "Layer3") (70 . 0) (62 . 4) (6 . "Continuous"))
    ((0 . "LAYER") (2 . "Layer4") (70 . 0) (62 . 6) (6 . "Continuous"))
    ((0 . "LAYER") (2 . "Layer5") (70 . 0) (62 . 1) (6 . "Continuous"))
    ((0 . "LAYER") (2 . "Layer1_d") (70 . 0) (62 . -7) (6 . "Continuous"))
   )
  "*_d"
)
(((0 . "LAYER") (2 . "0") (70 . 0) (62 . 1) (6 . "Continuous")) ((0 . "LAYER") (2 . "Layer1") (70 . 0) (62 . 2) (6 . "Continuous")) ((0 . "LAYER") (2 . "Layer2") (70 . 0) (62 . 3) (6 . "Continuous")) ((0 . "LAYER") (2 . "Layer3") (70 . 0) (62 . 4) (6 . "Continuous")) ((0 . "LAYER") (2 . "Layer4") (70 . 0) (62 . 6) (6 . "Continuous")) ((0 . "LAYER") (2 . "Layer5") (70 . 0) (62 . 1) (6 . "Continuous")))
|;
(defun выборка_слоев_неудовл_шабл  (т_слоев шабл / таб_сл)
  (mapcar (function (lambda (ln)
                      (if (null (wcmatch (strcase (cdr (assoc 2 ln))) (strcase шабл)))
                        (setq таб_сл (append таб_сл (list ln))))))
          т_слоев)
  таб_сл)
;;(выборка_слоев_по_списку_цветов '(((0 . "LAYER") (2 . "0") (70 . 0) (62 . 1) (6 . "Continuous")) ((0 . "LAYER") (2 . "Layer1") (70 . 0) (62 . 2) (6 . "Continuous")) ((0 . "LAYER") (2 . "Layer2") (70 . 0) (62 . 3) (6 . "Continuous")) ((0 . "LAYER") (2 . "Layer3") (70 . 0) (62 . 4) (6 . "Continuous")) ((0 . "LAYER") (2 . "Layer4") (70 . 0) (62 . 6) (6 . "Continuous")) ((0 . "LAYER") (2 . "Layer5") (70 . 0) (62 . 1) (6 . "Continuous"))) '(2 3 ))
;;(((0 . "LAYER") (2 . "Layer1") (70 . 0) (62 . 2) (6 . "Continuous")) ((0 . "LAYER") (2 . "Layer2") (70 . 0) (62 . 3) (6 . "Continuous")))
(defun выборка_слоев_по_списку_цветов  (т_слоев сп_цвет / таб_сл цв)
  (mapcar (function (lambda (ln)
                      (setq цв (abs (cdr (assoc 62 ln))))
                      (if (apply (function or) (mapcar (function (lambda (el) (= цв el))) сп_цвет))
                        (setq таб_сл (append таб_сл (list ln))))))
          т_слоев)
  таб_сл)

(defun rgb  (сп_изменяемых_цветов схема_раскраски шаблон_исключаемых_имен_слоев начало чередование / тбл_сл им_сл количество_цветов n cmd_echo)
  (setq тбл_сл (выборка_слоев)
        тбл_сл (выборка_слоев_по_списку_цветов тбл_сл сп_изменяемых_цветов)
        тбл_сл (выборка_слоев_неудовл_шабл тбл_сл шаблон_исключаемых_имен_слоев)
        им_сл  (имена_слоев тбл_сл))
  (setq количество_цветов (length схема_раскраски)
        n                 (rem начало количество_цветов)
        cmd_echo          (getvar "cmdecho"))
  (setvar "cmdecho" 0)
  (vl-cmdf "_.layer")
  (mapcar (function (lambda (ln)
                      (vl-cmdf "_c" (itoa (nth n схема_раскраски)) ln)
                      (setq n (rem (+ чередование n) количество_цветов))))
          им_сл)
  (command "")
  (setvar "cmdecho" cmd_echo))

(defun layer_rgb_settings  (/ ex_dialog action dcl_id code_val)
  (setq dcl_id (load_dialog (findfile (utils:path-src-lsp "layer/rgb.dcl"))))
  (if (< dcl_id 0)
    (exit))
  (reg_read_default_lst reg_root rgb_registry) ;  (while (null ex_dialog)
  (if (not (new_dialog "rgb" dcl_id "" dcl_rgb_pos))
    (exit))
  (mapcar (function (lambda (el) (set_tile (car el) (cdr el)))) code_val)
  (action_tile "b_1_1" "(ac_b_1_1)")
  (action_tile "t_1_1" "(ac_t_1_1)")
  (action_tile "rb_1_1" "(ac_rb_1_1)")
  (action_tile "rb_1_2" "(ac_rb_1_2)")
  (action_tile "eb_1_1" "(ac_eb_1_1)")
  (action_tile "eb_1_2" "(ac_eb_1_2)")
  (action_tile "eb_1_3" "(ac_eb_1_3)")
  (action_tile "accept" "(rgb_dlg_accept)")
  (setq action (start_dialog))          ;   (cond
                                        ;     ((= action 0) (setq ex_dialog t))
                                        ;     ((= action 1) (setq ex_dialog t))
                                        ;   )
                                        ; )
  (unload_dialog dcl_id)
  (cond ((= action 0) nil)
        ((= action 1) code_val)))


(defun rgb_dlg_accept  ()
  (setq dcl_rgb_pos (done_dialog 1))
  (reg_write_default_lst reg_root rgb_registry))

(defun ac_b_1_1 () (reg_write_default_lst reg_root rgb_registry))


(defun ac_t_1_1  (/ t_1_1)
  (setq t_1_1    (get_tile "t_1_1")
        code_val (subst (cons "t_1_1" t_1_1) (assoc "t_1_1" code_val) code_val))
  (print code_val))

(defun ac_t_1_1  ()
  (setq code_val (subst (cons "t_1_1" (get_tile "t_1_1")) (assoc "t_1_1" code_val) code_val))
  (print code_val))
(defun ac_rb_1_1  ()
  (setq code_val (subst (cons "rb_1_1" (get_tile "rb_1_1")) (assoc "rb_1_1" code_val) code_val)
        code_val (subst (cons "rb_1_2" (get_tile "rb_1_2")) (assoc "rb_1_2" code_val) code_val))
  (print code_val))
(defun ac_rb_1_2  ()
  (setq code_val (subst (cons "rb_1_1" (get_tile "rb_1_1")) (assoc "rb_1_1" code_val) code_val)
        code_val (subst (cons "rb_1_2" (get_tile "rb_1_2")) (assoc "rb_1_2" code_val) code_val))
  (print code_val))
(defun ac_eb_1_1  ()
  (setq code_val (subst (cons "eb_1_1" (get_tile "eb_1_1")) (assoc "eb_1_1" code_val) code_val))
  (print code_val))
(defun ac_eb_1_2  ()
  (setq code_val (subst (cons "eb_1_2" (get_tile "eb_1_2")) (assoc "eb_1_2" code_val) code_val))
  (print code_val))
(defun ac_eb_1_3  ()
  (setq code_val (subst (cons "eb_1_3" (get_tile "eb_1_3")) (assoc "eb_1_3" code_val) code_val))
  (print code_val))

;;;;;;("rgb" "Команда раскраски слоев." "Слои")
(defun c:rgb  (/ rez i список_изменяемых_цветов t_1_1 схема_раскраски reg_root rgb_registry dcl_rgb_pos)
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (setq reg_root "HKEY_CURRENT_USER\\Software\\MNASoft\\Layer")
  (setq rgb_registry
         '((dcl_rgb_pos (-1 -1))
           (code_val
            (("t_1_1" . "1")
             ("rb_1_1" . "1")
             ("rb_1_2" . "0")
             ("eb_1_1" . "D,*_D,DEFPOINTS,V,H")
             ("eb_1_2" . "0")
             ("eb_1_3" . "1")))))
  (setq rez (layer_rgb_settings))
  (cond ((null rez))
        (t
         (setq t_1_1 (cdr (assoc "t_1_1" rez)))
         (cond ((= t_1_1 "1")
                (setq i 0)
                (repeat 257
                  (setq список_изменяемых_цветов
                         (append список_изменяемых_цветов (list i))
                        i (1+ i))))
               ((= t_1_1 "0") (setq список_изменяемых_цветов (list 7))))
         (setq схема_раскраски
                (cond ((= (cdr (assoc "rb_1_1" rez)) "1") (list 1 2 3 4 6))
                      ((= (cdr (assoc "rb_1_2" rez)) "1") (list 10 30 40 50 60 70 110 130 140 150 160 190 200 210))))
         (rgb список_изменяемых_цветов
              схема_раскраски
              (cdr (assoc "eb_1_1" rez))
              (atoi (cdr (assoc "eb_1_2" rez)))
              (atoi (cdr (assoc "eb_1_3" rez))))))
  (err-handle ""))




;;;;;;("la_dhv" "Добавляет слои \"d\", \"h\", \"v\"." "Настройка")
(defun c:la_dhv  ()
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (if (null (tblsearch "layer" "d"))
    (progn (command "_.-layer" "_new" "d" "") (princ "\nLayer d created.")))
  (if (null (tblsearch "layer" "h"))
    (progn (command "_.-layer" "_new" "h" "") (princ "\nLayer h created.")))
  (if (null (tblsearch "layer" "v"))
    (progn (command "_.-layer" "_new" "v" "")
           (command "_.-layer" "_color" "5" "v" "")
           (command "_.-layer" "_plot" "_no" "v" "")
           (princ "\nLayer v created.")))
  (err-handle ""))
