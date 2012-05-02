#!/bin/bash
set_editor()
{
  local var_tmp i
  var_tmp="/c/PRG/Notepad++/notepad++.exe /d/PRG/Notepad++/notepad++.exe"
  for i in $var_tmp
  do
    if [ -x $i ]
      then
	    echo $i
        export GIT_EDITOR=$i
		break
    fi
  done
}

set_editor