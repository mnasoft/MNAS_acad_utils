(defun format:draw_line  (p1 p2 col)
  (entmake
    (list (cons 0 "LINE") (cons 10 p1) (cons 6 "BYBLOCK") (cons 8 "0") (cons 11 p2) (cons 62 col))))

(defun draw_text  (p11 gar str_1)
  (entmake (list (cons 0 "TEXT")
                 (cons 10 '(0 0 0))
                 (cons 6 "BYBLOCK")
                 (cons 8 "0")
                 (cons 11 p11)
                 (cons 40 3.5)
                 (cons 50 0.0)
                 (cons 51 0.0)
                 (cons 72 4)
                 (cons 1 str_1)
                 (cons 7 gar)
                 (cons 62 7))))

(defun pp_a (p0 p1 a) (polar p0 (+ a (angle p0 p1)) (distance p0 p1)))

(defun draw_dop_sht  (ss11 / ll1 str2 i1 p0 an0 p1 p2 p3 p4)
  (setq ll1 dsht_3_val)
  (while (setq ll2 (car ll1))
    (setq ll1 (cdr ll1))
    (setq str1 (car ll2))
    (setq i1 (cdr (assoc 70 (cadr ll2))))
    (setq an0 "0.0d")
    (setq p1 (cdr (assoc 11 (cadr ll2)))
          p2 (cdr (assoc 12 (cadr ll2)))
          p3 (cdr (assoc 13 (cadr ll2)))
          p4 (cdr (assoc 14 (cadr ll2))))
    (cond ((= i1 3)
           (setq p0  p_start
                 an0 0.0)
           (setq p1 (mapcar (function +) p1 p0))
           (setq p2 (mapcar (function +) p2 p0))
           (setq p3 (mapcar (function +) p3 p0))
           (setq p4 (mapcar (function +) p4 p0)))
          ((= i1 0)
           (setq p0 (polar p_start 0.0 (nth 0 for))
                 p1 (mapcar (function +) p1 p0)
                 p2 (mapcar (function +) p2 p0)
                 p3 (mapcar (function +) p3 p0)
                 p4 (mapcar (function +) p4 p0)))
          ((= i1 1)
           (setq p0 (polar (polar p_start 0.0 (nth 0 for)) (/ pi 2.0) (nth 1 for))
                 p1 (mapcar (function +) p1 p0)
                 p2 (mapcar (function +) p2 p0)
                 p3 (mapcar (function +) p3 p0)
                 p4 (mapcar (function +) p4 p0)))
          ((= i1 2)
           (if (or (and (= dir_sht 1) (> (nth kr_no kr_val) 1))
                   (and (= dir_sht 1) (= (nth kr_no kr_val) 1) (/= (nth for_no for_name) "А4"))
                   (and (= dir_sht 0) (= (nth kr_no kr_val) 1) (= (nth for_no for_name) "А4")))
             (setq p0 (polar p_start (/ pi 2.0) (nth 1 for))
                   p1 (mapcar (function +) p1 p0)
                   p2 (mapcar (function +) p2 p0)
                   p3 (mapcar (function +) p3 p0)
                   p4 (mapcar (function +) p4 p0))
             (setq p0  (polar (polar (mapcar (function +) p_start '(0.0 15.0 0.0)) 0.0 (nth 0 for)) (/ pi 2.) (nth 1 for))
                   an0 "-90.0d"
                   p1  (polar (polar (pp_a p_start p1 (/ pi -2.0)) 0.0 (nth 0 for)) (/ pi 2.0) (+ (nth 1 for) 15.))
                   p2  (polar (polar (pp_a p_start p2 (/ pi -2.0)) 0.0 (nth 0 for)) (/ pi 2.0) (+ (nth 1 for) 15.))
                   p3  (polar (polar (pp_a p_start p3 (/ pi -2.0)) 0.0 (nth 0 for)) (/ pi 2.0) (+ (nth 1 for) 15.))
                   p4  (polar (polar (pp_a p_start p4 (/ pi -2.0)) 0.0 (nth 0 for)) (/ pi 2.0) (+ (nth 1 for) 15.))))))
    (command "_insert" (strcat "*" (findfile (cdr (assoc 2 (cadr ll2))))) "_non" p0 1.0 an0)
    (setq ss11 (hid_re p1 p2 p3 p4 ss11))))

(defun draw_zona  (/ kr ff ff1 en1)
  (setq pick2 (ssadd)
        en1   (entlast))
  (format:draw_line (mapcar (function +) p_start (list 15.0 5.0 0.0))
             (mapcar (function +) p_start (list 15.0 (- (cadr for) 5.0) 0.0))
             7)                         ;Линии границы зоны на поле подшивки (20мм.)
  (format:draw_line (mapcar (function +) p_start (list 15.0 5.0 0.0))
             (mapcar (function +) p_start (list 20.0 5.0 0.0))
             7)
  (format:draw_line (mapcar (function +) p_start (list 20.0 (- (cadr for) 5.0) 0.0))
             (mapcar (function +) p_start (list 15.0 (- (cadr for) 5.0) 0.0))
             7)
  (setq kr (nth kr_no kr_val))
  (setq ff (nth 4 for_val))
  (if (or (and (> kr 1) (= dir_sht 1)) (and (= kr 1) (= dir_sht 0)))
    (setq ff (reverse ff)))
  (if (/= (/ for_no 2.) (/ for_no 2))
    (setq ff (reverse ff)))
  (setq ff1 (mapcar '/ for ff))
  (setq i1 (1- (nth 1 ff1)))
  (setq l1 (nth 1 ff))
  (while (> i1 0)
    (format:draw_line (mapcar (function +) (list 0.0 (* l1 i1) 0.0) p_start)
               (mapcar (function +) (list (nth 0 for) (* l1 i1) 0.0) p_start)
               7)
    (setq i1 (1- i1)))
  (setq i1 (1- (nth 0 ff1)))
  (setq l1 (nth 0 ff))
  (while (> i1 0)
    (format:draw_line (mapcar (function +) (list (* l1 i1) 0.0 0.0) p_start)
               (mapcar (function +) (list (* l1 i1) (nth 1 for) 0.0) p_start)
               7)
    (setq i1 (1- i1)))
  (while (setq en1 (entnext en1)) (setq pick2 (ssadd en1 pick2)))
  (setq i1 (nth 0 ff1))
  (while (> i1 0)
    (draw_text (mapcar (function +)
                       (list (* (nth 0 ff) (- 1 i1)) 0.0 0.0)
                       p_start
                       (list (+ (/ (nth 0 ff) -2.) (nth 0 for)) 2.5 0.0))
               "T"
               (itoa (+ zone_dig i1 -1)))
    (draw_text (mapcar (function +)
                       (list (* (nth 0 ff) (- 1 i1)) 0.0 0.0)
                       p_start
                       (list (+ (/ (nth 0 ff) -2.) (nth 0 for)) (- (nth 1 for) 2.5) 0.0))
               "T"
               (itoa (+ zone_dig i1 -1)))
    (setq i1 (1- i1)))
  (setq i1 (nth 1 ff1))
  (while (> i1 0)
    (if (= 1 i1)
      (draw_text (mapcar (function +) p_start (list 17.5 168.5 0.0)) "T" (chr (+ zone_ch i1 -1)))
      (draw_text (mapcar (function +) (list 0.0 (* (nth 1 ff) i1) 0.0) p_start (list 17.5 (/ (nth 1 ff) -2.) 0.0))
                 "T"
                 (chr (+ zone_ch i1 -1))))
    (draw_text (mapcar (function +)
                       (list 0.0 (* (nth 1 ff) i1) 0.0)
                       p_start
                       (list (+ (nth 0 for) -2.5) (/ (nth 1 ff) -2.) 0.0))
               "T"
               (chr (+ zone_ch i1 -1)))
    (setq i1 (1- i1)))
  (hid_re (mapcar (function +) p_start '(20.0 5.0 0.0))
          (mapcar (function +) '(-5.0 5.0 0.0) (polar p_start 0.0 (nth 0 for)))
          (mapcar (function +) p_start '(-5.0 -5.0 0.0) for)
          (mapcar (function +) '(20 -5.0 0.0) (polar p_start (/ pi 2.) (nth 1 for)))
          pick2))

(defun draw_shtamp  (/ s1)
  (setq s1 (nth f_no f_key))
  (cond ((= s1 "1")
         (command "_insert"
                  (strcat "*" (findfile "acad_w.sup/FORMAT/sht_1.dwg"))
                  "_non"
                  (polar p_start 0.0 (nth 0 for))
                  "1"
                  "0")
         (if (or (and (= dir_sht 1) (> (nth kr_no kr_val) 1))
                 (and (= dir_sht 1) (= (nth kr_no kr_val) 1) (/= (nth for_no for_name) "А4"))
                 (and (= dir_sht 0) (= (nth kr_no kr_val) 1) (= (nth for_no for_name) "А4")))
           (command "_insert"
                    (strcat "*" (findfile "acad_w.sup/FORMAT/sht_2.dwg"))
                    "_non"
                    (polar p_start (/ pi 2.0) (nth 1 for))
                    "1"
                    "0")
           (command "_insert"
                    (strcat "*" (findfile "acad_w.sup/FORMAT/sht_2.dwg"))
                    "_non"
                    (polar (polar (mapcar (function +) p_start '(0.0 15.0 0.0)) 0.0 (nth 0 for)) (/ pi 2.) (nth 1 for))
                    "1"
                    "-90"))
         (if (and (= divzone_no 1) (or (/= for_no 4) (and (= for_no 4) (> kr_no 0))))
           (command "_insert"
                    (strcat "*" (findfile "acad_w.sup/FORMAT/sht_3.dwg"))
                    "_non"
                    (polar p_start 0.0 (nth 0 for))
                    "1"
                    "0")))
        ((= s1 "2")
         (command "_insert"
                  (strcat "*" (findfile "acad_w.sup/FORMAT/sht_4.dwg"))
                  "_non"
                  (polar p_start 0.0 (nth 0 for))
                  "1"
                  "0"))
        ((= s1 "2аг")
         (command "_insert"
                  (strcat "*" (findfile "acad_w.sup/FORMAT/sht_5.dwg"))
                  "_non"
                  (polar p_start 0.0 (nth 0 for))
                  "1"
                  "0")
         (if (or (and (= dir_sht 1) (> (nth kr_no kr_val) 1))
                 (and (= dir_sht 1) (= (nth kr_no kr_val) 1) (/= (nth for_no for_name) "А4"))
                 (and (= dir_sht 0) (= (nth kr_no kr_val) 1) (= (nth for_no for_name) "А4")))
           (command "_insert"
                    (strcat "*" (findfile "acad_w.sup/FORMAT/sht_2.dwg"))
                    "_non"
                    (polar p_start (/ pi 2.0) (nth 1 for))
                    "1"
                    "0")
           (command "_insert"
                    (strcat "*" (findfile "acad_w.sup/FORMAT/sht_2.dwg"))
                    "_non"
                    (polar (polar (mapcar (function +) p_start '(0.0 15.0 0.0)) 0.0 (nth 0 for)) (/ pi 2.) (nth 1 for))
                    "1"
                    "-90")))
        ((= s1 "2ат")
         (command "_insert"
                  (strcat "*" (findfile "acad_w.sup/FORMAT/sht_5.dwg"))
                  "_non"
                  (polar p_start 0.0 (nth 0 for))
                  "1"
                  "0"))
        ((= s1 "2б")
         (command "_insert"
                  (strcat "*" (findfile "acad_w.sup/FORMAT/SHT_4_S.dwg"))
                  "_non"
                  (polar p_start 0.0 (nth 0 for))
                  "1"
                  "0"))
        ((= s1 "2бн")
         (command "_insert"
                  (strcat "*" (findfile "acad_w.sup/FORMAT/SHT_6_R.dwg"))
                  "_non"
                  (polar p_start 0.0 (nth 0 for))
                  "1"
                  "0"))
        ((= s1 "2бч")
         (command "_insert" (strcat "*" (findfile "acad_w.sup/FORMAT/SHT_6_L.dwg")) "_non" p_start "1" "0"))
        ((= s1 "3"))))
