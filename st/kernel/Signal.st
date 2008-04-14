"
Copyright (c) 2007-2008 Luca Bruno

This file is part of Smalltalk YX.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the 'Software'), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.
"

!Signal class methodsFor: 'instance creation'!

signal: messageText
    self new signal: messageText
!

signal
    self new signal
! !

!Signal methodsFor: 'signaling'!

handlerContext
    "Finds the context which handles the exception"
    | ctx |
    handlerContext
	ifNotNil: [ ^handlerContext ].

    ctx := signalerContext parent.
    [ ctx notNil ]
	whileTrue: [
	    (ctx handles: self)
		ifTrue: [ ^handlerContext := ctx ].
	    ctx := ctx parent ].
    ^nil
!

isResumable
    "Anwser if the signaler context can be resumed back"
    ^true
!

description
    ^'A signal has been sent.'
!

messageText
    ^messageText
!

messageText: aMessageText
    messageText := aMessageText
!

signal
    "Raises a signal. If it's not handled, debug the process"
    signalerContext := thisContext.
    [
	self handlerContext isNil
            ifTrue: [ Transcript showCr: 'Unhandled exception... process is going to be terminated'.
		      self debug.
		      Processor activeProcess terminate]
	    ifFalse: [ self return: (handlerContext handlerBlock value: self) ]
    ] on: Signal do: [ :ex | ]
!

signal: aMessageText
    messageText := aMessageText.
    self signal
!

debug
    Transcript showCr: '= ', self description.
    self messageText
	ifNotNil: [ Transcript showCr: '== ', self messageText ].
    Transcript
        cr;
        showCr: 'Traceback:'.
    [ signalerContext traceback ]
	on: Signal
        do: [ :ex | Transcript showCr: 'Unable to debug' ]
!

pass
    "Drop the exception to parent contexts"
    thisContext parent: handlerContext parent.
    handlerContext := nil.
    self signal
!

resume
    "Resume the context which generated the error"
    self isResumable
	ifTrue: [ Processor swapWith: signalerContext parent ]
!

return: anObject
    "Returns anObject"
    Processor leaveTo: handlerContext parent andAnswer: anObject
!

return
    self return: nil
! !

!Exception methodsFor: 'signaling'!

description
    ^'An exception has been raised.'
! !

!Error methodsFor: 'signaling'!

description
    ^'An error occurred during program execution.'
! !

!MessageNotUnderstood class methodsFor: 'instance creation'!

message: aMessage receiver: anObject
    ^self new
	message: aMessage receiver: anObject;
	signal
! !

!MessageNotUnderstood methodsFor: 'signaling'!

message
    ^message
! 

receiver
    ^receiver
!

message: aMessage receiver: anObject
    message := aMessage.
    receiver := anObject.
    self messageText: anObject class printString, ': did not understood ', aMessage printString
! !

!ZeroDivide class methodsFor: 'instance creation'!

signal
    ^self signal: 'Division by zero.'
! !

!SubclassResponsibility class methodsFor: 'instance creation'!

signal
    ^self signal: 'This method is not responsibility of this class. A subclass must implement this method.'
! !

!WrongArgumentCount class methodsFor: 'instance creation'!

signal
    ^self signal: 'Wrong number of arguments.'
! !

!NotFound class methodsFor: 'instance creation'!

what: anObject
    ^self signal: 'Object not found
