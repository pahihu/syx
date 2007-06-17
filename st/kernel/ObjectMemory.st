!ObjectMemory class methodsFor: 'image'!

indexOf: anOop
    <primitive: 'ObjectMemory_indexOf'>
	self primitiveFailed
!

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
