(setq *dim-style-command-list*
       '("MNASAddDimStyle" "dim-toh" "dim-rad-hor" "dim-rad-rad" "DIM-SD_SE" "MNASsetDimjust" "MNASsetDimtofl"
         "MNASsetDimtad" "MNASsetDimtmove" "MNASsetDimsd1" "MNASsetDimsd2" "MNASsetDimatfit" "MNASsetDimtoh"
         "dim_0001_1"))
;;;; (opech_cmds-str *dim-style-command-list*)

(defun c:���������������() (c:MNASAddDimStyle))
(defun c:���-���() (c:dim-toh))
(defun c:���-���-���() (c:dim-rad-hor))
(defun c:���-���-���() (c:dim-rad-rad))
(defun c:���-��_��() (c:DIM-SD_SE))
(defun c:��������������() (c:MNASsetDimjust))
(defun c:��������������() (c:MNASsetDimtofl))
(defun c:�������������() (c:MNASsetDimtad))
(defun c:���������������() (c:MNASsetDimtmove))
(defun c:������������1() (c:MNASsetDimsd1))
(defun c:������������2() (c:MNASsetDimsd2))
(defun c:���������������() (c:MNASsetDimatfit))
(defun c:�������������() (c:MNASsetDimtoh))
(defun c:���_0001_1() (c:dim_0001_1))

(princ "Loaded project dim_style.\n")