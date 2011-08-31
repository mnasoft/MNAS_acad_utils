;;;	AcadAppDocSpace() создает vla-объекты:
;;;	1. Приложения Acad - acadApp;
;;;	2. Активного документа - acadDoc;
;;;	3. Текущего пространства (модели или листа) - acadSpace.
(defun AcadAppDocSpace_1()
  (setq
    acadApp   (vlax-get-acad-object)
    acadDoc   (vla-get-ActiveDocument acadApp)
    acadSpace
	      (cond
		((= 1 (caar (VPORTS))) (vla-get-PaperSpace acadDoc))
		(t (vla-get-ModelSpace acadDoc))
	      )
  )
  t
)
;;;Space определяет какое пространство (модели или листа) является текущим.
;;;Возвращает:
;;;1. "PaperSpace" если текущим является пространство листа;
;;;2. "ModelSpace" если текущим является пространство модели;
(defun Space_1 ()
  (cond
    ((= 1 (caar (VPORTS))) "PaperSpace")
    (t "ModelSpace")
  )
)


;|«Visual LISP© Format Options»
(105 2 15 2 nil "end of" 90 15 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
