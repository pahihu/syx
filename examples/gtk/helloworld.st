#!/usr/bin/env syx
(Smalltalk loadPlugin: 'gtk')
    ifFalse: [ self error: 'Gtk+ plugin was not found' ]!

| window label |
label := GtkLabel new: 'Hello world'.
window := GtkWindow new.
window add: label; showAll.
window when: 'destroy' do: [ 'Quitting.' displayNl. Gtk mainQuit ].
Gtk main!