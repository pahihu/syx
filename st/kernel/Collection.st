!Collection class methodsFor: 'instance creation'!

new
    ^self new: 0
!

with: anObject
    "Answer a collection whose only element is anObject"
    ^self new add: anObject; yourself
!
 
with: firstObject with: secondObject
    "Answer a collection whose only elements are the parameters in the order
     they were passed"
    ^self new add: firstObject; add: secondObject; yourself
! !

!Collection methodsFor: 'indexable fields'!

add: anObject
    self subclassResponsibility
!

do: aBlock
    "Enumerate each object of thonly element is anObject"
    ^self new add: anObject; yourself
!
 
with: firstObject with: secondObject
    "Answer a collection whose only elements are the parameters in the order
     they were passed"
    ^self new add: firstObject; add: secondObject; yourself
! !

!Collection methodsFor: 'indexable fields'!

add: anObject
    self subclassResponsibility
!

do: aBlock
    "Enumerate each object of the receiver, passing them to aBlock"
    self subclassResponsibility
!

first
    ^self at: 1
!

last
    ^self at: self size
!

size
    "Answer how many objects we include"
    | count |
    count := 0.
    self do: [ :element | count := count + 1].
    ^count
! !

!Collection methodsFor: 'copying'!

copyEmpty: newSize
    "Answer an empty copy of the receiver whose size is newSize"
    ^self species new: newSize
! !
