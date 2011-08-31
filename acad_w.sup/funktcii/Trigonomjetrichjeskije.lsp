;;;(princ "\nЗагружаю Funktcii/Trigonomjetrichjeskije.lsp")
(princ (strcat "\nЗагружаю " (acad_sup) "/" "Funktcii/Trigonomjetrichjeskije.lsp"))

(defun asin (A)
  (atan (/ A (sqrt (- 1.0 (* A A)))))
)

(defun acos (A)
  (atan (/ (sqrt (- 1.0 (* A A))) A))
)

(princ "\t...загружен.\n")
;|«Visual LISP© Format Options»
(72 2 5 2 nil "end of" 60 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
