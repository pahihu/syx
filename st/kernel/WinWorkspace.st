!WinWorkspace class methodsFor: 'startup'!

primIterate
	<cCall: 'WinGui_IterateLoop' plugin: 'wingui'>
	self primitiveFailed
!

doIt: aString
      [ aString doIt ] on: Error do: [ :ex | ex debug ].
      ^true
!

nextPut: aCharacter
	 ^self nextPutAll: aCharacter asString
!

nextPutAll: aString
	<cCall: 'WinGui_TranscriptNextPutAll' plugin: 'wingui'>
	self primitiveFailed
!

startup
	Smalltalk loadPlugin: 'wingui'.
	Transcript proxyMessage: self -> #nextPutAll:.
	[ self primIterate ] whileTrue
! !