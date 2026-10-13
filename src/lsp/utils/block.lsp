
(defun load-block-def (dwg name / ac-app ac-doc dbx-doc src arr)
  (vl-load-com)
  (setq	ac-app (vlax-get-acad-object)
	ac-doc  (vla-get-ActiveDocument ac-app)
	dbx-doc (vla-GetInterfaceObject
                 ac-app
                 (strcat "ObjectDBX.AxDbDocument." (substr (getvar "ACADVER") 1 2))))
  (vla-Open dbx-doc dwg)
  (if (not (tblsearch "BLOCK" name))
      (progn (setq src (vla-Item (vla-get-Blocks dbx-doc) name)
		   arr (vlax-make-safearray vlax-vbObject '(0 . 0)))
	     (vlax-safearray-put-element arr 0 src)
	     (vla-CopyObjects dbx-doc arr (vla-get-Blocks ac-doc))))
  (vlax-release-object dbx-doc)
  (princ))

(defun load-dwg-as-block  (file / ac-app ac-doc space ref)
  (vl-load-com)
  (setq	ac-app (vlax-get-acad-object)
	ac-doc (vla-get-ActiveDocument ac-app)
	space  (vla-get-ModelSpace ac-doc))
  (setq ref (vla-InsertBlock
             space
             (vlax-3d-point '(0.0 0.0 0.0))
             file 1.0 1.0 1.0 0.0))
  (vla-delete ref)
  (princ))

;;(load-block-def (findfile "support/test.dwg") "block_123")


;;(load-dwg-as-block (findfile "support/weld_arrow_bot.dwg"))

;;(load-dwg-as-block (findfile "support/weld_arrow_top.dwg"))
