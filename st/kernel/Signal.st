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

!Signal class methodsFor: 'instance creation'!

signal
    self new signal
! !

!Signal methodsFor: 'signaling'!

findHandlerContext
    "Finds the context which handles the exception"
    <primitive: 'Signal_findHandlerContext'>
	self primitiveFailed
!

signal
    "Raises a signal. If it's not handled, debug the process"
    signalerContext := thisContext.
    handlerContext := self findHandlerContext.
    handlerContext isNil
	ifTrue: ['Unhandled exception... process is going to be terminated' printNl.
		 self debug.
		 Processor activeProcess terminate]
	ifFalse: [self return: (handlerContext handlerBlock value: self)]
!

debug
    [ signalerContext traceback ]
	on: Signal do: [ :ex | 'Unable to debug' printNl ]
!

pass
    thisContext parent: handlerContext parent.
    self signal
!

resume
    Processor swapWith: signalerContext parent
!

return: anObject
    Processor leaveTo: handlerContext parent andAnswer: anObject
!

return
    self return: nil
! !
