(defun err (msg) (setq *error* old_err) (princ))

(defun sort_l  ()
  (if str_atoms_l
    (setq str_atoms_l (acad_strlsort str_atoms_l)))
  t)

(defun sort_r  ()
  (if str_atoms_r
    (setq str_atoms_r (acad_strlsort str_atoms_r)))
  t)

(defun save_t  (l / old_err)
  (defun comp  (l)
    (setq i (1+ i))
    (cond ((listp l)
           (princ "\n" f)
           (setq k i)
           (while (>= 0 (setq k (1- k))) (princ "\t" f))
           (princ "(" f)
           (setq j (length l))
           (while (>= 0 (setq j (1- j))) (comp nth j l))
           (setq k i)
           (while (>= 0 (setq k (1- k))) (princ "\t" f))
           (princ ")" f)))
    (princ l f)
    (setq i (1- i)))
  (setq old_err *error*
        *error* err)
  (setq f (open (getfiled "Вывод " "" "ls" 1) "w"))
  (if (null f)
    (progn (alert (princ "")) (exit)))
  (setq i 0)
  (comp l)
  (setq i -1)
  (close f))

(defun ac_b_1_3  (/ temp_l temp_r el_)  ;С совпадающими именами и несовпадающими типами
  (setq temp_r (t7r)
        temp_l (t7l)
        str_atoms_l nil
        str_atoms_r nil)
  (mapcar (function (lambda (el)
                      (setq el_ (assoc (car el) temp_r))
                      (setq ty (cadr el_))
                      (if (and el_ (/= ty (cadr el)))
                        (setq str_atoms_l (cons (t4 (car el) (cadr el) flag_l) str_atoms_l)))))
          temp_l)
  (mapcar (function (lambda (el)
                      (setq el_ (assoc (car el) temp_l))
                      (setq ty (cadr el_))
                      (if (and el_ (/= ty (cadr el)))
                        (setq str_atoms_r (cons (t4 (car el) (cadr el) flag_r) str_atoms_r)))))
          temp_r))

(defun ac_b_1_2  (/ temp_l temp_r el_)  ;С совпадающими именами и несовпадающими типами
  (setq temp_r (t7r)
        temp_l (t7l)
        str_atoms_l nil
        str_atoms_r nil)
  (mapcar (function (lambda (el)
                      (setq el_ (assoc (car el) temp_r))
                      (setq ty (cadr el_))
                      (if (not el_)
                        (setq str_atoms_l (cons (t4 (car el) (cadr el) flag_l) str_atoms_l)))))
          temp_l)
  (mapcar (function (lambda (el)
                      (setq el_ (assoc (car el) temp_l))
                      (if (not el_)
                        (setq str_atoms_r (cons (t4 (car el) (cadr el) flag_r) str_atoms_r)))))
          temp_r)
  (sort_l)
  (sort_r))

(defun type_as_string  (data)
  (setq data (type data))
  (cond ((= data 'exsubr) "EXSUBR")
        ((= data 'file) "FILE")
        ((= data 'int) "INT")
        ((= data 'list) "LIST")
        ((= data 'nil) "NIL")
        ((= data 'real) "REAL")
        ((= data 'str) "STR")
        ((= data 'subr) "SUBR")
        ((= data 'sym) "SYM")
        (t " ")))

(defun string_as_type  (string)
  (setq string (strcase string))
  (cond ((= string "EXSUBR") 'exsubr)
        ((= string "FILE") 'file)
        ((= string "INT") 'int)
        ((= string "LIST") 'list)
        ((= string "NIL") 'nil)
        ((= string "REAL") 'real)
        ((= string "STR") 'str)
        ((= string "SUBR") 'subr)
        ((= string "SYM") 'sym)
        (t 't)))

(defun val_s  (s / l j i)
  (setq l (strlen s)
        i 1)
  (while (<= i l)
    (if (= (substr s i 1) " ")
      (setq j i))
    (setq i (1+ i)))
  (substr s (+ j 1) (- l j)))

(defun val_as_string  (data / f)
  (setq f (open "atoms.cpm" "w"))
  (if (null f)
    (progn (alert (princ "\nНе могу открыть файл atoms.cpm.")) (exit)))
  (print data f)
  (close f)
  (setq f (open "atoms.cpm" "r"))
  (if (null f)
    (progn (alert (princ "\nНе могу открыть файл atoms.cpm.")) (exit)))
  (read-line f)
  (setq data (read-line f))
  (close f)
  data)

(defun t1  (/ temp temp1)
  (setq temp (atoms-family 1))
  (mapcar (function (lambda (el)
                      (if el
                        (setq temp1 (cons el temp1)))))
          temp)
  (if temp1
    (acad_strlsort temp1)
    nil))

(defun t2  (lst_1 / temp el lst lst-i lst-len lst-rez) ;Возвращает список, состоящий из имен и типов
  (progn (setq lst     lst_1
               lst-len (length lst)
               lst-i   -1)
         (while (< (setq lst-i (1+ lst-i)) lst-len)
           (setq el      (nth lst-i lst)
                 lst-rez (cons (progn (setq temp (cons (list el (type_as_string (eval (read el)))) temp))) lst-rez)))
         (setq lst-rez (reverse lst-rez)))
  (reverse temp))

(defun t3  (lst_2 wc_str fl / temp st)
  (mapcar (function (lambda (el)
                      (setq st (t4 (car el) (cadr el) fl))
                      (if (wcmatch st wc_str)
                        (setq temp (cons st temp)))))
          lst_2)
  (if temp
    (acad_strlsort temp)
    nil))

(defun t4  (str1 str2 flag_r)
  (if (null flag_r)
    (strcat str1 " " str2)
    (strcat str2 " " str1)))

(defun t7r  (/ temp st)                 ;Список из объектов расположенных в окне
  (mapcar (function (lambda (el)
                      (if el
                        (progn (setq st (t4 (car el) (cadr el) flag_r))
                               (if (member st str_atoms_r)
                                 (setq temp (cons el temp)))))))
          all_atoms_r)
  temp)

(defun t7l  (/ temp st)                 ;Список из объектов расположенных в окне
  (mapcar (function (lambda (el)
                      (if el
                        (progn (setq st (t4 (car el) (cadr el) flag_l))
                               (if (member st str_atoms_l)
                                 (setq temp (cons el temp)))))))
          all_atoms_l)
  temp)

(defun t8r  ()
  (setq str_atoms_r nil)
  (mapcar (function (lambda (el)
                      (if el
                        (progn (setq st (t4 (car el) (cadr el) flag_r))
                               (if (wcmatch st shabl_r)
                                 (setq str_atoms_r (cons st str_atoms_r)))))))
          all_atoms_r)
  (sort_r))

(defun t8l  ()
  (setq str_atoms_l nil)
  (mapcar (function (lambda (el)
                      (if el
                        (progn (setq st (t4 (car el) (cadr el) flag_l))
                               (if (wcmatch st shabl_l)
                                 (setq str_atoms_l (cons st str_atoms_l)))))))
          all_atoms_l)
  (sort_l))

(defun ac_b_1_2  (/ tr tl)
  (setq tr (t7r)
        tl (t7l)
        str_atoms_r nil
        str_atoms_l nil)
  (mapcar (function (lambda (el)
                      (if (null (assoc (car el) tr))
                        (setq str_atoms_l (cons (t4 (car el) (cadr el) flag_l) str_atoms_l)))))
          tl)
  (mapcar (function (lambda (el)
                      (if (null (assoc (car el) tl))
                        (setq str_atoms_r (cons (t4 (car el) (cadr el) flag_r) str_atoms_r)))))
          tr)
  (sort_l)
  (sort_r))
 ;______________________________________________________________________________
(defun t11  (/ temp)
  (setq temp (t7r))
  (mapcar (function (lambda (el) (set (read (car el)) nil))) temp))
 ;______________________________________________________________________________
(defun ac_b_1_9  (/ temp_r)
  (setq temp_r (t7r))
  (mapcar (function (lambda (el)
                      (setq el_ (assoc (car el) all_atoms_l))
                      (if (not el_)
                        (setq all_atoms_l (cons el all_atoms_l)
                              str_atoms_l (cons (t4 (car el) (cadr el) flag_l) str_atoms_l)))))
          temp_r)
  (sort_l))
 ;______________________________________________________________________________
(defun ac_b_1_10  (/ temp_r temp st)
  (setq temp_r (t7r)
        temp all_atoms_r
        all_atoms_r nil
        str_atoms_r nil)
  (mapcar (function (lambda (el)
                      (if (not (assoc (car el) temp_r))
                        (progn (setq all_atoms_r (cons el all_atoms_r))
                               (setq st (t4 (car el) (cadr el) flag_r))
                               (if (wcmatch st shabl_r)
                                 (setq str_atoms_r (cons st str_atoms_r)))))))
          temp)
  (sort_r))
 ;______________________________________________________________________________
(defun un_init () (setq do_dial nil))
 ;______________________________________________________________________________
(defun init () (setq do_dial t) (setq shabl_r "*") (setq shabl_l "*") (setq e_1_1 "") (ac_b_1_11))
 ;______________________________________________________________________________
(defun ac_l_1_r  ($value / temp l el)
  (print poz_list_r)
  (if (= poz_list_r (setq temp (atoi $value)))
    (progn (setq poz_list_r nil)
           (start_list "l_1_r")
           (mapcar 'add_list str_atoms_r)
           (end_list)
           (set_tile "e_1_1" (setq e_1_1 "")))
    (progn (setq l (length all_atoms_r))
           (while (>= (setq l (1- l)) 0)
             (setq el (nth l all_atoms_r))
             (if (= (t4 (car el) (cadr el) flag_r) (nth (atoi $value) str_atoms_r))
               (setq l -1)))
           (setq el (eval (read (car el))))
           (setq e_1_1 (val_as_string el))
           (set_tile "e_1_1" e_1_1)
           (setq poz_list_r temp)))
  (print poz_list_r))
 ;______________________________________________________________________________
(defun ac_b_1_4  (/ temp)
  (setq temp        flag_r
        flag_r      flag_l
        flag_l      temp
        temp        shabl_r
        shabl_r     shabl_l
        shabl_l     temp
        temp        all_atoms_r
        all_atoms_r all_atoms_l
        all_atoms_l temp
        temp        str_atoms_r
        str_atoms_r str_atoms_l
        str_atoms_l temp
        temp        poz_list_r
        poz_list_r  poz_list_l
        poz_list_l  temp)
  (setup_r)
  (setup_l))
 ;______________________________________________________________________________
(defun ac_b_1_7  (/ fn f)
  (setq fn (getfiled "Файл для записи списка переменных" "" "cmp" 1))
  (if (null fn)
    (progn (alert (princ (strcat "\nНе могу открыть файл" fn "."))) (exit))
    (progn (setq f (open fn "w"))
           (if (null f)
             (progn (alert (princ (strcat "\nНе могу открыть файл:" fn ".\n"))) (exit)))
           (princ "(setq all_atoms_r '" f)
           (print (t7r) f)
           (princ ")" f)
           (princ "(setq str_atoms_r '" f)
           (print str_atoms_r f)
           (princ ")" f)
           (princ "(setq flag_r '" f)
           (print flag_r f)
           (princ ")" f)
           (close f))))
 ;______________________________________________________________________________
(defun ac_b_1_8  (/ fn)
  (setq fn (getfiled "Файл для чтения списка переменных" "" "cmp" 1))
  (if fn
    (load fn)))
 ;______________________________________________________________________________
(defun ac_b_1_11  (/ temp st ty)
  (setq all_atoms_r nil
        str_atoms_r nil
        temp        (atoms-family 1))
  (mapcar (function (lambda (el)
                      (if el
                        (progn (setq ty (type_as_string (eval (read el))))
                               (setq all_atoms_r (cons (list el ty) all_atoms_r))
                               (setq st (t4 el ty flag_r))
                               (if (wcmatch st shabl_r)
                                 (setq str_atoms_r (cons st str_atoms_r)))))))
          temp)
  (sort_r))

(defun ac_b_1_14r  ()
  (if flag_r
    (setq flag_r nil)
    (setq flag_r t))
  (t8r)
  (setup_r))
(defun ac_b_1_14l  ()
  (if flag_l
    (setq flag_l nil)
    (setq flag_l t))
  (t8l)
  (setup_l))
(defun ac_b_1_15  ()
  (setq all_atoms_r nil
        str_atoms_r nil)
  (setup_r))

(defun ac_e_1_2r () (setq shabl_r (strcase (get_tile "e_1_2r"))) (t8r) (setup_r))
(defun ac_e_1_2l () (setq shabl_l (strcase (get_tile "e_1_2l"))) (t8l) (setup_l))

(defun ac_tile  ()
  (action_tile "accept" "(un_init)")
  (action_tile "cancel" "(un_init)")
  (action_tile "e_1_2r" "(ac_e_1_2r)")
  (action_tile "e_1_2l" "(ac_e_1_2l)")
  (action_tile "l_1_r" "(ac_l_1_r $value)")
  (action_tile "b_1_2" "(ac_b_1_2)(setup_l)(setup_r)") ; <-- &&
  (action_tile "b_1_3" "(ac_b_1_3)(setup_l)(setup_r)") ; <-- &&
  (action_tile "b_1_4" "(ac_b_1_4)")    ;<---->
  (action_tile "b_1_7" "(ac_b_1_7)")    ;Записать
  (action_tile "b_1_8" "(ac_b_1_8)(setup_r)") ;Прочитать
  (action_tile "b_1_9" "(ac_b_1_9)(setup_l)") ;<-- Copy
  (action_tile "b_1_10" "(ac_b_1_10)(setup_r)") ;<---- Del
  (action_tile "b_1_11" "(ac_b_1_11)(setup_r)") ;Считать
  (action_tile "b_1_14r" "(ac_b_1_14r)") ;Имя Т | Т Имя
  (action_tile "b_1_14l" "(ac_b_1_14l)") ;Имя Т | Т Имя
  (action_tile "b_1_15" "(ac_b_1_15)")  ;Очитсить
  (action_tile "b_1_16" "(t11)")        ; Удалить
  )
(defun setup_r  ()
  (set_tile "e_1_1" e_1_1)
  (if flag_r
    (set_tile "t_1_1r" "Т+И")
    (set_tile "t_1_1r" "И+Т"))
  (set_tile "t_1_2r" (strcat (itoa (length str_atoms_r)) " из " (itoa (length all_atoms_r))))
  (set_tile "e_1_2r" shabl_r)
  (start_list "l_1_r")
  (mapcar 'add_list str_atoms_r)
  (end_list))
(defun setup_l  ()
  (if flag_l
    (set_tile "t_1_1l" "Т+И")
    (set_tile "t_1_1l" "И+Т"))
  (set_tile "t_1_2l" (strcat (itoa (length str_atoms_l)) " из " (itoa (length all_atoms_l))))
  (set_tile "e_1_2l" shabl_l)
  (start_list "l_1_l")
  (mapcar 'add_list str_atoms_l)
  (end_list))

;;;;;;("atoms" "Команда для просмотра загруженных команд функций и атомов." "not defined")
(defun c:atoms  (/ act dcl_id do_dial e_1_1 all_atoms_l str_atoms_l poz_list_l)
  (init)
  (setq dcl_id (load_dialog (findfile "src/lsp/atoms/atoms-dlg.dcl")))
  (if (< dcl_id 0)
    (exit))
  (if (not (new_dialog "atoms" dcl_id))
    (exit))
  (setup_r)
  (setup_l)
  (ac_tile)
  (while do_dial (setq act (start_dialog)) (cond ((= act 2) (un_init))))
  (unload_dialog dcl_id))
