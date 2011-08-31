;;;(princ "\nЗагружаю layer/nentlay.LSP   ")
(princ (strcat "\nЗагружаю " (acad_sup) "/" "layer/nentlay.LSP   "))

;;;;;;("llay" "not defined" "Слои")
(defun c:llay (/ str cmdstr ask la_l la lastcmd name col cl )
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (setq cmdstr "Set OFF WO FR WFr LO WL Un Col AO AT AU Exit")
  (setq str "Set")
  (setq lastcmd str)
  (while (/= str "Exit")
    (setq ask (strcat "\n" cmdstr " < " str " > :"))
    (initget cmdstr)
    (setq str (getkword ask))
    (if	(/= str nil)
      (setq lastcmd str)
      (setq str lastcmd)
    )
    (cond
      (
       (= str "Set")
       (setq la_l (get_nsel))
       (if la_l
	 (progn
	   (setq la (cdr (assoc 8 (entget (ssname la_l 0)))))
	   (command "_.layer" "_Set" la "")
	 )
       )
      )
      (
       (= str "Un")
       (setq la_l (get_nsel))
       (if la_l
	 (command "_.layer" "_Unlock" (layer_list la_l) "")
       )
      )
      (
       (= str "LO")
       (setq la_l (get_nsel))
       (if la_l
	 (command "_.layer" "_lock" (layer_list la_l) "")
       )
      )
      (
       (= str "OFF")
       (setq la_l (get_nsel))
       (if la_l
	 (if (setq la (layer_cl la_l (getvar "clayer")))
	   (command "_.layer" "_OFF" la "")
	 )
       )
      )
      (
       (= str "Col")
       (setq la_l (get_nsel))
       (setq col (getstring "\nEnter color : "))
       (if (and (/= col nil) la_l)
	 (command "_.layer" "_Color" col (layer_list la_l) "")
       )
      )
      (
       (= str "WL")
       (setq la_l (get_nsel))
       (if la_l
	 (command
	   "_.layer"
	   "_Set"
	   (cdr (assoc 8 (entget (ssname la_l 0))))
	   "_lock"
	   "~"
	   "_unlock"
	   (layer_list la_l)
	   ""
	 )
       )
      )
      (
       (= str "WO")
       (setq la_l (get_nsel))
       (if la_l
	 (command
	   "_.layer"
	   "_Set"
	   (cdr (assoc 8 (entget (ssname la_l 0))))
	   "_Off"
	   "~"
	   ""
	   "_on"
	   (layer_list la_l)
	   ""
	 )
       )
      )
      (
       (= str "WFr")
       (setq la_l (get_nsel))
       (if la_l
	 (command
	   "_.layer"
	   "_Set"
	   (cdr (assoc 8 (entget (ssname la_l 0))))
	   "_freeze"
	   "~"
	   "_thaw"
	   (layer_list la_l)
	   ""
	 )
       )
      )
      (
       (= str "FR")
       (setq la_l (get_nsel))
       (if la_l
	 (if (setq la (layer_cl la_l (getvar "clayer")))
	   (command "_.layer" "_freeze" la "")
	 )
       )
      )
      ((= str "AO") (command "_.layer" "_on" "~" ""))
      ((= str "AU") (command "_.layer" "_unlock" "~" ""))
      ((= str "AT") (command "_.layer" "_Thaw" "~" ""))
    )
  )
(err-handle "")
)

(defun get_nsel	(/ en ss)
  (setq ss (ssadd))
  (while (setq en (nentsel))
    (setq ss (ssadd (car en) ss))
  )
)

(princ "\t...загружен.\n")
 