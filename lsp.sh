# 
dirs=`ls -d */`
echo "" > rmdir.txt
for j in $dirs
do
  stree=`find $j -type d | sort -r`
  for k in $stree
  do
    echo "  RMDir  \$INSTDIR/$k" >> rmdir.txt
  done
done
sed -i "s/\//\\\/g" rmdir.txt
sed -i "s/[\]$//" rmdir.txt

#echo 'Section "lsp"' >lsp.txt
#assa=`find . -name "*.lsp"`
#for i in $assa
#do
#  dn=`dirname $i`
#  echo "  SetOutPath \$INSTDIR/$dn"
#  echo "  File $i"
#done >>lsp.txt
#echo 'SectionEnd' >>lsp.txt
#sed -i "s/\//\\\/g" lsp.txt
#
#echo 'Section "un.lsp"' >un.lsp.txt
#for i in $assa; do  echo "  Delete \$INSTDIR/$i"; done >>un.lsp.txt
#echo 'SectionEnd' >>un.lsp.txt
#sed -i "s/\//\\\/g" un.lsp.txt

#
#file_ext="lsp"

#sec_inst_name="lsp"
#sec_uninst_name="un.lsp"

#sec_inst_file="lsp.txt"
#sec_uninst_file="un.lsp.txt"

inst_uninst_section_create()
{
  file_ext="$1"
  sec_inst_name="$2"
  sec_uninst_name="$3"
  sec_inst_file="$4"
  sec_uninst_file="$5"
  
  local assa
  
  echo "Section \"$sec_inst_name\"" >$sec_inst_file
  assa=`find . -name "*.$file_ext"`
  
  for i in $assa
  do
    dn=`dirname $i`
    echo "  SetOutPath \$INSTDIR/$dn"
    echo "  File $i"
  done >>$sec_inst_file
  echo 'SectionEnd' >>$sec_inst_file
  sed -i "s/\//\\\/g" $sec_inst_file

  echo "Section \"$sec_uninst_name\"" >$sec_uninst_file
  
  for i in $assa
  do
    echo "  Delete \$INSTDIR/$i"
  done >>$sec_uninst_file
  
  echo 'SectionEnd' >>$sec_uninst_file
  sed -i "s/\//\\\/g" $sec_uninst_file
}

inst_uninst_section_create "lsp" "lsp"  "un.lsp" "lsp.txt" "un.lsp.txt"
inst_uninst_section_create "VLX" "VLX"  "un.VLX" "VLX.txt" "un.VLX.txt"
inst_uninst_section_create "html" "html"  "un.html" "html.txt" "un.html.txt"
inst_uninst_section_create "html" "jpg"  "un.jpg" "jpg.txt" "un.jpg.txt"
