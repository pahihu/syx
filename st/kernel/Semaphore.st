!Semaphore class methodsFor: 'instance creation'!

new
    "Answer a new semaphore"
    ^super basicNew initialize
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
    signals := 0.
    waitingProcesses := Array new
! !

!Semaphore methodsFor: 'accessing'!

waitingProcesses
    ^waitingProcesses
!

signals
    ^signals - waitingProcesses size
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
