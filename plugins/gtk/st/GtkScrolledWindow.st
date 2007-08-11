"
Copyright (c) 2007 Luca Bruno

This file is part of Smalltalk YX.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the 'Software'), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.
"

!GtkScrolledWindow class methodsFor: 'instance creation'!

primNewHadjustment: hadjustment vadjustment: vadjustment
    <cCall: 'Gtk_gtk_scrolled_window_new' plugin: 'gtk'>
	self primitiveFailed
!

hadjustment: aGtkAdjustment vadjustment: aGtkVadjustment
    ^self handle: (self primNewHadjustment: aGtkAdjustment vadjustment: aGtkVadjustment)
!

new
    ^self hadjustment: nil vadjustment: nil
! !

!GtkScrolledWindow methodsFor: 'primitives'!

hadjustment
    <cCall: 'Gtk_gtk_scrolled_window_get_hadjustment' plugin: 'gtk'>
	self primitiveFailed
!

vadjustment
    <cCall: 'Gtk_gtk_scrolled_window_get_vadjustment' plugin: 'gtk'>
	self primitiveFailed
!

hscrollbar
    <cCall: 'Gtk_gtk_scrolled_window_get_hscrollbar' plugin: 'gtk'>
	self primitiveFailed
!

vscrollbar
    <cCall: 'Gtk_gtk_scrolled_window_get_vscrollbar' plugin: 'gtk'>
	self primitiveFailed
!

hscrollbarPolicy: hpolicy vscrollbarPolicy: vpolicy
    <cCall: 'Gtk_gtk_scrolled_window_set_policy' plugin: 'gtk'>
	self primitiveFailed
!

addWithViewport: aWidget
    <cCall: 'Gtk_gtk_scrolled_window_add_with_viewport' plugin: 'gtk'>
	self primitiveFailed
!

placement: cornerType
    <cCall: 'Gtk_gtk_scrolled_window_set_placement' plugin: 'gtk'>
	self primitiveFailed
!

unsetPlacement
    <cCall: 'Gtk_gtk_scrolled_window_unset_placement' plugin: 'gtk'>
	self primitiveFailed
!

shadowType: shadowType
    <cCall: 'Gtk_gtk_scrolled_window_set_shadow_type' plugin: 'gtk'>
	self primitiveFailed
!

hadjustment: anAdjustment
    <cCall: 'Gtk_gtk_scrolled_window_set_hadjustment' plugin: 'gtk'>
	self primitiveFailed
!

vadjustment: anAdjustment
    <cCall: 'Gtk_gtk_scrolled_window_set_vadjustment' plugin: 'gtk'>
	self primitiveFailed
!

placement
    <cCall: 'Gtk_gtk_scrolled_window_get_placement' plugin: 'gtk'>
	self primitiveFailed
!

primPolicy: hpolicy vpolicy: vpolicy
    <cCall: 'Gtk_gtk_scrolled_window_get_policy' plugin: 'gtk'>
	self primitiveFailed
!

policy
    | res |
    res := self primPlacement: 0 vpolicy: 0.
    ^res copyFrom: 2
!

shadowType
    <cCall: 'Gtk_gtk_scrolled_window_get_shadow_type' plugin: 'gtk'>
	self primitiveFailed
! !
