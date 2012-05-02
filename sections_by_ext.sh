#!/bin/bash

# USAGE
# . sections_by_ext.sh

inst_uninst_section_create()
{
  file_ext="$1"         #"lsp"
  sec_inst_name="$2"    #"lsp"
  sec_uninst_name="$3"  #"un.lsp"
  sec_inst_file="$4"    #"inst.txt"
  sec_uninst_file="$5"  #"un.inst.txt"
  
  local f_ext
  
  echo "Section \"$sec_inst_name\"" >>$sec_inst_file
  f_ext=`find . -name "*.$file_ext"`
  
  for i in $f_ext
  do
    dn=`dirname $i`
    echo "  SetOutPath \$INSTDIR/$dn"
    echo "  File $i"
  done >>$sec_inst_file
  echo 'SectionEnd' >>$sec_inst_file
  sed -i "s/\//\\\/g" $sec_inst_file

  echo "Section \"$sec_uninst_name\"" >>$sec_uninst_file
  
  for i in $f_ext
  do
    echo "  Delete \$INSTDIR/$i"
  done >>$sec_uninst_file
  
  echo 'SectionEnd' >>$sec_uninst_file
  sed -i "s/\//\\\/g" $sec_uninst_file
}

make_nsi_multi_sec()
{
# Loading common variables and functions
  . ./section_ext.sh

  cleaning_output_files

  for i in $f_ext 
  do  
    inst_uninst_section_create $i $i un.$i $inst_fn $un_inst_fn
  done

  uninst_dirs
  create_nsi
}

make_nsi_multi_sec
