;;;c_epr()	- ��������� ������ ��� ������� ���������� ����� � ��������.
;;;		���������������� ���������� �� �����.
;;;(epr '((70 . 2)
;;;       ("����" (2 . "") (40 . 1.0) (41 . 1.0) (6 . "������") (8 . "0") (62 . 256))
;;;       ("�����" (40 . 1.0) (6 . "������") (8 . "0") (62 . 256))
;;;      )
;;;)

(defun epr-init  ()
  (setq fl    (cdr (assoc 70 param))
        d-bl  (cdr (assoc "����" param))
        d-lin (cdr (assoc "�����" param)))
  (princ d-lin))

(defun epr-setup  ()
  (if (= (logand fl 2) 2)
    (set_tile "t82" "1"))
  (if (= (logand fl 1) 1)
    (set_tile "t81" "1")))

(defun epr-ac_t81-82  ()
  (setq fl (+ (atoi (get_tile "t81")) (* (atoi (get_tile "t82")) 2)))
  (princ fl))

(defun epr-ac_tile  ()
  (action_tile "b81" "(eb d-bl)")
  (action_tile "b82" "(ep d-lin)")
  (action_tile "t81" "(epr-ac_t81-82)")
  (action_tile "t82" "(epr-ac_t81-82)"))

(defun epr  (epr-param / epr-dcl_id epr-do_dialog fl d-bl d-lin act)
  (epr-init)
  (setq epr-dcl_id (load_dialog (findfile "acad_w.sup/axis/axis.dcl")))
  (if (< epr-dcl_id 0)
    (exit))
  (setq epr-do_dialog t)
  (while epr-do_dialog
    (if (not (new_dialog "eprop" epr-dcl_id))
      (exit))
    (epr-setup)
    (epr-ac_tile)
    (setq act (start_dialog))
    (cond ((= act 0) (setq epr-do_dialog nil))
          ((= act 1) (setq epr-do_dialog nil))))
  (unload_dialog epr-dcl_id)
  epr-param)

;;;; (setq fl 0) (epr '((70 . 2) ("����" (2 . "") (40 . 1.0) (41 . 1.0) (6 . "������") (8 . "0") (62 . 256)) ("�����" (40 . 1.0) (6 . "������") (8 . "0") (62 . 256))))