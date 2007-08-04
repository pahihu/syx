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

!Interval class methodsFor: 'instance-creation'!

new: count
    self shouldNotImplement
!

from: start to: stop by: step
    ^self basicNew initializeFrom: start to: stop by: step; yourself
!

from: start to: stop
    ^self from: start to: stop by: 1
! !

!Interval methodsFor: 'initialize-release'!

initializeFrom: start to: stop by: step
    start := start.
    stop := stop.
    step := step
! !

!Interval methodsFor: 'basic'!

at: anIndex
    anIndex > self size
	ifTrue: [ ^self error: 'Invalid index' ].
    ^start + (anIndex - 1 * step)
!

size
    ^((start - stop) abs + 1 / step) ceiling
! !

!Interval methodsFor: 'accessing'!

start
    ^start
!

stop
    ^stop
!

step
    ^step
! !

!Interval methodsFor: 'copying'!

copyClass
    ^Array
! !

!Interval methodsFor: 'enumerating'!

collectClass
    ^Array
!

reverse
    "Answer a reversed Interval of the receiver"
    ^Interval from: stop to: start by: step negated
!

do: aBlock
    "Do aBlock passing the interval elements as first argument of the given block"
    | i |
    i := start.
    step positive
	ifTrue: [
	    [ i <= stop ]
		whileTrue: [ aBlock value: i.
			     i := i + step ] ]
	ifFalse: [
	    [ i >= stop ]
		whileTrue: [ aBlock value: i.
			     i := i + step ] ]
!

collect: transformerBlock
    "Evaluate the block for each element of the receiver.
     The results of these evaluations are collected into a new collection"
    | coll |
    coll := self copyEmptyForCollect.
    self from: 1 to: self size keysAndValuesDo: [ :i :v |
	coll at: i put: (transformerBlock value: v) ].
    ^coll
! !
