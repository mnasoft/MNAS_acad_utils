;;;;;;("x" "����� ������� _.explode." "������������")
;;;; ������� ���������� ������ � SPDS.
;;;; Ÿ ���������� � ���������� SPDS ������.
;;;(defun c:x  (/ en)
;;;  (setq en (car (entsel "�������� ���������:")))
;;;  (command "_.pedit" en "_close" "")
;;;  (command "_.region" en "")
;;;  (setq en (entlast))
;;;  (command "_.explode" en "")
;;;  (princ))


;;;;;;("pur" "������� ���� �������������� ��������� �� ������ ������." "������������")
(defun c:pur () (command "_.purge" "_all" "*" "_no") (princ))

;;;;;;("ra" "����������� ���� ������� �������." "������������")
     ;(defun c:ra () (command "_.redrawall") (princ))

;;;;;;("rg" "����������� �������." "������������")
     ;(defun c:rg () (command "_.regen") (princ))

;;;;;;("rga" "����������� ���� ������� ������� � �������." "������������")
     ;(defun c:rga () (command "_.regenall") (princ))

;;;;;;("sk" "��������� �������� ��������� (����� ������)." "������������")
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

;;;;;;("tm" "���������|���������� ������ ��������� ������." "������������")
(defun c:tm  (/ n)
  (setq n (getvar "tilemode"))
  (cond ((= n 1) (setvar "tilemode" 0))
        ((= n 0) (setvar "tilemode" 1)))
  (princ))

;;;;;;("vs" "����� ������� _.vports, ����������� ������� ���������." "������������")
     ;(defun c:vs () (command "_.vports"))

;;;;;;("z" "����� ������� _.zoom, ����������� ���������� ������� ���������." "������������")
     ;(defun c:z () (command "_.zoom"))

;;;;;;("za"
;;;;;;"��������� ������� ��������� ����� �������,
;;;;;; ����� ���� ���������� ��� ����������������� ��������� ������� +
;;;;;; ������� ����������� �������� �������." "������������")
(defun c:za () (command "_.zoom" "_a"))

;;;;;;("zc" "��������� ������� ��������� �� ���������� ����� � ������." "������������")
(defun c:zc () (command "_.zoom" "_c"))

;;;;;;("zd" "��������� ������� ��������� ��� ������ ������������� ����." "������������")
(defun c:zd () (command "_.zoom" "_d"))

;;;;;;("ze"
;;;;;;"��������� ������� ��������� ����� �������,
;;;;;; ����� ���� ���������� ��� ����������������� ��������� �������." "������������")
(defun c:ze () (command "_.zoom" "_e"))

;;;;;;("zp" "�������� ���������� ������������ �������." "������������")
(defun c:zp () (command "_.zoom" "_p"))

;;;;;;("zv"
;;;;;;"��������� ������� ��������� ����� �������,
;;;;;; ����� ����� ������������ ������������ �������, �� ��������� �����������." "������������")
(defun c:zv () (command "_.zoom" "_v"))

;;;;;;("zw" "��������� ������� ���������, ������������ �����." "������������")
(defun c:zw () (command "_.zoom" "_w"))

;;;;;;("fr" "����� ������� _.fillet � ����������� ��������� ����� ��� ����� �������." "������������")
(defun c:fr () (command "_.fillet" "_r") (princ))

;;;;;;("f" "����� ������� _.fillet � ����������� ��������� ����� ��� ����� �������." "������������")
     ;(defun c:f () (command "_.fillet") (princ))

;;;;;;("chd" "����� ������� _.chamfer � ����������� ��������� ����� ��� ����� ����� �����." "������������")
(defun c:chd () (command "_.chamfer" "_d") (princ))

;;;;;;("ch" "����� ������� _.chamfer." "������������")
     ;(defun c:ch () (command "_.chamfer") (princ))

;;;;;;("s" "����� ������� _.stretch" "������������")
     ;(defun c:s () (command "_.stretch") (princ))

;;;;;;("l" "����� ������� _.line" "������������")
     ;(defun c:l () (command "_.line") (princ))

;;;;;;("a" "����� ������� _.arc" "������������")
     ;(defun c:a () (command "_.arc") (princ))

;;;;;;("o" "����� ������� _.offset" "������������")
     ;(defun c:o () (command "_.offset") (princ))

;;;;;;("c" "����� ������� _.circle" "������������")
     ;(defun c:c () (command "_.circle") (princ))

;;;;;;("e" "����� ������� _.erase" "������������")
     ;(defun c:e () (command "_.erase") (princ))

;;;;;;("co" "����� ������� _.copy" "������������")
     ;(defun c:co () (command "_.copy") (princ))

;;;;;;("cp" "����� ������� _.copy" "������������")
     ;(defun c:cp () (command "_.copy") (princ))

;;;;;;("m" "����� ������� _.move" "������������")
     ;(defun c:m () (command "_.move") (princ))

;;;;;;("ro" "����� ������� _.rotate" "������������")
     ;(defun c:ro () (command "_.rotate") (princ))

;;;;;;("tr" "����� ������� _.trim" "������������")
     ;(defun c:tr () (command "_.trim") (princ))

;;;;;;("ex" "����� ������� _.extend" "������������")
     ;(defun c:ex () (command "_.extend") (princ))

;;;;;;("rec" "����� ������� _.rectangle" "������������")
     ;(defun c:rec () (command "_.rectangle") (princ))

;;;;;;("mi" "����� ������� _.mirror" "������������")
     ;(defun c:mi () (command "_.mirror") (princ))

;;;;;;("el" "����� ������� _.ellipse" "������������")
     ;(defun c:el () (command "_.ellipse") (princ))

;;;;;;("br" "����� ������� _.break" "������������")
     ;(defun c:br () (command "_.break") (princ))

;;;;;;("u" "����� ������� _.u" "������������")
     ;(defun c:u () (command "_.u") (princ))

;;;;;;("undo" "����� ������� _.undo" "������������")
     ;(defun c:undo () (command "_.undo") (princ))

;;;;;;("sc" "����� ������� _.scale" "������������")
     ;(defun c:sc () (command "_.scale") (princ))

;;;;;;("oops" "����� ������� _.oops" "������������")
     ;(defun c:oops () (command "_.oops") (princ))

;;;;;;("di" "����� ������� _.dist" "������������")
     ;(defun c:di () (command "_.dist") (princ))

;;;;;;("id" "����� ������� _.id" "������������")
     ;(defun c:id () (command "_.id") (princ))

;;;;;;("ma" "����� ������� _.matchprop" "������������")
     ;(defun c:ma () (command "_.matchprop") (princ))

;;;;;;("le" "����� ������� _.qleader" "������������")
     ;(defun c:le () (command "_.qleader") (princ))

;;;;;;("op" "����� ������� _.options" "������������")
     ;(defun c:op () (command "_.options") (princ))

;;;;;;("h" "����� ������� _.bhatch" "������������")
     ;(defun c:h  (/ dist sc an)
     ;  (setq dist (getdist "������� ���������� ����� ������� ��������� ��� ����� �������� ��������:")
     ;        sc   (cond ((= (getvar "dimscale") 0.0) 1.0)
     ;                   (t (getvar "dimscale")))
     ;        an   (getangle "������� ���� ������� �������:"))
     ;  (command "_-hatch" "_p" "_u" (* (/ 180. pi) an) (* dist sc))
     ;  ;;(command "_.bhatch") (princ)
     ;  )

;;;(defun c:he (/ dist sc an)
;;;  (setq
;;;    dist (getdist "������� ���������� ����� ������� ��������� ��� ����� �������� ��������:")
;;;    sc	 (cond
;;;	   ((= (getvar "dimscale") 0.0) 1.0)
;;;	   ( t (getvar "dimscale"))
;;;	 )
;;;    an   (getangle "������� ���� ������� �������:")
;;;  )
;;;  (command "_-hatch" "_p" "_u" (* (/ 180. pi) an) (* dist sc))
;;;(command "_.bhatch") (princ)
;;;)

;;;;;;("dt" "����� ������� _.dtext" "������������")
;;(defun c:dt () (command "_.dtext") (princ))

;;;;;;("pe" "����� ������� _.pedit" "������������")
;;(defun c:pe () (command "_.pedit") (princ))

;;;;;;("bo" "����� ������� _.boundary" "������������")
;;(defun c:bo () (command "_.boundary") (princ))

;;;;;;("ar" "����� ������� _.array" "������������")
;;(defun c:ar () (command "_.array") (princ))

;;;;;;("li" "����� ������� _.list" "������������")
;;(defun c:li () (command "_.list") (princ))

;;;;;;("x" "����� ������� _.explode" "������������")
;;(defun c:x () (command "_.explode") (princ))

;;;;;;("xa" "��������� ����������� ����� ������" "������������")
(defun c:xa  (/ el ss)
  (entmake '((0 . "POINT") (10 0.0 0.0 0.0)))
  (setq el (entlast))
  (prompt "�������� ������� ��� ������� ������")
  (setq ss (ssget '((0 . "INSERT"))))
  (while (and ss (> (sslength ss) 0)) (explode-all ss) (setq ss (select-all-past-ename el)))
  (entdel el)
  (princ))

;;;;;;("j" "����� ������� _.join" "������������")
;;(defun c:j () (command "_.join") (princ))

;;;;;;("b" "����� ������� _.block" "������������")
;;(defun c:b () (command "_.block") (princ))

;;;;;;("ps" "����� ������� _.pspace" "������������")
;;(defun c:ps () (command "_.pspace") (princ))

;;;;;;("ms" "����� ������� _.mspace" "������������")
;;(defun c:ms () (command "_.mspace") (princ))

;;;;;;("git" "����� ������� D:\\home\\_namatv\\Git\\git-bash.bat" "������������")
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
;;;;;;"���������|���������� ������ ����� ��������
;;;;;; (��. ��������� ���������� pickstyle)." "������������")
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
  (setq plb (getpoint "����� ������ ����:")
        prt (getpoint "������ ������� ����:"))
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
       '((("QLEADER" "��������") ("LE" "��"))
	 (("HATCHEDIT" "��������") ("HE" "��"))
	 (("BHATCH" "�����") ("BH" "��"))
         (("REDRAW" "��������") ("RE" "��"))
	 (("REDRAWALL" "��������") ("REA" "���"))
	 (("REGEN" "�����") ("RG" "��"))
	 (("REGENALL" "��������") ("RGA" "���"))
	 (("VPORTS" "������") ("VS" "��"))
	 (("ZOOM" "��������") ("Z" "�"))
	 (("FILLET" "����������") ("F" "�"))
	 (("CHAMFER" "�����") ("CH" "��"))
	 (("STRETCH" "���������") ("S" "�"))
	 (("LINE" "�������") ("L" "�"))
	 (("ARC" "����") ("A" "�"))
	 (("OFFSET" "�������") ("O" "�"))
	 (("CIRCLE" "����") ("C" "�"))
	 (("ERASE" "�������") ("E" "�"))
	 (("COPY" "����������") ("CO" "CP" "��" "��"))
	 (("MOVE" "���������") ("M" "�"))
	 (("ROTATE" "���������") ("R" "�"))
	 (("TRIM" "��������") ("TR" "��"))
	 (("EXTEND" "��������") ("EX" "��"))
	 (("RECTANGLE" "�������") ("REC" "���"))
	 (("MIRROR" "�������") ("MI" "��"))
	 (("ELLIPSE" "������") ("EL" "��"))
	 (("BREAK" "���������") ("BR" "��"))
	 (("U" "�") ("U" "�"))
	 (("UNDO" "��������") ("UNDO" "����"))
	 (("SCALE" "�������") ("SC" "��"))
	 (("OOPS" "��") ("OOPS" "����"))
	 (("DIST" "����") ("DI" "��"))
	 (("ID" "�����") ("ID" "��"))
	 (("MATCHPROP" "������������") ("MA" "��"))
;;;;;;;;;;;;;;;;;;;;;;;
	 (("DTEXT" "������") ("dt" "��"))
	 (("PEDIT" "������") ("pe" "��"))
	 (("BOUNDARY" "������") ("bo" "��"))
	 (("ARRAY" "������") ("ar" "��"))
	 (("LIST" "������") ("li" "��"))
	 (("EXPLODE" "����������") ("x" "�"))
	 (("JOIN" "���������") ("j" "�"))
	 (("BLOCK" "����") ("b" "�"))
	 (("PSPACE" "����") ("ps" "��"))
	 (("MSPACE" "������") ("ms" "��"))))


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

