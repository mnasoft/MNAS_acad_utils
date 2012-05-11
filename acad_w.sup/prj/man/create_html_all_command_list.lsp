(defun create_cmd_html (/ fl)
  (load (strcat (acad_sup) "\\prj\\man\\man_data_base.lsp")) ;;;
  (setq fl (open (strcat (acad_help) "\\mnasoft_command_list.php") "w")) ;;; cmd.html

  (princ (create-html-header) fl)
  (princ (javascript-show_hide-string) fl)
  
  (mapcar
    (function MNAS_command_help_tag_01)
    (re_sotr_by_type)
  ) 
 
  (close fl)
)

(defun MNAS_command_help_tag_01	(el)
  (setq
    tag	(car el)
    command-list
     (cdr el)
  )

  (princ "\n  <DIV>\n    <A href='javascript: show_hide(id)' onclick=\"show_hide('" fl)
  (princ tag fl)
  (princ "')\" ><H2>" fl)
  (princ tag fl)
  (princ "</H2></A>\n  </DIV>" fl)
  (princ "\n  <DIV Name='" fl)
  (princ tag fl)
  (princ "' ID='" fl)
  (princ tag fl)
  (princ "' Style='text-indent:15pt;display:none'>\n" fl)

  (mapcar
    (function
      (lambda (el)
	(princ
	  (strcat
	    "    <P>\n      <A HREF=\"./"
	    (car el)
	    "/"
	    (car el)
	    ".php\""
	    "\tNAME=\"command_"
	    (car el)
	    "\"> "
	    (car el)
	    " </A>\n        - "
	    (STRING-SUBST-ALL "</P><P>" "\n" (cadr el))
	    "</P>\n"
	  )
	  fl
	)
      )
    )
    command-list
  )

  (princ "  </DIV>" fl)


  (princ)
)


(defun string-subst-all	(new-str pattern string / do)
  (setq do t)
  (while do
    (setq str-rez (vl-string-subst new-str pattern string))
    (if	(/= str-rez string)
      (setq string str-rez)
      (setq do nil)
    )
  )
  string
)

(defun create-html-header ()
  (strcat
    "<HTML>"                                                                          "\n"
    "  <HEAD>"                                                                        "\n"
    "    <META HTTP-EQUIV=\"CONTENT-TYPE\" CONTENT=\"text/html; charset=1251\">"      "\n"
    "    <TITLE>Перечень команд пакета MNAS_acad_utils функций по категориям</TITLE>" "\n"
    "    <META NAME=\"AUTHOR\" CONTENT=\"Николай Матвеев\">"                          "\n"
    "    <META NAME=\"CREATED\" CONTENT=\"" (type-html-date) "\">"                    "\n"
    "  </HEAD>"                                                                       "\n"
    ""                                                                                "\n"
    "  <BODY LANG=\"ru-RU\" DIR=\"LTR\">"                                             "\n"
    "  <H1>"                                                                          "\n"
    "    <P>Перечень команд пакета MNAS_acad_utils функций по категориям<P>"          "\n"
    "  </H1>"                                                                         "\n"
    "  <BR />"                                                                        "\n"
   )
)

(defun type-html-date (/ date-time)
  (setq
    date-time (getvar "cdate")
    date (fix date-time )
    time (fix (* 1e8 (- date-time date)))
  )
  (strcat
    (itoa date)
    ";"
    (itoa time)
  )
)

(defun javascript-show_hide-string ()
  (strcat
    "  <script>"                                   "\n"
    "    <!--"                                     "\n"
    "    function show_hide(id)"                   "\n"
    "    {"                                        "\n"
    "      var id = document.getElementById(id) ;" "\n"
    "      if (id.style.display == \"none\")"      "\n"
    "      {"                                      "\n"
    "        id.style.display = \"block\";"        "\n"
    "      }"                                      "\n"
    "      else"                                   "\n"
    "      {"                                      "\n"
    "        id.style.display = \"none\";"         "\n"
    "      }"                                      "\n"
    "    }"                                        "\n"
    "    -->"                                      "\n"
    "  </script>"                                  "\n"
   )
)


(defun re_sotr_by_type ( / mnas_command_help new_lst )
  (load (strcat (acad_sup) "\\prj\\man\\man_data_base.lsp"))
  (setq	MNAS_command_help
	 (vl-sort
	   MNAS_command_help
	   (function
	     (lambda (a1 a2)
	       (cond
		 (
		  (< (nth 2 a1) (nth 2 a2))
		 )
		 (
		  (= (nth 2 a1) (nth 2 a2))
		  (< (nth 0 a1) (nth 0 a2))
		 )
	       )
	     )
	   )
	 )
  )

  (mapcar
    (function
      (lambda (el / tag sub_list new_sub_list)
	(setq tag (nth 2 el))
	(setq sub_list (assoc tag new_lst))
	(setq new_sub_list (list (nth 0 el) (nth 1 el) (nth 3 el)))
	(cond
	  ((null sub_list)
	   (setq
	     new_lst (append new_lst (list (list tag new_sub_list)))
	   )
	  )
	  (t
	   (setq new_lst (subst	(append sub_list (list new_sub_list))
				sub_list
				new_lst
			 )
	   )
	  )
	)
	t
      )
    )
    MNAS_command_help
  )
  new_lst
)

;|«Visual LISP© Format Options»
(72 2 5 2 nil "end of" 60 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
