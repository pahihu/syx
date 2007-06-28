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

!Number methodsFor: 'arithmetic'!

+ aNumber
     self subclassResponsibility
!

- aNumber
     self subclassResponsibility
!

* aNumber
     self subclassResponsibility
!

/ aNumber
     self subclassResponsibility
! !

!Number methodsFor: 'shortcuts and iterators'!

to: stop do: aBlock
    self to: stop by: self unity do: aBlock
!

to: stop by: step do: aBlock
    "Evaluate aBlock for each value in the interval going from the receiver
     to stop by 1. Compiled in-line for one-argument aBlocks without
     temporaries, and therefore not overridable."
    | i |
    i := self.
    [ i <= stop ]
	whileTrue: [ aBlock value: i.
                     i := i + step ]
! !

!Number methodsFor: 'coercing'!

coerce: aNumber
    ^aNumber
!

retrySumCoercing: aNumber
    self generality > aNumber generality
	ifTrue: [ ^self + (self coerce: aNumber) ]
	ifFalse: [ ^(aNumber coerce: self) + aNumber ]
!

retryDiffCoercing: aNumber
    self generality > aNumber generality
	ifTrue: [ ^self - (self coerce: aNumber) ]
	ifFalse: [ ^(aNumber coerce: self) - aNumber ]
!

retryLesserCoercing: aNumber
    self generality > aNumber generality
	ifTrue: [ ^self < (self coerce: aNumber) ]
	ifFalse: [ ^(aNumber coerce: self) < aNumber ]
!

retryGreaterCoercing: aNumber
    self generality > aNumber generality
	ifTrue: [ ^self > (self coerce: aNumber) ]
	ifFalse: [ ^(aNumber coerce: self) > aNumber ]
!

retryLesserEqualCoercing: aNumber
    self generality > aNumber generality
	ifTrue: [ ^self <= (self coerce: aNumber) ]
	ifFalse: [ ^(aNumber coerce: self) <= aNumber ]
!

retryGreaterEqualCoercing: aNumber
    self generality > aNumber generality
	ifTrue: [ ^self >= (self coerce: aNumber) ]
	ifFalse: [ ^(aNumber coerce: self) >= aNumber ]
!

retryEqualCoercing: aNumber
    self generality > aNumber generality
	ifTrue: [ ^self = (self coerce: aNumber) ]
	ifFalse: [ ^(aNumber coerce: self) = aNumber ]
!

retryNotEqualCoercing: aNumber
    self generality > aNumber generality
	ifTrue: [ ^self ~= (self coerce: aNumber) ]
	ifFalse: [ ^(aNumber coerce: self) ~= aNumber ]
!

generality
    self subclassResponsibility
!

unity
    self subclassResponsibility
! !
