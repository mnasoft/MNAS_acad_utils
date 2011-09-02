uninst_dirs()
{ 
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
}

inst_uninst_section_create()
{
  file_ext="$1"         #"lsp"
  sec_inst_name="$2"    #"lsp"
  sec_uninst_name="$3"  #"un.lsp"
  sec_inst_file="$4"    #"inst.txt"
  sec_uninst_file="$5"  #"un.inst.txt"
  
  local assa
  
  echo "Section \"$sec_inst_name\"" >>$sec_inst_file
  assa=`find . -name "*.$file_ext"`
  
  for i in $assa
  do
    dn=`dirname $i`
    echo "  SetOutPath \$INSTDIR/$dn"
    echo "  File $i"
  done >>$sec_inst_file
  echo 'SectionEnd' >>$sec_inst_file
  sed -i "s/\//\\\/g" $sec_inst_file

  echo "Section \"$sec_uninst_name\"" >>$sec_uninst_file
  
  for i in $assa
  do
    echo "  Delete \$INSTDIR/$i"
  done >>$sec_uninst_file
  
  echo 'SectionEnd' >>$sec_uninst_file
  sed -i "s/\//\\\/g" $sec_uninst_file
}

assa="html jpg js nsi png slb lsp mnl shp shx dcl lin bat INI EXE sld log txt bmp dat fnt glb hdx ijk mea prj prv sh VLX cui cuix fon ttf rtf dwg"

echo >inst.txt
echo >un.inst.txt
for i in $assa 
do  
inst_uninst_section_create $i $i un.$i inst.txt un.inst.txt
done

uninst_dirs