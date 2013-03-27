(defun c:lea (/ k str i)
  (setq ss (ssget '((0 . "LEADER"))))
  (initget "Arrow dotSmall weldTop weldBot")
  (setq k (getkword "Arrow dotSmall weldTop weldBot:"))
  (cond
    ((= "Arrow" k)
     (setq str "")
    )
    ((= "dotSmall" k)
     (setq str "DotSmall")
    )
    ((= "weldTop" k)
      (setq str "weld_top")
      (if (null(not(TBLSEARCH "BLOCK" "weld_top")))
	(command "_-INSERT" "weld_top" "*0,0,0" "1" "" "")
	(command "_erase" "_last" "")
      )
      ((= "weldBot" k)
	(setq str "weld_bot")
	(TBLSEARCH "BLOCK" "weld_bot")
      )
    )
  (setq i (sslength ss))
  (while (<= 0 (setq i (1- i)))
    (vlax-put-property (vlax-ename->vla-object (ssname ss i)) 'ArrowheadBlock str)
  )
)


Enter X scale factor, specify opposite corner, or [Corner/XYZ] <1>:
Enter Y scale factor <use X scale factor>:

Specify rotation angle <0>:
