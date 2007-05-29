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

add: anObject
    self shouldNotImplement
!

, aSequenceableCollection
    "Answer a new instance of an ArrayedCollection containing all the elements
     in the receiver, followed by all the elements in aSequenceableCollection"
    ^(self copyEmpty: (self size + aSequenceableCollection size))
	replaceFrom: 1 with: self;
	replaceFrom: self size + 1 with: aSequenceableCollection;
	yourself
!

size
    <primitive: 'Object_size'>
	self primitiveFailed
! !
