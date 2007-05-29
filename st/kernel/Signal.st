!Signal class methodsFor: 'instance creation'!

signal
    self new signal
! !

!Signal methodsFor: 'signaling'!

findHandlerContext
    "Finds the context which handles the exception"
    <primitive: 'Signal_findHandlerContext'>
	self primitiveFailed
!

signal
    signalerContext := thisContext.
    handlerContext := self findHandlerContext.
    handlerContext isNil
	ifTrue: ['Unhandled exception... process is being debugged?' print.
		 signalerContext parent parent parent method selector print]
	ifFalse: [self return: (handlerContext handlerBlock value: self)]
!

pass
    thisContext parent: handlerContext parent.
    self signal
!

resume
    thisContext swapWith: signalerContext parent
!

return: anObject
    thisContext returnTo: handlerContext parent andAnswer: anObject
!

return
    self return: nil
! !
