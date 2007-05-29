!True methodsFor: 'conditional'!

ifTrue: trueBlock ifFalse: falseBlock
    ^trueBlock value
!

ifTrue: trueBlock
    ^trueBlock value
!
    
ifFalse: falseBlock
    ^nil
!

not
    ^false
!

print
    'true' print
!

printString
    ^'true'
! !
