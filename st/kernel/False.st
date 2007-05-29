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

not
    ^true
!

printString
    ^'false'
! !
