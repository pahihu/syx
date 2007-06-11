!ContextPart class methodsFor: 'instance creation'!

on: aMethod parent: aContext arguments: anArray
    ^self new
	method: aMethod
	parent: aContext
	arguments: anArray;
	yourself
! !

!ContextPart methodsFor: 'initialize-release'!

initialize

! !

!ContextPart methodsFor: 'accessing'!

method
    ^method
!

method: aMethod parent: aContext arguments: anArray
    "if method is set then this context has been initialized"
    method notNil ifTrue: [^self].

    method := aMethod.
    parent := aContext.
    arguments := anArray, (Array new: method argumentsCount - anArray size).
    temporaries := Array new: method temporariesCount.
    ip := sp := 0.
    stack := Array new: method stackSize.
    returnContext := parent.
!

receiver
    ^receiver
!

parent: aContext
    parent := aContext
!

parent
    ^parent
! !
