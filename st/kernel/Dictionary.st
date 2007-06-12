!Dictionary methodsFor: 'accessing'!

at: aKey
    1 to: hashTable size by: 2 do: [ :i |
	(hashTable at: i) = aKey
	    ifTrue: [ ^hashTable at: i + 1 ]
	    ]
!

at: aKey put: aValue
    1 to: hashTable size by: 2 do: [ :i |
	| k |
	k := hashTable at: i.
	(k isNil or: [ k = aKey])
	    ifTrue: [
		hashTable at: i put: aKey.
		^hashTable at: i + 1 put: aValue ]
	    ]
! !
