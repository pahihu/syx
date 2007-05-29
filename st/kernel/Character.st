!Character class methodsFor: 'instance creation'!

new
    self shouldNotImplement
!

cr
    ^self value: 13
!

nl
    ^self value: 10
!

value: anInteger
    <primitive: 'Character_new'>
	self primitiveFailed
! !

!Character methodsFor: 'accessing'!

value
    <primitive: 'Character_value'>
	self primitiveFailed
! !

!Character methodsFor: 'converting'!

= aCharacter
     ^self value = aCharacter value
!

== aCharacter
     ^self value = aCharacter value
!

asCharacter
    ^self
!

asString
    ^String with: self
!

printString
    ^self asString
! !
