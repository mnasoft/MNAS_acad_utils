(setq *lines-command-list* '("d_chamf" "d_off" "d_otv" "d_rez" "exl" "xt" "xtcen" "cxt" "ltp" "r_off" "z0" "j_lns"))
;;;;(opech_cmds-str *lines-command-list*)

(defun c:в_срфьа() (c:d_chamf))
(defun c:в_щаа() (c:d_off))
(defun c:в_щем() (c:d_otv))
(defun c:в_куя() (c:d_rez))
(defun c:учд() (c:exl))
(defun c:че() (c:xt))
(defun c:чесут() (c:xtcen))
(defun c:сче() (c:cxt))
(defun c:дез() (c:ltp))
(defun c:к_щаа() (c:r_off))
(defun c:я0() (c:z0))
(defun c:о_дты() (c:j_lns))

(princ "Loaded project lines.\n")


'(("MNAS-CAD-UTILS-PATH" nil)
  ("LTP" t)
  ("R_OFF" t)                           ; Удаилть
  ("D_OFF" t)                           ; Удаилть
  ("D_OTV" t)                           ; Объединить с D_OTV
  ("D_CHAMF" t)                         ; Объединить с D_CHAMF
  ("D_REZ" t)                           ; Объединить с D_REZ
  ("XT" t)
  ("EXL" t)
  ("Z0" t)
  ("XTCEN" t)
  ("CXT" t)
  ("J_LNS" t) ;Добавить возможность сохранения настроек и координат диалога
  ("J_ARCS" t) ;Добавить диалог фильтрации с возможностью сохранения типа настроек
  )