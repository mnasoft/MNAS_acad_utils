;;move_rot(li p0 p2)
(defun move_rot	 (ss p0 p2)
  (command "_.move" ss "" "_non" p0 "_non" p2)
  (command "_.redraw")
  (command "_.rotate" ss "" "_non" p2))

;;;;;;("mr" "����������� � �������." "������")
(defun c:mr  (/ ss p0 p2 ang)
  (princ "\n����������� � ���������:")
  (setq ss (ssget))
  (setq p0 (getpoint "\n������� �����:"))
  (setq p2 (getpoint p0 "\n����� ���������:"))
  (move_rot ss p0 p2))

;;;;;;("mcp" "����������� � �����������." "������")
(defun c:mcp  (/ ss p0 p2 ang n_li la_st)
  (setq la_st (entlast))
  (prompt "\n�������� � �������")
  (setq ss (ssget))
  (command "_.copy" ss "" "0,0" "0,0")
  (setq n_li (ssadd))
  (while (/= (setq la_st (entnext la_st)) nil) (ssadd la_st n_li))
  (setq p0 (getpoint "\n������� �����:"))
  (setq p2 (getpoint p0 "\n����� ��������� ������� �����:"))
  (move_rot n_li p0 p2))

;;;;;;("off"
;;;;;;"������� offset � ���������� ����, ����� � ���� ����� �������� � �������." "������")
(defun c:off  (/ li la_st d)
  (setq	ofd_old_err *error*
	*error*	ofd_new_err)
  (while T
    (setq d (getdist "\n������� ���������� :"))
    (cond ((null d) (exit)))
    (setq la_st (entlast))
    (command "_.offset" d)
    (while (= 1 (getvar "CMDACTIVE")) (command pause))
    (command "_.chprop"
	     (ss_from_to_last la_st)
	     ""
	     "_la"
	     (getvar "clayer")
	     "_lt"
	     (getvar "celtype")
	     "_c"
	     (getvar "cecolor")
	     "")))


(defun ofd_new_err  (msg)
  (if (/= "Function cancelled" msg)
    (print msg))
  (setq *error* ofd_old_err)
  (princ))

(defun ss_from_to_last	(from_ename / li tmp)
  (setq li (ssadd))
  (while (setq tmp	  (entnext from_ename)
	       from_ename tmp)
    (ssadd from_ename li))
  li)

;;;;;;("ofd"
;;;;;;"������� offset � ���������� ������� �������� � ������� � ������ ����������� ��������." "������")
(defun c:ofd  (/ la_st d)
  (setq	ofd_old_err *error*
	*error*	ofd_new_err)
  (while T
    (setq d (getdist "\n������� ���������� :"))
    (cond ((null d) (exit)))
    (setq la_st (entlast))
    (setq d (/ d 2.))
    (command "_.offset" d)
    (while (= 1 (getvar "CMDACTIVE")) (command pause))
    (command "_.chprop"
	     (ss_from_to_last la_st)
	     ""
	     "_la"
	     (getvar "clayer")
	     "_lt"
	     (getvar "celtype")
	     "_c"
	     (getvar "cecolor")
	     "")))

;;;;;;("cr" "������������� ������� � ������������ ������ �����." "������")
(defun c:cr  (/ a1 a2 a3 ss1 ss2 en1 en2 p1 p2 p3 i j)
  (princ "\n�������� ��������� ��� �������� :")
  (setq i (sslength (setq ss1 (ssget))))
  (setq p1 (getpoint "\n������� ������� ����� :"))
  (if (setq p2 (getpoint p1 "\n��������� ���� :"))
    (setq a1 (angle p1 p2))
    (setq a1 0.0))
  (while T
    (if	(not (setq a2 (getorient p1 "\n��������� ���� :")))
      (setq a2 0.0))
    (if	(not (setq a3 (getorient p1 "\n���������� ����:")))
      (setq a3 0.0))
    (setq en1 (entlast))
    (command "_.copy" ss1 "" "_non" p1 "_non" p1)
    (setq ss2 (ssadd))
    (command "_rotate"
	     (while (setq en1 (entnext en1)) (setq ss2 (ssadd en1 ss2)))
	     ""
	     "_non"
	     p1
	     (/ (* 180. (- (+ a3 a2) a1)) pi))
    (setq j i)
    (while (> j 0) (redraw (ssname ss1 (setq j (1- j))) 1))))
