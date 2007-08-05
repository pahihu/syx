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

!String class methodsFor: 'instance creation'!

new: anIndex
    "Add 1 to anIndex to make room for NULL character"
    ^super new: anIndex + 1
! !

!String methodsFor: 'basic'!

at: anIndex
    ^Character codePoint: (self byteAt: anIndex)
!

at: anIndex put: aCharacter
    aCharacter isCharacter
	ifFalse: [ self error: 'A character is required got ', aCharacter printString ].
    self byteAt: anIndex put: aCharacter codePoint.
    ^aCharacter
!

basicAt: anIndex
    ^Character codePoint: (self byteAt: anIndex)
!

basicAt: anIndex put: aCharacter
    aCharacter isCharacter
	ifFalse: [ self error: 'A character is required' ].
    self byteAt: anIndex put: aCharacter codePoint.
    ^aCharacter
! !

!String methodsFor: 'primitives'!

printString
    ^self
! !

!String methodsFor: 'basic'!

hash
    <primitive: 'String_hash'>
	self primitiveFailed
!

size
    "The size is less by 1 because of the NULL character"
    ^self basicSize - 1
! !

!String methodsFor: 'utilities'!

compileFor: aClass
    | parser method |
    parser := CompilerParser text: self for: aClass.
    parser parse.
    ^CompiledMethod fromParser: parser
!

doIt
    | method context |
    method := ('goDoIt ', self) compileFor: nil class.
    context := MethodContext on: method parent: thisContext receiver: nil arguments: #().
    ^Processor enter: context
! !

!String methodsFor: 'converting'!

asSymbol
    <primitive: 'String_asSymbol'>
	self primitiveFailed
!

asString
    ^self
!

asNumber
    ^Number readFrom: (ReadStream on: self)
! !

!String methodsFor: 'testing'!

isString
    ^true
! !

!String methodsFor: 'comparing'!

= aString
     self hash == aString hash ifFalse: [ ^false ].
     ^super = aString
!

< aString
    ^(self compare: aString) < 0
!

> aString
    ^(self compare: aString) > 0
!

<= aString
    ^(self compare: aString) <= 0
!

>= aString
    ^(self compare: aString) >= 0
!

compare: aString
    1 to: (self size min: aString size) do: [ :i |
	| n1 n2 |
	n1 := (self at: i) codePoint.
	n2 := (aString at: i) codePoint.
	n1 = n2 ifFalse: [ ^n1 - n2 ] ].

    ^self size - aString size
! !
