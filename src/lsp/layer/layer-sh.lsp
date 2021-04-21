;;;;;;("sl_on" "Включение слоев по шаблону." "Слои")
(defun c:sl_on  (/ str)
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (setq str (getstring (strcat "Включить слои <" la_shabl_on_off ">:")))
  (command-s "_.-layer"
           "_on"
           (if (= "" str)
             la_shabl_on_off
             (setq la_shabl_on_off str)))
  (if_cmd_active)
  (err-handle ""))

;;;;;;("sl_off" "Выключение слоев по шаблону." "Слои")
(defun c:sl_off  (/ str)
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (setq str (getstring (strcat "Выключить слои <" la_shabl_on_off ">:")))
  (command-s "_.-layer"
           "_off"
           (if (= "" str)
             la_shabl_on_off
             (setq la_shabl_on_off str)))
  (if_cmd_active)
  (err-handle ""))

;;;;;;("sl_th" "Размораживание слоев по шаблону." "Слои")
(defun c:sl_th  (/ str)
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (setq str (getstring (strcat "Разморозить слои <" la_shabl_th_fr ">:")))
  (command-s "_.-layer"
           "_thaw"
           (if (= "" str)
             la_shabl_th_fr
             (setq la_shabl_th_fr str)))
  (if_cmd_active)
  (err-handle ""))

;;;;;;("sl_fr" "Замораживание слоев по шаблону." "Слои")
(defun c:sl_fr  (/ str)
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (setq str (getstring (strcat "Заморозить слои <" la_shabl_th_fr ">:")))
  (command-s "_.-layer"
           "_freeze"
           (if (= "" str)
             la_shabl_th_fr
             (setq la_shabl_th_fr str)))
  (if_cmd_active)
  (err-handle ""))

;;;;;;("sl_lo" "Блокировка слоев по шаблону." "Слои")
(defun c:sl_lo  (/ str)
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (setq str (getstring (strcat "Блокировать слои <" la_shabl_lo_un ">:")))
  (command-s "_.-layer"
           "_lock"
           (if (= "" str)
             la_shabl_lo_un
             (setq la_shabl_lo_un str)))
  (if_cmd_active)
  (err-handle ""))

;;;;;;("sl_un" "Блокировка слоев по шаблону." "Слои")
(defun c:sl_un  (/ str)
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (setq str (getstring (strcat "Разблокировать слои <" la_shabl_lo_un ">:")))
  (command-s "_.-layer"
           "_unlock"
           (if (= "" srt)
             la_shabl_lo_un
             (setq la_shabl_lo_un str)))
  (if_cmd_active)
  (err-handle ""))

;;;;;;("svl_th" "Размораживание слоев по шаблону для данного порта просмотра." "Слои")
(defun c:svl_th  ()
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (if (= 1 (getvar "tilemode"))
    (setvar "tilemode" 0))
  (command-s "_mspace")
  (if_cmd_active)
  (command-s "_vplayer"
           "_thaw"
           (if (= "" (setq str (getstring (strcat "Размомрозить слои <" vp_la_shabl_th_fr ">:"))))
             vp_la_shabl_th_fr
             (setq vp_la_shabl_th_fr str)))
  (if_cmd_active)
  (err-handle ""))

;;;;;;("svl_fr" "Замораживание слоев по шаблону для данного порта просмотра." "Слои")
(defun c:svl_fr  ()
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (if (= 1 (getvar "tilemode"))
    (setvar "tilemode" 0))
  (command-s "_mspace")
  (if_cmd_active)
  (command-s "_vplayer"
           "_freeze"
           (if (= "" (setq str (getstring (strcat "Размомрозить слои <" vp_la_shabl_th_fr ">:"))))
             vp_la_shabl_th_fr
             (setq vp_la_shabl_th_fr str)))
  (if_cmd_active)
  (err-handle ""))

(setq la_shabl_on_off "*_d"
      la_shabl_th_fr "*_d"
      la_shabl_lo_un "*_d"
      vp_la_shabl_th_fr "*_d")
