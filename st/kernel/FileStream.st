!FileStream class methodsFor: 'instance creation'!

new
    self shouldNotImplement
!
    
on: aFD
    ^self basicNew fd: aFD
!

open: aFilename
    ^self basicNew fd: (self fileOp: 0 with: aFilename with: self readWrite)
!

open: aFilename for: aMode
    ^self basicNew fd: (self fileOp: 0 with: aFilename with: aMode)
!

fileOp: anInteger with: anArgument with: anotherArgument
    "Returns a file descriptor"
    <primitive: 'FileStream_fileOp'>
	self primitiveFailed
!

write
    ^'w'
!

read
    ^'r'
!

readWrite
    ^'r+'
! !

!FileStream methodsFor: 'accessing'!

fd: aFD
    fd := aFD
!

fd
    ^fd
! !

!FileStream methodsFor: 'primitives'!

fileOp: anInteger on: aFD
    <primitive: 'FileStream_fileOp'>
	self primitiveFailed
!

fileOp: anInteger on: aFD with: anArgument
    <primitive: 'FileStream_fileOp'>
	self primitiveFailed
! !

!FileStream methodsFor: 'basic'!

close
    self fileOp: 1 on: fd
!

nextPut: aCharacter
    self fileOp: 2 on: fd with: aCharacter
!

nextPutAll: aString
    self fileOp: 3 on: fd with: aString
!

flush
    self fileOp: 4 on: fd
!

next
    ^self fileOp: 5 on: fd
!

nextAll: numBytes
    ^self fileOp: 6 on: fd with: numBytes
! !
