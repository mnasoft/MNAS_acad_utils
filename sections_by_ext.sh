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
#  sed -i "s/\//\\\/g" $sec_inst_file

  echo "Section \"$sec_uninst_name\"" >>$sec_uninst_file
  
  for i in $f_ext
  do
    echo "  Delete \$INSTDIR/$i"
  done >>$sec_uninst_file
  
  echo 'SectionEnd' >>$sec_uninst_file
#  sed -i "s/\//\\\/g" $sec_uninst_file
}

make_nsi_multi_sec()
{
  echo 'Starting job                   at' `date`

  . ./section_ext.sh                            # Loading common variables and functions
  
  echo 'Cleaning files                 at' `date`
  cleaning_output_files

  echo 'Finding files                  at' `date`
  
  for i in $f_ext 
  do  
    inst_uninst_section_create $i $i un.$i $inst_fn $un_inst_fn
  done
  
  echo 'Converting slash types         at' `date`
  
  sed -i "s/\/\.\//\//g;s/\//\\\/g" $inst_fn
  sed -i "s/\/\.\//\//g;s/\//\\\/g" $un_inst_fn

  echo 'Creating uninst dirs tmp file  at' `date`
  
  uninst_dirs
  
  echo 'Creating nsi tmp file          at' `date`
  
  create_nsi
  
  echo 'Stoping job                    at' `date`
}

make_nsi_multi_sec
