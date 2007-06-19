!ObjectMemory class methodsFor: 'image'!

garbageCollect
    <primitive: 'ObjectMemory_garbageCollect'>
	self primitiveFailed
!

snapshot: aFilename
    <primitive: 'ObjectMemory_snapshot'>
	self primitiveFailed
!

snapshot
    self snapshot: ImageFileName
! !
