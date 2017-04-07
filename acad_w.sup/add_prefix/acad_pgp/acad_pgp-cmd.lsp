;;;;;;("acad_pgp"
;;;;;;"Производит поиск и разбор файла acad.pgp,
;;;;;; применяющегося для задания абревиатур команд в текущей версии ACAD
;;;;;; для текушего пользователя.
;;;;;; Выводит на экран содержимое разобранного pgp файла.
;;;;;; После каждой аббревиатуры, найденной в исходном файле,
;;;;;; добавляется абревиатура набранная по тем же клавишам но в русской раскладке.
;;;;;; Исходный pgp файл не изменяется.
;;;;;; Изменения, при необходимости, следует вносить вручную,
;;;;;; копируя результат работы программы поверх содержимого исходного pgp файла." "not defined")
(defun c:acad_pgp  (/ abrev_str abrev_str_tr command_str lst_str fl_in fn lst_abrev_command str str1 str2 str3 str4)
  (setq fn (findfile "acad.pgp"))
  (if (null fn)
    (progn (alert (princ "Не могу найти файл acad.pgp.\n")) (exit)))
  (setq fl_in (open fn "r"))
  (if (null fl_in)
    (progn (file-open-err fn) (exit)))
  (write-line (strcat " ... " fn " ..."))
  (while (setq str (read-line fl_in))
    (cond ((= str "") (write-line str))
          ((= (substr str 1 1) " ") (write-line str))
          ((= (substr str 1 1) ";") (write-line str))
          (t
           (setq lst_str (str_token str ","))
           (cond ((< (length lst_str) 2) (write-line str))
                 ((> (length lst_str) 2) (write-line str))
                 (t
                  (setq abrev_str (car lst_str)
                        abrev_str (vl-string-left-trim " \t\n" abrev_str)
                        abrev_str (vl-string-right-trim " \t\n" abrev_str)
                        abrev_str (vl-string-translate str_keyboard str_opchatka abrev_str))
                  (setq command_str (cadr lst_str)
                        command_str (vl-string-left-trim " \t\n" command_str)
                        command_str (vl-string-right-trim " \t\n" command_str))
                  (write-line str)
                  (write-line (strcat abrev_str ", " command_str)))))))
  (close fl_in)
  (write-line (strcat " ...  " fn "..."))
  (princ))

(defun copy-files-MNAS_ARXPRJ_ROAMABLEROOTPREFIX  (dir file-name-list / d-from d-to)
  (setq d-from (vl-string-translate "\\" "/" (strcat (MNAS_ARXPRJ_ROAMABLEROOTPREFIX) dir))
        d-to   (vl-string-translate "\\" "/" (strcat (getvar "ROAMABLEROOTPREFIX") dir)))
  (mapcar (function (lambda (el) (vl-file-copy (strcat d-from el) (strcat d-to el)))) file-name-list))

(defun delete-files-RoamableRootPrefix  (dir file-name-list / d-from)
  (setq d-from (vl-string-translate "\\" "/" (strcat (getvar "ROAMABLEROOTPREFIX") dir)))
  (mapcar (function (lambda (el) (vl-file-delete (strcat d-from el)))) file-name-list))

(defun setup-Ploters  ()
  (copy-files-MNAS_ARXPRJ_ROAMABLEROOTPREFIX
    "Plotters/"
    '("A mxn DWG To PDF.pc3")))

(defun setup-ploters-Plot_Styles  ()
  (copy-files-MNAS_ARXPRJ_ROAMABLEROOTPREFIX
    "Plotters/Plot Styles/"
    '("BW_015_030.ctb" "BW_020_040.ctb" "BW_025_050.ctb" "BW_030_060.ctb" "CL_030_060.ctb")))

(defun delete-Ploters  ()
  (delete-files-RoamableRootPrefix "Plotters/" '("A mxn DWG To PDF.pc3")))

(defun delete-Ploters-Plot_Styles  ()
  (delete-files-RoamableRootPrefix "Plotters/Plot Styles/"
    '("BW_015_030.ctb" "BW_020_040.ctb" "BW_025_050.ctb" "BW_030_060.ctb" "CL_030_060.ctb")))

(defun c:mnasoft-utils-install () (setup-Ploters) (setup-ploters-Plot_Styles))

(defun c:mnasoft-utils-uninstall () (delete-Ploters) (delete-ploters-Plot_Styles))
