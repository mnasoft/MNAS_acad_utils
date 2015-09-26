;;;;;;("de"
;;;;;;"Вызывает диалог для редактирования текста примитивов следуюших типов:
;;;;;;MTEXT, TEXT, DIMENSION." "Тексты")
(defun c:de  (/ en obj temp)
  (setq en   (car (entsel "\nВыберите примитив:"))
        obj  (entget en)
        temp (cdr (assoc 0 obj)))
  (cond ((or (= "MTEXT" temp) (= "TEXT" temp) (= "DIMENSION" temp)) (command "ddedit" en))
        ((or (= "INSERT" temp)) (command "ddatte" en)))
  (princ))


;;;;;;("ate" "Редактирование атрибута." "Тексты")
(defun c:ate  (/ en obj temp)
  (setq en   (car (nentsel "\nВыберите примитив:"))
        obj  (entget en)
        temp (cdr (assoc 0 obj)))
  (cond ((or (= "MTEXT" temp) (= "TEXT" temp) (= "DIMENSION" temp)) (command "ddedit" en))
        ((or (= "ATTRIB" temp)) (command "attedit" "_y" "*" "*" "*" en)))
  (princ))
