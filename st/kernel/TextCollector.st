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
       instanceVariableNames: 'proxyReceiver proxySelector'
       classVariableNames: ''!


!TextCollector class methodsFor: 'instance creation'! 
   
new
    self shouldNotImplement
!

proxyMessage: anAssociation
    "Specify an association of receiver -> selector, to be performed when writing to the TextCollector"
    ^self basicNew proxyMessage: anAssociation; yourself
! !

!TextCollector methodsFor: 'set up'!

proxyMessage
    "Answer the receiver -> selector association being used to write to the TextCollector"
    ^proxyReceiver -> proxySelector
!

proxyMessage: anAssociation
    "Set the association receiver -> selector, to be performed when writing to the TextCollector"
    proxyReceiver := anAssociation key.
    proxySelector := anAssociation value
! !

!TextCollector methodsFor: 'accessing'!

cr
    "Write a new line to the receiver"
    self nl
!

nextPut: aCharacter
    "Write aCharacter to the receiver"
    proxyReceiver nextPut: aCharacter
!

nextPutAll: aString
    "Write aString to the receiver"
    proxyReceiver nextPutAll: aString
!

show: aString
    "Write aString to the receiver"
    self nextPutAll: aString
!

showCr: aString
    "Write aString to the receiver followed by a new line"
    self nextPutAll: aString; cr
! !
