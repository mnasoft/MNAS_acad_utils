;;;(princ "\nЗагружаю text/Redaktirovanije tjekstov.lsp")
(princ (strcat "\nЗагружаю " (acad_sup) "/" "text/Redaktirovanije tjekstov.lsp"))

;;;;;;("de"
;;;;;;"Вызывает диалог для редактирования текста примитивов следуюших типов:
;;;;;;MTEXT, TEXT, DIMENSION." "Тексты")
(defun c:de (/ en obj temp)
  (setq
    en	 (car (entsel "\nВыберите примитив:"))
    obj	 (entget en)
    temp (cdr (assoc 0 obj))
  )
  (cond
    (
     (or
       (= "MTEXT" temp)
       (= "TEXT" temp)
       (= "DIMENSION" temp)
     )
     (command "ddedit" en)
    )
    (
     (OR
       (= "INSERT" temp)
     )
     (command "ddatte" en)
    )
  )
  (princ)
)


;;;;;;("ate" "Редактирование атрибута." "Тексты")
(defun c:ate (/ en obj temp)
  (setq
    en	 (car (nentsel "\nВыберите примитив:"))
    obj	 (entget en)
    temp (cdr (assoc 0 obj))
  )
  (cond
    (
     (or
       (= "MTEXT" temp)
       (= "TEXT" temp)
       (= "DIMENSION" temp)
     )
     (command "ddedit" en)
    )
    (
     (or
       (= "ATTRIB" temp)
     )
     (command "attedit" "_y" "*" "*" "*" en)
    )
  )
  (princ)
)
(princ "\t...загружен.\n")
;|«Visual LISP© Format Options»
(72 2 5 2 nil "end of" 60 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;