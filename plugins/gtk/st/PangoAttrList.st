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

!PangoAttrList class methodsFor: 'instance creation'!

primNew
    <cCall: 'Gtk_pango_attr_list_new' plugin: 'gtk'>
	self primitiveFailed
!

new
    ^self handle: self primNew
! !

!PangoAttrList methodsFor: 'primitives'!

primRef
    <cCall: 'Gtk_pango_attr_list_ref' plugin: 'gtk'>
	self primitiveFailed
!

ref
    handle := self primRef
!

unref
    <cCall: 'Gtk_pango_attr_list_unref' plugin: 'gtk'>
	self primitiveFailed
!

primCopy
    <cCall: 'Gtk_pango_attr_list_copy' plugin: 'gtk'>
	self primitiveFailed
!

copy
    ^PangoAttrList handle: self primCopy
!

insert: pangoAttribute
    <cCall: 'Gtk_pango_attr_list_insert' plugin: 'gtk'>
	self primitiveFailed
!

insertBefore: pangoAttribute
    <cCall: 'Gtk_pango_attr_list_insert_before' plugin: 'gtk'>
	self primitiveFailed
!

change: pangoAttribute
    <cCall: 'Gtk_pango_attr_list_change' plugin: 'gtk'>
	self primitiveFailed
!

splice: otherAttrList from: pos length: len
    <cCall: 'Gtk_pango_attr_list_splice' plugin: 'gtk'>
	self primitiveFailed
! !
