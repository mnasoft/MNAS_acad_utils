;;;;;;("read_exel" "������ �� Exel." "�����")
(defun c:read_exel (/ xls_tbl_pathname						; ���� � ����������� �������
		    sheet_no							; ����� ����������� �� Exel �������
		    cell_lt							; ����� ������� ������
		    cell_rb							; ������ ������ ������
)
  (setq	xls_tbl_pathname
	 (getfiled "���������" "" "xls" 0)
  )
  (setq sheet_no (getint "������� ����� �������� Exel:"))
  (setq	cell_lt	(getstring "����� ������� ������<A1>:")
	cell_lt
		(cond
		  ((= "" cell_lt)
		   "A1"
		  )
		  (cell_lt)
		)
  )

  (setq	cell_rb	(getstring "������ ������ ������ �� ��������� �����:")
	cell_rb
		(cond
		  ((= "" cell_rb)
		   "IV65536"
		  )
		  (cell_rb)
		)
  )
  (read_exel xls_tbl_pathname sheet_no cell_lt cell_rb)
)