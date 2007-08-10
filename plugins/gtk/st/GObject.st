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

!GPointer class methodsFor: 'instance creation'!

new
    self subclassResponsibility
!

handle: aPointer
    ^self basicNew handle: aPointer
! !

!GPointer methodsFor: 'initialize-release'!

handle: aPointer
    handle := aPointer
! !

!GPointer methodsFor: 'accessing'!

handle
    ^handle
! !


!GObject methodsFor: 'signals'!

primConnect: signalName closure: aGClosure after: aBoolean
    <cCall: 'Gtk_g_signal_connect_closure' plugin: 'gtk'>
	self primitiveFailed
!

when: signalName send: aSelector
    ^self when: signalName send: aSelector withArguments: #()
!

when: signalName send: aSelector withArguments: anArray
    | callback id |
    callback := GCallback selector: aSelector withArguments: anArray.
    id := self primConnect: signalName closure: callback closure after: false.
    callback handlerId: id.
    ^callback
! !



!GClosure class methodsFor: 'instance creation'!

primNew: userData destroyData: destroyData
    <cCall: 'Gtk_g_cclosure_new' plugin: 'gtk'>
	self primitiveFailed
!

on: aGCallback
    ^self handle: (self primNew: aGCallback destroyData: nil)
! !

!GClosure methodsFor: 'initialize-release'!

marshal: marshal
    <cCall: 'Gtk_g_closure_set_marshal' plugin: 'gtk'>
	self primitiveFailed
!

ref
    <cCall: 'Gtk_g_closure_ref' plugin: 'gtk'>
	self primitiveFailed
!

unref
    <cCall: 'Gtk_g_closure_unref' plugin: 'gtk'>
	self primitiveFailed
! !
