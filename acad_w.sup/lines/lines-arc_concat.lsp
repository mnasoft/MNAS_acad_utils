(vl-load-com)

;;;;;;("j_arcs"
;;;;;;  "��������� ����������� ���, ������� ������� � ����������� ����� ���������� ��� ����� �����."
;;;;;;  "������"
;;;;;;)

(defun c:j_arcs  (/                     ;
                  ss                    ; ����� ������
                  i                     ; ���������� �����
                  vla_lst               ; ������, ���������� vla - ����� ���������
                  c_lst                 ; ������������� ������, � ������� �������� ������������ ��������
                  r_lst                 ; ������������� ������ � �������  �������� �� ������������ ��������
                  rez_lst               ;
                  filter                ;
)
;;;  (err-init '("cmdecho"))
  (setq ss    (ssget '((0 . "ARC")))
        i     (sslength ss)
        delta 0.000001
;;;	filter (line-concat-dlg)
        )
  (while (<= 0 (setq i (1- i))) (setq vla_lst (cons (vlax-ename->vla-object (ssname ss i)) vla_lst)))
  (v3d->list (vlax-get-property (nth 0 vla_lst) 'center))
  (v3d->list (vlax-get-property (nth 0 vla_lst) 'normal))
  (vlax-get-property (nth 0 vla_lst) 'radius)
  (while vla_lst
    (setq c_lst   (cons (car vla_lst) c_lst)
          vla_lst (cdr vla_lst))
    (mapcar (function (lambda (el)
                        (if (is-arc_concatenable (car c_lst) el delta)
                          (setq c_lst (cons el c_lst))
                          (setq r_lst (cons el r_lst)))))
            vla_lst)
    (if (< 1 (length c_lst))
      (setq rez_lst (cons c_lst rez_lst)))
    (setq vla_lst r_lst
          c_lst   nil
          r_lst   nil))
  (mapcar (function
            (lambda (el)
              (setq el (vl-sort el
                                (function (lambda (e1 e2) (> (vlax-get-property e1 'arclength) (vlax-get-property e2 'arclength))))))
              (concat_arc_lst el delta)))
          rez_lst)
;;;  (err-handle "")
  )


(defun is-arc_concatenable  (v_arc_1    ; Vla ������, ������������� ������ �������
                             v_arc_2    ; Vla ������, ������������� ������ �������
                             delta      ; ��������, ���������� ��� ������� ������� ��������� �������������
                             /          ;
                             c_1        ;
                             c_2        ;
                             n_1        ;
                             n_2        ;
                             r_1        ;
                             r_2        ;
) (setq c_1 (v3d->list (vlax-get-property v_arc_1 'center))
        c_2 (v3d->list (vlax-get-property v_arc_2 'center))
        n_1 (v3d->list (vlax-get-property v_arc_1 'normal))
        n_2 (v3d->list (vlax-get-property v_arc_2 'normal))
        r_1 (vlax-get-property v_arc_1 'radius)
        r_2 (vlax-get-property v_arc_2 'radius))
  (and (< (distance c_1 c_2) delta)
       (< (distance n_1 n_2) delta)
       (< (distance (list r_1 0.0 0.0) (list r_2 0.0 0.0)) delta)))


(defun concat_arc_lst  (vla_lst         ; ������ ��������� ��� �����������
                        delta           ; ��������
                        /               ;
                        rmd_lst         ; ������, ���������� ��������� �������
                        vla_tmp_lst do  ; ������� ����������� ���������� �����
) (setq do t)
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
                         (concatenate_two_arcs vli vlj delta filter))))))
    (mapcar (function (lambda (el)
                        (if (not (member el rmd_lst))
                          (setq vla_tmp_lst (cons el vla_tmp_lst)))))
            vla_lst)
    (if rmd_lst
      (setq do t)
      (setq do nil))
    (setq rmd_lst nil
          vla_lst vla_tmp_lst)))

(defun concatenate_two_arcs  (v_line_1  ; Vla ������, �������������� ������ �������
                              v_line_2  ; Vla ������, �������������� ������ �������
                              delta     ; ��������, ������������ ���������� ����� ������ � �������� ��� ������� ��� ��������� ������������
                              filter /  ;
                              lns_clnr  ; ������� �������������� ��������
                              vl1s      ; ������ ��������� ��������� ����� ������� �������
                              vl1e      ; ������ ��������� �������� ����� ������� �������
                              vl2s      ; ������ ��������� ��������� ����� ������� �������
                              vl2e      ; ������ ��������� �������� ����� ������� �������
                              vl1e_on_vl2 ; �������� ����� ������� ������� ����� �� ������ �������
                              vl1s_on_vl2 ; ��������� ����� ������� ������� ����� �� ������ �������
                              vl2e_on_vl1 ; �������� ����� ������� ������� ����� �� ������ �������
                              vl2s_on_vl1 ; ��������� ����� ������� ������� ����� �� ������ �������
                              fltrd     ;
) (setq
;;;    lns_clnr	(is-collinear v_line_1 v_line_2 delta)
        vl1s        (v3d->list (vlax-get-property v_line_1 'startpoint))
        vl1e        (v3d->list (vlax-get-property v_line_1 'endpoint))
        vl2s        (v3d->list (vlax-get-property v_line_2 'startpoint))
        vl2e        (v3d->list (vlax-get-property v_line_2 'endpoint))
        vl2s_on_vl1 (is-pnt-on-line vl2s v_line_1 delta)
        vl2e_on_vl1 (is-pnt-on-line vl2e v_line_1 delta)
        vl1s_on_vl2 (is-pnt-on-line vl1s v_line_2 delta)
        vl1e_on_vl2 (is-pnt-on-line vl1e v_line_2 delta)
;;;    fltrd	(not (is-prop-lst-same v_line_1 v_line_2 filter))
        )
  (cond ;;��� �������������� ��������
;;;    ((not lns_clnr)
;;;     nil
;;;    )
        ;; ������ �� ��������� ��������
;;;    (fltrd nil)
        ;; ������ ������� ��������� ����� �� ������ �������
        ((and vl1s_on_vl2 vl1e_on_vl2) (vlax-invoke-method v_line_1 'delete) (list v_line_1))
        ;; ������ ������� ��������� ����� �� ������ �������
        ((and vl2s_on_vl1 vl2e_on_vl1) (vlax-invoke-method v_line_2 'delete) (list v_line_2))
        ;; �������� ����� ������� ������� ����� �� ������ �������
        ;; �
        ;; �������� ����� ������� ������� ����� �� ������ �������
        ((and (null vl2s_on_vl1) vl2e_on_vl1 (null vl1s_on_vl2) vl1e_on_vl2)
         (if (> (vlax-get-property v_line_1 'arclength) (vlax-get-property v_line_2 'arclength))
           (progn (vlax-put-property v_line_1 'endangle (vlax-get-property v_line_2 'startangle))
                  (vlax-invoke-method v_line_2 'delete)
                  (list v_line_2))
           (progn (vlax-put-property v_line_2 'endangle (vlax-get-property v_line_1 'startangle))
                  (vlax-invoke-method v_line_1 'delete)
                  (list v_line_1))))
        ;; �������� ����� ������� ������� ����� �� ������ �������
        ;; �
        ;; ��������� ����� ������� ������� ����� �� ������ �������
        ((and (null vl2s_on_vl1) vl2e_on_vl1 vl1s_on_vl2 (null vl1e_on_vl2))
         (if (> (vlax-get-property v_line_1 'arclength) (vlax-get-property v_line_2 'arclength))
           (progn (vlax-put-property v_line_1 'startangle (vlax-get-property v_line_2 'startangle))
                  (vlax-invoke-method v_line_2 'delete)
                  (list v_line_2))
           (progn (vlax-put-property v_line_2 'endangle (vlax-get-property v_line_1 'endangle))
                  (vlax-invoke-method v_line_1 'delete)
                  (list v_line_1))))
        ;; ��������� ����� ������� ������� ����� �� ������ �������
        ;; �
        ;; �������� ����� ������� ������� ����� �� ������ �������
        ((and vl2s_on_vl1 (null vl2e_on_vl1) (null vl1s_on_vl2) vl1e_on_vl2)
         (if (> (vlax-get-property v_line_1 'arclength) (vlax-get-property v_line_2 'arclength))
           (progn (vlax-put-property v_line_1 'endangle (vlax-get-property v_line_2 'endangle))
                  (vlax-invoke-method v_line_2 'delete)
                  (list v_line_2))
           (progn (vlax-put-property v_line_2 'startangle (vlax-get-property v_line_1 'startangle))
                  (vlax-invoke-method v_line_1 'delete)
                  (list v_line_1))))
        ;;��������� ����� ������� ������� ����� �� ������ �������
        ;; �
        ;;��������� ����� ������� ������� ����� �� ������ �������
        ((and vl2s_on_vl1 (null vl2e_on_vl1) vl1s_on_vl2 (null vl1e_on_vl2))
         (if (> (vlax-get-property v_line_1 'arclength) (vlax-get-property v_line_2 'arclength))
           (progn (vlax-put-property v_line_1 'startangle (vlax-get-property v_line_2 'endangle))
                  (vlax-invoke-method v_line_2 'delete)
                  (list v_line_2))
           (progn (vlax-put-property v_line_2 'startangle (vlax-get-property v_line_1 'endangle))
                  (vlax-invoke-method v_line_1 'delete)
                  (list v_line_1))))
        ;; ������� �����������, �� ����� ����� ���
        ((and (null vl2s_on_vl1) (null vl2e_on_vl1) (null vl1s_on_vl2) (null vl1e_on_vl2)) nil)
        ;; �� ����� ���
        (t (princ "\n������ �� ��������������\n") nil)))


(defun c:cccc  ()
  (concatenate_two_arcs
    (vlax-ename->vla-object (car (entsel)))
    (vlax-ename->vla-object (car (entsel)))
    0.0001
    nil))

