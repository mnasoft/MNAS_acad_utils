#!/bin/bash

# USAGE
# . sections_by_ext.sh

make_nsi_multi_sec()
{
  echo 'Starting job                   at' `date`
  echo 'Compiling *.cpp files          at' `date`
  
  g++ inst_uninst_sections.cpp -o inst_uninst_sections
  g++ file_reverse.cpp -o file_reverse
  

  echo 'Cleaning files                 at' `date`
  . ./section_ext.sh                   # Loading common variables and functions
  cleaning_output_files
  echo >files_by_ext.tmp
  
  echo 'Finding files and creating sec at' `date`
  
  find . -name "*.EXE" \
-or -name "*.INI" \
-or -name "*.VLX" \
-or -name "*.arx" \
-or -name "*.bat" \
-or -name "*.bmp" \
-or -name "*.cui" \
-or -name "*.cuix" \
-or -name "*.dat" \
-or -name "*.dbx" \
-or -name "*.dcl" \
-or -name "*.dwg" \
-or -name "*.fnt" \
-or -name "*.fon" \
-or -name "*.glb" \
-or -name "*.hdx" \
-or -name "*.html" \
-or -name "*.ijk" \
-or -name "*.jpg" \
-or -name "*.js" \
-or -name "*.lin" \
-or -name "*.log" \
-or -name "*.lsp" \
-or -name "*.mea" \
-or -name "*.mnl" \
-or -name "*.nsi" \
-or -name "*.php" \
-or -name "*.png" \
-or -name "*.prj" \
-or -name "*.prv" \
-or -name "*.rtf" \
-or -name "*.sh" \
-or -name "*.shp" \
-or -name "*.shx" \
-or -name "*.slb" \
-or -name "*.sld" \
-or -name "*.ttf" \
-or -name "*.txt" \
-or -name "*.dot" \
-or -name "*.pdf" \
-or -name "*.scr" \
| file_reverse.exe | sort | file_reverse.exe | inst_uninst_sections.exe
  
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
