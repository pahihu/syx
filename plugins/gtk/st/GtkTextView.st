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

!GtkTextView class methodsFor: 'instance creation'!

primNew
    <cCall: 'Gtk_gtk_text_view_new' plugin: 'gtk'>
	self primitiveFailed
!

primBuffer: textBuffer
    <cCall: 'Gtk_gtk_text_view_new_with_buffer' plugin: 'gtk'>
	self primitiveFailed
!

new
    ^self handle: self primNew
!

buffer: textBuffer
    ^self handle: (self primBuffer: textBuffer)
! !

!GtkTextView methodsFor: 'primitives'!

buffer: textBuffer
    <cCall: 'Gtk_gtk_text_view_set_buffer' plugin: 'gtk'>
	self primitiveFailed
!

primBuffer
    <cCall: 'Gtk_gtk_text_view_get_buffer' plugin: 'gtk'>
	self primitiveFailed
!

buffer
    ^GtkTextBuffer handle: self primBuffer
!

scrollToMark: textMark withinMargin: floatMargin useAlign: aBoolean xalign: xalign yalign: yalign
    <cCall: 'Gtk_gtk_text_view_scroll_to_mark' plugin: 'gtk'>
	self primitiveFailed
!

scrollToIter: textIter withinMargin: floatMargin useAlign: aBoolean xalign: xalign yalign: yalign
    <cCall: 'Gtk_gtk_text_view_scroll_to_iter' plugin: 'gtk'>
	self primitiveFailed
!

scrollMarkOnscreen: textMark
    <cCall: 'Gtk_gtk_text_view_scroll_mark_onscreen' plugin: 'gtk'>
	self primitiveFailed
!

moveMarkOnscreen: textMark
    <cCall: 'Gtk_gtk_text_view_move_mark_onscreen' plugin: 'gtk'>
	self primitiveFailed
!

placeCursorOnscreen
    <cCall: 'Gtk_gtk_text_view_place_cursor_onscreen' plugin: 'gtk'>
	self primitiveFailed
!

primVisibleRect: rect
    <cCall: 'Gtk_gtk_text_view_get_visible_rect' plugin: 'gtk'>
	self primitiveFailed
!

visibleRect
    | rect |
    rect := GdkRectangle new.
    self primVisibleRect: rect.
    ^rect
!

primIter: iter location: location
    <cCall: 'Gtk_gtk_text_view_get_iter_location' plugin: 'gtk'>
	self primitiveFailed
!

iterLocation: textIter
    | loc |
    loc := GdkRectangle new.
    self primIter: textIter location: loc.
    ^loc
!

primLineAtY: y lineTop: unused
    <cCall: 'Gtk_gtk_text_view_get_line_at_y' plugin: 'gtk'>
	self primitiveFailed
!

lineAtY: y
    ^(self primLineAtY: y lineTop: 0) second
!

primLineYRange: iter y: y height: height
    <cCall: 'Gtk_gtk_text_view_get_line_yrange' plugin: 'gtk'>
	self primitiveFailed
!

lineYRange: textIter
    | ret |
    ret := self primLineYRange: textIter y: 0 height: 0.
    ^ret copyFrom: 2
!

primIterAtX: x y: y
    <cCall: 'Gtk_gtk_text_view_get_iter_at_location' plugin: 'gtk'>
	self primitiveFailed
!

iterAtLocation: aPoint
    | iter |
    iter := GtkTextIter new.
    self primIterAtX: aPoint x y: aPoint y.
    ^iter
!

primIterAtPosition: iter trailing: trailing x: x y: y
    <cCall: 'Gtk_gtk_text_view_get_iter_at_position' plugin: 'gtk'>
	self primitiveFailed
!


iterAtPosition: aPoint
    | res iter |
    iter := GtkTextIter new.
    res := self primIterAtPosition: iter trailing: 0 x: aPoint x y: aPoint y.
    ^{iter. res second}
!

primBufferToWindowCoords: win x: x y: y wx: wx wy: wy
    <cCall: 'Gtk_gtk_text_view_buffer_to_window_coords' plugin: 'gtk'>
	self primitiveFailed
!

bufferCoords: aPoint toWindowCoords: windowType
    | res |
    res := self primBufferToWindowCoords: windowType x: aPoint x y: aPoint y wx: 0 wy: 0.
    ^res second @ res third
!

primWindowToBufferCoords: win x: x y: y wx: wx wy: wy
    <cCall: 'Gtk_gtk_text_view_window_to_buffer_coords' plugin: 'gtk'>
	self primitiveFailed
!

windowCoords: aPoint toBufferCoords: windowType
    | res |
    res := self primWindowToBufferCoords: windowType x: aPoint x y: aPoint y wx: 0 wy: 0.
    ^res second @ res third
!

primWindow: textWindowType
    <cCall: 'Gtk_gtk_text_view_get_window' plugin: 'gtk'>
	self primitiveFailed
!

window: windowType
    ^GdkWindow handle: (self primWindow: windowType)
!

windowType: gdkWindow
    <cCall: 'Gtk_gtk_text_view_get_window_type' plugin: 'gtk'>
	self primitiveFailed
!

windowBorderSize: anInteger
    <cCall: 'Gtk_gtk_text_view_set_border_window_size' plugin: 'gtk'>
	self primitiveFailed
!

windowBorderSize
    <cCall: 'Gtk_gtk_text_view_get_border_window_size' plugin: 'gtk'>
	self primitiveFailed
!

forwardDisplayLine: textIter
    <cCall: 'Gtk_gtk_text_view_forward_display_line' plugin: 'gtk'>
	self primitiveFailed
!

backwardDisplayLine: textIter
    <cCall: 'Gtk_gtk_text_view_backward_display_line' plugin: 'gtk'>
	self primitiveFailed
!

forwardDisplayLineEnd: textIter
    <cCall: 'Gtk_gtk_text_view_forward_display_line_end' plugin: 'gtk'>
	self primitiveFailed
!

backwardDisplayLineStart: textIter
    <cCall: 'Gtk_gtk_text_view_backward_display_line_start' plugin: 'gtk'>
	self primitiveFailed
!

startsDisplayLine: textIter
    <cCall: 'Gtk_gtk_text_view_starts_display_line' plugin: 'gtk'>
	self primitiveFailed
!

moveVisually: textIter by: count
    <cCall: 'Gtk_gtk_text_view_move_visually' plugin: 'gtk'>
	self primitiveFailed
!

addChild: childWidget atAnchor: textChildAnchor
    <cCall: 'Gtk_gtk_text_view_add_child_at_anchor' plugin: 'gtk'>
	self primitiveFailed
! !
