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

with: anObject
    "Create a collection with a single element"
    ^(self new: 1)
        at: 1 put: anObject;
        yourself
!

with: firstObject with: secondObject
    "Create a collection with the two given elements"
    ^(self new: 2)
        at: 1 put: firstObject;
        at: 2 put: secondObject;
        yourself
!

withAll: aCollection
    "Answer an arrayed collection with the same elements of aCollection"
    ^(self new: aCollection size)
	replaceFrom: 1 to: aCollection size with: aCollection;
	yourself
! !

!ArrayedCollection methodsFor: 'basic'!

add: anObject
    self shouldNotImplement
!

copyFrom: startIndex to: stopIndex
    stopIndex < startIndex ifTrue: [ ^self copyEmpty: 0 ].
    ^(self copyEmpty: stopIndex)
	replaceFrom: startIndex to: stopIndex with: self;
	yourself
!

replaceFrom: startIndex to: stopIndex with: aCollection
    <primitive: 'ArrayedCollection_replaceFromToWith'>
	^super replaceFrom: startIndex to: stopIndex with: aCollection
! !
