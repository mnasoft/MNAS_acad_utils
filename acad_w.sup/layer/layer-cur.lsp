;;;;;;("vl_s_d"
;;;;;;"Создание замороженного во всех портах просмотра и (или)\n
;;;;;;установка в текущее значение слоя,\n
;;;;;;с именем слоя отмеченного примитива + \"_d\"." "Слои")
(defun c:vl_s_d  (/ tm)
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (setq en   (car (entsel "\nВыберите примитив:"))
        ed   (entget en)
        la   (cdr (assoc 8 ed))
        la_d (strcat la "_d")
        tm   (getvar "tilemode"))
  (cond ((wcmatch (strcase la) (strcase "*_d")) (vl-cmdf "_.layer" "_set" la))
        ((tblsearch "layer" la_d) (vl-cmdf "_.layer" "_set" la_d))
        ((null (tblsearch "layer" la_d))
         (setvar "tilemode" 0)
         (vl-cmdf "_.vplayer" "_new" la_d)
         (if_cmd_active)
         (vl-cmdf "_.layer" "_set" la_d)))
  (if_cmd_active)
  (setvar "tilemode" tm)
  (err-handle ""))


;;	if_cmd_active()	- Функция производит ввод в командную строку пробелов дотех пор пока
;;			команда находится в активном состоянии.
(defun if_cmd_active () (while (= 1 (getvar "CMDACTIVE")) (vl-cmdf "")))

;;;;;;("cl_s_d"
;;;;;;"Создание и (или) установка в текущее значение слоя
;;;;;;с именем слоя, отмеченного примитива + \"_d\"." "Слои")
(defun c:cl_s_d  (/ en ed la la_d)
  (setq en   (car (entsel "\nВыберите примитив:"))
        ed   (entget en)
        la   (cdr (assoc 8 ed))
        la_d (strcat la "_d"))
  (cond ((wcmatch (strcase la) (strcase "*_d")) (vl-cmdf "_.layer" "_set" la))
        ((tblsearch "layer" la_d) (vl-cmdf "_.layer" "_set" la_d))
        ((null (tblsearch "layer" la_d)) (vl-cmdf "_.layer" "_new" la_d "_set" la_d)))
  (if_cmd_active)
  (err-handle ""))

;;;;;;("cl_sw_d"
;;;;;;"Установка в текущее значение слоя с именем слоя,\n
;;;;;;отмеченного примитива без окончания \"_d\"." "Слои")
(defun c:cl_sw_d  (/ en ed la la_d)
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (setq en   (car (entsel "\nВыберите примитив:"))
        ed   (entget en)
        la_d (cdr (assoc 8 ed)))
  (vl-cmdf "_.layer" "_set")
  (if (wcmatch (strcase la_d) (strcase "*_d"))
    (progn (setq la (substr la_d 1 (- (strlen la_d) (strlen "_d"))))
           (if (tblsearch "layer" la)
             (vl-cmdf la)
             (vl-cmdf la_d)))
    (vl-cmdf la_d))
  (if_cmd_active)
  (err-handle ""))
