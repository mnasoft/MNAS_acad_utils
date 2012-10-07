out_file=./vlx/M_cmds.PRV
cd ../

echo >$out_file
echo "(PRV-DEF (:target . \"M_cmds.VLX\")
  (:active-x . T)
  (:separate-namespace . T)
  (:protected . T)
  (:load-file-list" >>$out_file
  
for i in `find -name "*.prj"`
do
echo "    (:prj \".$i\")" >>$out_file
done

echo "  )
   (:require-file-list" >>$out_file

for i in `find -name "*.dcl"`
do
echo "    (:DCL \".$i\")" >>$out_file
done

echo "  )
   (:ob-directory . \"../vlisp.tmp\")
   (:tmp-directory . \"../vlisp.tmp\")
   (:optimization . st)
)
;; EOF " >>$out_file
	
