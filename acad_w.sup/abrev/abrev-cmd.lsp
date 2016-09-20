;;;;;;("pur" "Очистка всех неиспользуемых элементов из секции таблиц." "Аббревиатуры")
(defun c:pur () (command "_.purge" "_all" "*" "_no") (princ))

;;;;;;("ra" "Перерисовка всех видовых экранов." "Аббревиатуры")
(defun c:ra () (command "_.redrawall") (princ))

;;;;;;("rg" "Регенерация чертежа." "Аббревиатуры")
(defun c:rg () (command "_.regen") (princ))

;;;;;;("rga" "Регенерация всех видовых экранов в чертеже." "Аббревиатуры")
(defun c:rga () (command "_.regenall") (princ))

;;;;;;("sk" "Отрисовка эскизной полилинии (линии обрыва)." "Аббревиатуры")
(defun c:sk  (/ skp ortm)
  (setq skp  (getvar "skpoly")
        ortm (getvar "orthomode"))
  (setvar "skpoly" 1)
  (setvar "orthomode" 0)
  (command "_.sketch")
  (while (= 1 (getvar "cmdactive")) (command pause))
  (setvar "skpoly" skp)
  (setvar "orthomode" ortm)
  (princ))

;;;;;;("tm" "Включение|Выключение режима кафельной плитки." "Аббревиатуры")
(defun c:tm  (/ n)
  (setq n (getvar "tilemode"))
  (cond ((= n 1) (setvar "tilemode" 0))
        ((= n 0) (setvar "tilemode" 1)))
  (princ))

;;;;;;("vs" "Вызов команды _.vports, управляющей протами просмотра." "Аббревиатуры")
(defun c:vs () (command "_.vports"))

;;;;;;("z" "Вызов команды _.zoom, управляющей изменением области просмотра." "Аббревиатуры")
(defun c:z () (command "_.zoom"))

;;;;;;("za"
;;;;;;"Изменение области просмотра таким образом,
;;;;;; чтобы были отображены все срегенерированные примитивы чертежа +
;;;;;; область опеделяемая лимитами чертежа." "Аббревиатуры")
(defun c:za () (command "_.zoom" "_a"))

;;;;;;("zc" "Изменение области просмотра по ценральной точке и высоте." "Аббревиатуры")
(defun c:zc () (command "_.zoom" "_c"))

;;;;;;("zd" "Изменение области просмотра при помощи динамического окна." "Аббревиатуры")
(defun c:zd () (command "_.zoom" "_d"))

;;;;;;("ze"
;;;;;;"Изменение области просмотра таким образом,
;;;;;; чтобы были отображены все срегенерированные примитивы чертежа." "Аббревиатуры")
(defun c:ze () (command "_.zoom" "_e"))

;;;;;;("zp" "Просмотр предыдущей отображаемой области." "Аббревиатуры")
(defun c:zp () (command "_.zoom" "_p"))

;;;;;;("zv"
;;;;;;"Изменение области просмотра таким образом,
;;;;;; чтобы стала отображаться максимальная область, не требующая регенерации." "Аббревиатуры")
(defun c:zv () (command "_.zoom" "_v"))

;;;;;;("zw" "Изменение области просмотра, определяемой окном." "Аббревиатуры")
(defun c:zw () (command "_.zoom" "_w"))

;;;;;;("fr" "Вызов команды _.fillet с последующим указанием ключа для ввода радиуса." "Аббревиатуры")
(defun c:fr () (command "_.fillet" "_r") (princ))

;;;;;;("f" "Вызов команды _.fillet с последующим указанием ключа для ввода радиуса." "Аббревиатуры")
(defun c:f () (command "_.fillet") (princ))

;;;;;;("chd" "Вызов команды _.chamfer с последующим указанием ключа для ввода длины фаски." "Аббревиатуры")
(defun c:chd () (command "_.chamfer" "_d") (princ))

;;;;;;("ch" "Вызов команды _.chamfer." "Аббревиатуры")
(defun c:ch () (command "_.chamfer") (princ))

;;;;;;("s" "Вызов команды _.stretch" "Аббревиатуры")
(defun c:s () (command "_.stretch") (princ))

;;;;;;("l" "Вызов команды _.line" "Аббревиатуры")
(defun c:l () (command "_.line") (princ))

;;;;;;("a" "Вызов команды _.arc" "Аббревиатуры")
(defun c:a () (command "_.arc") (princ))

;;;;;;("o" "Вызов команды _.offset" "Аббревиатуры")
(defun c:o () (command "_.offset") (princ))

;;;;;;("c" "Вызов команды _.circle" "Аббревиатуры")
(defun c:c () (command "_.circle") (princ))

;;;;;;("e" "Вызов команды _.erase" "Аббревиатуры")
(defun c:e () (command "_.erase") (princ))

;;;;;;("co" "Вызов команды _.copy" "Аббревиатуры")
(defun c:co () (command "_.copy") (princ))

;;;;;;("cp" "Вызов команды _.copy" "Аббревиатуры")
(defun c:cp () (command "_.copy") (princ))

;;;;;;("m" "Вызов команды _.move" "Аббревиатуры")
(defun c:m () (command "_.move") (princ))

;;;;;;("ro" "Вызов команды _.rotate" "Аббревиатуры")
(defun c:ro () (command "_.rotate") (princ))

;;;;;;("tr" "Вызов команды _.trim" "Аббревиатуры")
(defun c:tr () (command "_.trim") (princ))

;;;;;;("ex" "Вызов команды _.extend" "Аббревиатуры")
(defun c:ex () (command "_.extend") (princ))

;;;;;;("rec" "Вызов команды _.rectangle" "Аббревиатуры")
(defun c:rec () (command "_.rectangle") (princ))

;;;;;;("mi" "Вызов команды _.mirror" "Аббревиатуры")
(defun c:mi () (command "_.mirror") (princ))

;;;;;;("el" "Вызов команды _.ellipse" "Аббревиатуры")
(defun c:el () (command "_.ellipse") (princ))

;;;;;;("br" "Вызов команды _.break" "Аббревиатуры")
(defun c:br () (command "_.break") (princ))

;;;;;;("u" "Вызов команды _.u" "Аббревиатуры")
(defun c:u () (command "_.u") (princ))

;;;;;;("undo" "Вызов команды _.undo" "Аббревиатуры")
(defun c:undo () (command "_.undo") (princ))

;;;;;;("sc" "Вызов команды _.scale" "Аббревиатуры")
(defun c:sc () (command "_.scale") (princ))

;;;;;;("oops" "Вызов команды _.oops" "Аббревиатуры")
(defun c:oops () (command "_.oops") (princ))

;;;;;;("di" "Вызов команды _.dist" "Аббревиатуры")
(defun c:di () (command "_.dist") (princ))

;;;;;;("id" "Вызов команды _.id" "Аббревиатуры")
(defun c:id () (command "_.id") (princ))

;;;;;;("ma" "Вызов команды _.matchprop" "Аббревиатуры")
(defun c:ma () (command "_.matchprop") (princ))

;;;;;;("le" "Вызов команды _.qleader" "Аббревиатуры")
(defun c:le () (command "_.qleader") (princ))

;;;;;;("op" "Вызов команды _.options" "Аббревиатуры")
(defun c:op () (command "_.options") (princ))

;;;;;;("h" "Вызов команды _.bhatch" "Аббревиатуры")
(defun c:h  (/ dist sc an)
  (setq dist (getdist "Введите расстояние между линиями штриховки без учета масштаба размеров:")
        sc   (cond ((= (getvar "dimscale") 0.0) 1.0)
                   (t (getvar "dimscale")))
        an   (getangle "Введите угол наклона штрихов:"))
  (command "_-hatch" "_p" "_u" (* (/ 180. pi) an) (* dist sc))
  ;;(command "_.bhatch") (princ)
  )

;;;(defun c:he (/ dist sc an)
;;;  (setq
;;;    dist (getdist "Введите расстояние между линиями штриховки без учета масштаба размеров:")
;;;    sc	 (cond
;;;	   ((= (getvar "dimscale") 0.0) 1.0)
;;;	   ( t (getvar "dimscale"))
;;;	 )
;;;    an   (getangle "Введите угол наклона штрихов:")
;;;  )
;;;  (command "_-hatch" "_p" "_u" (* (/ 180. pi) an) (* dist sc))
;;;  ;;(command "_.bhatch") (princ)
;;;)

;;;;;;("dt" "Вызов команды _.dtext" "Аббревиатуры")
(defun c:dt () (command "_.dtext") (princ))

;;;;;;("pe" "Вызов команды _.pedit" "Аббревиатуры")
(defun c:pe () (command "_.pedit") (princ))

;;;;;;("bo" "Вызов команды _.boundary" "Аббревиатуры")
(defun c:bo () (command "_.boundary") (princ))

;;;;;;("ar" "Вызов команды _.array" "Аббревиатуры")
(defun c:ar () (command "_.array") (princ))

;;;;;;("li" "Вызов команды _.list" "Аббревиатуры")
(defun c:li () (command "_.list") (princ))

;;;;;;("x" "Вызов команды _.explode" "Аббревиатуры")
(defun c:x () (command "_.explode") (princ))

;;;;;;("xa" "uВызов команды _.explode" "Аббревиатуры")
(defun c:xa  (/ el ss)
  (entmake '((0 . "POINT") (10 0.0 0.0 0.0)))
  (setq el (entlast))
  (prompt "Выдерите объекты для полного взрыва")
  (setq ss (ssget '((0 . "INSERT"))))
  (while (> (sslength ss) 0)
    (explode-all ss)
    (setq ss (select-all-past-ename el))
    )
  (entdel el)
  (princ))

(defun select-all-past-ename  (el / ss ed)
  (setq ss (ssadd))
  (while (and el (setq el (entnext el)))
    (setq ed (entget el))
    (if (= "INSERT" (cdr (assoc 0 ed)))
    (setq ss (ssadd el ss))))
  ss)

(defun explode-all  (ss / i)
  (setq i (sslength ss))
  (while (>= (setq i (1- i)) 0) (vl-cmdf "_.explode" (ssname ss i) "")))




;;;;;;("j" "Вызов команды _.join" "Аббревиатуры")
(defun c:j () (command "_.join") (princ))

;;;;;;("b" "Вызов команды _.block" "Аббревиатуры")
(defun c:b () (command "_.block") (princ))

;;;;;;("ps" "Вызов команды _.pspace" "Аббревиатуры")
(defun c:ps () (command "_.pspace") (princ))

;;;;;;("ms" "Вызов команды _.mspace" "Аббревиатуры")
(defun c:ms () (command "_.mspace") (princ))

;;;;;;("git" "Вызов команды D:\\home\\_namatv\\Git\\git-bash.bat" "Аббревиатуры")
(defun c:git () (command "shell" "D:\\home\\_namatv\\Git\\git-bash.bat"))

(defun c:vl () (command "_-VPORTS" "_L" "_ON"))

(defun c:vu () (command "_-VPORTS" "_L" "_OFF"))


(defun c:lou () (command "_LAYOUT" "_S"))

;;;;;;("gr_on_off"
;;;;;;"Включение|Отключение выбора групп объектов
;;;;;; (см. системную переменную pickstyle)." "Аббревиатуры")
(defun c:gr_on_off  ()
  (setq pstl (getvar "pickstyle"))
  (cond ((= pstl 0) (setvar "pickstyle" 1) (princ "\nGroup on..."))
        ((= pstl 1) (setvar "pickstyle" 0) (princ "\nGroup off..."))
        ((= pstl 2) (setvar "pickstyle" 3) (princ "\nGroup on..."))
        ((= pstl 3) (setvar "pickstyle" 2) (princ "\nGroup off...")))
  (princ))
