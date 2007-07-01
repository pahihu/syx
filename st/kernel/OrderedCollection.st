!OrderedCollection methodsFor: 'basic'!

add: anObject
    ^self notYetImplemented
!

addAll: aCollection
    aCollection do: [:ea |
	self add: ea]
!

remove: anObject ifAbsent: aBlock
    ^self removeAtIndex:
        (self indexOf: anObject startingAt: 1 ifAbsent: [ ^aBlock value ])
!

removeAtIndex: anIndex
    ^self notYetImplemented
! !
