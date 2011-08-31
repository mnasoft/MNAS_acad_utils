;;;;;;("welding" "Построение обозначения сварочных швов. Не закончена." "Размеры")
(defun c:welding (/ wt_exit_dialog)
  (setq	arrow_dcl_id
	 (load_dialog
	   (strcat (acad_sup) "/DIMS/welding/welding.dcl")
	 )
  )
  (if (< arrow_dcl_id 0)
    (exit)
  )
  (while (null wt_exit_dialog)
  (if (not (new_dialog "welding_text" arrow_dcl_id))
    (exit)
  )
  (wt:init)
  (wt:setup_ac)

  (setq act (start_dialog))
  (cond
    ((= act 0)  (setq wt_exit_dialog t ))
    ((= act 1) (setq wt_exit_dialog t ))
    ((= act 2) (princ "Нарисовать"))
    ((= act 3) (princ "Настройка"))
    ((= act 4) (princ "Сохранить"))
    ((= act 5) (princ "Выбрать"))
    ((= act 6) (princ "Обновить")(ac-Обновить))
  )
  )
  (unload_dialog arrow_dcl_id)
)

(defun wt:init ()
  (mapcar
    (function
      (lambda (el)
	(cond
	  (
	   (= 2 (length el))
	   (set_tile (car el) (cadr el))
	  )
	  (
	   (= 3 (length el))
	   (start_list (car el))
	   (mapcar (function add_list) (caddr el))
	   (end_list)
	   (set_tile (car el) (cadr el))
	  )
	)
      )
    )
    ll_welding_setup
  )
)


(defun wt:all_ac ()
  (setq
    ll_welding_setup
     (mapcar
       (function
	 (lambda (el)
	   (cond
	     (
	      (= 2 (length el))
	      (list (car el) (get_tile (car el)))
	     )
	     (
	      (= 3 (length el))
	      (list (car el) (get_tile (car el)) (caddr el))
	     )
	   )
	 )
       )
       ll_welding_setup
     )
  )
)

(defun wt:setup_ac ()
  (mapcar
    (function (lambda (el) (action_tile (car el) "(wt:all_ac)")))
    ll_welding_setup
  )
	   
  (action_tile "Нарисовать" "(done_dialog 2)")
  (action_tile "Настройка" "(done_dialog 3)")
  (action_tile "Сохранить" "(done_dialog 4)")
  (action_tile "Выбрать" "(done_dialog 5)")
  (action_tile "Обновить" "(done_dialog 6)")
)

(defun ac-Обновить(/ str_надстрочник str_подстрочник)
  (setq str_надстрочник "")
  (setq str_подстрочник "")
  (if (= "1"
	 (СПИСОК_ЗНАЧЕНИЙ_ПО_КЛЮЧУ
	   "wt:обозн_стандарта"
	   ll_welding_setup
	 )
      )
    (setq str_надстрочник
	   (strcat str_надстрочник
		   (СПИСОК_ЗНАЧЕНИЙ_ПО_КЛЮЧУ
		     "wt:список_обозн_стандартаpтов"
		     ll_welding_setup
		   )
	   )
    )
  )
  (if (= "1"
	 (СПИСОК_ЗНАЧЕНИЙ_ПО_КЛЮЧУ
	   "wt:обозн_шва"
	   ll_welding_setup
	 )
      )
    (setq str_надстрочник
	   (strcat str_надстрочник
		   "-"
		   (СПИСОК_ЗНАЧЕНИЙ_ПО_КЛЮЧУ
		     "wt:список_обозн_швов"
		     ll_welding_setup
		   )
	   )
    )   
  )

  (if (= "1"
	 (СПИСОК_ЗНАЧЕНИЙ_ПО_КЛЮЧУ
	   "wt:спос_сварки"
	   ll_welding_setup
	 )
      )
    (setq str_надстрочник
	   (strcat str_надстрочник
		   "-"
		   (СПИСОК_ЗНАЧЕНИЙ_ПО_КЛЮЧУ
		     "wt:список_спос_сварки"
		     ll_welding_setup
		   )
	   )
    )   
  )  
  
  
  (setq	ll_welding_setup
	 (subst	(list "wt:надстрочник" str_надстрочник)
		(assoc "wt:надстрочник" ll_welding_setup)
		ll_welding_setup
	 )
  )

  
'(("wt:надстрочник" "")
  ("wt:подстрочник" "")
  ("wt:разв_стрелки_по_часам" "1")
  ("wt:разв_стрелки_против_часов" "0")
  ("wt:сторона_указываемыя" "1")
  ("wt:сторона_оборотная" "0")
  ("wt:по_контуру_замкнутому" "0")
  ("wt:по_контуру_разамкнутому" "0")
  ("wt:по_контуру_по_линии" "1")
  ("wt:монтажный_да" "0")
  ("wt:монтажный_нет" "1")
  ("wt:обозн_стандарта" "1")
  ("wt:список_обозн_стандартаpтов"
   "0"
   ("Тип А" "Тип Б" "Тип В" "Тип Г" "Тип Д")
  )
  ("wt:обозн_шва" "1")
  ("wt:список_обозн_швов"
   "0"
   ("С1"   "С2"	  "С3"	 "С4"	"С6"   "С7"   "С8"   "С9"   "С11"
    "С12"  "С15"  "С17"	 "С18"	"С20"  "С21"  "С25"  "У1"   "У3"
    "У4"   "У5"	  "У6"	 "У8"	"У9"   "Т1"   "Т2"   "Т3"   "Т4"
    "Т6"   "Т7"	  "Т8"	 "Н1"	"Н2"
   )
  )
  ("wt:спос_сварки" "1")
  ("wt:список_спос_сварки" "0" ("Э" "ИН" "ИНп" "ИП" "УП"))
  ("wt:катет_t" "0")
  ("wt:катет_eb" "1.5")
  ("wt:надстр_список_доп_знаков"
   "0"
   ("Без доп. зн." "Усилен. снять" "Плавн. перех.")
  )
  ("wt:надстр_шерох_t" "0")
  ("wt:надстр_шерох_eb" "20")
  ("wt:категория" "1")
  ("wt:список_категорий" "0" ("I" "II" "III" "IV"))
  ("wt:комплекс" "1")
  ("wt:список_комплексов"
   "0"
   ("1"	"2" "3"	"4" "5"	"6" "7"	"8" "9"	"10" "11" "12" "13" "14" "15"
    "16" "17" "18")
  )
  ("wt:подстр_список_доп_знаков"
   "0"
   ("Без доп. зн." "Усилен. снять" "Плавн. перех.")
  )
  ("wt:подстр_шерох_t" "0")
  ("wt:подстр_шерох_eb" "20")
 )
)

(defun список_значений_по_ключу(ключ список-значений / ключ_список-значений )
  (setq ключ_список-значений (assoc ключ список-значений))
  (cond
    ((= 2 (length ключ_список-значений))
      (cadr ключ_список-значений)
    )
    ((= 3 (length ключ_список-значений))
     (nth (atoi (cadr ключ_список-значений))(caddr ключ_список-значений))
    )
  )
)


'(("wg:угол_раскрытия_стрелки" "10.")
   ("wg:угол_хвоста_стрелки" "60.")
   ("wg:направление_стрелки" "0")
   ("wg:высота_текста" "3.5")
   ("wg:расст_полка-верхний_текст" "1.75")
   ("wg:расст_полка-нижний_текст" "1.75")
   ("wg:радиус_по_контуру" "1.5")
 )
;|«Visual LISP© Format Options»
(72 2 5 2 nil "end of" 60 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
