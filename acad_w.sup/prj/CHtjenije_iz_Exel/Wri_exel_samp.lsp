; �.�. �������, 2003
;===================================================
; ��������� COM-����� AutoCAD - Microsoft Excel 2002
;===================================================
; ��������� �������������� ������ � ����������� ���� ����� Excel
;
; ���������:
; shname1, shname2 � ����� ������;
; bname � ��� ������������ �����.
;
; ���������� ����������:
; g_oex - VLA-������ ���������� Excel 2002;
; g_wbs - VLA-������ ��������� Workbooks;
; g_cb - VLA-������ ������� �����;
; g_csh - VLA-������ ������� �����;
; g_sh2 - VLA-������ ������� �����;
; g_shs - VLA-������ ��������� Sheets;
; g_r1, g_r2, g_cr - VLA-������� ���������� �����.
;
; ������� ��������� � ���������:
; (writeex10_com "������� (����� 1)" "������ 2" "d:\\r 16\\ExportBook")
; (writeex10_com "�����" "�����" "d:\\r 16\\ExportBook1")
(defun writeex10_com (shname1 shname2 bname /)
  (vl-load-com)
					; ��������� Excel ��� �������� ����
  ;(setq g_oex (vlax-get-or-create-object "Excel.Application.10"))
  (setq g_oex (vlax-get-or-create-object "Excel.Application"))
					; ������ ���������� ������, ������� ��������� � ����� �����
					; (�� ��������� ������ 3)
  (vlax-put-property g_oex 'SheetsInNewWorkbook 2)
					; ������ ���� Excel �������
  (vlax-put-property g_oex 'Visible :vlax-true)
					; ��������� ��������� Workbooks
  (setq g_wbs (vlax-get-property g_oex 'Workbooks))
					; �������� ����� �����
  (setq g_cb (vlax-invoke-method g_wbs 'Add))
					; ��������� ��������� Sheets
  (setq g_shs (vlax-get-property g_cb 'Sheets))
					;
					; � ������� �������� Item �������� ��������� ������� �����
  (setq g_csh (vlax-get-property g_shs 'Item 1))
					; ������ ��� ������� ����� (���� ����1)
  (vlax-put-property g_csh 'Name shname1)
					; ��������� ������� �����
  (setq g_sh2 (vlax-get-property g_shs 'Item 2))
					; ��� ������� �����
  (vlax-put-property g_sh2 'Name shname2)
					; ������ ������ �������� ����� B3:B3 (� ������ �����)
  (setq g_r1 (vlax-get-property g_oex "Range" "B3:B3"))
					; ��������� ������� �����
  (vlax-invoke-method g_sh2 'Activate)
					; ������ ������ �������� ����� A2:C4 (�� ������ �����)
  (setq g_r2 (vlax-get-property g_oex "Range" "A2:C4"))
					; ��������� ������� �����
  (vlax-invoke-method g_csh 'Activate)
					; ������ � �������������� ���������
  (vlax-put-property g_r1 "value2" 1234)
  (vlax-put-property g_r2 "value2" "���� � ������")
					; ������ ������ �������� �� ������ E7 (� ������ �����)
  (setq g_cr (vlax-get-property g_csh 'Range "E7")) ;
					; ������ � ������
  (vlax-put-property g_cr "value2" -17.873)
					; ��������� ����� ����� (XLS-����)
  (vlax-invoke-method
    g_cb 'SaveAs bname -4143 ""	"" :vlax-false :vlax-false nil)
					; ������� �� Excel
  (vlax-invoke-method g_oex "Quit")
					; ������������ �������� � �������� Excel
  (if (and g_cr (not (vlax-object-released-p g_cr)))
    (vlax-release-object g_cr)
  )
  (if (and g_r2 (not (vlax-object-released-p g_r2)))
    (vlax-release-object g_r2)
  )
  (if (and g_r1 (not (vlax-object-released-p g_r1)))
    (vlax-release-object g_r1)
  )
  (if (and g_csh (not (vlax-object-released-p g_csh)))
    (vlax-release-object g_csh)
  )
  (if (and g_sh2 (not (vlax-object-released-p g_sh2)))
    (vlax-release-object g_sh2)
  )
  (if (and g_shs (not (vlax-object-released-p g_shs)))
    (vlax-release-object g_shs)
  )
  (if (and g_cb (not (vlax-object-released-p g_cb)))
    (vlax-release-object g_cb)
  )
  (if (and g_wbs (not (vlax-object-released-p g_wbs)))
    (vlax-release-object g_wbs)
  )
  (if (and g_oex (not (vlax-object-released-p g_oex)))
    (vlax-release-object g_oex)
  )
					; ��������� �������������� ���������� ����������
  (setq	g_cr nil
	g_r2 nil
	g_r1 nil
	g_csh nil
	g_sh2 nil
	g_shs nil
	g_cb nil
	g_wbs nil
	g_oex nil
  )
					; ������ ������
  (gc)
)
