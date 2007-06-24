!Console class methodsFor: 'instance creation'!

run
    ^self basicNew initialize run
! !

!Console methodsFor: 'running'!

initialize
    hasReadline := Smalltalk loadPlugin: 'readline'
!

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
    hasReadline
	ifTrue: [ line := self primReadline: '> '.
		  "received EOF"
		  line isNil
		      ifTrue: [ 'EOF' printNl. Smalltalk quit ].
		  self primAddHistory: line ]
	ifFalse: [ '> ' print.
		   line := stdin nextAll: 1024.
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
	[
	    | chunk method context |
	    chunk := self nextChunk.
	    ('^[', chunk, '] value') doIt printNl.
	] on: Signal do: [ :ex | ex debug ]
    ] repeat
! !
