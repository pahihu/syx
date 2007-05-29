!ProcessorScheduler methodsFor: 'accessing'!

addProcess: aProcess
    ^self
!

processList
    ^processList
!

processTimeSlice
    ^processTimeslice
!

processTimeslice: anInteger
    processTimeslice: anInteger
!

activeProcess
    <primitive: 'Processor_activeProcess'>
	^self primitiveFailed
! !
