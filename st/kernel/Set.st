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

!Set class methodsFor: 'instance creation'!

new: size
    ^(self basicNew: (size max: 10)) initialize
! !

!Set methodsFor: 'initialize-release'!

initialize
    tally := 0
! !    

!Set methodsFor: 'private'!

incrementTally
    tally >= (self basicSize // 2)
	ifTrue: [ self rehashToSize: self basicSize + tally ].
    tally := tally + 1.
! !

!Set methodsFor: 'accessing'!

size
    ^tally
!

rehashClass
    ^self class
!

growTo: anInteger
    self rehashToSize: anInteger
!
    
rehashToSize: anInteger
    | d |
    d := self rehashClass new: anInteger.
    self do: [ :ea |
	d add: ea ].
    ObjectMemory atData: self put: d
!

indexOf: anObject
    | i n size |
    size := self basicSize.
    i := 2 * (anObject hash \\ size).
    n := tally + 2.
    [ (n := n - 1) = 0 ]
	whileFalse: [
	    | key |
	    i >= size
		ifTrue: [ i := 0 ].
	    key := self basicAt: i + 1.
	    key = anObject | key isNil
		ifTrue: [ ^i + 1 ].
	    i := i + 1 ]
! !

!Set methodsFor: 'enumerating'!

do: aBlock
    1 to: self basicSize do: [ :i |
         | el |
         el := self basicAt: i.
	 el ifNotNil: [ aBlock value: el ] ]
! !

!Set methodsFor: 'adding'!

add: anObject
    | index |
    anObject
	ifNil: [ self error: 'Element must not be nil' ].
    
    index := self indexOf: anObject.
    (self basicAt: index) isNil
	ifTrue: [
	    self basicAt: index put: anObject.
	    self incrementTally ].
    ^anObject
! !

!Set methodsFor: 'removing'!

remove: anObject ifAbsent: exceptionHandler
    | index |
    anObject
	ifNil: [ ^self ].

    index := self indexOf: anObject.
    (self basicAt: index) isNil
	ifTrue: [ ^exceptionHandler value ].
    self basicAt: index put: nil.
    tally := tally - 1.
    ^anObject
! !

!Set methodsFor: 'converting'!

asSet
    ^self
! !

!Set methodsFor: 'testing'!

includes: anObject
    | index |
    index := self indexOf: anObject.
    ^(self basicAt: index) notNil
!

isSet
    ^true
! !
