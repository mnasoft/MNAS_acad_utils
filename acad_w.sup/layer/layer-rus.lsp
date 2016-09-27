(setq *layer-command-list*
       '("lay" "rgb" "la_dhv" "bl_off" "bl_fr" "bl_all_on" "bl_all_th" "vl_s_d" "cl_s_d" "cl_sw_d" "ml_off" "ml_on"
         "ml_on_c" "ml_off_c" "am_la" "vl_fr" "vl_th" "vl_fr_w" "vl_th_all" "vl_fr_w+_d" "sl_on" "sl_off" "sl_th"
         "sl_fr" "sl_lo" "sl_un" "svl_th" "svl_fr" "llay"))
;;;; (opech_cmds-str *layer-command-list*)

(defun c:הפם() (c:lay))
(defun c:ךןט() (c:rgb))
(defun c:הפ_גנל() (c:la_dhv))
(defun c:טה_שאא() (c:bl_off))
(defun c:טה_אך() (c:bl_fr))
(defun c:טה_פהה_שע() (c:bl_all_on))
(defun c:טה_פהה_ונ() (c:bl_all_th))
(defun c:לה_û_ג() (c:vl_s_d))
(defun c:סה_û_ג() (c:cl_s_d))
(defun c:סה_ûצ_ג() (c:cl_sw_d))
(defun c:üה_שאא() (c:ml_off))
(defun c:üה_שע() (c:ml_on))
(defun c:üה_שע_ס() (c:ml_on_c))
(defun c:üה_שאא_ס() (c:ml_off_c))
(defun c:פü_הפ() (c:am_la))
(defun c:לה_אך() (c:vl_fr))
(defun c:לה_ונ() (c:vl_th))
(defun c:לה_אך_צ() (c:vl_fr_w))
(defun c:לה_ונ_פהה() (c:vl_th_all))
(defun c:לה_אך_צ+_ג() (c:vl_fr_w+_d))
(defun c:ûה_שע() (c:sl_on))
(defun c:ûה_שאא() (c:sl_off))
(defun c:ûה_ונ() (c:sl_th))
(defun c:ûה_אך() (c:sl_fr))
(defun c:ûה_הש() (c:sl_lo))
(defun c:ûה_דע() (c:sl_un))
(defun c:ûלה_ונ() (c:svl_th))
(defun c:ûלה_אך() (c:svl_fr))
(defun c:ההפם() (c:llay))

(princ "Loaded project layer.\n")





