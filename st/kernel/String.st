!String class methodsFor: 'instance creation'!

new: anIndex
    ^super new: anIndex + 1
! !

!String methodsFor: 'primitives'!

printString
    ^self
!

compile
    <primitive: 'String_compile'>
	self primitiveFailed
! !

!String methodsFor: 'basic'!

size
    ^self basicSize - 1
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
