(defun ai_ffile (app)
  (or (findfile (strcat app ".vlx"));;; Добавлено мною
      (findfile (strcat app ".fas"));;; Добавлено мною
      (findfile (strcat app ".lsp"))
      (findfile (strcat app ".exp"))
      (findfile (strcat app ".exe"))
      (findfile (strcat app ".arx"))
      (findfile app)
  )
)



(load (strcat (acad_sup) "/utils/acad_sup_dir"))
;;; Плохо проверенные приложения.
;;; Плохо проверенные приложения.

;;; Приложения, работающие в пространстве имен документа.
(load "c:/vlx/f_otv" )
;;; Приложения, работающие в пространстве имен документа.

(autoload "prj/Расчет/zav_1" '("завихритель"))

(autoload "Юля/Усадки/усадка" '("усадка"))

(defun-q
  my_startup
  ()
  (princ "\nStart my_startup")
;  (setvar "ucsicon" 1)
  (princ "\t\tmy_startup End.")
  (princ)
)

(setq s::startup (append s::startup my_startup))
;|«Visual LISP© Format Options»
(105 2 25 2 nil "end of" 60 25 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
