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

!Collection class methodsFor: 'instance creation'!

new
    ^self new: 0
!

with: anObject
    "Answer a collection with a single element"
    ^self new add: anObject; yourself
!
 
with: firstObject with: secondObject
    "Answer a collection with the two given objects"
    ^self new add: firstObject; add: secondObject; yourself
!

withAll: aCollection
    "Create a collection whose elements are the same of aCollection"
    ^self new addAll: aCollection
! !

!Collection methodsFor: 'indexable fields'!

add: anObject
    self subclassResponsibility
!

addAll: aCollection
    aCollection do: [ :ea |
	self add: ea ]
!

do: aBlock
    "Call aBlock for each element of the collection"
    self subclassResponsibility
!

first
    ^self at: 1
!

last
    ^self at: self size
!

size
    | count |
    count := 0.
    self do: [ :element | count := count + 1].
    ^count
! !

!Collection methodsFor: 'copying'!

copyEmpty: newSize
    "Create the empty collection of the given size"
    ^self class new: newSize
! !

!Collection methodsFor: 'converting'!

asOrderedCollection
    ^OrderedCollection withAll: self
! !
