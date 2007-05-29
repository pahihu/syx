!OrderedCollection methodsFor: 'basic'!

add: anObject
    <primitive: 'Object_add'>
	self primitiveFailed
!

addAll: aCollection
    aCollection do: [:ea |
	self add: ea]
!

remove: anObject ifAbsent: aBlock
    "Remove anObject from the receiver. If it can't be found, answer the
     result of evaluating aBlock"

    ^self removeAtIndex:
        (self indexOf: anObject startingAt: 1 ifAbsent: [ ^aBlock value ])
!

removeAtIndex: anIndex
    <primitive: 'Object_removeAtIndex'>
	self primitiveFailed
! !
