(defun func_2                           ; Настроить
               (/
                action                  ; Номер дествия приобработке диалога
                fl_nm                   ; 
                )
  (setup_f2_dialog)
  (setup_ac_f2)
  (setq action (start_dialog))
  (cond ((= action 0) (setq num_dia 0))
        ((= action 1)
         (setq num_dia 0)
         (setq fl_nm (open (strcat (acad_sup) "/spec/Dialog_Nastrojka.lsp") "w"))
         (prinf "dlg_2_kv" dlg_2_kv fl_nm)
         (close fl_nm))
        ((= action 2) (ac_b_2_4))
        ((= action 3) (ac_b_2_1))))

(defun dis_b  ()                        ; Замораживает две кнопки в окне Настроить
  (mapcar 'mode_tile (list "b_2_1" "b_2_2") (list 1 1)))

(defun en_b  ()                         ; Размораживает две кнопки в окне Настроить
  (mapcar 'mode_tile (list "b_2_1" "b_2_2") (list 0 0)))

(defun ac_b_2_1  ()
  (setq line_p0 nil
        line_p1 nil)
  (while (null line_p0) (setq line_p0 (getpoint "\nПервая точка линии:")))
  (while (null line_p1) (setq line_p1 (getpoint line_p0 "\nВторая точка линии:"))))

(defun ac_b_2_4  (/ p0 p1)              ; Задает направление полки
  (setq p0    (getpoint "\nНачало:")
        p1    (getpoint p0 "\nНаправление:")
        a_dir (angle p0 p1)))

(defun ac_dlg_2  ($key $value)          ; Считывание сохраняемых данных
  (cond ((= $key "r_2_1") (dis_b))
        ((or (= $key "r_2_2") (= $key "r_2_3") (= $key "r_2_4") (= $key "r_2_5")) (en_b)))
  (setq dlg_2_kv (mapcar (function (lambda (e) (cons (car e) (get_tile (car e))))) dlg_2_kv)))

(defun setup_ac_f2  ()                  ; Задание функций обработки событий диалога
  (action_tile "b_2_1" "(done_dialog 3)") ;Линия точка+направление
  (action_tile "b_2_4" "(done_dialog 2)") ;Задать напрвление позиции
  (mapcar (function (lambda (e) (action_tile (car e) "(ac_dlg_2 $key $value)"))) dlg_2_kv))


(defun setup_f2_dialog  ()              ; Настройка диалога
  (mapcar (function (lambda (e) (set_tile (car e) (cdr e)))) dlg_2_kv)
  (if (= (cdr (assoc "r_2_1" dlg_2_kv)) "1")
    (dis_b)))
