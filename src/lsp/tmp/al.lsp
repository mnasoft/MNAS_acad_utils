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
  (command-s "MyCommand1" )
  (command)
  (c:ul)
  (princ)
)
