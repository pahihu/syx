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
    "Raises a signal. If it's not handled, debug the process"
    signalerContext := thisContext.
    handlerContext := self findHandlerContext.
    handlerContext isNil
	ifTrue: ['Unhandled exception... process is going to be terminated' printNl.
		 signalerContext traceback.
		 Processor activeProcess terminate]
	ifFalse: [self return: (handlerContext handlerBlock value: self)]
!

pass
    thisContext parent: handlerContext parent.
    self signal
!

resume
    Processor swapWith: signalerContext parent
!

return: anObject
    Processor leaveTo: handlerContext parent andAnswer: anObject
!

return
    self return: nil
! !
