;;;;;;("gr_on_off"
;;;;;;"Включение|Отключение выбора групп объектов
;;;;;; (см. системную переменную pickstyle)." "Аббревиатуры")
(defun c:gr_on_off ()
  (setq pstl (getvar "pickstyle"))
  (cond
    ((= pstl 0) (setvar "pickstyle" 1)(PRINC "\nGroup on..."))
    ((= pstl 1) (setvar "pickstyle" 0)(PRINC "\nGroup off..."))
    ((= pstl 2) (setvar "pickstyle" 3)(PRINC "\nGroup on..."))
    ((= pstl 3) (setvar "pickstyle" 2)(PRINC "\nGroup off..."))
  )
  (princ)
)