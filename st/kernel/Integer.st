!Integer methodsFor: 'arithmetic'!

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

!Integer methodsFor: 'bit-wise operations'!

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
	    cp := $0 codePoint + (num \\ base).
	    cp > $9 codePoint
		ifTrue: [ cp := cp + $A codePoint - $9 codePoint - 1 ].
	    stream nextPut: (Character codePoint: cp).
	    num := num // base ].
    self negative
	ifTrue: [ stream nextPut: $- ].
    ^stream contents reverse
! !

!Integer methodsFor: 'printing'!

printOn: aStream
    aStream nextPutAll: (self radix: 10)
! !

!Integer methodsFor: 'converting'!

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
