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

Object subclass: #ConsoleChunkReader
       instanceVariableNames: 'previousChunk inString inComment'
       classVariableNames: ''!

!ConsoleChunkReader class methodsFor: 'instance creation'!

new
    ^self basicNew initialize
! !

!ConsoleChunkReader methodsFor: 'initialize-release'!

initialize
    previousChunk := ''.
    inString := false.
    inComment := false
!

splitChunk: chunk into: chunks
    chunk from: 1 to: chunk size keysAndValuesDo: [ :i :ea |
        ea = $'
            ifTrue: [ inString := inString not ].
        ea = $" & inString not
            ifTrue: [ inComment := inComment not ].
        ea = $! & inString not & inComment not
            ifTrue: [
                chunks add: (chunk copyFrom: 1 to: i-1).
                ^self splitChunk: (chunk copyFrom: i+1 to: chunk size) into: chunks ] ].
    previousChunk := chunk
!

nextChunks: newLine
    | chunks |
    chunks := OrderedCollection new.
    self splitChunk: previousChunk, newLine into: chunks.
    ^chunks
! !

!Console class methodsFor: 'instance creation'!

startup
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
    haveReadline
	ifTrue: [ line := self primReadline: '> '.
		  line isNil
		      ifTrue: [ Transcript showCr: 'EOF'. Smalltalk quit ].
		  self primAddHistory: line ]
	ifFalse: [ '> ' print. stdout flush.
	           line := stdin next: 1024.
		   line isNil
		       ifTrue: [ Transcript showCr: 'EOF'. Smalltalk quit].
		   line := line copyFrom: 1 to: line size - 1 ].
    ^line
!

helpString
    ^'===========
To quit Smalltalk YX type "Smalltalk quit!" or press ^D (ctrl+D).
To say Hello World type:
 ''Hello world''!

For more documentation and examples please visit the homepage or contact us.

Homepage: http://syx.googlecode.com
Mailing list: http://groups.google.com/group/syx-discuss
IRC channel: #syx on irc.freenode.net
E-mail: lethalman88 at gmail.com
==========='
!

setupHelp
    Smalltalk at: #help put: self helpString
!

showHelp
    Transcript
        showCr: Smalltalk version, ' is ready.';
        showCr: 'Type "help!" to get help.'
!

run
    | chunkReader |
    self
        setupHelp;
        showHelp.
    haveReadline := Smalltalk loadPlugin: 'readline'.
    chunkReader := ConsoleChunkReader new.
    [
	[
            | lastObject |
            (chunkReader nextChunks: self nextLine) do: [ :chunk |
                lastObject := ('^[', chunk, '] value') doIt ].
            lastObject printNl
	] on: Signal do: [ :ex | ex debug ]
    ] repeat
! !
