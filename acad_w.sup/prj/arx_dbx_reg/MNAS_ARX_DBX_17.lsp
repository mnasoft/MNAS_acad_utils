;;;;;;("mnas_arx_dirs" "Возвращает информацию о каталогах ARX, установленных в системе программ AutoCAD, на основании данных из системного реестра." "Настройка")
(defun c:mnas_arx_dirs (/ arx_root)
  (setq arx_root '("HKEY_LOCAL_MACHINE\\SOFTWARE\\Autodesk\\AutoCAD"))
  (registry-subdirs (registry-subdirs arx_root))
)
;;;;;;("mnas_dbx_dirs" "Возвращает информацию о каталогах DBX, установленных в системе программ AutoCAD, на основании данных из системного реестра." "Настройка")
(defun c:mnas_dbx_dirs (/ dbx_root)
  (setq dbx_root '("HKEY_LOCAL_MACHINE\\SOFTWARE\\Autodesk\\ObjectDBX"))
  (registry-subdirs dbx_root)
)
;;;;;;("mnas_arx_dbx_registry_17" "Формирует reg-файл, предназначенный для внесения в проект Visual Studio Net информации о командах пакета MNAS_cad_utils." "Настройка")
(defun c:mnas_arx_dbx_registry_17 (/		     arx_dirs	       dbx_dirs
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
  (setq fn (getfiled "Имя файла реестра" "mnas_arx_dbx_17" "reg" 1))
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
    mnasarx_welding	"MNASArx_Welding"
    mnasdbx_pozition	"MNASDbx_Pozition"
    mnasdbx_welding	"MNASDbx_Welding"
  )
  (princ "Windows Registry Editor Version 5.00" reg_file)

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

  (form_reg_for_arx_app
    mnasarx_pozition
    db_version
    "dword:0000000c"
    '(("MNASPozition" "pos")
	       ;      ("MNASPozEdit" "posed")
	       ;      ("MNASPozMatch" "posma")
     )
    arx_dirs
  )
  (form_reg_for_dbx_app MNASDbx_Pozition db_version "dword:00000001" dbx_dirs)

  (form_reg_for_arx_app
    mnasarx_welding
    db_version
    "dword:0000000c"
    '(
      ("MNASWelding" "sv")
	       ;      ("MNASWeldEdit" "sved")
     )
    arx_dirs
  )
  (form_reg_for_dbx_app MNASDbx_Welding db_version "dword:00000001" dbx_dirs)

  (princ (strcat "[HKEY_LOCAL_MACHINE\\SOFTWARE\\MNASoft\\" db_version "]" "\n") reg_file)

  (princ "\"ROOT\"=\"[TARGETDIR]\"" reg_file)

  (close reg_file)
)
