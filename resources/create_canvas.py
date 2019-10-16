#!/usr/bin/env python
from argparse import ArgumentParser

def create_canvas(name, fill):
    with open(name, 'wb') as file:
        file.write(bytes([fill]*0x600000))

if __name__ == '__main__':
    p = ArgumentParser(description='prepare empty rom files for inter-diff')
    p.add_argument('black', help='black ($00) output file path')
    p.add_argument('white', help='white ($FF) output file path')

    args = p.parse_args()

    create_canvas(args.black, 0x00)
    create_canvas(args.white, 0xFF)
