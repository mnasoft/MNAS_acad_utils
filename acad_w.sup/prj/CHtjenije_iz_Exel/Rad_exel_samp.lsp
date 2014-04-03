;;; Н.Н. Полещук, 2003
;;;===================================================
;;; Программа COM-связи AutoCAD - Microsoft Excel 2002
;;;===================================================
;;; Вычерчивание таблицы по данным из книги Excel
;;; Используются текущий слой, текущий цвет и текущий текстовый стиль
;;; Аргументы:
;;; tb_xls - имя файла книги Excel;
;;; sheetname - имя листа;
;;; hcell - высота ячейки таблицы;
;;; hlet - высота букв текста таблицы;
;;; show - признак показа Excel во время работы (T или nil)
;;; Глобальные переменные:
;;; g_oex - VLA-объект приложения Excel 2002;
;;; g_wkbs - VLA-объект семейства Workbooks;
;;; g_awb - VLA-объект активной книги;
;;; g_shs - VLA-объект семейства Sheets;
;;; g_mainsh - VLA-объект нужного листа книги;
;;; g_cell - VLA-объект ячейки.
;;; Примеры обращения к программе:
;;; (readex10_com "d:\\r 16\\readex.xls" "Спецификация" 8.0 5.0 T)
;;; (readex10_com "d:\\r 16\\readex.xls" "Спецификация" 5.0 3.0 nil)

(defun readex10_com (tb_xls    sheetname hcell	   hlet	     show
		     /	       nlines	 ncolumns  table_items
		     i	       j	 row	   pt0	     widths
		     types     headers	 xx1	   xx2	     yy1
		     ww	       val	 Листинг   2.4.	     Программа
		     readex10_com	 old_ortho old_snap  old_osnap
		     old_echo
		    )
  (vl-load-com)				; Подгрузка библиотек, обеспечивающих работу с ActiveX
  (setq old_echo (getvar "CMDECHO"))	; Отключение эхо-вывода
  (setvar "CMDECHO" 0)
  (ex10_set_connect show)		; Установление связи с Excel
  (setq g_wkbs (vlax-get-property g_oex "Workbooks"))
					; Указатель семейства Workbooks
  (setq g_awb (vlax-invoke-method g_wkbs "Open" tb_xls))
					; Открытие файла (книги) и получение указателя книги
  (if (not g_awb)			; Проверка открытия файла
    (progn
      (alert (strcat "Не обнаружен файл " tb_xls))
      (ex_break_connect)
      (exit)
    )
  )

  (setq g_shs (vlax-get-property g_awb "Worksheets")); Чтение списка листов; не обязательно активизировать нужный

  (vlax-for s g_shs
    (if	(= sheetname (vlax-get-property s "Name"))
      (setq g_mainsh s)
    )
  ); Указатель на лист с нужным именем
  (if (not g_mainsh)
    (progn
      (alert (strcat "Не обнаружен лист " sheetname))
      (ex_break_connect)
      (exit)
    )
  )

;;; Чтение количества строк в будущей таблице спецификации
;;; (из ячейки A1 листа Excel), без учета строки заголовков
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
;;; Чтение количества столбцов в будущей таблице спецификации
;;; (из ячейки B1 листа Excel)
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
;;; Получение списка элементов таблицы (ряды 2,3,4, ... Excel)
;;; Ряд 2 - ширины столбцов в мм
;;; Ряд 3 - заголовки столбцов
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

;;; Закрытие и выгрузка Excel
  (ex_break_connect)

;;; Запрос точки левого верхнего угла таблицы
  (setq pt0 nil)
  (while (null pt0)
    (setq pt0 (getpoint "\nТочка левого верхнего угла таблицы: "))
  )

  (setq	widths (nth 0 table_items)
	types  (nth 1 table_items)
  )

;;; Рисование сетки (высота ячеек hcell)
  (tab_lines pt0 ncolumns nlines widths hcell)

;;; Заголовки таблицы
  (setq	headers	(nth 2 table_items)
	i	–1
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

;;; Вписывание элементов таблицы
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
;;; Восстановление режима эхо-вывода
  (setvar "CMDECHO" old_echo)
  (redraw)
  (princ)
)

;;; Установка связи с Excel 2002
;;; Аргумент:
;;; vis = T – сделать Excel видимым;
;;; vis = nil – сделать Excel невидимым.

(defun ex10_set_connect	(vis /)
  ;(setq g_oex (vlax-get-or-create-object "Excel.Application.10"))
  (setq g_oex (vlax-get-or-create-object "Excel.Application"))
;;; Если связь не установлена, то аварийно завершить работу
  (if (null g_oex)
    (progn
      (alert "Невозможно запустить Microsoft Excel 2002")
      (exit)
    )
  )
;;; Сделать Excel видимым в зависимости от параметра vis
  (if vis
    (vlax-put-property g_oex "Visible" :vlax-true)
  )
)



; Разрыв связи с Excel и выгрузка из памяти
(defun ex_break_connect	(/)
  (vlax-invoke-method g_oex "Quit")
					; Освобождаем объекты, связанные с Excel,
					; для корректной выгрузки Excel из памяти
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
					; Сборка мусора
  (setq	g_cell nil
	g_mainsh nil
	g_shs nil
	g_awb nil
	g_wkbs nil
	g_oex nil
  )
  (gc)
)

;;; Вычерчивание элемента таблицы, с отступом от границ ячейки
;;; Аргументы:
;;; item - элемент (текст, число);
;;; typ - тип ("int", "str", ...);
;;; x1,x2 – граничные абсциссы заполняемой ячейки;
;;; yi - ордината нижней границы ячейки;
;;; hl - высота букв надписи;
;;; wi - ширина ячейки.

;;; Пояснение к некоторым рабочим переменным:
;;; gapx – отступ по X от левой и правой границ ячейки;
;;; gapy - отступ по Y от левой и правой границ ячейки.

(defun write_item
       (item typ x1 x2 yi hl / gapx gapy wi yig st size sizex)
  (setq	gapx 1.0
	gapy 1.0
	wi   (- x2 x1)
	yig  (+ yi gapy)
  )
  (if item
    (progn
;;; Преобразование значения item в текст, в зависимости от типа
;;; Значения типа "int" нужно обрабатывать без дробной части
      (setq st
	     (if (= typ "int")
	       (itoa (fix item))
	       (vl-princ-to-string item)
	     )
      )

;;; Если текст помещается в ячейке, то вписываем его
;;; с выравниванием по левой нижней точке
;;; Если текст не помещается, то вписываем его с опцией Fit (По ширине)
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


;;; Вычерчивание линий таблицы
;;; Аргументы:
;;; p0 - точка верхнего левого угла таблицы;
;;; nc - количество столбцов;
;;; nl - количество строк;
;;; wids - список ширин столбцов;
;;; h - высота строк.

(defun tab_lines (p0 nc nl wids h / w k xx yy htab)
;;; Вычисление полной ширины таблицы
  (setq	w 0.0
	k -1
  )
  (repeat nc
    (setq k (1+ k)
	  w (+ w (nth k wids))
    )
  )

;;; Горизонтальные отрезки
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


;;; Вертикальные отрезки
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