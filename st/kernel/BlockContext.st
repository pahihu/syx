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

!BlockContext methodsFor: 'accessing'!

handlerBlock
    "Answer the block that handles handledException"
    ^handlerBlock
!

handlerBlock: aBlock
    "Set the block that handles handledException"
    handlerBlock := aBlock
!

ensureBlock: aBlock
    "Set the block to be evaluted"
    ensureBlock := aBlock
!

ensureBlock
    ^ensureBlock
!

handledException: anExceptionClass
    "Set the exception handled by handlerBlock"
    handledException := anExceptionClass
!

handledException
    "Answer the exception handled by handlerBlock"
    ^handledException
! !

!BlockContext methodsFor: 'exception traceback'!

handles: anException
    ^anException isKindOf: handledException
!

tracebackString
    "Shows my single traceback"
    ^self homeContext tracebackString, '[]'
!

homeContext
    ^self outerContext homeContext
!

outerContext
    <primitive: 'BlockContext_outerContext'>
    self primitiveFailed
! !

!BlockContext methodsFor: 'testing'!

isMethodContext
    ^false
! !
