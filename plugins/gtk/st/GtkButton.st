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

!GtkButton class methodsFor: 'instance creation'!

primNew
    <cCall: 'Gtk_gtk_button_new' plugin: 'gtk'>
	self primitiveFailed
!

primNewWithLabel: aString
    <cCall: 'Gtk_gtk_button_new_with_label' plugin: 'gtk'>
	self primitiveFailed
!

primNewWithMnemonic: aString
    <cCall: 'Gtk_gtk_button_new_with_mnemonic' plugin: 'gtk'>
	self primitiveFailed
!

primNewFromStock: stockId
    <cCall: 'Gtk_gtk_button_new_from_stock' plugin: 'gtk'>
	self primitiveFailed
!

new
    ^self handle: self primNew
!

withLabel: aString
    ^self handle: (self primNewWithLabel: aString)
!

withMnemonic: aString
    ^self handle: (self primNewWithMnemonic: aString)
!

fromStock: stockId
    ^self handle: (self primNewFromStock: stockId)
! !

!GtkButton methodsFor: 'primitives'!

pressed
    <cCall: 'Gtk_gtk_button_pressed' plugin: 'gtk'>
	self primitiveFailed
!

released
    <cCall: 'Gtk_gtk_button_released' plugin: 'gtk'>
	self primitiveFailed
!

clicked
    <cCall: 'Gtk_gtk_button_clicked' plugin: 'gtk'>
	self primitiveFailed
!

enter
    <cCall: 'Gtk_gtk_button_enter' plugin: 'gtk'>
	self primitiveFailed
!

leave
    <cCall: 'Gtk_gtk_button_leave' plugin: 'gtk'>
	self primitiveFailed
!

relief: newStyle
    <cCall: 'Gtk_gtk_button_set_relief' plugin: 'gtk'>
	self primitiveFailed
!

label
    <cCall: 'Gtk_gtk_button_get_label' plugin: 'gtk'>
	self primitiveFailed
!

label: aString
    <cCall: 'Gtk_gtk_button_set_label' plugin: 'gtk'>
	self primitiveFailed
!

useStock
    <cCall: 'Gtk_gtk_button_get_use_stock' plugin: 'gtk'>
	self primitiveFailed
!

useStock: aBoolean
    <cCall: 'Gtk_gtk_button_set_use_stock' plugin: 'gtk'>
	self primitiveFailed
!

useUnderline
    <cCall: 'Gtk_gtk_button_get_use_underline' plugin: 'gtk'>
	self primitiveFailed
!

useUnderline: aBoolean
    <cCall: 'Gtk_gtk_button_set_use_underline' plugin: 'gtk'>
	self primitiveFailed
!

focusOnClick: aBoolean
    <cCall: 'Gtk_gtk_button_set_focus_on_click' plugin: 'gtk'>
	self primitiveFailed
!

focusOnClick
    <cCall: 'Gtk_gtk_button_get_focus_on_click' plugin: 'gtk'>
	self primitiveFailed
!

primAlignment: xalign yalign: yalign
    <cCall: 'Gtk_gtk_button_set_alignment' plugin: 'gtk'>
	self primitiveFailed
!

alignment: aPoint
    self primAlignment: aPoint x yalign: aPoint y
!

primAlignment
    <cCall: 'Gtk_gtk_button_set_use_underline' plugin: 'gtk'>
	self primitiveFailed
!

alignment
    | alignment |
    alignment := self primAlignment.
    ^alignment second @ alignment third
!

image: aWidget
    <cCall: 'Gtk_gtk_button_set_image' plugin: 'gtk'>
	self primitiveFailed
!

image
    <cCall: 'Gtk_gtk_button_get_image' plugin: 'gtk'>
	self primitiveFailed
!

imagePosition: positionType
    <cCall: 'Gtk_gtk_button_set_image_position' plugin: 'gtk'>
	self primitiveFailed
!

imagePosition
    <cCall: 'Gtk_gtk_button_get_image_position' plugin: 'gtk'>
	self primitiveFailed
! !
