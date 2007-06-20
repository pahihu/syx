!Object methodsFor: 'initialize-release'!

initialize
    ^self
! !

!Object methodsFor: 'basic'!

at: anIndex
    self shouldNotImplement
!

at: anIndex put: anObject
    self shouldNotImplement
!

basicAt: anIndex
    <primitive: 'Object_at'>
	self primitiveFailed
!

basicAt: anIndex put: anObject
    <primitive: 'Object_at_put'>
	self primitiveFailed
!

size
    <primitive: 'Object_size'>
	self primitiveFailed
!

basicSize
    <primitive: 'Object_size'>
	self primitiveFailed
!

hash
    <primitive: 'Object_hash'>
	self primitiveFailed
! !

!Object methodsFor: 'testing'!

isString
    ^false
!

ifNil: aBlock
    ^self
!

ifNotNil: aBlock
    ^aBlock value
!

isNil
    ^false
!

notNil
    ^true
! !

!Object methodsFor: 'accessing'!

class
    <primitive: 'Object_class'>
	self primitiveFailed
!

print
    Transcript show: self printString
!

printNl
    Transcript showCr: self printString
!

= anObject
    ^self == anObject
!

== anObject
    <primitive: 'Object_identityEqual'>
	self primitiveFailed
!

printString
    ^'a ', self class name asString
! !

!Object methodsFor: 'signaling'!

shouldNotImplement
    ShouldNotImplement signal
!

subclassResponsibility
    SubclassResponsibility signal
!

notYetImplemented
    NotYetImplemented signal
!

primitiveFailed
    PrimitiveFailed signal
! !

!Object methodsFor: 'syntax shortcuts'!

-> anObject
    "Creates a new instance of Association with the receiver being the key
     and the argument becoming the value"
    ^Association key: self value: anObject
! !

!Object methodsFor: 'class type methods'!

species 
    "This method has no unique definition. Generally speaking, methods which
     always return the same type usually don't use #class, but #species.
     For example, a PositionableStream's species is the class of the collection
     on which it is streaming (used by upTo:, upToAll:, upToEnd). Stream uses
     species for obtaining the class of next:'s return value, Collection uses
     it in its #copyEmpty: message, which in turn is used by all collection-re-
     turning methods. An Interval's species is Array (used by collect:, select:
     reject:, etc.)."
    ^self class
!

yourself
    "Answer the receiver"
    ^self
! !

!Object methodsFor: 'inspecting'!

briefInspect
    
