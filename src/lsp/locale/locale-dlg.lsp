(defun locale:find-dialog ()
  (findfile
   (utils:path-src-lsp
    (strcat "locale/" utils-locale "/locale.dcl"))))

(defun locale:load-dialog  (/ dcl-name dcl_id)
  (setq dcl-name (locale:find-dialog))
  (if (null dcl-name)
      (progn
        (alert
         (strcat
          (utils-locale-string '(("ru" "Не могу найти файл диалога")
                                 ("uk" "Не можу знайти файл діалогу")
                                 ("en" "Cannot find dialog file"))
                               "Cannot find dialog file")
          "\n.../locale/"
          utils-locale
          "/locale.dcl\n"
          (utils-locale-string '(("ru" "Проверьте пути доступа к вспомогательным файлам.")
                                 ("uk" "Перевірте шляхи доступу до допоміжних файлів.")
                                 ("en" "Check the access paths to the auxiliary files."))
	                       "Check the access paths to the auxiliary files.")))
         nil)
      (progn
        (setq dcl_id (load_dialog dcl-name))
        (if (< dcl_id 0)
            (progn
              (alert "Не удалось загрузить диалог выбора локали.")
              nil)
            dcl_id))))

(defun locale:dlg-info ()
  (alert
   (strcat
    (utils-locale-string '(("ru" "Редактирование текста")
                           ("uk" "Редагування тексту")
                           ("en" "Text Editing"))
                         "Text Editing")
     " "
    (about-gpl-string))))

(defun locale:valid-p (locale)
  (member locale '("ru" "uk" "en")))

(defun locale:set (locale)
  (if (locale:valid-p locale)
      (setq utils-locale locale)
      (setq utils-locale utils-locale))
  utils-locale)

(defun locale:selected ()
  (cond
    ((= (get_tile "rb_ru") "1") "ru")
    ((= (get_tile "rb_uk") "1") "uk")
    ((= (get_tile "rb_en") "1") "en")
    (t utils-locale)))

(defun c:locale (/ action dcl_id)
  (setq dcl_id (locale:load-dialog))
  (if (null dcl_id)
      (exit))
  (if (not (new_dialog "utils_locale" dcl_id))
      (progn
        (unload_dialog dcl_id)
        (exit)))
  (set_tile "rb_ru" (if (= utils-locale "ru") "1" "0"))
  (set_tile "rb_uk" (if (= utils-locale "uk") "1" "0"))
  (set_tile "rb_en" (if (= utils-locale "en") "1" "0"))
  (action_tile "rb_ru" "(setq utils-locale \"ru\")")
  (action_tile "rb_uk" "(setq utils-locale \"uk\")")
  (action_tile "rb_en" "(setq utils-locale \"en\")")
  (action_tile "accept" "(setq utils-locale (locale:selected)) (done_dialog 1)")
  (action_tile "cancel" "(done_dialog 0)")
  (action_tile "info" "(locale:dlg-info)")
  (setq action (start_dialog))
  (unload_dialog dcl_id)
  utils-locale)
