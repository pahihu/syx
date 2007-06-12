!Number methodsFor: 'arithmetic'!

+ aNumber
     self subclassResponsibility
!

- aNumber
     self subclassResponsibility
!

* aNumber
     self subclassResponsibility
!

/ aNumber
     self subclassResponsibility
! !

!Number methodsFor: 'shortcuts and iterators'!

to: stop do: aBlock
    self to: stop by: self unity do: aBlock
!

to: stop by: step do: aBlock
    "Evaluate aBlock for each value in the interval going from the receiver
     to stop by 1. Compiled in-line for one-argument aBlocks without
     temporaries, and therefore not overridable."
    | i |
    i := self.
    [ i <= stop ]
	whileTrue: [ aBlock value: i.
                     i := i + step ]
! !

!Number methodsFor: 'converting'!
unity
    self subclassResponsibility
! !
