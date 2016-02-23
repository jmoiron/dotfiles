#!/usr/bin/env python

"""These colour files are brilliant but they are missing CursorLine,
Pmenu, PmenuSel, and some other things which _just_ throws them off
a little.  This script adds them all to the file based on what's can
be gleaned by a very simplistic parser."""

import argparse

parser = argparse.ArgumentParser(description="add highlight extensions to daylerees vim colour files")
parser.add_argument("files", type=str, nargs="+")
parser.add_argument("--always", action="store_true", help="always apply styling (overwriting existing)")
args = parser.parse_args()

def try_lighten(colour):
    """Try to lighten a bg color (for CursorLine or PmenuSel)"""
    colour = colour.strip().strip("#")
    if colour == "ffffff":
        return "#efefef"
    if colour == "000000":
        return "#111111"
    triplet = colour[:2], colour[2:4], colour[4:]
    intlet = map(lambda x: int(x, 16), triplet)
    # bg colors tend to be quite light or quite dark
    # the worst case is we add the bgcolor, which isn't bad
    if all([x < 0xa0 for x in intlet]):
        intlet = [x + 0x10 for x in intlet]
    elif all([x > 0xa0 for x in intlet]):
        intlet = [x - 0x10 for x in intlet]
    return "#%02x%02x%02x" % tuple(intlet)

def try_darken(colour):
    """Try to darken a bg color (for Pmenu)"""
    colour = colour.strip().strip("#")
    if colour == "ffffff":
        return "#efefef"
    if colour == "000000":
        return "#111111"
    triplet = colour[:2], colour[2:4], colour[4:]
    intlet = map(lambda x: int(x, 16), triplet)

    if all([x <= 0x10 for x in intlet]):
        intlet = [x + 0x10 for x in intlet]
    elif all([x > 0x10 for x in intlet]):
        intlet = [x - 0x10 for x in intlet]
    return "#%02x%02x%02x" % tuple(intlet)


def has_extensions(text):
    if args.always:
        return False
    return "CursorLine" in text and "Pmenu" in text and "PmenuSel" in text

for path in args.files:
    with open(path, "r") as f:
        content = f.read()
        if has_extensions(content):
            continue

    lines = content.split("\n")
    normline = [l for l in lines if "hi Normal" in l]
    if len(normline) != 1:
        print "Could not find 'hi Normal' line in %s.  Continuing" % path
        continue
    norm = normline[0]
    parts = norm.split()
    kv = {}
    for part in parts:
        kvs = part.split("=")
        if len(kvs) == 2:
            kv[kvs[0].lower()] = kvs[1].lower()

    if "guibg" not in kv:
        print "Could not determine guibg from %s.  Continuing" % path
        continue

    clcolour = try_lighten(kv["guibg"])
    pmenu = try_darken(kv["guibg"])

    with open(path, "w") as f:
        for line in lines:
            if "hi Normal" in line:
                f.write("hi CursorLine  guibg=%s\n" % clcolour)
                f.write("hi Pmenu       guibg=%s\n" % pmenu)
                f.write("hi PmenuSel    guibg=%s\n" % kv["guibg"])
            if "CursorLine" in line:
                continue
            if "Pmenu" in line:
                continue
            if "PmenuSel" in line:
                continue
            f.write(line)
            f.write("\n")

    print "%s => %s" % (kv["guibg"], clcolour)

