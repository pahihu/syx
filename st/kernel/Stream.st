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

!Stream class methodsFor: 'instance creation'!

new
    ^self basicNew initialize
! !

!Stream methodsFor: 'initialize-release'!

initialize
    self allowReadOnly
! !

!Stream methodsFor: 'accessing'!

allowReadOnly
    accessMode := 0
!

allowReadAndWrite
    accessMode := 1
!

allowWriteOnly
    accessMode := 2
!

canRead
    ^accessMode <= 1
!

canWrite
    ^accessMode >= 1
!

ensureReadable
    self canRead
	ifFalse: [ ^self error: 'the stream is not readable' ]
!

ensureWriteable
    self canWrite
	ifFalse: [ ^self error: 'the stream is not writeable' ]
!

next
    self subclassResponsibility
!

next: amount
    "Returns a collection with the given number of objects next in the stream"
    | i stream |
    self ensureReadable.
    stream := WriteStream on: (self collectionClass new: amount).
    1 to: amount do: [ :i |
	stream nextPut: self next ].
    ^stream contents
!

peek
    self subclassResponsibility
!

contents
    self subclassResponsibility
!

upToEnd
    "Answer the contents of the stream from current position"
    | stream |
    stream := WriteStream on: (self collectionClass new: 10).
    self do: [ :ea | stream nextPut: ea ].
    ^stream contents
!

nextPut: anObject   
    "Write anObject to the receiver"
    self subclassResponsibility
!

nextPutAll: aCollection
    "Write all the objects in aCollection to the receiver"
    self ensureWriteable.
    aCollection do: [ :element | self nextPut: element ].
    ^aCollection
! !

!Stream methodsFor: 'testing'!

isPositionable
    ^false
!

isEmpty
    self subclassResponsibility
!

atEnd
    "Return true if I'm at the end"
    self subclassResponsibility
! !

!Stream methodsFor: 'enumerating'!

do: aBlock
    "Call a block for each element of the stream from the current position, until the end."
    [ self atEnd ] whileFalse:
        [ aBlock value: self next ]

! !

!Stream methodsFor: 'private'!

collectionClass
    "Answer the collection class that's used to return the contents of the stream"
    ^Array
! !

!Stream methodsFor: 'basic'!

close
    ^self
!

nl
    "Write a new line"
    self nextPut: Character nl
!

tab
    "Write a tab character"
    self nextPut: Character tab
!

cr 
    "Write a carriage return"
    self nextPut: Character cr
!

space
    "Write a space character"
    self nextPut: Character space
! !

!Stream methodsFor: 'shortcuts'!

store: anObject
    "Store a String representation from which anObject can be reconstructed"
    anObject storeOn: self
!

print: anObject
    "Print a String representation of anObject"
    anObject printOn: self
! !
