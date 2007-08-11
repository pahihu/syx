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

!GtkAdjustment class methodsFor: 'instance creation'!

new
    self shouldNotImplement
!

primNew: value min: min max: max step: step pageIncrement: pageIncrement pageSize: pageSize
    <cCall: 'Gtk_gtk_adjustment_new' plugin: 'gtk'>
	self primitiveFailed
!

new: initialValue interval: anInterval pageIncrement: pageIncrement pageSize: pageSize
    ^self handle: (self primNew: initialValue min: anInterval start max: anInterval stop step: anInterval step pageIncrement: pageIncrement pageSize: pageSize)
! !

!GtkAdjustment methodsFor: 'primitives'!

value
    <cCall: 'Gtk_gtk_adjustment_get_value' plugin: 'gtk'>
	self primitiveFailed
!

value: aFloat
    <cCall: 'Gtk_gtk_adjustment_set_value' plugin: 'gtk'>
	self primitiveFailed
!

primClampPageLow: low high: high
    <cCall: 'Gtk_gtk_adjustment_clamp_page' plugin: 'gtk'>
	self primitiveFailed
!

clampPage: anInterval
    self primClampPageLow: anInterval start high: anInterval stop
!

changed
    <cCall: 'Gtk_gtk_adjustment_changed' plugin: 'gtk'>
	self primitiveFailed
!

valueChanged
    <cCall: 'Gtk_gtk_adjustment_value_changed' plugin: 'gtk'>
	self primitiveFailed
! !

