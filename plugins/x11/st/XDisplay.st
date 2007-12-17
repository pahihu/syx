"
Copyright (c) 2007 Rahul, Luca Bruno
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

CObject subclass: #XDisplay
        instanceVariableNames: ''
        classVariableNames: ''!

!XDisplay class methodsFor: 'initialize-release'!

initialize
    finalizationRequest := true
! !

!XDisplay class methodsFor: 'instance creation'!

primXOpenDisplay: aString
    <cCall: 'Xlib_XOpenDisplay' plugin: 'x11'>
        self primitiveFailed
!

open
    ^self open: nil
!

open: aStringOrNil
    ^self handle: (self primXOpenDisplay: aStringOrNil)
! !

!XDisplay methodsFor: 'primitives'!

primXCloseDisplay: display
    <cCall: 'Xlib_XCloseDisplay' plugin: 'x11'>
        self primitiveFailed
!

primDefaultRootWindow: display
    <cCall: 'Xlib_DefaultRootWindow' plugin: 'x11'>
        self primitiveFailed
!

primXNextEvent: display
    <cCall: 'Xlib_XNextEvent' plugin: 'x11'>
        self primitiveFailed
! !

!XDisplay methodsFor: 'xlib'!

defaultRootWindow
    ^(XWindow handle: (self primDefaultRootWindow: handle))
        display: self;
        yourself
!

nextEvent
    ^XEvent handle: (self primXNextEvent: handle)
! !

!XDisplay methodsFor: 'finalization'!

close
    | ret |
    ret := self primXCloseDisplay: handle.
    handle := nil.
    ^ret
!

finalize
    self close
! !