(vl-load-com)

;;;MNASAddDimStyle	-	+ добавление размерного стиля
;;;MNASsetDimtxt	-	изменение размерного текста

;;;MNASsetDimsd1	-	+ подавление первой выносной линии и стрелки
;;;MNASsetDimsd2	-	+ подавление второй выносной линии и стрелки

;;;MNASsetDimatfit	-	+ расположение стрелок снаружи
;;;MNASsetDimtoh	-	+ текст размера горизонтально
;;;MNASsetDimtad	-	+ вертикальное расположение текста
;;;MNASsetDimtmove	-	+ текст на полке или без полки
;;;MNASsetDimtofl	-	+ форсировать отрисовку размерной линии
;;;MNASsetDimjust	-	+ горизонтальное расположение текста

(defun c:MNASsetDimjust ()
  (princ "\nVLISP MNASsetDimtad\n")
  (setq
    vla-obj
	    (vlax-ename->vla-object (car (entsel)))
    prop
	    (vlax-get-property vla-obj 'HorizontalTextPosition  )
  )
  (cond
    ((= prop acHorzCentered)
     (vlax-put-property vla-obj 'HorizontalTextPosition  acOverSecondExtension)
     (vlax-put-property vla-obj 'VerticalTextPosition    acVertCentered)
    )
    ((= prop acFirstExtensionLine)
     (vlax-put-property vla-obj 'HorizontalTextPosition   acHorzCentered)
     (vlax-put-property vla-obj 'VerticalTextPosition     acAbove)
    )
    ((= prop acSecondExtensionLine)
     (vlax-put-property vla-obj 'HorizontalTextPosition   acFirstExtensionLine)
     (vlax-put-property vla-obj 'VerticalTextPosition     acAbove)
    )
    ((= prop acOverFirstExtension)
     (vlax-put-property vla-obj 'HorizontalTextPosition   acSecondExtensionLine)
     (vlax-put-property vla-obj 'VerticalTextPosition     acAbove)
    )
    ((= prop acOverSecondExtension)
     (vlax-put-property vla-obj 'HorizontalTextPosition   acOverFirstExtension)
     (vlax-put-property vla-obj 'VerticalTextPosition     acVertCentered)
    )
  )
;;;acHorzCentered
;;;acFirstExtensionLine
;;;acSecondExtensionLine
;;;acOverFirstExtension
;;;acOverSecondExtension
)

(defun c:MNASsetDimtofl ()
  (princ "\nVLISP MNASsetDimtad\n")
  (setq
    vla-obj
	    (vlax-ename->vla-object (car (entsel)))
    prop
	    (vlax-get-property vla-obj 'ForceLineInside )
  )
  (cond
    ((= prop :vlax-false)
     (vlax-put-property vla-obj 'ForceLineInside :vlax-true)
    )
    ((= prop :vlax-true)
     (vlax-put-property vla-obj 'ForceLineInside  :vlax-false)
    )
  )
;;;:vlax-false
;;;:vlax-true
)


(defun c:MNASsetDimtad ()
  (princ "\nVLISP MNASsetDimtad\n")
  (setq
    vla-obj
	    (vlax-ename->vla-object (car (entsel)))
    prop
	    (vlax-get-property vla-obj 'VerticalTextPosition )
  )
  (cond
    ((= prop acVertCentered)
     (vlax-put-property vla-obj 'VerticalTextPosition acAbove)
    )
    ((= prop acAbove)
     (vlax-put-property vla-obj 'VerticalTextPosition  acJIS)
    )
    ((= prop acOutside)
     (vlax-put-property vla-obj 'VerticalTextPosition  acAbove)
    )
    ((= prop acJIS)
     (vlax-put-property vla-obj 'VerticalTextPosition  acAbove)
    )
  )
;;;acVertCentered
;;;acAbove
;;;acOutside
;;;acJIS
)

(defun c:MNASsetDimtmove ()
  (princ "\nVLISP MNASsetDimtmove\n")
  (setq
    vla-obj
	    (vlax-ename->vla-object (car (entsel)))
    prop
	    (vlax-get-property vla-obj 'TextMovement)
  )
  (cond
    ((= prop acDimLineWithText)
     (vlax-put-property vla-obj 'TextMovement acMoveTextAddLeader)
    )
    ((= prop acMoveTextAddLeader)
     (vlax-put-property vla-obj 'TextMovement acDimLineWithText)
    )
    ((= prop acMoveTextNoLeader)
     (vlax-put-property vla-obj 'TextMovement acDimLineWithText)
    )
  )
;;;acDimLineWithText
;;;acMoveTextAddLeader
;;;acMoveTextNoLeader
)

(defun c:MNASsetDimsd1 ()
  (princ "\nVLISP MNASsetDimsd1\n")
  (setq
    vla-obj
	    (vlax-ename->vla-object (car (entsel)))
    prop
	    (vlax-get-property vla-obj 'DimLine1Suppress)
  )
  (cond
    ((= prop :vlax-true)
     (vlax-put-property vla-obj 'DimLine1Suppress :vlax-false)
     (vlax-put-property vla-obj 'ExtLine1Suppress :vlax-false)
    )
    ((= prop :vlax-false)
     (vlax-put-property vla-obj 'DimLine1Suppress :vlax-true)
     (vlax-put-property vla-obj 'ExtLine1Suppress :vlax-true)
    )
  )
)

(defun c:MNASsetDimsd2 ()
  (princ "\nVLISP MNASsetDimsd2\n")
  (setq
    vla-obj
	    (vlax-ename->vla-object (car (entsel)))
    prop
	    (vlax-get-property vla-obj 'DimLine2Suppress)
  )
  (cond
    ((= prop :vlax-true)
     (vlax-put-property vla-obj 'DimLine2Suppress :vlax-false)
     (vlax-put-property vla-obj 'ExtLine2Suppress :vlax-false)
    )
    ((= prop :vlax-false)
     (vlax-put-property vla-obj 'DimLine2Suppress :vlax-true)
     (vlax-put-property vla-obj 'ExtLine2Suppress :vlax-true)
    )
  )
)

(defun c:MNASsetDimatfit ()
  (princ "\nVLISP MNASsetDimatfit\n")
  (setq
    vla-obj
	    (vlax-ename->vla-object (car (entsel)))
    prop
	    (vlax-get-property vla-obj 'Fit)
  )
  (cond
    ((= prop acTextAndArrows)
     (vlax-put-property vla-obj 'Fit acTextOnly)
    )
    ((= prop acArrowsOnly)
     (vlax-put-property vla-obj 'Fit acTextOnly)
    )

    ((= prop acTextOnly)
     (vlax-put-property vla-obj 'Fit acTextAndArrows)
    )

    ((= prop acBestFit)
     (vlax-put-property vla-obj 'Fit acTextAndArrows)
    )
  )
;;;acTextAndArrows 
;;;acArrowsOnly 
;;;acTextOnly 
;;;acBestFit 
)

(defun c:MNASsetDimtoh ()
  (princ "\nVLISP MNASsetDimtoh\n")
  (setq
    vla-obj
	    (vlax-ename->vla-object (car (entsel)))
    prop
	    (vlax-get-property vla-obj 'TextOutsideAlign)
  )
  (cond
    ((= prop :vlax-true)
     (vlax-put-property vla-obj 'TextOutsideAlign :vlax-false)
    )
    ((= prop :vlax-false)
     (vlax-put-property vla-obj 'TextOutsideAlign :vlax-true)
    )
  )
)