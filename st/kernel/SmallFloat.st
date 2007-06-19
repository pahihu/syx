!SmallFloat class methodsFor: 'instance creation'!

new
    self shouldNotImplement
! !

!SmallFloat methodsFor: 'printing'!

print
    <primitive: 'Float_print'>
	self primitiveFailed
! !

!SmallFloat methodsFor: 'testing'!

isSmallFloat
    ^true
! !

!SmallFloat methodsFor: 'arithmetic'!

+ aNumber
     <primitive: 'SmallFloat_plus'>
	 self primitiveFailed
!

- aNumber
     <primitive: 'SmallFloat_minus'>
	 self primitiveFailed
!

< aNumber
     <primitive: 'SmallFloat_lt'>
	 self primitiveFailed
!

> aNumber
     <primitive: 'SmallFloat_gt'>
	 self primitiveFailed
!

<= aNumber
     <primitive: 'SmallFloat_le'>
	 self primitiveFailed
!

>= aNumber
     <primitive: 'SmallFloat_ge'>
	 self primitiveFailed
!

= aNumber
     <primitive: 'SmallFloat_eq'>
	 self primitiveFailed
!

~= aNumber
     <primitive: 'SmallFloat_ne'>
	 self primitiveFailed
! !
