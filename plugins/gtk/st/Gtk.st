"
Copyright (c) 2007-2008 Luca Bruno

This file is part of Smalltalk YX.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the 'Software'), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.
"

"Pango declarations"

Object subclass: #PangoAttrList
       instanceVariableNames: ''
       classVariableNames: ''!

"Gtk declarations"

Object subclass: #Gtk
       instanceVariableNames: ''
       classVariableNames: ''!

GPointer subclass: #GtkTextIter
	 instanceVariableNames: ''
	 classVariableNames: ''!

GPointer subclass: #GtkTextAttributes
	 instanceVariableNames: ''
	 classVariableNames: ''!

GPointer subclass: #PangoLanguage
	 instanceVariableNames: ''
	 classVariableNames: ''!

GPointer subclass: #GdkRectangle
	 instanceVariableNames: ''
	 classVariableNames: ''!

GObject subclass: #GtkObject
	instanceVariableNames: ''
	classVariableNames: ''!

GObject subclass: #GtkTextBuffer
	instanceVariableNames: ''
	classVariableNames: ''!

GObject subclass: #GdkDrawable
	instanceVariableNames: ''
	classVariableNames: ''!

GObject subclass: #GtkTextTagTable
	instanceVariableNames: ''
	classVariableNames: ''!

GObject subclass: #GtkTextChildAnchor
	instanceVariableNames: ''
	classVariableNames: ''!

GObject subclass: #GtkTextMark
	instanceVariableNames: ''
	classVariableNames: ''!

GObject subclass: #GtkTextTag
	instanceVariableNames: ''
	classVariableNames: ''!

GdkDrawable subclass: #GdkWindow
	    instanceVariableNames: ''
	    classVariableNames: ''!

GtkObject subclass: #GtkWidget
	  instanceVariableNames: ''
	  classVariableNames: ''!

GtkObject subclass: #GtkAdjustment
	  instanceVariableNames: ''
	  classVariableNames: ''!

GtkWidget subclass: #GtkContainer
	  instanceVariableNames: ''
	  classVariableNames: ''!

GtkWidget subclass: #GtkLabel
	  instanceVariableNames: ''
	  classVariableNames: ''!

GtkWidget subclass: #GtkButton
	  instanceVariableNames: ''
	  classVariableNames: ''!

GtkContainer subclass: #GtkBin
	     instanceVariableNames: ''
	     classVariableNames: ''!

GtkContainer subclass: #GtkWindow
	     instanceVariableNames: ''
	     classVariableNames: ''!

GtkContainer subclass: #GtkBox
	     instanceVariableNames: ''
	     classVariableNames: ''!

GtkContainer subclass: #GtkTextView
	     instanceVariableNames: ''
	     classVariableNames: ''!

GtkBin subclass: #GtkScrolledWindow
       instanceVariableNames: ''
       classVariableNames: ''!

GtkBox subclass: #GtkVBox
       instanceVariableNames: ''
       classVariableNames: ''!

GtkBox subclass: #GtkHBox
       instanceVariableNames: ''
       classVariableNames: ''!

"GUI Tools"

WorkspaceView subclass: #GtkWorkspaceView
	      instanceVariableNames: 'textView'
	      classVariableNames: ''!

Workspace subclass: #GtkWorkspace
	  instanceVariableNames: ''
	  classVariableNames: ''!

"Gtk control class"


!Gtk class methodsFor: 'main loop'!

primMain: idleProcess on: aSemaphore
    <cCall: 'Gtk_main' plugin: 'gtk'>
	self primitiveFailed
!

initialize
    GCallback initialize
!

main
    | proc sem |
    "Use a semaphore to keep the process alive but suspended forever"
    sem := Semaphore new.
    proc := [ [ sem wait ] repeat ] fork.
    self primMain: proc on: sem
!

mainQuit
    <cCall: 'Gtk_mainQuit' plugin: 'gtk'>
	self primitiveFailed
! !


" Initialization code "

Gtk initialize!
