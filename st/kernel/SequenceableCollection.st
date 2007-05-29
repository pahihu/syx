!SequenceableCollection methodsFor: 'replacing items'!

replaceFrom: start with: replacementCollection
    "Replace the items from start to stop with replacementCollection's items
     from 1 to stop-start+1 (in unexpected order if the collection is not
     sequenceable)."
    | i |
    i := start - 1.
    replacementCollection do: [ :ea |
	self at: (i := i + 1) put: ea
    ]
! !

!SequenceableCollection methodsFor: 'enumerating'!

do: aBlock
    "Evaluate aBlock for all the elements in the sequenceable collection"
    1 to: self size do: [ :i | aBlock value: (self at: i) ].
! !

!SequenceableCollection methodsFor: 'basic'!

indexOf: anElement startingAt: anIndex ifAbsent: exceptionBlock
    anIndex to: self size do: [ :index |
        (self at: index) == anObject ifTrue: [ ^index ].
    ].
    ^exceptionBlock value
! !
