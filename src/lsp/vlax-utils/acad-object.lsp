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

(defun mnas-vlax-utils-menu-name-list  (/ acad-object count menugroups-object menu menu-list menu-name)
  (setq	acad-object	  (vlax-get-acad-object)
	MenuGroups-object (vla-get-MenuGroups acad-object)
	count		  (vlax-get-property MenuGroups-object 'Count)
	menu		  nil
	menu-list	  nil)
  (while (<= 0 (setq count (1- count)))
    (setq menu	    (vlax-invoke-method MenuGroups-object 'Item count)
	  menu-name (vlax-get-property menu 'Name)
	  menu-list (cons menu-name menu-list)))
  menu-list)

(defun mnas-vlax-utils-search-menu-by-name  (Name / acad-object count MenuGroups-object menu menu-name menu-rez)
  (setq	acad-object	  (vlax-get-acad-object)
	MenuGroups-object (vla-get-MenuGroups acad-object)
	count		  (vlax-get-property MenuGroups-object 'Count)
	menu-rez	  nil
	menu		  nil
	menu-name	  nil)
  (while (<= 0 (setq count (1- count)))
    (setq menu	    (vlax-invoke-method MenuGroups-object 'Item count)
	  menu-name (vlax-get-property menu 'Name))
    (if	(= menu-name Name)
      (setq menu-rez menu)))
  menu-rez)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;(mnas-vlax-utils-menu-name-list)
;;;(mnas-vlax-utils-search-menu-by-name "MNASOFT")
;;;(mnas-vlax-utils-search-menu-by-name "ACAD")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun mnas-vlax-utils-Toolbars-name-list  (menu-obj / count toolbar toolbar-list toolbar-name toolbars-object)
  (setq	Toolbars-object	(vla-get-Toolbars menu-obj)
	count		(vlax-get-property Toolbars-object 'Count)
	toolbar		nil
	toolbar-list	nil)
  (while (<= 0 (setq count (1- count)))
    (setq toolbar      (vlax-invoke-method Toolbars-object 'Item count)
	  toolbar-name (vlax-get-property toolbar 'Name)
	  toolbar-list (cons toolbar-name toolbar-list)))
  toolbar-list)

(defun mnas-vlax-utils-search-Toolbar-by-name  (menu-obj Name / count toolbar toolbar-list toolbar-name toolbar-rez toolbars-object)
  (setq	Toolbars-object	(vla-get-Toolbars menu-obj)
	count		(vlax-get-property Toolbars-object 'Count)
	toolbar-rez	nil
	toolbar		nil
	toolbar-list	nil)
  (while (<= 0 (setq count (1- count)))
    (setq toolbar      (vlax-invoke-method Toolbars-object 'Item count)
	  toolbar-name (vlax-get-property toolbar 'Name))
    (if	(= toolbar-name Name)
      (setq toolbar-rez toolbar)))
  toolbar-rez)

;;;;;;;;;;;;;;;;;;;;;;

(defun mnas-vlax-utils-add-Toolbar  (menu-obj Toolbar-name)
  (vlax-invoke-method (vla-get-Toolbars menu-obj) 'Add Toolbar-name))

;;;(mnas-vlax-utils-Toolbars-name-list (mnas-vlax-utils-search-menu-by-name "MNASOFT"))
;;;(mnas-vlax-utils-add-Toolbar (mnas-vlax-utils-search-menu-by-name "MNASOFT") "MNAS_XX1")

(defun mnas-vlax-utils-Add-Toolbar-Button  (menu-name toolbar-name btn-name command-name small-icon big-icon / menu-object newbutton openmacro toolbar-object)
  (setq Menu-object (mnas-vlax-utils-search-menu-by-name menu-name))
  (if (null Menu-object)
    (progn (prompt (strcat "\nERROR in func AddToolbarButton. Cood not find menu: \"" menu-name "\"."))
	   (quit)))
  (if (null (setq ToolBar-object (mnas-vlax-utils-search-Toolbar-by-name Menu-object toolbar-name)))
    (setq ToolBar-object (vla-Add (vla-get-Toolbars Menu-object) toolbar-name)))
  (setq openMacro (strcat (Chr 3) (Chr 3) (Chr 95) command-name (Chr 32)))
  (setq newButton (vla-AddToolbarButton ToolBar-object "" btn-name "Open a file." openMacro))
  (vla-put-Visible ToolBar-object :vlax-true)
  (vlax-invoke-method newButton 'SetBitmaps small-icon big-icon))

;;; (mnas-vlax-utils-Add-Toolbar-Button "MNASOFT" "MNAS_Axis_Temp" "mnas-axis-edit" "mnas-axis-edit" "./menus/Acad_mnu_icon./axis./mnas_axis_edit_16.bmp" "./menus/Acad_mnu_icon./axis./mnas_axis_edit_32.bmp")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
