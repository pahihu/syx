!ProcessorScheduler methodsFor: 'interpreter'!

yield
    <primitive: 'Processor_yield'>
	self primitiveFailed
!

enter: aContext
    <primitive: 'Processor_enter'>
	self primitiveFailed
!

swapWith: aContext
    <primitive: 'Processor_swapWith'>
	self primitiveFailed
!

leaveTo: aContext andAnswer: anObject
    <primitive: 'Processor_leaveTo_andAnswer'>
	self primitiveFailed
! !

!ProcessorScheduler methodsFor: 'accessing'!

processByteslice
    ^processByteslice
!

processByteslice: anInteger
    processByteslice: anInteger
!

activeProcess
	^activeProcess
! !
