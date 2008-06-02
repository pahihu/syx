#!/bin/sh

swig -syx -noinit Xlib.i
ruby x11gen.rb Xlib_wrap.c Xlib.i > st/Xlib.st