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
    
on: aFD
    ^self basicNew fd: aFD
!

open: aFilename
    ^self open: aFilename for: self read
!

open: aFilename for: aMode
    | inst |
    inst := self basicNew fd: (self fileOp: 0 with: aFilename with: aMode).
    aMode
	caseOf: {
	    [ self read ] -> [ inst allowReadOnly ].
	    [ self write ] -> [ inst allowWriteOnly ].
	    [ self readWrite ] -> [ inst allowReadAndWrite ] }.
    ^inst
!

fileOp: anInteger with: anArgument with: anotherArgument
    "Returns a file descriptor"
    <primitive: 'FileStream_fileOp'>
	self primitiveFailed
!

fileIn: aFilename
    ^(self open: aFilename) fileIn; yourself
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
    primSize := self fileOp: 7 on: fd.
    ^primSize max: endPos
!    

atEnd
    ^self size = curPos
!

fileIn
    | stream lexer parser method context |
    stream := ReadWriteStream with: 'doFileIn ' copy.
    stream
	nextPutAll: self contents;
	reset.
    lexer := CompilerLexer readFrom: stream.
    parser := CompilerParser on: lexer for: nil class.
    parser parse.
    method := CompiledMethod fromParser: parser.
    context := MethodContext on: method parent: thisContext receiver: nil arguments: #().
    Processor enter: context
!

fd: aFD
    fd := aFD.
    collection := String new: 10.
    curPos := endPos := 0
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
    self fileOp: 1 on: fd
!

nextPut: aCharacter
    self ensureWriteable.
    self fileOp: 2 on: fd with: aCharacter.
"    self nextPutBuffer: aCharacter asString"
!

nextPutAll: aByteArray
    self ensureWriteable.
    self fileOp: 3 on: fd with: aByteArray.
"    self nextPutBuffer: aByteArray"
!

flush
    self fileOp: 4 on: fd
!

next
    | c |
    self ensureReadable.
    c := self fileOp: 5 on: fd.
    self nextPutBuffer: c asString.
    ^c
!

next: numBytes
    | s |
    self ensureReadable.
    s := self fileOp: 6 on: fd with: numBytes.
    self nextPutBuffer: s.
    ^s
! !
