#!/bin/bash

# USAGE
# . sections_by_ext.sh

make_nsi_multi_sec()
{
  echo 'Starting job                   at' `date`
  echo 'Compiling *.cpp files          at' `date`
  
  g++ inst_uninst_sections.cpp -o iu
  g++ file_reverse.cpp -o file_reverse
  
  echo 'Cleaning files                 at' `date`
  . ./section_ext.sh   # Loading common variables and functions
  cleaning_output_files
  echo >files_by_ext.tmp
  
  echo 'Finding files                  at' `date`
  
  for i in $f_ext 
  do
    find . -type f -and -name "*.$i" >>files_by_ext.tmp
  done 
  
  echo 'Creating sections tmp files    at' `date`
  iu.exe <files_by_ext.tmp
  
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
