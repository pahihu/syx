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

!Dictionary class methodsFor: 'instance creation'!

new: size
    ^self basicNew: (size max: 15) * 2 + 3
! !

!Dictionary methodsFor: 'accessing'!

removeKey: aKey
    | index |
    index := self indexOf: aKey.
    (self basicAt: index) isNil
	ifTrue: [ NotFound signal: 'Key not found' ].
    self basicAt: index put: nil
!

indexOf: aKey
    | h2 pos size |
    size := self basicSize.
    pos := 2 * (aKey hash \\ ((size - 1) / 2)).
    h2 := pos / 4.

    (h2 between: 0 and: 1)
	ifTrue: [ h2 := 2 ].
    (h2 \\ 2) isZero
	ifFalse: [ h2 := h2 - 1 ].

    1 to: size do: [ :i |
	| key |
	key := self basicAt: pos + 1.
	key = aKey | key isNil
	    ifTrue: [ ^pos + 1 ].
	pos := pos + h2.
	pos >= (size - 1)
	    ifTrue: [ pos := pos - (size - 1) ] ].
    self error: 'Dictionary is full'
!

at: aKey
    | index |
    index := self indexOf: aKey.
    (self basicAt: index) isNil
	ifTrue: [ NotFound signal: 'Key not found' ].
    ^self basicAt: index + 1
!

at: aKey put: aValue
    | index |
    index := self indexOf: aKey.
    self
	basicAt: index put: aKey;
	basicAt: index + 1 put: aValue.
    ^aValue
!

do: aBlock
    1 to: self basicSize by: 2 do: [ :i |
         | el |
         el := self basicAt: i.
	 el ifNotNil: [ aBlock value: el ] ]
! !
