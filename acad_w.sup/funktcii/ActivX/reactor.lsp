(defun print-radius (notifier-object reactor-object parameter-list)
;(vl-load-com)
  (cond
    (
     (vlax-property-available-p
       notifier-object
       "Radius"
     )
     (princ "The radius is ")
     (princ (vla-get-radius notifier-object))
    )
  )
)
;;;To see how an object reactor works
;;;
;;;1	Load the following code to define a circle object; you will be prompted to draw the circle:


(setq myCircle
					; Prompt for the center point and radius: 
       (progn (setq ctrPt
			   (getpoint "\nCircle center point: ")
		    radius (distance ctrPt
				     (getpoint ctrpt "\nRadius: ")
			   )
	      )
					; Add a circle to the drawing model space. Nest the function 
					; calls to obtain the path to the current drawing's model 
					; space: AcadObject > ActiveDocument > ModelSpace 
	      (vla-addCircle

		(vla-get-ModelSpace
		  (vla-get-ActiveDocument (vlax-get-acad-object))
		)
		(vlax-3d-point ctrPt)
		radius
	      )
       )

)
;;;
;;;This code uses vla-addCircle to draw a circle, assigning the return value to variable myCircle. The return value is a VLA-object, which contains a pointer to the Circle object drawn.
;;;
;;;2	Load the print-radius callback function shown in "Defining Object Reactor Callback Functions."
;;;3	Define the reactor with the following command:

(setq circleReactor
       (vlr-object-reactor
	 (list myCircle)

	 "Circle Reactor"
	 '((:vlr-modified . print-radius))
       )
)
;;;4	In the AutoCAD drawing window, select the circle and change its size. The print-radius function will display a message in the AutoCAD Command window. For example, if you use the STRETCH command to enlarge the circle, the message looks like the following:

