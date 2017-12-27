;;;;;;("ea"
;;;;;;"Производит преобразование примитивов типа LINE в примитив			
;;;;;; с расширенными данными типа \"SHCKALA\".\n
;;;;;; Расширенные даные имеют следующий вид:\n
;;;;;;(-3
;;;;;;  (\"SHCKALA\"      ; - имя приложения\n
;;;;;;    (1002 . \"{\")
;;;;;;    (1040 . 0.0)    ; - значение по шкале в начальной точке отрезка\n
;;;;;;    (1040 . 100.0)  ; - значение по шкале в конечной точке отрезка\n
;;;;;;    (1070 . 0)      ; - тип шкалы: 0-пропорциональная; 1-логарифмическая\n
;;;;;;    (1000 . \"xx\") ; - имя шкалы\n
;;;;;;    (1002 . \"}\")
;;;;;;  )
;;;;;;)"
;;;;;;"Шкалы")

(defun c:eam  (/ en-txt)
  (regapp "SHCKALA")
  (setq en-txt (dxf-get 1 (entget (car (entsel "\nВыберите текст:")))))
  (setq ed  (entget (car (entsel "\nВыберите Шкалу:")) (list "SHCKALA")))
  (print ed)
  (setq ed (subst (list -3 (append (list "SHCKALA") (dsubst (cdr (assoc "SHCKALA" (cdr (assoc -3 ed)))) (list (cons 1000 en-txt))))) (assoc -3 ed) ed))
  (print ed)
  (entmod ed))

(defun c:ea  (/ ed ed1 en)
  (setq en (car (entsel "\nВыберите шкалу : ")))
  (if (null en)
    (exit))
  (regapp "SHCKALA")
  (setq ed (entget en (list "SHCKALA")))
  (if (/= (cdr (assoc 0 ed)) "LINE")
    (exit))
  (if (null (_xd_appget ed "SHCKALA"))
    (setq ed1 (_xd_appsubst ed "SHCKALA" (list '(1040 . 0.0) '(1040 . 100.0) '(1070 . 0) '(1000 . ""))))
    (setq ed1 ed))
  (setq ed1 (ea:eaxis ed1))
  (IF (NOT (EQUAL ED ED1))
    (entMOD ed1)))

(defun ea:ac_e30-31 () (setq p-s (list (atof (get_tile "e30")) (atof (get_tile "e31")))))

(defun ea:ac_e33-34 () (setq p-e (list (atof (get_tile "e33")) (atof (get_tile "e34")))))

(defun ea:ac_e32 () (setq l__s (atof (get_tile "e32"))))

(defun ea:ac_e35 () (setq l__e (atof (get_tile "e35"))))

(defun ea:ac_e36 () (setq n-sc (get_tile "e36")))

(defun ea:ac_r30 () (setq fl 0))

(defun ea:ac_r31  ()
  (setq fl 1)
  (if (or (<= l__s 0.0) (<= l__e 0.0))
    (progn (setq l__s 0.01) (setq l__e 100.0) (ea:setup))))

(defun ea:ac_b31 () (while (not (setq p-s (getpoint p-e "Начальная точка :")))))

(defun ea:ac_b32 () (while (not (setq p-e (getpoint p-s "Конечная точка :")))))

(defun ea:ac_tile  ()
  (action_tile "b31" "(done_dialog 31)")
  (action_tile "b32" "(done_dialog 32)")
  (action_tile "e30" "(ea:ac_e30-31)")
  (action_tile "e31" "(ea:ac_e30-31)")
  (action_tile "e32" "(ea:ac_e32)")
  (action_tile "e33" "(ea:ac_e33-34)")
  (action_tile "e34" "(ea:ac_e33-34)")
  (action_tile "e35" "(ea:ac_e35)")
  (action_tile "e36" "(ea:ac_e36)")
  (action_tile "r30" "(ea:ac_r30)")
  (action_tile "r31" "(ea:ac_r31)")
  (action_tile "about" "(ea:ac_about)"))

(defun ea:ac_about () (alert (strcat "Редактирование шкалы" (about-GPL-string))))


(defun ea:setup  ()
  (set_tile "e30" (rtos (car p-s)))
  (set_tile "e31" (rtos (cadr p-s)))
  (set_tile "e32" (rtos l__s))
  (set_tile "e33" (rtos (car p-e)))
  (set_tile "e34" (rtos (cadr p-e)))
  (set_tile "e35" (rtos l__e))
  (set_tile "e36" n-sc)
  (if (= fl 0)
    (set_tile "r30" "1")
    (set_tile "r31" "1")))

(defun ea:init  ()
  (setq p-s (cdr (assoc 10 axdata)))
  (setq p-e (cdr (assoc 11 axdata)))
  (setq l__s (xdgetn axdata "SHCKALA" 0))
  (setq l__e (xdgetn axdata "SHCKALA" 1))
  (setq fl (xdgetn axdata "SHCKALA" 2))
  (setq n-sc (xdgetn axdata "SHCKALA" 3))
  (setq do_dial t))

(defun ea:un_init () (setq do_dial nil))

(defun ea:eaxis  (axdata / act p-s p-e l__s l__e fl n-sc do_dial dcl_id)
  (setq dcl_id (load_dialog "./acad_w.sup/axis/axis.dcl"))
  (ea:init)
  (while do_dial
;;;    (if	(not (new_dialog "eaxis" axis_dcl_id))
    (if (not (new_dialog "eaxis" dcl_id))
      (exit))
    (ea:setup)
    (ea:ac_tile)
    (setq act (start_dialog))
    (cond ((= act 1)
           (setq axdata (_xd_appsubst (dsubst axdata (list (cons 10 p-s) (cons 11 p-e)))
                                      "SHCKALA"
                                      (list (cons 1040 l__s) (cons 1040 l__e) (cons 1070 fl) (cons 1000 n-sc))))
           (ea:un_init))
          ((= act 0) (ea:un_init))
          ((= act 31) (ea:ac_b31))
          ((= act 32) (ea:ac_b32))))
  axdata)