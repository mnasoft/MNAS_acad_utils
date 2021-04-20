(defun f_otv (d) (* 0.25 pi d d))

(defun d_ek (f) (sqrt (/ (* 4.0 f) pi)))

;;; Прощадь жиклера

(defun f_zikl  (f_e                     ; - эквивалентная площадь всех сопротивлений которую необходимо получить за счет постновки жиклера.
                f_1                     ; - эквивалентная площадь всех остальных сопротивлений.
                )
  (sqrt (/ 1.0 (- (/ 1.0 (* f_e f_e)) (/ 1.0 (* f_1 f_1))))))

;;; Вычисляет площадь, эквивалентную площади последовательно расположенных сопротивлений.
;;; Предполагается, что среда протекающая через площади не сжимается.
(defun f_ek_zikl  (l_f                  ; - список, содержащий проходные сечения.
                   /                    ;
                   zero                 ;
                   )
  (mapcar (function (lambda (el)
                      (if (zerop el)
                        (setq zero t))))
          l_f)
  (cond (zero 0.0)
        (t (sqrt (/ 1.0 (apply (function +) (mapcar (function (lambda (el) (/ 1.0 (* el el)))) l_f)))))))


;;;;;;("f_kolca" "Вычисление площади кольца." "Расчеты")
(defun c:f_kolca (/ area p1 p1-p2 p2 p_mid p_mid-p_os p_os) (f_kolca) (princ))

(defun f_kolca  (/ area p1 p1-p2 p2 p_mid p_mid-p_os p_os)
  (setq p1         (getpoint "Введите 1 точку на кольце:")
        p2         (getpoint p1 "Введите 2 точку на кольце:")
        p_mid      (mapcar (function (lambda (el1 el2) (/ (+ el1 el2) 2.0))) p1 p2)
        p_os       (getpoint p_mid "Кратчайшее расстояние до оси:")
        p1-p2      (distance p1 p2)
        p_mid-p_os (distance p_mid p_os)
        area       (* p1-p2 p_mid-p_os 2. pi))
  (princ "\nДлина кольца p1-p2: ")
  (princ p1-p2)
  (princ "\nРадиус кольца p_mid-p_os: ")
  (princ p_mid-p_os)
  (princ "\nГидравлический диаметр: ")
  (princ (/ area p_mid-p_os pi))
  (princ "\nДиаметр равновеликий: ")
  (princ (sqrt (/ area 0.25 pi)))
  (princ "\nПлощадь: ")
  (princ area)
  area)

(defun c:d_hydravlic  (/ en)
  (setq en (car (entsel)))
  (command-s "_area" "_Object" en)
  (/ (* (getvar "AREA") 4.0) (getvar "PERIMETER")))

(defun c:d_hydravlic_diff  (/ en1 en2 area-1 area-2 perim-1 perim-2)
  (setq en1 (car (entsel)))
  (setq en2 (car (entsel)))
  (command-s "_area" "_Object" en1)
  (setq	area-1	(getvar "AREA")
	perim-1	(getvar "PERIMETER"))
  (command-s "_area" "_Object" en2)
  (setq	area-2	(getvar "AREA")
	perim-2	(getvar "PERIMETER"))
  (/ (* (- area-1 area-2) 4.0) (+ perim-1 perim-2)))

(defun c:f_zavihr  (/ area p1 p1-p2 p2 p_mid p_mid-p_os p_os)
  (setq p1         (getpoint "\nВведите 1 точку на кольце:")
        p2         (getpoint p1 "\nВведите 2 точку на кольце:")
        p_mid      (mapcar (function (lambda (el1 el2) (/ (+ el1 el2) 2.0))) p1 p2)
        p_os       (getpoint p_mid "\nКратчайшее расстояние до оси:")
        p1-p2      (distance p1 p2)
        p_mid-p_os (distance p_mid p_os)
        area       (* p1-p2 p_mid-p_os 2. pi)
        n_lop      (getreal "\nКоличество лопаток завихрителя:")
        delta_lop  (getreal "\nТолщина лопатки завихрителя:")
        alfa       (getangle p_os "\nУгол крутки лопаток:"))
  (princ "\nДлина кольца p1-p2: ")
  (princ p1-p2)
  (princ "\nРадиус кольца p_mid-p_os: ")
  (princ p_mid-p_os)
  (princ "\nПлощадь без учета крутки потока: ")
  (princ area)
  (princ "\nПлощадь завихрителя: ")
  (princ (- (* area (cos alfa)) (* n_lop delta_lop p1-p2)))
  (princ))
