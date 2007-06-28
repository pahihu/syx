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

!ArrayedCollection class methodsFor: 'instance creation'!

new: size withAll: anObject 
    "Answer a collection with the given size, whose elements are all set to
     anObject"
    ^(self new: size) atAllPut: anObject; yourself
!

withAll: aCollection  
    "Answer a collection whose elements are the same as those in aCollection"
    | anArrayedCollection index |
    anArrayedCollection := self new: aCollection size.
    index := 1.
    aCollection do: [ :each |
        anArrayedCollection at: index put: each.
        index := index + 1
    ].
    ^anArrayedCollection
!

with: element1
    "Answer a collection whose only element is element1"
    
    ^(self new: 1)
        at: 1 put: element1;
        yourself
!

with: element1 with: element2
    "Answer a collection whose only elements are the parameters in the order
     they were passed"
    
    ^(self new: 2)
        at: 1 put: element1;
        at: 2 put: element2;
        yourself
! !

!ArrayedCollection methodsFor: 'basic'!

at: anIndex
    <primitive: 'Object_at'>
	self primitiveFailed
!

at: anIndex put: anObject
    <primitive: 'Object_at_put'>
	self primitiveFailed
!

size
    ^self basicSize
!

add: anObject
    self shouldNotImplement
!

copyFrom: start to: stop
    stop < start ifTrue: [^self copyEmpty: 0].
    ^(self copyEmpty: stop)
	replaceFrom: start to: stop with: self;
	yourself
!

replaceFrom: start to: stop with: replacementCollection
    <primitive: 'ArrayedCollection_replaceFromToWith'>

    ^super replaceFrom: start to: stop with: replacementCollection
! !
