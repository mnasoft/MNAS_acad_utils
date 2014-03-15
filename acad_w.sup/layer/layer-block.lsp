;;;;;;("bl_off"
;;;;;;"��������� ����, �������� � ����, ��� �������� �� ������ � ������� �����." "����")
(defun c:bl_off	(/ la)
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (setq	la
	 (cdr
	   (assoc 8
		  (entget
		    (car
		      (nentsel
			"\n�������� ������� �����, ���� �������� ����� ��������:"
		      )
		    )
		  )
	   )
	 )
  )
  (COMMAND "-layer" "off" la)
  (if_cmd_active)
  (err-handle "")
)


;;;;;;("bl_fr"
;;;;;;  "������������ ����, �������� � ����, ��� �������� �� ������ � ������� �����." "����")
(defun c:bl_fr (/ la)
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (setq	la
	 (cdr
	   (assoc 8
		  (entget
		    (car
		      (nentsel
			"\n�������� ������� �����, ���� �������� ����� ���������:"
		      )
		    )
		  )
	   )
	 )
  )
  (COMMAND "-layer" "fr" la)
  (if_cmd_active)
  (err-handle "")
)

;;;;;;("bl_all_on" "�������� ��� ����, �������� � ������ �����." "����")
(defun c:bl_all_on (/ bl_name ed ed_tbl en en_1 la la_lst)
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (setq str (bl_all))
  (COMMAND "-layer" "on" str)
  (if_cmd_active)
  (err-handle "")
)

;;;;;;("bl_all_th" "������������� ��� ����, �������� � ������ �����." "����")
(defun c:bl_all_th (/ str)
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (setq str (bl_all))
  (COMMAND "-layer" "thaw" str)
  (if_cmd_active)
  (err-handle "")
)

;; ���������� ������ ����� �������������� � ���������, ������������ �����.
(defun bl_all (/ bl_name ed ed_tbl en en_1 la la_lst)
  (setq
    en	    (car (entsel "�������� ����:"))
    ed	    (entget en)
    bl_name (cdr (assoc 2 ed))
    ed_tbl  (tblsearch "block" bl_name)
    en_1    (cdr (assoc -2 ed_tbl))
  )
  (while en_1
    (setq
      la     (cdr (assoc 8 (entget en_1)))
      la_lst (cons la la_lst)
      en_1   (entnext en_1)
    )
  )
  (setq la_lst (bin_or la_lst))
  (str_comma la_lst ",")
)

;; ������� �� ������ ���������� ����� lst ������, ��������� �� ���� �����
;; ����� �������� ��������� �������������� ������ comma.
;; ��������:
;; (str_comma '("layer1" "2" "3" ) ",")
;; "layer1,2,3"
(defun str_comma (lst comma / str)
  (setq str (car lst))
  (mapcar
    (function
      (lambda (el)
	(setq str (strcat str comma el))
      )
    )
    (cdr lst)
  )
  str
)
