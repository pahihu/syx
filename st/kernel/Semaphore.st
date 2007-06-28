"
Copyright (c) 2007 Luca Bruno

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

!Semaphore class methodsFor: 'instance creation'!

new
    "Answer a new semaphore"
    ^super basicNew initialize
!

forMutualExclusion
    "Answer a new semaphore with a signal on it. These semaphores are a useful
     shortcut when you use semaphores as critical sections."
    ^self new
        signal;
        yourself
! !

!Semaphore methodsFor: 'mutual exclusion'!

critical: aBlock  
    "Wait for the receiver to be free, execute aBlock and signal the receiver 
     again. Return the result of evaluating aBlock."
    self wait.
    ^aBlock ensure: [ self signal ]
! !

!Semaphore methodsFor: 'initialize-release'! 

initialize
    signals := 0.
    waitingProcesses := Array new
! !

!Semaphore methodsFor: 'accessing'!

waitingProcesses
    ^waitingProcesses
!

signals
    ^signals - waitingProcesses size
! !

!Semaphore methodsFor: 'private'!

wait: aFD for: aBoolean
    <primitive: 'Semaphore_waitFor'>
	self primitiveFailed
! !

!Semaphore methodsFor: 'basic'!

waitForRead: aFD
    self wait: aFD for: false
!

waitForWrite: aFD
    self wait: aFD for: true
!

signal
    <primitive: 'Semaphore_signal'>
	self primitiveFailed
!

wait
    <primitive: 'Semaphore_wait'>
	self primitiveFailed
! !
