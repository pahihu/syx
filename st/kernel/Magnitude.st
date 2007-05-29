!Magnitude methodsFor: 'basic'!

< aMagnitude
    "Answer whether the receiver is less than aMagnitude"
    self subclassResponsibility 
!

> aMagnitude
    "Answer whether the receiver is greater than aMagnitude"
    ^aMagnitude < self
!

<= aMagnitude
    "Answer whether the receiver is less than or equal to aMagnitude"
    ^(aMagnitude < self) not
! !
