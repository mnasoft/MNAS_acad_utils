(opech_cmds '("d_chamf" "d_off" "d_otv" "d_rez" "exl" "xt" "xtcen" "cxt" "ltp" "r_off" "z0" "j_lns"))

(princ "Loaded project lines.\n")


(mapcar (function (lambda (el) (list (vl-symbol-name el))))
        '(mnas-cad-utils-path ltp r_off d_off d_otv d_chamf d_rez xt exl z0 xtcen cxt j_lns j_arcs test_err
          translit))

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