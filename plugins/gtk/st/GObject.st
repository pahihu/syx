"
Copyright (c) 2007-2008 Luca Bruno

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

Object subclass: #GPointer
       instanceVariableNames: 'handle'
       classVariableNames: ''!

GPointer subclass: #GCallback
	 instanceVariableNames: 'arguments closure handlerId'
	 classVariableNames: 'AllCallbacks GClosureMarshal'!

GCallback subclass: #GMethodCallback
          instanceVariableNames: 'selector'
          classVariableNames: ''!

GCallback subclass: #GBlockCallback
          instanceVariableNames: 'block'
          classVariableNames: ''!

GPointer subclass: #GClosure
	 instanceVariableNames: ''
	 classVariableNames: ''!

GPointer subclass: #GObject
	 instanceVariableNames: ''
	 classVariableNames: ''!

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
    callback := GMethodCallback selector: aSelector withArguments: anArray.
    id := self primConnect: signalName closure: callback closure after: false.
    callback handlerId: id.
    ^callback
!

when: signalName do: aBlock
    ^self when: signalName do: aBlock withArguments: #()
!

when: signalName do: aBlock withArguments: anArray
    | callback id |
    callback := GBlockCallback block: aBlock withArguments: anArray.
    id := self primConnect: signalName closure: callback closure after: false.
    callback handlerId: id.
    ^callback
! !

"Callbacks"

!GCallback class methodsFor: 'initialize-release'!

initialize
    AllCallbacks := Bag new.
    GClosureMarshal := GPointer handle: (Smalltalk plugin: 'gtk' cSymbol: 'syx_g_closure_marshal')
! !

!GCallback class methodsFor: 'instance creation'!

new
    ^self basicNew initialize
! !

!GCallback methodsFor: 'initialize-release'!

initialize
    | callback marshal |
    handle := self.
    marshal := GClosureMarshal.
    closure := GClosure on: self.
    closure ref.
    closure marshal: marshal.
    AllCallbacks add: self
!

handlerId: aSignalHandler
    handlerId := aSignalHandler
! !

!GCallback methodsFor: 'accessing'!

closure
    ^closure
!

handlerId
    ^handlerId
!

arguments
    ^arguments
! !

!GMethodCallback class methodsFor: 'instance creation'!

selector: aSelector withArguments: anArray
    ^self new initializeSelector: aSelector arguments: anArray
! !

!GMethodCallback methodsFor: 'initialize-release'!

initializeSelector: aSelector arguments: anArray
    selector := aSelector.
    arguments := anArray
! !

!GMethodCallback methodsFor: 'invoking'!

invoke: anArray
    "This method is called directly from syx_gtk_callback"
    ^selector key perform: selector value withArguments: anArray, arguments
! !

!GBlockCallback class methodsFor: 'instance creation'!

block: aBlock withArguments: anArray
    ^self new initializeBlock: aBlock arguments: anArray
! !

!GBlockCallback methodsFor: 'initialize-release'!

initializeBlock: aBlock arguments: anArray
    block := aBlock.
    arguments := anArray
! !

!GBlockCallback methodsFor: 'invoking'!

invoke: anArray
    "This method is called directly from syx_gtk_callback"
    ^block valueWithArguments: anArray, arguments
! !

" C callback closures "

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
