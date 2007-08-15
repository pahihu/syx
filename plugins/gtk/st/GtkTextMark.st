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

!GtkTextMark class methodsFor: 'instance creation'!

new
    self shouldNotImplement
! !

!GtkTextMark methodsFor: 'primitives'!

visible: aBoolean
    <cCall: 'Gtk_gtk_text_mark_set_visible' plugin: 'gtk'>
	self primitiveFailed
!

visible
    <cCall: 'Gtk_gtk_text_mark_get_visible' plugin: 'gtk'>
	self primitiveFailed
!

deleted
    <cCall: 'Gtk_gtk_text_mark_get_deleted' plugin: 'gtk'>
	self primitiveFailed
!

name
    <cCall: 'Gtk_gtk_text_mark_get_name' plugin: 'gtk'>
	self primitiveFailed
!

primBuffer
    <cCall: 'Gtk_gtk_text_mark_get_buffer' plugin: 'gtk'>
	self primitiveFailed
!

buffer
    ^GtkTextBuffer handle: self primBuffer
!

leftGravity
    <cCall: 'Gtk_gtk_text_mark_get_left_gravity' plugin: 'gtk'>
	self primitiveFailed
! !
