(setq str
       (vl-registry-read
	 "HKEY_CURRENT_USER\\Software\\Autodesk\\AutoCAD\\R16.2\\ACAD-4013:409\\Profiles\\<<VANILLA>>\\General"
	 "ACAD"
       )
)

(VL-STRING-SEARCH ";" str 0)
(VL-STRING-SEARCH ";" str 540)

(setq
  len (strlen str)
  i 0
  str_lst nil
)

(while (< i len)
  (setq n (VL-STRING-SEARCH ";" str i))
  (setq s1 (substr str (+ i 1) (- n i)))
  (setq
    i	    (+ 1 n)
    str_lst (cons s1 str_lst)
  )
)

("C:\\Program Files\\MNASoft\\MNAS_cad_utils\\acad.fnt\\kompas"
  "C:\\Program Files\\MNASoft\\MNAS_cad_utils\\acad.fnt"
  "C:\\Program Files\\MNASoft\\MNAS_cad_utils\\acad.mnu\\acad_mnu_icon"
  "C:\\Program Files\\MNASoft\\MNAS_cad_utils\\acad_w.sup"
  "C:\\Program Files\\Autodesk\\MDT 2006\\support\\color"
  "C:\\Program Files\\Autodesk\\MDT 2006\\express"
  "C:\\Program Files\\Autodesk\\MDT 2006\\help"
  "C:\\Program Files\\Autodesk\\MDT 2006\\fonts"
  "C:\\Program Files\\Autodesk\\MDT 2006\\support"
  "C:\\Documents and Settings\\namatv\\Application Data\\Autodesk\\Autodesk Mechanical Desktop 2006\\R16.2\\enu\\support"
 )