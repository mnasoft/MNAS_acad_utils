import os
import os.path
f_lst=[]
for root, dirs, files in os.walk('.'):
  if '.git' in dirs:
    dirs.remove('.git')
  for name in files:
    print(os.path.join(root, name))
    f_lst.append(os.path.join(root, name))
def str_iter(string):
  if string[-len(extension):]==extension: 
    return True
  else: 
    return False
extension='.js'
filter(str_iter, f_lst)
