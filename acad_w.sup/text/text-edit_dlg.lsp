(setq *text-edit-dlg-reg_root* "HKEY_CURRENT_USER\\Software\\MNASoft\\Text")
(setq *text-edit-dlg-te_registry* '((dcl_te_pos (-1 -1))))
(setq *text-edit-dlg-str* "")
(setq *text-edit-dlg-dcl_te_pos* '(-1 -1))

;;;;;;("te"
;;;;;;"���������� �������������� ������� � ������� ��������� ����������." "������")
(defun c:te  (/ dcl_id en i ss_td)
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (reg_read_default_lst *text-edit-dlg-reg_root* *text-edit-dlg-te_registry*)
  (prompt "\n�������� ������ ��� ������� :")
  (setq ss_td  (ssget '((-4 . "<OR") (0 . "DIMENSION") (0 . "TEXT") (0 . "MTEXT") (-4 . "OR>")))
        dcl_id (load_dialog (findfile "acad_w.sup/text/text.dcl")))
  (if (null ss_td)
    (progn (alert "��� ��������� ��������.") (exit)))
  (if (< dcl_id 0)
    (exit))
  (if (not (new_dialog "chgtextt" dcl_id "" *text-edit-dlg-dcl_te_pos*))
    (exit))
  (setq *text-edit-dlg-str* (cdr (assoc 1 (entget (ssname ss_td 0)))))
  (set_tile "dim_string" *text-edit-dlg-str*)
  (action_tile "add-round-brackets" "(text-edit-dlg-ac-add-round-brackets)")
  (action_tile "add-big-round-brackets" "(text-edit-dlg-ac-add-big-round-brackets)")
  (action_tile "add-square-brackets" "(text-edit-dlg-ac-add-square-brackets)")
  (action_tile "add-big-square-brackets" "(text-edit-dlg-ac-add-big-square-brackets)")
  (action_tile "delete-round-brackets" "(text-edit-dlg-ac-delete-round-brackets)")
  (action_tile "delete-square-brackets" "(text-edit-dlg-ac-delete-square-brackets)")
  (action_tile "add-diameter-sign" "(text-edit-dlg-ac-add-diameter-sign)")
  (action_tile "delete-diameter-sign" "(text-edit-dlg-ac-delete-diameter-sign)")

  (action_tile "add-x45-degrees" "(text-edit-dlg-ac-add-x45-degrees)")
  (action_tile "delete-x45-degrees" "(text-edit-dlg-ac-delete-x45-degrees)")
  (action_tile "add-tolerance" "(text-edit-dlg-ac-add-tolerance)")
  
  (action_tile "accept" "(text-edit-dlg-accept)")
  (action_tile "info" "(text-edit-dlg-info)")
  (action_tile "help" "(text-edit-dlg-help)")
  (start_dialog)
  (unload_dialog dcl_id)
  (setq i (sslength ss_td))
  (while (>= (setq i (1- i)) 0) (setq en (ssname ss_td i)) (ch_dxf en 1 *text-edit-dlg-str*))
  (err-handle ""))

(defun text-edit-dlg-accept  ()
  (setq *text-edit-dlg-str* (get_tile "dim_string"))
  (setq *text-edit-dlg-dcl_te_pos* (done_dialog 0))
  (reg_write_default_lst *text-edit-dlg-reg_root* *text-edit-dlg-te_registry*))

(defun text-edit-dlg-info () (alert (strcat "�������������� ������ " (about-gpl-string))))

(defun text-edit-dlg-help () (help (strcat (acad_help) "/te/te.html")))

(defun text-edit-dlg-ac-add-round-brackets  (/ txt-str)
  (setq txt-str (get_tile "dim_string"))
  (cond ((or (= txt-str "") (= txt-str "<>")) (setq txt-str "(<>)"))
        (t (setq txt-str (strcat "(" txt-str ")"))))
  (set_tile "dim_string" txt-str))

(defun text-edit-dlg-ac-add-big-round-brackets  (/ txt-str)
  (setq txt-str (get_tile "dim_string"))
  (cond ((= txt-str "") (setq txt-str "{\\H2x(\\H0.5x}<>{\\H2x)\\H0.5x}"))
        ((= txt-str "<>") (setq txt-str "{\\H2x(\\H0.5x}<>{\\H2x)\\H0.5x}"))
        (t (setq txt-str (strcat "{\\H2x(\\H0.5x}" txt-str "{\\H2x)\\H0.5x}"))))
  (set_tile "dim_string" txt-str))

(defun text-edit-dlg-ac-add-square-brackets  (/ txt-str)
  (setq txt-str (get_tile "dim_string"))
  (cond ((or (= txt-str "") (= txt-str "<>")) (setq txt-str "[<>]"))
        (t (setq txt-str (strcat "[" txt-str "]"))))
  (set_tile "dim_string" txt-str))

(defun text-edit-dlg-ac-add-big-square-brackets  (/ txt-str)
  (setq txt-str (get_tile "dim_string"))
  (cond ((or (= txt-str "") (= txt-str "<>")) (setq txt-str "{\\H2x[\\H0.5x}<>{\\H2x]\\H0.5x}"))
        (t (setq txt-str (strcat "{\\H2x[\\H0.5x}" txt-str "{\\H2x]\\H0.5x}"))))
  (set_tile "dim_string" txt-str))


(defun text-edit-dlg-ac-delete-round-brackets  (/ txt-str sk_close sk_open str_1 str_2 str_3)
  (setq txt-str (get_tile "dim_string"))
  (setq sk_open  (vl-string-position (ascii "(") txt-str)
        sk_close (vl-string-position (ascii ")") txt-str nil t))
  (if (and (and sk_open sk_close) (< sk_open sk_close))
    (setq str_1   (substr txt-str 1 sk_open)
          str_2   (substr txt-str (+ 2 sk_open) (- sk_close sk_open 1))
          str_3   (substr txt-str (+ 2 sk_close))
          txt-str (strcat str_1 str_2 str_3)))
  (setq txt-str (string-subst-all "" "{\\H2x\\H0.5x}" txt-str))
  (setq txt-str (strcat "\\A1;" (string-subst-all "" "\\A1;" txt-str)))
  (set_tile "dim_string" txt-str))

(defun text-edit-dlg-ac-delete-square-brackets  (/ txt-str sk_close sk_open str_1 str_2 str_3)
  (setq txt-str (get_tile "dim_string"))
  (setq sk_open  (vl-string-position (ascii "[") txt-str)
        sk_close (vl-string-position (ascii "]") txt-str nil t))
  (if (and (and sk_open sk_close) (< sk_open sk_close))
    (setq str_1   (substr txt-str 1 sk_open)
          str_2   (substr txt-str (+ 2 sk_open) (- sk_close sk_open 1))
          str_3   (substr txt-str (+ 2 sk_close))
          txt-str (strcat str_1 str_2 str_3)))
  (setq txt-str (string-subst-all "" "{\\H2x\\H0.5x}" txt-str))
  (setq txt-str (strcat "\\A1;" (string-subst-all "" "\\A1;" txt-str)))
  (set_tile "dim_string" txt-str))

(defun text-edit-dlg-ac-add-diameter-sign  (/ txt-str)
  (setq txt-str (get_tile "dim_string"))
  (cond ((or (= txt-str "") (= txt-str "<>")) (setq txt-str "%%C<>"))
        (t (setq txt-str (vl-string-subst "%%C<>" "<>" txt-str))))
  (set_tile "dim_string" txt-str))

(defun text-edit-dlg-ac-delete-diameter-sign  (/ txt-str)
  (setq txt-str (get_tile "dim_string"))
  (cond ((= txt-str "%%C<>") (setq txt-str ""))
        (t (setq txt-str (vl-string-subst "<>" "%%C<>" txt-str))))
  (set_tile "dim_string" txt-str))

(defun text-edit-dlg-ac-add-x45-degrees  (/ txt-str)
  (setq txt-str (get_tile "dim_string"))
  (cond ((= txt-str "") (setq txt-str "<>&L45%%d"))
        ((= txt-str "<>") (setq txt-str "<>&L45%%d"))
        (t (setq txt-str (strcat txt-str "&L45%%d"))))
  (set_tile "dim_string" txt-str))


(defun text-edit-dlg-ac-delete-x45-degrees  (/ txt-str)
  (setq txt-str (get_tile "dim_string"))
  (cond ((= txt-str "<>&L45%%d") (setq txt-str ""))
        (t (setq txt-str (vl-string-subst "<>" "<>&L45%%d" txt-str))))
  (set_tile "dim_string" txt-str))

(defun text-edit-dlg-ac-add-tolerance  (/ txt-str)
  (setq txt-str (get_tile "dim_string"))
  (cond ((or (= txt-str "") (= txt-str "<>")) (setq txt-str "\\A1;<>{\\H0.725x;\\S+0.03^-0.06;}"))
        (t (setq txt-str (strcat "\\A1;" txt-str "{\\H0.725x;\\S+0.025^-0.001;}"))))
  (set_tile "dim_string" txt-str))