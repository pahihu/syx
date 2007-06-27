!Dictionary class methodsFor: 'instance creation'!

new
    ^self new: 10
! !

!Dictionary methodsFor: 'accessing'!

at: aKey
    1 to: hashTable size do: [ :i |
	| link |
	link := hashTable at: i.
	link key = aKey
	    ifTrue: [ link value]
	    ]
!

at: aKey put: aValue
    1 to: hashTable size do: [ :i |
	| link |
	link := hashTable at: i.
	link isNil
	    ifTrue: [
		link := Link key: aKey value: aValue.
		^hashTable at: i put: link ]
	link key = aKey
	    ifTrue: [ ^link value: aValue ]
	    ]		
! !
