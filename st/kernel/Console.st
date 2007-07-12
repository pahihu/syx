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

!Console class methodsFor: 'instance creation'!

run
    ^self new run
! !

!Console methodsFor: 'running'!

primReadline: aString
    <cCall: 'Readline_readline' plugin: 'readline'>
	self primitiveFailed
!

primAddHistory: aString
    <cCall: 'Readline_addHistory' plugin: 'readline'>
	self primitiveFailed
!

nextLine
    | line |
    "This works only with sockets on Windows"
"    Semaphore new waitForRead: stdin fd."
    haveReadline
	ifTrue: [ line := self primReadline: '> '.
		  line isNil
		      ifTrue: [ 'EOF' printNl. Smalltalk quit ].
		  self primAddHistory: line ]
	ifFalse: [ '> ' print.
	           line := stdin nextAll: 1024.
		   line isNil
		       ifTrue: [ 'EOF' printNl. Smalltalk quit].
		   line := line copyFrom: 1 to: line size - 1 ].
    ^line
!

nextChunk
    | chunk |
    chunk := String new.
    [
	| next |
	next := self nextLine.
	chunk := chunk, next.
	chunk size > 1
	    ifTrue: [
		(chunk at: chunk size) = $!
                     ifTrue: [^chunk copyFrom: 1 to: chunk size - 1] ]
    ] repeat
!

run
    [
	"Compatibilty with Syx compiled without readline support"
	haveReadline := Smalltalk loadPlugin: 'readline'.
	[
	    | chunk method context |
	    chunk := self nextChunk.
	    ('^[', chunk, '] value') doIt printNl.
	] on: Signal do: [ :ex | ex debug ]
    ] repeat
! !
