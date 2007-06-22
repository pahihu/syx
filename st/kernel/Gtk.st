!Gtk class methodsFor: 'main loop'!

main
    <cCall: 'Gtk_main' plugin: 'gtk'>
	self primitiveFailed
!

mainQuit
    <cCall: 'Gtk_mainQuit' plugin: 'gtk'>
	self primitiveFailed
! !

!GObject class methodsFor: 'instance creation'!

new
    ^self subclassResponsibility
!

handler: aPointer
    ^self basicNew handler: aPointer
! !

!GObject methodsFor: 'initialize-release'!

handler: aPointer
    handler := aPointer
! !

!GtkWindow class methodsFor: 'instance creation'!

primNew
    <cCall: 'GtkWindow_new' plugin: 'gtk'>
	self primitiveFailed
!

new
    ^self handler: self primNew
! !

!GtkWidget methodsFor: 'gtk'!

showAll
    <cCall: 'GtkWidget_showAll' plugin: 'gtk'>
	self primitiveFailed
! !

