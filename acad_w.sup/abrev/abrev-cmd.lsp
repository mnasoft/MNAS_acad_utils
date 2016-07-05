;;;;;;("pur" "������� ���� �������������� ��������� �� ������ ������." "������������")
(defun c:pur () (command "_.purge" "_all" "*" "_no") (princ))

;;;;;;("ra" "����������� ���� ������� �������." "������������")
(defun c:ra () (command "_.redrawall") (princ))

;;;;;;("rg" "����������� �������." "������������")
(defun c:rg () (command "_.regen") (princ))

;;;;;;("rga" "����������� ���� ������� ������� � �������." "������������")
(defun c:rga () (command "_.regenall") (princ))

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
(defun c:vs () (command "_.vports"))

;;;;;;("z" "����� ������� _.zoom, ����������� ���������� ������� ���������." "������������")
(defun c:z () (command "_.zoom"))

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
(defun c:f () (command "_.fillet") (princ))

;;;;;;("chd" "����� ������� _.chamfer � ����������� ��������� ����� ��� ����� ����� �����." "������������")
(defun c:chd () (command "_.chamfer" "_d") (princ))

;;;;;;("ch" "����� ������� _.chamfer." "������������")
(defun c:ch () (command "_.chamfer") (princ))

;;;;;;("s" "����� ������� _.stretch" "������������")
(defun c:s () (command "_.stretch") (princ))

;;;;;;("l" "����� ������� _.line" "������������")
(defun c:l () (command "_.line") (princ))

;;;;;;("a" "����� ������� _.arc" "������������")
(defun c:a () (command "_.arc") (princ))

;;;;;;("o" "����� ������� _.offset" "������������")
(defun c:o () (command "_.offset") (princ))

;;;;;;("c" "����� ������� _.circle" "������������")
(defun c:c () (command "_.circle") (princ))

;;;;;;("e" "����� ������� _.erase" "������������")
(defun c:e () (command "_.erase") (princ))

;;;;;;("co" "����� ������� _.copy" "������������")
(defun c:co () (command "_.copy") (princ))

;;;;;;("cp" "����� ������� _.copy" "������������")
(defun c:cp () (command "_.copy") (princ))

;;;;;;("m" "����� ������� _.move" "������������")
(defun c:m () (command "_.move") (princ))

;;;;;;("ro" "����� ������� _.rotate" "������������")
(defun c:ro () (command "_.rotate") (princ))

;;;;;;("tr" "����� ������� _.trim" "������������")
(defun c:tr () (command "_.trim") (princ))

;;;;;;("ex" "����� ������� _.extend" "������������")
(defun c:ex () (command "_.extend") (princ))

;;;;;;("rec" "����� ������� _.rectangle" "������������")
(defun c:rec () (command "_.rectangle") (princ))

;;;;;;("mi" "����� ������� _.mirror" "������������")
(defun c:mi () (command "_.mirror") (princ))

;;;;;;("el" "����� ������� _.ellipse" "������������")
(defun c:el () (command "_.ellipse") (princ))

;;;;;;("br" "����� ������� _.break" "������������")
(defun c:br () (command "_.break") (princ))

;;;;;;("u" "����� ������� _.u" "������������")
(defun c:u () (command "_.u") (princ))

;;;;;;("undo" "����� ������� _.undo" "������������")
(defun c:undo () (command "_.undo") (princ))

;;;;;;("sc" "����� ������� _.scale" "������������")
(defun c:sc () (command "_.scale") (princ))

;;;;;;("oops" "����� ������� _.oops" "������������")
(defun c:oops () (command "_.oops") (princ))

;;;;;;("di" "����� ������� _.dist" "������������")
(defun c:di () (command "_.dist") (princ))

;;;;;;("id" "����� ������� _.id" "������������")
(defun c:id () (command "_.id") (princ))

;;;;;;("ma" "����� ������� _.matchprop" "������������")
(defun c:ma () (command "_.matchprop") (princ))

;;;;;;("le" "����� ������� _.qleader" "������������")
(defun c:le () (command "_.qleader") (princ))

;;;;;;("op" "����� ������� _.options" "������������")
(defun c:op () (command "_.options") (princ))

;;;;;;("h" "����� ������� _.bhatch" "������������")
(defun c:h  (/ dist sc an)
  (setq dist (getdist "������� ���������� ����� ������� ��������� ��� ����� �������� ��������:")
        sc   (cond ((= (getvar "dimscale") 0.0) 1.0)
                   (t (getvar "dimscale")))
        an   (getangle "������� ���� ������� �������:"))
  (command "_-hatch" "_p" "_u" (* (/ 180. pi) an) (* dist sc))
  ;;(command "_.bhatch") (princ)
  )

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
;;;  ;;(command "_.bhatch") (princ)
;;;)

;;;;;;("dt" "����� ������� _.dtext" "������������")
(defun c:dt () (command "_.dtext") (princ))

;;;;;;("pe" "����� ������� _.pedit" "������������")
(defun c:pe () (command "_.pedit") (princ))

;;;;;;("bo" "����� ������� _.boundary" "������������")
(defun c:bo () (command "_.boundary") (princ))

;;;;;;("ar" "����� ������� _.array" "������������")
(defun c:ar () (command "_.array") (princ))

;;;;;;("li" "����� ������� _.list" "������������")
(defun c:li () (command "_.list") (princ))

;;;;;;("x" "����� ������� _.explode" "������������")
(defun c:x () (command "_.explode") (princ))

;;;;;;("xa" "u����� ������� _.explode" "������������")
(defun c:xa  (/ el ss)
  (entmake '((0 . "POINT") (10 0.0 0.0 0.0)))
  (setq el (entlast))
  (prompt "�������� ������� ��� ������� ������")
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




;;;;;;("j" "����� ������� _.join" "������������")
(defun c:j () (command "_.join") (princ))

;;;;;;("b" "����� ������� _.block" "������������")
(defun c:b () (command "_.block") (princ))

;;;;;;("ps" "����� ������� _.pspace" "������������")
(defun c:ps () (command "_.pspace") (princ))

;;;;;;("ms" "����� ������� _.mspace" "������������")
(defun c:ms () (command "_.mspace") (princ))

;;;;;;("git" "����� ������� D:\\home\\_namatv\\Git\\git-bash.bat" "������������")
(defun c:git () (command "shell" "D:\\home\\_namatv\\Git\\git-bash.bat"))

(defun c:vl () (command "_-VPORTS" "_L" "_ON"))

(defun c:vu () (command "_-VPORTS" "_L" "_OFF"))


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
