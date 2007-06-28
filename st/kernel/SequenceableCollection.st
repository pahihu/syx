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
    "Answer a new instance of an ArrayedCollection containing all the elements
     in the receiver, followed by all the elements in aSequenceableCollection"
    ^(self copyEmpty: self size + aSequenceableCollection size)
	replaceFrom: 1 with: self;
	replaceFrom: self size + 1 with: aSequenceableCollection;
	yourself
! !

!SequenceableCollection methodsFor: 'replacing items'!

replaceFrom: start with: replacementCollection
    "Replace the items from start to stop with replacementCollection's items
     from 1 to stop-start+1 (in unexpected order if the collection is not
     sequenceable)."
    | i |
    i := start - 1.
    replacementCollection do: [ :ea |
	self at: (i := i + 1) put: ea
    ]
! !

!SequenceableCollection methodsFor: 'enumerating'!

do: aBlock
    "Evaluate aBlock for all the elements in the sequenceable collection"
    1 to: self size do: [ :i | aBlock value: (self at: i) ].
! !

!SequenceableCollection methodsFor: 'basic'!

indexOf: anElement startingAt: anIndex ifAbsent: exceptionBlock
    anIndex to: self size do: [ :index |
        (self at: index) == anElement ifTrue: [ ^index ].
    ].
    ^exceptionBlock value
! !
