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

!GtkBox class methodsFor: 'instance creation'!

new
    self subclassResponsibility
! !

!GtkBox methodsFor: 'primitives'!

packStart: childWidget expand: expand fill: fill padding: anInteger
    <cCall: 'Gtk_gtk_box_pack_start' plugin: 'gtk'>
	self primitiveFailed
!

packStart: childWidget
    <cCall: 'Gtk_gtk_box_pack_start_defaults' plugin: 'gtk'>
	self primitiveFailed
!

packEnd: childWidget expand: expand fill: fill padding: anInteger
    <cCall: 'Gtk_gtk_box_pack_end' plugin: 'gtk'>
	self primitiveFailed
!

packEnd: childWidget
    <cCall: 'Gtk_gtk_box_pack_end_defaults' plugin: 'gtk'>
	self primitiveFailed
!

homogeneous
    <cCall: 'Gtk_gtk_box_get_homogeneous' plugin: 'gtk'>
	self primitiveFailed
!

homogeneous: aBoolean
    <cCall: 'Gtk_gtk_box_set_homogeneous' plugin: 'gtk'>
	self primitiveFailed
!

spacing
    <cCall: 'Gtk_gtk_box_get_spacing' plugin: 'gtk'>
	self primitiveFailed
!

spacing: anInteger
    <cCall: 'Gtk_gtk_box_set_spacing' plugin: 'gtk'>
	self primitiveFailed
!

reorderChild: childWidget at: position
    <cCall: 'Gtk_gtk_box_reorder_child' plugin: 'gtk'>
	self primitiveFailed
!

primQueryChildPacking: childWidget expand: expand fill: fill padding: padding packType: packType
    <cCall: 'Gtk_gtk_box_query_child_packing' plugin: 'gtk'>
	self primitiveFailed
!

queryChildPacking: childWidget
    | res |
    res := self primQueryChildPacking: childWidget expand: 0 fill: 0 padding: 0 packType: 0.
    ^res copyFrom: 2
!

childPacking: childWidget expand: expand fill: fill padding: padding packType: packType
    <cCall: 'Gtk_gtk_box_set_child_packing' plugin: 'gtk'>
	self primitiveFailed
! !

!GtkVBox class methodsFor: 'instance creation'!

primHomogeneous: aBoolean spacing: anInteger
    <cCall: 'Gtk_gtk_vbox_new' plugin: 'gtk'>
	self primitiveFailed
!

homogeneous: aBoolean spacing: anInteger
    ^self handle: (self primHomogeneous: aBoolean spacing: anInteger)
!

homogeneous: aBoolean
    ^self homogeneous: aBoolean spacing: 3
!

spacing: anInteger
    ^self homogeneous: false
!

new
    ^self homogeneous: false spacing: 3
! !

!GtkHBox class methodsFor: 'instance creation'!

primHomogeneous: aBoolean spacing: anInteger
    <cCall: 'Gtk_gtk_hbox_new' plugin: 'gtk'>
	self primitiveFailed
!

homogeneous: aBoolean spacing: anInteger
    ^self handle: (self primHomogeneous: aBoolean spacing: anInteger)
!

homogeneous: aBoolean
    ^self homogeneous: aBoolean spacing: 3
!

spacing: anInteger
    ^self homogeneous: false
!

new
    ^self homogeneous: false spacing: 3
! !

