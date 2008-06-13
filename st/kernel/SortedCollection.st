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

!SortedCollection class methodsFor: 'instance creation'!

sortBlock: aBlock
        ^(self basicNew: 0) sortBlock: aBlock; yourself
!

new
        ^self sortBlock: [ :a :b | a <= b ]
! !

!SortedCollection methodsFor: 'accessing'!

sortBlock
        ^sortBlock
!

sortBlock: aBlock
    | c |
    sortBlock := aBlock.
    "Do an insertion sort"
    2 to: self size do: [ :i |
        | x j |
        x := self at: i.
        j := i - 1.
        [ j >= 1 and: [ sortBlock value: x value: (self at: j) ] ]
            whileTrue: [
                self at: j + 1 put: (self at: j).
                j := j - 1  ].
        self at: j + 1 put: x ]
! !

!SortedCollection methodsFor: 'basic'!

indexOf: anObject
    | low high pos |
    low := pos := 0.
    high := self size - 1.
    "Find the right position with binary search"
    [ low <= high ]
        whileTrue: [ pos := (low + high) // 2.
                     (self at: pos + 1) = anObject
                         ifTrue: [ ^pos + 1 ].
                     (sortBlock value: (self at: pos + 1) value: anObject)
                         ifTrue: [ low := pos + 1 ]
                         ifFalse: [ high := pos - 1 ] ].
    NotFound what: anObject
! !

!SortedCollection methodsFor: 'adding'!

add: anObject
    | low high pos |
    low := pos := 0.
    high := self size - 1.
    "Find the right position with binary search"
    [ low <= high ]
        whileTrue: [ pos := (low + high) // 2.
                     (sortBlock value: (self at: pos + 1) value: anObject)
                         ifTrue: [ low := pos + 1 ]
                         ifFalse: [ high := pos - 1 ] ].
    pos := (low + high) // 2 + 2.
    "Now shift all elements"
    self growBy: 1.
    self size to: pos + 1 reverseDo: [ :i |
        self at: i put: (self at: i - 1) ].

    ^self at: pos put: anObject
! !
