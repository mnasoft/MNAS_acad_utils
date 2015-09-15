# Сценарий предназначен для построения файла mnas_acad_utils.nsi
# 
# Для запуска данного сценария необходимо:
# 1 Создать ярлык для запуска "Python 3.x (command line - 32 bit)"
# 2 Параметр "Рабочая папка" вновь созданного ярлыка для запуска 
# "Python 3.x (command line - 32 bit)" установить равным пути,
# где находится настоящий файл (nsi.py). 
# 3 Запустить на выполнение интерпретатор команд Python при помощи вновь созданного ярлыка.
# В командной строке интерпритатора выполнить нижеследующую команду:
# >>> import nsi

import os
import os.path
f_lst=[]
d_lst=[]
extension='.lsp'
fn_nsi='mnas_acad_utils.nsi'
fn_version='mnas_acad_utils.version'

#ext_lst=['.txt']
ext_lst=['.EXE', '.INI', '.VLX', '.arx', '.bat', '.bmp', '.cui', '.cuix', '.dat', '.dbx', '.dcl', '.dwg', '.fnt', '.fon', '.glb', '.hdx', '.html', '.ijk', '.jpg', '.js', '.lin', '.log', '.lsp', '.mea', '.mnl', '.nsi', '.php', '.png', '.prj', '.prv', '.rtf', '.sh', '.shp', '.shx', '.slb', '.sld', '.ttf', '.txt', '.dot', '.pdf', '.scr','.ctb','.pmp']


def find_files(pth='.'):
  global f_lst
  f_lst=[]
  for root, dirs, files in os.walk(pth):
    if '.git' in dirs:
      dirs.remove('.git')
    if '__pycache__' in dirs:
      dirs.remove('__pycache__')
    for name in files:
      f_lst.append(os.path.join(root, name))
      
def find_dirs(pth='.'):
  global d_lst
  d_lst=[]
  for root, dirs, files in os.walk(pth):
    if '.git' in dirs:
      dirs.remove('.git')
    if '__pycache__' in dirs:
      dirs.remove('__pycache__')
    for name in dirs:
      d_lst.append(os.path.join(root, name))

def rm_dirs(f_inst, pth='.'):
  global d_lst
  for d in d_lst:
    f_inst.write('''  RMDir  $INSTDIR\\''')
    f_inst.write(d[2:])
    f_inst.write('''\n''')
    
#RMDir  $INSTDIR\vlx\KOMPAS
    
def str_iter(string):
  if string[-len(extension):]==extension:
    return True
  else:
    return False

def str_select(ext):
  global extension
  extension=ext
  for s in filter(str_iter, f_lst):
    print(s)

def select_exts(exts,pth='.'):
  global f_lst
  global extension
  f_lst=[]
  find_files(pth)
  for i in exts:
    extension=i
    for s in filter(str_iter, f_lst):
     print(s)
     
def inst(f_inst,exts,pth='.'):
  global f_lst
  global extension
  for i in exts:
    extension=i
    f_inst.write('''Section "''')
    f_inst.write(extension[1:])
    f_inst.write('''"\n''')
    for s in filter(str_iter, f_lst):
      f_inst.write('''  SetOutPath $INSTDIR\\''')
      dirname = os.path.dirname(s)
      f_inst.write(dirname)
      f_inst.write('''\n''')
      f_inst.write('''  File ''')
      f_inst.write(s)
      f_inst.write('''\n''')
    f_inst.write('''SectionEnd\n''')
    
def uninst(f_inst,exts,pth='.'):
  global f_lst
  global extension
  for i in exts:
    extension=i
    f_inst.write('''Section "un.''')
    f_inst.write(extension[1:])
    f_inst.write('''"\n''')
    for s in filter(str_iter, f_lst):
      f_inst.write('''  Delete $INSTDIR\\''')
      f_inst.write(s)
      f_inst.write('''\n''')
    f_inst.write('''SectionEnd\n''')
    
def create_nsi(pth='.'):
  global f_lst
  global extension
  global ext_lst
  global fn_version
  global fn_nsi
  #Поиск файлов 
  find_files(pth)
  f_lst.sort()
  f_lst.reverse()
  #Поиск каталогов
  find_dirs(pth)
  d_lst.sort()
  d_lst.reverse()
  #Считывание номера версии
  fr=open(fn_version,'r')
  UTILS_VERSION=fr.readline()
  fr.close()
  #Открытие файла установщика
  f_nsi=open(fn_nsi, 'w')
  f_nsi.write('''; MNAS_acad_utils.nsi\n
; The name of the installer
Name "mnas_acad_utils"
''')
  f_nsi.write('''\n!define VERSION "''')
  f_nsi.write(UTILS_VERSION)
  f_nsi.write('''"\n''')
  f_nsi.write('''
LoadLanguageFile "${NSISDIR}\\Contrib\\Language files\\English.nlf"
LoadLanguageFile "${NSISDIR}\\Contrib\\Language files\\Russian.nlf"

VIProductVersion "${VERSION}"
VIAddVersionKey /LANG=${LANG_ENGLISH} "ProductName" "Mnas_acad_utils"
VIAddVersionKey /LANG=${LANG_ENGLISH} "Comments" "Utils for work with AutoCAD© (2007-2011)"
VIAddVersionKey /LANG=${LANG_ENGLISH} "CompanyName" "Nick Matvyeyev (MNASoft)"
VIAddVersionKey /LANG=${LANG_ENGLISH} "LegalTrademarks" "http:\\\\www.mnasoft.mksat.net"
VIAddVersionKey /LANG=${LANG_ENGLISH} "LegalCopyright" "License: GNU GPL v3.0"
VIAddVersionKey /LANG=${LANG_ENGLISH} "FileDescription" "Утилиты для работы с AutoCAD© (2007-2011)"
VIAddVersionKey /LANG=${LANG_ENGLISH} "FileVersion" "${VERSION}"

VIAddVersionKey /LANG=${LANG_RUSSIAN} "ProductName" "Mnas_acad_utils"
VIAddVersionKey /LANG=${LANG_RUSSIAN} "Comments" "Утилиты для работы с AutoCAD© (2013)"
VIAddVersionKey /LANG=${LANG_RUSSIAN} "CompanyName" "Матвеев Николай Анатольевич (MNASoft)"
VIAddVersionKey /LANG=${LANG_RUSSIAN} "LegalTrademarks" "http:\\\\www.mnasoft.mksat.net"
VIAddVersionKey /LANG=${LANG_RUSSIAN} "LegalCopyright" "Распространяется по лицензии GNU GPL v3.0"
VIAddVersionKey /LANG=${LANG_RUSSIAN} "FileDescription" "Утилиты для работы с AutoCAD© (2013)"
VIAddVersionKey /LANG=${LANG_RUSSIAN} "FileVersion" "${VERSION}"


; The file to write
OutFile "mnas_acad_utils-${VERSION}.exe"

; The default installation directory
InstallDir $PROGRAMFILES\\MNASoft\\MNAS_acad_utils

; Registry key to check for directory (so if you install again, it will 
; overwrite the old one automatically)

InstallDirRegKey HKLM "Software\\MNASoft" "ROOT"

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
  
  WriteRegStr HKLM SOFTWARE\\MNASoft    "ROOT" "$INSTDIR"
  WriteRegStr HKLM SOFTWARE\\MNASoft\\16 "ROOT" "$INSTDIR"
  WriteRegStr HKLM SOFTWARE\\MNASoft\\17 "ROOT" "$INSTDIR"
  WriteRegStr HKLM SOFTWARE\\MNASoft\\18 "ROOT" "$INSTDIR"
  WriteRegStr HKLM SOFTWARE\\MNASoft\\19 "ROOT" "$INSTDIR"
  
  ; Write the uninstall keys for Windows
  WriteRegStr HKLM "Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\mnas_acad_utils" "DisplayName" "mnas_acad_utils"
  WriteRegStr HKLM "Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\mnas_acad_utils" "UninstallString" "$INSTDIR\\uninstall.exe"
  WriteRegDWORD HKLM "Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\mnas_acad_utils" "NoModify" 1
  WriteRegDWORD HKLM "Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\mnas_acad_utils" "NoRepair" 1
  WriteUninstaller "uninstall.exe"
  
SectionEnd

; Optional section (can be disabled by the user)
Section "Start Menu Shortcuts"

  SetShellVarContext all

  CreateDirectory "$SMPROGRAMS\\mnas_acad_utils"
  
  CreateShortCut "$SMPROGRAMS\\mnas_acad_utils\\Uninstall.lnk"               "$INSTDIR\\uninstall.exe"           "" "$INSTDIR\\uninstall.exe" 0
  CreateShortCut "$SMPROGRAMS\\mnas_acad_utils\\README.html.lnk"              "$INSTDIR\\README.html"              "" "" 0  
  CreateShortCut "$SMPROGRAMS\\mnas_acad_utils\\Change.log.html.lnk"              "$INSTDIR\\Change.log.html"              "" "" 0  
  CreateShortCut "$SMPROGRAMS\\mnas_acad_utils\\CopyRight.html.lnk"          "$INSTDIR\\CopyRight.html"          "" "" 0  
  CreateShortCut "$SMPROGRAMS\\mnas_acad_utils\\Mnasoft_command_list.html.lnk" "$INSTDIR\\acad.help\\mnasoft_command_list.html"          "" "" 0  
  CreateShortCut "$SMPROGRAMS\\mnas_acad_utils\\CopyRight.rtf.lnk"           "$INSTDIR\\CopyRight.rtf"           "" "" 0  
  CreateShortCut "$SMPROGRAMS\\mnas_acad_utils\\gpl-3.0.rtf.lnk"             "$INSTDIR\\gpl-3.0.rtf"             "" "" 0  
  CreateShortCut "$SMPROGRAMS\\mnas_acad_utils\\gpl-3.0-standalone.html.lnk" "$INSTDIR\\gpl-3.0-standalone.html" "" "" 0  

SectionEnd

;_Section_MNASoft_files_Start__________________________________________________\n''')
  inst(f_nsi,ext_lst,pth)
  f_nsi.write('''
;_Section_MNASoft_files_END____________________________________________________

; Uninstaller
;______________________________________________________________________________
''')
  uninst(f_nsi,ext_lst,pth)
  f_nsi.write('''
;______________________________________________________________________________
Section "Uninstall"
  
  ; Remove registry keys
  DeleteRegKey HKLM "Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\mnas_acad_utils"
  
  DeleteRegKey HKLM SOFTWARE\\MNASoft

  ; Remove files and uninstaller
  Delete $INSTDIR\\mnas_acad_utils.nsi
  Delete $INSTDIR\\uninstall.exe
  
;_RMDir_Start_______________________________________________________________________
''')
  rm_dirs(f_nsi, pth)
  f_nsi.write('''
;_RMDir_End_________________________________________________________________________

  ; Remove shortcuts, if any
  SetShellVarContext all
  Delete "$SMPROGRAMS\\mnas_acad_utils\\*.*"
  
  ; Remove directories used
  RMDir "$SMPROGRAMS\\mnas_acad_utils"
  
  RMDir "$INSTDIR"

SectionEnd
''')
  f_nsi.close()

create_nsi()