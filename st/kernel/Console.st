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
    haveReadline := Smalltalk loadPlugin: 'readline'.
    [
	[
	    | chunk method context |
	    chunk := self nextChunk.
	    ('^[', chunk, '] value') doIt printNl.
	] on: Signal do: [ :ex | ex debug ]
    ] repeat
! !
