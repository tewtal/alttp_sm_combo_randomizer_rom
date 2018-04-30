@echo off
echo Building Super Metroid + Zelda
cd resources
copy /y orig.bin zsm.sfc > NUL:
asar ..\src\main.asm zsm.sfc
copy zsm.sfc "..\build\zsm.sfc" > NUL:
cd ..
echo Done