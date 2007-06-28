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

!Stream methodsFor: 'accessing-reading'!

next
    "Return the next object in the receiver"
    self subclassResponsibility
!


contents
    "Answer the whole contents of the receiver, from the next object to
     the last"
    | stream |

    stream := WriteStream on: (self species new: 10).
    self do: [ :each | stream nextPut: each ].
    ^stream contents
! !


!Stream methodsFor: 'accessing-writing'!   

nextPut: anObject   
    "Write anObject to the receiver"
    self subclassResponsibility
!


nextPutAll: aCollection
    "Write all the objects in aCollection to the receiver"
    aCollection do: [ :element | self nextPut: element ].
    ^aCollection
! !

!Stream methodsFor: 'testing'!

atEnd
    "Answer whether the stream has got to an end"
    self subclassResponsibility
!

isExternalStream
    "Answer whether the receiver streams on a file or socket.
     By default, answer false."
    ^false
! !


!Stream methodsFor: 'enumerating'!

do: aBlock
    "Evaluate aBlock once for every object in the receiver"
    [self atEnd] whileFalse:
        [aBlock value: self next ]

! !


!Stream methodsFor: 'basic'!

species
    ^Array
!

nl
    "Store a new line on the receiver"
    self nextPut: Character nl
!

cr 
    "Store a cr on the receiver"
    self nextPut: Character cr
! !

!Stream methodsFor: 'providing consistent protocols'!

close
    "Do nothing. This is provided for consistency with file streams"
!

flush 
    "Do nothing. This is provided for consistency with file streams"
! !
