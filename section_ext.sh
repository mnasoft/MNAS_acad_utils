#!/bin/bash

# This file describe variables and common functions which used in files 
# sections_by_ext.sh and section_one_by_ext.sh

# Extensions wich we can add to output files
f_ext="EXE INI VLX arx bat bmp cui cuix dat dbx dcl dwg fnt fon glb hdx html ijk jpg js lin log lsp mea mnl nsi php png prj prv rtf sh shp shx slb sld ttf txt dot pdf scr"

#Temporare file variables
inst_fn="inst.tmp"
un_inst_fn="un.inst.tmp"
rm_dir_fn="rmdir.tmp"
nsi_tmp="mnas_acad_utils.nsi.tmp"

uninst_dirs()
{
  local d_name
  local stree
  local k
  stree=`find . -type d -and ! -path "./.git*" -and ! -name "." | sort -r`
  for k in $stree
  do
    echo "  RMDir  \$INSTDIR/${k}" >> $rm_dir_fn
  done
  sed -i "s/\/\.\//\//g;s/\//\\\/g" $rm_dir_fn
}

# Cleaning output files
cleaning_output_files()
{
  echo >$inst_fn
  echo >$un_inst_fn
  echo >$rm_dir_fn
  echo >$nsi_tmp
}

create_nsi()
{
echo '; MNAS_acad_utils.nsi

; The name of the installer
Name "mnas_acad_utils"

!define VERSION "2.7.7.7"

LoadLanguageFile "${NSISDIR}\Contrib\Language files\English.nlf"
LoadLanguageFile "${NSISDIR}\Contrib\Language files\Russian.nlf"

VIProductVersion "${VERSION}"
VIAddVersionKey /LANG=${LANG_ENGLISH} "ProductName" "Mnas_acad_utils"
VIAddVersionKey /LANG=${LANG_ENGLISH} "Comments" "Utils for work with AutoCAD© (2007-2011)"
VIAddVersionKey /LANG=${LANG_ENGLISH} "CompanyName" "Nick Matvyeyev (MNASoft)"
VIAddVersionKey /LANG=${LANG_ENGLISH} "LegalTrademarks" "http:\\www.mnasoft.mksat.net"
VIAddVersionKey /LANG=${LANG_ENGLISH} "LegalCopyright" "License: GNU GPL v3.0"
VIAddVersionKey /LANG=${LANG_ENGLISH} "FileDescription" "Утилиты для работы с AutoCAD© (2007-2011)"
VIAddVersionKey /LANG=${LANG_ENGLISH} "FileVersion" "${VERSION}"

VIAddVersionKey /LANG=${LANG_RUSSIAN} "ProductName" "Mnas_acad_utils"
VIAddVersionKey /LANG=${LANG_RUSSIAN} "Comments" "Утилиты для работы с AutoCAD© (2007-2011)"
VIAddVersionKey /LANG=${LANG_RUSSIAN} "CompanyName" "Матвеев Николай Анатольевич (MNASoft)"
VIAddVersionKey /LANG=${LANG_RUSSIAN} "LegalTrademarks" "http:\\www.mnasoft.mksat.net"
VIAddVersionKey /LANG=${LANG_RUSSIAN} "LegalCopyright" "Распространяется по лицензии GNU GPL v3.0"
VIAddVersionKey /LANG=${LANG_RUSSIAN} "FileDescription" "Утилиты для работы с AutoCAD© (2007-2011)"
VIAddVersionKey /LANG=${LANG_RUSSIAN} "FileVersion" "${VERSION}"


; The file to write
OutFile "mnas_acad_utils-${VERSION}.exe"

; The default installation directory
InstallDir $PROGRAMFILES\MNASoft\MNAS_acad_utils

; Registry key to check for directory (so if you install again, it will 
; overwrite the old one automatically)

InstallDirRegKey HKLM "Software\MNASoft" "ROOT"

; Request application privileges for Windows Vista
RequestExecutionLevel admin

LicenseData ./gpl-3.0.txt

;______________________________________________________________________________

; Pages
Page license
Page components
Page directory
Page instfiles

UninstPage uninstConfirm
UninstPage instfiles

;______________________________________________________________________________

; The stuff to install
Section "mnas_acad_utils (required)"

  SectionIn RO
  
  ; Set output path to the installation directory.
  SetOutPath $INSTDIR
  
  ; Put file there

  ; Write the installation path into the registry
  
  WriteRegStr HKLM SOFTWARE\MNASoft    "ROOT" "$INSTDIR"
  WriteRegStr HKLM SOFTWARE\MNASoft\16 "ROOT" "$INSTDIR"
  WriteRegStr HKLM SOFTWARE\MNASoft\17 "ROOT" "$INSTDIR"
  WriteRegStr HKLM SOFTWARE\MNASoft\18 "ROOT" "$INSTDIR"
  WriteRegStr HKLM SOFTWARE\MNASoft\19 "ROOT" "$INSTDIR"
  
  ; Write the uninstall keys for Windows
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\mnas_acad_utils" "DisplayName" "mnas_acad_utils"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\mnas_acad_utils" "UninstallString" "$INSTDIR\uninstall.exe"
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\mnas_acad_utils" "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\mnas_acad_utils" "NoRepair" 1
  WriteUninstaller "uninstall.exe"
  
SectionEnd

; Optional section (can be disabled by the user)
Section "Start Menu Shortcuts"

  CreateDirectory "$SMPROGRAMS\mnas_acad_utils"
  
  CreateShortCut "$SMPROGRAMS\mnas_acad_utils\Uninstall.lnk"               "$INSTDIR\uninstall.exe"           "" "$INSTDIR\uninstall.exe" 0
  CreateShortCut "$SMPROGRAMS\mnas_acad_utils\README.txt.lnk"              "$INSTDIR\README.txt"              "" "" 0  
  CreateShortCut "$SMPROGRAMS\mnas_acad_utils\Change.log.lnk"              "$INSTDIR\Change.log"              "" "" 0  
  CreateShortCut "$SMPROGRAMS\mnas_acad_utils\CopyRight.html.lnk"          "$INSTDIR\CopyRight.html"          "" "" 0  
  CreateShortCut "$SMPROGRAMS\mnas_acad_utils\CopyRight.rtf.lnk"           "$INSTDIR\CopyRight.rtf"           "" "" 0  
  CreateShortCut "$SMPROGRAMS\mnas_acad_utils\gpl-3.0.rtf.lnk"             "$INSTDIR\gpl-3.0.rtf"             "" "" 0  
  CreateShortCut "$SMPROGRAMS\mnas_acad_utils\gpl-3.0-standalone.html.lnk" "$INSTDIR\gpl-3.0-standalone.html" "" "" 0  

SectionEnd

;_Section_MNASoft_files_Start__________________________________________________'  > $nsi_tmp

cat inst.tmp >> $nsi_tmp

echo '
;_Section_MNASoft_files_END____________________________________________________

; Uninstaller
;______________________________________________________________________________
' >> $nsi_tmp

cat un.inst.tmp >> $nsi_tmp

echo '
;______________________________________________________________________________
Section "Uninstall"
  
  ; Remove registry keys
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\mnas_acad_utils"
  
  DeleteRegKey HKLM SOFTWARE\MNASoft

  ; Remove files and uninstaller
  Delete $INSTDIR\mnas_acad_utils.nsi
  Delete $INSTDIR\uninstall.exe
  
;_RMDir_Start_______________________________________________________________________
' >> $nsi_tmp

cat rmdir.tmp >> $nsi_tmp

echo '
;_RMDir_End_________________________________________________________________________

  ; Remove shortcuts, if any
  Delete "$SMPROGRAMS\mnas_acad_utils\*.*"

  ; Remove directories used
  RMDir "$SMPROGRAMS\mnas_acad_utils"
  
  RMDir "$INSTDIR"

SectionEnd
' >> $nsi_tmp
}
