!FileStream class methodsFor: 'instance creation'!

new
    self shouldNotImplement
!

on: aFD
    ^self fromFD: anInteger
!

fromFD: anInteger
    <primitive: 'FileStream_new'>
	self primitiveFailed
!

open: aFilename
    ^self open: aFilename for: self readWrite
!

open: aFilename for: aMode
    <primitive: 'FileStream_newFile'>
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

!FileStream methodsFor: 'basic'!

close
    self shutdown: true
!

shutdown: aBoolean
    <primitive: 'FileStream_shutdown'>
	self primitiveFailed
!

primAddWatchForInput: aSemaphore
    <primitive: 'FileStream_addWatchForInput'>
	self primitiveFailed
!

primAddWatchForOutput: aSemaphore
    <primitive: 'FileStream_addWatchForOutput'>
	self primitiveFailed
!

waitForInput
    | sem |
    sem := Semaphore new.
    self primAddWatchForInput: sem.
    sem wait.
!

waitForOutput
    | sem |
    sem := Semaphore new.
    self primAddWatchForOutput: sem.
    sem wait.
!

readChar
    <primitive: 'FileStream_readChar'>
	self primitiveFailed
!

writeChar: aCharacter
    <primitive: 'FileStream_writeChar'>
	self primitiveFailed
!

flush
    <primitive: 'FileStream_flush'>
	self primitiveFailed
!

next
    self waitForInput.
    ^self readChar
!

nextPut: aCharacter
    self waitForOutput.
    self writeChar: aCharacter
!

name
    ^name
! !
