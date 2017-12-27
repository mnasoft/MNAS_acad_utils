(vl-load-com)

(defun c:hpgl_in  (/ fn                 ;
                   ch                   ;
                   fl                   ;
                   ch_n                 ;
                   s_instr              ;
                   str_digit            ;
                   s_buf                ;
                   do_it                ;
                   lst_instr            ;
                   hpgl:coords          ; координаты абсолютные или относительные
                   hpgl:p_pnt           ; текущее положение пера
                   hpgl:color           ; цвет пера
                   hpgl:pen             ;состояние пера
) (setq hpgl:pen "UP"                   ;"UP"|"DOWN";
        hpgl:coords
         "A"                            ;"A"|"R"
        )
  (setq fn (getfiled "title" "" "plt" 4))
  (setq fl (open fn "r"))
  (setq s_instr ""
        str_digit ""
        s_buf ""
        do_it t)
  (while do_it
    (setq ch_n (read-char fl))
    (setq ch (cond (ch_n (chr ch_n))
                   (t "")))
    (cond ((= ch "") (setq do_it nil))
          ((= ch ";")
           (setq lst_instr (analize s_buf)) ;       (print lst_instr)
           (draw_plt lst_instr)
           (setq s_buf ""))
          (t (setq s_buf (strcat s_buf ch)))))
  (close fl)
  (princ))

(defun analize  (s_buf / len i ch s_instr digit lst_rez) ;  (print s_buf)
  (setq len (strlen s_buf)
        i   0)
  (while (< i len)
    (setq ch (chr (vl-string-elt s_buf i)))
    (cond ((= ch ";")                   ;       (выполнить_инструкцию)
           )
          ((wcmatch ch "[-1234567890]") ; -1234567890
           (setq digit (read_digit s_buf))
           (setq lst_rez (append lst_rez (list digit))) ;       (print digit)
           )
          ((wcmatch ch "@")
           (setq s_instr (read_instr s_buf)) ;       (print s_instr)
           (setq lst_rez (append lst_rez (list s_instr)))))
    (setq i (1+ i)))
  lst_rez)

(defun read_digit  (s_buf / ch do_it str_digit)
  (setq do_it t)
  (setq str_digit "")
  (while (and do_it (< i len))
    (setq ch (chr (vl-string-elt s_buf i)))
    (cond ((wcmatch ch "[-1234567890]") ;-1234567890
           (setq str_digit (strcat str_digit ch))
           (setq i (1+ i)))
          ((setq do_it nil))))
  (setq i (1- i))
  (read str_digit))

(defun read_instr  (s_buf / ch do_it str_instr)
  (setq do_it t)
  (setq str_instr "")
  (while (and do_it (< i len))
    (setq ch (chr (vl-string-elt s_buf i)))
    (cond ((wcmatch ch "@")             ;1234567890
           (setq str_instr (strcat str_instr ch))
           (setq i (1+ i)))
          ((setq do_it nil))))
  (setq i (1- i))
  str_instr)

;;;_$ (HPGL_INSTR->LIST "HPGL-INSTR->LIST")
;;;("HP" "GL" "-I" "NS" "TR" "->" "LI" "ST")
(defun hpgl_instr->list  (instr / int_instr_lst)
  (if (= (type instr) 'str)
    (progn (setq int_instr_lst (list-point2d_list (vl-string->list instr)))
           (mapcar (function (lambda (el / str_lst)
                               (setq str_lst (mapcar (function (lambda (el1) (chr el1))) el))
                               (apply (function strcat) str_lst)))
                   int_instr_lst))
    nil))

(defun points_lst  (lst / pnt_lst)
  (setq pnt_lst    (list-point2d_list (list-scale lst 0.025))
        pnt_lst    (cond (hpgl:p_pnt (append (list hpgl:p_pnt) pnt_lst))
                         (t pnt_lst))
        hpgl:p_pnt (last pnt_lst))
  pnt_lst)

(defun do_instr  (key lst / pnt_lst)
  (cond ((= "PU" key)
         (setq hpgl:pen "UP")
         (if lst
           (setq pnt_lst (points_lst lst))))
        ((= "PD" key)
         (setq hpgl:pen "DOWN")
         (if lst
           (progn (setq pnt_lst (points_lst lst))
                  (if (= hpgl:pen "DOWN")
                    (dr:pline pnt_lst hpgl:color)))))
        ((= "PA" key)
         (setq hpgl:coords "A")
         (if lst
           (progn (setq pnt_lst (points_lst lst))
                  (if (= hpgl:pen "DOWN")
                    (dr:pline pnt_lst hpgl:color)))))
        ((= "SP" key) (setq hpgl:color (car lst)))))

(defun do_instr_lst (i_lst) (mapcar (function (lambda (el) (do_instr el nil))) i_lst))

(defun draw_plt  (lst / instr_lst instr)
  (if lst
    (progn (setq instr_lst (reverse (hpgl_instr->list (car lst)))
                 instr     (car instr_lst)
                 instr_lst (reverse (cdr instr_lst)))
           (setq lst (cdr lst))
           (do_instr_lst instr_lst)
           (do_instr instr lst))))
(defun draw_plt_bak  (lst / instr)
  (setq instr (car lst))
  (setq lst (cdr lst))
  (cond ((= "PU" instr)
         (if lst
           (setq hpgl:p_pnt (car (reverse (list-point2d_list (list-scale lst 0.025))))))
         (setq hpgl:pen "UP"))
        ((= "PD" instr)
         (if lst
           (setq hpgl:p_pnt (append hpgl:p_pnt (list-point2d_list (list-scale lst 0.025)))))
         (setq hpgl:pen "DOWN"))
        ((= "PA" instr)
         (setq hpgl:p_pnt (list-point2d_list (list-scale lst 0.025)))
         (dr:pline hpgl:p_pnt hpgl:color))
        ((= "PUPA" instr)
         (if lst
           (setq hpgl:p_pnt (car (reverse (list-point2d_list (list-scale lst 0.025)))))))
        ((= "PDPA" instr)
         (setq hpgl:p_pnt (append hpgl:p_pnt (list-point2d_list (list-scale lst 0.025))))
         (dr:pline hpgl:p_pnt hpgl:color))
        ((= "SP" instr)                 ;     (princ lst)
         (setq hpgl:color (car lst)))))

(defun list-point2d_list  (lst / n i x y lst_rez j)
  (setq n (/ (length lst) 2)
        i 0)
  (while (< i n)
    (setq j       (* i 2)
          x       (nth j lst)
          y       (nth (1+ j) lst)
          lst_rez (append lst_rez (list (list x y)))
          i       (1+ i)))
  lst_rez)

(defun list-scale (lst scale) (setq lst (mapcar (function (lambda (el) (* scale el))) lst)))

