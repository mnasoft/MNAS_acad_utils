(setq *axis-command-list* '("a1" "an" "a2" "a2t" "a2xyn_t" "a2xy_t" "a3" "a4" "a5" "a6" "an" "ax" "c1" "c2" "c3" "c4" "ea" "epr" "im"))

;;;;(opech_cmds-str  *axis-command-list*)

(defun c:ф1() (c:a1))
(defun c:фт() (c:an))
(defun c:ф2() (c:a2))
(defun c:ф2е() (c:a2t))
(defun c:ф2чнт_е() (c:a2xyn_t))
(defun c:ф2чн_е() (c:a2xy_t))
(defun c:ф3() (c:a3))
(defun c:ф4() (c:a4))
(defun c:ф5() (c:a5))
(defun c:ф6() (c:a6))
(defun c:фт() (c:an))
(defun c:фч() (c:ax))
(defun c:с1() (c:c1))
(defun c:с2() (c:c2))
(defun c:с3() (c:c3))
(defun c:с4() (c:c4))
(defun c:уф() (c:ea))
;(defun c:узк() (c:epr))
(defun c:шь() (c:im))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun c:mnas-menu-delete-toolbar-axis  ()
  (vlax-invoke-method
    (mnas-vlax-utils-search-toolbar-by-name
      (mnas-vlax-utils-search-menu-by-name "MNAS_CLEAN")
      "MNAS_Clean_Axis")
    'Delete))

(defun mnas-axis-Add-Toolbar-Button  (c-n-h)
  (setq	menu-name    "MNAS_CLEAN"
	toolbar-name "MNAS_Clean_Axis"
	command-name (car c-n-h)
	command-help (cadr c-n-h)
	button-name  (STRCASE (VL-STRING-TRANSLATE "-" "_" command-name) nil)
	icon-path    "./menus/Acad_mnu_icon/axis/"
	icon-name    (VL-STRING-TRANSLATE "-" "_" command-name)
	icon-name-16 (strcat icon-path icon-name "_16.bmp")
	icon-name-32 (strcat icon-path icon-name "_32.bmp"))
  (mnas-vlax-utils-add-Toolbar-name-Button
    menu-name toolbar-name button-name command-name command-help icon-name-16 icon-name-32))



(defun c:mnas-menu-add-toolbar-axis  ()
  (mapcar (function mnas-axis-Add-Toolbar-Button)
	  '(("mnas-axis-mode-setup" "Настройка режима приглашений и уведомлений")
	    ("mnas-axis-edit" "Преобразование отрезка в ось & Редактирование оси")
	    ("mnas-axis-graph-xy" "Построение полилинии в координатах двух шкал.")
	    ("mnas-axis-graph-xy-n" "Построение семейства полилиний в координатах двух шкал")
	    ("mnas-axis-point" "Построение точки в координатах шкалы")
	    ("mnas-axis-point-text" "Построение точки в координатах шкалы и нанесение текста")
	    ("mnas-axis-tick" "Построение линий сетки в координатах 2-х шкал и нанесение текста")
	    ("mnas-axis-ticks" "Построение линий сетки в координатах 2-х шкал и нанесение текста")
	    ("mnas-axis-draw-xy" "Построение точек в координатах двух шкал по их координатам")
	    ("mnas-axis-draw-point" "Построение точек в координатах двух шкал по точкам")
	    ("mnas-axis-point-to-screen" "Перевод точек из координат двух шкал в координаты экрана")
	    ("mnas-axis-point-to-another-axis" "Перевод точек из координат одной пары шкал в координаты другой пары шкал.")
	    ("mnas-axis-point-value" "Определение значения на шкале по точке")
	    ("mnas-axis-point-value-xy" "Выводит координаты отмеченных точек"))))

(princ "Loaded project axis.\n")