; MNAS_acad_utils.nsi
;
; This script is based on example1.nsi, but it remember the directory, 
; has uninstall support and (optionally) installs start menu shortcuts.
;
; It will install example2.nsi into a directory that the user selects,

;--------------------------------

; The name of the installer
Name "mnas_acad_db17_utils"


; The file to write
OutFile "mnas_acad_db17_utils.exe"

; The default installation directory
InstallDir $PROGRAMFILES\mnas_acad_db17_utils_tst

; Registry key to check for directory (so if you install again, it will 
; overwrite the old one automatically)
InstallDirRegKey HKLM "Software\NSIS_mnas_acad_db17_utils_tst" "Install_Dir"

; Request application privileges for Windows Vista
RequestExecutionLevel admin

;--------------------------------

; Pages

Page components
Page directory
Page instfiles

UninstPage uninstConfirm
UninstPage instfiles

;--------------------------------

; The stuff to install
Section "mnas_acad_db17_utils (required)"

  SectionIn RO
  
  ; Set output path to the installation directory.
  SetOutPath $INSTDIR
  
  ; Put file there
  File "mnas_acad_db17_utils.nsi"
  File /r *.lsp
  
  ; Write the installation path into the registry
  WriteRegStr HKLM SOFTWARE\NSIS_mnas_acad_db17_utils_tst "Install_Dir" "$INSTDIR"
  
  ; Write the uninstall keys for Windows
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\mnas_acad_db17_utils_tst" "DisplayName" "NSIS mnas_acad_db17_utils_tst"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\mnas_acad_db17_utils_tst" "UninstallString" '"$INSTDIR\uninstall.exe"'
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\mnas_acad_db17_utils_tst" "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\mnas_acad_db17_utils_tst" "NoRepair" 1
  WriteUninstaller "uninstall.exe"
  
SectionEnd

; Optional section (can be disabled by the user)
Section "Start Menu Shortcuts"

  CreateDirectory "$SMPROGRAMS\mnas_acad_db17_utils_tst"
  CreateShortCut "$SMPROGRAMS\mnas_acad_db17_utils_tst\Uninstall.lnk" "$INSTDIR\uninstall.exe" "" "$INSTDIR\uninstall.exe" 0
  CreateShortCut "$SMPROGRAMS\mnas_acad_db17_utils_tst\mnas_acad_db17_utils_tst (MakeNSISW).lnk" "$INSTDIR\mnas_acad_db17_utils.nsi" "" "$INSTDIR\mnas_acad_db17_utils.nsi" 0
  
SectionEnd

;--------------------------------

; Uninstaller

Section "Uninstall"
  
  ; Remove registry keys
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\mnas_acad_db17_utils_tst"
  DeleteRegKey HKLM SOFTWARE\NSIS_mnas_acad_db17_utils_tst

  ; Remove files and uninstaller
  Delete $INSTDIR\mnas_acad_db17_utils.nsi
  Delete $INSTDIR\uninstall.exe
  RMDir /r $INSTDIR\acad_w.sup
#  Delete $INSTDIR\*.lsp

  ; Remove shortcuts, if any
  Delete "$SMPROGRAMS\mnas_acad_db17_utils_tst\*.*"

  ; Remove directories used
  RMDir "$SMPROGRAMS\mnas_acad_db17_utils_tst"
  RMDir "$INSTDIR"

SectionEnd
