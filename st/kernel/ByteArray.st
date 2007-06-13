!ByteArray class methodsFor: 'instance creation'!

new: size
    <primitive: 'ByteArray_newColon'>
	self primitiveFailed
!

basicNew: size
    <primitive: 'ByteArray_newColon'>
	self primitiveFailed
! !

!ByteArray methodsFor: 'accessing'!

at: anIndex
    <primitive: 'ByteArray_at'>
	self primitiveFailed
!

at: anIndex put: aCharacter
    <primitive: 'ByteArray_at_put'>
	self primitiveFailed
!

basicAt: anIndex
    <primitive: 'ByteArray_at'>
	self primitiveFailed
!

basicAt: anIndex put: aCharacter
    <primitive: 'ByteArray_at_put'>
	self primitiveFailed
! !
