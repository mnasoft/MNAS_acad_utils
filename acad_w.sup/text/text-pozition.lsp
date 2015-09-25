;;;;;;("pos_export"
;;;;;;"Производит выгрузку текста позиций в файл." "Тексты")
(defun c:pos_export  (/ fd              ; дескриптор файла, в который экспортируются данные
                      fn                ; имя файла, в который экспортируются данные
                      i                 ; счетчик
                      name              ; имя текущего обрабатываемого объекта
                      ss                ; набор выбора
                      txt)              ; извлеченный из атрибута экспортированный текст
  (setq fn (getfiled "" "" "txt" 1)
        fd (open fn "W"))
  (cond ((/= 'str (type fn)) (alert (princ "Переменная fn не содержит имени файла.")))
        ((null fd) (alert (princ (strcat "Не могу открыть файл: " fn "."))) (exit)))
  (setq ss (ssget)
        i  (sslength ss))
  (while (>= (setq i (1- i)) 0)
    (setq name (ssname ss i))
    (cond ((= (cdr (assoc 0 (entget name))) "MNASPozition")
           (setq txt (cdr (assoc 1 (entget name))))
           (princ txt fd)
           (princ "\n" fd))))
  (close fd))
