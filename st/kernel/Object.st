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

!Object methodsFor: 'initialize-release'!

initialize

! !

!Object methodsFor: 'finalization'!

finalize

! !

!Object methodsFor: 'copying'!

copy
    ^self shallowCopy
!

shallowCopy
    <primitive: 'Object_copy'>
	^self
! !

!Object methodsFor: 'basic'!

at: anIndex
    self shouldNotImplement
!

at: anIndex put: anObject
    self shouldNotImplement
!

basicAt: anIndex
    <primitive: 'Object_at'>
	self primitiveFailed
!

basicAt: anIndex put: anObject
    <primitive: 'Object_at_put'>
	self primitiveFailed
!

basicGrowTo: aSize
    <primitive: 'Object_resize'>
	self primitiveFailed
!

size
    <primitive: 'Object_size'>
	self primitiveFailed
!

basicSize
    <primitive: 'Object_size'>
	self primitiveFailed
!

identityHash
    <primitive: 'Object_identityHash'>
	self primitiveFailed
!

hash
    <primitive: 'Object_hash'>
	self primitiveFailed
! !
    
!Object methodsFor: 'testing'!

isCharacter
    ^false
!

isBoolean
    ^false
!

isKindOf: aClass
    "Answer true if the receiver's class is a subclass of aClass"
    | class |
    aClass
	ifNil: [ ^false ].
    class := self class.
    class = aClass
	ifTrue: [ ^true ].

    aClass allSubclassesDo: [ :ea |
	ea = class
	    ifTrue: [ ^true ] ].
    ^false
!

isMemberOf: aClass
    "Answer true whenever the receiver is an instance of the given class"
    ^self class = aClass
!

isClass
    ^false
!

isNumber
    ^false
!

isCollection
    ^false
!

isString
    ^false
!

isSymbol
    ^false
!

ifNil: aBlock
    ^self
!

ifNotNil: aBlock
    ^aBlock value
!

isNil
    ^false
!

notNil
    ^true
! !

!Object methodsFor: 'accessing'!

class
    <primitive: 'Object_class'>
	self primitiveFailed
!

= anObject
    <primitive: 'Object_equal'>
	self primitiveFailed
!

== anObject
    <primitive: 'Object_identityEqual'>
	self primitiveFailed
!

~= anObject
    ^(self = anObject) not
!

~~ anObject
    ^(self == anObject) not
! !

!Object methodsFor: 'signaling'!

error: messageText
    Error signal: messageText
!

doesNotUnderstand: aMessage
    MessageNotUnderstood
	message: aMessage receiver: self
!

shouldNotImplement
    ShouldNotImplement signal
!

subclassResponsibility
    SubclassResponsibility signal
!

notYetImplemented
    NotYetImplemented signal
!

primitiveFailed
    PrimitiveFailed signal
! !

!Object methodsFor: 'syntax shortcuts'!

respondsTo: selector
    "Answer if the receiver can respond to the given selector"
    ^self class doesUnderstand: selector
!

perform: selector
    <primitive: 'Object_perform'>
	(self respondsTo: selector)
	ifFalse: [ self doesNotUnderstand: selector ]
	ifTrue: [ WrongArgumentCount signal ]
!

perform: selector with: argument1
    <primitive: 'Object_perform'>
	(self respondsTo: selector)
	ifFalse: [ self doesNotUnderstand: selector ]
	ifTrue: [ WrongArgumentCount signal ]
!

perform: selector with: argument1 with: argument2
    <primitive: 'Object_perform'>
	(self respondsTo: selector)
	ifFalse: [ self doesNotUnderstand: selector ]
	ifTrue: [ WrongArgumentCount signal ]
!

perform: selector with: argument1 with: argument2 with: argument3
    <primitive: 'Object_perform'>
	(self respondsTo: selector)
	ifFalse: [ self doesNotUnderstand: selector ]
	ifTrue: [ WrongArgumentCount signal ]
!

perform: selector withArguments: arguments
    "Send a message using the given message selector and the given collection of arguments"
    <primitive: 'Object_performWithArguments'>
	(self respondsTo: selector)
	ifFalse: [ self doesNotUnderstand: selector ]
	ifTrue: [ WrongArgumentCount signal ]
!

-> anObject
    "Create a new association between myself and anObject"
    ^Association key: self value: anObject
!

caseOf: anArrayOfAssociations
    ^self caseOf: anArrayOfAssociations otherwise: [ NotFound signal ]
!

caseOf: anArrayOfAssociations otherwise: aBlock
    "
     Switch case between the keys of the array. If one of the block evaluation is the same as the receiver
     then the value of the association (a block) is evaluated.
     
     123 caseOf: {
       [123] -> ['This is 123'].
       [321] -> ['This is 321'] }
     "
    anArrayOfAssociations do: [ :assoc |
	assoc key value = self
	    ifTrue: [ ^assoc value value ] ].
    ^aBlock value
! !

!Object methodsFor: 'class type methods'!

yourself
    "Answer the receiver"
    ^self
! !

!Object methodsFor: 'inspecting'!

briefInspect
    ^self
! !

!Object methodsFor: 'printing'!

print
    Transcript show: self printString
!

printNl
    Transcript showCr: self printString
!

printOn: aStream
    "Append to aStream a String representation of the receiver"
    aStream
        nextPutAll: 'a ';
        nextPutAll: self class name
!

printString
    "Answer a String representation of the receiver"
    | stream |
    stream := WriteStream on: String new.
    self printOn: stream.
    ^stream contents
! !
