!Semaphore class methodsFor: 'instance creation'!

new
    "Answer a new semaphore"
    ^super new initialize
!

forMutualExclusion
    "Answer a new semaphore with a signal on it. These semaphores are a useful
     shortcut when you use semaphores as critical sections."
    ^self new
        signal;
        yourself
! !

!Semaphore methodsFor: 'mutual exclusion'!

critical: aBlock  
    "Wait for the receiver to be free, execute aBlock and signal the receiver 
     again. Return the result of evaluating aBlock."
    self wait.
    ^aBlock ensure: [ self signal ]
! !

!Semaphore methodsFor: 'initialize-release'! 

initialize
    signals := 0
! !

!Semaphore methodsFor: 'accessing'!

signals
    ^signals
! !

!Semaphore methodsFor: 'basic'!

signal
    <primitive: 'Semaphore_signal'>
	self primitiveFailed
!

wait
    <primitive: 'Semaphore_wait'>
	self primitiveFailed
! !
