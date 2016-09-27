(setq *dims-command-list*
       '("ins_blk" "bas" "poz" "up" "bot" "d_up" "cut" "look" "obj_data" "dwg_put" "dwg_get" "welding" "index_ru"
         "index_en" "index" "lea"))
;;;; (opech_cmds-str *dims-command-list*)

(defun c:רעû_טהכ() (c:ins_blk))
(defun c:טפû() (c:bas))
(defun c:חשÿ() (c:poz))
(defun c:דח() (c:up))
(defun c:טשו() (c:bot))
(defun c:ג_דח() (c:d_up))
(defun c:סדו() (c:cut))
(defun c:הששכ() (c:look))
(defun c:שטמ_גפופ() (c:obj_data))
(defun c:גצן_חדו() (c:dwg_put))
(defun c:גצן_ןףו() (c:dwg_get))
(defun c:צףהגרען() (c:welding))
(defun c:רעגףק_ךד() (c:index_ru))
(defun c:רעגףק_ףע() (c:index_en))
(defun c:רעגףק() (c:index))
(defun c:הףפ() (c:lea))

(princ "Loaded project dims.\n")


