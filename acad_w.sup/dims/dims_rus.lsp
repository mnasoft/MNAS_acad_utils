(setq *dims-command-list*
       '("ins_blk" "bas" "poz" "up" "bot" "d_up" "cut" "look" "obj_data" "dwg_put" "dwg_get" "welding" "index_ru"
         "index_en" "index" "lea"))
;;;; (opech_cmds-str *dims-command-list*)

(defun c:���_���() (c:ins_blk))
(defun c:���() (c:bas))
(defun c:���() (c:poz))
(defun c:��() (c:up))
(defun c:���() (c:bot))
(defun c:�_��() (c:d_up))
(defun c:���() (c:cut))
(defun c:����() (c:look))
(defun c:���_����() (c:obj_data))
(defun c:���_���() (c:dwg_put))
(defun c:���_���() (c:dwg_get))
(defun c:�������() (c:welding))
(defun c:�����_��() (c:index_ru))
(defun c:�����_��() (c:index_en))
(defun c:�����() (c:index))
(defun c:���() (c:lea))

(princ "Loaded project dims.\n")


