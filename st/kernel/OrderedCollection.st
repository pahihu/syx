!OrderedCollection class methodsFor: 'instance-creation'!

new: size
    ^(self basicNew: size) initialize
!

new
    ^self new: 11
! !

!OrderedCollection methodsFor: 'initialize-release'!

initialize
    tally := 0
! !

!OrderedCollection methodsFor: 'basic'!

incrementNumElements
    (tally := tally + 1) > (self basicSize // 2)
	ifTrue: [ self growTo: self basicSize + tally ]
!

size
    ^tally
!

add: anObject
    self incrementNumElements.
    self at: tally put: anObject
!

addAll: aCollection
    aCollection do: [ :ea |
	self add: ea ]
!

remove: anObject ifAbsent: aBlock
    ^self removeAtIndex:
        (self indexOf: anObject startingAt: 1 ifAbsent: [ ^aBlock value ])
!

removeAtIndex: anIndex
    ^self notYetImplemented
! !

!OrderedCollection methodsFor: 'converting'!

asOrderedCollection
    ^self
! !

!OrderedCollection methodsFor: 'testing'!

isOrderedCollection
    ^true
! !
