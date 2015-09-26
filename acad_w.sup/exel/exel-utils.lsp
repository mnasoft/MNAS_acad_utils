;;; Производит преобразование ячейки Exel заданной в символьном формате в список,
;;; где на первом месте идет строка, а на втором столбец.
;;;_$ (строка_xls->точка "S2")
;;;(2 19)
(DEFUN строка_xls->точка  (str / lst_09 lst_az)
  (MAPCAR (FUNCTION
            (LAMBDA (el)
              (COND ((AND (>= el (ASCII "A")) (<= el (ASCII "Z"))) (SETQ lst_az (CONS (- el 64) lst_az)))
                    ((AND (>= el (ASCII "0")) (<= el (ASCII "9"))) (SETQ lst_09 (CONS (- el 48) lst_09))))
              T))
          (REVERSE (VL-STRING->LIST (STRCASE str))))
  (LIST (композиция_по_основанию lst_09 10) (композиция_по_основанию lst_az 26)))

;;;Преобразует строку символов str, представляющую целое число,
;;;представленное в системе счисления с основанием base и имеющее вид типа колонок в Exel,
;;;в целое число.
;;;
;;;_$ (СТРОКА_XLS->ЦЕЛОЕ "AA" "A" 26)
;;;27
;;;_$ (СТРОКА_XLS->ЦЕЛОЕ "IV" "A" 26)
;;;256
(DEFUN строка_xls->целое  (str          ;Преобразуемая строка
                           base_chr     ;Начальноый символ в системе счисления
                           base         ;основание системы счисления
                           / delta)
  (SETQ delta (1- (ASCII base_chr)))
  (композиция_по_основанию (MAPCAR (FUNCTION (LAMBDA (el) (- el delta))) (VL-STRING->LIST str)) base))




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
(DEFUN целое->строка_xls  (i            ; преобразуемое число
                           base_chr     ; Начальный символ системы счисления
                           base         ; основание системы счисления
                           )
  (APPLY (FUNCTION STRCAT)
         (MAPCAR (FUNCTION (LAMBDA (el) (целое->символ_xls el base_chr)))
                 (преобразование_к_безнулевому_виду (разложение_по_основанию i base) base))))

;;;Используется внутренне функцией целое->строка_xls.
;;;_$ (целое->символ_xls 0 "A")
;;;"@"
;;;_$ (целое->символ_xls 1 "A")
;;;"A"
(DEFUN целое->символ_xls  (i            ; преобразуемое число
                           base_chr     ; Начальный символ системы счисления
                           )
  (CHR (+ (ASCII base_chr) i -1)))

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
(DEFUN преобразование_к_безнулевому_виду  (lst basa / n_null ln i lst1 lst_1 val)
  (WHILE (SETQ n_null (поиск_первого_нуля lst 0))
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
(DEFUN поиск_первого_нуля  (lst         ;Список.
                            n_start     ;Номер элемента с которого начинается поиск.
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

;;;Производит чтение данных из таблицы Exel
(DEFUN read_exel  (xls_tbl_pathname     ;Путь и имя файла читаемой таблицы Exel
                   sheet_no             ;Номер страницы для чтения данных
                   cell_lt              ; Левая верхняя ячейка
                   cell_rb              ; Правая нижняя ячейка
                   / oex                ;"Excel.Application"
                   wbs                  ;"Workbooks"
                   awb                  ;активная рабочая книга
                   shs                  ;"Sheets"
                   csh                  ;Текущий лист
                   matrix               ;результирующая матрица
) (VL-LOAD-COM)
  (SETQ oex (VLAX-GET-OR-CREATE-OBJECT "Excel.Application"))
  (VLAX-PUT-PROPERTY oex "Visible" :VLAX-TRUE)
  (SETQ wbs (VLAX-GET-PROPERTY oex "Workbooks"))
  (SETQ awb (VLAX-INVOKE-METHOD wbs "Open" xls_tbl_pathname))
  (SETQ shs (VLAX-GET-PROPERTY awb "Worksheets"))
  (SETQ csh (VLAX-GET-PROPERTY shs "Item" sheet_no)) ;(vlax-put-property csh "Name" "Cool")
  (SETQ matrix (read_csh csh cell_lt cell_rb))
  (VLAX-INVOKE-METHOD oex "Quit"))

;;; Чтение текущего листа
;;; (read_csh csh "A1" "B3")
(DEFUN read_csh  (csh                   ; Текущий лист Exel
                  cell_lt               ; Левая верхняя ячейка
                  cell_rb               ; Правая нижняя ячейка
                  /                     ;
                  cell                  ;текущая ячейка
                  column_row            ;результирующая матрица
                  do_column             ;признак выхода из цикла по колонкам строки
                  do_row                ;признак выхода из цикла по строкам
                  i_column              ;текущая колонка
                  i_row                 ;текущая строка
                  pnt_lt                ;Координаты левой верхней ячейки
                  pnt_rb                ;Координаты правой нижней  ячейки
                  row_list              ;список содержащий элементы текущей строки
                  var                   ;вариант находящийся в ячейке cell
                  var_type              ;тип варианта
                  var_val               ;значение варианта
) (SETQ pnt_lt     (строка_xls->точка cell_lt)
        pnt_rb     (строка_xls->точка cell_rb)
        i_row      (CAR pnt_lt)
        do_row     T
        column_row nil)
  (WHILE do_row
    (SETQ i_column (CADR pnt_lt)
          cell     (vlax-variant-value
                     (vlax-invoke-method csh "Evaluate" (STRCAT (целое->строка_xls i_column "A" 26) (ITOA i_row))))
          var      (vlax-get-property cell "Value")
          var_type (vlax-variant-type var)
          var_val  (vlax-variant-value var)
          do_row   var_val)             ; определение того, является-ли начало строки пустой
    (SETQ do_column T
          row_list nil)
    (WHILE do_column
      (SETQ cell      (vlax-variant-value
                        (vlax-invoke-method csh "Evaluate" (STRCAT (целое->строка_xls i_column "A" 26) (ITOA i_row))))
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

(DEFUN read-exel-sheet-by-row  (csh     ; Текущий лист Exel
                                cell_lt ; Левая верхняя ячейка
                                cell_rb ; Правая нижняя ячейка
                                /       ;
                                cell    ;текущая ячейка
                                row_column ;результирующая матрица
                                do_column ;признак выхода из цикла по колонкам строки
                                do_row  ;признак выхода из цикла по строкам
                                i_column ;текущая колонка
                                i_row   ;текущая строка
                                pnt_lt  ;Координаты левой верхней ячейки
                                pnt_rb  ;Координаты правой нижней  ячейки
                                col_list ;список содержащий элементы текущего столбца
                                var     ;вариант находящийся в ячейке cell
                                var_type ;тип варианта
                                var_val ;значение варианта
) (SETQ pnt_lt     (строка_xls->точка cell_lt)
        pnt_rb     (строка_xls->точка cell_rb)
        i_column   (CADR pnt_lt)
        do_column  T
        row_column nil)
  (WHILE do_column
    (SETQ i_row     (CAR pnt_lt)
          cell      (vlax-variant-value
                      (vlax-invoke-method csh "Evaluate" (STRCAT (целое->строка_xls i_column "A" 26) (ITOA i_row))))
          var       (vlax-get-property cell "Value")
          var_type  (vlax-variant-type var)
          var_val   (vlax-variant-value var)
          do_column var_val)            ; определение того, является-ли начало строки пустой
    (SETQ do_row T
          col_list nil)
    (WHILE do_row
      (SETQ cell      (vlax-variant-value
                        (vlax-invoke-method csh "Evaluate" (STRCAT (целое->строка_xls i_column "A" 26) (ITOA i_row))))
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
