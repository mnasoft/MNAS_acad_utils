;;;; (defun good-layer-name (name) (VL-STRING-TRANSLATE "\"\\<>/:;?*|,=` \t\n." "-----____-_--____" name))

(defun good-layer-name (name) (VL-STRING-TRANSLATE "\"<>/:;?*|,=` \t\n." "----____-_--____" name))

(defun axis:draw-single-graph-by-axis-xy-val-data
       (x-axis-data y-axis-data pnt-name-var layer-name / pts el lst lst-i lst-len lst-rez pnt-type)
  (if (and x-axis-data y-axis-data)
    (progn
      (setq pts (progn (setq lst     pnt-name-var
                             lst-len (length lst)
                             lst-i   -1)
                       (while (< (setq lst-i (1+ lst-i)) lst-len)
                         (setq el      (nth lst-i lst)
                               lst-rez (cons (progn (sc:pxy_pt el x-axis-data y-axis-data)) lst-rez)))
                       (setq lst-rez (reverse lst-rez))))
      (dr:layer-set layer-name)
      (if mnas-axis:draw-pline
        (dr:pline pts 256))
      (if mnas-axis:draw-spline
        (dr:spline pts 256))
      (if mnas-axis:draw-point
        (progn
        (setq pnt-type (axis:point-type-next))
        (mapcar (function
                  (lambda (pt)
                    (dr:insert pt pnt-type mnas-axis:block-scale mnas-axis:block-scale mnas-axis:block-scale 0.0)))
                pts))))))

(defun axis:draw-single-graph-by-axis-data  (x-axis-data y-axis-data xy-point-name / pnt-name-var)
  (print xy-point-name)
  (setq pnt-name-var (vl-doc-ref (read xy-point-name)))
  (print pnt-name-var)
  (axis:draw-single-graph-by-axis-xy-val-data x-axis-data y-axis-data pnt-name-var xy-point-name))

;;;;;;;;;;

(defun axis:draw-single-graph-by-axis-names  (x-axis-name y-axis-name xy-point-name)
  (axis:draw-single-graph-by-axis-data
    (axis:get (axis:sel-by-name x-axis-name))
    (axis:get (axis:sel-by-name y-axis-name))
    xy-point-name))

(defun axis:draw-multiple-graphs-on-same-axis
       (x-axis-name y-axis-name data-symbol-lst)
  (axis:load-point-types)
  (axis:point-type-reset)
  (mapcar (function (lambda (el)
		      (axis:draw-single-graph-by-axis-names
			x-axis-name
			y-axis-name
			(strcase (vl-symbol-name el) t))))
	  data-symbol-lst))

(defun axis:draw-multiple-graphs-by-axis-names  (x-axis-name y-axis-name-lst / x-data y-data)
  (axis:load-point-types)
  (axis:point-type-reset)
  (setq x-data (vl-doc-ref (read x-axis-name)))
  (mapcar (function (lambda (el)
                      (axis:draw-single-graph-by-axis-xy-val-data
                        (axis:get (axis:sel-by-name x-axis-name))
                        (axis:get (axis:sel-by-name el))
                        (mapcar (function list) x-data (vl-doc-ref (read el)))
                        (good-layer-name el))))
          y-axis-name-lst))

(defun axis:mnas-axis-multiple-graph  (str-x str-y / str-y-n)
  (setq str-y-n (vl-doc-ref (read str-y)))
  (axis:draw-multiple-graphs-by-axis-names str-x str-y-n))
