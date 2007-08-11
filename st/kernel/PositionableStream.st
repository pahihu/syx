!PositionableStream class methodsFor: 'instance creation'!

on: aCollection
    ^self new initializeOn: aCollection
!

with: aCollection
    ^self new initializeOn: aCollection; setToEnd
! !

!PositionableStream methodsFor: 'initialize-release'!

initializeOn: aCollection
    collection := aCollection.
    curPos := 0.
    endPos := collection size    
! !

!PositionableStream methodsFor: 'accessing'!

size
    ^endPos
!

collectionClass
    ^collection class
!

contents
    ^collection copyFrom: 1 to: endPos
!

upToEnd
    ^collection copyFrom: (curPos + 1 min: endPos) to: endPos
!

position
    ^curPos
!

position: anInteger
    (anInteger between: 0 and: endPos)
	ifTrue: [ curPos := anInteger ]
	ifFalse: [ self error: 'Position out of bounds' ]
!

peek
    self ensureReadable.
    self atEnd
	ifTrue: [ ^nil ].
    ^collection at: curPos + 1
!

skipTo: anObject
    self ensureReadable.
    self do: [ :ea |
	ea = anObject
	    ifTrue: [ ^true ] ].
    ^false
!

next
    self ensureReadable.
    self atEnd
	ifTrue: [ ^nil ].
    ^collection at: self skipOne
!

nextPut: anObject
    self ensureWriteable.
    curPos := curPos + 1.
    self atEnd
	ifTrue: [ (endPos := curPos) >= collection size
		      ifTrue: [ collection growTo: endPos + 10 ] ].
    ^collection at: curPos put: anObject
!

nextPutAll: aCollection
    | pos |
    self ensureWriteable.
    pos := curPos + 1.
    curPos := curPos + aCollection size.
    self atEnd
	ifTrue: [ (endPos := curPos) >= collection size
		      ifTrue: [ collection growTo: endPos + 10 ] ].
    collection replaceFrom: pos to: curPos with: aCollection.
    ^aCollection
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
    ^curPos := (curPos + anInteger) min: endPos
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
