;;;;;;("check_command_category_list"
;;;;;;"��������� ������������ ��������� ������� � lsp-������. ������� �������� ������������ ��������."
;;;;;;"�������")
(defun c:check_command_category_list  (/ i command_category_list a-el)
  (setq command_category_list
         (list "not defined"   "������������"  "������� �����" "������"        "���������"     "�����"
               "�������"       "���������"     "�������"       "�������"       "����"          "���������"
               "�������"       "������"        "�����"         "�����"))
  (load (findfile "acad_w.sup/man/man-data_base.lsp"))
  (setq i 0
        i (foreach a-el  mnas_command_help
            (if (/= 4 (length a-el))
              (progn (print a-el) (princ "\n") (setq i (1+ i))))
            i))
  (princ "\n������ ������ ��������.")
  (if (= i 0)
    (princ "\n������������ �������� �� �������."))
  (princ (strcat "\n������� " (itoa i) " ������������ ��������."))
  (princ))

;;;(mapcar (function (lambda (el)
;;;                      (setq len (length el))
;;;                      (if (/= 4 len)
;;;                        (progn (print el) (princ "\n") (setq i (1+ i))))
;;;                      len))
;;;          mnas_command_help)







