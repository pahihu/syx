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

!GtkLabel class methodsFor: 'instance creation'!

primNew: aString
    <cCall: 'Gtk_gtk_label_new' plugin: 'gtk'>
	self primitiveFailed
!

primNewWithMnemonic: aString
    <cCall: 'Gtk_gtk_label_new_with_mnemonic' plugin: 'gtk'>
	self primitiveFailed
!

new
    ^self shouldNotImplement
!

new: aString
    ^self handle: (self primNew: aString)
!

newWithMnemonic: aString
    ^self handle: (self primNewWithMnemonic: aString)
! !

!GtkLabel methodsFor: 'gtk'!

text: aString
    <cCall: 'Gtk_gtk_label_set_text' plugin: 'gtk'>
	self primitiveFailed
!

attributes: pangoAttrList
    <cCall: 'Gtk_gtk_label_set_attributes' plugin: 'gtk'>
	self primitiveFailed
!

markup: aString
    <cCall: 'Gtk_gtk_label_set_markup' plugin: 'gtk'>
	self primitiveFailed
!

markupWithMnemonic: aString
    <cCall: 'Gtk_gtk_label_set_markup_with_mnemonic' plugin: 'gtk'>
	self primitiveFailed
!

pattern: aString
    <cCall: 'Gtk_gtk_label_set_pattern' plugin: 'gtk'>
	self primitiveFailed
!

justify: gtkJustification
    <cCall: 'Gtk_gtk_label_set_justify' plugin: 'gtk'>
	self primitiveFailed
!

ellipsize: pangoEllipsizeMode
    <cCall: 'Gtk_gtk_label_set_ellipsize' plugin: 'gtk'>
	self primitiveFailed
!

widthChars: nChars
    <cCall: 'Gtk_gtk_label_set_width_chars' plugin: 'gtk'>
	self primitiveFailed
!

maxWidthChars: nChars
    <cCall: 'Gtk_gtk_label_set_max_width_chars' plugin: 'gtk'>
	self primitiveFailed
!

parseUline: aString
    <cCall: 'Gtk_gtk_label_parse_uline' plugin: 'gtk'>
	self primitiveFailed
!

lineWrap: aBoolean
    <cCall: 'Gtk_gtk_label_set_line_wrap' plugin: 'gtk'>
	self primitiveFailed
!

lineWrapMode: pangoWrapMode
    <cCall: 'Gtk_gtk_label_set_line_wrap_mode' plugin: 'gtk'>
	self primitiveFailed
!

primLayoutOffsets: start to: stop
    <cCall: 'Gtk_gtk_label_get_layout_offsets' plugin: 'gtk'>
	self primitiveFailed
!

layoutOffsets
    | offsets |
    offsets := self primLayoutOffsets: 0 to: 0.
    ^offsets second to: offsets third
!

mnemonicKeyval
    <cCall: 'Gtk_gtk_label_get_mnemonic_keyval' plugin: 'gtk'>
	self primitiveFailed
!

selectable
    <cCall: 'Gtk_gtk_label_get_selectable' plugin: 'gtk'>
	self primitiveFailed
!

text
    <cCall: 'Gtk_gtk_label_get_text' plugin: 'gtk'>
	self primitiveFailed
!

selectRegionFrom: startOffset to: stopOffset
    <cCall: 'Gtk_gtk_label_select_region' plugin: 'gtk'>
	self primitiveFailed
!

mnemonicWidget: aWidget
    <cCall: 'Gtk_gtk_label_set_mnemonic_widget' plugin: 'gtk'>
	self primitiveFailed
!

selectable: aBoolean
    <cCall: 'Gtk_gtk_label_set_selectable' plugin: 'gtk'>
	self primitiveFailed
!

textWithMnemonic: aString
    <cCall: 'Gtk_gtk_label_set_text_with_mnemonic' plugin: 'gtk'>
	self primitiveFailed
!

attributes
    <cCall: 'Gtk_gtk_label_get_attributes' plugin: 'gtk'>
	self primitiveFailed
!

justify
    <cCall: 'Gtk_gtk_label_get_justify' plugin: 'gtk'>
	self primitiveFailed
!

ellipsize
    <cCall: 'Gtk_gtk_label_get_ellipsize' plugin: 'gtk'>
	self primitiveFailed
!

widthChars
    <cCall: 'Gtk_gtk_label_get_width_chars' plugin: 'gtk'>
	self primitiveFailed
!

maxWidthChars
    <cCall: 'Gtk_gtk_label_get_max_width_chars' plugin: 'gtk'>
	self primitiveFailed
!

label
    <cCall: 'Gtk_gtk_label_get_label' plugin: 'gtk'>
	self primitiveFailed
!

layout
    <cCall: 'Gtk_gtk_label_get_layout' plugin: 'gtk'>
	self primitiveFailed
!

lineWrap
    <cCall: 'Gtk_gtk_label_get_line_wrap' plugin: 'gtk'>
	self primitiveFailed
!

lineWrapMode
    <cCall: 'Gtk_gtk_label_get_line_wrap_mode' plugin: 'gtk'>
	self primitiveFailed
!

mnemonicWidget
    <cCall: 'Gtk_gtk_label_get_mnemonic_widget' plugin: 'gtk'>
	self primitiveFailed
!

selectionBounds
    <cCall: 'Gtk_gtk_label_get_selection_bounds' plugin: 'gtk'>
	self primitiveFailed
!

useMarkup
    <cCall: 'Gtk_gtk_label_get_use_markup' plugin: 'gtk'>
	self primitiveFailed
!

useUnderline
    <cCall: 'Gtk_gtk_label_get_use_underline' plugin: 'gtk'>
	self primitiveFailed
!

singleLineMode
    <cCall: 'Gtk_gtk_label_get_single_line_mode' plugin: 'gtk'>
	self primitiveFailed
!

angle
    <cCall: 'Gtk_gtk_label_get_angle' plugin: 'gtk'>
	self primitiveFailed
!

label: aString
    <cCall: 'Gtk_gtk_label_set_label' plugin: 'gtk'>
	self primitiveFailed
!

useMarkup: aBoolean
    <cCall: 'Gtk_gtk_label_set_use_markup' plugin: 'gtk'>
	self primitiveFailed
!

useUnderline: aBoolean
    <cCall: 'Gtk_gtk_label_set_use_underline' plugin: 'gtk'>
	self primitiveFailed
!

singleLineMode: aBoolean
    <cCall: 'Gtk_gtk_label_set_single_line_mode' plugin: 'gtk'>
	self primitiveFailed
!

angle: aFloat
    <cCall: 'Gtk_gtk_label_set_angle' plugin: 'gtk'>
	self primitiveFailed
! !
