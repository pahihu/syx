!False methodsFor: 'conditional'!

ifTrue: trueBlock ifFalse: falseBlock
    ^falseBlock value
!

ifTrue: trueBlock
    ^nil
!

ifFalse: falseBlock
    ^falseBlock value
!

or: aBlock
    ^aBlock value
!

not
    ^true
!

printString
    ^'false'
! !
