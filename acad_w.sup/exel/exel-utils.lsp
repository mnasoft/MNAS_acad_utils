;;; ���������� �������������� ������ Exel �������� � ���������� ������� � ������,
;;; ��� �� ������ ����� ���� ������, � �� ������ �������.
;;;_$ (������_xls->����� "S2")
;;;(2 19)
(DEFUN ������_xls->�����  (str / lst_09 lst_az)
  (MAPCAR (FUNCTION
            (LAMBDA (el)
              (COND ((AND (>= el (ASCII "A")) (<= el (ASCII "Z"))) (SETQ lst_az (CONS (- el 64) lst_az)))
                    ((AND (>= el (ASCII "0")) (<= el (ASCII "9"))) (SETQ lst_09 (CONS (- el 48) lst_09))))
              T))
          (REVERSE (VL-STRING->LIST (STRCASE str))))
  (LIST (����������_��_��������� lst_09 10) (����������_��_��������� lst_az 26)))

;;;����������� ������ �������� str, �������������� ����� �����,
;;;�������������� � ������� ��������� � ���������� base � ������� ��� ���� ������� � Exel,
;;;� ����� �����.
;;;
;;;_$ (������_XLS->����� "AA" "A" 26)
;;;27
;;;_$ (������_XLS->����� "IV" "A" 26)
;;;256
(DEFUN ������_xls->�����  (str          ;������������� ������
                           base_chr     ;���������� ������ � ������� ���������
                           base         ;��������� ������� ���������
                           / delta)
  (SETQ delta (1- (ASCII base_chr)))
  (����������_��_��������� (MAPCAR (FUNCTION (LAMBDA (el) (- el delta))) (VL-STRING->LIST str)) base))




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
(DEFUN �����->������_xls  (i            ; ������������� �����
                           base_chr     ; ��������� ������ ������� ���������
                           base         ; ��������� ������� ���������
                           )
  (APPLY (FUNCTION STRCAT)
         (MAPCAR (FUNCTION (LAMBDA (el) (�����->������_xls el base_chr)))
                 (��������������_�_�����������_���� (����������_��_��������� i base) base))))

;;;������������ ��������� �������� �����->������_xls.
;;;_$ (�����->������_xls 0 "A")
;;;"@"
;;;_$ (�����->������_xls 1 "A")
;;;"A"
(DEFUN �����->������_xls  (i            ; ������������� �����
                           base_chr     ; ��������� ������ ������� ���������
                           )
  (CHR (+ (ASCII base_chr) i -1)))

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
(DEFUN ��������������_�_�����������_����  (lst basa / n_null ln i lst1 lst_1 val)
  (WHILE (SETQ n_null (�����_�������_���� lst 0))
    (SETQ ln   (LENGTH lst)
          i    ln
          lst1 nil)
    (WHILE (>= (SETQ i (1- i)) 0)
      (COND ((= i n_null) (SETQ val basa))
            ((= i (1- n_null)) (SETQ val (1- (NTH i lst))))
            (T (SETQ val (NTH i lst))))
      (SETQ lst1 (CONS val lst1)))
    (IF (= (CAR lst1) 0)
      (SETQ lst (CDR lst1))
      (SETQ lst lst1)))
  lst)

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
(DEFUN �����_�������_����  (lst         ;������.
                            n_start     ;����� �������� � �������� ���������� �����.
                            / do_while rez ln)
  (SETQ ln       (LENGTH lst)
        do_while (< n_start ln))
  (WHILE do_while
    (COND ((= 0 (NTH n_start lst))
           (SETQ do_while nil
                 rez n_start))
          ((= n_start ln)
           (SETQ do_while nil
                 rez nil))
          ((< n_start ln) (SETQ n_start (1+ n_start)))))
  rez)

;;;���������� ������ ������ �� ������� Exel
(DEFUN read_exel  (xls_tbl_pathname     ;���� � ��� ����� �������� ������� Exel
                   sheet_no             ;����� �������� ��� ������ ������
                   cell_lt              ; ����� ������� ������
                   cell_rb              ; ������ ������ ������
                   / oex                ;"Excel.Application"
                   wbs                  ;"Workbooks"
                   awb                  ;�������� ������� �����
                   shs                  ;"Sheets"
                   csh                  ;������� ����
                   matrix               ;�������������� �������
) (VL-LOAD-COM)
  (SETQ oex (VLAX-GET-OR-CREATE-OBJECT "Excel.Application"))
  (VLAX-PUT-PROPERTY oex "Visible" :VLAX-TRUE)
  (SETQ wbs (VLAX-GET-PROPERTY oex "Workbooks"))
  (SETQ awb (VLAX-INVOKE-METHOD wbs "Open" xls_tbl_pathname))
  (SETQ shs (VLAX-GET-PROPERTY awb "Worksheets"))
  (SETQ csh (VLAX-GET-PROPERTY shs "Item" sheet_no)) ;(vlax-put-property csh "Name" "Cool")
  (SETQ matrix (read_csh csh cell_lt cell_rb))
  (VLAX-INVOKE-METHOD oex "Quit"))

;;; ������ �������� �����
;;; (read_csh csh "A1" "B3")
(DEFUN read_csh  (csh                   ; ������� ���� Exel
                  cell_lt               ; ����� ������� ������
                  cell_rb               ; ������ ������ ������
                  /                     ;
                  cell                  ;������� ������
                  column_row            ;�������������� �������
                  do_column             ;������� ������ �� ����� �� �������� ������
                  do_row                ;������� ������ �� ����� �� �������
                  i_column              ;������� �������
                  i_row                 ;������� ������
                  pnt_lt                ;���������� ����� ������� ������
                  pnt_rb                ;���������� ������ ������  ������
                  row_list              ;������ ���������� �������� ������� ������
                  var                   ;������� ����������� � ������ cell
                  var_type              ;��� ��������
                  var_val               ;�������� ��������
) (SETQ pnt_lt     (������_xls->����� cell_lt)
        pnt_rb     (������_xls->����� cell_rb)
        i_row      (CAR pnt_lt)
        do_row     T
        column_row nil)
  (WHILE do_row
    (SETQ i_column (CADR pnt_lt)
          cell     (vlax-variant-value
                     (vlax-invoke-method csh "Evaluate" (STRCAT (�����->������_xls i_column "A" 26) (ITOA i_row))))
          var      (vlax-get-property cell "Value")
          var_type (vlax-variant-type var)
          var_val  (vlax-variant-value var)
          do_row   var_val)             ; ����������� ����, ��������-�� ������ ������ ������
    (SETQ do_column T
          row_list nil)
    (WHILE do_column
      (SETQ cell      (vlax-variant-value
                        (vlax-invoke-method csh "Evaluate" (STRCAT (�����->������_xls i_column "A" 26) (ITOA i_row))))
            var       (vlax-get-property cell "Value")
            var_type  (vlax-variant-type var)
            var_val   (vlax-variant-value var)
            do_column var_val)
      (IF var_val
        (SETQ row_list (APPEND row_list (LIST var_val))))
      (COND ((AND (< i_column 256) (< i_column (CADR pnt_rb))) (SETQ i_column (1+ i_column)))
            (T (SETQ do_column nil))))
    (IF row_list
      (SETQ column_row (APPEND column_row (LIST row_list))))
    (COND ((AND (< i_row 65536) (< i_row (CAR pnt_rb))) (SETQ i_row (1+ i_row)))
          (T (SETQ do_row nil))))
  column_row)

(DEFUN read-exel-sheet-by-row  (csh     ; ������� ���� Exel
                                cell_lt ; ����� ������� ������
                                cell_rb ; ������ ������ ������
                                /       ;
                                cell    ;������� ������
                                row_column ;�������������� �������
                                do_column ;������� ������ �� ����� �� �������� ������
                                do_row  ;������� ������ �� ����� �� �������
                                i_column ;������� �������
                                i_row   ;������� ������
                                pnt_lt  ;���������� ����� ������� ������
                                pnt_rb  ;���������� ������ ������  ������
                                col_list ;������ ���������� �������� �������� �������
                                var     ;������� ����������� � ������ cell
                                var_type ;��� ��������
                                var_val ;�������� ��������
) (SETQ pnt_lt     (������_xls->����� cell_lt)
        pnt_rb     (������_xls->����� cell_rb)
        i_column   (CADR pnt_lt)
        do_column  T
        row_column nil)
  (WHILE do_column
    (SETQ i_row     (CAR pnt_lt)
          cell      (vlax-variant-value
                      (vlax-invoke-method csh "Evaluate" (STRCAT (�����->������_xls i_column "A" 26) (ITOA i_row))))
          var       (vlax-get-property cell "Value")
          var_type  (vlax-variant-type var)
          var_val   (vlax-variant-value var)
          do_column var_val)            ; ����������� ����, ��������-�� ������ ������ ������
    (SETQ do_row T
          col_list nil)
    (WHILE do_row
      (SETQ cell      (vlax-variant-value
                        (vlax-invoke-method csh "Evaluate" (STRCAT (�����->������_xls i_column "A" 26) (ITOA i_row))))
            var       (vlax-get-property cell "Value")
            var_type  (vlax-variant-type var)
            var_val   (vlax-variant-value var)
            do_column var_val)
      (IF var_val
        (SETQ col_list (APPEND col_list (LIST var_val))))
      (COND ((AND (< i_column 16000) (< i_column (CADR pnt_rb))) (SETQ i_column (1+ i_column)))
            (T (SETQ do_column nil))))
    (IF row_list
      (SETQ column_row (APPEND column_row (LIST row_list))))
    (COND ((AND (< i_row 65536) (< i_row (CAR pnt_rb))) (SETQ i_row (1+ i_row)))
          (T (SETQ do_row nil))))
  row_column)
