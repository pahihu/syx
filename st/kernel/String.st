!String methodsFor: 'primitives'!

print
    <primitive: 'String_print'>
	self primitiveFailed
!

printString
    ^self
!

compile
    <primitive: 'String_compile'>
	self primitiveFailed
!

"= anObject
    <primitive: 'valueEqual' module: 'Kernel'>
	self primitiveFailed
!" !

!String methodsFor: 'testing'!

isString
    ^true
! !
