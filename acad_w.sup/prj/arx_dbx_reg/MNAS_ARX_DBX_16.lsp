
;;;;;;("mnas_arx_dbx_registry_16" "��������� reg-����, ��������������� ��� �������� � ������ Visual Studio Net ���������� � �������� ������ MNAS_cad_utils." "���������")
(defun c:mnas_arx_dbx_registry_16 (/		     arx_dirs	       dbx_dirs
				   full_ver_str	     db_version	       R_version
				   fn		     reg_file	       mnasarx_adddimstyle
				   mnasarx_pozition  mnasarx_welding   mnasdbx_pozition
				   mnasdbx_welding
				  )
  (setq
    full_ver_str (getvar "ACADVER")
    db_version	 (substr full_ver_str
			 1
			 (vl-string-position (ascii ".") full_ver_str)
		 )
    R_version	 (strcat "R" db_version ".")
  )
  (setq	arx_dirs (c:mnas_arx_dirs)
	arx_dirs (restrict_not_match arx_dirs R_version)
  )
  (setq	dbx_dirs (c:mnas_dbx_dirs)
	dbx_dirs (restrict_not_match dbx_dirs R_version)
  )
  (setq fn (getfiled "��� ����� �������" "mnas_arx_dbx_16" "reg" 1))
  (setq reg_file (open fn "w"))
  (setq
    full_ver_str (getvar "ACADVER")
    db_version	 (substr full_ver_str
			 1
			 (vl-string-position (ascii ".") full_ver_str)
		 )
    R_version	 (strcat "R" db_version ".")
  )
  (setq
    mnasarx_adddimstyle	"MNASArx_AddDimstyle"

    mnasarx_pozition	"MNASArx_Pozition"
    mnasdbx_pozition	"MNASDbx_Pozition"

    mnasarx_welding	"MNASArx_Welding"
    mnasdbx_welding	"MNASDbx_Welding"

    mnasarx_klejmo	"MNASArx_Klejmo"
    mnasdbx_klejmo	"MNASDbx_Klejmo"

    mnasarx_defaultmenu	"MNASArx_DefaultMenu"
  )
  
  (princ "Windows Registry Editor Version 5.00" reg_file)


(form_reg_for_arx_app
  mnasarx_pozition
  db_version
  "dword:0000000c"
  '(("MNASPozition" "pos")
    ("MNASPozEdit" "posed")
    ("MNASPozMatch" "posma")
   )
  arx_dirs
)

(form_reg_for_dbx_app
  mnasdbx_pozition
  db_version
  "dword:00000001"
  dbx_dirs
)
;;;----------------------------------------------------------------------

(form_reg_for_arx_app
  mnasarx_welding
  db_version
  "dword:0000000c"
  '(
    ("MNASWelding" "sv")
    ("MNASWeldEdit" "sved")
   )
  arx_dirs
)


(form_reg_for_dbx_app  mnasdbx_welding  db_version  "dword:00000001"  dbx_dirs)
;;;----------------------------------------------------------------------

(form_reg_for_arx_app mnasarx_klejmo db_version	"dword:0000000c" '(("MNASKlejmo" "MNASKlejmo"))	arx_dirs)
(form_reg_for_dbx_app mnasdbx_klejmo db_version "dword:00000001" dbx_dirs)
;;;----------------------------------------------------------------------


  (form_reg_for_arx_app
    mnasarx_adddimstyle
    db_version
    "dword:0000000c"
    '(
      ("MNASAddDimStyle" "MNASAddDimStyle")
      ("MNASsetDimtxt" "MNASsetDimtxt")
      ("MNASsetDimsd1" "MNASsetDimsd1")
      ("MNASsetDimsd2" "MNASsetDimsd2")
      ("MNASsetDimatfit" "MNASsetDimatfit")
      ("MNASsetDimtoh" "MNASsetDimtoh")
      ("MNASsetDimtad" "MNASsetDimtad")
      ("MNASsetDimtmove" "MNASsetDimtmove")
      ("MNASsetDimtofl" "MNASsetDimtofl")
      ("MNASsetDimjust" "MNASsetDimjust")
     )
    arx_dirs
  )
;;;----------------------------------------------------------------------
  (form_reg_for_arx_app    mnasarx_defaultmenu	db_version "dword:00000002" '()	arx_dirs)
;;;----------------------------------------------------------------------

  (princ (strcat "[HKEY_LOCAL_MACHINE\\SOFTWARE\\MNASoft\\" db_version "]" "\n") reg_file)

  (princ "\"ROOT\"=\"[TARGETDIR]\"" reg_file)

  (close reg_file)
)
