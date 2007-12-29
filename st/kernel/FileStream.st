"
Copyright (c) 2007 Luca Bruno

This file is part of Smalltalk YX.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the 'Software'), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.
"

!FileStream class methodsFor: 'instance creation'!

new
    self shouldNotImplement
!
    
on: aFD for: aMode
    ^self basicNew initializeHandle: (self fileOp: 8 with: aFD with: aMode) for: aMode
!

open: aFilename
    ^self open: aFilename for: self read
!

open: aFilename for: aMode
    ^self basicNew initializeHandle: (self fileOp: 0 with: aFilename with: aMode) for: aMode
!

fileOp: anInteger with: anArgument with: anotherArgument
    "Returns a FILE* handle"
    <primitive: 'FileStream_fileOp'>
	self primitiveFailed
!

fileIn: aFilename
    ^(self open: aFilename) fileIn; yourself
!

append
    ^'a'
!

write
    ^'w'
!

read
    ^'r'
!

readWrite
    ^'r+'
!

readWriteCreate
    ^'w+'
! !


!FileStream methodsFor: 'initialize-release'!

initialize
    super initialize.
    collection := String new: 10.
    curPos := endPos := 0
!

initializeHandle: aFilePointer for: aMode
    self initialize.
    handle := aFilePointer.
    aMode
	caseOf: {
	    [ self class append ] -> [ self allowWriteOnly ].
	    [ self class read ] -> [ self allowReadOnly ].
	    [ self class write ] -> [ self allowWriteOnly ].
	    [ self class readWrite ] -> [ self allowReadAndWrite ].
	    [ self class readWriteCreate ] -> [ self allowReadAndWrite ] }
! !

!FileStream methodsFor: 'accessing'!

contents
    | pos ret |
    pos := curPos.
    self reset.
    ret := self upToEnd.
    self position: pos.
    ^ret
!

upToEnd
    ^self next: (self size - curPos)
!

size
    | primSize |
    primSize := self fileOp: 7 on: handle.
    ^primSize max: endPos
!    

atEnd
    ^self size = curPos
!

fileIn
    | stream lexer parser method context peek |
    stream := ReadWriteStream with: String new.
    peek := self next.
    peek = $#
	ifTrue: [ self skipTo: Character nl ]
	ifFalse: [ stream nextPut: peek ].
    stream
	nextPutAll: self upToEnd;
	reset.
    lexer := CompilerLexer readFrom: stream.
    parser := CompilerParser on: lexer for: nil class.
    parser runMultipleAndDeclarations
! !

!FileStream methodsFor: 'primitives'!

fileOp: anInteger on: fileHandle
    <primitive: 'FileStream_fileOp'>
	self primitiveFailed
!

fileOp: anInteger on: fileHandle with: anArgument
    <primitive: 'FileStream_fileOp'>
	self primitiveFailed
! !

!FileStream methodsFor: 'private'!

nextPutBuffer: aByteArray
    | pos |
    pos := curPos + 1.
    curPos := curPos + aByteArray size.
    super atEnd
	ifTrue: [ (endPos := curPos) >= collection size
		      ifTrue: [ collection growTo: endPos + 10 ] ].
    ^collection replaceFrom: pos to: curPos with: aByteArray
! !

!FileStream methodsFor: 'basic'!

close
    self fileOp: 1 on: handle.
    handle := nil
!

nextPut: aCharacter
    self ensureWriteable.
    self fileOp: 2 on: handle with: aCharacter.
    self nextPutBuffer: aCharacter asString
!

nextPutAll: aByteArray
    self ensureWriteable.
    self fileOp: 3 on: handle with: aByteArray.
    self nextPutBuffer: aByteArray
!

flush
    self fileOp: 4 on: handle
!

next
    | c |
    self ensureReadable.
    c := self fileOp: 5 on: handle.
    self nextPutBuffer: c asString.
    ^c
!

next: numBytes
    | s |
    self ensureReadable.
    s := self fileOp: 6 on: handle with: numBytes.
    self nextPutBuffer: s.
    ^s
! !

!StdIOStream methodsFor: 'basic'!

upToEnd
    | w |
    w := WriteStream on: String new.
    [ w nextPut: self next ] repeat.
    ^w contents
!

nextPut: aCharacter
    <primitive: 'StdIOStream_nextPut'>
        self primitiveFailed
!

nextPutAll: aString
    <primitive: 'StdIOStream_nextPutAll'>
        self primitiveFailed
!

nextPutBuffer: aString
! !
