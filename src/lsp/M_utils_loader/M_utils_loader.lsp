;;;'(registry-delete-recursive '("HKEY_LOCAL_MACHINE\\SOFTWARE\\Autodesk\\AutoCAD\\R17.2\\ACAD-7005:419\\Applications\\MNASArx_Welding"))

;;;'("HKEY_LOCAL_MACHINE\\SOFTWARE\\Autodesk\\AutoCAD\\R17.2\\ACAD-7005:419\\Applications\\MNASArx_Welding")

(defun read-reg-el  (str / rel)
  (setq rel (vl-registry-descendents str))
  (mapcar (function (lambda (el) (strcat str "\\" el))) rel))

;;;f;;;
;;;f;;;("registry-dir"
;;;f;;;  "Выполняет чтение подключей для строк содержащих ключи реестра.\n
;;;f;;;Возвращает список подключей реестра.\n
;;;f;;;Параметры:\n
;;;f;;;str-lst - содержит список ключей реестра.\n
;;;f;;;Пример использования 1:\n
;;;f;;;(registry-dir '(\"HKEY_LOCAL_MACHINE\\SOFTWARE\\Autodesk\\AutoCAD\\R17.2\\ACAD-7005:419\\Applications\\MNASArx_Pozition\"))\n
;;;f;;;Результат работы 1:\n
;;;f;;;(\"HKEY_LOCAL_MACHINE\\SOFTWARE\\Autodesk\\AutoCAD\\R17.2\\ACAD-7005:419\\Applications\\MNASArx_Pozition\\Groups\"\n
;;;f;;; \"HKEY_LOCAL_MACHINE\\SOFTWARE\\Autodesk\\AutoCAD\\R17.2\\ACAD-7005:419\\Applications\\MNASArx_Pozition\\Commands\"\n")
(defun registry-dir (str-lst) (apply (function append) (mapcar (function read-reg-el) str-lst)))

(defun registry-dir-recursive  (str-lst / do i n str-lst-res)
  (setq do t
        str-lst-res str-lst)
  (while do
    (setq i (length str-lst-res))
    (setq str-lst (registry-dir str-lst))
    (setq str-lst-res (append str-lst-res str-lst))
    (setq n (length str-lst-res))
    (if (= i n)
      (setq do nil)))
  str-lst-res)

(defun registry-delete-recursive  (str-lst)
  (mapcar (function vl-registry-delete) (reverse (registry-dir-recursive str-lst))))

(defun read_mnas_reg_str  (str / rez)
  (setq rez (vl-registry-read (strcat "HKEY_LOCAL_MACHINE\\SOFTWARE\\MNASoft\\" str) "ROOT"))
  (if (null rez)
    (setq rez (vl-registry-read (strcat "HKEY_LOCAL_MACHINE\\SOFTWARE\\Wow6432Node\\MNASoft\\" str) "ROOT")))
  rez)

