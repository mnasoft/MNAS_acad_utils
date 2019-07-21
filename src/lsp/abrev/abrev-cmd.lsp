;;;;;;("x" "Вызов команды _.explode." "Аббревиатуры")
;;;; Попытка устранения ошибки в SPDS.
;;;; Её надобность в отсутствие SPDS отпала.
;;;(defun c:x  (/ en)
;;;  (setq en (car (entsel "Выберите полилинию:")))
;;;  (command "_.pedit" en "_close" "")
;;;  (command "_.region" en "")
;;;  (setq en (entlast))
;;;  (command "_.explode" en "")
;;;  (princ))


;;;;;;("pur" "Очистка всех неиспользуемых элементов из секции таблиц." "Аббревиатуры")
(defun c:pur () (command "_.purge" "_all" "*" "_no") (princ))

;;;;;;("ra" "Перерисовка всех видовых экранов." "Аббревиатуры")
     ;(defun c:ra () (command "_.redrawall") (princ))

;;;;;;("rg" "Регенерация чертежа." "Аббревиатуры")
     ;(defun c:rg () (command "_.regen") (princ))

;;;;;;("rga" "Регенерация всех видовых экранов в чертеже." "Аббревиатуры")
     ;(defun c:rga () (command "_.regenall") (princ))

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
     ;(defun c:vs () (command "_.vports"))

;;;;;;("z" "Вызов команды _.zoom, управляющей изменением области просмотра." "Аббревиатуры")
     ;(defun c:z () (command "_.zoom"))

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
     ;(defun c:f () (command "_.fillet") (princ))

;;;;;;("chd" "Вызов команды _.chamfer с последующим указанием ключа для ввода длины фаски." "Аббревиатуры")
(defun c:chd () (command "_.chamfer" "_d") (princ))

;;;;;;("ch" "Вызов команды _.chamfer." "Аббревиатуры")
     ;(defun c:ch () (command "_.chamfer") (princ))

;;;;;;("s" "Вызов команды _.stretch" "Аббревиатуры")
     ;(defun c:s () (command "_.stretch") (princ))

;;;;;;("l" "Вызов команды _.line" "Аббревиатуры")
     ;(defun c:l () (command "_.line") (princ))

;;;;;;("a" "Вызов команды _.arc" "Аббревиатуры")
     ;(defun c:a () (command "_.arc") (princ))

;;;;;;("o" "Вызов команды _.offset" "Аббревиатуры")
     ;(defun c:o () (command "_.offset") (princ))

;;;;;;("c" "Вызов команды _.circle" "Аббревиатуры")
     ;(defun c:c () (command "_.circle") (princ))

;;;;;;("e" "Вызов команды _.erase" "Аббревиатуры")
     ;(defun c:e () (command "_.erase") (princ))

;;;;;;("co" "Вызов команды _.copy" "Аббревиатуры")
     ;(defun c:co () (command "_.copy") (princ))

;;;;;;("cp" "Вызов команды _.copy" "Аббревиатуры")
     ;(defun c:cp () (command "_.copy") (princ))

;;;;;;("m" "Вызов команды _.move" "Аббревиатуры")
     ;(defun c:m () (command "_.move") (princ))

;;;;;;("ro" "Вызов команды _.rotate" "Аббревиатуры")
     ;(defun c:ro () (command "_.rotate") (princ))

;;;;;;("tr" "Вызов команды _.trim" "Аббревиатуры")
     ;(defun c:tr () (command "_.trim") (princ))

;;;;;;("ex" "Вызов команды _.extend" "Аббревиатуры")
     ;(defun c:ex () (command "_.extend") (princ))

;;;;;;("rec" "Вызов команды _.rectangle" "Аббревиатуры")
     ;(defun c:rec () (command "_.rectangle") (princ))

;;;;;;("mi" "Вызов команды _.mirror" "Аббревиатуры")
     ;(defun c:mi () (command "_.mirror") (princ))

;;;;;;("el" "Вызов команды _.ellipse" "Аббревиатуры")
     ;(defun c:el () (command "_.ellipse") (princ))

;;;;;;("br" "Вызов команды _.break" "Аббревиатуры")
     ;(defun c:br () (command "_.break") (princ))

;;;;;;("u" "Вызов команды _.u" "Аббревиатуры")
     ;(defun c:u () (command "_.u") (princ))

;;;;;;("undo" "Вызов команды _.undo" "Аббревиатуры")
     ;(defun c:undo () (command "_.undo") (princ))

;;;;;;("sc" "Вызов команды _.scale" "Аббревиатуры")
     ;(defun c:sc () (command "_.scale") (princ))

;;;;;;("oops" "Вызов команды _.oops" "Аббревиатуры")
     ;(defun c:oops () (command "_.oops") (princ))

;;;;;;("di" "Вызов команды _.dist" "Аббревиатуры")
     ;(defun c:di () (command "_.dist") (princ))

;;;;;;("id" "Вызов команды _.id" "Аббревиатуры")
     ;(defun c:id () (command "_.id") (princ))

;;;;;;("ma" "Вызов команды _.matchprop" "Аббревиатуры")
     ;(defun c:ma () (command "_.matchprop") (princ))

;;;;;;("le" "Вызов команды _.qleader" "Аббревиатуры")
     ;(defun c:le () (command "_.qleader") (princ))

;;;;;;("op" "Вызов команды _.options" "Аббревиатуры")
     ;(defun c:op () (command "_.options") (princ))

;;;;;;("h" "Вызов команды _.bhatch" "Аббревиатуры")
     ;(defun c:h  (/ dist sc an)
     ;  (setq dist (getdist "Введите расстояние между линиями штриховки без учета масштаба размеров:")
     ;        sc   (cond ((= (getvar "dimscale") 0.0) 1.0)
     ;                   (t (getvar "dimscale")))
     ;        an   (getangle "Введите угол наклона штрихов:"))
     ;  (command "_-hatch" "_p" "_u" (* (/ 180. pi) an) (* dist sc))
     ;  ;;(command "_.bhatch") (princ)
     ;  )

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
;;;(command "_.bhatch") (princ)
;;;)

;;;;;;("dt" "Вызов команды _.dtext" "Аббревиатуры")
;;(defun c:dt () (command "_.dtext") (princ))

;;;;;;("pe" "Вызов команды _.pedit" "Аббревиатуры")
;;(defun c:pe () (command "_.pedit") (princ))

;;;;;;("bo" "Вызов команды _.boundary" "Аббревиатуры")
;;(defun c:bo () (command "_.boundary") (princ))

;;;;;;("ar" "Вызов команды _.array" "Аббревиатуры")
;;(defun c:ar () (command "_.array") (princ))

;;;;;;("li" "Вызов команды _.list" "Аббревиатуры")
;;(defun c:li () (command "_.list") (princ))

;;;;;;("x" "Вызов команды _.explode" "Аббревиатуры")
;;(defun c:x () (command "_.explode") (princ))

;;;;;;("xa" "Выполняет рекурсивный взрыв блоков" "Аббревиатуры")
(defun c:xa  (/ el ss)
  (entmake '((0 . "POINT") (10 0.0 0.0 0.0)))
  (setq el (entlast))
  (prompt "Выберите объекты для полного взрыва")
  (setq ss (ssget '((0 . "INSERT"))))
  (while (and ss (> (sslength ss) 0)) (explode-all ss) (setq ss (select-all-past-ename el)))
  (entdel el)
  (princ))

;;;;;;("j" "Вызов команды _.join" "Аббревиатуры")
;;(defun c:j () (command "_.join") (princ))

;;;;;;("b" "Вызов команды _.block" "Аббревиатуры")
;;(defun c:b () (command "_.block") (princ))

;;;;;;("ps" "Вызов команды _.pspace" "Аббревиатуры")
;;(defun c:ps () (command "_.pspace") (princ))

;;;;;;("ms" "Вызов команды _.mspace" "Аббревиатуры")
;;(defun c:ms () (command "_.mspace") (princ))

;;;;;;("git" "Вызов команды D:\\home\\_namatv\\Git\\git-bash.bat" "Аббревиатуры")
(defun c:git () (command "shell" "D:\\home\\_namatv\\Git\\git-bash.bat"))

(defun c:vl () (command "_-VPORTS" "_L" "_ON"))

(defun c:vu () (command "_-VPORTS" "_L" "_OFF"))

(defun layout-tab-list  (/ layouts items acadObj doc)
  (setq acadObj (vlax-get-acad-object))
  (setq doc (vla-get-ActiveDocument acadObj))
  (mapcar 'vla-get-name
          (vl-sort (vlax-for layout (vla-get-layouts doc) (setq layouts (cons layout layouts)))
                   '(lambda (a b) (< (vla-get-taborder a) (vla-get-taborder b))))))

(defun clayout-number  (/ layout-lst)
  (setq layout-lst (layout-tab-list))
  (- (length layout-lst)
     (length
       (member (VL-LIST->STRING (reverse (cdr (member 42 (reverse (vl-string->list (getvar "clayout")))))))
               layout-lst))))

(defun c:ll  (/ layout-lst)
  (setq layout-lst (layout-tab-list))
  (setq new-layout (nth (max 1 (- (clayout-number) 10)) layout-lst))
  (command "_layout" "_set" new-layout))

(defun c:lr  (/ layout-lst)
  (setq layout-lst (layout-tab-list))
  (setq new-layout (nth (min (- (length layout-lst) 1) (+ (clayout-number) 10)) layout-lst))
  (command "_layout" "_set" new-layout))

(defun c:l-first  (/ layout-lst)
  (setq layout-lst (layout-tab-list))
  (setq new-layout (nth 1 layout-lst))
  (command "_layout" "_set" new-layout))

(defun c:l-last  (/ layout-lst)
  (setq layout-lst (layout-tab-list))
  (setq new-layout (nth (- (length layout-lst) 1) layout-lst))
  (command "_layout" "_set" new-layout))

(defun c:l-mid  (/ layout-lst)
  (setq layout-lst (layout-tab-list))
  (setq new-layout (nth (/ (- (length layout-lst) 2 ) 1) layout-lst))
  (command "_layout" "_set" new-layout))

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

(defun c:lim  (/ plb prt)
  (command "_zoom" "_e")
  (command "_zoom" "0.8x")
  (setq plb (getpoint "Левый нижний угол:")
        prt (getpoint "Правый верхний угол:"))
  (command "_limits" "_non" plb "_non" prt)
  (command "_zoom" "_e"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

";  -- User Defined Command Aliases --
HE,         	    *HATCHEDIT
BH,                 *BHATCH
;  Make any changes or additions to the default AutoCAD command aliases in 
;  this section to ensure successful migration of these settings when you
;  upgrade to the next version of AutoCAD.  If a command alias appears more
;  than once in this file, items in the User Defined Command Alias take
;  precedence over duplicates that appear earlier in the file.
;  **********----------**********  ; No xlate ; DO NOT REMOVE
"

(setq *acad-pgp-data*
       '((("QLEADER" "БВЫНОСКА") ("LE" "ДЕ"))
	 (("HATCHEDIT" "РЕДШТРИХ") ("HE" "РУ"))
	 (("BHATCH" "ШТРИХ") ("BH" "ИР"))
         (("REDRAW" "ОСВЕЖИТЬ") ("RE" "КУ"))
	 (("REDRAWALL" "ВСЕОСВЕЖ") ("REA" "КУА"))
	 (("REGEN" "РЕГЕН") ("RG" "КП"))
	 (("REGENALL" "ВСЕРЕГЕН") ("RGA" "КПФ"))
	 (("VPORTS" "ВЭКРАН") ("VS" "МЫ"))
	 (("ZOOM" "ПОКАЗАТЬ") ("Z" "Я"))
	 (("FILLET" "СОПРЯЖЕНИЕ") ("F" "А"))
	 (("CHAMFER" "ФАСКА") ("CH" "СР"))
	 (("STRETCH" "РАСТЯНУТЬ") ("S" "Ы"))
	 (("LINE" "ОТРЕЗОК") ("L" "Д"))
	 (("ARC" "ДУГА") ("A" "Ф"))
	 (("OFFSET" "ПОДОБИЕ") ("O" "Щ"))
	 (("CIRCLE" "КРУГ") ("C" "С"))
	 (("ERASE" "СТЕРЕТЬ") ("E" "У"))
	 (("COPY" "КОПИРОВАТЬ") ("CO" "CP" "СЩ" "СЗ"))
	 (("MOVE" "ПЕРЕНЕСТИ") ("M" "Ь"))
	 (("ROTATE" "ПОВЕРНУТЬ") ("R" "К"))
	 (("TRIM" "ОБРЕЗАТЬ") ("TR" "ЕК"))
	 (("EXTEND" "УДЛИНИТЬ") ("EX" "УЧ"))
	 (("RECTANGLE" "ПРЯМОУГ") ("REC" "КУС"))
	 (("MIRROR" "ЗЕРКАЛО") ("MI" "ЬШ"))
	 (("ELLIPSE" "ЭЛЛИПС") ("EL" "УД"))
	 (("BREAK" "РАЗОРВАТЬ") ("BR" "ИК"))
	 (("U" "О") ("U" "Г"))
	 (("UNDO" "ОТМЕНИТЬ") ("UNDO" "ГТВЩ"))
	 (("SCALE" "МАСШТАБ") ("SC" "ЫС"))
	 (("OOPS" "ОЙ") ("OOPS" "ЩЩЗЫ"))
	 (("DIST" "ДИСТ") ("DI" "ВШ"))
	 (("ID" "КООРД") ("ID" "ШВ"))
	 (("MATCHPROP" "КОПИРОВАТЬСВ") ("MA" "ЬФ"))
;;;;;;;;;;;;;;;;;;;;;;;
	 (("DTEXT" "ДТЕКСТ") ("dt" "ве"))
	 (("PEDIT" "ПОЛРЕД") ("pe" "зу"))
	 (("BOUNDARY" "КОНТУР") ("bo" "ищ"))
	 (("ARRAY" "МАССИВ") ("ar" "фк"))
	 (("LIST" "СПИСОК") ("li" "дш"))
	 (("EXPLODE" "РАСЧЛЕНИТЬ") ("x" "ч"))
	 (("JOIN" "СОЕДИНИТЬ") ("j" "о"))
	 (("BLOCK" "БЛОК") ("b" "и"))
	 (("PSPACE" "ЛИСТ") ("ps" "зы"))
	 (("MSPACE" "МОДЕЛЬ") ("ms" "ьы"))))


(defun string-split  (delimiter string / l i a b q n)
  (if (and string
           (= 'str (type string))
           (setq q (strlen string)
                 i 1))
    (while (<= i q)
      (while (and (= (substr string i 1) delimiter) (<= i q)) (setq i (1+ i)))
      (setq n i)
      (while (and (/= (substr string i 1) delimiter) (<= i q)) (setq i (1+ i)))
      (setq a (substr string n (- i n))
            i (1+ i))
      (if (and a (/= "" a))
        (setq l (cons a l)))))
  (if l
    (reverse l)))

(defun make-pgp-record  (a-lst comm / c-a)
  (setq c-a ",          *")
  (mapcar (function (lambda (el) (princ (strcat el c-a comm "\n")))) a-lst))

(defun make-en-pgp-record  ()
  (mapcar (function (lambda (el) (make-pgp-record (cadr el) (caar el)))) *acad-pgp-data*))

(defun make-ru-pgp-record  ()
  (mapcar (function (lambda (el) (make-pgp-record (cadr el) (cadar el)))) *acad-pgp-data*))

(defun c:acad-pdp-add-script  (/ r-r-p r-r-p-last)
  (setq r-r-p (getvar "ROAMABLEROOTPREFIX"))
  (setq r-r-p-last (strcase (last (string-split "\\" r-r-p))))
  (cond ((= "ENU" r-r-p-last) (make-en-pgp-record))
        ((= "RUS" r-r-p-last) (make-ru-pgp-record)))
  (princ
    (strcat "Edit acad.pgp file in directory: " (VL-STRING-TRANSLATE "\\" "/" r-r-p) "Support/acad.pgp"))
  (princ))

