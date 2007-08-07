!IdentityDictionary methodsFor: 'accessing'!

indexOf: aKey
    | i n size |
    size := self basicSize.
    i := 2 * (aKey hash \\ (size // 2)).
    n := numElements + 2.
    [ (n := n - 1) = 0 ]
	whileFalse: [
	    | key |
	    i >= (size - 1)
		ifTrue: [ i := 0 ].
	    key := self basicAt: i + 1.
	    key == aKey | key isNil
		ifTrue: [ ^i + 1 ].
	    i := i + 2 ]
! !
