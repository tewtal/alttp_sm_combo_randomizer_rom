#!/usr/bin/env bash
# Remember to commit an updated build.bat as well if making changes

echo Building Super Metroid + Zelda

find . -name build.py -exec python {} \;

cd resources
python create_exhirom.py sm_orig.sfc alttp_orig.sfc zsm_orig.sfc
cp -f zsm_orig.sfc zsm.sfc > /dev/null
./asar --symbols=wla --symbols-path=../build/zsm.sym ../src/main.asm zsm.sfc
cp zsm.sfc ../build/zsm.sfc > /dev/null

echo Done
