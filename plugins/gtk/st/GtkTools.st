"
Copyright (c) 2007 Luca Bruno

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

!GtkWorkspaceView methodsFor: 'initialize-release'!

setupUi
    mainWidget := GtkWindow new.
    mainContainer := GtkVBox new.
    mainWidget add: mainContainer.
    mainWidget when: 'destroy' send: self -> #close.
    self setupToolbar.
    self setupText
!

setupToolbar
    | hbox button |
    hbox := GtkHBox new.

    button := GtkButton fromStock: 'gtk-execute'.
    button when: 'clicked' send: self -> #onExecute.
    hbox packStart: button.

    button := GtkButton fromStock: 'gtk-clear'.
    button when: 'clicked' send: self -> #onClear.
    hbox packStart: button.

    button := GtkButton fromStock: 'gtk-quit'.
    button when: 'clicked' send: self -> #onClose.
    hbox packStart: button.

    mainContainer packStart: hbox
!

setupText
    | buffer scrolled |
    buffer := GtkTextBuffer new.
    textView := GtkTextView buffer: buffer.
    scrolled := GtkScrolledWindow new add: textView; yourself.
    mainContainer packStart: scrolled
!

open
    mainWidget showAll
! !

!GtkWorkspaceView methodsFor: 'mvc-events'!

onExecute
    | text buffer |
    buffer := textView buffer.
    text := buffer textFrom: buffer startIter to: buffer endIter includeHiddenChars: false.
    eventDispatcher dispatch: #doIt with: text
!

onClose
    eventDispatcher dispatch: #quit
!

onClear
    textView buffer text: ''
! !

!GtkWorkspace class methodsFor: 'instance creation'!

defaultView
    ^GtkWorkspaceView new
! !
