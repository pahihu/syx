!Float class methodsFor: 'instance creation'!

new
    self shouldNotImplement
! !

!Float methodsFor: 'printing'!

print
    <primitive: 'Float_print'>
	self primitiveFailed
! !

!Float methodsFor: 'testing'!

isFloat
    ^true
! !

!Float methodsFor: 'arithmetic'!

+ aNumber
     <primitive: 'Float_plus'>
	 self primitiveFailed
!

- aNumber
     <primitive: 'Float_minus'>
	 self primitiveFailed
!

< aNumber
     <primitive: 'Float_lt'>
	 self primitiveFailed
!

> aNumber
     <primitive: 'Float_gt'>
	 self primitiveFailed
!

<= aNumber
     <primitive: 'Float_le'>
	 self primitiveFailed
!

>= aNumber
     <primitive: 'Float_ge'>
	 self primitiveFailed
!

= aNumber
     <primitive: 'Float_eq'>
	 self primitiveFailed
!

~= aNumber
     <primitive: 'Float_ne'>
	 self primitiveFailed
! !
