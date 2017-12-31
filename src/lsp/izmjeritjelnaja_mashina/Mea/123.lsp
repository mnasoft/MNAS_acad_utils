(defun read_ijk_file  (/ fn ; имя файла
		       fl ; дескриптор файла
		       line ; строка, считанная из файла
		       xyz_ijk_lst ; список координат точек и ортов подхода к ним
)
;;;  (setq fn (getfiled "title" "default" "ijk" 0))
  (setq fn (findfile (utils:path-src-lsp "Измерительная машина/Mea/h10_1.ijk")))
  (if (null fn)
    (progn (alert
	     (princ
	       (strcat "Не могу открыть файл :" "src/lsp/Измерительная машина/Mea/h10_1.ijk")))
	   (exit)))
  (setq fl (open fn "r"))
  (if (null fl)
    (progn (alert (princ (strcat "Не могу открыть файл :" fn "."))) (exit)))
  (while (setq line (read-line fl))
    (setq xyz_ijk_lst (cons (read (strcat "(" line ")")) xyz_ijk_lst)))
  (close fl)
  xyz_ijk_lst)

(defun find_spline_pts	(xyz_ijk_lst ; список координат точек и ортов подхода к ним
			 / xyz_ijk ; координаты контрольных точек и орты подхода к ним
			 xyz_ijk_prev ; предыдущая точка
			 xyz_ijk_lst ; список координат точек и ортов подхода к ним
			 spline_lst ; список сплайнов
			 spline_temp ; сплайн, состоящий из отчек корыта или спинки
) (mapcar (function
	    (lambda (xyz_ijk)
	      (cond ((null xyz_ijk_prev) (setq xyz_ijk_prev xyz_ijk) (setq spline_temp (cons xyz_ijk spline_temp)))
		    ((and (= (caddr xyz_ijk) (caddr xyz_ijk_prev))
			  (< (distance (xyz_ijk->ijk xyz_ijk) (xyz_ijk->ijk xyz_ijk_prev)) 1.0))
		     (setq xyz_ijk_prev xyz_ijk)
		     (setq spline_temp (cons xyz_ijk spline_temp)))
		    ((or (/= (caddr xyz_ijk) (caddr xyz_ijk_prev))
			 (>= (distance (xyz_ijk->ijk xyz_ijk) (xyz_ijk->ijk xyz_ijk_prev)) 1.0))
		     (setq xyz_ijk_prev xyz_ijk)
		     (setq spline_lst (cons spline_temp spline_lst))
		     (setq spline_temp nil)
		     (setq spline_temp (cons xyz_ijk spline_temp))))))
	  xyz_ijk_lst)
  (setq spline_lst (cons spline_temp spline_lst)))

(defun xyz_ijk->xyz (xyz_ijk) (list (car xyz_ijk) (cadr xyz_ijk) (caddr xyz_ijk)))

(defun xyz_ijk->ijk  (xyz_ijk / temp)
  (setq temp (cdddr xyz_ijk))
  (list (car temp) (cadr temp) (caddr temp)))

(defun print_ijk (ijk_lst) (mapcar (function (lambda (ijk) (print ijk))) ijk_lst))

(defun draw_xyz	 (xyz_ijk_lst color)
  (mapcar (function (lambda (xyz_ijk) (dr:point (list (car xyz_ijk) (cadr xyz_ijk) (caddr xyz_ijk)) 0)))
	  xyz_ijk_lst))

(defun draw_ijk	 (xyz_ijk_lst scale color)
  (mapcar (function (lambda (xyz_ijk / xyz ijk xyz+ijk*scale)
		      (setq xyz		  (xyz_ijk->xyz xyz_ijk)
			    ijk		  (xyz_ijk->ijk xyz_ijk)
			    xyz+ijk*scale (mapcar (function (lambda (x i) (+ x (* i scale)))) xyz ijk))
		      (dr:line xyz+ijk*scale xyz color)))
	  xyz_ijk_lst))

(defun draw:spline_lst	(spline_lst)
  (setq color 10)
  (mapcar (function (lambda (lst)
		      (setq color (cond	((>= color 240) 10)
					(t (+ color 10))))
		      (dr:spline lst color)))
	  spline_lst))
