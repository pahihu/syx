!Gtk class methodsFor: 'main loop'!

mainIterationDo: aBoolean
    <primitive: 'GtkMainIterationDo' module: 'Gtk'>
	^self primitiveFailed
!

main
    [ self mainIterationDo: true ] repeat
! !

!GtkButton class methodsFor: 'instance creation'!

new
    <primitive: 'GtkButtonNew' module: 'Gtk'>
	self primitiveFailed
!

newWithLabel: aString
    <primitive: 'GtkButtonNew' module: 'Gtk'>
	self primitiveFailed
! !

!GtkWindow class methodsFor: 'instance creation'!

new
    <primitive: 'GtkWindowNew' module: 'Gtk'>
	self primitiveFailed
! !

!GtkWindow methodsFor: 'calls'!

showAll
    <primitive: 'GtkWindowShowAll' module: 'Gtk'>
	self primitiveFailed
! !
