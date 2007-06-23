!ArrayedCollection class methodsFor: 'instance creation'!

new: size withAll: anObject 
    "Answer a collection with the given size, whose elements are all set to
     anObject"
    ^(self new: size) atAllPut: anObject; yourself
!

withAll: aCollection  
    "Answer a collection whose elements are the same as those in aCollection"
    | anArrayedCollection index |
    anArrayedCollection := self new: aCollection size.
    index := 1.
    aCollection do: [ :each |
        anArrayedCollection at: index put: each.
        index := index + 1
    ].
    ^anArrayedCollection
!

with: element1
    "Answer a collection whose only element is element1"
    
    ^(self new: 1)
        at: 1 put: element1;
        yourself
!

with: element1 with: element2
    "Answer a collection whose only elements are the parameters in the order
     they were passed"
    
    ^(self new: 2)
        at: 1 put: element1;
        at: 2 put: element2;
        yourself
! !

!ArrayedCollection methodsFor: 'basic'!

at: anIndex
    <primitive: 'Object_at'>
	self primitiveFailed
!

at: anIndex put: anObject
    <primitive: 'Object_at_put'>
	self primitiveFailed
!

size
    ^self basicSize
!

add: anObject
    self shouldNotImplement
!

copyFrom: start to: stop
    stop < start ifTrue: [^self copyEmpty: 0].
    ^(self copyEmpty: stop)
	replaceFrom: start to: stop with: self;
	yourself
!

replaceFrom: start to: stop with: replacementCollection
    <primitive: 'ArrayedCollection_replaceFromToWith'>

    ^super replaceFrom: start to: stop with: replacementCollection
! !
