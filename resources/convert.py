#!/usr/bin/env python
import sys
import os
name = ""
base_name = ""

if sys.argv[1] == "":
	print("You need to specify a file to convert")
	sys.exit()
else:
	name = sys.argv[1]
	
f = open(os.path.dirname(os.path.realpath(__file__)) + "\\" + name, "rb")
fo = open(os.path.dirname(os.path.realpath(__file__)) + "\\" + name + ".hirom", "wb")

data = f.read()

for i in range(0, 0x40, 1):	
	hi_bank = data[(i*0x8000):(i*0x8000)+0x8000]
	lo_bank = data[((i+0x40)*0x8000):((i+0x40)*0x8000)+0x8000]
	if len(lo_bank) == 0:
		lo_bank = bytes([0xff] * 0x8000)
	if len(hi_bank) == 0:
		hi_bank = bytes([0xff] * 0x8000)
		
	fo.write(lo_bank)
	fo.write(hi_bank)

f.close()
fo.close()