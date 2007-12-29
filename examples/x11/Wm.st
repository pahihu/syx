(Smalltalk loadPlugin: 'x11')
    ifFalse: [ self error: 'No X11 plugin was found' ]!

Object subclass: #Wm
       instanceVariableNames: 'display'
       classVariableNames: 'CurrentTime None KeyPress ButtonPress MotionNotify ButtonRelease Expose ExposureMask KeyPressMask'!

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
    ExposureMask := 32768.
    KeyPressMask := 1.
    None := 0.
!

invoke
    ^self initialize new invoke
!

win
    ^self initialize new win

! !

!Wm methodsFor: 'main loop'!

max: x and: y
    x > y ifTrue: [^x] ifFalse: [^y].
!

corner: btype button: button diff: d w: w
    (button = btype) ifTrue: [^(d+w)] ifFalse: [^w]
!

invoke "TinyWM in Syx"
    |rootWindow event attr sb sx sy|
    display := XDisplay open.
    (display isHandleNil) ifTrue: ['Unable to get display' printNl.  ^0 ]
    rootWindow := display defaultRootWindow.
    display grabKey: 'F1' window: rootWindow;
            grabButton: 1 window: rootWindow;
            grabButton: 3 window: rootWindow.
    event := XEvent create.
    attr := X11XWindowAttributes create.
    [
        display nextEvent: event.
        event type caseOf: {
            [KeyPress] -> [ |skwin|
                skwin := (event xkey) subwindow.
                (skwin ~= None) ifTrue: [ display raiseWindow: skwin. ] ].
            [ButtonPress] -> [ |sbwin start|
                sbwin := (event xbutton) subwindow.
                (sbwin ~= None) ifTrue: [
                    display grabPointer: sbwin.
                    display getWindowAttributes: sbwin attribute: attr.
                    start := event xbutton.
                    sx := start xroot.
                    sy := start yroot.
                    sb := start button.
                ] ].
            [MotionNotify] -> [ |xdiff ydiff xb|
                [display checkTypedEvent: MotionNotify event: event] whileTrue.
                xb := event xbutton.
                xdiff := (xb xroot) - sx.
                ydiff := (xb yroot) - sy.

                display moveResizeWindow: ((event xmotion) window)
                    x: (self corner: 1 button: sb diff: xdiff w: attr x)
                    y: (self corner: 1 button: sb diff: ydiff w: attr y)
                    width: (self max: 1 and:
                        (self corner: 3 button: sb diff: xdiff w: attr width))
                    height: (self max: 1 and:
                        (self corner: 3 button: sb diff: ydiff w: attr height)).
            ].
            [ButtonRelease] -> [
                display unGrabPointer: CurrentTime.
            ].
        }.
    ] repeat.
    attr delete.
!

win "Create a simple window with a rectangle on it, and show"
    |screen window event cond bpixel wpixel mask|
    display := XDisplay open.
    (display isHandleNil) ifTrue: ['Unable to get display' printNl.  ^0 ]
    screen := display defaultScreen.
    window := display createSimpleWindow: (display rootWindow: screen)
                x: 10 y: 10 width: 100 height: 100 bwidth: 1
                border: (display blackPixel: screen)
                background: (display whitePixel: screen).
    display selectInput: window
            eventMask: (ExposureMask bitOr: KeyPressMask).
    display mapWindow: window.
    event := X11XEvent create.
    cond := 1.
    [cond = 1] whileTrue: [
        display nextEvent: event.
        event type caseOf: {
            [Expose] -> [ |gc|
                gc := display defaultGC: screen.
                display fillRectangle: window gc: gc
                    x: 20 y: 20 width: 10 height: 10
            ].
            [KeyPress] -> [ cond := 0 ].
        }.
    ].

! !

Wm invoke!