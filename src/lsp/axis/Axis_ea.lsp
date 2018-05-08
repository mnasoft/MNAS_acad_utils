;;;;;;("eam"
;;;;;;  "Устанавливает имя шкалы по содержимому текста для выбранного текстового примитива."
;;;;;;  "Шкалы")

(defun c:eam  (/ en-txt)
  (regapp (axis:app-name))
  (setq en-txt (dxf-get 1 (entget (car (entsel "\nВыберите текст:")))))
  (setq ed  (entget (car (entsel "\nВыберите Шкалу:")) (list (axis:app-name))))
  (print ed)
  (setq ed (subst (list -3 (append (list (axis:app-name)) (dsubst (cdr (assoc (axis:app-name) (cdr (assoc -3 ed)))) (list (cons 1000 en-txt))))) (assoc -3 ed) ed))
  (print ed)
  (entmod ed))

;;;;;;("mnas-axis-edit"
;;;;;;  "Производит преобразование примитивов типа LINE в примитив			
;;;;;; с расширенными данными типа \"SHCKALA\".\n
;;;;;; Расширенные даные имеют следующий вид:\n
;;;;;;(-3
;;;;;;  (\"SHCKALA\"      ; - имя приложения\n
;;;;;;    (1002 . \"{\")
;;;;;;    (1040 . 0.0)    ; - значение по шкале в начальной точке отрезка\n
;;;;;;    (1040 . 100.0)  ; - значение по шкале в конечной точке отрезка\n
;;;;;;    (1070 . 0)      ; - тип шкалы: 0-пропорциональная; 1-логарифмическая\n
;;;;;;    (1000 . \"xx\") ; - имя шкалы\n
;;;;;;    (1000 . \"кПа\") ; - размерность\n
;;;;;;    (1002 . \"}\")
;;;;;;  )
;;;;;;)"
;;;;;;  "Шкалы")

(defun c:mnas-axis-edit	 (/ ed ed1 en)
  (setq en (car (entsel "\nВыберите шкалу:")))
  (if (null en)
    (exit))
  (regapp (axis:app-name))
  (setq ed (entget en (list (axis:app-name))))
  (if (/= (cdr (assoc 0 ed)) "LINE")
    (exit))
  (if (null (_xd_appget ed (axis:app-name)))
    (setq ed1 (_xd_appsubst ed (axis:app-name) (axis:extract-axis-xdt (axis:make-axis-initial-data))))
    (setq ed1 ed))
  (setq ed1 (mnas-axis-edit:eaxis ed1))
  (if (not (equal ed ed1))
    (entmod ed1)))

;;;;;;("ea"
;;;;;;  "См. mnas-axis-edit"
;;;;;;  "Шкалы")
(defun c:ea ()
  (c:mnas-axis-edit))

(defun mnas-axis-edit:ac_e30-31 () (setq p-s (list (atof (get_tile "e30")) (atof (get_tile "e31")))))

(defun mnas-axis-edit:ac_e33-34 () (setq p-e (list (atof (get_tile "e33")) (atof (get_tile "e34")))))

(defun mnas-axis-edit:ac_e32 () (setq l__s (atof (get_tile "e32"))))

(defun mnas-axis-edit:ac_e35 () (setq l__e (atof (get_tile "e35"))))

(defun mnas-axis-edit:ac_name () (setq n-sc (get_tile "name")))

(defun mnas-axis-edit:ac_caption () (setq cap-sc (get_tile "caption")))

(defun mnas-axis-edit:ac_dimension () (setq dim-sc (get_tile "dimension")))

(defun mnas-axis-edit:ac_r30 () (setq fl 0))

(defun mnas-axis-edit:ac_r31  ()
  (setq fl 1)
  (if (or (<= l__s 0.0) (<= l__e 0.0))
    (progn (setq l__s 0.01) (setq l__e 100.0) (mnas-axis-edit:setup))))

(defun mnas-axis-edit:ac_b31 () (while (not (setq p-s (getpoint p-e "Начальная точка :")))))

(defun mnas-axis-edit:ac_b32 () (while (not (setq p-e (getpoint p-s "Конечная точка :")))))

(defun mnas-axis-edit:ac_tile  ()
  (action_tile "b31" "(done_dialog 31)")
  (action_tile "b32" "(done_dialog 32)")
  (action_tile "e30" "(mnas-axis-edit:ac_e30-31)")
  (action_tile "e31" "(mnas-axis-edit:ac_e30-31)")
  (action_tile "e32" "(mnas-axis-edit:ac_e32)")
  (action_tile "e33" "(mnas-axis-edit:ac_e33-34)")
  (action_tile "e34" "(mnas-axis-edit:ac_e33-34)")
  (action_tile "e35" "(mnas-axis-edit:ac_e35)")
  (action_tile "name" "(mnas-axis-edit:ac_name)")
  (action_tile "dimension" "(mnas-axis-edit:ac_dimension)")
  (action_tile "caption" "(mnas-axis-edit:ac_caption)")
  (action_tile "r30" "(mnas-axis-edit:ac_r30)")
  (action_tile "r31" "(mnas-axis-edit:ac_r31)")
  (action_tile "about" "(mnas-axis-edit:ac_about)"))

(defun mnas-axis-edit:ac_about () (alert (strcat "Редактирование шкалы" (about-GPL-string))))

(defun mnas-axis-edit:setup  ()
  (set_tile "e30" (rtos (car p-s)))
  (set_tile "e31" (rtos (cadr p-s)))
  (set_tile "e32" (rtos l__s))
  (set_tile "e33" (rtos (car p-e)))
  (set_tile "e34" (rtos (cadr p-e)))
  (set_tile "e35" (rtos l__e))
  (set_tile "name" n-sc)
  (set_tile "caption" cap-sc)
  (set_tile "dimension" dim-sc)
  (set_tile "name" n-sc)
  (if (= fl 0)
    (set_tile "r30" "1")
    (set_tile "r31" "1")))


(defun mnas-axis-edit:init  (/ ax-data)
  (setq	ax-data	(axis:get axdata)
	p-s	(cdr (assoc 10 ax-data))
	p-e	(cdr (assoc 11 ax-data))
	l__s	(cdr (assoc 40 ax-data))
	l__e	(cdr (assoc 41 ax-data))
	fl	(cdr (assoc 70 ax-data))
	n-sc	(cdr (assoc 1 ax-data))
	cap-sc	(cdr (assoc 2 ax-data))
	dim-sc	(cdr (assoc 3 ax-data))
	do_dial	t))

(defun mnas-axis-edit:un_init () (setq do_dial nil))

(defun mnas-axis-edit:eaxis  (axdata / act p-s p-e l__s l__e fl n-sc cap-sc dim-sc do_dial dcl_id)
  (setq dcl_id (load_dialog "./src/lsp/axis/axis.dcl"))
  (mnas-axis-edit:init)
  (while do_dial
;;;    (if	(not (new_dialog "eaxis" axis_dcl_id))
    (if (not (new_dialog "eaxis" dcl_id))
      (exit))
    (mnas-axis-edit:setup)
    (mnas-axis-edit:ac_tile)
    (setq act (start_dialog))
    (cond ((= act 1)
           (setq axdata (_xd_appsubst (dsubst axdata (list (cons 10 p-s) (cons 11 p-e)))
                                      (axis:app-name)
                                      (list (cons 1040 l__s) (cons 1040 l__e) (cons 1070 fl) (cons 1000 n-sc) (cons 1000 cap-sc) (cons 1000 dim-sc))))
           (mnas-axis-edit:un_init))
          ((= act 0) (mnas-axis-edit:un_init))
          ((= act 31) (mnas-axis-edit:ac_b31))
          ((= act 32) (mnas-axis-edit:ac_b32))))
  axdata)