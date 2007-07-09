!WriteStream class methodsFor: 'instance creation'!

on: aCollection
    ^(self basicNew initializeOn: aCollection)
	truncate;
	yourself
! !
