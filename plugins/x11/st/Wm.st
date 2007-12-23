Object subclass: #Wm
       instanceVariableNames: 'display'
       classVariableNames: 'CurrentTime None KeyPress ButtonPress MotionNotify ButtonRelease Expose'!

"Wm control class"

!Wm class methodsFor: ''!

initialize
    finalizationRequest := true.
    KeyPress := 2.
    Expose := 12.
    ButtonPress := 4.
    ButtonRelease := 5.
    MotionNotify := 6.
    CurrentTime := 0.
    None := 0.
!

invoke
    ^self new invoke
!

win
    ^self new win

! !

!Wm methodsFor: 'main loop'!

max: x and: y
    x > y ifTrue: [^x] ifFalse: [^y].
!

corner: btype button: button diff: d
    (button = btype) ifTrue: [^d] ifFalse: [^0]
!

invoke "TinyWM in Syx"
    | rootWindow event attr sb sx sy |
    display := Display open.
    (display isHandleNil) ifTrue: ['Unable to get display' printNl.  ^0 ]
    rootWindow := display defaultRootWindow.
    display grabKey: 'F1' window: rootWindow;
            grabButton: 1 window: rootWindow;
            grabButton: 3 window: rootWindow.
    event := XEvent create.
    attr := XlibXWindowAttributes create.
    [ |tmp eventType sbwin|
        display nextEvent: event.
        eventType := event type.
        sbwin := (event xkey) subwindow.
        (eventType = KeyPress) ifTrue: [
            |skwin|
            skwin := (event xkey) subwindow.
            (skwin ~= None) ifTrue: [
                display raiseWindow: skwin.
            ]
        ]
        (eventType = ButtonPress) ifTrue: [
            |sbwin start|
            sbwin := (event xbutton) subwindow.
            (sbwin ~= None) ifTrue: [
                display grabPointer: sbwin.
                display getWindowAttributes: sbwin attribute: attr.
                start := event xbutton.
                sx := start xroot.
                sy := start yroot.
                sb := start button.
            ]
        ]
        (eventType = MotionNotify) ifTrue: [
            |xdiff ydiff win b x y w h xb|
            [display checkTypedEvent: MotionNotify event: event] whileTrue.
            xb := event xbutton.
            xdiff := (xb xroot) - sx.
            ydiff := (xb yroot) - sy.
            win := (event xmotion) window.

            x := (attr x) + (self corner: 1 button: sb diff: xdiff).
            y := (attr y) + (self corner: 1 button: sb diff: ydiff).
            w := self max: 1 and: ((attr width)+(self corner: 3 button: sb diff: xdiff)).
            h := self max: 1 and: ((attr height)+(self corner: 3 button: sb diff: ydiff)).
            display moveResizeWindow: win x: x y: y width: w height: h.
        ]
        (eventType = ButtonRelease) ifTrue: [
            display unGrabPointer: CurrentTime.
        ]
    ] repeat.
    attr delete.
!

win "Create a simple window with a rectangle on it, and show"
    |screen window parent event cond bpixel wpixel|
    display := Display open.
    (display isHandleNil) ifTrue: ['Unable to get display' printNl.  ^0 ]
    screen := display defaultScreen.
    parent := display rootWindow: screen.
    bpixel := display blackPixel: screen.
    wpixel := display whitePixel: screen.
    window := display createSimpleWindow: parent
            x: 10 y: 10 width: 100 height: 100 bwidth: 1 border: bpixel background: wpixel.
    display selectInput: window eventMask: 32769 "ExposureMask | KeyPressMask".
    display mapWindow: window.
    event := XlibXEvent create.
    cond := 1.
    [cond = 1] whileTrue: [|eventType|
        display nextEvent: event.
        eventType := event type.
        (eventType = Expose) ifTrue: [ |gc|
            gc := display defaultGC: screen.
            display fillRectangle: window gc: gc x: 20 y: 20 width: 10 height: 10
        ].
        (eventType = KeyPress) ifTrue: [
            cond := 0
        ]
    ].

! !

