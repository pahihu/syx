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

incrementLastIndex: aNumber
    (lastIndex := lastIndex + aNumber) > self basicSize
	ifTrue: [ self growTo: lastIndex * 2 ]
!

incrementLastIndex
    self incrementLastIndex: 1
!

shiftFrom: anIndex by: offset
    self size to: anIndex reverseDo: [ :i |
        self at: i + offset put: (self at: i) ].
! !   

!OrderedCollection methodsFor: 'adding'!

add: anObject
    self incrementLastIndex.
    ^self basicAt: lastIndex put: anObject
!

add: newObject after: oldObject
    "Add newObject after oldObject"
    | index |
    index := self indexOf: oldObject.
    self incrementLastIndex.
    self shiftFrom: index + 1 by: 1.
    ^self at: index + 1 put: newObject
!

add: newObject before: oldObject
    "Add newObject before oldObject"
    | index |
    index := self indexOf: oldObject.
    self incrementLastIndex.
    self shiftFrom: index by: 1.
    ^self at: index put: newObject
!

addAllFirst: aSequenceableCollection
    "Add the given collection at the beginning of the receiver"
    | size |
    size := aSequenceableCollection size.
    self incrementLastIndex: size.
    self shiftFrom: 1 by: size.
    aSequenceableCollection from: 1 to: size keysAndValuesDo: [ :i :ea |
        self at: i put: ea ].
    ^aSequenceableCollection
!

addAllLast: aSequenceableCollection
    "Add the given collection at the end of the receiver"
    | size |
    size := self size.
    self incrementLastIndex: aSequenceableCollection size.
    aSequenceableCollection from: 1 to: aSequenceableCollection size keysAndValuesDo: [ :i :ea |
        self at: i + size put: ea ].
    ^aSequenceableCollection
!

addFirst: anObject
    "Add anObject at the beginning of the receiver"
    self incrementLastIndex.
    self shiftFrom: 1 by: 1.
    ^self at: 1 put: anObject
!

addLast: newObject
    "Add anObject at the end of the receiver"
    ^self add: newObject
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
! !

!OrderedCollection methodsFor: 'removing'!

remove: anObject ifAbsent: aBlock
    ^self removeAtIndex:
        (self indexOf: anObject startingAt: 1 ifAbsent: [ ^aBlock value ])
!

removeAtIndex: anIndex
    | answer |
    self size = 0
        ifTrue: [ ^nil ].

    answer := self at: anIndex.
    
    anIndex = 1
	ifTrue: [ firstIndex := firstIndex + 1. ^answer ].
    anIndex = self size
	ifTrue: [ lastIndex := lastIndex - 1. ^answer ].

    anIndex + firstIndex - 1 to: (lastIndex := lastIndex - 1) do: [ :index |
	self basicAt: index put: (self basicAt: index + 1) ].
    ^answer
!

removeFirst
    self removeAtIndex: 1
!

removeLast
    self removeAtIndex: self size
! !

!OrderedCollection methodsFor: 'converting'!

asOrderedCollection
    ^self
!

asArray
    ^Array withAll: self startingAt: firstIndex
! !

!OrderedCollection methodsFor: 'testing'!

isOrderedCollection
    ^true
! !
