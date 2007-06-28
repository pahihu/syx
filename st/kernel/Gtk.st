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

!Gtk class methodsFor: 'main loop'!

main
    <cCall: 'Gtk_main' plugin: 'gtk'>
	self primitiveFailed
!

mainQuit
    <cCall: 'Gtk_mainQuit' plugin: 'gtk'>
	self primitiveFailed
! !

!GObject class methodsFor: 'instance creation'!

new
    self subclassResponsibility
!

handle: aPointer
    ^self basicNew handle: aPointer
! !

!GObject methodsFor: 'initialize-release'!

handle: aPointer
    handle := aPointer
! !

!GObject methodsFor: 'accessing'!

handle
    ^handle
! !

!GtkWindow class methodsFor: 'instance creation'!

primNew
    <cCall: 'GtkWindow_new' plugin: 'gtk'>
	self primitiveFailed
!

new
    ^self handle: self primNew
! !

!GtkWidget methodsFor: 'gtk'!

showAll
    <cCall: 'GtkWidget_showAll' plugin: 'gtk'>
	self primitiveFailed
! !

