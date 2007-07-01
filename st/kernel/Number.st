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
! !

!Number methodsFor: 'testing'!

isSmallInteger
    ^false
! !

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
    "Do aBlock from self to stop. Pass the counter to aBlock"
    self to: stop by: self unity do: aBlock
!

to: stop by: step do: aBlock
    "Do aBlock from self to stop stepping by step. Pass the counter to aBlock"
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

sumWith: aNumber
    "Coerce aNumber and do sum"
    self generality > aNumber generality
	ifTrue: [ ^self + (self coerce: aNumber) ]
	ifFalse: [ ^(aNumber coerce: self) + aNumber ]
!

differenceWith: aNumber
    "Coerce aNumber and do the difference"
    self generality > aNumber generality
	ifTrue: [ ^self - (self coerce: aNumber) ]
	ifFalse: [ ^(aNumber coerce: self) - aNumber ]
!

lesserThan: aNumber
    "Coerce aNumber and compare"
    self generality > aNumber generality
	ifTrue: [ ^self < (self coerce: aNumber) ]
	ifFalse: [ ^(aNumber coerce: self) < aNumber ]
!

greaterThan: aNumber
    "Coerce aNumber and compare"
    self generality > aNumber generality
	ifTrue: [ ^self > (self coerce: aNumber) ]
	ifFalse: [ ^(aNumber coerce: self) > aNumber ]
!

lesserOrEqualThan: aNumber
    "Coerce aNumber and compare"
    self generality > aNumber generality
	ifTrue: [ ^self <= (self coerce: aNumber) ]
	ifFalse: [ ^(aNumber coerce: self) <= aNumber ]
!

greaterOrEqualThan: aNumber
    "Coerce aNumber and compare"
    self generality > aNumber generality
	ifTrue: [ ^self >= (self coerce: aNumber) ]
	ifFalse: [ ^(aNumber coerce: self) >= aNumber ]
!

equalTo: aNumber
    "Coerce aNumber and compare equality"
    self generality > aNumber generality
	ifTrue: [ ^self = (self coerce: aNumber) ]
	ifFalse: [ ^(aNumber coerce: self) = aNumber ]
!

notEqualTo: aNumber
    "Coerce aNumber and compare inequality"
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
