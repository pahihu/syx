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

!SequenceableCollection methodsFor: 'concatenating'!

, aSequenceableCollection
    "Concatenate self to aSequenceableCollection"
    ^(self copyEmpty: self size + aSequenceableCollection size)
	replaceFrom: 1 with: self;
	replaceFrom: self size + 1 with: aSequenceableCollection;
	yourself
! !

!SequenceableCollection methodsFor: 'copying'!

copyFrom: startIndex to: stopIndex
    "Answer a collection which is a copy of the receiver, with the elements from startIndex to stopIndex"
    | coll |
    coll := self copyEmpty: 0.
    self from: startIndex to: stopIndex do: [ :ea | coll add: ea ].
    ^coll
!

copyWith: newElement
    "Answer a collection which is a copy of the receiver, and adds a newElement at the end"
    | coll |
    coll := self class withAll: self.
    ^coll add: newElement; yourself
! !

!SequenceableCollection methodsFor: 'replacing'!

replaceFrom: startIndex with: aCollection
    "Replace items from startIndex to aCollection's size with the elements of aCollection."
    self replaceFrom: startIndex to: aCollection size with: aCollection
!

replaceFrom: startIndex to: stopIndex with: aCollection
    "Replace items from startIndex to stopIndex with the elements of aCollection"
    | j |
    j := 0.
    startIndex to: (stopIndex min: aCollection size) do: [ :i |
	self at: i put: (aCollection at: (j := j + 1)) ]
! !

!SequenceableCollection methodsFor: 'enumerating'!

first
    ^self at: 1
!

second
    ^self at: 2
!

third
    ^self at: 3
!

fourth
    ^self at: 4
!

last
    ^self at: self size
!

after: anObject
    "Answer the object that follows anObject in the collection"
    1 to: self size do: [ :i |
	((self at: i) = anObject)
	    ifTrue: [ ^self at: i + 1 ] ].
    NotFound signal
!

before: anObject
    "Answer the object that's before anObject in the collection"
    1 to: self size do: [ :i |
	((self at: i) = anObject)
	    ifTrue: [ ^self at: i - 1 ] ].
    NotFound signal
!

from: startIndex to: stopIndex do: aBlock
    "Call aBlock for each element from startIndex to stopIndex"
    startIndex to: stopIndex do: [ :i | aBlock value: (self at: i) ]
!

do: aBlock
    "Call aBlock for each element of the collection"
    self from: 1 to: self size do: aBlock
! !

!SequenceableCollection methodsFor: 'basic'!

at: anIndex
    <primitive: 'Object_at'>
	self primitiveFailed
!

at: anIndex put: anObject
    <primitive: 'Object_at_put'>
	self primitiveFailed
!

at: anIndex ifAbsent: exceptionBlock
    [ self at: anIndex ]
	on: Error do: exceptionBlock
!

size
    ^self basicSize
!

indexOf: anElement ifAbsent: exceptionBlock
    ^self indexOf: anElement startingAt: 1 ifAbsent: exceptionBlock
!

indexOf: anElement startingAt: anIndex ifAbsent: exceptionBlock
    "Answer the position of anElement in the collection.
     Searches for it starting from the given index."
    anIndex to: self size do: [ :i |
        (self at: i) == anElement ifTrue: [ ^i ].
    ].
    ^exceptionBlock value
!

= aCollection
    "Answer if the receiver is equivalent to aCollection"
    self class = aCollection class
	ifFalse: [ ^false ].

    self size = aCollection size
	ifFalse: [ ^false ].

    1 to: self size do: [ :i |
	(self at: i) = (aCollection at: i)
	    ifFalse: [ ^false ] ].
    ^true
! !
