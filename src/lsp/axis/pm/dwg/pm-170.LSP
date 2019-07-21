'("Gas2Oil"  "Oil2Gas"
  "N"        "GQ010"    "P02"
  "EN1"      "EN2"
  "FQ010"    "FQ110"
  "T04"	     "T04max"	"T04min"
  
  "FP210"    "FP220"    "FP230"      
  
  "EB100"    "EB110"    "EB120"
  
  "FT010"    "FT020"    "PT250"    "PT240"    "PT230"
  "WP020"    "WP030"    "WT100"    "PT210"    "PT220"    "FT310"    "FT320"    "FA010"    "FA016"
  "FF116"    "FA020"    "FA026"
  
  "PH066"    "PH076"    "FH176"
  "FK200"    "FK201"    "FH206"    "FH207"
  "FK250"    "FK251"    "FH256"    "FH257"
  "FK260"    "FK261"    "FH266"    "FH267"
  "FK270"    "FK271"    "FH276"    "FH277"
  "FK280"    "FK281"    "FH286"    "FH287"
  "FK290"    "FK291"    "FH296"    "FH297"
  "FK300"    "FK301"    "FH306"    "FH307"
  "FK310"    "FK311"    "FH316"    "FH317"
  "FK350"    "FH356"    "FH366"
  "FK370"    "FH376"    "FH386"
  "FK480"    "FH486"    "FH487"
  "FK400"    "FK401"    "FH406"    "FH407"
  
  "WH010"    "WH011"    "WH016"    "WH017"
  

  "FK230"    "FH236"    "FH226"    "FH046"
  "FK010"    "FK020"
  "FH036"    "FH016"    "FH028"    "FH027"
  
  "FK211"    "FH336"    "FH346"    "FH466"    "FH476"
  
  "FA011"    "FA012"    "FM016"    "FU116"    "Hand_FM01"           "FA021"    "FA022"    "FM026"
  "FU016")

(defun foo  (data / l len)
  (setq len (length (nth 1 data))
        i   1)
  (while (< i len)
    (set (read (nth i (nth 1 data)))
         (mapcar (function (lambda (el) (list (- (nth 0 el) (caar(cddr data))) (nth i el)))) (cddr data)))
    (setq i (1+ i))))

(foo Alsp_nm)















  
