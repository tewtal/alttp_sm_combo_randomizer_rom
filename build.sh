#!/usr/bin/env bash
# Remember to commit an updated build.bat as well if making changes

echo Building Super Metroid + Zelda

find . -name build.py -exec python {} \;

cd resources
python create_canvas.py 00.sfc ff.sfc
./asar --no-title-check --symbols=wla --symbols-path=../build/zsm.sym ../src/main.asm 00.sfc
./asar --no-title-check --symbols=wla --symbols-path=../build/zsm.sym ../src/main.asm ff.sfc
python create_diff.py -f ips 00.sfc ff.sfc zsm.ips
cp zsm.ips ../build/zsm.ips > /dev/null

echo Done
