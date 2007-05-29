!BlockClosure methodsFor: 'executing'!

block
    ^block
!

asContext: anArray
    <primitive: 'BlockClosure_asContext'>
	self primitiveFailed
!

newProcess
    <primitive: 'BlockClosure_newProcess'>
	self primitiveFailed
!

fork
    ^self newProcess resume
!

on: anExceptionClass do: aBlock
    <primitive: 'BlockClosure_on_do'>
    | ctx | 
    ctx := self asContext: #().
    ctx
	handledException: anExceptionClass;
	handlerBlock: aBlock.
    ^thisContext enter: ctx
!

ensure: aBlock
    self on: Signal do: [:ex | ^aBlock value]
!

valueWithArguments: anArray
    <primitive: 'BlockClosure_valueWithArguments'>
    | ctx |
    ctx := self asContext: anArray.
    ^thisContext enter: ctx
!

value
    <primitive: 'BlockClosure_value'>
    ^self valueWithArguments: #()
!

value: anObject
    <primitive: 'BlockClosure_valueWith'>
    ^self valueWithArguments: {anObject}
! !

!BlockClosure methodsFor: 'accessing'!

definedContext: aContext
    definedContext := aContext
! !

!BlockClosure methodsFor: 'loops'!

repeat
    [true] whileTrue: self
!

whileTrue
    self whileTrue: [nil]
!

whileTrue: aBlock
    self whileTrue: aBlock
!

whileFalse: aBlock
    self whileFalse: aBlock
! !

