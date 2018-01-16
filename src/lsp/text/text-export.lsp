;;;;;;("text_export" "Экспортирует текст примитмвов во внешний файл." "Тексты")
(defun c:text_export  (/ fd fn i name ss txt)
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (setq fn (getfiled "" "" "txt" 1)
        fd (open fn "W"))
  (if fd
    (progn (setq ss (ssget '((-4 . "<OR") (0 . "MTEXT") (0 . "TEXT") (-4 . "OR>")))
                 i  (sslength ss))
           (while (>= (setq i (1- i)) 0)
             (setq name (ssname ss i)
                   txt  (cdr (assoc 1 (entget name))))
             (princ txt fd)
             (princ "\n" fd))
           (close fd))
    (file-open-err fn))
  (err-handle ""))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun c:export-text-dxf  (/ fd fn i en ss txt)
  (if (null (setq fd (open (getfiled "" "" "txt" 1) "W")))
    (exit))
  (setq ss (ssget '((0 . "TEXT")))
        i  (sslength ss))
  (while (>= (setq i (1- i)) 0)
    (setq en (ssname ss i)
          ed (cdr (entget en)))
    (print ed fd))
  (close fd))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun c:mnas-text-exel  (/ o-c ss)
;;;; Экспортирование объектов в MS.Exel
  (setq o-c (mnas-text-get-excel-cells))
  (setq ss (select-text))
  (do-text-exel ss o-c))

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

(defun select-text () (ssget '((0 . "text"))))

(defun do-text-exel  (ss o-c / i o-txt ss-len str)
  (setq ss-len (sslength ss)
        i      -1)
  (while (< (setq i (1+ i)) ss-len)
    (setq o-txt (vlax-ename->vla-object (cdr (car (entget (ssname ss i)))))
          str   (vlax-get-property o-txt 'textstring))
    (write-row-column o-c (+ 1 i) 1 str)))

(defun write-row-column	 (o-cells row col x)
  (vlax-put-property o-cells 'Item row col (vl-princ-to-string x)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun read-row-column  (o-cells row col)
;;;; Не окончено
  (vlax-variant-value (vlax-get-property o-cells 'Item row col)))