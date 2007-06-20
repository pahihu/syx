!MethodContext methodsFor: 'testing'!

isMethodContext
    ^true
! !

!BlockContext methodsFor: 'testing'!

isMethodContext
    ^false
! !

!ContextPart class methodsFor: 'instance creation'!

on: aMethod parent: aContext receiver: anObject arguments: anArray
    ^self new
	method: aMethod
	parent: aContext
	receiver: anObject
	arguments: anArray;
	yourself
! !

!ContextPart methodsFor: 'initialize-release'!

initialize

! !

!ContextPart methodsFor: 'debugging'!

traceback
    | context |
    context := self.
    [ context notNil ]
	whileTrue: [
	    context isMethodContext
		ifTrue: [
		    (context receiver class printString, '>>', context method selector asString) printNl.
			].
	    context := context parent
	    ]
! !


!ContextPart methodsFor: 'accessing'!

isMethodContext
    self subclassResponsibility
! !

!ContextPart methodsFor: 'debugging'!

method
    ^method
!

method: aMethod parent: aContext receiver: anObject arguments: anArray
    "if method is set then this context has been initialized"
    method notNil ifTrue: [^self].

    method := aMethod.
    returnContext := parent := aContext.
    receiver := anObject.

    method argumentsCount > 0
	ifTrue: [ arguments := Array new: method argumentsCount ].

    anArray notNil
	ifTrue: [ arguments replaceFrom: 1 with: anArray ].

    method temporariesCount > 0
	ifTrue: [ temporaries := Array new: method temporariesCount ].

    ip := sp := 0.
    stack := Array new: method stackSize
!

receiver
    ^receiver
!

parent: aContext
    parent := aContext
!

parent
    ^parent
! !
