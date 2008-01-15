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
			 Character verticalTab. Character ff } asSet.
    XDigitsTable := (Set new: 40) addAll: #($0 $1 $2 $3 $4 $5 $6 $7 $8 $9 $a $b $c $d $e $f $A $B $C $D $E $F)
!

whiteSpaces
    ^WhiteSpaceTable
!

cr
    "Answer a carriage return character"
    ^self value: 13
!

nl
    "Answer a new line character"
    ^self value: 10
!

lf
    "Answer a line feed character"
    ^self value: 10
!

space
    "Answer a space character"
    ^self value: 32
!

tab
    "Answer a tab character"
    ^self value: 9
!

verticalTab
    "Answer a vertical tab character"
    ^self value: 11
!

ff
    "Answer a form-feed character"
    ^self value: 12
!

codePoint: anInteger
    ^self value: anInteger
!

value: anInteger
    "Create a Character from the given integer representation"
    <primitive: 'Character_new'>
	self primitiveFailed
!

digitValue: anInteger
    "Create a Character whose digit value is anInteger"
    ^self value: anInteger + $0 asciiValue
! !

!Character methodsFor: 'accessing'!

codePoint
    ^self asciiValue
!

asciiValue
    "Answer the integer rapresentation of myself"
    <primitive: 'Character_value'>
	self primitiveFailed
!

digitValue
    "Answer the number corresponding to the digit value of the receiver"
    ^self asciiValue - $0 asciiValue
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
     aCharacter isCharacter
	 ifFalse: [ ^false ].
     ^self codePoint = aCharacter codePoint
!

== aCharacter
     aCharacter isCharacter
	 ifFalse: [ ^false ].
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
        ifTrue: [ ^Character value: self codePoint - 32 ]
!

asLowercase
    self isUppercase
        ifTrue: [ ^Character value: self codePoint + 32 ]
! !

!Character methodsFor: 'printing'!

printOn: aStream
    aStream
        nextPut: $$;
        nextPut: self
!

storeOn: aStream
    aStream
        nextPut: $$;
        nextPut: self
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

isXDigit
    ^XDigitsTable includes: self
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
