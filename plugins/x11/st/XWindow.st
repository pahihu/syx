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


CObject subclass: #XWindow
        instanceVariableNames: 'display'
        classVariableNames: ''!


!XWindow methodsFor: 'primitives'!

primXGrabKey: display root: root key: key
    <cCall: 'Xlib_XGrabKey' plugin: 'x11'>
        self primitiveFailed
!

primXGrabButton: display root: root button: button
    <cCall: 'Xlib_XGrabButton' plugin: 'x11'>
        self primitiveFailed
! !

!XWindow methodsFor: 'xlib'!

grabKey: aString
    ^self primXGrabKey: display handle root: handle key: aString
!

grabButton: buttonNumber
    ^self primXGrabButton: display handle root: handle button: buttonNumber
! !

!XWindow methodsFor: 'accessing'!

display
    ^display
!

display: aXDisplay
    display := aXDisplay
! !
