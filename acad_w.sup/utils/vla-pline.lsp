(vl-load-com)

;;	¬озвращант реперные точки полилинии.
(defun pline-get-points	(vo /  vc val arr pts_2)
  (setq vc (vlax-get-property vo 'Coordinates))
  (setq val (vlax-variant-value vc))
  (setq arr (vlax-safearray->list val))
  (setq i 0)
  (while (nth i arr)
    (setq
      x_i (nth i arr)
      y_i (nth (1+ i) arr)
      pts_2 (cons (list x_i y_i) pts_2)
      i (+ i 2)
    )
  )
  (reverse pts_2)
)

;;;(vlax-curve-getEndPoint  ename)
;;;(vlax-curve-getStartPoint  ename)
;;;(vlax-curve-getStartParam  ename)
;;;(vlax-curve-getEndParam  ename)
;;;
;;;(vlax-curve-getSecondDeriv (vlax-ename->vla-object ename) 1.5)
;;;
;;;(vlax-curve-getFirstDeriv (vlax-ename->vla-object ename) 1.5)
;;;(vlax-curve-getPointAtParam (vlax-ename->vla-object ename) 1.5)
;;;
;;;(vlax-safearray->list
;;;  (vlax-variant-value
;;;    (vlax-invoke-method
;;;      (vlax-ename->vla-object sp1)
;;;      'IntersectWith
;;;      (vlax-ename->vla-object l1)
;;;      acExtendBoth
;;;    )
;;;  )
;;;)
;;;
;;;(mapcar
;;;  (function
;;;    (lambda (el)
;;;      (dr:point
;;;	el
;;;	2
;;;      )
;;;    )
;;;  )
;;;  pts
;;;)