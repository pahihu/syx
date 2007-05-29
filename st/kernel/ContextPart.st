!ContextPart class methodsFor: 'instance creation'!

on: aMethod parent: aContext arguments: anArray
    ^self new
	parent: aContext;
	yourself
! !

!ContextPart methodsFor: 'initialize-release'!

initialize

! !

!ContextPart methodsFor: 'execution'!

enter: aContext
    <primitive: 'Context_enter'>
	^self primitiveFailed
!

swapWith: aContext
    <primitive: 'Context_swapWith'>
	^self primitiveFailed
!

returnTo: aContext andAnswer: anObject
    <primitive: 'Context_returnTo_andAnswer'>
	^self primitiveFailed
! !

!ContextPart methodsFor: 'accessing'!

parent
    <primitive: 'Context_parent'>
	self primitiveFailed
!

parent: aContextPart
    <primitive: 'Context_parent_'>
	self primitiveFailed
! !