!Process class methodsFor: 'instance creation'!

on: aContext
    ^self new context: aContext; initialize; yourself
! !

!Process methodsFor: 'execution'!

initialize
    self suspend
!

context
    ^context
!

context: aContext
    context := aContext
!

suspend
    <primitive: 'Process_suspend'>
	self primitiveFailed
!

resume
    <primitive: 'Process_resume'>
	self primitiveFailed
!

terminate
    thisContext leaveTo: nil andAnswer: nil
! !

!Process methodsFor: 'testing'!

isActive
    ^self == Processor activeProcess
! !
