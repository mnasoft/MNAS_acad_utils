(defun dim-restore ()
  (command "-dimstyle" "_Restore" (getvar "dimstyle"))
)

(defun toh-0()
  (dim-restore)
  (command "DIMTOH" 0)
  (command "_dim1" "_update" ss "")
)

(defun toh-1()
  (dim-restore)
  (command "DIMTOH" 1)
  (command "_dim1" "_update" ss "")
)
;;;Расположение размерного текста горизонтально.
(defun c:dim-toh (/ do func_list i n ss x)
  (setq ss (ssget))
  (setq
    func_list
     '(
       (1 . toh-0)
       (2 . toh-1)
      )
  )
  (setq
    do t
    i  1
    n  2
  )
  (while do
    (initget "Next Exit")
    (setq x (getkword "Next Exit <Next>:"))
    (if	(null x)
      (setq x "Next")
    )
    (cond
      ((= x "Next")
       (apply (cdr (assoc i func_list)) nil)
       (command "_redraw")
       (setq i (1+ i))
       (if (> i n)
	 (setq i 1)
       )
      )
      ((= x "Exit")
       (dim-restore)
       (setq do nil)
      )
    )
  )
)


(defun c:dim-rad-hor ()
  (dim-restore)
  (command "DIMTMOVE" 1)
  (command "DIMTOH" 1)
  (command "DIMTOFL" 0)
  (command "DIMCEN" 0.0)
  (command "_dimradius")
)

(defun c:dim-rad-rad ()
  (dim-restore)
  (command "DIMTMOVE" 1)
  (command "DIMTOH" 0)
  (command "DIMTOFL" 0)
  (command "DIMCEN" 0.0)
  (command "_dimradius")
)

;;;Подавление|восстановление стрелок и линий выносок.
(defun c:DIM-SD_SE(/ x do ss)
  (setq ss (ssget))
  (setq
    func_list '(
		(1 . SD1-0_SE1-0_SD2-0_SE2-0)
		(2 . SD1-1_SE1-1_SD2-0_SE2-0)
		(3 . SD1-0_SE1-0_SD2-1_SE2-1)
		(4 . SD1-0_SE1-1_SD2-1_SE2-0)
		(5 . SD1-1_SE0-1_SD2-0_SE2-1)
	       )
  )
  (setq
    do t
    i  1
    n  5
  )
  (while do
    (initget "Next Exit")
    (setq x (getkword "Next Exit <Next>:"))
    (if (null x)
      (setq x "Next")
    )
    (cond
      ((= x "Next")
       (apply (cdr(assoc i func_list)) nil)
       (command "_redraw")
       (setq i  (1+ i))
       (if (> i n)
	 (setq i 1)
       )
      )
      ((= x "Exit")
       (dim-restore)
       (setq do nil)
      )
    )
  )
)

(defun SD1-0_SE1-0_SD2-0_SE2-0 ()
  (dim-restore)
  (command "DIMSD1" 0)
  (command "DIMSE1" 0)
  (command "DIMSD2" 0)
  (command "DIMSE2" 0)
  (command "_dim1" "_update" ss "")
)

(defun SD1-1_SE1-1_SD2-0_SE2-0 ()
  (dim-restore)
  (command "DIMSD1" 1)
  (command "DIMSE1" 1)
  (command "DIMSD2" 0)
  (command "DIMSE2" 0)
  (command "_dim1" "_update" ss "")
)

(defun SD1-0_SE1-0_SD2-1_SE2-1 ()
  (dim-restore)
  (command "DIMSD1" 0)
  (command "DIMSE1" 0)
  (command "DIMSD2" 1)
  (command "DIMSE2" 1)
  (command "_dim1" "_update" ss "")
)

(defun SD1-0_SE1-1_SD2-1_SE2-0 ()
  (dim-restore)
  (command "DIMSD1" 0)
  (command "DIMSE1" 1)
  (command "DIMSD2" 1)
  (command "DIMSE2" 0)
  (command "_dim1" "_update" ss "")
)

(defun SD1-1_SE0-1_SD2-0_SE2-1 ()
  (dim-restore)
  (command "DIMSD1" 1)
  (command "DIMSE1" 0)
  (command "DIMSD2" 0)
  (command "DIMSE2" 1)
  (command "_dim1" "_update" ss "")
)

;|«Visual LISP© Format Options»
(105 2 15 2 nil "end of" 90 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
