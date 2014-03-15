;;prins (str val)
;;	Выводит имя и значеие переменнной на экран.

;; util:entlast()
;;	Возвращает имя последнего неудаленного подпримитива
;;	(вершины полилинии, атрибут блока) в базе данных
;;	или nil если, неудаленных примитивов в базе данных нет.
;;	_$ (util:entlast)
;;	nil
;;	_$ (util:entlast)
;;	<Entity name: 14815a8>

(defun util:entlast  (/ tmp en)
  (setq	tmp (entlast)
	en  tmp)
  (while tmp
    (setq en  tmp
	  tmp (entnext tmp)))
  en)

;;prins (str val)
;;	Выводит имя и значеие переменнной на экран.
;;_$ (prins "lst_p1" 112.1323)
;;lst_p1 = 112.132
(defun prins (str val) (princ str) (princ " = ") (prin1 val) (princ))
