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
    "Answer a collection whose only element is anObject"
    ^self new add: anObject; yourself
!
 
with: firstObject with: secondObject
    "Answer a collection whose only elements are the parameters in the order
     they were passed"
    ^self new add: firstObject; add: secondObject; yourself
! !

!Collection methodsFor: 'indexable fields'!

add: anObject
    self subclassResponsibility
!

do: aBlock
    "Enumerate each object of thonly element is anObject"
    self subclassResponsibility
!
 
with: firstObject with: secondObject
    "Answer a collection whose only elements are the parameters in the order
     they were passed"
    ^self new add: firstObject; add: secondObject; yourself
! !

!Collection methodsFor: 'indexable fields'!

add: anObject
    self subclassResponsibility
!

do: aBlock
    "Enumerate each object of the receiver, passing them to aBlock"
    self subclassResponsibility
!

first
    ^self at: 1
!

last
    ^self at: self size
!

size
    "Answer how many objects we include"
    | count |
    count := 0.
    self do: [ :element | count := count + 1].
    ^count
! !

!Collection methodsFor: 'copying'!

copyEmpty: newSize
    "Answer an empty copy of the receiver whose size is newSize"
    ^self species new: newSize
! !
