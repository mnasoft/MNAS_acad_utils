(vl-load-com)

;;;f;;; ("v3d->list" "��������� �������������� vla3d ����� � ������ � ���������.")

(defun v3d->list (v3d) (vlax-safearray->list (vlax-variant-value v3d)))

;;;f;;; ("is-collinear"
;;;f;;; "��������� �������� ���� �������� �� ��������������.
;;;f;;; ����������:
;;;f;;; T - ������� �����������;
;;;f;;; nil - ������� �� �����������.
;;;f;;; ���������:
;;;f;;; v_line_1 - Vla ������, ������������� ������ �������;
;;;f;;; v_line_2 - Vla ������, ������������� ������ �������;
;;;f;;; delta - ��������, ���������� �� ����� �� ������� ��� ������� ������� ��������� �������������.
;;;f;;; ������ �������������:
;;;f;;; (vl-load-com)
;;;f;;; (entmake '((0 . \"LINE\") (10 0.0 0.0 0.0) (11 10.0 10.0 0.0)))
;;;f;;; (setq vl1 (vlax-ename->vla-object(entlast)))
;;;f;;; (entmake '((0 . \"LINE\") (10 20.0 20.0 0.0) (11 30.0 30.0 0.0)))
;;;f;;; (setq vl2 (vlax-ename->vla-object(entlast)))
;;;f;;; (entmake '((0 . \"LINE\") (10 25.0 20.0 0.0) (11 35.0 30.0 0.0)))
;;;f;;; (setq vl3 (vlax-ename->vla-object(entlast)))
;;;f;;; (is-collinear vl1 vl2 0.0001)
;;;f;;; (is-collinear vl1 vl3 0.0001)
;;;f;;; ")

(defun is-collinear  (v_line_1          ; Vla ������, ������������� ������ �������
                      v_line_2          ; Vla ������, ������������� ������ �������
                      delta             ; ��������, ���������� ��� ������� ������� ��������� �������������
                      / v_tmp)
  (if (< (vlax-get-property v_line_1 'length) (vlax-get-property v_line_2 'length))
    (setq v_tmp    v_line_1
          v_line_1 v_line_2
          v_line_2 v_tmp))
  (setq sp (v3d->list (vlax-get-property v_line_2 'startpoint))
        ep (v3d->list (vlax-get-property v_line_2 'endpoint)))
  (and (< (distance sp (vlax-curve-getclosestpointto v_line_1 sp t)) delta)
       (< (distance ep (vlax-curve-getclosestpointto v_line_1 ep t)) delta)))


(defun is-pnt-on-line  (pnt v_line delta)
  (< (distance pnt (vlax-curve-getclosestpointto v_line pnt nil)) delta))

(defun dist-from-pnt-to-curve  (pnt v_curve ext)
  (distance pnt (vlax-curve-getclosestpointto vname pnt ext)))

;;;f;;; (
;;;f;;; "concatenate_two_lines"
;;;f;;; "
;;;f;;; ��������� ����������� ���� ��������.
;;;f;;; ���������� ������ �� ��������� ��������.
;;;f;;; ���������.
;;;f;;; v_line_1 - Vla ������, �������������� ������ �������
;;;f;;; v_line_2 - Vla ������, �������������� ������ �������
;;;f;;; delta - ��������, ������������ ���������� ����� ������ � �������� ��� ������� ��� ��������� ������������
;;;f;;; filter
;;;f;;; "
;;;f;;; )

(defun concatenate_two_lines  (v_line_1 ; Vla ������, �������������� ������ �������
                               v_line_2 ; Vla ������, �������������� ������ �������
                               delta    ; ��������, ������������ ���������� ����� ������ � �������� ��� ������� ��� ��������� ������������
                               filter / ;
                               lns_clnr ; ������� �������������� ��������
                               vl1s     ; ������ ��������� ��������� ����� ������� �������
                               vl1e     ; ������ ��������� �������� ����� ������� �������
                               vl2s     ; ������ ��������� ��������� ����� ������� �������
                               vl2e     ; ������ ��������� �������� ����� ������� �������
                               vl1e_on_vl2 ; �������� ����� ������� ������� ����� �� ������ �������
                               vl1s_on_vl2 ; ��������� ����� ������� ������� ����� �� ������ �������
                               vl2e_on_vl1 ; �������� ����� ������� ������� ����� �� ������ �������
                               vl2s_on_vl1 ; ��������� ����� ������� ������� ����� �� ������ �������
                               fltrd    ;
) (setq lns_clnr    (is-collinear v_line_1 v_line_2 delta)
        vl1s        (v3d->list (vlax-get-property v_line_1 'startpoint))
        vl1e        (v3d->list (vlax-get-property v_line_1 'endpoint))
        vl2s        (v3d->list (vlax-get-property v_line_2 'startpoint))
        vl2e        (v3d->list (vlax-get-property v_line_2 'endpoint))
        vl2s_on_vl1 (is-pnt-on-line vl2s v_line_1 delta)
        vl2e_on_vl1 (is-pnt-on-line vl2e v_line_1 delta)
        vl1s_on_vl2 (is-pnt-on-line vl1s v_line_2 delta)
        vl1e_on_vl2 (is-pnt-on-line vl1e v_line_2 delta)
        fltrd       (not (is-prop-lst-same v_line_1 v_line_2 filter)))
  (cond ;;��� �������������� ��������
        ((not lns_clnr) nil)
        ;; ������ �� ��������� ��������
        (fltrd nil)
        ;; ������ ������� ��������� ����� �� ������ �������
        ((and vl1s_on_vl2 vl1e_on_vl2) (vlax-invoke-method v_line_1 'delete) (list v_line_1))
        ;; ������ ������� ��������� ����� �� ������ �������
        ((and vl2s_on_vl1 vl2e_on_vl1) (vlax-invoke-method v_line_2 'delete) (list v_line_2))
        ;; �������� ����� ������� ������� ����� �� ������ �������
        ;; �
        ;; �������� ����� ������� ������� ����� �� ������ �������
        ((and (null vl2s_on_vl1) vl2e_on_vl1 (null vl1s_on_vl2) vl1e_on_vl2)
         (if (> (vlax-get-property v_line_1 'length) (vlax-get-property v_line_2 'length))
           (progn (vlax-put-property v_line_1 'endpoint (vlax-get-property v_line_2 'startpoint))
                  (vlax-invoke-method v_line_2 'delete)
                  (list v_line_2))
           (progn (vlax-put-property v_line_2 'endpoint (vlax-get-property v_line_1 'startpoint))
                  (vlax-invoke-method v_line_1 'delete)
                  (list v_line_1))))
        ;; �������� ����� ������� ������� ����� �� ������ �������
        ;; �
        ;; ��������� ����� ������� ������� ����� �� ������ �������
        ((and (null vl2s_on_vl1) vl2e_on_vl1 vl1s_on_vl2 (null vl1e_on_vl2))
         (if (> (vlax-get-property v_line_1 'length) (vlax-get-property v_line_2 'length))
           (progn (vlax-put-property v_line_1 'startpoint (vlax-get-property v_line_2 'startpoint))
                  (vlax-invoke-method v_line_2 'delete)
                  (list v_line_2))
           (progn (vlax-put-property v_line_2 'endpoint (vlax-get-property v_line_1 'endpoint))
                  (vlax-invoke-method v_line_1 'delete)
                  (list v_line_1))))
        ;; ��������� ����� ������� ������� ����� �� ������ �������
        ;; �
        ;; �������� ����� ������� ������� ����� �� ������ �������
        ((and vl2s_on_vl1 (null vl2e_on_vl1) (null vl1s_on_vl2) vl1e_on_vl2)
         (if (> (vlax-get-property v_line_1 'length) (vlax-get-property v_line_2 'length))
           (progn (vlax-put-property v_line_1 'endpoint (vlax-get-property v_line_2 'endpoint))
                  (vlax-invoke-method v_line_2 'delete)
                  (list v_line_2))
           (progn (vlax-put-property v_line_2 'startpoint (vlax-get-property v_line_1 'startpoint))
                  (vlax-invoke-method v_line_1 'delete)
                  (list v_line_1))))
        ;;��������� ����� ������� ������� ����� �� ������ �������
        ;; �
        ;;��������� ����� ������� ������� ����� �� ������ �������
        ((and vl2s_on_vl1 (null vl2e_on_vl1) vl1s_on_vl2 (null vl1e_on_vl2))
         (if (> (vlax-get-property v_line_1 'length) (vlax-get-property v_line_2 'length))
           (progn (vlax-put-property v_line_1 'startpoint (vlax-get-property v_line_2 'endpoint))
                  (vlax-invoke-method v_line_2 'delete)
                  (list v_line_2))
           (progn (vlax-put-property v_line_2 'startpoint (vlax-get-property v_line_1 'endpoint))
                  (vlax-invoke-method v_line_1 'delete)
                  (list v_line_1))))
        ;; ������� �����������, �� ����� ����� ���
        ((and (null vl2s_on_vl1) (null vl2e_on_vl1) (null vl1s_on_vl2) (null vl1e_on_vl2)) nil)
        ;; �� ����� ���
        (t (princ "\n������ �� ��������������\n") nil)))

;;; (is-prop-same(vlax-ename->vla-object (car (entsel ))) (vlax-ename->vla-object (car (entsel ))) 'LineType)
;;; (is-prop-same(vlax-ename->vla-object (car (entsel ))) (vlax-ename->vla-object (car (entsel ))) 'TrueColor)
(defun is-prop-same  (vl1               ; ������ vla-������
                      vl2               ; ������ vla-������
                      pr                ; ��� ������������� ��������
                      /                 ;
                      vc1               ; vla-���� ������� �������
                      vc2               ; vla-���� ������� �������
) (cond ((or (= pr 'layer) (= pr 'linetype)) (eq (vlax-get-property vl1 pr) (vlax-get-property vl2 pr)))
        ((= pr 'truecolor)
         (setq vc1 (vlax-get-property vl1 'truecolor)
               vc2 (vlax-get-property vl2 'truecolor))
         (and (= (vlax-get-property vc1 'red) (vlax-get-property vc2 'red))
              (= (vlax-get-property vc1 'green) (vlax-get-property vc2 'green))
              (= (vlax-get-property vc1 'blue) (vlax-get-property vc2 'blue))))
        (t)))

;;;(is-prop-lst-same(vlax-ename->vla-object (car (entsel ))) (vlax-ename->vla-object (car (entsel ))) (list 'TrueColor 'Layer 'LineType))
(defun is-prop-lst-same  (vl1           ; ������ vla-������
                          vl2           ; ������ vla-������
                          pr_lst        ; ������ ���� ������������ �������
                          )
  (apply (function and) (mapcar (function (lambda (el) (is-prop-same vl1 vl2 el))) pr_lst)))

;;; ������������ ������������ �������� �������� � ������ vla_lst
;;; delta - ���������� �� ����� ������ ������� �� ������� ������� ��� ������� ���������, ��� ����� ����� �� �������.
(defun concat_lst  (vla_lst             ; ������ ��������� ��� �����������
                    delta               ; ��������
                    /                   ;
                    rmd_lst             ; ������, ���������� ��������� �������
                    vla_tmp_lst do      ; ������� ����������� ���������� �����
                    i j)
  (setq do t)
  (while do
    (setq i (length vla_lst))
    (while (<= 0 (setq i (1- i)))
      (setq j i)
      (while (<= 0 (setq j (1- j)))
        (setq vli (nth i vla_lst)
              vlj (nth j vla_lst))
        (if (and (not (member vli rmd_lst)) (not (member vlj rmd_lst)))
          (progn (mapcar (function (lambda (el)
                                     (if (not (member el rmd_lst))
                                       (setq rmd_lst (cons el rmd_lst)))))
                         (concatenate_two_lines vli vlj delta filter))))))
    (mapcar (function (lambda (el)
                        (if (not (member el rmd_lst))
                          (setq vla_tmp_lst (cons el vla_tmp_lst)))))
            vla_lst)
    (if rmd_lst
      (setq do t)
      (setq do nil))
    (setq rmd_lst nil
          vla_lst vla_tmp_lst)))


;;;;;;("j_lns"
;;;;;;  "��������� ����������� ��������, ������� ������� � ����������� ����� ���������� �������� ����� ��������."
;;;;;;  "������"
;;;;;;)

(defun c:j_lns  (/                      ;
                 ss                     ; ����� ������
                 i                      ; ���������� �����
                 vla_lst                ; ������, ���������� vla - ����� ���������
                 c_lst                  ; ������������� ������, � ������� �������� ������������ ��������
                 r_lst                  ; ������������� ������ � �������  �������� �� ������������ ��������
                 rez_lst                ;
                 filter delta)
  (err-init '("cmdecho"))
  (setq ss     (ssget '((0 . "LINE")))
        i      (sslength ss)
        delta  0.000001
        filter (line-concat-dlg))
  (while (<= 0 (setq i (1- i))) (setq vla_lst (cons (vlax-ename->vla-object (ssname ss i)) vla_lst)))
  (while vla_lst
    (setq c_lst   (cons (car vla_lst) c_lst)
          vla_lst (cdr vla_lst))
    (mapcar (function (lambda (el)
                        (if (is-collinear (car c_lst) el delta)
                          (setq c_lst (cons el c_lst))
                          (setq r_lst (cons el r_lst)))))
            vla_lst)
    (if (< 1 (length c_lst))
      (setq rez_lst (cons c_lst rez_lst)))
    (setq vla_lst r_lst
          c_lst   nil
          r_lst   nil))
  (mapcar (function (lambda (el)
                      (setq el
                             (vl-sort el
                                      (function (lambda (e1 e2) (> (vlax-get-property e1 'length) (vlax-get-property e2 'length))))))
                      (concat_lst el delta)))
          rez_lst)
  (err-handle ""))


(defun line-concat-dlg  (/ dcl_id       ; id �������
                         setup_lst      ; ������ � ����������� �������
                         line-concat-dlg_pos ; ��������� ������� �� ������
                         do_dialog      ; ������� ����������� ���������� �������
                         rez            ; ������������ ������
) (setq setup_lst (list '("tgl_Layer" "0") '("tgl_TrueColor" "0") '("tgl_LineType" "0"))
        line-concat-dlg_pos
         '(-1 -1)
        do_dialog t)
  (setq dcl_id (load_dialog "./acad_w.sup/lines/line_concat.dcl"))
  (while do_dialog
    (if (not (new_dialog "line_concat" dcl_id "" dia_weld_pos))
      (exit))
    (init_dlg setup_lst)
    (action-tile_dlg "setup_lst" "setup_lst" "" "")
    (action_tile "help" "(lines-j_lns-help)")
    (action_tile "info" "(lines-j_lns-info)")
    (setq action (start_dialog))
    (cond ((= action 1) (setq rez (ac_accept_do)) (setq do_dialog nil))
          ((= action 0) (ac_cancel_do) (setq do_dialog nil))
          (setq do_dialog nil)))
  (unload_dialog dcl_id)
  rez)

(defun ac_accept_do  (/ rez_lst)
  (if (= "1" (cadr (assoc "tgl_Layer" setup_lst)))
    (setq rez_lst (cons 'layer rez_lst)))
  (if (= "1" (cadr (assoc "tgl_TrueColor" setup_lst)))
    (setq rez_lst (cons 'truecolor rez_lst)))
  (if (= "1" (cadr (assoc "tgl_LineType" setup_lst)))
    (setq rez_lst (cons 'linetype rez_lst)))
  rez_lst)

(defun ac_cancel_do () nil)

(defun lines-j_lns-info () (alert (strcat "����������� ���������� ���� �� ����� �������� " (about-gpl-string))))

(defun lines-j_lns-help() (help (strcat (acad_help) "/j_lns/j_lns.html")))


;;;(defun c:cccc()
;;;  (concatenate_two_lines
;;;    (vlax-ename->vla-object (car (entsel)))
;;;    (vlax-ename->vla-object (car (entsel)))
;;;    0.0001
;;;    nil
;;;  )
;;;)