!Stack class methodsFor: 'instance creation'!

new
    ^self basicNew initialize
! !

!Stack methodsFor: 'initialize-release'!

initialize
    collection := OrderedCollection new.
    top := 0.
!

push: anObject
    (top := top + 1) > collection size
	ifTrue: [ collection growTo: top + 10 ].
    ^collection at: top put: anObject
!

pop
    | ret |
    top = 0
	ifTrue: [ ^self error: 'Stack is empty' ].
    ret := collection at: top.
    top := top - 1.
    ^ret
!

peek
    top = 0
	ifTrue: [ ^self error: 'Stack is empty' ].
    ^collection at: top
!

peekPut: anObject
    top = 0
	ifTrue: [ ^self error: 'Stack is empty' ].
    ^collection at: top put: anObject
!

contents
    ^collection copyFrom: 1 to: top
! !
