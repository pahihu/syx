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

X11Display subclass: #XDisplay
        instanceVariableNames: ''
        classVariableNames: 'Mod1Mask GrabModeAsync ButtonPressMask None CurrentTime'!

!XDisplay class methodsFor: 'initialize-release'!

initialize
    finalizationRequest := true.
    Mod1Mask := 8.
    GrabModeAsync := 1.
    ButtonPressMask := 4.
    CurrentTime := 0.
    None := 0
! !

!XDisplay class methodsFor: 'instance creation'!

open
    ^self open: nil
!

open: aStringOrNil
    ^self handle: (X11 primXOpenDisplay: aStringOrNil)
! !


!XDisplay methodsFor: 'xlib'!

defaultRootWindow
    ^self primXDefaultRootWindow
!

defaultScreen
    ^self primXDefaultScreen
!

rootWindow: screen
    ^self primXRootWindow: screen
!

blackPixel: screen
    ^self primXBlackPixel: screen
!

whitePixel: screen
    ^self primXWhitePixel: screen
!

defaultGC: screen
    ^X11GC handle: (self primXDefaultGC: screen)
!

fillRectangle: window gc: gc x: x y: y width: w height: h
    ^self primXFillRectangle: window gc: gc x: x y: y width: w height: h
!

createSimpleWindow: parent x: x y: y width: w height: h bwidth: bw border: border background: bg
    ^self primXCreateSimpleWindow: parent
        x: x y: y width: w height: h
        borderWidth: bw border: border background: bg
!

xKeysymToKeycode: keySym
    ^self primXKeysymToKeycode: keySym
!

xStringToKeysym: str
    ^X11 primXStringToKeysym: str
!

grabKey: aString window: w
    |keysym keycode|
    keysym := self xStringToKeysym: aString.
    keycode :=  self xKeysymToKeycode: keysym.
    ^self primXGrabKey: keycode
        modifiers: Mod1Mask
        grabWindow: w
        ownerEvents: true
        pointerMode: GrabModeAsync
        keyboardMode: GrabModeAsync
!

grabButton: button window: w
    ^self primXGrabButton: button
        modifiers: Mod1Mask
        grabWindow: w
        ownerEvents: true
        eventMask: ButtonPressMask
        pointerMode: GrabModeAsync
        keyboardMode: GrabModeAsync
        confineTo: None
        cursor: None
!

raiseWindow: w
    ^self primXRaiseWindow: w
!

mapWindow: w
    ^self primXMapWindow: w
!


selectInput: win eventMask: ev
    ^self primXSelectInput: win eventMask: ev
!


grabPointer: window
    ^self primXGrabPointer: window
        ownerEvents: true
        eventMask: 72 "(ButtonReleaseMask|PointerMotionMask)"
        pointerMode: GrabModeAsync
        keyboardMode: GrabModeAsync
        confineTo: None
        cursor: None
        time: CurrentTime
!

unGrabPointer: time
    ^self primXUngrabPointer: time
!

getWindowAttributes: window attribute: attr
    ^self primXGetWindowAttributes: window windowAttributesReturn: attr
!

checkTypedEvent: type event: evt
    ^self primXCheckTypedEvent: type eventReturn: evt
!

moveResizeWindow: win x: x y: y width: w height: h
    ^self primXMoveResizeWindow: win x: x y: y width: w height: h
!

nextEvent: evt
    ^self primXNextEvent: evt
! !

!XDisplay methodsFor: 'finalization'!

close
    | ret |
    ret := self primXCloseDisplay.
    handle := nil.
    ^ret
!

finalize
    self close
! !
