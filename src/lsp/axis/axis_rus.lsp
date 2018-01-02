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