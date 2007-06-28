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

!BlockClosure methodsFor: 'executing'!

block
    ^block
!

asContext: anArray
    <primitive: 'BlockClosure_asContext'>
	self primitiveFailed
!

newProcess
    <primitive: 'BlockClosure_newProcess'>
	self primitiveFailed
!

fork
    ^self newProcess resume
!

on: anExceptionClass do: aBlock
    <primitive: 'BlockClosure_on_do'>
    | ctx | 
    ctx := self asContext: #().
    ctx
	handledException: anExceptionClass;
	handlerBlock: aBlock.
    ^thisContext enter: ctx
!

ensure: aBlock
    self on: Signal do: [:ex | ^aBlock value]
!

valueWithArguments: anArray
    <primitive: 'BlockClosure_valueWithArguments'>
	self primitiveFailed
!

value
    <primitive: 'BlockClosure_value'>
	self primitiveFailed
!

value: anObject
    <primitive: 'BlockClosure_valueWith'>
	self primitiveFailed
! !

!BlockClosure methodsFor: 'accessing'!

definedContext: aContext
    definedContext := aContext
! !

!BlockClosure methodsFor: 'loops'!

repeat
    [true] whileTrue: self
!

whileTrue
    self whileTrue: [nil]
!

whileTrue: aBlock
    self whileTrue: aBlock
!

whileFalse: aBlock
    self whileFalse: aBlock
! !

