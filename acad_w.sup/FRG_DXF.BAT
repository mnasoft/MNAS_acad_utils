@echo off
cls
echo После работы программы можно вставить по команде _dxfin файл %1.dxf
set acad=c:\acad.sup >nul
call d:\user\sf_dxf\cad_sf %1.frg >nul
call d:\user\sf_dxf\sf_dxf %1 >nul
del %1.sf >nul
pause