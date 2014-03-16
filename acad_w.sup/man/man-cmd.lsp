;;;;;;("man"
;;;;;;"
;;;;;;������� ����������� ���������� ���������� �� ��������, ������������ �������������.\n
;;;;;;   Command  - ��������� ���������� ����� ������� �� ������� � ����� � ������� ���������� ���������� ���;\n
;;;;;;   Keywords - ��������� ���������� ����� ������� �� ������� � �������� ������� � ������� ���������� ���������� ���;\n
;;;;;;   List     - ������� �������� �����, ������������ �������������;\n
;;;;;;   Rebuild  - ��������� ���������� ���������� �� lsp - ������, ������������ ���� ������ ������;\n
;;;;;;   ����������: ��� ������������� ����� Rebuild � ������ ������ ������: (malform-list) ���������� ����� �
;;;;;; ����� /man/man-data_base.lsp ��������� ��������� ������ � ����� ��������������� ��� ������
;;;;;; � ����� /man/man_data.txt ������ ����� ����.
;;;;;;" "�������")
(DEFUN c:man (/				;
	      l_cmds			;
	      do			; ���������� �����.
	     )
  (man-load-func)
  (SETQ do T)
  (WHILE do
    (INITGET "Command List Keywords Function Rebuild loAd Html Exit")
    (SETQ kw (GETKWORD "Select option [Command/List/Keywords/Function/Rebuild/loAd/Html] <Exit>:"))
    (COND
      ((= kw nil)
       (SETQ do nil)
      )
      ((= kw "Exit")
       (SETQ do nil)
      )
      ((= kw "loAd")
       (man-load-func)
      )
      ((= kw "List")
       (SETQ
	 l_cmds	(MAPCAR (FUNCTION CAR) mnas_command_help)
       )
       (MAPCAR
	 (FUNCTION
	   (LAMBDA (el)
	     (PRINC el)
	     (PRINC "\n")
	   )
	 )
	 (VL-SORT l_cmds (FUNCTION <))
       )
      )

      ((= kw "Keywords")
       (SETQ pattern (GETSTRING "\n������� ������ ���������� ������� ��� ������ �������:"))
       (MAPCAR
	 (FUNCTION
	   (LAMBDA (el)
	     (IF (wcmatch-case (CADR el) pattern)
	       (PROGN
		 (PRINC (STRCAT "�������: " (CAR el) "\n"))
		 (PRINC	(STRCAT "�������� �������:" "\n" (CADR el) "\n\n")
		 )
	       )
	     )
	   )
	 )
	 mnas_command_help
       )
      )
      ((= kw "Rebuild")
       (man-rebuild)
       (man-rebuild-func)
      )
      ((= kw "Html")
       (create_cmd_html)
      )
      ((= kw "Command")
       (SETQ pattern (GETSTRING "\n������� ������ ����� ������� ��� ������ �� ��������:"))
       (MAPCAR
	 (FUNCTION
	   (LAMBDA (el)
	     (IF (wcmatch-case (CAR el) pattern)
	       (PROGN
		 (PRINC (STRCAT "������� : " (CAR el) "\n"))
		 (PRINC (STRCAT "�������� ������� :\n" (CADR el) "\n\n"))
	       )
	     )
	   )
	 )
	 mnas_command_help
       )
      )
      ((= kw "Function")
       (SETQ pattern (GETSTRING "\n������� ������ ����� ������� ��� ������ �� ��������:"))
       (MAPCAR
	 (FUNCTION
	   (LAMBDA (el)
	     (IF (wcmatch-case (CAR el) pattern)
	       (PROGN
		 (PRINC (STRCAT "������� : " (CAR el) "\n"))
		 (PRINC (STRCAT "�������� ������� :\n" (CADR el) "\n\n"))
	       )
	     )
	   )
	 )
	 mnas_function_help
       )
      )
      (T
       (SETQ pattern kw)
       (MAPCAR
	 (FUNCTION
	   (LAMBDA (el)
	     (IF (wcmatch-case (CAR el) pattern)
	       (PROGN
		 (PRINC (STRCAT "������� : " (CAR el) "\n"))
		 (PRINC (STRCAT "�������� ������� :\n" (CADR el) "\n\n"))
	       )
	     )
	   )
	 )
	 mnas_command_help
       )
      )
    )
  )
  (PRINC)
)

(DEFUN man-load-func ()
  (LOAD (STRCAT (acad_sup) "/man/man-data_base.lsp"))
  (LOAD (STRCAT (acad_sup) "/man/man-data_base_func.lsp"))
)

;;;f;;;("man-rebuild"
;;;f;;;"Prj - man.\n
;;;f;;;File - man.lsp.
;;;f;;;���������� ���������� ���������� ���������� �� ������ *.lsp")
(DEFUN man-rebuild (/ asterix_semicolon fl_r fl_w fn_r fn_w f_name ln semicolon ss)
  (SETQ
    fn_w (STRCAT (acad_sup) "/man/man-data_base.lsp")
    fn_r (GETFILED "Select a Lisp File" (STRCAT (acad_sup) "/man/man_data.txt") "txt" 1)
  )
  (find-line-by_mask-in_directory_files
    (acad_sup)
    "*.lsp"
    (STRCAT "*;;;" ";;;*")
    fn_r
  )
  (SETQ
    fl_r (OPEN fn_r "r")
    fl_w (OPEN fn_w "w")
  )
  (COND
    ((NULL fl_r)
     (ALERT
       (PRINC
	 (STRCAT "�� ���� ������� ���� :" fn_r ".")
       )
     )
     (EXIT)
    )
    ((NULL fl_w)
     (ALERT
       (PRINC
	 (STRCAT "�� ���� ������� ���� :" fn_w ".")
       )
     )
     (EXIT)
    )
  )

  (PRINC "(setq MNAS_command_help '(" fl_w)
  (SETQ
    f_name	      ""
    ss		      ""
    semicolon	      (STRCAT ";;;" ";;;")
    asterix_semicolon (STRCAT "*" semicolon "*")
  )
  (WHILE (SETQ ln (READ-LINE fl_r))
    (IF	(wcmatch-case ln asterix_semicolon)
      (PROGN
	(SETQ
	  ln (VL-STRING-SUBST "" "\t\t" ln)
	  ln (VL-STRING-SUBST "" "\t" ln)
	  ln (VL-STRING-SUBST "" semicolon ln)
	  ss (STRCAT ss ln)
	)
      )
      (PROGN
	(MAPCAR
	  (FUNCTION
	    (LAMBDA (el)
	      (PRIN1 (APPEND el (LIST f_name)) fl_w)
	    )
	  )
	  (READ (STRCAT "(" ss ")"))
	)
	(SETQ f_name ln
	      ss ""
	)
      )
    )
  )
  (MAPCAR
    (FUNCTION
      (LAMBDA (el)
	(PRIN1 (APPEND el (LIST f_name)) fl_w)
      )
    )
    (READ (STRCAT "(" ss ")"))
  )
  (PRINC "))" fl_w)
  (CLOSE fl_r)
  (CLOSE fl_w)
)

;;;f;;;("dir_recursive" "����������� ����� ���� ��������� ������� � �������� directory.")
(DEFUN dir_recursive
		     (directory / d_curr d_list directory_list d_rez d_curr)
  (SETQ directory_list (CONS directory directory_list))
  (WHILE directory_list
    (SETQ
      d_curr	     (CAR directory_list)
      d_rez	     (APPEND d_rez (LIST d_curr))
      directory_list (CDR directory_list)
      d_list	     (VL-DIRECTORY-FILES d_curr "*" -1)
    )
    (IF	(= "." (CAR d_list))
      (SETQ d_list (CDR (CDR d_list)))
    )
    (SETQ
      d_list
		     (MAPCAR
		       (FUNCTION
			 (LAMBDA (el) (STRCAT d_curr "/" el))
		       )
		       d_list
		     )
      directory_list (APPEND d_list directory_list)
    )
  )
  d_rez
)

;;;f;;;("fname_recursive"
;;;f;;;"����������� ����� ���� ���� ������ � ������ fn_mask ������� � �������� directory.")
(DEFUN fname_recursive (directory fn_mask / fn_rez fn_rez)
  (MAPCAR
    (FUNCTION
      (LAMBDA (el)
	(SETQ
	  fn_rez (APPEND fn_rez
			 (MAPCAR (FUNCTION
				   (LAMBDA (el1) (STRCAT el "/" el1))
				 )
				 (VL-DIRECTORY-FILES el fn_mask 1)
			 )
		 )
	)
	T
      )
    )
    (dir_recursive directory)
  )
  fn_rez
)

;;;f;;;("find_line_by_mask"
;;;f;;;"���������� ����� ����� � ����� � ������ fname,\n
;;;f;;;��������������� ����� mask � ���������� �� ������ � ���� � ������������  f_out.\n
;;;f;;;���� f_out ������ ���� ������ �� ������.")
(DEFUN find_line_by_mask (fname mask f_out / fl str)
  (SETQ fl (OPEN fname "r"))
  (COND
    ((/= 'str (TYPE fname))
     (ALERT (PRINC "���������� fname �� �������� ����� �����."
	    )
     )

    )
    ((NULL fl)
     (ALERT
       (PRINC
	 (STRCAT "�� ���� ������� ���� :" fn_r ".")
       )
     )
     (EXIT)
    )
  )
  (WHILE
    (SETQ str
	   (READ-LINE fl)
    )
     (IF (wcmatch-case str mask)
       (PROGN (PRINC str f_out) (PRINC "\n" f_out))
     )
  )
  (CLOSE fl)
)

;;;f;;;("find-line-by_mask-in_directory_files"
;;;f;;;"���������� ����� �����, ��������������� ����� str_mask,\n
;;;f;;;� ������ � ������ ����� ����� file_mask\n
;;;f;;;������� � �������� directory ���������� ������ �� ������ ���������\n
;;;f;;;� ������� ������, ��������� � ������, � �������� ���� � ������ fn_out.")
(DEFUN find-line-by_mask-in_directory_files (directory file_mask str_mask fn_out / f_out)
  (SETQ f_out (OPEN fn_out "w"))
  (COND
    ((/= 'str (TYPE fn_out))
     (ALERT (PRINC "���������� fn_out �� �������� ����� �����."
	    )
     )

    )
    ((NULL f_out)
     (ALERT
       (PRINC
	 (STRCAT "�� ���� ������� ���� :" fn_out ".")
       )
     )
     (EXIT)
    )
  )
  (MAPCAR
    (FUNCTION
      (LAMBDA (el)
	(PRINC el f_out)
	(PRINC "\n" f_out)
	(find_line_by_mask el str_mask f_out)
      )
    )
    (fname_recursive directory file_mask)
  )
  (CLOSE f_out)
)

(DEFUN man-rebuild-func	(/ asterix_semicolon fl_r fl_w fn_r fn_w f_name ln semicolon ss)
  (SETQ
    fn_w	      (STRCAT (acad_sup) "/man/man-data_base_func.lsp")
    fn_r	      (GETFILED	"Select a Lisp File"
				(STRCAT (acad_sup) "/man/man_data_func.txt")
				"txt"
				1
		      )
    f_name	      ""
    ss		      ""
    semicolon	      (STRCAT ";;;" "f" ";;;")
    asterix_semicolon (STRCAT "*" semicolon "*")
  )
  (find-line-by_mask-in_directory_files (acad_sup) "*.lsp" asterix_semicolon fn_r)
  (SETQ
    fl_r (OPEN fn_r "r")
    fl_w (OPEN fn_w "w")
  )
  (COND
    ((NULL fl_r)
     (ALERT
       (PRINC
	 (STRCAT "�� ���� ������� ���� :" fn_r ".")
       )
     )
     (EXIT)
    )
    ((NULL fl_w)
     (ALERT
       (PRINC
	 (STRCAT "�� ���� ������� ���� :" fn_w ".")
       )
     )
     (EXIT)
    )
  )

  (PRINC "(setq MNAS_function_help '(" fl_w)

  (WHILE (SETQ ln (READ-LINE fl_r))
    (IF	(wcmatch-case ln asterix_semicolon)
      (PROGN
	(SETQ
	  ln (VL-STRING-SUBST "" "\t\t" ln)
	  ln (VL-STRING-SUBST "" "\t" ln)
	  ln (VL-STRING-SUBST "" semicolon ln)
	  ss (STRCAT ss ln)
	)
      )
      (PROGN
	(MAPCAR
	  (FUNCTION
	    (LAMBDA (el)
	      (PRIN1 (APPEND el (LIST f_name)) fl_w)
	    )
	  )
	  (READ (STRCAT "(" ss ")"))
	)
	(SETQ f_name ln
	      ss ""
	)
      )
    )
  )
  (MAPCAR
    (FUNCTION
      (LAMBDA (el)
	(PRIN1 (APPEND el (LIST f_name)) fl_w)
      )
    )
    (READ (STRCAT "(" ss ")"))
  )
  (PRINC "))" fl_w)
  (CLOSE fl_r)
  (CLOSE fl_w)
)

(DEFUN wcmatch-case (str pattern)
  (WCMATCH (STRCASE str) (STRCASE pattern))
)
;|�Visual LISP� Format Options�
(120 2 40 2 nil "end of" 100 15 2 1 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
