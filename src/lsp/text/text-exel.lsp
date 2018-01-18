(defun mnas-text-get-excel-cells  (/ o-cells o-excel-app o-sheet1 o-sheets o-workbook o-workbooks)
;;; Получение яцеек объекта первого листа Exel
    (setq o-excel-app (vlax-create-object "excel.application"))
    (setq o-workbooks (vlax-get-property o-excel-app 'Workbooks))
    (setq o-workbook (vlax-invoke-method o-workbooks 'Add))
    (setq o-sheets (vlax-get-property o-workbook 'Sheets))
    (setq o-sheet1 (vlax-get-property o-sheets 'Item 1))
    (setq o-cells (vlax-get-property o-sheet1 'Cells))
    (vlax-put-property o-excel-app 'Visible :vlax-true)
    o-cells)

(defun replase-U-codes (str / f-ch str-rez)
  (setq str-rez ""
        f-ch nil)
  (while str
    (setq f-ch (VL-STRING-SEARCH "\\U+" str 0))
    (cond ((> f-ch 0)
           (setq str-rez (strcat str-rez (substr str 1 f-ch))
                 str     (substr str (+ 1 f-ch))))
          ((= f-ch 0)
           (setq str-rez (strcat str-rez (substr str 1 7) ";")
                 str     (substr str 8)))
          ((null f-ch)
           (setq str-rez (strcat str-rez str)
                 str     nil))))
  str-rez)

(defun mnas-text-exel:translate	 (str)
  (setq
    str (replase-U-codes str)
    str (string-subst-all "&#x2205;" "%%C" str)
    str (string-subst-all "&#x2205;" "%%c" str)
    str (string-subst-all "&#xB1;" "%%p" str)
    str (string-subst-all "&#xB1;" "%%P" str)
    str (string-subst-all "&#xB0;" "%%d" str)
    str (string-subst-all "&#xB0;" "%%D" str)

    str (string-subst-all "&#x" "\\U+00" str)
    str (string-subst-all "&#x" "\\U+0" str)
	str (string-subst-all "&#x" "\\U+" str))
	(strcat "<html>" str "</html>"))

(defun select-text  ()
;;; Создание набора выбора типа c объектами типа текст.
    (ssget '((0 . "text"))))

(defun do-text-exel  (ss o-c / i o-txt ss-len str)
;;; Вывод объектов, находящихся в наборе ss ячейки Exel объект o-c
  (setq	ss-len (sslength ss)
	i      -1)
  (while (< (setq i (1+ i)) ss-len)
    (setq str (cdr (assoc 1 (entget (ssname ss i))))
	  str (mnas-text-exel:translate str))
    (PasteSpecial-string-row-column o-c str (+ 1 i) 1)))

(defun cells-select (o-c row col)
  (vlax-invoke-method  (variant-value (vlax-get-property o-c 'Item row col)) 'Select))

(defun string->ClipBoard  (str / h-f)
;;;; Выполняет запись строки в буфер обмена
  (setq h-f (vlax-create-object "htmlfile"))
  (vlax-invoke
    (vlax-get-property (vlax-get-property h-f 'ParentWindow) 'ClipBoardData)
    'setData
    "Text"
    str)
  (vlax-release-object h-f))

(defun ClipBoard->string  (/ h-f str)
  ;;;; Возвращает строку из буфера обмена
  (setq h-f (vlax-create-object "htmlfile"))
  (setq	str (vlax-invoke
	      (vlax-get-property (vlax-get-property h-f 'ParentWindow) 'ClipBoardData)
	      'GetData
	      "Text"))
  (vlax-release-object h-f)
  str)

(defun PasteSpecial-string-row-column  (o-c str row col / o-s)
  (setq o-s (vlax-get-property o-c 'Parent))
  (string->ClipBoard str)
  (cells-select o-c row col)
  (vlax-invoke-method o-s 'PasteSpecial))

(defun c:mnas-text-exel	 (/ o-c ss)
;;;; Экспортирование объектов в MS.Exel
  (setq o-c (mnas-text-get-excel-cells))
  (setq ss (select-text))
  (do-text-exel ss o-c))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun get-row-column-text (o-cells row col)
;;;; Не окончено
  (vlax-variant-value (vlax-get-property (vlax-variant-value (vlax-get-property *o-c* 'Item row col)) 'text)))

(defun get-row-column-value (o-cells row col)
;;;; Не окончено
  (vlax-variant-value (vlax-get-property (vlax-variant-value (vlax-get-property *o-c* 'Item row col)) 'value)))

(defun get-row-column-value2 (o-cells row col)
;;;; Не окончено
  (vlax-variant-value (vlax-get-property (vlax-variant-value (vlax-get-property *o-c* 'Item row col)) 'value2)))

(defun write-row-column  (o-cells row col x)
;;; Вывод строки x в ячейку Exel o-cells row col
      (vlax-put-property o-cells 'Item row col (vl-princ-to-string x)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
