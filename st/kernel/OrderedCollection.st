!OrderedCollection class methodsFor: 'instance-creation'!

new: size
    ^(self basicNew: size) initialize
!

new
    ^self new: 16
! !

!OrderedCollection methodsFor: 'initialize-release'!

initialize
    firstIndex := self basicSize // 2.
    lastIndex := firstIndex - 1
! !

!OrderedCollection methodsFor: 'private'!

incrementLastIndex
    (lastIndex := lastIndex + 1) > self basicSize
	ifTrue: [ self growTo: lastIndex * 2 ]
! !

!OrderedCollection methodsFor: 'basic'!

at: anIndex
    ^self basicAt: anIndex + firstIndex - 1
!

at: anIndex put: anObject
    ^self basicAt: anIndex + firstIndex - 1 put: anObject
!

firstIndex
    ^firstIndex
!

lastIndex
    ^lastIndex
!

size
    ^lastIndex - firstIndex + 1
!

add: anObject
    self incrementLastIndex.
    ^self basicAt: lastIndex put: anObject
!

addAll: aCollection
    aCollection
	do: [ :ea | self add: ea ]
!

remove: anObject ifAbsent: aBlock
    ^self removeAtIndex:
        (self indexOf: anObject startingAt: 1 ifAbsent: [ ^aBlock value ])
!

removeAtIndex: anIndex
    | answer |
    answer := self at: anIndex.
    
    anIndex = 1
	ifTrue: [ firstIndex := firstIndex + 1. ^answer ].
    anIndex = self size
	ifTrue: [ lastIndex := lastIndex - 1. ^answer ].

    anIndex + firstIndex - 1 to: (lastIndex := lastIndex - 1) do: [ :index |
	self basicAt: index put: (self basicAt: index + 1) ].
    ^answer
! !

!OrderedCollection methodsFor: 'converting'!

asOrderedCollection
    ^self
! !

!OrderedCollection methodsFor: 'testing'!

isOrderedCollection
    ^true
! !
