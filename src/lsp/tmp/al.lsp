(defun c:al ()
  (arxload
    "D:/home/_namatv/UserSDK/AddDimstyle/Debug/MNASAddDimstyle.arx"
  )
)
(defun c:ul ()
  (arxunload
    "D:/home/_namatv/UserSDK/AddDimstyle/Debug/MNASAddDimstyle.arx"
  )
)

(defun c:tl ()
  (c:al)
  (command "MyCommand1" )
  (command)
  (c:ul)
  (princ)
)
;|«Visual LISP© Format Options»
(72 2 5 2 nil "end of" 60 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
