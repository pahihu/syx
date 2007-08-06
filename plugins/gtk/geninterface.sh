#!/bin/sh
swig -syx -noinit -cpperraswarn `pkg-config glib-2.0 gtk+-2.0 --cflags` gtk.i