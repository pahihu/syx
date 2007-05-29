Stream subclass: #TextCollector
       instanceVariableNames: 'semaphore receiver selector'!


!TextCollector class methodsFor: 'instance creation'! 
   
new
    self shouldNotImplement
!

message: receiverToSelectorAssociation
    "Answer a new instance of the receiver, that uses the message identified
     by anAssociation to perform write operations.  anAssociation's
     key is the receiver, while its value is the selector."
    ^self new message: receiverToSelectorAssociation; yourself
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
    self nextPutAll: aCharacter asString
!

nextPutAll: aString
    "Write aString to the Transcript"
    self primNextPutAll: aString.  
!

show: aString
    "Write aString to the Transcript"
    self primNextPutAll: aString
!

showCr: aString
    self primNextPutAll: aString; cr
! !

!TextCollector methodsFor: 'private'!

primNextPutAll: aString  
    "Private - Forward the writing request to the actual object
     receiver perform: selector with: aString"

    stdout nextPutAll: aString
! !
