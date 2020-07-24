;;; K5LT_THIN

;;; K5LT_AXLED

(defun c:kompas-acad-lines  (/ ss)
  (mnas-lines:load-line-types)
;;;;
  (setq ss (SSGET "_X" '((-4 . "<OR") (6 . "K5LT_AXLED") (6 . "CENTER") (-4 . "OR>"))))
  (if (and ss (< 0 (sslength ss)))
    (command "_chprop" ss "" "_ltype" "CENTER" "_color" "7" "_LWeight" "_BYLAYER" ""))
;;;;
  (setq ss (SSGET "_X" '((-4 . "<OR") (6 . "K5LT_THIN") (-4 . "OR>"))))
  (if (and ss (< 0 (sslength ss)))
    (command "_chprop" ss "" "_ltype" "_BYLAYER" "_color" "7" "_LWeight" "_BYLAYER" ""))
;;;;
  (setq ss (SSGET "_X" '((-4 . "<OR") (6 . "K5LT_THIN_INCLUDED_TO_HATCHING") (-4 . "OR>"))))
  (if (and ss (< 0 (sslength ss)))
    (command "_chprop" ss "" "_ltype" "_BYLAYER" "_layer" "h" "_color" "_BYLAYER" "_LWeight" "_BYLAYER"	""))
;;;;
  (setq ss (SSGET "_X" '((-4 . "<OR") (6 . "K5LT_DASHED") (6 . "HIDDEN") (-4 . "OR>"))))
  (if (and ss (< 0 (sslength ss)))
    (command "_chprop" ss "" "_ltype" "HIDDEN" "_color" "7" "_Thickness" "0" ""))
;;;;
  (setq ss (SSGET "_X" '((-4 . "<OR") (6 . "K5LT_BASIC") (6 . "K5LT_REINFORCED") (-4 . "OR>"))))
  (if (and ss (< 0 (sslength ss)))
    (command "_chprop" ss "" "_ltype" "_BYLAYER" "_color" "_BYLAYER" "_LWeight" "_BYLAYER" "")))

(defun c:select-all-blocks () (setq ss (SSGET "_X" '((-4 . "<OR") (0 . "INSERT") (-4 . "OR>")))))
 
"_Color"
"_LAyer"
"_LType"
"_ltScale"
"_LWeight"
"_Thickness"
"_TRansparency"
"_Material"
"_Annotative"