import os

import os.path

f_lst=[]

extension='.lsp'

ext_lst=['.lsp', '.dcl','.prj', '.prv']

def find_files(pth='.'):
  global f_lst
  for root, dirs, files in os.walk(pth):
    if '.git' in dirs:
      dirs.remove('.git')
    for name in files:
      f_lst.append(os.path.join(root, name))
    
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
