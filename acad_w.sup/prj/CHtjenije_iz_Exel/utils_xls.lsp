;;; ���������� �������������� ������ Exel �������� � ���������� ������� � ������,
;;; ��� �� ������ ����� ���� ������, � �� ������ �������.
;;;_$ (������_xls->����� "S2")
;;;(2 19)
(defun ������_xls->����� (str / lst_09 lst_AZ)
  (mapcar
    (function
      (lambda (el)
	(cond
	  ((and (>= el (ascii "A")) (<= el (ascii "Z")))
	   (setq lst_AZ
		  (cons (- el 64) lst_AZ)
	   )
	  )
	  ((and (>= el (ascii "0")) (<= el (ascii "9")))
	   (setq lst_09
		  (cons (- el 48) lst_09)
	   )
	  )
	)
	t
      )
    )
    (reverse (VL-STRING->LIST (strcase str)))
  )
  (list (����������_��_��������� lst_09 10) (����������_��_��������� lst_az 26))
)

;;;����������� ������ �������� str, �������������� ����� �����,
;;;�������������� � ������� ��������� � ���������� base � ������� ��� ���� ������� � Exel,
;;;� ����� �����.
;;;
;;;_$ (������_XLS->����� "AA" "A" 26)
;;;27
;;;_$ (������_XLS->����� "IV" "A" 26)
;;;256
(defun ������_xls->����� (str							;������������� ������
			  base_chr						;���������� ������ � ������� ���������
			  base							;��������� ������� ���������
			  / delta)
  (setq delta (1- (ascii base_chr)))
  (����������_��_���������
    (mapcar
      (function
	(lambda	(el)
	  (- el delta)
	)
      )
      (vl-string->list str)
    )
    base
  )
)


;;;���������� �������������� ������ ����� � ������ ��������.
;;;���������� ����������� ������� � ������� Exel.
;;;������ ������� - "A", ������ - "B", 26 - "Z", 27 - "AA", 256 - "IV"
;;;
;;;_$ (�����->������_xls 1 "A" 26)
;;;"A"
;;;_$ (�����->������_xls 2 "A" 26)
;;;"B"
;;;_$ (�����->������_xls 26 "A" 26)
;;;"Z"
;;;_$ (�����->������_xls 27 "A" 26)
;;;"AA"
;;;_$ (�����->������_xls 256 "A" 26)
;;;"IV"
(defun �����->������_xls (i							; ������������� �����
			  base_chr						; ��������� ������ ������� ���������
			  base							; ��������� ������� ���������
			 )
  (apply
    (function strcat)
    (mapcar
      (function
	(lambda	(el)
	  (�����->������_xls el base_chr)
	)
      )
      (��������������_�_�����������_���� (����������_��_��������� i base) base)
    )
  )
)

;;;������������ ��������� �������� �����->������_xls.
;;;_$ (�����->������_xls 0 "A")
;;;"@"
;;;_$ (�����->������_xls 1 "A")
;;;"A"
(defun �����->������_xls (i							; ������������� �����
			  base_chr						; ��������� ������ ������� ���������
			  )
  (chr (+ (ascii base_chr) i -1))
)

;;;������������ ��������� �������� �����->������_xls.
;;;����������� ������ �������� ��������, ������������ ���������� �� �������� ����� �����,
;;;���������� � ������� ��������� � ���������� basa, � ������, � �������� � �������� ����������� 0.
;;;�������� ��������� ������, �������������� ������� ����� �� ��������������, ����� ���������� � ��������� [0 basa-1].
;;;�������� ��������� ������, �������������� ������� ���������������� �����, ����� ���������� � ��������� [1 basa].
;;;������� ������� ��������� � ������ ������.
;;;
;;;_$ (��������������_�_�����������_���� '(25 0 11 0 13) 26)
;;;(24 26 10 26 13)
;;;_$ (��������������_�_�����������_���� '(1 0 0 1 0 1) 2)
;;;(1 1 2 2 1)
(defun ��������������_�_�����������_���� (lst basa / n_null ln i lst1 lst_1 val)
  (while (setq n_null (�����_�������_���� lst 0))
    (setq
      ln   (length lst)
      i	   ln
      lst1 nil
    )
    (while (>= (setq i (1- i)) 0)
      (cond
	((= i n_null)
	 (setq val basa)
	)
	((= i (1- n_null))
	 (setq val (1- (nth i lst)))
	)
	(t
	 (setq val (nth i lst))
	)
      )
      (setq lst1 (cons val lst1))
    )
    (if	(= (car lst1) 0)
      (setq lst (cdr lst1))
      (setq lst lst1)
    )
  )
  lst
)

;;;������������ ��������� �������� ��������������_�_�����������_����.
;;;���������� ����� ������� ���������� � ������ ��������, �������� �������� ����� 0,
;;;��� nil, ���� ����� ������� �� ��� ������.
;;;����� ������� ������� � �������� n_start. ������ ������� ������ ����� ����� 0.
;;;
;;;_$ (�����_�������_���� '(0 1 2 3 0) 0)
;;;0
;;;_$ (�����_�������_���� '(0 1 2 3 0) 1)
;;;4
;;;_$ (�����_�������_���� '(1 0 3 4) 2)
;;;nil
(defun �����_�������_���� (lst							;������.
			   n_start						;����� �������� � �������� ���������� �����.
			   / do_while rez ln)
  (setq
    ln	     (length lst)
    do_while (< n_start ln)
  )
  (while do_while
    (cond
      ((= 0 (nth n_start lst))
       (setq
	 do_while nil
	 rez n_start
       )
      )
      ((= n_start ln)
       (setq
	 do_while nil
	 rez nil
       )
      )
      ((< n_start ln)
       (setq
	 n_start (1+ n_start)
       )
      )
    )
  )
  rez
)

;;;���������� ������ ������ �� ������� Exel
(defun read_exel
		 (xls_tbl_pathname						;���� � ��� ����� �������� ������� Exel
		  sheet_no							;����� �������� ��� ������ ������
		  cell_lt							; ����� ������� ������
		  cell_rb							; ������ ������ ������
		  / oex								;"Excel.Application"
		  wbs								;"Workbooks"
		  awb								;�������� ������� �����
		  shs								;"Sheets"
		  csh								;������� ����
		  matrix							;�������������� �������
)
  (vl-load-com)
  (setq oex (vlax-get-or-create-object "Excel.Application"))
  (vlax-put-property oex "Visible" :vlax-true)

  (setq wbs (vlax-get-property oex "Workbooks"))
  (setq	awb (vlax-invoke-method
	      wbs
	      "Open"
	      xls_tbl_pathname
	    )
  )
  (setq shs (vlax-get-property awb "Worksheets"))
  (setq csh (vlax-get-property shs "Item" sheet_no))
										;(vlax-put-property csh "Name" "Cool")
  (setq	matrix
	 (read_csh csh cell_lt cell_rb)
  )
  (vlax-invoke-method oex "Quit")
)

;;; ������ �������� �����
;;; (read_csh csh "A1" "B3")
(defun read_csh	(csh								; ������� ���� Exel
		 cell_lt							; ����� ������� ������
		 cell_rb							; ������ ������ ������
		 / cell								;������� ������
		 column_row							;�������������� �������
		 do_column							;������� ������ �� ����� �� �������� ������
		 do_row								;������� ������ �� ����� �� �������
		 i_column							;������� �������
		 i_row								;������� ������
		 pnt_lt								;���������� ����� ������� ������
		 pnt_rb								;���������� ������ ������  ������
		 row_list							;������ ���������� �������� ������� ������
		 var								;������� ����������� � ������ cell
		 var_type							;��� ��������
		 var_val							;�������� ��������
)
  (setq
    pnt_lt     (������_xls->����� cell_lt)
    pnt_rb     (������_xls->����� cell_rb)
    i_row      (car pnt_lt)
    do_row     t
    column_row nil
  )
  (while do_row
    (setq i_column (cadr pnt_lt))
    (setq cell
		   (vlax-variant-value
		     (vlax-invoke-method
		       csh
		       "Evaluate"
		       (strcat (�����->������_xls i_column "A" 26) (itoa i_row))
		     )
		   )
	  var	   (vlax-get-property cell "Value")
	  var_type (vlax-variant-type var)
	  var_val  (vlax-variant-value var)
	  do_row   var_val
    )										; ����������� ����, ��������-�� ������ ������ ������
    (setq
      do_column	t
      row_list nil
    )
    (while do_column
      (setq cell      (vlax-variant-value
			(vlax-invoke-method csh "Evaluate" (strcat (�����->������_xls i_column "A" 26) (itoa i_row)))
		      )
	    var	      (vlax-get-property cell "Value")
	    var_type  (vlax-variant-type var)
	    var_val   (vlax-variant-value var)
	    do_column var_val
      )
      (if var_val
	(setq row_list (append row_list (list var_val)))
      )
      (cond
	((and (< i_column 256) (< i_column (cadr pnt_rb)))
	 (setq i_column (1+ i_column))
	)
	(t
	 (setq do_column nil)
	)
      )
    )
    (if	row_list
      (setq column_row (append column_row (list row_list)))
    )

    (cond
      ((and (< i_row 65536) (< i_row (car pnt_rb)))
       (setq i_row (1+ i_row))
      )
      (t
       (setq do_row nil)
      )
    )
  )
  column_row
)