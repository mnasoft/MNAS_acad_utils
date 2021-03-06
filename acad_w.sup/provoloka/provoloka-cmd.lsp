(vl-load-com)

;;;;;;("prov" "���������� ���������� ��� ���������� ����������� ����������� ���������." "������")
                                        ;entname curve-obj
(defun c:prov  (/ curve-obj d delta end_dist end_param k_rad k_shag len lst n pnt_lst_1 pnt_lst_2 start_dist start_param)
  (setq d (getdist "������� ���������:"))
  (setq delta (* d 1.0))
  (setq k_shag 0.2)
  (setq k_rad 1.0)
  (setq entname (car (entsel "�������� ������:")))
  (setq curve-obj (vlax-ename->vla-object entname))
  (setq start_param (vlax-curve-getstartparam curve-obj))
  (setq end_param (vlax-curve-getendparam curve-obj))
  (setq start_dist (vlax-curve-getdistatparam curve-obj start_param))
  (setq end_dist (vlax-curve-getdistatparam curve-obj end_param))
  (setq len (- end_dist start_dist))
  (setq n (fix (/ len (/ d k_shag))))
  (setq lst (foo_1 (sub-div-n n)))
  (setq pnt_lst_1 (mapcar (function (lambda (el) (list-1 curve-obj len el lst delta))) lst))
  (dr:pline pnt_lst_1 4)
  (command "_fillet" "_r" (* d k_rad))
  (command "_fillet" "_p" "_l" "")
  (setq pnt_lst_2 (mapcar (function (lambda (el) (list-2 curve-obj len el lst delta))) lst))
  (dr:pline pnt_lst_2 6)
  (command "_fillet" "_r" (* d k_rad))
  (command "_fillet" "_p" "_l" ""))

(defun foo_1  (lst / end start)
  (setq start 0)
  (setq end (* 2 (last lst)))
  (append (list start) (mapcar (function (lambda (el) (1- (* 2 el)))) lst) (list end)))

(defun list-1  (curve-obj len i lst delta / end_i start_i dist)
  (setq end_i (last lst))
  (setq start_i (car lst))
  (setq dist (/ (* i len) end_i))
  (setq param (vlax-curve-getparamatdist curve-obj dist))
  (setq pnt (vlax-curve-getpointatparam curve-obj param)) ;(dr:point pnt 1)
  (cond ((= i start_i) (setq k 0.0))
        ((= i end_i) (setq k 0.0))
        ((> (gcd (/ (1+ i) 2) 2) 1) (setq k 1.0))
        (t (setq k -1.0)))
  (setq smesh (* k delta))
  (setq deriv (vlax-curve-getfirstderiv curve-obj param))
  (setq ang (angle (list 0 0 0) deriv))
  (setq pnt_prov (polar pnt (+ ang (* pi 0.5)) (* delta k))) ;(dr:point pnt_prov 3)
  pnt_prov)

(defun list-2  (curve-obj len i lst delta / end_i start_i dist)
  (setq end_i (last lst))
  (setq start_i (car lst))
  (setq dist (/ (* i len) end_i))
  (setq param (vlax-curve-getparamatdist curve-obj dist))
  (setq pnt (vlax-curve-getpointatparam curve-obj param)) ;(dr:point pnt 1)
  (cond ((= i start_i) (setq k 0.0))
        ((= i end_i) (setq k 0.0))
        ((> (gcd (/ (1+ i) 2) 2) 1) (setq k -1.0))
        (t (setq k 1.0)))
  (setq smesh (* k delta))
  (setq deriv (vlax-curve-getfirstderiv curve-obj param))
  (setq ang (angle (list 0 0 0) deriv))
  (setq pnt_prov (polar pnt (+ ang (* pi 0.5)) (* delta k))) ;(dr:point pnt_prov 3)
  pnt_prov)
