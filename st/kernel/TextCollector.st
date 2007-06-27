Stream subclass: #TextCollector
       instanceVariableNames: 'receiver selector'
       classVariableNames: ''!


!TextCollector class methodsFor: 'instance creation'! 
   
new
    self shouldNotImplement
!

message: receiverToSelectorAssociation
    "Answer a new instance of the receiver, that uses the message identified
     by anAssociation to perform write operations.  anAssociation's
     key is the receiver, while its value is the selector."
    ^self basicNew message: receiverToSelectorAssociation; yourself
! !

!TextCollector methodsFor: 'set up'!

message
    "Answer an association representing the message to be sent
    to perform write operations.  The key is the receiver, the value is the
    selector"
    ^receiver -> selector
!

message: receiverToSelectorAssociation
    "Set the message to be sent to perform write operations
     to the one represented by anAssociation.  anAssociation's key is the
     receiver, while its value is the selector"
    receiver := receiverToSelectorAssociation key.
    selector := receiverToSelectorAssociation value
! !

!TextCollector methodsFor: 'accessing'!

cr
    "Emit a new-line (carriage return) to the Transcript"
    self nl
!

nextPut: aCharacter
    receiver nextPut: aCharacter
!

nextPutAll: aString
    "Write aString to the Transcript"
    receiver nextPutAll: aString
    "self primNextPutAll: aString.  "
!

show: aString
    "Write aString to the Transcript"
    self nextPutAll: aString
!

showCr: aString
    self nextPutAll: aString; cr
! !
