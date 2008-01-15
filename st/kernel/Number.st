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

!Number class methodsFor: 'instance creation'!

new
    ^self shouldNotImplement
!

readFrom: readStream
    "Parse the string into a number"
    | c n num scale |
    c := readStream next.
    (c notNil and: [ c isDigit ])
	ifFalse: [ ^0 ].

    "Integer part first"
    num := c digitValue.
    [ c := readStream next. c notNil and: [ c isDigit ] ]
	whileTrue: [
	    n := c digitValue.
	    num := num * 10 + n ].

    "Check for radix"
    c ifNil: [ ^num ].
    c asLowercase = $r
	ifTrue: [
	    | radix table |
	    table := #($0 $1 $2 $3 $4 $5 $6 $7 $8 $9 $A $B $C $D $E $F).
	    radix := num.
	    num := 0.
	    [ (c := readStream next) notNil and: [ c isXDigit ] ]
		whileTrue: [
		    | idx |
		    idx := table indexOf: c asUppercase.
		    idx > radix
			ifTrue: [
			    readStream skip: -1. ^num ].
		    num := (num * radix) + idx - 1 ] ].

    "Is it just an integer?"
    (c = $.)
	ifFalse: [ readStream skip: -1. ^num ].

    "Maybe a float"
    scale := 0.1.
    c := readStream next.

    "Be sure it's a float"
    (c notNil and: [ c isDigit ])
	ifFalse: [ readStream skip: -2. ^num ].

    [ c notNil and: [ c isDigit ] ]
	whileTrue: [
	    n := c digitValue.
	    num := num + (n * scale).
	    scale := scale * 0.1.
	    c := readStream next ].

    readStream skip: -1.
    ^num
! !

!Number methodsFor: 'testing'!

isNumber
    ^true
!

isInteger
    ^false
!

isSmallInteger
    ^false
!

isLargeInteger
    ^false
!

isFloat
    ^false
!

isFraction
    ^false
!

isZero
    ^self = self zero
!

negative
    ^self < self zero
!

positive
    ^self >= self zero
!

sign
    self < self zero
	ifTrue: [ ^-1 ].
    self > self zero
	ifTrue: [ ^1 ].
    ^0
! !

!Number methodsFor: 'iterators'!

to: stop
    "Create an Interval between the receiver and stop"
    ^Interval from: self to: stop
!

to: stop by: step
    "Create an Interval between the receiver and stop by step"
    ^Interval from: self to: stop by: step
!

to: stop do: aBlock
    "Do aBlock from self to stop. Pass the counter to aBlock"
    self to: stop by: self unity do: aBlock
!

to: stop reverseDo: aBlock
    "Do aBlock decreasing self to stop. Pass the counter to aBlock"
    self to: stop by: self unity reverseDo: aBlock
!

to: stop by: step do: aBlock
    "Do aBlock increasing self to stop stepping by step. Pass the counter to aBlock"
    | i |
    i := self.
    step positive
	ifTrue: [
	    [ i <= stop ]
		whileTrue: [ aBlock value: i.
			     i := i + step ] ]
	ifFalse: [
	    [ i >= stop ]
		whileTrue: [ aBlock value: i.
			     i := i + step ] ]
! !

!Number methodsFor: 'coercing'!

asFraction
    ^Fraction numerator: self denominator: 1
!

zero
    ^self subclassResponsibility
!

coerce: aNumber
    ^aNumber
! !

!Number methodsFor: 'arithmetic'!

negated
    self ~= self zero
	ifTrue: [ ^self zero - self ]
!

abs
    self < self zero
	ifTrue: [ ^self negated ]
	ifFalse: [ ^self ]
!

+ aNumber
    "Coerce aNumber and do the sum"
    ^self generality > aNumber generality
	 ifTrue: [ self + (self coerce: aNumber) ]
	 ifFalse: [ (aNumber coerce: self) + aNumber ]
!

- aNumber
    "Coerce aNumber and do the difference"
    ^self generality > aNumber generality
	ifTrue: [ self - (self coerce: aNumber) ]
	ifFalse: [ (aNumber coerce: self) - aNumber ]
!

* aNumber
    "Coerce aNumber and do multiplication"
    ^self generality > aNumber generality
	ifTrue: [ self * (self coerce: aNumber) ]
	ifFalse: [ (aNumber coerce: self) * aNumber ]
!

< aNumber
    ^"Coerce aNumber and compare"
    self generality > aNumber generality
	ifTrue: [ self < (self coerce: aNumber) ]
	ifFalse: [ (aNumber coerce: self) < aNumber ]
!

> aNumber
    "Coerce aNumber and compare"
    ^self generality > aNumber generality
	ifTrue: [ self > (self coerce: aNumber) ]
	ifFalse: [ (aNumber coerce: self) > aNumber ]
!

<= aNumber
    "Coerce aNumber and compare"
    ^self generality > aNumber generality
	ifTrue: [ self <= (self coerce: aNumber) ]
	ifFalse: [ (aNumber coerce: self) <= aNumber ]
!

>= aNumber
    "Coerce aNumber and compare"
    ^self generality > aNumber generality
	ifTrue: [ self >= (self coerce: aNumber) ]
	ifFalse: [ (aNumber coerce: self) >= aNumber ]
!

= aNumber
    "Coerce aNumber and compare equality"
    aNumber isNumber
	ifFalse: [ ^false ].
    ^self generality > aNumber generality
	ifTrue: [ self = (self coerce: aNumber) ]
	ifFalse: [ (aNumber coerce: self) = aNumber ]
!

== aNumber
    "Coerce aNumber and compare equality"
    aNumber isNumber
	ifFalse: [ ^false ].
    ^self generality > aNumber generality
	 ifTrue: [ self == (self coerce: aNumber) ]
	 ifFalse: [ (aNumber coerce: self) == aNumber ]
!

~= aNumber
    "Coerce aNumber and compare inequality"
    ^self generality > aNumber generality
	ifTrue: [ self ~= (self coerce: aNumber) ]
	ifFalse: [ (aNumber coerce: self) ~= aNumber ]
!

~~ aNumber
    "Coerce aNumber and compare inequality"
    ^self generality > aNumber generality
	ifTrue: [ self ~~ (self coerce: aNumber) ]
	ifFalse: [ (aNumber coerce: self) ~~ aNumber ]
!

/ aNumber
    "Coerce aNumber and do division"
    aNumber isZero
	ifTrue: [ self zeroDivide ].

    ^self generality > aNumber generality
        ifTrue: [ self / (self coerce: aNumber) ]
        ifFalse: [ (aNumber coerce: self) / aNumber ]
!

// aNumber
    "Do division then answer the quotient floor"
    ^(self / aNumber) floor
!

\\ aNumber
    "Coerce aNumber and do modulo"
    ^self generality > aNumber generality
	ifTrue: [ self \\ (self coerce: aNumber) ]
	ifFalse: [ (aNumber coerce: self) \\ aNumber ]
!

quo: aNumber
    "Do division then answer the truncated quotient"
    ^(self / aNumber) truncated
!

compare: aNumber
    "Return 1 if self > aNumber, 0 if = aNumber, -1 if < aNumber"
    self > aNumber
	ifTrue: [ ^1 ].
    self = aNumber
	ifTrue: [ ^0 ].
    self < aNumber
	ifTrue: [ ^-1 ]
!

reciprocal
    "Answer the reciprocal number of self"
    ^1 / self
!

generality
    self subclassResponsibility
!

unity
    self subclassResponsibility
! !

!Number methodsFor: 'signaling'!

zeroDivide
    ZeroDivide signal
! !
