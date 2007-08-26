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

!BlockClosure class methodsFor: 'instance creation'!

new: aBlock
    ^self new initializeBlock: aBlock
! !

!BlockClosure methodsFor: 'initialize-release'!

initializeBlock: aBlock
    block := aBlock
! !

!BlockClosure methodsFor: 'executing'!

block
    "Answer the CompiledBlock which i'm holding"
    ^block
!

asContextWithArguments: anArray
    "Return a BlockContext. Contents of anArray is given to the block as its arguments"
    <primitive: 'BlockClosure_asContext'>
	self primitiveFailed
!

newProcess
    "Return a new Process from self. The Process is suspended"
    <primitive: 'BlockClosure_newProcess'>
	self primitiveFailed
!

fork
    "Answer a new resumed Process"
    ^self newProcess resume
!

on: anExceptionClass do: aBlock
    "If anExceptionClass, or its subclasses, are signaled, aBlock is evaluated with the exception as argument"
    <primitive: 'BlockClosure_on_do'>
    | ctx | 
    ctx := self asContext: #().
    ctx
	handledException: anExceptionClass;
	handlerBlock: aBlock.
    ^thisContext enter: ctx
!

ifCurtailed: aBlock
    "Be sure aBlock is called if an error occurs evaluating the receiver"
    ^self on: Signal do: [ :ex | aBlock value. ex pass. ^nil ]
!    

ensure: aBlock
    "Be sure aBlock is called if an error occurs or not"
    | ret |
    ret := self on: Signal do: [ :ex | aBlock value. ex pass. ^nil ].
    aBlock value.
    ^ret
!

valueWithArguments: anArray
    "Call my block with the elements of anArray as arguments of the message"
    <primitive: 'BlockClosure_valueWithArguments'>
	self primitiveFailed
    WrongArgumentCount signal
!

value
    "Call my block without arguments"
    <primitive: 'BlockClosure_value'>
	WrongArgumentCount signal
!

value: anObject
    "Call my block with anObject as single argument"
    <primitive: 'BlockClosure_valueWith'>
	WrongArgumentCount signal
!

value: firstObject value: secondObject
    ^self valueWithArguments: { firstObject. secondObject }
! !

!BlockClosure methodsFor: 'accessing'!

definedContext
    ^definedContext
!

definedContext: aContext
    "Set the context where the closure has been defined."
    definedContext := aContext
! !

!BlockClosure methodsFor: 'loops'!

repeat
    "Do an infinite loop"
    [true] whileTrue: self
!

whileTrue
    "Loop until self evaluation is false"
    self whileTrue: [nil]
!

whileFalse
    "Loop until self evaluation is true"
    self whileFalse: [nil]
!

whileTrue: aBlock
    "Do aBlock until self is false"
    self whileTrue: aBlock
!

whileFalse: aBlock
    "Do aBlock until self is true"
    self whileFalse: aBlock
! !

