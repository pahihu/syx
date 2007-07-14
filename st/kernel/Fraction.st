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

!Fraction methodsFor: 'printing'!

print
    numerator print. '/' print. denominator print
!

printNl
    self print. Transcript cr
! !