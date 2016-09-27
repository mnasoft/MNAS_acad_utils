(setq *layer-command-list*
       '("lay" "rgb" "la_dhv" "bl_off" "bl_fr" "bl_all_on" "bl_all_th" "vl_s_d" "cl_s_d" "cl_sw_d" "ml_off" "ml_on"
         "ml_on_c" "ml_off_c" "am_la" "vl_fr" "vl_th" "vl_fr_w" "vl_th_all" "vl_fr_w+_d" "sl_on" "sl_off" "sl_th"
         "sl_fr" "sl_lo" "sl_un" "svl_th" "svl_fr" "llay"))
;;;; (opech_cmds-str *layer-command-list*)

(defun c:���() (c:lay))
(defun c:���() (c:rgb))
(defun c:��_���() (c:la_dhv))
(defun c:��_���() (c:bl_off))
(defun c:��_��() (c:bl_fr))
(defun c:��_���_��() (c:bl_all_on))
(defun c:��_���_��() (c:bl_all_th))
(defun c:��_�_�() (c:vl_s_d))
(defun c:��_�_�() (c:cl_s_d))
(defun c:��_��_�() (c:cl_sw_d))
(defun c:��_���() (c:ml_off))
(defun c:��_��() (c:ml_on))
(defun c:��_��_�() (c:ml_on_c))
(defun c:��_���_�() (c:ml_off_c))
(defun c:��_��() (c:am_la))
(defun c:��_��() (c:vl_fr))
(defun c:��_��() (c:vl_th))
(defun c:��_��_�() (c:vl_fr_w))
(defun c:��_��_���() (c:vl_th_all))
(defun c:��_��_�+_�() (c:vl_fr_w+_d))
(defun c:��_��() (c:sl_on))
(defun c:��_���() (c:sl_off))
(defun c:��_��() (c:sl_th))
(defun c:��_��() (c:sl_fr))
(defun c:��_��() (c:sl_lo))
(defun c:��_��() (c:sl_un))
(defun c:���_��() (c:svl_th))
(defun c:���_��() (c:svl_fr))
(defun c:����() (c:llay))

(princ "Loaded project layer.\n")





