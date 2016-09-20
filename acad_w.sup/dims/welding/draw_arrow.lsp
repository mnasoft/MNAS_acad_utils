(defun dr_weld_arrow  (p00 p01 / ar_e_an ar_s_an a_p00_p01 a_p01_p2 p1 p2 clock size)
  (setq a_p00_p01 (angle p00 p01)
        ar_s_an   (angtof (cadr (assoc "wg:угол_раскрытия_стрелки" ll_wg_setup)))
        ar_e_an   (angtof (cadr (assoc "wg:угол_хвоста_стрелки" ll_wg_setup)))
        size      (atof (cadr (assoc "wg:размер_стрелки" ll_wg_setup)))
        clock     (cadr (assoc "wg:направление_стрелки" ll_wg_setup))
        a_p01_p2  (cond ((= clock "0") (- a_p00_p01 ar_s_an))
                        (t (+ a_p00_p01 ar_s_an)))
        p2        (polar p00 a_p01_p2 size)
        p1        (cond ((= clock "0") (inters p00 p01 p2 (polar p2 (- a_p00_p01 ar_e_an) 1.0) nil))
                        (t (inters p00 p01 p2 (polar p2 (+ a_p00_p01 ar_e_an) 1.0) nil))))
  (dr:line p00 p01 256)
  (dr:solid p00 p1 p2 p2 256))


(defun dr_po_konturu  (p01 / size)
  (setq size (atof (cadr (assoc "wg:радиус_по_контуру" ll_wg_setup))))
  (dr:circle p01 size 256))

