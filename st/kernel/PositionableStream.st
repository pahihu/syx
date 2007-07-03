!PositionableStream class methodsFor: 'instance creation'!

on: aCollection
    ^self basicNew initializeOn: aCollection
!

with: aCollection
    ^(self on: aCollection) setToEnd
! !

!PositionableStream methodsFor: 'initialize-release'!

initializeOn: aCollection
    collection := aCollection.
    curPos := 0.
    endPos := collection size
! !

!PositionableStream methodsFor: 'accessing'!

collectionClass
    ^collection class
!

contents
    ^collection copyFrom: 1 to: endPos
!

position
    ^curPos
!

position: anInteger
    (anInteger between: 0 and: endPos)
	ifTrue: [ curPos := anInteger ]
	ifFalse: [ self error: 'Position out of bounds' ].
    curPos := anInteger
!

peek
    self atEnd
	ifTrue: [ ^collection at: curPos ].
    ^collection at: curPos + 1
!

next
    self errorAtEnd.
    ^collection at: self skipOne
!

nextPut: anObject  
    curPos := curPos + 1.
    self atEnd
	ifTrue: [ (endPos := curPos) > collection size
		      ifTrue: [ collection growTo: endPos ] ].
    ^collection at: curPos put: anObject
!

collection
    ^collection
! !

!PositionableStream methodsFor: 'private'!

errorAtEnd
    self atEnd
	ifTrue: [ self error: 'End of stream' ]
! !

!PositionableStream methodsFor: 'positioning'!

skip: anInteger
    ^curPos := (curPos + (anInteger max: 0)) min: endPos
!

truncate
    endPos := curPos
!

reset
    curPos := 0
!

skipOne
    ^self skip: 1
!

atEnd
    ^curPos >= endPos
!

setToEnd
    curPos := endPos
! !

!PositionableStream methodsFor: 'testing'!

isPositionable
    ^true
!

isEmpty
    ^endPos = 0
! !
