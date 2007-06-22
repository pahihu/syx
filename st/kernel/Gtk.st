!Gtk class methodsFor: 'main loop'!

main
    <cCall: 'syx_gtk_main' plugin: 'gtk'>
	self primitiveFailed
!

mainQuit
    <cCall: 'syx_gtk_main_quit' plugin: 'gtk'>
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
    <cCall: 'syx_gtk_window_new' plugin: 'gtk'>
	self primitiveFailed
!

new
    ^self handler: self primNew
! !

!GtkWidget methodsFor: 'gtk'!

showAll
    <cCall: 'syx_gtk_widget_show_all' plugin: 'gtk'>
	self primitiveFailed
! !

