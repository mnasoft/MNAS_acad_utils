



(xdata-get obj "MNAS-WELDING")



(vla-SetXData
  obj
  (vlax-make-variant
    (vlax-safearray-fill
      (vlax-make-safearray vlax-vbInteger '(0 . 1))
      '(1001 1000)))
  (vlax-make-variant
    (vlax-safearray-fill
      (vlax-make-safearray vlax-vbVariant '(0 . 1))
      '("MNAS-WELDING" "Моя строка"))))

(entget (car (entsel "\nВыберите Leader: ")) '("MNAS-WELDING"))

(xdata-values
   1000
   '((1001 "MNAS-WELDING")
     (1000 "Моя строка 1")
     (1000 "Моя строка 2")
     (1071 20789)))


