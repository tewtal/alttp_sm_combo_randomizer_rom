@echo off
echo Building Super Metroid + Zelda
cd resources
python create_exhirom.py sm_orig.sfc alttp_orig.sfc zsm_orig.sfc
copy /y zsm_orig.sfc zsm.sfc > NUL:
asar ..\src\main.asm zsm.sfc
copy zsm.sfc "..\build\zsm.sfc" > NUL:
cd ..
echo Done