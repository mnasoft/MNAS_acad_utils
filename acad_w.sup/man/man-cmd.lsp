;;;;;;("man"
;;;;;;"
;;;;;;Команда отображения справочной информации по командам, определенным пользователем.\n
;;;;;;   Command  - позволяет произвести поиск команды по шаблону в имени и вывести справочную информацию ней;\n
;;;;;;   Keywords - позволяет произвести поиск команды по шаблону в описании команды и вывести справочную информацию ней;\n
;;;;;;   List     - выводит перечень комад, определенных пользователем;\n
;;;;;;   Rebuild  - извлекает справочную ниформацию из lsp - файлов, перестраивая базу данных помощи;\n
;;;;;;   Примечание: При использовании опции Rebuild в случае вывода ошибки: (malform-list) необходимо найти в
;;;;;; файле /man/man-data_base.lsp последний считанный список и найти соответствующую ему запись
;;;;;; в файле /man/man_data.txt ошибка будет ниже.
;;;;;;" "Справка")
(defun c:man  (/                        ;
               l_cmds                   ;
               do                       ; Переменная цикла.
               )
  (man-load-func)
  (setq do t)
  (while do
    (initget "Command List Keywords Function Rebuild loAd Html Exit")
    (setq kw (getkword "Select option [Command/List/Keywords/Function/Rebuild/loAd/Html] <Exit>:"))
    (cond ((= kw nil) (setq do nil))
          ((= kw "Exit") (setq do nil))
          ((= kw "loAd") (man-load-func))
          ((= kw "List")
           (setq l_cmds (mapcar (function car) mnas_command_help))
           (mapcar (function (lambda (el) (princ el) (princ "\n"))) (vl-sort l_cmds (function <))))
          ((= kw "Keywords")
           (setq pattern (getstring "\nВведите шаблон содержания справки для поиска команды:"))
           (mapcar (function (lambda (el)
                               (if (wcmatch-case (cadr el) pattern)
                                 (progn (princ (strcat "Команда: " (car el) "\n"))
                                        (princ (strcat "Описание команды:" "\n" (cadr el) "\n\n"))))))
                   mnas_command_help))
          ((= kw "Rebuild") (man-rebuild) (man-rebuild-func))
          ((= kw "Html") (create_cmd_html))
          ((= kw "Command")
           (setq pattern (getstring "\nВведите шаблон имени команды для поиска ее описания:"))
           (mapcar (function (lambda (el)
                               (if (wcmatch-case (car el) pattern)
                                 (progn (princ (strcat "Команда : " (car el) "\n"))
                                        (princ (strcat "Описание команды :\n" (cadr el) "\n\n"))))))
                   mnas_command_help))
          ((= kw "Function")
           (setq pattern (getstring "\nВведите шаблон имени команды для поиска ее описания:"))
           (mapcar (function (lambda (el)
                               (if (wcmatch-case (car el) pattern)
                                 (progn (princ (strcat "Функция : " (car el) "\n"))
                                        (princ (strcat "Описание функции :\n" (cadr el) "\n\n"))))))
                   mnas_function_help))
          (t
           (setq pattern kw)
           (mapcar (function (lambda (el)
                               (if (wcmatch-case (car el) pattern)
                                 (progn (princ (strcat "Команда : " (car el) "\n"))
                                        (princ (strcat "Описание команды :\n" (cadr el) "\n\n"))))))
                   mnas_command_help))))
  (princ))

(defun man-load-func  ()
  (load (findfile "acad_w.sup/man/man-data_base.lsp"))
  (load (findfile "acad_w.sup/man/man-data_base_func.lsp")))

;;;f;;;("man-rebuild"
;;;f;;;"Prj - man.\n
;;;f;;;File - man.lsp.
;;;f;;;Производит извлечение справочной информации из файлов *.lsp")
(defun man-rebuild  (/ asterix_semicolon fl_r fl_w fn_r fn_w f_name ln semicolon ss)
  (setq fn_w (findfile "acad_w.sup/man/man-data_base.lsp")
        fn_r (getfiled "Select a Lisp File" (findfile "acad_w.sup/man/man_data.txt") "txt" 1))
  (find-line-by_mask-in_directory_files (acad_sup) "*.lsp" (strcat "*;;;" ";;;*") fn_r)
  (setq fl_r (open fn_r "r")
        fl_w (open fn_w "w"))
  (cond ((null fl_r) (alert (princ (strcat "Не могу открыть файл :" fn_r "."))) (exit))
        ((null fl_w) (alert (princ (strcat "Не могу открыть файл :" fn_w "."))) (exit)))
  (princ "(setq MNAS_command_help '(" fl_w)
  (setq f_name            ""
        ss                ""
        semicolon         (strcat ";;;" ";;;")
        asterix_semicolon (strcat "*" semicolon "*"))
  (while (setq ln (read-line fl_r))
    (if (wcmatch-case ln asterix_semicolon)
      (progn (setq ln (vl-string-subst "" "\t\t" ln)
                   ln (vl-string-subst "" "\t" ln)
                   ln (vl-string-subst "" semicolon ln)
                   ss (strcat ss ln)))
      (progn (mapcar (function (lambda (el) (prin1 (append el (list f_name)) fl_w))) (read (strcat "(" ss ")")))
             (setq f_name ln
                   ss ""))))
  (mapcar (function (lambda (el) (prin1 (append el (list f_name)) fl_w))) (read (strcat "(" ss ")")))
  (princ "))" fl_w)
  (close fl_r)
  (close fl_w))

;;;f;;;("dir_recursive" "Рекурсивный поиск всех каталогов начиная с каталога directory.")
(defun dir_recursive  (directory / d_curr d_list directory_list d_rez d_curr)
  (setq directory_list (cons directory directory_list))
  (while directory_list
    (setq d_curr         (car directory_list)
          d_rez          (append d_rez (list d_curr))
          directory_list (cdr directory_list)
          d_list         (vl-directory-files d_curr "*" -1))
    (if (= "." (car d_list))
      (setq d_list (cdr (cdr d_list))))
    (setq d_list         (mapcar (function (lambda (el) (strcat d_curr "/" el))) d_list)
          directory_list (append d_list directory_list)))
  d_rez)

;;;f;;;("fname_recursive"
;;;f;;;"Рекурсивный поиск всех имен файлов с маской fn_mask начиная с каталога directory.")
(defun fname_recursive  (directory fn_mask / fn_rez fn_rez)
  (mapcar (function
            (lambda (el)
              (setq fn_rez (append fn_rez
                                   (mapcar (function (lambda (el1) (strcat el "/" el1))) (vl-directory-files el fn_mask 1))))
              t))
          (dir_recursive directory))
  fn_rez)

;;;f;;;("find_line_by_mask"
;;;f;;;"Производит поиск строк в файле с именем fname,\n
;;;f;;;удовлетворяющих маске mask и производит их запись в файл с дескриптором  f_out.\n
;;;f;;;Файл f_out должен быть открыт по записи.")
(defun find_line_by_mask  (fname mask f_out / fl str)
  (setq fl (open fname "r"))
  (cond ((/= 'str (type fname)) (alert (princ "Переменная fname не содержит имени файла.")))
        ((null fl) (alert (princ (strcat "Не могу открыть файл :" fn_r "."))) (exit)))
  (while (setq str (read-line fl))
    (if (wcmatch-case str mask)
      (progn (princ str f_out) (princ "\n" f_out))))
  (close fl))

;;;f;;;("find-line-by_mask-in_directory_files"
;;;f;;;"Производит поиск строк, удовлетворяющих маске str_mask,\n
;;;f;;;в файлах с маской имени файла file_mask\n
;;;f;;;начиная с коталога directory рекурсивно вглубь по дереву каталогов\n
;;;f;;;и выводит строки, найденные в файлах, в выходной файл с именем fn_out.")
(defun find-line-by_mask-in_directory_files  (directory file_mask str_mask fn_out / f_out)
  (setq f_out (open fn_out "w"))
  (cond ((/= 'str (type fn_out)) (alert (princ "Переменная fn_out не содержит имени файла.")))
        ((null f_out) (alert (princ (strcat "Не могу открыть файл :" fn_out "."))) (exit)))
  (mapcar (function (lambda (el) (princ el f_out) (princ "\n" f_out) (find_line_by_mask el str_mask f_out)))
          (fname_recursive directory file_mask))
  (close f_out))

(defun man-rebuild-func  (/ asterix_semicolon fl_r fl_w fn_r fn_w f_name ln semicolon ss)
  (setq fn_w              (findfile "acad_w.sup/man/man-data_base_func.lsp")
        fn_r              (getfiled "Select a Lisp File" (findfile "acad_w.sup/man/man_data_func.txt") "txt" 1)
        f_name            ""
        ss                ""
        semicolon         (strcat ";;;" "f" ";;;")
        asterix_semicolon (strcat "*" semicolon "*"))
  (find-line-by_mask-in_directory_files (acad_sup) "*.lsp" asterix_semicolon fn_r)
  (setq fl_r (open fn_r "r")
        fl_w (open fn_w "w"))
  (cond ((null fl_r) (alert (princ (strcat "Не могу открыть файл :" fn_r "."))) (exit))
        ((null fl_w) (alert (princ (strcat "Не могу открыть файл :" fn_w "."))) (exit)))
  (princ "(setq MNAS_function_help '(" fl_w)
  (while (setq ln (read-line fl_r))
    (if (wcmatch-case ln asterix_semicolon)
      (progn (setq ln (vl-string-subst "" "\t\t" ln)
                   ln (vl-string-subst "" "\t" ln)
                   ln (vl-string-subst "" semicolon ln)
                   ss (strcat ss ln)))
      (progn (mapcar (function (lambda (el) (prin1 (append el (list f_name)) fl_w))) (read (strcat "(" ss ")")))
             (setq f_name ln
                   ss ""))))
  (mapcar (function (lambda (el) (prin1 (append el (list f_name)) fl_w))) (read (strcat "(" ss ")")))
  (princ "))" fl_w)
  (close fl_r)
  (close fl_w))

(defun wcmatch-case (str pattern) (wcmatch (strcase str) (strcase pattern)))

