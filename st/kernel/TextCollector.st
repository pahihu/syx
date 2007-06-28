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

Stream subclass: #TextCollector
       instanceVariableNames: 'receiver selector'
       classVariableNames: ''!


!TextCollector class methodsFor: 'instance creation'! 
   
new
    self shouldNotImplement
!

message: receiverToSelectorAssociation
    "Answer a new instance of the receiver, that uses the message identified
     by anAssociation to perform write operations.  anAssociation's
     key is the receiver, while its value is the selector."
    ^self basicNew message: receiverToSelectorAssociation; yourself
! !

!TextCollector methodsFor: 'set up'!

message
    "Answer an association representing the message to be sent
    to perform write operations.  The key is the receiver, the value is the
    selector"
    ^receiver -> selector
!

message: receiverToSelectorAssociation
    "Set the message to be sent to perform write operations
     to the one represented by anAssociation.  anAssociation's key is the
     receiver, while its value is the selector"
    receiver := receiverToSelectorAssociation key.
    selector := receiverToSelectorAssociation value
! !

!TextCollector methodsFor: 'accessing'!

cr
    "Emit a new-line (carriage return) to the Transcript"
    self nl
!

nextPut: aCharacter
    receiver nextPut: aCharacter
!

nextPutAll: aString
    "Write aString to the Transcript"
    receiver nextPutAll: aString
    "self primNextPutAll: aString.  "
!

show: aString
    "Write aString to the Transcript"
    self nextPutAll: aString
!

showCr: aString
    self nextPutAll: aString; cr
! !
