(vl-load-com)

;;;;;;("ins_blk" "������� ����� � ��������� ������ �������� ��������." "�������")
(defun c:ins_blk  (/ p0 a-p1 dir_0 name sc)
  (setq p0 (getpoint "\n����� ������� �����:"))
  (setq a-p1 (getpoint p0 "\n���� �������� :"))
  (setq dir_0 (angle p0 a-p1))
  (setq name (getstring "\n��� �����:"))
  (setq sc (getvar "dimscale"))
  (ins_block p0 name sc dir_0))

;;;;;;("bas" "����������� ���." "�������")
(defun c:bas  (/ ort os sc a-p1 p2 r a1 p01 p02 p03 str old_err tst v_line v_polygon pnt_int v_dimtxt)
  (setq old_err *error*
        *error* bas:n_err)
  (command "_.undo" "_begin")
  (setq tst      (getvar "dimtxsty")
        ort      (getvar "orthomode")
        os       (getvar "osmode")
        sc       (getvar "dimscale")
        v_dimtxt (getvar "dimtxt"))
  (if (= sc 0)
    (setq sc (getreal "\nEnter dimension scale:")))
  (command "_.osnap" "_end,_int")
  (command "_.ortho" "_off")
  (setq a-p1 (getpoint "\nPoint of basa:"))
  (setq p2 (getpoint a-p1 "\nCenter of rect:"))
  (setq r (* sc v_dimtxt))
  (setq a1 (angle a-p1 p2))
  (setq p01 (polar a-p1 (+ a1 (dtr 90.)) (* sc 2.5)))
  (setq p02 (polar p01 (- a1 (dtr 90.)) (* sc 5.)))
  (setq p03 (polar p01 (- a1 (dtr 30.)) (* sc 5.)))
  (command "_.solid" "_non" p01 "_non" p02 "_non" p03 "" "")
  (command "_.line" "_non" a-p1 "_non" p2 "")
  (setq v_line (vlax-ename->vla-object (entlast)))
  (command "_.polygon" "4" p2 "_c" r)
  (setq v_polygon (vlax-ename->vla-object (entlast)))
  (setq pnt_int (vlax-safearray->list
                  (vlax-variant-value (vlax-invoke-method v_line 'IntersectWith v_polygon acExtendNone))))
  (vlax-put-property v_line 'EndPoint (vlax-3D-point pnt_int))
;;;  (setq str (getstring 1 "\n������� ����� ���� :"))
  (setq str (index:string))
  (index:add)
;;;  (setvar "textstyle" "t")
  (command "_.text" "_s" tst "_j" "_mc" "_non" p2 r "0" str)
  (vlax-put-property (vlax-ename->vla-object (entlast)) "Color" 1)
  (bas:n_err ""))

(defun bas:n_err  (msg)
  (setvar "textstyle" tst)
  (setvar "orthomode" ort)
  (setq *error* old_err)
  (command "_.undo" "_end")
  (princ))

(setq *poz-getvar-lst*      '("orthomode" "osmode" "dimscale" "cecolor"))
(setq *poz-getvar-value-lst* nil)

;;;;;;("poz" "����������� �������, ����������� ���� ���������, ����������, ����������� �����." "�������")
(defun c:poz  (/ color_curr ort os sc key1 key2 key3 key4 key5 a-p1 p2 p3 a1 a2 h p01 w p02 p03 p04 r p05 a3 old_err pi/2)
  (setq pi/2 (/ pi 2.0))
  (command "_.undo" "_begin")
  (setq old_err    *error*
        *error*    poz:n_err
        ort        (getvar "orthomode")
        os         (getvar "osmode")
        sc         (getvar "dimscale")
        color_curr (getvar "cecolor"))
  (if (= sc 0)
    (setq sc (getreal "\nEnter dimension scale:")))
  (progn (initget "STrelka SVarka SSVarka POint Nothing")
         (setq key1 (getkword "\nSTrelka/SVarka/SSVarka/POint/<Nothing>:")))
  (progn (initget "Kontur Nothing") (setq key2 (getkword "\nKontur/<Nothing>:")))
  (progn (initget "Montaz Nothing") (setq key3 (getkword "\nMontaz/<Nothing>:")))
  (progn (initget "Kley Pajka Nothing") (setq key4 (getkword "\nKley/Pajka/<Nothing>:")))
  (progn (initget "Nothing Circle KLejmo Polka")
         (setq key5 (getkword "\nNothing/Circle/KLejmo/<Polka>:"))
         (if (= key5 nil)
           (setq key5 "Polka")))
;;;  (command "_.osnap" "_non")
  (setq a-p1 (getpoint "\n������ �������:"))
  (command "_.ortho" "_off")
;;;  (command "_.osnap" "_end")
  (setq p2 (getpoint a-p1 "\nStart point of polka:"))
  (command "_.ortho" "_on")
  (setq p3 (getpoint p2 "\nDirection of polka:"))
  (setq a1 (angle a-p1 p2))
  (setq a2 (+ pi a1))
  (setq h (* 0.5 sc))
  (command "_.line" "_non" a-p1 "_non" p2 "")
  (cond ((= key1 "STrelka")
         (setq p01 (polar a-p1 a1 (* sc 5.)))
         (setq w (* sc 0.75))
         (command "_.pline" "_non" a-p1 "_h" "0" w "_non" p01 ""))
        ((= key1 "SVarka")
         (setq p01 (polar a-p1 a1 (* sc 5.)))
         (setq p02 (polar p01 (+ a1 1.4) (* sc 0.75)))
         (command "_.solid" "_non" a-p1 "_non" p01 "_non" p02 "" ""))
        ((= key1 "SSVarka")
         (setq p01 (polar a-p1 a1 (* sc 5.)))
         (setq p02 (polar p01 (- a1 1.4) (* sc 0.75)))
         (command "_.solid" "_non" a-p1 "_non" p01 "_non" p02 "" ""))
        ((= key1 "POint")
         (setq p01 (polar a-p1 a1 (* sc 0.5)))
         (setq p02 (polar a-p1 (+ a1 pi/2) (* sc 0.5)))
         (setq p03 (polar a-p1 (+ a1 pi) (* sc 0.5)))
         (setq p04 (polar a-p1 (- a1 pi/2) (* sc 0.5)))
         (command "_.solid" "_non" p01 "_non" p02 "_non" p04 "_non" p03 "")))
  (cond ((= key2 "Kontur") (setq r (* sc 2.)) (command "_.circle" "_non" p2 r)))
  (cond ((= key3 "Montaz")
         (setq p01 (polar p2 pi/2 (* sc 10.)))
         (setq p02 (polar p01 pi (* sc 5.)))
         (command "_.pline" "_non" p2 "_h" "0" "0" "_non" p01 "_non" p02 "")))
  (cond ((= key4 "Kley")
         (setq p01 (polar a-p1 a1 (/ (distance a-p1 p2) 2.)))
         (setq p02 (polar p01 (+ a1 pi/2) (* sc 5.)))
         (setq p03 (polar p01 (- a1 pi/2) (* sc 5.)))
         (setq p04 (polar p02 a1 (* sc 5.)))
         (setq p05 (polar p03 a1 (* sc 5.)))
         (command "_.pline" "_non" p04 "_h" "0" "0" "_non" p01 "_non" p05 "")
         (command "_.pline" "_non" p02 "_h" "0" "0" "_non" p03 "")))
  (cond ((= key4 "Pajka")
         (setq p01 (polar a-p1 a1 (/ (distance a-p1 p2) 2.)))
         (setq p02 (polar p01 (+ a1 0.785398175) (* sc 5. 1.41)))
         (setq p03 (polar p01 (- a1 0.785398175) (* sc 5. 1.41)))
         (command "_.arc" "_non" p02 "_non" p01 "_non" p03)))
  (cond ((= key5 "Polka") (command "_.line" "_non" p2 "_non" p3 ""))
        ((= key5 "Circle")
         (setq r (* sc 6.))
         (setvar "cecolor" "1")
         (command "_.circle" "_non" p2 r)
         (command "_.trim" "_l" "" p2 "")
         (setvar "cecolor" color_curr))
        ((= key5 "KLejmo")
         (setq r (* sc 14.1))
         (setq a3 (angle p2 p3))
         (setq p01 (polar p2 a3 r))
         (if (= 0. a3)
           (setq p02 (polar p2 (+ a3 1.0471975667) r))
           (setq p02 (polar p2 (- a3 1.0471975667) r)))
         (setvar "cecolor" "1")
         (command "_.line" "_non" p2 "_non" p01 "_non" p02 "_non" p2 "")
         (setvar "cecolor" color_curr)))
  (poz:n_err ""))

(defun poz:n_err  (msg)
  (setvar "orthomode" ort)
  (setvar "osmode" os)
  (setvar "dimscale" sc)
  (setvar "cecolor" color_curr)
  (setq *error* old_err)
  (command "_.undo" "_end")
  (princ))


;;;;;;("up"
;;;;;;"����������� ����� ��� ��������� ������.\n
;;;;;;1) �������� ����� ����������� �������� ���� �����.\n
;;;;;;2) ������������ ����� �� ��������� ���������� ��� ���� ������.\n
;;;;;;����������:\n
;;;;;;1) ����� ������� � ���������� ����.\n
;;;;;;2) ������ ��������� ������������ ������.\n
;;;;;;2.1) ���������� �� �����.\n
;;;;;;2.2) ������������� ������������ ��������� �����."
;;;;;;"�������")

(defun c:up  (/ ts ort os v_dimscale h a-p1 p2 p01 p02 str old_err v_dimtxt v_dimtxsty)
  (setq old_err    *error*
        *error*    up:n_err
        ort        (getvar "orthomode")
        os         (getvar "osmode")
        v_dimscale (getvar "dimscale")
        v_dimtxt   (getvar "dimtxt")
        v_dimtxsty (getvar "dimtxsty"))
  (if (= v_dimscale 0)
    (setq v_dimscale (getreal "\n������� ��������:")))
  (command "_.undo" "_begin")
  (setvar "osmode" 512)
  (setvar "orthomode" 0)
  (setq h   (* (getreal "\n�������:") v_dimscale v_dimtxt)
        a-p1  (getpoint "\n��������� �����:")
        p2  (getpoint a-p1 "\n�������� �����:")
        p01 (polar a-p1 (+ (angle a-p1 p2) (/ pi 2.)) (/ h 2.))
        p02 (polar p01 (angle a-p1 p2) 10.)
        str (getstring 1 "\n������� ����� :"))
  (command "_.text" "_s" v_dimtxsty "_non" p01 h "_non" p02 str)
  (up:n_err ""))

(defun up:n_err  (msg)
  (setvar "orthomode" ort)
  (setvar "osmode" os)
  (setq *error* old_err)
  (command "_.undo" "_end")
  (princ))

;;;;;;("bot" "����������� ������ ��� ������." "�������")
(defun c:bot  (/ ts ort os v_dimscale h a-p1 p2 p01 p02 str old_err)
  (setq old_err    *error*
        *error*    up:n_err
        ort        (getvar "orthomode")
        os         (getvar "osmode")
        v_dimscale (getvar "dimscale")
        v_dimtxt   (getvar "dimtxt")
        v_dimtxsty (getvar "dimtxsty"))
  (if (= v_dimscale 0)
    (setq v_dimscale (getreal "\n������� ��������:")))
  (command "_.undo" "_begin")
  (setvar "osmode" 512)
  (setvar "orthomode" 0)
  (setq h   (* (getreal "\n�������:") v_dimscale v_dimtxt)
        a-p1  (getpoint "\n��������� �����:")
        p2  (getpoint a-p1 "\n���� ��������:")
        p01 (polar a-p1 (+ (angle a-p1 p2) (/ pi -2.)) (* h 1.5))
        p02 (polar p01 (angle a-p1 p2) 10.)
        str (getstring 1 "\n������� ����� :"))
  (command "_.text" "_s" v_dimtxsty "_non" p01 h "_non" p02 str)
  (up:n_err ""))


;;;;;;("d_up" "���������� ������� �������� �� ��������� ������, � ������� ��� ���� �������." "�������")
(defun c:d_up  (/ d_l st sub old_err)
  (setq old_err *error*
        *error* d_up:n_err)
  (setq d_l (ssget '((0 . "DIMENSION"))))
  (while (< 0 (sslength d_l))
    (setq st (get_dxf (ssname d_l 0) 3))
    (setq sub (get_ss_list d_l st 3))
    (command "_.dim" "_restore" st "_up" sub "" "_exit")
    (setq d_l (subst_ss d_l sub)))
  (d_up:n_err ""))

(defun d_up:n_err (msg) (setq *error* old_err) (princ))
