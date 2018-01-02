(setq *axis-command-list* '("a1" "an" "a2" "a2t" "a2xyn_t" "a2xy_t" "a3" "a4" "a5" "a6" "an" "ax" "c1" "c2" "c3" "c4" "ea" "epr" "im"))

;;;;(opech_cmds-str  *axis-command-list*)

(defun c:�1() (c:a1))
(defun c:��() (c:an))
(defun c:�2() (c:a2))
(defun c:�2�() (c:a2t))
(defun c:�2���_�() (c:a2xyn_t))
(defun c:�2��_�() (c:a2xy_t))
(defun c:�3() (c:a3))
(defun c:�4() (c:a4))
(defun c:�5() (c:a5))
(defun c:�6() (c:a6))
(defun c:��() (c:an))
(defun c:��() (c:ax))
(defun c:�1() (c:c1))
(defun c:�2() (c:c2))
(defun c:�3() (c:c3))
(defun c:�4() (c:c4))
(defun c:��() (c:ea))
;(defun c:���() (c:epr))
(defun c:��() (c:im))

(defun mnas-axis-Add-Toolbar-Button  (command-name)
  (setq	menu-name    "MNASOFT"
	toolbar-name "MNAS_Axis_Temp"
	button-name  (STRCASE (VL-STRING-TRANSLATE "-" "_" command-name) nil)
	icon-path    "./menus/Acad_mnu_icon/axis/"
	icon-name    (VL-STRING-TRANSLATE "-" "_" command-name)
	icon-name-16 (strcat icon-path icon-name "_16.bmp")
	icon-name-32 (strcat icon-path icon-name "_32.bmp"))
  (mnas-vlax-utils-Add-Toolbar-Button
    menu-name toolbar-name button-name command-name icon-name-16 icon-name-32))

(mapcar	(function mnas-axis-Add-Toolbar-Button)
	'("mnas-axis-mode-setup" "mnas-axis-edit" "mnas-axis-graph-xy" "mnas-axis-graph-xy-n" "mnas-axis-point"	"mnas-axis-point-text" "mnas-axis-tick"	"mnas-axis-ticks" "mnas-axis-draw-xy"
	  "mnas-axis-draw-point"))

(princ "Loaded project axis.\n")