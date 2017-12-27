;;;(defun MNAS_ArxPrj_root	 (/ LOADER_32 LOADER_64)
;;;  (setq	LOADER_64 (vl-registry-read
;;;		    (strcat "HKEY_LOCAL_MACHINE\\SOFTWARE\\Wow6432Node\\MNASoft\\"
;;;			    (substr (getvar "acadver") 1 2))
;;;		    "ROOT")
;;;	LOADER_32 (vl-registry-read
;;;		    (strcat "HKEY_LOCAL_MACHINE\\SOFTWARE\\MNASoft\\" (substr (getvar "acadver") 1 2))
;;;		    "ROOT"))
;;;  (VL-STRING-TRANSLATE
;;;    "\\"
;;;    "/"
;;;    (cond (mnasoft-debug mnasoft-debug-path)
;;;	  (LOADER_64)
;;;	  (LOADER_32))))

(defun ac:machine-instance  (/ wscript pcname)
  (cond ((setq wscript (vlax-create-object "WScript.Network"))
         (setq pcname (vlax-get-property wscript "ComputerName"))
         (vlax-release-object wscript)
         pcname)))

(defun mnas_arxprj_root	 ()
  (cond
    ((= (ac:machine-instance) "MNASOFT-01")
     "C:/msys32/home/namatv/develop/git/MNAS_acad_utils")
    ((= (ac:machine-instance) "KO11-118383")
     "D:/PRG/msys32/home/namatv/develop/git/mnasoft/MNAS_acad_utils")
    (t "C:/")))


(defun MNAS_ArxPrj_RoamableRootPrefix () (strcat (MNAS_ArxPrj_root) "/" "RoamableRootPrefix/"))

(defun MNAS_ArxPrj_acad_w () (strcat (MNAS_ArxPrj_root) "/" "acad_w.sup"))

(defun MNAS_ArxPrj_acad_help () (strcat (MNAS_ArxPrj_root) "/" "acad.help"))

(defun MNAS_ArxPrj_vlx () (strcat (MNAS_ArxPrj_root) "/" "vlx"))

(defun acad_sup () (MNAS_ArxPrj_acad_w))

(defun acad_help () (MNAS_ArxPrj_acad_help))

;;;(is_path_full (cdr (assoc 2 (cadr ll2))))
(defun is_path_full (ifp-str) (wcmatch ifp-str "@:*"))

;;;(extend_path (cdr (assoc 2 (cadr ll2))))
(defun extend_path  (extend_path-str)
  (if (is_path_full extend_path-str)
    extend_path-str
    (strcat (acad_sup) extend_path-str)))
