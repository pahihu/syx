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

new
    ^self new: 10
! !

!Dictionary methodsFor: 'accessing'!

removeKey: aKey
    1 to: hashTable size by: 2 do: [ :i |
	(hashTable at: i) = aKey
	    ifTrue: [ hashTable at: i put: nil. ^hashTable at: i + 1 put: nil ] ]
!

at: aKey
    1 to: hashTable size by: 2 do: [ :i |
	(hashTable at: i) = aKey
	    ifTrue: [ ^hashTable at: i + 1 ] ]
!

at: aKey put: aValue
    1 to: hashTable size by: 2 do: [ :i |
	| key |
	key := hashTable at: i.
	key = aKey
	    ifTrue: [ ^hashTable at: i + 1 put: aValue ].
	key isNil
	    ifTrue: [
		hashTable at: i put: aKey.
		^hashTable at: i + 1 put: aValue ] ]
! !
