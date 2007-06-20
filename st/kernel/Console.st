!Console class methodsFor: 'instance creation'!

run
    ^self new run
! !

!Console methodsFor: 'running'!

nextChunk
    | chunk |
    chunk := String new.
    [
	| next |
	next := stdin nextAll: 1024.
	chunk := chunk, next.
	(chunk at: chunk size - 1) = $!
            ifTrue: [chunk at: chunk size - 1 put: $.. ^chunk].
	'>> ' print
    ] repeat
!

run
    [
	[
	    | chunk method context |
            '> ' print.
	    chunk := self nextChunk.
	    ('^[', chunk, '] value') doIt printNl.
	] on: Signal do: [ :ex | ex debug ]
    ] repeat
! !
