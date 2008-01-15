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

!Integer methodsFor: 'factorization and divisibility'!

gcd: aNumber
    "Answer the greatest common divisor"
    | num tmp remainder |
    num := self max: aNumber.
    remainder := self min: aNumber.
    [ remainder isZero ]
	whileFalse: [    
	    tmp := remainder.
	    remainder := num \\ remainder.
	    num := tmp ].
    ^num abs
! !

!Integer methodsFor: 'bit manipulation'!

allMask: anInteger
    "Answer true if all 1 bits of the receiver are 1 also in the argument"
    ^(self bitAnd: anInteger) == anInteger
!

anyMask: anInteger
    "Answer true if any of the bits that are 1 in the argument are 1 in the receiver"
    ^(self bitAnd: anInteger) ~~ anInteger
!

noMask: anInteger
    "Answer true if none of the bits that are 1 in the argument are 1 in the receiver"
    ^(self bitAnd: anInteger) == 0
!

bitAnd: aNumber
    aNumber isInteger
	ifFalse: [ self error: 'An integer is required' ].

    self generality > aNumber generality
	ifTrue: [ ^self bitAnd: (self coerce: aNumber) ]
	ifFalse: [ ^(aNumber coerce: self) bitAnd: aNumber ]
!

bitOr: aNumber
    aNumber isInteger
	ifFalse: [ self error: 'An integer is required' ].

    self generality > aNumber generality
	ifTrue: [ ^self bitOr: (self coerce: aNumber) ]
	ifFalse: [ ^(aNumber coerce: self) bitOr: aNumber ]
!

bitXor: aNumber
    aNumber isInteger
	ifFalse: [ self error: 'An integer is required' ].

    self generality > aNumber generality
	ifTrue: [ ^self bitXor: (self coerce: aNumber) ]
	ifFalse: [ ^(aNumber coerce: self) bitXor: aNumber ]
!

bitShift: aNumber
    aNumber isSmallInteger
	ifFalse: [ self error: 'A small integer is required' ].
   
    ^self asLargeInteger bitShift: aNumber
!

bitAt: index
    "Answer the bit 0 or 1 at the given index"
    ^(self bitShift: (index - 1) negated) bitAnd: 1
!

bitInvert
    "Answer an Integer whose bits are inverted"
    ^self bitXor: -1
!

<< aNumber
    ^self bitShift: aNumber
!

>> aNumber
    ^self bitShift: aNumber negated
! !

!Integer methodsFor: 'printing'!

radix: base
    "Returns a string representing the integer with the given base.
     The base must be between 2 and 16"
    | stream num |
    base isInteger & (base between: 2 and: 16)
	ifFalse: [ self error: 'Argument must be an integer between 2 and 16' ].
    self isZero
	ifTrue: [ ^'0' ].
    stream := WriteStream on: String new.
    num := self abs.
    [ num ~= 0 ]
	whileTrue: [
	    | cp |
	    cp := $0 asciiValue + (num \\ base).
	    cp > $9 asciiValue
		ifTrue: [ cp := cp + $A asciiValue - $9 asciiValue - 1 ].
	    stream nextPut: (Character value: cp).
	    num := num // base ].
    self negative
	ifTrue: [ stream nextPut: $- ].
    ^stream contents reverse
!

printStringRadix: base
    | stream |
    stream := WriteStream on: String new.
    self printOn: stream base: base.
    ^stream contents
!

printOn: aStream
    self storeOn: aStream base: 10
!

storeOn: aStream
    self storeOn: aStream base: 10
!

printOn: aStream base: base
    aStream nextPutAll: (self radix: base)
!

storeOn: aStream base: base
    aStream nextPutAll: (self radix: base)
! !

!Integer methodsFor: 'truncation and round off'!

ceiling
    ^self
!

floor
    ^self
!

truncated
    ^self
! !

!Integer methodsFor: 'testing'!

isInteger
    ^true
! !

!Integer methodsFor: 'enumerating'!

timesRepeat: aBlock
    1 to: self to: [ :ea |
        aBlock value ]
! !
