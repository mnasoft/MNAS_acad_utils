;;	stl()		- Устанавливает в зависимости от платформы ситль текста T на основании шрифтов: "es_***,my_b_f".
(defun stl(/ os_ver)
 (setq os_ver (cadr (str_token (getvar "platform") " ")))
 (cond
  ((= os_ver "DOS")
   (vl-cmdf "_style" "t" "es_dos,my_b_f"  "0"  "1" "0" "_N" "_N" "_N")
  )
  ((= os_ver "Windows")
   (vl-cmdf "_style" "t" "es_win,my_b_f"  "0"  "1" "0" "_N" "_N" "_N")
  )
 )
)