;;; Производит преобразование ячейки Exel заданной в символьном формате в список,
;;; где на первом месте идет строка, а на втором столбец.
;;;_$ (строка_xls->точка "S2")
;;;(2 19)
(defun строка_xls->точка (str / lst_09 lst_AZ)
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
  (list (композиция_по_основанию lst_09 10) (композиция_по_основанию lst_az 26))
)

;;;Преобразует строку символов str, представляющую целое число,
;;;представленное в системе счисления с основанием base и имеющее вид типа колонок в Exel,
;;;в целое число.
;;;
;;;_$ (СТРОКА_XLS->ЦЕЛОЕ "AA" "A" 26)
;;;27
;;;_$ (СТРОКА_XLS->ЦЕЛОЕ "IV" "A" 26)
;;;256
(defun строка_xls->целое (str							;Преобразуемая строка
			  base_chr						;Начальноый символ в системе счисления
			  base							;основание системы счисления
			  / delta)
  (setq delta (1- (ascii base_chr)))
  (композиция_по_основанию
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


;;;Производит преобразование целого числа в строку символов.
;;;Аналогично обозначению колонок в таблице Exel.
;;;Первая колонка - "A", вторая - "B", 26 - "Z", 27 - "AA", 256 - "IV"
;;;
;;;_$ (целое->строка_xls 1 "A" 26)
;;;"A"
;;;_$ (целое->строка_xls 2 "A" 26)
;;;"B"
;;;_$ (целое->строка_xls 26 "A" 26)
;;;"Z"
;;;_$ (целое->строка_xls 27 "A" 26)
;;;"AA"
;;;_$ (целое->строка_xls 256 "A" 26)
;;;"IV"
(defun целое->строка_xls (i							; преобразуемое число
			  base_chr						; Начальный символ системы счисления
			  base							; основание системы счисления
			 )
  (apply
    (function strcat)
    (mapcar
      (function
	(lambda	(el)
	  (целое->символ_xls el base_chr)
	)
      )
      (преобразование_к_безнулевому_виду (разложение_по_основанию i base) base)
    )
  )
)

;;;Используется внутренне функцией целое->строка_xls.
;;;_$ (целое->символ_xls 0 "A")
;;;"@"
;;;_$ (целое->символ_xls 1 "A")
;;;"A"
(defun целое->символ_xls (i							; преобразуемое число
			  base_chr						; Начальный символ системы счисления
			  )
  (chr (+ (ascii base_chr) i -1))
)

;;;Используется внутренне функцией целое->строка_xls.
;;;Преобразует список элементы которого, представляют разложеное по разрядам целое число,
;;;выраженное с системе счисления с основанием basa, в список, у которого в разрядах отсутствуют 0.
;;;Значения элементов списка, представляющих разряды числа до преобразования, могут находиться в диапазоне [0 basa-1].
;;;Значения элементов списка, представляющих разряды преобразованного числа, могут находиться в диапазоне [1 basa].
;;;Старшие разряды находятся в начале списка.
;;;
;;;_$ (преобразование_к_безнулевому_виду '(25 0 11 0 13) 26)
;;;(24 26 10 26 13)
;;;_$ (преобразование_к_безнулевому_виду '(1 0 0 1 0 1) 2)
;;;(1 1 2 2 1)
(defun преобразование_к_безнулевому_виду (lst basa / n_null ln i lst1 lst_1 val)
  (while (setq n_null (поиск_первого_нуля lst 0))
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

;;;Используется внутренне функцией преобразование_к_безнулевому_виду.
;;;Возвращает номер первого найденного в списке элемента, значение которого равно 0,
;;;или nil, если такой элемент не был найден.
;;;Поиск ведется начиная с элемента n_start. Первый элемент списка имеет номер 0.
;;;
;;;_$ (поиск_первого_нуля '(0 1 2 3 0) 0)
;;;0
;;;_$ (поиск_первого_нуля '(0 1 2 3 0) 1)
;;;4
;;;_$ (поиск_первого_нуля '(1 0 3 4) 2)
;;;nil
(defun поиск_первого_нуля (lst							;Список.
			   n_start						;Номер элемента с которого начинается поиск.
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

;;;Производит чтение данных из таблицы Exel
(defun read_exel
		 (xls_tbl_pathname						;Путь и имя файла читаемой таблицы Exel
		  sheet_no							;Номер страницы для чтения данных
		  cell_lt							; Левая верхняя ячейка
		  cell_rb							; Правая нижняя ячейка
		  / oex								;"Excel.Application"
		  wbs								;"Workbooks"
		  awb								;активная рабочая книга
		  shs								;"Sheets"
		  csh								;Текущий лист
		  matrix							;результирующая матрица
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

;;; Чтение текущего листа
;;; (read_csh csh "A1" "B3")
(defun read_csh	(csh								; Текущий лист Exel
		 cell_lt							; Левая верхняя ячейка
		 cell_rb							; Правая нижняя ячейка
		 / cell								;текущая ячейка
		 column_row							;результирующая матрица
		 do_column							;признак выхода из цикла по колонкам строки
		 do_row								;признак выхода из цикла по строкам
		 i_column							;текущая колонка
		 i_row								;текущая строка
		 pnt_lt								;Координаты левой верхней ячейки
		 pnt_rb								;Координаты правой нижней  ячейки
		 row_list							;список содержащий элементы текущей строки
		 var								;вариант находящийся в ячейке cell
		 var_type							;тип варианта
		 var_val							;значение варианта
)
  (setq
    pnt_lt     (строка_xls->точка cell_lt)
    pnt_rb     (строка_xls->точка cell_rb)
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
		       (strcat (целое->строка_xls i_column "A" 26) (itoa i_row))
		     )
		   )
	  var	   (vlax-get-property cell "Value")
	  var_type (vlax-variant-type var)
	  var_val  (vlax-variant-value var)
	  do_row   var_val
    )										; определение того, является-ли начало строки пустой
    (setq
      do_column	t
      row_list nil
    )
    (while do_column
      (setq cell      (vlax-variant-value
			(vlax-invoke-method csh "Evaluate" (strcat (целое->строка_xls i_column "A" 26) (itoa i_row)))
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