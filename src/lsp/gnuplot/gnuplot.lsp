(vl-load-all)

(defun c:gnuplot-vectors-export  (/ ss en ed vo)
  (setq ss (ssget)
        i  (sslength ss))
  (while (<= 0 (setq i (1- i)))
    (setq en    (ssname ss i)
          ed    (entget en)
          vo    (vlax-ename->vla-object en)
          vo-sp (vlax-curve-getStartParam vo)
          vo-ep (vlax-curve-getEndParam vo))
    (print (list (cdr (assoc 0 ed)) vo-sp vo-ep))
    (cond
      (= (cdr (assoc 0 ed))))))

(defun gnuplot-export-vector  (sp ep)
  (mapcar (function (lambda (el) (princ el) (princ " "))) sp)
  (mapcar (function (lambda (el) (princ el) (princ " "))) (mapcar (function -) ep sp))
  (princ "\n"))

(defun gnuplot-export-line-to-vector  (vo / sp ep)
  (setq sp (vlax-curve-getPointAtParam vo (vlax-curve-getStartParam vo))
        ep (vlax-curve-getPointAtParam vo (vlax-curve-getEndParam vo)))
  (gnuplot-export-vector sp ep))

(defun gnuplot-export-arc-to-vector  (vo / s-param e-param sp-delta sp ep sp-i ep-i i n )
  (setq s-param  (vlax-curve-getStartParam vo)
        e-param  (vlax-curve-getEndParam vo)
        n        24
        sp-delta (/ (- e-param s-param) n)
        i        0)
  (while (< i n)
    (setq sp-i (+ s-param (* i sp-delta))
          ep-i (+ s-param (* (1+ i) sp-delta))
          sp   (vlax-curve-getPointAtParam vo sp-i)
          ep   (vlax-curve-getPointAtParam vo ep-i))
    (gnuplot-export-vector sp ep)
    (setq i (1+ i))))

(defun gnuplot-export-circle-to-vector  (vo / s-param e-param sp-delta sp ep sp-i ep-i i n )
  (setq s-param  (vlax-curve-getStartParam vo)
        e-param  (vlax-curve-getEndParam vo)
        n        24
        sp-delta (/ (- e-param s-param) n)
        i        0)
  (while (< i n)
    (setq sp-i (+ s-param (* i sp-delta))
          ep-i (+ s-param (* (1+ i) sp-delta))
          sp   (vlax-curve-getPointAtParam vo sp-i)
          ep   (vlax-curve-getPointAtParam vo ep-i))
    (gnuplot-export-vector sp ep)
    (setq i (1+ i))))

(setq *vo* (vlax-ename->vla-object (car (entsel ":"))))

(gnuplot-export-arc-to-vector *vo*)

(c:gnuplot-vectors-export)

