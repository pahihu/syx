!Fraction class methodsFor: 'instance creation'!

numerator: topNumber denominator: bottomNumber
    ^self basicNew initializeNumerator: topNumber denominator: bottomNumber
! !

!Fraction methodsFor: 'initialize-release'!

initializeNumerator: topNumber denominator: bottomNumber
    numerator := topNumber.
    denominator := bottomNumber.
    self ensureDenominator
! !

!Fraction methodsFor: 'private'!

ensureDenominator
    denominator isZero
    	ifTrue: [ self error: 'Zero division' ].
    denominator negative
    	ifTrue: [ numerator := numerator negated. denominator := denominator negated ]
! !

!Fraction methodsFor: 'arithmetic'!

ceiling
    ^self asFloat ceiling
!

floor
    ^self asFloat floor
!

truncated
    ^self asFloat truncated
! !

!Fraction methodsFor: 'converting'!

asFloat
    ^numerator asFloat / denominator asFloat
! !

!Fraction methodsFor: 'printing'!

printString
    | stream |
    stream := WriteStream on: String new.
    stream
	nextPut: $(;
	nextPutAll: numerator printString;
	nextPut: $/;
	nextPutAll: denominator printString;
	nextPut: $).
    ^stream contents
! !
