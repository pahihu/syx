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

!Character class methodsFor: 'instance creation'!

new
    self shouldNotImplement
!

initialize
    WhiteSpaceTable := { Character cr. Character nl. Character lf. Character space. Character tab.
			 Character verticalTab. Character ff } asSet
!

whiteSpaces
    ^WhiteSpaceTable
!

cr
    "Answer a carriage return character"
    ^self codePoint: 13
!

nl
    "Answer a new line character"
    ^self codePoint: 10
!

lf
    "Answer a line feed character"
    ^self codePoint: 10
!

space
    "Answer a space character"
    ^self codePoint: 32
!

tab
    "Answer a tab character"
    ^self codePoint: 9
!

verticalTab
    "Answer a vertical tab character"
    ^self codePoint: 11
!

ff
    "Answer a form-feed character"
    ^self codePoint: 12
!

codePoint: anInteger
    "Create a character from its integer representation"
    <primitive: 'Character_new'>
	self primitiveFailed
! !

!Character methodsFor: 'accessing'!

codePoint
    "Answer the integer rapresentation of myself"
    <primitive: 'Character_value'>
	self primitiveFailed
! !

!Character methodsFor: 'comparing'!

< aCharacter
     ^self codePoint < aCharacter codePoint
!

> aCharacter
     ^self codePoint > aCharacter codePoint
!

<= aCharacter
     ^self codePoint <= aCharacter codePoint
!

>= aCharacter
     ^self codePoint >= aCharacter codePoint
!

= aCharacter
     ^self codePoint = aCharacter codePoint
!

== aCharacter
     ^self codePoint = aCharacter codePoint
! !

!Character methodsFor: 'converting'!

asCharacter
    ^self
!

asString
    "Return a new string with a single character"
    ^String with: self
!

asUppercase
    self isLowercase
        ifTrue: [ ^Character codePoint: self codePoint - 32 ]
!

asLowercase
    self isUppercase
        ifTrue: [ ^Character codePoint: self codePoint + 32 ]
!

printString
    ^self asString
! !

!Character methodsFor: 'testing'!

isCharacter
    ^true
!

isWhiteSpace
    ^WhiteSpaceTable includes: self
!

isLetter
    ^self isLowercase | self isUppercase
!

isDigit
    ^self between: $0 and: $9
!

isAlphaNumeric
    ^self isDigit | self isLetter
!

isLowercase
    ^self between: $a and: $z
!

isUppercase
    ^self between: $A and: $Z
! !
