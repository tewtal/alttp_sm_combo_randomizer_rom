#!/usr/bin/env python
from collections.abc import MutableSequence
from collections import defaultdict
from itertools import chain, product
from enum import Enum
from os import path
import struct
import json

root = path.dirname(path.realpath(__file__))

def main():
    data = read_json('main_dma_layout.json')
    data = { entry['.']: entry for entry in data }

    dma_allocation = main_dma_allocation(data)
    usage, usage_by_animation = main_dma_pose_usage(data)

    prim_table, sec_upper_table, sec_lower_table, sec_upper_cache, sec_lower_cache = main_dma_data_tables(data, dma_allocation)
    write_binary_asset('_main_dma_prim_table.bin', prim_table)
    write_binary_asset('_main_dma_sec_upper_table.bin', sec_upper_table)
    write_binary_asset('_main_dma_sec_lower_table.bin', sec_lower_table)

    prim_table, sec_table = main_dma_afp_tables(usage, usage_by_animation, sec_upper_cache, sec_lower_cache)
    write_binary_asset('_main_dma_afp_prim_table.bin', prim_table)
    for addr, block in zip(['DB48', 'B800'], sec_table):
        write_binary_asset(f'_main_dma_afp_sec_table_{addr}.bin', block)

    prim_upper_table, prim_lower_table, sec_table, tilemaps = main_dma_tilemap_tables(data, usage, usage_by_animation)
    for index, block in prim_upper_table.items():
        write_binary_asset(f'_main_dma_tilemap_prim_upper_table_at_{index:02X}.bin', block)
    for index, block in prim_lower_table.items():
        write_binary_asset(f'_main_dma_tilemap_prim_lower_table_at_{index:02X}.bin', block)
    for addr, block in zip(['8091', '83C1', '83E7', '8A0D'], sec_table):
        write_binary_asset(f'_main_dma_tilemap_sec_table_{addr}.bin', block)
    write_binary_asset('_main_dma_tilemaps.bin', tilemaps)

    prim_table, sec_table = death_dma_tilemap_tables()
    write_binary_asset('_death_dma_prim_table.bin', prim_table)
    write_binary_asset('_death_dma_sec_table.bin', sec_table)

def read_json(filename):
    with open(path.join(root, filename), 'r') as f:
        return json.load(f)

def write_binary_asset(filename, binary):
    with open(path.join(root, '..', filename), 'bw') as f:
        f.write(binary)

def main_dma_allocation(data):
    freespace = FreeSpace([(bank*0x10000,bank*0x10000+0x8000) for bank in chain(range(0x44,0x4C),range(0x54,0x5A))])

    allocation = {}
    for name, entry in data.items():
        dimension = access(data, name, 'd')
        dimensions = access(data, name, 'd+')
        dimensions = [dimension]+(dimensions or [])
        size = sum([(x1-x0)*(y1-y0)//8**2 for x0, y0, x1, y1 in dimensions]) * 0x20

        _, address = freespace.allocate(size)
        allocation[name] = (address, size)

    return allocation

def main_dma_pose_usage(data):
    usage = defaultdict(list)
    # sort according to the ordinal
    for name, entry in sorted(data.items(), key=lambda x: access(data, x[1]['.'], 'o')):
        for animation, pose in entry['u']:
            # strip $ and convert hex to integer
            usage[(int(animation[1:], 16), pose)].append(name)

    # group pose numbers by animation numbers
    usage_by_animation = groupby(usage.keys(), lambda x: x[0], lambda x: x[1])

    return usage, usage_by_animation

def main_dma_data_tables(data, dma_allocation):
    """Construct DMA data tables

    Returns:
        prim_table $92:D91E dw ...
        sec_upper_table $92:C580 dl dw dw ...
        sec_lower_table $92:D600 dl dw dw ...
        sec_[upper/lower]_lookup name -> (n, i)
    """

    # With more gfx, taking 7 bytes each for a total of $116B bytes (vs $BE5
    # previously), some space from the death tilemaps ($92:C580-CBED) will be
    # used since those tilemaps will also change later.
    # Keeping the upper primary table "paged" is a failsafe against vanilla
    # glitches, while the lower primary table is simplified.

    upper_addr = 0x92C580
    lower_addr = 0x92D600
    table_end = 0x92D7D2

    freespace_upper = FreeSpace([(upper_addr,lower_addr)])
    freespace_lower = FreeSpace([(lower_addr,table_end)])

    prim_table = [dw(upper_addr)]*13 + [dw(lower_addr)]*11
    sec_upper_table = bytearray()
    sec_lower_table = bytearray()
    sec_upper_cache = {}
    sec_lower_cache = {}

    upper_entry = (0, 0)
    lower_entry = (0, 0)
    for name, (dma_address, size) in dma_allocation.items():
        # half of the tiles, floored (the same way the gfx is constructed)
        size_bottom_row = 0x20*(size//0x40)
        size_top_row = size - size_bottom_row
        dma_entry = dl(dma_address)+dw(size_top_row)+dw(size_bottom_row)

        if access(data, name, 'lower') == True:
            _, address = freespace_lower.allocate(7)
            _, index = lower_entry

            sec_lower_table += dma_entry
            sec_lower_cache[name] = lower_entry

            lower_entry = (0, index+1)

        else:
            _, address = freespace_upper.allocate(7)
            number, index = upper_entry
            # overflow to a new table past $30 entries (which is choosen fairly arbitrary)
            if index > 0x30:
                number += 1
                index = 0
                if number >= 13:
                    raise AssertionError('DMA data primary table overflow from upper into lower part')
                prim_table[number] = dw(address)

            sec_upper_table += dma_entry
            sec_upper_cache[name] = (number, index)

            upper_entry = (number, index+1)

    # Null data. Most poses will lack a lower section. The last iterated gfx
    # (dma_address) is used, but with a load size of 1 (DONT! use zero since it
    # tries to load an entire bank).
    dma_entry = dl(dma_address)+dw(1)+dw(1)

    freespace_upper.allocate(7)
    sec_upper_table += dma_entry
    sec_upper_cache['null'] = upper_entry

    freespace_lower.allocate(7)
    sec_lower_table += dma_entry
    sec_lower_cache['null'] = lower_entry

    prim_table = bytes().join(prim_table)
    return prim_table, sec_upper_table, sec_lower_table, sec_upper_cache, sec_lower_cache

def main_dma_afp_tables(usage, usage_by_animation, dma_sec_upper_cache, dma_sec_lower_cache):
    """Construct 'Animation Frame Progression' tables

    Returns:
        prim_table $92:D94E dw ...
        sec_table db db db db ...
            $92:[DB48-ED24)
            $92:[B800-C500)
    """

    # While populating these tables with new data an area related to loading
    # from save points, and fanfares, at $92:ED24-EDF3 needs to be avoided.

    freespace_sec_table = FreeSpace([(0x92DB48,0x92ED24),(0x92B800,0x92C500)])

    overflow_length = 0x40
    total_animations = 0xFD

    # As a failsafe against overflow, start with a null list long enough for
    # the largest possible overflow
    _, address = freespace_sec_table.allocate(4*overflow_length)
    prim_table = [dw(address)]*total_animations
    null_upper_entry = dma_sec_upper_cache['null']
    null_lower_entry = dma_sec_lower_cache['null']
    sec_table = [[(null_upper_entry + null_lower_entry)]*overflow_length]

    for animation, poses in usage_by_animation.items():
        # exclusive end bound
        bound = max(poses)+1

        new, address = freespace_sec_table.allocate(4*bound)
        append_new_tables(sec_table, new)
        prim_table[animation] = dw(address)

        for pose in range(bound):
            upper_entry = null_upper_entry
            lower_entry = null_lower_entry
            if pose in poses:
                for name in usage[(animation,pose)]:
                    if name in dma_sec_upper_cache:
                        upper_entry = dma_sec_upper_cache[name]
                    elif name in dma_sec_lower_cache:
                        lower_entry = dma_sec_lower_cache[name]
            sec_table[-1].append(upper_entry+lower_entry)

    prim_table = bytes().join(prim_table)
    sec_table = [bytes().join(db(b) for entry in block for b in entry) for block in sec_table]
    return prim_table, sec_table

def main_dma_tilemap_tables(data, usage, usage_by_animation):
    """Construct DMA tilemap tables

    Returns:
        prim_upper_table $92:9263
        prim_lower_table $92:945D
            (dword index: dw ...,) ...
        sec_table dw ...
            $92:[8091,8390)
            $92:[83C1,83E4)
            $92:[83E7,8A04)
            $92:[8A0D,90C4)
        tilemaps $92:[9663-B000) dw (dw db dw)* ...
    """

    # Missing tilemaps stalls the game, so using $0000 is avoided.
    # The secondary table contains "TM pointers". The TM_006 pointers are
    # navigated around since its auxiliary uses in-game are not clear.
    # The space after $92B000 is reserved for death dma tilemaps.

    sec_table_origin_address = 0x92808D
    freespace_sec_table = FreeSpace([(0x928091,0x928390),(0x9283C1,0x9283E4),(0x9283E7,0x928A04),(0x928A0D,0x9290C4)])
    freespace_tilemap = FreeSpace([(0x929663,0x92B000)])

    prim_upper_table = []
    prim_lower_table = []
    sec_table = [bytearray()]
    tilemaps = bytearray()

    # Null tilemap, made up zero tilemap entries.
    _, null_tilemap_address = freespace_tilemap.allocate(2)
    tilemaps += dw(0)

    # Secondary table null entries to use when lower is not forced
    max_poses = 96
    _, null_sec_table_address = freespace_sec_table.allocate(2*max_poses)
    sec_table[-1] += dw(null_tilemap_address)*max_poses

    tilemap_address_cache = {}
    for animation, poses in usage_by_animation.items():
        # exclusive end bound
        bound = max(poses)+1

        need_lower_tilemaps = any([access(data, name, 'lower') for pose in range(bound) if pose in poses for name in usage[animation, pose]])

        new_upper, upper_sec_table_address = freespace_sec_table.allocate(2*bound)
        prim_upper_table.append((animation, dw((upper_sec_table_address-sec_table_origin_address)//2)))
        new_lower, lower_sec_table_address = freespace_sec_table.allocate(2*bound) if need_lower_tilemaps else (0, null_sec_table_address)
        prim_lower_table.append((animation, dw((lower_sec_table_address-sec_table_origin_address)//2)))

        sec_upper_table = []
        sec_lower_table = [] if need_lower_tilemaps else null_list()
        for pose in range(bound):
            upper_tilemap_address = null_tilemap_address
            lower_tilemap_address = null_tilemap_address

            if pose in poses:
                # in the case of two names, one of them will be forced lower
                for name in usage[(animation,pose)]:
                    force_lower = access(data, name, 'lower')
                    tilemap = compile_tilemap(
                        access(data, name, 'd'),
                        access(data, name, 'd+'),
                        access(data, name, 'pal'),
                        force_lower)

                    # have to make the whole bubble out of one quadrant
                    if name.startswith('crystal_bubble'):
                        tilemap = quadrate_crystal_bubble(tilemap)
                    # need to 180 rotate these grapple poses to appear as they did in vanilla for upside-down poses
                    if animation == 0xB2 and pose in chain(range(0,9),range(25,41),range(57,64)): # 0-8, 25-40, 57-63
                        tilemap = rotate_tilemap(tilemap)
                    if animation == 0xB3 and pose in chain(range(0,8),range(24,40),range(56,64)): # 0-7, 24-39, 56-63
                        tilemap = rotate_tilemap(tilemap)

                    tilemap_entry = tuple(tilemap)
                    tilemap_address = tilemap_address_cache.get(tilemap_entry)

                    if tilemap_address is None:
                        _, tilemap_address = freespace_tilemap.allocate(2+len(tilemap))
                        tilemap_address_cache[tilemap_entry] = tilemap_address
                        tilemaps += dw(len(tilemap)//5)
                        tilemaps += tilemap

                    if force_lower:
                        lower_tilemap_address = tilemap_address
                    else:
                        upper_tilemap_address = tilemap_address

            sec_upper_table.append(dw(upper_tilemap_address))
            sec_lower_table.append(dw(lower_tilemap_address))

        append_new_tables(sec_table, new_upper, tabletype=bytearray)
        sec_table[-1] += bytes().join(sec_upper_table)
        append_new_tables(sec_table, new_lower, tabletype=bytearray)
        sec_table[-1] += bytes().join(sec_lower_table)

    prim_upper_table = consecutive_animations(prim_upper_table)
    prim_lower_table = consecutive_animations(prim_lower_table)

    return prim_upper_table, prim_lower_table, sec_table, tilemaps

def consecutive_animations(table):
    """Group the primary table into blocks of consecutive animation numbers"""

    by_animation = lambda x: x[0]
    consecutive_numbers = lambda n, p: n[0] == p[0]+1

    table = sorted(table, key=by_animation)
    table = clusterby(table, consecutive_numbers)
    # key by the initial animation number of each block
    return { block[0][0]: bytes().join(addr for _, addr in block) for block in table }

def compile_tilemap(dimension, dimensions, palette, force_lower):
    # strip $ and convert hex to integer. 0x28 is the default of the normal Samus palette
    palette = int(palette[1:], 16) if palette else 0x28

    big_tiles = []
    small_tiles = []
    for bounding_box in chain([dimension], dimensions or []):
        x_min, y_min, x_max, y_max = bounding_box
        # chads, extra 8x8 tiles in the x or y directions
        x_chad = (x_max-x_min) % 16 > 0
        y_chad = (y_max-y_min) % 16 > 0
        for y in range(y_min, y_max-15, 16):
            for x in range(x_min, x_max-15, 16):
                big_tiles.append((x, y))
            if x_chad:
                small_tiles.append((x_max-8, y  ))
                small_tiles.append((x_max-8, y+8))
        if y_chad:
            for x in range(x_min, x_max-7, 8):
                small_tiles.append((x, y_max-8))

    tilemap = []
    index = 0x08 if force_lower else 0x00
    for x, y in big_tiles:
        flags = 0xC3 if x < 0 else 0xC2
        tilemap += [x, flags, y, index, palette]
        index += 0x02
    for x, y in small_tiles:
        flags = 0x01 if x < 0 else 0x00
        tilemap += [x, flags, y, index, palette]
        index += 0x10 if index//0x10 == 0 else -0x10 + 0x01

    return bytes().join(db(b) for b in tilemap)

def quadrate_crystal_bubble(tilemap):
    flag_x_sign = 0x01
    flag_h_flip = 0x40
    flag_v_flip = 0x80
    quad_tilemap = []
    for h_flip, v_flip in product([True, False], repeat=2):
        for i in range(0, len(tilemap), 5):
            x, size, y, tile, palette = tilemap[i:i+5]
            if h_flip:
                x = 0xF0 - x
                size ^= flag_x_sign
                palette ^= flag_h_flip
            if v_flip:
                y = 0xF0 - y
                palette ^= flag_v_flip
            if x < 0:
                x += 0x100
                size ^= flag_x_sign
            if y < 0:
                y += 0x100
            quad_tilemap += [x, size, y, tile, palette]

    return bytes().join(db(b) for b in quad_tilemap)

def rotate_tilemap(tilemap):
    flag_x_sign = 0x01
    rotated_tilemap = []
    for i in range(0, len(tilemap), 5):
        x, size, y, tile, palette = tilemap[i:i+5]
        flip_origin = 0xF8 if size & 0xC2 == 0 else 0xF0
        x = flip_origin - x
        y = flip_origin - y
        size ^= flag_x_sign
        palette ^= 0xC0
        if x < 0:
            x += 0x100
            size ^= flag_x_sign
        if y < 0:
            y += 0x100
        rotated_tilemap.extend([x, size, y, tile, palette])

    return bytes().join(db(b) for b in rotated_tilemap)

class Direction(Enum):
    left = 0
    right = 1

    def index(self, sequence):
        """Access a data sequence that store values in the order left, right"""
        return sequence[self.value]

def death_dma_tilemap_tables():
    """Construct death DMA tilemap tables

    Returns:
        prim_table dw{2}
            $92:EDDB (left)
            $92:EDD0 (right)
        table $92:B001-B800 (db? dw ... dw (dw db dw)* ...){2}
    """

    # Need to start on a dword aligned offset from the secondary table origin
    sec_table_origin_address = 0x92808D
    freespace = FreeSpace([(0x92B001,0x92B800)])

    prim_table = bytearray()
    sec_table = bytearray()

    for direction in Direction:
        # Since the tilemaps share space with the secondary table we need to
        # make sure the entries are dword aligned
        _, table_address = freespace.allocate(2*9)
        if (table_address-sec_table_origin_address) % 2 != 0:
            freespace.allocate(1)
            table_address += 1
            sec_table += db(0x00)

        prim_table += dw((table_address-sec_table_origin_address)//2)

        tilemaps = bytearray()
        for pose in range(9):
            tilemap = compile_death_tilemap(direction, pose)

            _, tilemap_address = freespace.allocate(2+len(tilemap))
            sec_table += dw(tilemap_address)

            tilemaps += dw(len(tilemap)//5)
            tilemaps += tilemap

        sec_table += tilemaps

    return prim_table, sec_table

def compile_death_tilemap(direction, pose):
    return compile_death_pieces_tilemap(direction, pose) + compile_death_body_tilemap(direction, pose)

def compile_death_pieces_tilemap(direction, pose):
    if pose not in range(1,6):
        return bytes()

    # Some tiles overlap. This is intended, and isn't a big problem for death poses
    if pose == 1:
        origin = (-9, -15), -25
        tiles = [
            (0,  0, 0xC2, 0x00),
            (0, 16, 0xC2, 0x20),
            (0, 32, 0xC2, 0x40),
            (8,  0, 0xC2, 0x01),
            (8, 16, 0xC2, 0x21),
            (8, 32, 0xC2, 0x41),
        ]
    elif pose == 2:
        origin = (-12, -20), -25
        tiles = [
            ( 0,  0, 0xC2, 0x03),
            ( 0, 16, 0xC2, 0x23),
            ( 0, 32, 0xC2, 0x43),
            (16,  0, 0xC2, 0x05),
            (16, 16, 0xC2, 0x25),
            (16, 32, 0xC2, 0x45),
        ]
    elif pose == 3:
        origin = (-18, -22), -35
        tiles = [
            ( 0,  0, 0xC2, 0xB7), # top
            ( 0, 16, 0xC2, 0xD7),
            (16,  0, 0xC2, 0xB9),
            (16, 16, 0xC2, 0xD9),
            (24,  0, 0xC2, 0xBA),
            (24, 16, 0xC2, 0xDA),
            ( 0, 32, 0xC2, 0xBC), # left bottom
            ( 0, 48, 0xC2, 0xDC),
            (16, 32, 0xC2, 0xBE),
            (16, 48, 0xC2, 0xDE),
            (32, 32, 0x00, 0xF7), # right bottom pieces
            (32, 40, 0x00, 0xF8),
            (32, 48, 0x00, 0xF9),
            (32, 56, 0x00, 0xFA),
        ]
    elif pose == 4:
        origin = (-26, -30), -42
        tiles = [
            ( 0,  0, 0xC2, 0x60),
            ( 0, 16, 0xC2, 0x80),
            ( 0, 32, 0xC2, 0xA0),
            ( 0, 48, 0xC2, 0xC0),
            ( 0, 64, 0xC2, 0xE0),
            (16,  0, 0xC2, 0x62),
            (16, 16, 0xC2, 0x82),
            (16, 32, 0xC2, 0xA2),
            (16, 48, 0xC2, 0xC2),
            (16, 64, 0xC2, 0xE2),
            (32,  0, 0xC2, 0x64),
            (32, 16, 0xC2, 0x84),
            (32, 32, 0xC2, 0xA4),
            (32, 48, 0xC2, 0xC4),
            (32, 64, 0xC2, 0xE4),
            (40,  0, 0xC2, 0x65),
            (40, 16, 0xC2, 0x85),
            (40, 32, 0xC2, 0xA5),
            (40, 48, 0xC2, 0xC5),
            (40, 64, 0xC2, 0xE5),
        ]
    elif pose == 5:
        origin = (-36, -36), -45
        tiles = [
            ( 0,  0, 0xC2, 0x07),
            ( 0, 16, 0xC2, 0x27),
            ( 0, 32, 0xC2, 0x47),
            ( 0, 48, 0xC2, 0x67),
            ( 0, 64, 0xC2, 0x87),
            ( 0, 72, 0xC2, 0x97),
            (16,  0, 0xC2, 0x09),
            (16, 16, 0xC2, 0x29),
            (16, 32, 0xC2, 0x49),
            (16, 48, 0xC2, 0x69),
            (16, 64, 0xC2, 0x89),
            (16, 72, 0xC2, 0x99),
            (32,  0, 0xC2, 0x0B),
            (32, 16, 0xC2, 0x2B),
            (32, 32, 0xC2, 0x4B),
            (32, 48, 0xC2, 0x6B),
            (32, 64, 0xC2, 0x8B),
            (32, 72, 0xC2, 0x9B),
            (48,  0, 0xC2, 0x0D),
            (48, 16, 0xC2, 0x2D),
            (48, 32, 0xC2, 0x4D),
            (48, 48, 0xC2, 0x6D),
            (48, 64, 0xC2, 0x8D),
            (48, 72, 0xC2, 0x9D),
            (56,  0, 0xC2, 0x0E),
            (56, 16, 0xC2, 0x2E),
            (56, 32, 0xC2, 0x4E),
            (56, 48, 0xC2, 0x6E),
            (56, 64, 0xC2, 0x8E),
            (56, 72, 0xC2, 0x9E),
        ]

    flag_x_sign = 0x01
    x_min, y_min = origin
    x_min = direction.index(x_min)
    palette = 0x29 # normally 0x28, but the last bit here goes to the next VRAM page to grab tiles
    tilemaps = []
    for x, y, flags, index in tiles:
        if x < 0:
            flags |= flag_x_sign
        tilemaps += [x_min+x, flags, y_min+y, index, palette]

    return bytes().join(db(b) for b in tilemaps)

def compile_death_body_tilemap(direction, pose):
    flag_x_sign = 0x01
    x_min, y_min = (-12, -20), -32
    x_min = direction.index(x_min)
    y_min = -32
    offset = pose if pose <= 6 else pose-1
    palette = 0x2E if pose > 0 else 0x28
    tilemaps = []
    for i in range(2):
        for j in range(4):
            x = x_min + 16*i
            y = y_min + 16*j
            size = 0xC2
            index = 0x80*(offset//4) +  0x20*j + 4*(offset%4) + 2*i
            if x < 0:
                x += 0x100
                size |= flag_x_sign
            if y < 0:
                y += 0x100
            tilemaps += [x, size, y, index, palette]

    return bytes().join(db(b) for b in tilemaps)

class FreeSpace():
    def __init__(self, blocks):
        self.blocks = blocks
        self.block = 0
        self.index = 0

    def allocate(self, size):
        """Returns tuple of ("changed blocks", addr)"""

        new_blocks = 0
        while self.block < len(self.blocks):
            start, end = self.blocks[self.block]
            if start + self.index + size <= end:
                address = start + self.index
                self.index += size
                return new_blocks, address
            else:
                new_blocks += 1
                self.block += 1
                self.index = 0
        raise AssertionError('Ran out of space to allocate from')

def append_new_tables(tables, amount, *, tabletype=list):
    for _ in range(amount):
        tables.append(tabletype())

def access(data, name, key, *, visited=[]):
    if name in visited:
        raise AssertionError(f'Detected recursive loop {", ".join(visited + [name])}')

    if name in data:
        entry = data[name]
        if key in entry:
            return entry[key]
        elif '..' in entry:
            return access(data, entry['..'], key, visited=visited+[name])

    return None

class null_list(MutableSequence):
    """A null object that ignores any elements and just reports as an empty list"""
    def __setitem__(self,key,value): pass
    def __getitem__(self,key): raise IndexError()
    def __delitem__(self,key): pass
    def insert(self,i,x): pass
    def __len__(self): return 0
    def __repr__(self): return repr([])

def groupby(values, key, element=None):
    """Group by a key into a lookup rather than relying on prior sorting"""

    if element is None:
        element = lambda x: x

    groups = defaultdict(list)
    for value in values:
        groups[key(value)].append(element(value))
    return groups

def clusterby(values, criteria):
    """Cluster a list of values according to the boundary of the criteria

    criteria: lambda value, previous
        Return falsy to start a new cluster, otherwise the value stays with the
        current cluster.
    """

    acc = None
    for value in values:
        if acc and criteria(value, acc[-1]):
            acc.append(value)
            continue
        elif acc:
            yield acc
        acc = [value]
    if acc:
        yield acc

def db(value):
    return struct.pack('<B', value & 0xFF)

def dw(value):
    return struct.pack('<H', value & 0xFFFF)

def dl(value):
    return struct.pack('<L', value & 0xFFFFFF)[:3]

# Run the code if this file was invoked from the shell
if __name__ == '__main__':
    main()
