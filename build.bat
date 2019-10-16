@echo off
:: Remember to commit an updated build.sh as well if making changes

echo Building Super Metroid + Zelda

for /r %%f in (build*.py) do python %%f

cd resources
python create_exhirom.py sm_orig.sfc alttp_orig.sfc zsm_orig.sfc
copy /y zsm_orig.sfc zsm.sfc > NUL
asar --symbols=wla --symbols-path=..\build\zsm.sym ..\src\main.asm zsm.sfc
copy zsm.sfc ..\build\zsm.sfc > NUL

cd ..
echo Done
