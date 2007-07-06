!Set class methodsFor: 'instance creation'!

new: size
    ^self basicNew: (size max: 10)
	initializeTable: size;
	yourself
! !

!Set methodsFor: 'accessing'!

indexOf: anObject
    | h2 pos size |
    size := self basicSize.
    pos := anObject hash \\ (size - 1).
    h2 := pos / 4.

    h2 := h2 max: 1.
    (h2 ~= 1 & ((h2 \\ 2) isZero))
	ifTrue: [ h2 := h2 - 1 ].
    
    pos := pos + 1.
    1 to: size do: [ :i |
	| key |
	key := self basicAt: pos.
	key = anObject | key isNil
	    ifTrue: [ ^pos ].
	pos := pos + h2.
	pos > size
	    ifTrue: [ pos := pos - size ] ].
    self error: 'Set is full'
!

do: aBlock
    1 to: self basicSize do: [ :i |
         | el |
         el := self basicAt: i.
	 el ifNotNil: [ aBlock value: el ] ]
!

add: anObject
    | index |
    anObject
	ifNil: [ ^nil ].
    
    index := self indexOf: anObject.
    (self basicAt: index) isNil
	ifTrue: [ self basicAt: index put: anObject ]
!

remove: anObject
    | index |
    index := self indexOf: anObject.
    (self basicAt: index) isNil
	ifTrue: [ NotFound signal: 'Object not found' ].
    self basicAt: index put: nil
! !
