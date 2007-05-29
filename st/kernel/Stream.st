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
