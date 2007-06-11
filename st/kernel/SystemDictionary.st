!SystemDictionary methodsFor: 'initialize-release'!

initializeSystem
    self
	at: #stdin put: (FileStream on: 0);
	at: #stdout put: (FileStream on: 1);
	at: #stderr put: (FileStream on: 2).
! !
