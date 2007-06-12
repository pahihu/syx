!String class methodsFor: 'instance creation'!

new: anIndex
    ^self basicNew: anIndex
! !

!String methodsFor: 'primitives'!

printString
    ^self
!

compile
    <primitive: 'String_compile'>
	self primitiveFailed
! !

!String methodsFor: 'utilities'!

doIt
    | method context |
    method := ('goDoIt ', self) compile.
    context := MethodContext on: method parent: thisContext receiver: nil arguments: nil.
    ^Processor enter: context
! !

!String methodsFor: 'converting'!

asString
    ^self
! !

!String methodsFor: 'testing'!

isString
    ^true
! !
