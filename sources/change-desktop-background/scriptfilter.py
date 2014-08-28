#!/usr/bin/env python
# vim: ts=4:sw=4:sts=4:tw=120:expandtab:fileencoding=utf-8

"""
 Package       :  scriptfilter
 Author(s)     :  Daniel Kriesten
 Email         :  daniel.kriesten@etit.tu-chemnitz.de
 Creation Date :  Do 28 Aug 21:23:25 2014
"""

import sys
import find_bg_images as fbg

__BG_BASEDIR__ = fbg.__BG_BASEDIR__
__THE_FILTER__ = "{query}"

if __name__ == "__main__":
    __retval__ = fbg.find_files(__BG_BASEDIR__.replace(" ", r"\ "), __THE_FILTER__)
    if __retval__ != None:
        sys.stdout.write(__retval__)
