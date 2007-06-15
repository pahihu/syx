!SystemDictionary methodsFor: 'initialize-release'!

quit: exitStatus
    <primitive: 'Smalltalk_quit'>
	self primitiveFailed
!

quit
    ^self quit: 0
!

initializeSystem
    self
	at: #stdin put: (FileStream on: 0);
	at: #stdout put: (FileStream on: 1);
	at: #stderr put: (FileStream on: 2);
	at: #Transcript put: (TextCollector message: stdout -> #nextPutAll:);
	at: #ImageFileName put: 'default.sim'
! !
