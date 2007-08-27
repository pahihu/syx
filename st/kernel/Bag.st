!Bag methodsFor: 'accessing'!

indexOf: anObject
    "This method is similiar to Set>>indexOf: except that return the position only of empty entries"
    | i n size |
    size := self basicSize.
    i := 2 * (anObject hash \\ size).
    n := tally + 2.
    [ (n := n - 1) = 0 ]
	whileFalse: [
	    | key |
	    i >= size
		ifTrue: [ i := 0 ].
	    key := self basicAt: i + 1.
	    key isNil
		ifTrue: [ ^i + 1 ].
	    i := i + 1 ]
! !

!Bag methodsFor: 'converting'!

asSet
    ^Set withAll: self
!

asBag
    ^self
! !

!Bag methodsFor: 'testing'!

isSet
    ^false
!

isBag
    ^true
! !
