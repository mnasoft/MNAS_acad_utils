inst_fn="inst.tmp"
un_inst_fn="un.inst.tmp"
rm_dir_fn="rmdir.tmp"

uninst_dirs()
{ 
dirs=`ls -d */`
echo "" > $rm_dir_fn
for j in $dirs
do
  stree=`find $j -type d | sort -r`
  for k in $stree
  do
    echo "  RMDir  \$INSTDIR/$k" >> $rm_dir_fn
  done
done
sed -i "s/\//\\\/g" $rm_dir_fn
sed -i "s/[\]$//" $rm_dir_fn
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

assa="EXE INI VLX arx bat bmp cui cuix dat dbx dcl dwg fnt fon glb hdx html ijk jpg js lin log lsp mea mnl nsi png prj prv rtf sh shp shx slb sld ttf txt"

echo >$inst_fn
echo >$un_inst_fn
for i in $assa 
do  
inst_uninst_section_create $i $i un.$i $inst_fn $un_inst_fn
done

uninst_dirs