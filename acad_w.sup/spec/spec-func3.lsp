(defun func_3  (/ action_3)             ; Диалог спецификация
  (setup_f3_dialog)
  (setup_f3_ac)
  (setq action_3 (start_dialog))
  (cond ((= action_3 0) (setq num_dia 0))
        ((= action_3 1) (setq num_dia 0))
        ((= action_3 5) (ac_b_3_4) (setq num_dia 0))
        (t (setq num_dia 0))))

(defun setup_l_3_1  ()
  (start_list "l_3_1")
  (mapcar (function
            (lambda (e) (add_list (apply 'strcat (mapcar (function (lambda (e1) (strcat (cdr e1) "\t"))) e)))))
          sp_poz)
  (end_list))

(defun get_poz (key) (atoi (cdr (assoc key dlg_3_kv))))

(defun set_poz  (key poz / temp)
  (setq temp     (itoa poz)
        dlg_3_kv (subst (cons key temp) (assoc key dlg_3_kv) dlg_3_kv))
  (set_tile key temp))

(defun ac_b_3_3  (/ temp)
  (setq temp (get_poz "l_3_1"))
  (del 'temp 'sp_poz)
  (setup_l_3_1)
  (set_poz "l_3_1" temp))

(defun ac_b_3_4  ()
  (setq sp_curr (nth (get_poz "l_3_1") sp_poz))
  (mapcar (function
            (lambda (e)
              (setq dlg_1_kv (subst (cons (cdr e) (cdr (assoc (car e) sp_curr))) (assoc (cdr e) dlg_1_kv) dlg_1_kv))
              t))
          d1_sp_curr))

(defun ac_b_3_8  (/ temp sp_prev)
  (setq temp (get_poz "l_3_1"))
  (cond ((> temp 0)
         (setq sp_curr (nth temp sp_poz)
               sp_prev (nth (1- temp) sp_poz))
         (upd 'sp_prev 'temp 'sp_poz)
         (setq temp (1- temp))
         (upd 'sp_curr 'temp 'sp_poz)
         (setup_l_3_1)
         (set_poz "l_3_1" temp))))

(defun ac_b_3_9  (/ temp sp_next)
  (setq temp (get_poz "l_3_1"))
  (cond ((< temp (1- (length sp_poz)))
         (setq sp_curr (nth temp sp_poz)
               sp_next (nth (1+ temp) sp_poz))
         (upd 'sp_next 'temp 'sp_poz)
         (setq temp (1+ temp))
         (upd 'sp_curr 'temp 'sp_poz)
         (setup_l_3_1)
         (set_poz "l_3_1" temp))))

(defun ac_dlg_3  ($key $value)
  (setq dlg_3_kv (subst (cons $key $value) (assoc $key dlg_3_kv) dlg_3_kv)))

(defun setup_f3_ac  ()
  (action_tile "b_3_1" "(done_dialog 2)") ;Доб_пер
  (action_tile "b_3_2" "(done_dialog 3)") ;Доб_пос
  (action_tile "b_3_3" "(ac_b_3_3)")    ;Удалить
  (action_tile "b_3_4" "(done_dialog 5)") ;Редакт.
  (action_tile "b_3_5" "(done_dialog 6)") ;Сорт.
  (action_tile "b_3_6" "(done_dialog 7)") ;Выбрать
  (action_tile "b_3_7" "(done_dialog 8)") ;Расст. поз.
  (action_tile "b_3_8" "(ac_b_3_8)")    ;<
  (action_tile "b_3_9" "(ac_b_3_9)")    ;>
  (mapcar (function (lambda (e) (action_tile (car e) "(ac_dlg_3 $key $value)"))) dlg_3_kv))

(defun setup_f3_dialog  (/ temp)
  (setq temp 0)
  (setq sp_curr (mapcar (function (lambda (e) (cons (car e) (cdr (assoc (cdr e) dlg_1_kv))))) d1_sp_curr))
  (cond ((= action_3 2) (setq temp (get_poz "l_3_1")) (ins_befor 'sp_curr 'temp 'sp_poz))
        ((= action_3 3) (setq temp (get_poz "l_3_1")) (ins_after 'sp_curr 'temp 'sp_poz))
        ((= action_3 5) (setq temp (get_poz "l_3_1")) (upd 'sp_curr 'temp 'sp_poz))
        (t nil))
  (setup_l_3_1)
  (set_poz "l_3_1" temp))
