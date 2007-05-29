!Console methodsFor: 'running'!

nextChunk
    | chunk |
    chunk := String new.
    [
	| next |
	next := stdin next.
	next = $! ifTrue: [^chunk].
	next ifNotNil: [chunk := chunk, next asString]
    ] repeat
!

run
    | chunk method context |
    [
	[
	    stdout nextPutAll: '> '; flush.
	    chunk := self nextChunk.
	    method := ('goDoIt ^[', chunk, '] value') compile.
	    context := MethodContext on: method parent: thisContext arguments: {nil}.
	    (thisContext enter: context) printNl
	] on: PrimitiveFailed do: [:ex | ]
    ] repeat
! !
