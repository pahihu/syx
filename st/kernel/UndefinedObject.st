!UndefinedObject methodsFor: 'printing'!

printString
    ^'nil'
! !

!UndefinedObject methodsFor: 'testing'!

ifNil: aBlock
    ^aBlock value
!

ifNotNil: aBlock
    ^self
!

isNil
    ^true
!

notNil
    ^false
! !
