;;; �.�. �������, 2003
;;;===================================================
;;; ��������� COM-����� AutoCAD - Microsoft Excel 2002
;;;===================================================
;;; ������������ ������� �� ������ �� ����� Excel
;;; ������������ ������� ����, ������� ���� � ������� ��������� �����
;;; ���������:
;;; tb_xls - ��� ����� ����� Excel;
;;; sheetname - ��� �����;
;;; hcell - ������ ������ �������;
;;; hlet - ������ ���� ������ �������;
;;; show - ������� ������ Excel �� ����� ������ (T ��� nil)
;;; ���������� ����������:
;;; g_oex - VLA-������ ���������� Excel 2002;
;;; g_wkbs - VLA-������ ��������� Workbooks;
;;; g_awb - VLA-������ �������� �����;
;;; g_shs - VLA-������ ��������� Sheets;
;;; g_mainsh - VLA-������ ������� ����� �����;
;;; g_cell - VLA-������ ������.
;;; ������� ��������� � ���������:
;;; (readex10_com "d:\\r 16\\readex.xls" "������������" 8.0 5.0 T)
;;; (readex10_com "d:\\r 16\\readex.xls" "������������" 5.0 3.0 nil)

(defun readex10_com (tb_xls    sheetname hcell	   hlet	     show
		     /	       nlines	 ncolumns  table_items
		     i	       j	 row	   pt0	     widths
		     types     headers	 xx1	   xx2	     yy1
		     ww	       val	 �������   2.4.	     ���������
		     readex10_com	 old_ortho old_snap  old_osnap
		     old_echo
		    )
  (vl-load-com)				; ��������� ���������, �������������� ������ � ActiveX
  (setq old_echo (getvar "CMDECHO"))	; ���������� ���-������
  (setvar "CMDECHO" 0)
  (ex10_set_connect show)		; ������������ ����� � Excel
  (setq g_wkbs (vlax-get-property g_oex "Workbooks"))
					; ��������� ��������� Workbooks
  (setq g_awb (vlax-invoke-method g_wkbs "Open" tb_xls))
					; �������� ����� (�����) � ��������� ��������� �����
  (if (not g_awb)			; �������� �������� �����
    (progn
      (alert (strcat "�� ��������� ���� " tb_xls))
      (ex_break_connect)
      (exit)
    )
  )

  (setq g_shs (vlax-get-property g_awb "Worksheets")); ������ ������ ������; �� ����������� �������������� ������

  (vlax-for s g_shs
    (if	(= sheetname (vlax-get-property s "Name"))
      (setq g_mainsh s)
    )
  ); ��������� �� ���� � ������ ������
  (if (not g_mainsh)
    (progn
      (alert (strcat "�� ��������� ���� " sheetname))
      (ex_break_connect)
      (exit)
    )
  )

;;; ������ ���������� ����� � ������� ������� ������������
;;; (�� ������ A1 ����� Excel), ��� ����� ������ ����������
  (setq	g_cell
	 (vlax-variant-value
	   (vlax-invoke-method g_mainsh "Evaluate" "A1")
	 )
  )
  (setq	nlines
	 (fix (vlax-variant-value (vlax-get-property g_cell "Value"))
	 )
  )
  (vlax-release-object g_cell)
;;; ������ ���������� �������� � ������� ������� ������������
;;; (�� ������ B1 ����� Excel)
  (setq	g_cell
	 (vlax-variant-value
	   (vlax-invoke-method g_mainsh "Evaluate" "B1")
	 )
  )
  (setq	ncolumns
	 (fix (vlax-variant-value (vlax-get-property g_cell "Value"))
	 )
  )
  (vlax-release-object g_cell)
;;;
;;; ��������� ������ ��������� ������� (���� 2,3,4, ... Excel)
;;; ��� 2 - ������ �������� � ��
;;; ��� 3 - ��������� ��������
  (setq	table_items
	 nil
	j 1
  )
  (repeat (+ nlines 3)
    (setq row nil
	  j   (1+ j)
	  i   -1
    )
    (repeat ncolumns
      (setq i (1+ i))
      (setq g_cell
	     (vlax-variant-value
	       (vlax-invoke-method
		 g_mainsh
		 "Evaluate"
		 (strcat (chr (+ i (ascii "A"))) (itoa j))
	       )
	     )
      )
      (setq row
	     (append
	       row
	       (list
		 (vlax-variant-value
		   (vlax-get-property g_cell "Value")
		 )
	       )
	     )
      )
      (vlax-release-object g_cell)
    )
    (setq table_items (append table_items (list row)))
  )
;;;repeat nlines

;;; �������� � �������� Excel
  (ex_break_connect)

;;; ������ ����� ������ �������� ���� �������
  (setq pt0 nil)
  (while (null pt0)
    (setq pt0 (getpoint "\n����� ������ �������� ���� �������: "))
  )

  (setq	widths (nth 0 table_items)
	types  (nth 1 table_items)
  )

;;; ��������� ����� (������ ����� hcell)
  (tab_lines pt0 ncolumns nlines widths hcell)

;;; ��������� �������
  (setq	headers	(nth 2 table_items)
	i	�1
	xx1	(car pt0)
	yy1	(- (cadr pt0) hcell)
  )
  (repeat ncolumns
    (setq i   (1+ i)
	  ww  (nth i widths)
	  xx2 (+ xx1 ww)
    )
    (setq val (nth i headers))
    (write_item val "str" xx1 xx2 yy1 hlet)
    (setq xx1 xx2)
  )

;;; ���������� ��������� �������
  (setq j 2)
  (repeat nlines
    (setq j   (1+ j)
	  i   -1
	  xx1 (car pt0)
	  yy1 (- (cadr pt0) (* (1- j) hcell))
    )
    (repeat ncolumns
      (setq i	(1+ i)
	    ww	(nth i widths)
	    xx2	(+ xx1 ww)
      )
      (setq val (nth i (nth j table_items)))
      (setq itype (nth i types))
      (write_item val itype xx1 xx2 yy1 hlet)
      (setq xx1 xx2)
    )
  )
;;; �������������� ������ ���-������
  (setvar "CMDECHO" old_echo)
  (redraw)
  (princ)
)

;;; ��������� ����� � Excel 2002
;;; ��������:
;;; vis = T � ������� Excel �������;
;;; vis = nil � ������� Excel ���������.

(defun ex10_set_connect	(vis /)
  ;(setq g_oex (vlax-get-or-create-object "Excel.Application.10"))
  (setq g_oex (vlax-get-or-create-object "Excel.Application"))
;;; ���� ����� �� �����������, �� �������� ��������� ������
  (if (null g_oex)
    (progn
      (alert "���������� ��������� Microsoft Excel 2002")
      (exit)
    )
  )
;;; ������� Excel ������� � ����������� �� ��������� vis
  (if vis
    (vlax-put-property g_oex "Visible" :vlax-true)
  )
)



; ������ ����� � Excel � �������� �� ������
(defun ex_break_connect	(/)
  (vlax-invoke-method g_oex "Quit")
					; ����������� �������, ��������� � Excel,
					; ��� ���������� �������� Excel �� ������
  (mapcar
    (function (lambda (x)
		(if
		  (and x (not (vlax-object-released-p x)))
		   (vlax-release-object x)
		)
	      )
    )
    (list g_cell g_mainsh g_shs g_awb g_wkbs g_oex)
  )
					; ������ ������
  (setq	g_cell nil
	g_mainsh nil
	g_shs nil
	g_awb nil
	g_wkbs nil
	g_oex nil
  )
  (gc)
)

;;; ������������ �������� �������, � �������� �� ������ ������
;;; ���������:
;;; item - ������� (�����, �����);
;;; typ - ��� ("int", "str", ...);
;;; x1,x2 � ��������� �������� ����������� ������;
;;; yi - �������� ������ ������� ������;
;;; hl - ������ ���� �������;
;;; wi - ������ ������.

;;; ��������� � ��������� ������� ����������:
;;; gapx � ������ �� X �� ����� � ������ ������ ������;
;;; gapy - ������ �� Y �� ����� � ������ ������ ������.

(defun write_item
       (item typ x1 x2 yi hl / gapx gapy wi yig st size sizex)
  (setq	gapx 1.0
	gapy 1.0
	wi   (- x2 x1)
	yig  (+ yi gapy)
  )
  (if item
    (progn
;;; �������������� �������� item � �����, � ����������� �� ����
;;; �������� ���� "int" ����� ������������ ��� ������� �����
      (setq st
	     (if (= typ "int")
	       (itoa (fix item))
	       (vl-princ-to-string item)
	     )
      )

;;; ���� ����� ���������� � ������, �� ��������� ���
;;; � ������������� �� ����� ������ �����
;;; ���� ����� �� ����������, �� ��������� ��� � ������ Fit (�� ������)
      (setq size (textbox (list (cons 1 st) (cons 40 hl))))
      (setq sizex (- (caadr size) (caar size)))
      (if (<= sizex (- wi (+ gapx gapx)))
	(entmake
	  (list	'(0 . "TEXT")
		(cons 1 st)
		(cons 10 (list (+ x1 gapx) yig))
		(cons 40 hl)
		'(72 . 0)
	  )
	)
	(entmake
	  (list	'(0 . "TEXT")
		(cons 1 st)
		(cons 10 (list (+ x1 gapx) yig))
		(cons 11 (list (- x2 gapx) yig))
		(cons 40 hl)
		'(72 . 5)
	  )
	)
      )
    )
  )
)


;;; ������������ ����� �������
;;; ���������:
;;; p0 - ����� �������� ������ ���� �������;
;;; nc - ���������� ��������;
;;; nl - ���������� �����;
;;; wids - ������ ����� ��������;
;;; h - ������ �����.

(defun tab_lines (p0 nc nl wids h / w k xx yy htab)
;;; ���������� ������ ������ �������
  (setq	w 0.0
	k -1
  )
  (repeat nc
    (setq k (1+ k)
	  w (+ w (nth k wids))
    )
  )

;;; �������������� �������
  (setq	xx (car p0)
	yy (cadr p0)
  )
  (repeat (+ nl 2)
    (entmake
      (list '(0 . "LINE")
	    (cons 10 (list xx yy))
	    (cons 11 (list (+ xx w) yy))
      )
    )
    (setq yy (- yy h))
  )


;;; ������������ �������
  (setq	xx   (car p0)
	yy   (cadr p0)
	htab (* h (1+ nl))
	k    -1
  )
  (entmake
    (list '(0 . "LINE")
	  (cons 10 (list xx yy))
	  (cons 11 (list xx (- yy htab)))
    )
  )
  (repeat nc
    (setq k  (1+ k)
	  xx (+ xx (nth k wids))
    )
    (entmake
      (list '(0 . "LINE")
	    (cons 10 (list xx yy))
	    (cons 11 (list xx (- yy htab)))
      )
    )
  )
)


"D:\\_namatvadm\\book_1.xls"