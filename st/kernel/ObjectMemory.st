"
Copyright (c) 2007-2008 Luca Bruno

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

!ObjectMemory class methodsFor: 'image'!

garbageCollect
    <primitive: 'ObjectMemory_garbageCollect'>
	self primitiveFailed
!

snapshot: aFilename
    (aFilename notNil and: [ aFilename isString not ])
	ifTrue: [ ^'Cant save the image' printNl ]
	ifFalse: [ Smalltalk at: #ImageFileName put: aFilename ].
    self primSnapshot: aFilename
!

snapshot
    self snapshot: ImageFileName
! !

!ObjectMemory class methodsFor: 'private'!

atData: destObject put: sourceObject
    <primitive: 'ObjectMemory_atDataPut'>
	self primitiveFailed
!

setConstant: anObject
    <primitive: 'ObjectMemory_setConstant'>
	self primitiveFailed
!

primSnapshot: aFilename
    <primitive: 'ObjectMemory_snapshot'>
	self primitiveFailed
! !
