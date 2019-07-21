;;;;;;("r_off"
;;;;;;"Линия в направлении (ang+dir_0) из точки, лежащей на перпедикуляре к dir_0\n
;;;;;;проходящем через p0 на расстоянии rad, проекция линии на направление dir_0\n
;;;;;;равна off." "Отверстия")
(defun c:r_off  (/ p0 p1 dir_0 off rad ang)
  (setq p0 (getpoint "\nНачальная точка на оси:"))
  (setq p1 (getpoint p0 "\nНаправление:"))
  (setq dir_0 (angle p0 p1))
  (setq off (getdist p0 "\nДлина вдоль оси:"))
  (setq rad (getdist p0 "\nНачальный радиус:"))
  (setq ang (* pi (/ (getreal "\nУгол конуса:") 180.)))
  (off_ang_rad p0 off ang rad dir_0))

;;;;;;("d_off"
;;;;;;"Линия в направлении (ang+dir_0) из точки, лежащей на перпедикуляре к dir_0\n
;;;;;;проходящем через p0 на расстоянии rad, проекция линии на направление dir_0\n
;;;;;;равна off ; зеркальная к ней ; и линия замыкающая концы этих линий." "Отверстия")
(defun c:d_off  (/ p0 p1 dir_0 off dia ang)
  (setq p0 (getpoint "\nНачальная точка на оси:"))
  (setq p1 (getpoint p0 "\nНаправление:"))
  (setq dir_0 (angle p0 p1))
  (setq off (getdist p0 "\nДлина вдоль оси:"))
  (setq dia (getdist "\nDia:"))
  (setq ang (* pi (/ (getreal "\nУгол наклона профиля:") 180.)))
  (off_ang_dia p0 off ang dia dir_0))
;;;;;;("d_otv" "Отверстие без фаски." "Отверстия")
(defun c:d_otv  (/ p0 p1 dir_0 off dia ang)
  (setq p0 (getpoint "\nНачальная точка на оси:"))
  (setq p1 (getpoint p0 "\nНаправление:"))
  (setq dir_0 (angle p0 p1))
  (setq off (getdist "\nГлубина отверстия:"))
  (setq dia (getdist "\nДиаметр:"))
  (setq ang (* pi (/ -60. 180.)))
  (otv p0 dia off ang dir_0))

;;;;;;("d_chamf" "Отверстие с фаской." "Отверстия")
(defun c:d_chamf  (/ p0 p1 dir_0 off dia h alfa gamma)
  (setq p0 (getpoint "\nНачальная точка на оси:"))
  (setq p1 (getpoint p0 "\nНаправление:"))
  (setq dir_0 (angle p0 p1))
  (setq off (getdist "\nГлубина отверстия:"))
  (setq dia (getdist "\nДиаметр:"))
  (setq h (getdist "\nШирина аски:"))
  (setq alfa (* pi (/ -60. 180.)))
  (setq gamma (* pi (/ 45. 180.)))
  (otv_faska p0 dia off h alfa gamma dir_0))

;;;;;;("d_rez" "Построение резьбового отверстия" "Отверстия")
(defun c:d_rez  (/ p0 p1 dir_0 l1 l2 l3 h d1 d2 alfa betta gamma)
  (setq p0 (getpoint "\nНачальная точка на оси:"))
  (setq p1 (getpoint p0 "\nНаправление:"))
  (setq dir_0 (angle p0 p1))
  (setq l1 (getdist p0 "\nДлина сверления для нарезки резьбы:"))
  (setq l2 (getdist p0 "\nДлина резьбовой части:"))
  (setq d1 (getdist p0 "\nВнутренний диаметр резьбы:"))
  (setq d2 (getdist p0 "\nНаружный диаметр резьбы:"))
  (setq h (/ (- d2 d1) 2.))
  (setq l3 (* (- d2 d1) 0.5 (/ (sin (dtr 60.)) (cos (dtr 60.)))))
  (setq alfa (* pi (/ -60. 180.)))
  (setq betta (* pi (/ -30. 180.)))
  (setq gamma (* pi (/ 45. 180.)))
  (otv_rezba p0 d1 d2 h l1 l2 l3 alfa betta gamma dir_0))

(defun off_ang_rad  (p0 off ang rad dir_0 / zn p1 p2 p21 p11 p3) ; Линия в направлении (ang+dir_0) из точки, лежащей на перпедикуляре к dir_0
                                        ; проходящем через p0 на расстоянии rad, проекция линии на направление dir_0
                                        ; равна off.
  (if (< rad 0.)
    (setq zn -1.)
    (setq zn 1.))
  (setq p1 (polar p0 (+ dir_0 (* zn pi 0.5)) (* zn rad)))
  (setq p2 (polar p0 dir_0 off))
  (setq p21 (polar p2 (+ dir_0 (* zn pi 0.5)) (* zn rad)))
  (setq p11 (polar p1 (+ dir_0 (* zn ang)) (* zn rad)))
  (setq p3 (inters p1 p11 p2 p21 nil))
  (command "_line" "_non" p1 "_non" p3 "")
  (setq p3 p3))

(defun off_ang_dia  (p0 off ang dia dir_0 / p1 p2 p01) ; Линия в направлении (ang+dir_0) из точки, лежащей на перпедикуляре к dir_0
                                        ; проходящем через p0 на расстоянии rad, проекция линии на направление dir_0
                                        ; равна off ; зеркальная к ней ; и линия замыкающая концы этих линий.
  (setq p1 (off_ang_rad p0 off ang (/ dia 2.) dir_0))
  (setq p2 (off_ang_rad p0 off ang (/ dia -2.) dir_0))
  (command "_line" "_non" p1 "_non" p2 "")
  (setq p01 (polar p0 dir_0 off))
  (inters p0 p01 p1 p2 nil))




(defun konus  (p1 p2 alfa dir_0 / d p11 p21 p3) ; 2 линии проходящие через p1 p2 в направлении
                                        ; (dir_0+alfa) и (dir_0-alfa) соответственно до точки их пересечения.
  (setq d (distance p1 p2))
  (setq p11 (polar p1 (+ dir_0 alfa) d))
  (setq p21 (polar p2 (+ dir_0 (- 0 alfa)) d))
  (setq p3 (inters p1 p11 p2 p21 nil))
  (command "_line" "_non" p1 "_non" p3 "_non" p2 "")
  (setq p3 p3))

(defun otv  (p0 d l alfa dir_0 / p1 p2)
  (setq p1 (off_ang_rad p0 l 0 (/ d 2.) dir_0))
  (setq p2 (off_ang_rad p0 l 0 (/ d -2.) dir_0))
  (command "_line" p1 "_non" p2 "_non" "")
  (konus p1 p2 alfa dir_0))

(defun otv_faska  (p0 d l h alfa gamma dir_0 / p1 p2 p3)
  (setq p1 (polar p0 dir_0 h))
  (setq p2 (polar p1 (+ dir_0 (/ pi 2.)) (/ d 2.)))
  (setq p3 (polar p1 (- dir_0 (/ pi 2.)) (/ d 2.)))
  (command "_line" "_non" p2 "_non" p3 "")
  (otv p1 d (- l h) alfa dir_0)
  (off_ang_rad p1 h gamma (/ d 2.) (+ pi dir_0))
  (off_ang_rad p1 h gamma (/ d -2.) (+ pi dir_0)))

(defun otv_rezba  (p0 d1 d2 h l1 l2 l3 alfa betta gamma dir_0 / p1)
  (otv_faska p0 d1 l1 h alfa gamma dir_0)
  (setq p1 (off_ang_dia p0 l2 0 d2 dir_0))
  (off_ang_dia p1 l3 betta d2 dir_0))

(defun c:z-point(/ p)
  (setq p (getpoint "Укажите точку:"))
  (command "_point" ".xy" p ".z" "*0,0,0" ))