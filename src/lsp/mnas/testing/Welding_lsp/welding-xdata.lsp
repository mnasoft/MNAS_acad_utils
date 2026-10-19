(vl-load-com)

(regapp "MNAS-WELDING")

(defun xdata->arrays  (data / types values n range)
  (setq n (length data)
        range (cons 0 (1- n)))
  (setq types (vlax-make-safearray vlax-vbInteger range))
  (vlax-safearray-fill types (mapcar 'car data))
  (setq values (vlax-make-safearray vlax-vbVariant range))
  (vlax-safearray-fill values (mapcar 'cadr data))
  (list types values))

(defun xdata-get  (obj app / types values)
  (vla-GetXData obj app 'types 'values)
  (if (and types values)
    (mapcar 'list
            (vlax-safearray->list types)
            (mapcar 'vlax-variant-value (vlax-safearray->list values)))))

(defun xdata-values (key data)
  (mapcar
    'cadr
    (vl-remove-if-not
      (function
        (lambda (x)
          (= (car x) key)))
      data)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 (xdata-values
   1000
   '((1001 "MNAS-WELDING")
     (1000 "Моя строка 1")
     (1000 "Моя строка 2")
     (1071 20789)))


(defun foo-assoc-by-code()
  )

(defun c:w-set-xdata  (/ obj xdata)
  (setq obj (vlax-ename->vla-object
              (car (entsel "\nВыберите Leader: "))))
  (setq xdata (xdata->arrays
                '((1001 "MNAS-WELDING")
                  (1000 "Моя строка 1")
                  (1000 "Моя строка 2")
                  (1071 20789))))
  (vla-SetXData
    obj
    (vlax-make-variant (car xdata))
    (vlax-make-variant (cadr xdata))))

(defun c:w-get-xdata  (/ obj)
  (setq obj (vlax-ename->vla-object
              (car (entsel "\nВыберите Leader: "))))
  (xdata-get obj "MNAS-WELDING"))