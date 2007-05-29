!Association class methodsFor: 'basic'!

key: aKey value: aValue
    "Answer a new association with the given key and value"
    ^self new key: aKey value: aValue
! !

!Association methodsFor: 'accessing'!

value: aValue
    "Set the association's value to aValue"
    value := aValue
!

key: aKey value: aValue
    "Set the association's key to aKey, and its value to aValue"
    key := aKey.
    value := aValue
!

value
    "Answer the association's value"
    ^value
! !
