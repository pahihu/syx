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
    self subclassResponsibility
!

handle: aPointer
    ^self basicNew handle: aPointer
! !

!GObject methodsFor: 'initialize-release'!

handle: aPointer
    handle := aPointer
! !

!GObject methodsFor: 'accessing'!

handle
    ^handle
! !

!GtkWindow class methodsFor: 'instance creation'!

primNew
    <cCall: 'GtkWindow_new' plugin: 'gtk'>
	self primitiveFailed
!

new
    ^self handle: self primNew
! !

!GtkWidget methodsFor: 'gtk'!

showAll
    <cCall: 'GtkWidget_showAll' plugin: 'gtk'>
	self primitiveFailed
! !

