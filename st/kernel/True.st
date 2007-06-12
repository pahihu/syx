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

or: aBlock
    ^true
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
