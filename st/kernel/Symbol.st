!Symbol methodsFor: 'accessing'!
"
value
    <primitive: 'globalValue' module: 'Kernel'>
	self primitiveFailed
!

asString
    <primitive: 'symbolToString' module: 'Kernel'>
	self primitiveFailed
!
"
print
    <primitive: 'Symbol_print'>
!

printString
    ^self asString
! !
