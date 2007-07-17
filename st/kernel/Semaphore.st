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
    ^self basicNew initialize
!

forMutualExclusion
    "Create a new Semaphore and signal it initially. This means the first time a Process waits, it's not blocked."
    ^self new
        signal;
        yourself
! !

!Semaphore methodsFor: 'mutual exclusion'!

critical: aBlock  
    "Wait the semaphore, call aBlock ensuring to signal the semaphore at the end"
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
    "The list of process being waiting"
    ^waitingProcesses
!

signals
    "The difference between all signals and the number of waiting processes"
    ^signals - waitingProcesses size
! !

!Semaphore methodsFor: 'private'!

wait: aFD for: aBoolean
    <primitive: 'Semaphore_waitFor'>
	self primitiveFailed
! !

!Semaphore methodsFor: 'basic'!

waitForRead: aFD
    "Wait a file descriptor to be ready for reading"
    self wait: aFD for: false
!

waitForWrite: aFD
    "Wait a file descriptor to be ready for writing"
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
