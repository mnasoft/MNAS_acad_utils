(vl-load-com)

(setq acad-object (vlax-get-acad-object))

(defun mnas-vlax-utils-acad-window-Minimize  (/ acad-object)
  (setq acad-object (vlax-get-acad-object))
  (vlax-put-property acad-object 'WindowState acMin))

(defun mnas-vlax-utils-acad-window-Normalize  (/ acad-object)
  (setq acad-object (vlax-get-acad-object))
  (vlax-put-property acad-object 'WindowState acNorm))

(defun mnas-vlax-utils-acad-window-Maximize  (/ acad-object)
  (setq acad-object (vlax-get-acad-object))
  (vlax-put-property acad-object 'WindowState acMax))

(defun mnas-vlax-utils-acad-window-Size	 (Width Height / acad-object)
  (setq acad-object (vlax-get-acad-object))
  (mnas-vlax-utils-acad-window-Normalize)
  (vlax-put-property acad-object 'Height Height)
  (vlax-put-property acad-object 'Width Width))

;;;(mnas-vlax-utils-acad-window-Size 8000 6000)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; list

(defun mnas-vlax-utils-list-Item-name  (v-obj / count item item-list item-name)
;;;f;;; ("mnas-vlax-utils-list-Item-name" "Выводит список имен, находящихся в v-obj, содержащем коллекцию имен.")
  (setq	count	  (vlax-get-property v-obj 'Count)
	item-list nil)
  (while (<= 0 (setq count (1- count)))
    (setq item	    (vlax-invoke-method v-obj 'Item count)
	  item-name (vlax-get-property item 'Name)
	  item-list (cons item-name item-list))))

(defun mnas-vlax-utils-list-menu-name  ()
;;;f;;;("mnas-vlax-utils-list-menu-name" "")
  (mnas-vlax-utils-list-Item-name (vla-get-MenuGroups (vlax-get-acad-object))))

;;;(mnas-vlax-utils-list-menu-name)

(defun mnas-vlax-utils-list-Toolbar-name  (menu-obj)
;;;f;;;("mnas-vlax-utils-list-Toolbar-name" "")
  (mnas-vlax-utils-list-Item-name (vla-get-Toolbars menu-obj)))

;;;(mnas-vlax-utils-list-Toolbar-name (mnas-vlax-utils-search-menu-by-name "MNASOFT"))

(defun mnas-vlax-utils-list-Button-name	 (toolbar-obj)
;;;f;;;("mnas-vlax-utils-list-Toolbar-name" "")
  (mnas-vlax-utils-list-Item-name toolbar-obj))

;;; list
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; search

(defun mnas-vlax-utils-search-item-by-name  (v-obj name / count item item-name item-rez)
  (setq	count	  (vlax-get-property v-obj 'Count)
	item-rez  nil
	item	  nil
	item-name nil)
  (while (<= 0 (setq count (1- count)))
    (setq item	    (vlax-invoke-method v-obj 'Item count)
	  item-name (vlax-get-property item 'Name))
    (if	(= item-name name)
      (setq item-rez item)))
  item-rez)

(defun mnas-vlax-utils-search-menu-by-name  (name)
;;;f;;;("mnas-vlax-utils-search-menu-by-name" "")
  (mnas-vlax-utils-search-item-by-name (vla-get-menugroups (vlax-get-acad-object)) name))

;;;(mnas-vlax-utils-search-menu-by-name "MNASOFT")
;;;(mnas-vlax-utils-search-menu-by-name "ACAD")

(defun mnas-vlax-utils-search-Toolbar-by-name  (menu-obj Name / toolbars-object)
;;;;f;;;("mnas-vlax-utils-search-Toolbar-by-name" "")
  (mnas-vlax-utils-search-item-by-name (vla-get-Toolbars menu-obj) name))

;;;(mnas-vlax-utils-search-Toolbar-by-name (mnas-vlax-utils-search-menu-by-name "MNASOFT") "MNAS_Axis_Temp")

(defun mnas-vlax-utils-search-by-name-Button  (toolbar-obj Name / count toolbar toolbar-list toolbar-name toolbar-rez toolbars-object)
  (mnas-vlax-utils-search-item-by-name toolbars-object name))

;;;(mnas-vlax-utils-list-Button-name (mnas-vlax-utils-search-toolbar-by-name (mnas-vlax-utils-search-menu-by-name "MNASOFT") "MNAS_Axis_Temp"))

;;; search
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; add

(defun mnas-vlax-utils-add-Item-name  (v-obj Item-name)
;;;f;;;("mnas-vlax-utils-add-Item-name" "")
  (vlax-invoke-method v-obj 'Add Item-name))

(defun mnas-vlax-utils-add-Toolbar-name	 (menu-obj Toolbar-name)
;;;f;;;("mnas-vlax-utils-add-Toolbar-name" "")
  (mnas-vlax-utils-add-Item-name (vla-get-Toolbars menu-obj) Toolbar-name))

;;;(mnas-vlax-utils-add-Toolbar-name (mnas-vlax-utils-search-menu-by-name "MNASOFT") "MNAS_XX1")

(defun mnas-vlax-utils-add-Menu-name (Menu-name)
;;;f;;;("mnas-vlax-utils-add-Toolbar-name" "")
  (mnas-vlax-utils-add-Item-name (vla-get-Toolbars menu-obj) Toolbar-name))

;;; add
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; delete

;;;(vlax-invoke-method (mnas-vlax-utils-search-toolbar-by-name (mnas-vlax-utils-search-menu-by-name "MNASOFT") "MNAS_XX1") 'Delete)

;;;(vlax-invoke-method (mnas-vlax-utils-search-toolbar-by-name (mnas-vlax-utils-search-menu-by-name "MNAS_CLEAN") "MNAS_CLEAN_Axis") 'Delete)

;;; delete
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun mnas-vlax-utils-add-Toolbar-name-Button  (menu-name toolbar-name btn-name command-name command-help small-icon big-icon / menu-object newbutton openmacro toolbar-object)
  (setq Menu-object (mnas-vlax-utils-search-menu-by-name menu-name))
  (if (null Menu-object)
    (progn (prompt (strcat "\nERROR in func AddToolbarButton. Cood not find menu: \"" menu-name "\"."))
	   (quit)))
  (if (null (setq ToolBar-object (mnas-vlax-utils-search-Toolbar-by-name Menu-object toolbar-name)))
    (setq ToolBar-object (vla-Add (vla-get-Toolbars Menu-object) toolbar-name)))
  (setq openMacro (strcat (Chr 3) (Chr 3) (Chr 95) command-name (Chr 32)))
  (setq newButton (vla-AddToolbarButton ToolBar-object "" btn-name command-help openMacro))
  (vla-put-Visible ToolBar-object :vlax-true)
  (vlax-invoke-method newButton 'SetBitmaps small-icon big-icon))

;;; (mnas-vlax-utils-add-Toolbar-name-Button "MNASOFT" "MNAS_Axis_Temp" "mnas-axis-edit" "mnas-axis-edit" "./menus/Acad_mnu_icon./axis./mnas_axis_edit_16.bmp" "./menus/Acad_mnu_icon./axis./mnas_axis_edit_32.bmp")

