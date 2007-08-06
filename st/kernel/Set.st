!Set class methodsFor: 'instance creation'!

new: size
    ^(self basicNew: (size max: 10)) initialize
! !

!Set methodsFor: 'initialize-release'!

initialize
    numElements := 0
! !    

!Set methodsFor: 'private'!

incrementNumElements
    numElements >= (self basicSize // 2)
	ifTrue: [ self rehashToSize: self basicSize + numElements ].
    numElements := numElements + 1.
! !

!Set methodsFor: 'accessing'!

size
    ^numElements
!

rehashClass
    ^self class
!

growTo: anInteger
    self rehashToSize: anInteger
!
    
rehashToSize: anInteger
    | d |
    d := self rehashClass new: anInteger.
    self do: [ :ea |
	d add: ea ].
    ObjectMemory atData: self put: d
!

indexOf: anObject
    | i n size |
    size := self basicSize.
    i := 2 * (anObject hash \\ size).
    n := numElements + 2.
    [ (n := n - 1) = 0 ]
	whileFalse: [
	    | key |
	    i >= size
		ifTrue: [ i := 0 ].
	    key := self basicAt: i + 1.
	    key = anObject | key isNil
		ifTrue: [ ^i + 1 ].
	    i := i + 1 ]
!

do: aBlock
    1 to: self basicSize do: [ :i |
         | el |
         el := self basicAt: i.
	 el ifNotNil: [ aBlock value: el ] ]
!

add: anObject
    | index |
    anObject
	ifNil: [ self error: 'Element must not be nil' ].
    
    index := self indexOf: anObject.
    (self basicAt: index) isNil
	ifTrue: [
	    self basicAt: index put: anObject.
	    self incrementNumElements ].
    ^anObject
!

remove: anObject ifAbsent: exceptionHandler
    | index |
    anObject
	ifNil: [ ^self ].

    index := self indexOf: anObject.
    (self basicAt: index) isNil
	ifTrue: [ ^exceptionHandler value ].
    self basicAt: index put: nil.
    numElements := numElements - 1.
    ^anObject
! !

!Set methodsFor: 'converting'!

asSet
    ^self
! !

!Set methodsFor: 'enumerating'!

includes: anObject
    | index |
    index := self indexOf: anObject.
    ^(self basicAt: index) notNil
! !

!Set methodsFor: 'testing'!

isSet
    ^true
! !
