;;;;;;("format" "Построение форматной рамки." "Размеры")
(defun c:format  (/                     ;
                  f_key ; Список, содержащий ключи основных надписей: ("1" "2" "2аг" "2ат" "2бн" "2бч" "3")
                  f_val ; Список, содержащий полные наименования основных надписей.
                  sht1_key     ; Ключи  тегов в основной надписи
                  sht1_key2    ; Наименования тегов в основной надписи
                  kr_key ; Список, содержащий допустимые кратности для форматов (строки).
                  kr_val ; Список, содержащий допустимые кратности для форматов (целочисленные).
                  for_name      ; Список, содержащий имена форматов.
                  for_val       ; Список, содержащий размеры форматов.
                  reg_root ; Корнь реестра для записи переменных параметров.
                  format_registry ; Список, содержащий значения параметров диалога по умолчанию.
                  f_no            ; Индекс основной надписи.
                  kr_no     ; Индекс для нахождения кратности формата.
                  )
  "format - Построение форматной рамки. Размеры"
  (setq reg_root "HKEY_CURRENT_USER\\Software\\MNASoft\\Format")
  (setq format_registry '((p_start (0.0 0.0 0.0))
                          (sht1_val
                           ("Устройство горелочное"           "В2М80009993СБ"  "Дораб.черт. Н80038002СБ"
                            ""               ""               ""               ""               "1:1"
                            ""               "1"              "ЖАКИ"           "Нач отд"        "Матвеев   "
                            "Матвєєв   "     "Дунаев   "      "Ванцовский"     "Матвеев   "     "Спицын   "
                            ""               ""))
                          (f_no 0)
                          (kr_no 0)
                          (for_no 1)
                          (dir_sht 1)
                          (divzone_no 1)
                          (zone_ch 65)
                          (zone_dig 1)))
  (load_format)
  (main_format)
  (princ))


(setq format:locale "uk");; ru, uk

;;;f;;; ("format:locale-string (key-strings default)"
;;;f;;;  "Возвращает строку, соответствующую действующей локали.\n
;;;f;;;    Аргументы:\n
;;;f;;;    key-strings  - точки;\n
;;;f;;;    default     - значение по умолчанию.\n
;;;f;;;    Пример использования:\n
;;;f;;; _$ (format:locale-string '((\"ua\" \"Альбомна\") (\"ru\" \"Альбомная\") \"Landscape\"))\n
;;;f;;; ")

(defun format:locale-string (key-strings default)
  (cond
    ((cadr (assoc format:locale key-strings)))
     (t default)))

(defun format:locale-data (key-data default)
  (cond
    ((cadr (assoc format:locale key-data)))
     (t default)))

