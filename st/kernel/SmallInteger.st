!SmallInteger methodsFor: 'arithmetic'!

+ aNumber
     <primitive: 'SmallInteger_plus'>
	 self primitiveFailed
!

- aNumber
     <primitive: 'SmallInteger_minus'>
	 self primitiveFailed
!

< aNumber
     <primitive: 'SmallInteger_lt'>
	 self primitiveFailed
!

> aNumber
     <primitive: 'SmallInteger_gt'>
	 self primitiveFailed
!

<= aNumber
     <primitive: 'SmallInteger_le'>
	 self primitiveFailed
!

>= aNumber
     <primitive: 'SmallInteger_ge'>
	 self primitiveFailed
!

= arg
     <primitive: 'SmallInteger_eq'>
	 self primitiveFailed
!

== arg
     <primitive: 'SmallInteger_eq'>
	 self primitiveFailed
!

~= arg
     <primitive: 'SmallInteger_ne'>
	 self primitiveFailed
!

~~ arg
     <primitive: 'SmallInteger_ne'>
	 self primitiveFailed
! !

!SmallInteger methodsFor: 'coercing'!

print
    <primitive: 'SmallInteger_print'>
	self primitiveFailed
!

unity
    ^1
! !
