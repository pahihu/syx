CStruct subclass: #X11
        instanceVariableNames: ''
        classVariableNames: ''!

!X11 class methodsFor: 'initialize-release'!

initialize
    finalizationRequest := true.
! !

!X11 class methodsFor: 'X11'!



"_________________________________________________________"
"XNewModifiermap primitive function"
primXNewModifiermap: arg1
    <cCall: 'X11_XNewModifiermap' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XOpenDisplay primitive function"
primXOpenDisplay: arg1
    <cCall: 'X11_XOpenDisplay' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XrmInitialize primitive function"
primXrmInitialize
    <cCall: 'X11_XrmInitialize' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XDisplayName primitive function"
primXDisplayName: arg1
    <cCall: 'X11_XDisplayName' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XKeysymToString primitive function"
primXKeysymToString: arg1
    <cCall: 'X11_XKeysymToString' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XStringToKeysym primitive function"
primXStringToKeysym: arg1
    <cCall: 'X11_XStringToKeysym' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XInitThreads primitive function"
primXInitThreads
    <cCall: 'X11_XInitThreads' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XAllPlanes primitive function"
primXAllPlanes
    <cCall: 'X11_XAllPlanes' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XSetErrorHandler primitive function"
primXSetErrorHandler: arg1
    <cCall: 'X11_XSetErrorHandler' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XSetIOErrorHandler primitive function"
primXSetIOErrorHandler: arg1
    <cCall: 'X11_XSetIOErrorHandler' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XFreeStringList primitive function"
primXFreeStringList: arg1
    <cCall: 'X11_XFreeStringList' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XFree primitive function"
primXFree: arg1
    <cCall: 'X11_XFree' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XFreeExtensionList primitive function"
primXFreeExtensionList: arg1
    <cCall: 'X11_XFreeExtensionList' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XFreeFontInfo primitive function"
primXFreeFontInfo: arg1 freeInfo: arg2 actualCount: arg3
    <cCall: 'X11_XFreeFontInfo' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XFreeFontNames primitive function"
primXFreeFontNames: arg1
    <cCall: 'X11_XFreeFontNames' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XFreeFontPath primitive function"
primXFreeFontPath: arg1
    <cCall: 'X11_XFreeFontPath' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XParseGeometry primitive function"
primXParseGeometry: arg1 xReturn: arg2 yReturn: arg3 widthReturn: arg4 heightReturn: arg5
    <cCall: 'X11_XParseGeometry' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XReadBitmapFileData primitive function"
primXReadBitmapFileData: arg1 widthReturn: arg2 heightReturn: arg3 dataReturn: arg4 xHotReturn: arg5 yHotReturn: arg6
    <cCall: 'X11_XReadBitmapFileData' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XSupportsLocale primitive function"
primXSupportsLocale
    <cCall: 'X11_XSupportsLocale' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XSetLocaleModifiers primitive function"
primXSetLocaleModifiers: arg1
    <cCall: 'X11_XSetLocaleModifiers' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XVaCreateNestedList primitive function"
primXVaCreateNestedList: arg1
    <cCall: 'X11_XVaCreateNestedList' plugin: 'x11'>
    self primitiveFailed
!





name
    ^'X11'

! !

!X11 methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11 methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XIMStatusDrawCallbackStruct
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XIMStatusDrawCallbackStruct class methodsFor: 'initialize-release'!

primX11XIMStatusDrawCallbackStructCreate
    <cCall: 'X11_new_XIMStatusDrawCallbackStruct' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XIMStatusDrawCallbackStructCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XIMStatusDrawCallbackStruct  methodsFor: 'X11'!

"_________________________________________________________"
"type primitive accessors"
primXIMStatusDrawCallbackStructType
    <cCall: 'X11_XIMStatusDrawCallbackStruct_type_get' plugin: 'x11'>
    self primitiveFailed
!
primXIMStatusDrawCallbackStructType: val
    <cCall: 'X11_XIMStatusDrawCallbackStruct_type_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"type accessors"
type
    ^self primXIMStatusDrawCallbackStructType
!
type: val
    ^self primXIMStatusDrawCallbackStructType: val
!

"_________________________________________________________"
"data primitive accessors"
primXIMStatusDrawCallbackStructData
    <cCall: 'X11_XIMStatusDrawCallbackStruct_data_get' plugin: 'x11'>
    self primitiveFailed
!
primXIMStatusDrawCallbackStructData: val
    <cCall: 'X11_XIMStatusDrawCallbackStruct_data_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"data accessors"
data
    ^self primXIMStatusDrawCallbackStructData
!
data: val
    ^self primXIMStatusDrawCallbackStructData: val
!






primX11XIMStatusDrawCallbackStructDelete
    <cCall: 'X11_delete_XIMStatusDrawCallbackStruct' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XIMStatusDrawCallbackStructDelete.
!


name
    ^'X11XIMStatusDrawCallbackStruct'

! !

!X11XIMStatusDrawCallbackStruct methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XIMStatusDrawCallbackStruct methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XIMPreeditDrawCallbackStruct
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XIMPreeditDrawCallbackStruct class methodsFor: 'initialize-release'!

primX11XIMPreeditDrawCallbackStructCreate
    <cCall: 'X11_new_XIMPreeditDrawCallbackStruct' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XIMPreeditDrawCallbackStructCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XIMPreeditDrawCallbackStruct  methodsFor: 'X11'!

"_________________________________________________________"
"caret primitive accessors"
primXIMPreeditDrawCallbackStructCaret
    <cCall: 'X11_XIMPreeditDrawCallbackStruct_caret_get' plugin: 'x11'>
    self primitiveFailed
!
primXIMPreeditDrawCallbackStructCaret: val
    <cCall: 'X11_XIMPreeditDrawCallbackStruct_caret_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"caret accessors"
caret
    ^self primXIMPreeditDrawCallbackStructCaret
!
caret: val
    ^self primXIMPreeditDrawCallbackStructCaret: val
!

"_________________________________________________________"
"chg_first primitive accessors"
primXIMPreeditDrawCallbackStructChgFirst
    <cCall: 'X11_XIMPreeditDrawCallbackStruct_chg_first_get' plugin: 'x11'>
    self primitiveFailed
!
primXIMPreeditDrawCallbackStructChgFirst: val
    <cCall: 'X11_XIMPreeditDrawCallbackStruct_chg_first_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"chg_first accessors"
chgfirst
    ^self primXIMPreeditDrawCallbackStructChgFirst
!
chgfirst: val
    ^self primXIMPreeditDrawCallbackStructChgFirst: val
!

"_________________________________________________________"
"chg_length primitive accessors"
primXIMPreeditDrawCallbackStructChgLength
    <cCall: 'X11_XIMPreeditDrawCallbackStruct_chg_length_get' plugin: 'x11'>
    self primitiveFailed
!
primXIMPreeditDrawCallbackStructChgLength: val
    <cCall: 'X11_XIMPreeditDrawCallbackStruct_chg_length_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"chg_length accessors"
chglength
    ^self primXIMPreeditDrawCallbackStructChgLength
!
chglength: val
    ^self primXIMPreeditDrawCallbackStructChgLength: val
!

"_________________________________________________________"
"text primitive accessors"
primXIMPreeditDrawCallbackStructText
    <cCall: 'X11_XIMPreeditDrawCallbackStruct_text_get' plugin: 'x11'>
    self primitiveFailed
!
primXIMPreeditDrawCallbackStructText: val
    <cCall: 'X11_XIMPreeditDrawCallbackStruct_text_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"text accessors"
text
    ^self primXIMPreeditDrawCallbackStructText
!
text: val
    ^self primXIMPreeditDrawCallbackStructText: val
!






primX11XIMPreeditDrawCallbackStructDelete
    <cCall: 'X11_delete_XIMPreeditDrawCallbackStruct' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XIMPreeditDrawCallbackStructDelete.
!


name
    ^'X11XIMPreeditDrawCallbackStruct'

! !

!X11XIMPreeditDrawCallbackStruct methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XIMPreeditDrawCallbackStruct methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XKeyEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XKeyEvent class methodsFor: 'initialize-release'!

primX11XKeyEventCreate
    <cCall: 'X11_new_XKeyEvent' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XKeyEventCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XKeyEvent  methodsFor: 'X11'!

"_________________________________________________________"
"type primitive accessors"
primXKeyEventType
    <cCall: 'X11_XKeyEvent_type_get' plugin: 'x11'>
    self primitiveFailed
!
primXKeyEventType: val
    <cCall: 'X11_XKeyEvent_type_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"type accessors"
type
    ^self primXKeyEventType
!
type: val
    ^self primXKeyEventType: val
!

"_________________________________________________________"
"serial primitive accessors"
primXKeyEventSerial
    <cCall: 'X11_XKeyEvent_serial_get' plugin: 'x11'>
    self primitiveFailed
!
primXKeyEventSerial: val
    <cCall: 'X11_XKeyEvent_serial_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"serial accessors"
serial
    ^self primXKeyEventSerial
!
serial: val
    ^self primXKeyEventSerial: val
!

"_________________________________________________________"
"send_event primitive accessors"
primXKeyEventSendEvent
    <cCall: 'X11_XKeyEvent_send_event_get' plugin: 'x11'>
    self primitiveFailed
!
primXKeyEventSendEvent: val
    <cCall: 'X11_XKeyEvent_send_event_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"send_event accessors"
sendevent
    ^self primXKeyEventSendEvent
!
sendevent: val
    ^self primXKeyEventSendEvent: val
!

"_________________________________________________________"
"display primitive accessors"
primXKeyEventDisplay
    <cCall: 'X11_XKeyEvent_display_get' plugin: 'x11'>
    self primitiveFailed
!
primXKeyEventDisplay: val
    <cCall: 'X11_XKeyEvent_display_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"display accessors"
display
    ^self primXKeyEventDisplay
!
display: val
    ^self primXKeyEventDisplay: val
!

"_________________________________________________________"
"window primitive accessors"
primXKeyEventWindow
    <cCall: 'X11_XKeyEvent_window_get' plugin: 'x11'>
    self primitiveFailed
!
primXKeyEventWindow: val
    <cCall: 'X11_XKeyEvent_window_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"window accessors"
window
    ^self primXKeyEventWindow
!
window: val
    ^self primXKeyEventWindow: val
!

"_________________________________________________________"
"root primitive accessors"
primXKeyEventRoot
    <cCall: 'X11_XKeyEvent_root_get' plugin: 'x11'>
    self primitiveFailed
!
primXKeyEventRoot: val
    <cCall: 'X11_XKeyEvent_root_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"root accessors"
root
    ^self primXKeyEventRoot
!
root: val
    ^self primXKeyEventRoot: val
!

"_________________________________________________________"
"subwindow primitive accessors"
primXKeyEventSubwindow
    <cCall: 'X11_XKeyEvent_subwindow_get' plugin: 'x11'>
    self primitiveFailed
!
primXKeyEventSubwindow: val
    <cCall: 'X11_XKeyEvent_subwindow_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"subwindow accessors"
subwindow
    ^self primXKeyEventSubwindow
!
subwindow: val
    ^self primXKeyEventSubwindow: val
!

"_________________________________________________________"
"time primitive accessors"
primXKeyEventTime
    <cCall: 'X11_XKeyEvent_time_get' plugin: 'x11'>
    self primitiveFailed
!
primXKeyEventTime: val
    <cCall: 'X11_XKeyEvent_time_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"time accessors"
time
    ^self primXKeyEventTime
!
time: val
    ^self primXKeyEventTime: val
!

"_________________________________________________________"
"x primitive accessors"
primXKeyEventX
    <cCall: 'X11_XKeyEvent_x_get' plugin: 'x11'>
    self primitiveFailed
!
primXKeyEventX: val
    <cCall: 'X11_XKeyEvent_x_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"x accessors"
x
    ^self primXKeyEventX
!
x: val
    ^self primXKeyEventX: val
!

"_________________________________________________________"
"y primitive accessors"
primXKeyEventY
    <cCall: 'X11_XKeyEvent_y_get' plugin: 'x11'>
    self primitiveFailed
!
primXKeyEventY: val
    <cCall: 'X11_XKeyEvent_y_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"y accessors"
y
    ^self primXKeyEventY
!
y: val
    ^self primXKeyEventY: val
!

"_________________________________________________________"
"x_root primitive accessors"
primXKeyEventXRoot
    <cCall: 'X11_XKeyEvent_x_root_get' plugin: 'x11'>
    self primitiveFailed
!
primXKeyEventXRoot: val
    <cCall: 'X11_XKeyEvent_x_root_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"x_root accessors"
xroot
    ^self primXKeyEventXRoot
!
xroot: val
    ^self primXKeyEventXRoot: val
!

"_________________________________________________________"
"y_root primitive accessors"
primXKeyEventYRoot
    <cCall: 'X11_XKeyEvent_y_root_get' plugin: 'x11'>
    self primitiveFailed
!
primXKeyEventYRoot: val
    <cCall: 'X11_XKeyEvent_y_root_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"y_root accessors"
yroot
    ^self primXKeyEventYRoot
!
yroot: val
    ^self primXKeyEventYRoot: val
!

"_________________________________________________________"
"state primitive accessors"
primXKeyEventState
    <cCall: 'X11_XKeyEvent_state_get' plugin: 'x11'>
    self primitiveFailed
!
primXKeyEventState: val
    <cCall: 'X11_XKeyEvent_state_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"state accessors"
state
    ^self primXKeyEventState
!
state: val
    ^self primXKeyEventState: val
!

"_________________________________________________________"
"keycode primitive accessors"
primXKeyEventKeycode
    <cCall: 'X11_XKeyEvent_keycode_get' plugin: 'x11'>
    self primitiveFailed
!
primXKeyEventKeycode: val
    <cCall: 'X11_XKeyEvent_keycode_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"keycode accessors"
keycode
    ^self primXKeyEventKeycode
!
keycode: val
    ^self primXKeyEventKeycode: val
!

"_________________________________________________________"
"same_screen primitive accessors"
primXKeyEventSameScreen
    <cCall: 'X11_XKeyEvent_same_screen_get' plugin: 'x11'>
    self primitiveFailed
!
primXKeyEventSameScreen: val
    <cCall: 'X11_XKeyEvent_same_screen_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"same_screen accessors"
samescreen
    ^self primXKeyEventSameScreen
!
samescreen: val
    ^self primXKeyEventSameScreen: val
!



"_________________________________________________________"
"XLookupKeysym primitive function"
primXLookupKeysym: arg1
    <cCall: 'X11_XLookupKeysym' plugin: 'x11'>
    self primitiveFailed
!




primX11XKeyEventDelete
    <cCall: 'X11_delete_XKeyEvent' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XKeyEventDelete.
!


name
    ^'X11XKeyEvent'

! !

!X11XKeyEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XKeyEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XMapRequestEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XMapRequestEvent class methodsFor: 'initialize-release'!

primX11XMapRequestEventCreate
    <cCall: 'X11_new_XMapRequestEvent' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XMapRequestEventCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XMapRequestEvent  methodsFor: 'X11'!

"_________________________________________________________"
"type primitive accessors"
primXMapRequestEventType
    <cCall: 'X11_XMapRequestEvent_type_get' plugin: 'x11'>
    self primitiveFailed
!
primXMapRequestEventType: val
    <cCall: 'X11_XMapRequestEvent_type_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"type accessors"
type
    ^self primXMapRequestEventType
!
type: val
    ^self primXMapRequestEventType: val
!

"_________________________________________________________"
"serial primitive accessors"
primXMapRequestEventSerial
    <cCall: 'X11_XMapRequestEvent_serial_get' plugin: 'x11'>
    self primitiveFailed
!
primXMapRequestEventSerial: val
    <cCall: 'X11_XMapRequestEvent_serial_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"serial accessors"
serial
    ^self primXMapRequestEventSerial
!
serial: val
    ^self primXMapRequestEventSerial: val
!

"_________________________________________________________"
"send_event primitive accessors"
primXMapRequestEventSendEvent
    <cCall: 'X11_XMapRequestEvent_send_event_get' plugin: 'x11'>
    self primitiveFailed
!
primXMapRequestEventSendEvent: val
    <cCall: 'X11_XMapRequestEvent_send_event_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"send_event accessors"
sendevent
    ^self primXMapRequestEventSendEvent
!
sendevent: val
    ^self primXMapRequestEventSendEvent: val
!

"_________________________________________________________"
"display primitive accessors"
primXMapRequestEventDisplay
    <cCall: 'X11_XMapRequestEvent_display_get' plugin: 'x11'>
    self primitiveFailed
!
primXMapRequestEventDisplay: val
    <cCall: 'X11_XMapRequestEvent_display_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"display accessors"
display
    ^self primXMapRequestEventDisplay
!
display: val
    ^self primXMapRequestEventDisplay: val
!

"_________________________________________________________"
"parent primitive accessors"
primXMapRequestEventParent
    <cCall: 'X11_XMapRequestEvent_parent_get' plugin: 'x11'>
    self primitiveFailed
!
primXMapRequestEventParent: val
    <cCall: 'X11_XMapRequestEvent_parent_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"parent accessors"
parent
    ^self primXMapRequestEventParent
!
parent: val
    ^self primXMapRequestEventParent: val
!

"_________________________________________________________"
"window primitive accessors"
primXMapRequestEventWindow
    <cCall: 'X11_XMapRequestEvent_window_get' plugin: 'x11'>
    self primitiveFailed
!
primXMapRequestEventWindow: val
    <cCall: 'X11_XMapRequestEvent_window_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"window accessors"
window
    ^self primXMapRequestEventWindow
!
window: val
    ^self primXMapRequestEventWindow: val
!






primX11XMapRequestEventDelete
    <cCall: 'X11_delete_XMapRequestEvent' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XMapRequestEventDelete.
!


name
    ^'X11XMapRequestEvent'

! !

!X11XMapRequestEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XMapRequestEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XTextItem
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XTextItem class methodsFor: 'initialize-release'!

primX11XTextItemCreate
    <cCall: 'X11_new_XTextItem' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XTextItemCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XTextItem  methodsFor: 'X11'!

"_________________________________________________________"
"chars primitive accessors"
primXTextItemChars
    <cCall: 'X11_XTextItem_chars_get' plugin: 'x11'>
    self primitiveFailed
!
primXTextItemChars: val
    <cCall: 'X11_XTextItem_chars_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"chars accessors"
chars
    ^self primXTextItemChars
!
chars: val
    ^self primXTextItemChars: val
!

"_________________________________________________________"
"nchars primitive accessors"
primXTextItemNchars
    <cCall: 'X11_XTextItem_nchars_get' plugin: 'x11'>
    self primitiveFailed
!
primXTextItemNchars: val
    <cCall: 'X11_XTextItem_nchars_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"nchars accessors"
nchars
    ^self primXTextItemNchars
!
nchars: val
    ^self primXTextItemNchars: val
!

"_________________________________________________________"
"delta primitive accessors"
primXTextItemDelta
    <cCall: 'X11_XTextItem_delta_get' plugin: 'x11'>
    self primitiveFailed
!
primXTextItemDelta: val
    <cCall: 'X11_XTextItem_delta_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"delta accessors"
delta
    ^self primXTextItemDelta
!
delta: val
    ^self primXTextItemDelta: val
!

"_________________________________________________________"
"font primitive accessors"
primXTextItemFont
    <cCall: 'X11_XTextItem_font_get' plugin: 'x11'>
    self primitiveFailed
!
primXTextItemFont: val
    <cCall: 'X11_XTextItem_font_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"font accessors"
font
    ^self primXTextItemFont
!
font: val
    ^self primXTextItemFont: val
!






primX11XTextItemDelete
    <cCall: 'X11_delete_XTextItem' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XTextItemDelete.
!


name
    ^'X11XTextItem'

! !

!X11XTextItem methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XTextItem methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11Visual
        instanceVariableNames: ''
        classVariableNames: ''!

!X11Visual class methodsFor: 'initialize-release'!

primX11VisualCreate
    <cCall: 'X11_new_Visual' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11VisualCreate).
!

initialize
    finalizationRequest := true.
! !

!X11Visual  methodsFor: 'X11'!

"_________________________________________________________"
"ext_data primitive accessors"
primVisualExtData
    <cCall: 'X11_Visual_ext_data_get' plugin: 'x11'>
    self primitiveFailed
!
primVisualExtData: val
    <cCall: 'X11_Visual_ext_data_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"ext_data accessors"
extdata
    ^self primVisualExtData
!
extdata: val
    ^self primVisualExtData: val
!

"_________________________________________________________"
"visualid primitive accessors"
primVisualVisualid
    <cCall: 'X11_Visual_visualid_get' plugin: 'x11'>
    self primitiveFailed
!
primVisualVisualid: val
    <cCall: 'X11_Visual_visualid_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"visualid accessors"
visualid
    ^self primVisualVisualid
!
visualid: val
    ^self primVisualVisualid: val
!

"_________________________________________________________"
"class primitive accessors"
primVisualClass
    <cCall: 'X11_Visual_class_get' plugin: 'x11'>
    self primitiveFailed
!
primVisualClass: val
    <cCall: 'X11_Visual_class_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"class accessors"
class
    ^self primVisualClass
!
class: val
    ^self primVisualClass: val
!

"_________________________________________________________"
"red_mask primitive accessors"
primVisualRedMask
    <cCall: 'X11_Visual_red_mask_get' plugin: 'x11'>
    self primitiveFailed
!
primVisualRedMask: val
    <cCall: 'X11_Visual_red_mask_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"red_mask accessors"
redmask
    ^self primVisualRedMask
!
redmask: val
    ^self primVisualRedMask: val
!

"_________________________________________________________"
"green_mask primitive accessors"
primVisualGreenMask
    <cCall: 'X11_Visual_green_mask_get' plugin: 'x11'>
    self primitiveFailed
!
primVisualGreenMask: val
    <cCall: 'X11_Visual_green_mask_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"green_mask accessors"
greenmask
    ^self primVisualGreenMask
!
greenmask: val
    ^self primVisualGreenMask: val
!

"_________________________________________________________"
"blue_mask primitive accessors"
primVisualBlueMask
    <cCall: 'X11_Visual_blue_mask_get' plugin: 'x11'>
    self primitiveFailed
!
primVisualBlueMask: val
    <cCall: 'X11_Visual_blue_mask_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"blue_mask accessors"
bluemask
    ^self primVisualBlueMask
!
bluemask: val
    ^self primVisualBlueMask: val
!

"_________________________________________________________"
"bits_per_rgb primitive accessors"
primVisualBitsPerRgb
    <cCall: 'X11_Visual_bits_per_rgb_get' plugin: 'x11'>
    self primitiveFailed
!
primVisualBitsPerRgb: val
    <cCall: 'X11_Visual_bits_per_rgb_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"bits_per_rgb accessors"
bitsperrgb
    ^self primVisualBitsPerRgb
!
bitsperrgb: val
    ^self primVisualBitsPerRgb: val
!

"_________________________________________________________"
"map_entries primitive accessors"
primVisualMapEntries
    <cCall: 'X11_Visual_map_entries_get' plugin: 'x11'>
    self primitiveFailed
!
primVisualMapEntries: val
    <cCall: 'X11_Visual_map_entries_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"map_entries accessors"
mapentries
    ^self primVisualMapEntries
!
mapentries: val
    ^self primVisualMapEntries: val
!



"_________________________________________________________"
"XVisualIDFromVisual primitive function"
primXVisualIDFromVisual
    <cCall: 'X11_XVisualIDFromVisual' plugin: 'x11'>
    self primitiveFailed
!




primX11VisualDelete
    <cCall: 'X11_delete_Visual' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11VisualDelete.
!


name
    ^'X11Visual'

! !

!X11Visual methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11Visual methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XCrossingEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XCrossingEvent class methodsFor: 'initialize-release'!

primX11XCrossingEventCreate
    <cCall: 'X11_new_XCrossingEvent' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XCrossingEventCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XCrossingEvent  methodsFor: 'X11'!

"_________________________________________________________"
"type primitive accessors"
primXCrossingEventType
    <cCall: 'X11_XCrossingEvent_type_get' plugin: 'x11'>
    self primitiveFailed
!
primXCrossingEventType: val
    <cCall: 'X11_XCrossingEvent_type_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"type accessors"
type
    ^self primXCrossingEventType
!
type: val
    ^self primXCrossingEventType: val
!

"_________________________________________________________"
"serial primitive accessors"
primXCrossingEventSerial
    <cCall: 'X11_XCrossingEvent_serial_get' plugin: 'x11'>
    self primitiveFailed
!
primXCrossingEventSerial: val
    <cCall: 'X11_XCrossingEvent_serial_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"serial accessors"
serial
    ^self primXCrossingEventSerial
!
serial: val
    ^self primXCrossingEventSerial: val
!

"_________________________________________________________"
"send_event primitive accessors"
primXCrossingEventSendEvent
    <cCall: 'X11_XCrossingEvent_send_event_get' plugin: 'x11'>
    self primitiveFailed
!
primXCrossingEventSendEvent: val
    <cCall: 'X11_XCrossingEvent_send_event_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"send_event accessors"
sendevent
    ^self primXCrossingEventSendEvent
!
sendevent: val
    ^self primXCrossingEventSendEvent: val
!

"_________________________________________________________"
"display primitive accessors"
primXCrossingEventDisplay
    <cCall: 'X11_XCrossingEvent_display_get' plugin: 'x11'>
    self primitiveFailed
!
primXCrossingEventDisplay: val
    <cCall: 'X11_XCrossingEvent_display_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"display accessors"
display
    ^self primXCrossingEventDisplay
!
display: val
    ^self primXCrossingEventDisplay: val
!

"_________________________________________________________"
"window primitive accessors"
primXCrossingEventWindow
    <cCall: 'X11_XCrossingEvent_window_get' plugin: 'x11'>
    self primitiveFailed
!
primXCrossingEventWindow: val
    <cCall: 'X11_XCrossingEvent_window_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"window accessors"
window
    ^self primXCrossingEventWindow
!
window: val
    ^self primXCrossingEventWindow: val
!

"_________________________________________________________"
"root primitive accessors"
primXCrossingEventRoot
    <cCall: 'X11_XCrossingEvent_root_get' plugin: 'x11'>
    self primitiveFailed
!
primXCrossingEventRoot: val
    <cCall: 'X11_XCrossingEvent_root_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"root accessors"
root
    ^self primXCrossingEventRoot
!
root: val
    ^self primXCrossingEventRoot: val
!

"_________________________________________________________"
"subwindow primitive accessors"
primXCrossingEventSubwindow
    <cCall: 'X11_XCrossingEvent_subwindow_get' plugin: 'x11'>
    self primitiveFailed
!
primXCrossingEventSubwindow: val
    <cCall: 'X11_XCrossingEvent_subwindow_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"subwindow accessors"
subwindow
    ^self primXCrossingEventSubwindow
!
subwindow: val
    ^self primXCrossingEventSubwindow: val
!

"_________________________________________________________"
"time primitive accessors"
primXCrossingEventTime
    <cCall: 'X11_XCrossingEvent_time_get' plugin: 'x11'>
    self primitiveFailed
!
primXCrossingEventTime: val
    <cCall: 'X11_XCrossingEvent_time_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"time accessors"
time
    ^self primXCrossingEventTime
!
time: val
    ^self primXCrossingEventTime: val
!

"_________________________________________________________"
"x primitive accessors"
primXCrossingEventX
    <cCall: 'X11_XCrossingEvent_x_get' plugin: 'x11'>
    self primitiveFailed
!
primXCrossingEventX: val
    <cCall: 'X11_XCrossingEvent_x_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"x accessors"
x
    ^self primXCrossingEventX
!
x: val
    ^self primXCrossingEventX: val
!

"_________________________________________________________"
"y primitive accessors"
primXCrossingEventY
    <cCall: 'X11_XCrossingEvent_y_get' plugin: 'x11'>
    self primitiveFailed
!
primXCrossingEventY: val
    <cCall: 'X11_XCrossingEvent_y_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"y accessors"
y
    ^self primXCrossingEventY
!
y: val
    ^self primXCrossingEventY: val
!

"_________________________________________________________"
"x_root primitive accessors"
primXCrossingEventXRoot
    <cCall: 'X11_XCrossingEvent_x_root_get' plugin: 'x11'>
    self primitiveFailed
!
primXCrossingEventXRoot: val
    <cCall: 'X11_XCrossingEvent_x_root_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"x_root accessors"
xroot
    ^self primXCrossingEventXRoot
!
xroot: val
    ^self primXCrossingEventXRoot: val
!

"_________________________________________________________"
"y_root primitive accessors"
primXCrossingEventYRoot
    <cCall: 'X11_XCrossingEvent_y_root_get' plugin: 'x11'>
    self primitiveFailed
!
primXCrossingEventYRoot: val
    <cCall: 'X11_XCrossingEvent_y_root_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"y_root accessors"
yroot
    ^self primXCrossingEventYRoot
!
yroot: val
    ^self primXCrossingEventYRoot: val
!

"_________________________________________________________"
"mode primitive accessors"
primXCrossingEventMode
    <cCall: 'X11_XCrossingEvent_mode_get' plugin: 'x11'>
    self primitiveFailed
!
primXCrossingEventMode: val
    <cCall: 'X11_XCrossingEvent_mode_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"mode accessors"
mode
    ^self primXCrossingEventMode
!
mode: val
    ^self primXCrossingEventMode: val
!

"_________________________________________________________"
"detail primitive accessors"
primXCrossingEventDetail
    <cCall: 'X11_XCrossingEvent_detail_get' plugin: 'x11'>
    self primitiveFailed
!
primXCrossingEventDetail: val
    <cCall: 'X11_XCrossingEvent_detail_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"detail accessors"
detail
    ^self primXCrossingEventDetail
!
detail: val
    ^self primXCrossingEventDetail: val
!

"_________________________________________________________"
"same_screen primitive accessors"
primXCrossingEventSameScreen
    <cCall: 'X11_XCrossingEvent_same_screen_get' plugin: 'x11'>
    self primitiveFailed
!
primXCrossingEventSameScreen: val
    <cCall: 'X11_XCrossingEvent_same_screen_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"same_screen accessors"
samescreen
    ^self primXCrossingEventSameScreen
!
samescreen: val
    ^self primXCrossingEventSameScreen: val
!

"_________________________________________________________"
"focus primitive accessors"
primXCrossingEventFocus
    <cCall: 'X11_XCrossingEvent_focus_get' plugin: 'x11'>
    self primitiveFailed
!
primXCrossingEventFocus: val
    <cCall: 'X11_XCrossingEvent_focus_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"focus accessors"
focus
    ^self primXCrossingEventFocus
!
focus: val
    ^self primXCrossingEventFocus: val
!

"_________________________________________________________"
"state primitive accessors"
primXCrossingEventState
    <cCall: 'X11_XCrossingEvent_state_get' plugin: 'x11'>
    self primitiveFailed
!
primXCrossingEventState: val
    <cCall: 'X11_XCrossingEvent_state_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"state accessors"
state
    ^self primXCrossingEventState
!
state: val
    ^self primXCrossingEventState: val
!






primX11XCrossingEventDelete
    <cCall: 'X11_delete_XCrossingEvent' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XCrossingEventDelete.
!


name
    ^'X11XCrossingEvent'

! !

!X11XCrossingEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XCrossingEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XIMStatusDrawCallbackStructData
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XIMStatusDrawCallbackStructData class methodsFor: 'initialize-release'!

primX11XIMStatusDrawCallbackStructDataCreate
    <cCall: 'X11_new_XIMStatusDrawCallbackStruct_data' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XIMStatusDrawCallbackStructDataCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XIMStatusDrawCallbackStructData  methodsFor: 'X11'!

"_________________________________________________________"
"text primitive accessors"
primXIMStatusDrawCallbackStructDataText
    <cCall: 'X11_XIMStatusDrawCallbackStruct_data_text_get' plugin: 'x11'>
    self primitiveFailed
!
primXIMStatusDrawCallbackStructDataText: val
    <cCall: 'X11_XIMStatusDrawCallbackStruct_data_text_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"text accessors"
text
    ^self primXIMStatusDrawCallbackStructDataText
!
text: val
    ^self primXIMStatusDrawCallbackStructDataText: val
!

"_________________________________________________________"
"bitmap primitive accessors"
primXIMStatusDrawCallbackStructDataBitmap
    <cCall: 'X11_XIMStatusDrawCallbackStruct_data_bitmap_get' plugin: 'x11'>
    self primitiveFailed
!
primXIMStatusDrawCallbackStructDataBitmap: val
    <cCall: 'X11_XIMStatusDrawCallbackStruct_data_bitmap_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"bitmap accessors"
bitmap
    ^self primXIMStatusDrawCallbackStructDataBitmap
!
bitmap: val
    ^self primXIMStatusDrawCallbackStructDataBitmap: val
!






primX11XIMStatusDrawCallbackStructDataDelete
    <cCall: 'X11_delete_XIMStatusDrawCallbackStruct_data' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XIMStatusDrawCallbackStructDataDelete.
!


name
    ^'X11XIMStatusDrawCallbackStructData'

! !

!X11XIMStatusDrawCallbackStructData methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XIMStatusDrawCallbackStructData methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XOMFontInfo
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XOMFontInfo class methodsFor: 'initialize-release'!

primX11XOMFontInfoCreate
    <cCall: 'X11_new_XOMFontInfo' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XOMFontInfoCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XOMFontInfo  methodsFor: 'X11'!

"_________________________________________________________"
"num_font primitive accessors"
primXOMFontInfoNumFont
    <cCall: 'X11_XOMFontInfo_num_font_get' plugin: 'x11'>
    self primitiveFailed
!
primXOMFontInfoNumFont: val
    <cCall: 'X11_XOMFontInfo_num_font_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"num_font accessors"
numfont
    ^self primXOMFontInfoNumFont
!
numfont: val
    ^self primXOMFontInfoNumFont: val
!

"_________________________________________________________"
"font_struct_list primitive accessors"
primXOMFontInfoFontStructList
    <cCall: 'X11_XOMFontInfo_font_struct_list_get' plugin: 'x11'>
    self primitiveFailed
!
primXOMFontInfoFontStructList: val
    <cCall: 'X11_XOMFontInfo_font_struct_list_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"font_struct_list accessors"
fontstructlist
    ^self primXOMFontInfoFontStructList
!
fontstructlist: val
    ^self primXOMFontInfoFontStructList: val
!

"_________________________________________________________"
"font_name_list primitive accessors"
primXOMFontInfoFontNameList
    <cCall: 'X11_XOMFontInfo_font_name_list_get' plugin: 'x11'>
    self primitiveFailed
!
primXOMFontInfoFontNameList: val
    <cCall: 'X11_XOMFontInfo_font_name_list_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"font_name_list accessors"
fontnamelist
    ^self primXOMFontInfoFontNameList
!
fontnamelist: val
    ^self primXOMFontInfoFontNameList: val
!






primX11XOMFontInfoDelete
    <cCall: 'X11_delete_XOMFontInfo' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XOMFontInfoDelete.
!


name
    ^'X11XOMFontInfo'

! !

!X11XOMFontInfo methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XOMFontInfo methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XFontProp
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XFontProp class methodsFor: 'initialize-release'!

primX11XFontPropCreate
    <cCall: 'X11_new_XFontProp' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XFontPropCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XFontProp  methodsFor: 'X11'!

"_________________________________________________________"
"name primitive accessors"
primXFontPropName
    <cCall: 'X11_XFontProp_name_get' plugin: 'x11'>
    self primitiveFailed
!
primXFontPropName: val
    <cCall: 'X11_XFontProp_name_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"name accessors"
name
    ^self primXFontPropName
!
name: val
    ^self primXFontPropName: val
!

"_________________________________________________________"
"card32 primitive accessors"
primXFontPropCard32
    <cCall: 'X11_XFontProp_card32_get' plugin: 'x11'>
    self primitiveFailed
!
primXFontPropCard32: val
    <cCall: 'X11_XFontProp_card32_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"card32 accessors"
card32
    ^self primXFontPropCard32
!
card32: val
    ^self primXFontPropCard32: val
!






primX11XFontPropDelete
    <cCall: 'X11_delete_XFontProp' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XFontPropDelete.
!


name
    ^'X11XFontProp'

! !

!X11XFontProp methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XFontProp methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XSelectionEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XSelectionEvent class methodsFor: 'initialize-release'!

primX11XSelectionEventCreate
    <cCall: 'X11_new_XSelectionEvent' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XSelectionEventCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XSelectionEvent  methodsFor: 'X11'!

"_________________________________________________________"
"type primitive accessors"
primXSelectionEventType
    <cCall: 'X11_XSelectionEvent_type_get' plugin: 'x11'>
    self primitiveFailed
!
primXSelectionEventType: val
    <cCall: 'X11_XSelectionEvent_type_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"type accessors"
type
    ^self primXSelectionEventType
!
type: val
    ^self primXSelectionEventType: val
!

"_________________________________________________________"
"serial primitive accessors"
primXSelectionEventSerial
    <cCall: 'X11_XSelectionEvent_serial_get' plugin: 'x11'>
    self primitiveFailed
!
primXSelectionEventSerial: val
    <cCall: 'X11_XSelectionEvent_serial_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"serial accessors"
serial
    ^self primXSelectionEventSerial
!
serial: val
    ^self primXSelectionEventSerial: val
!

"_________________________________________________________"
"send_event primitive accessors"
primXSelectionEventSendEvent
    <cCall: 'X11_XSelectionEvent_send_event_get' plugin: 'x11'>
    self primitiveFailed
!
primXSelectionEventSendEvent: val
    <cCall: 'X11_XSelectionEvent_send_event_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"send_event accessors"
sendevent
    ^self primXSelectionEventSendEvent
!
sendevent: val
    ^self primXSelectionEventSendEvent: val
!

"_________________________________________________________"
"display primitive accessors"
primXSelectionEventDisplay
    <cCall: 'X11_XSelectionEvent_display_get' plugin: 'x11'>
    self primitiveFailed
!
primXSelectionEventDisplay: val
    <cCall: 'X11_XSelectionEvent_display_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"display accessors"
display
    ^self primXSelectionEventDisplay
!
display: val
    ^self primXSelectionEventDisplay: val
!

"_________________________________________________________"
"requestor primitive accessors"
primXSelectionEventRequestor
    <cCall: 'X11_XSelectionEvent_requestor_get' plugin: 'x11'>
    self primitiveFailed
!
primXSelectionEventRequestor: val
    <cCall: 'X11_XSelectionEvent_requestor_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"requestor accessors"
requestor
    ^self primXSelectionEventRequestor
!
requestor: val
    ^self primXSelectionEventRequestor: val
!

"_________________________________________________________"
"selection primitive accessors"
primXSelectionEventSelection
    <cCall: 'X11_XSelectionEvent_selection_get' plugin: 'x11'>
    self primitiveFailed
!
primXSelectionEventSelection: val
    <cCall: 'X11_XSelectionEvent_selection_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"selection accessors"
selection
    ^self primXSelectionEventSelection
!
selection: val
    ^self primXSelectionEventSelection: val
!

"_________________________________________________________"
"target primitive accessors"
primXSelectionEventTarget
    <cCall: 'X11_XSelectionEvent_target_get' plugin: 'x11'>
    self primitiveFailed
!
primXSelectionEventTarget: val
    <cCall: 'X11_XSelectionEvent_target_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"target accessors"
target
    ^self primXSelectionEventTarget
!
target: val
    ^self primXSelectionEventTarget: val
!

"_________________________________________________________"
"property primitive accessors"
primXSelectionEventProperty
    <cCall: 'X11_XSelectionEvent_property_get' plugin: 'x11'>
    self primitiveFailed
!
primXSelectionEventProperty: val
    <cCall: 'X11_XSelectionEvent_property_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"property accessors"
property
    ^self primXSelectionEventProperty
!
property: val
    ^self primXSelectionEventProperty: val
!

"_________________________________________________________"
"time primitive accessors"
primXSelectionEventTime
    <cCall: 'X11_XSelectionEvent_time_get' plugin: 'x11'>
    self primitiveFailed
!
primXSelectionEventTime: val
    <cCall: 'X11_XSelectionEvent_time_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"time accessors"
time
    ^self primXSelectionEventTime
!
time: val
    ^self primXSelectionEventTime: val
!






primX11XSelectionEventDelete
    <cCall: 'X11_delete_XSelectionEvent' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XSelectionEventDelete.
!


name
    ^'X11XSelectionEvent'

! !

!X11XSelectionEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XSelectionEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XPixmapFormatValues
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XPixmapFormatValues class methodsFor: 'initialize-release'!

primX11XPixmapFormatValuesCreate
    <cCall: 'X11_new_XPixmapFormatValues' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XPixmapFormatValuesCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XPixmapFormatValues  methodsFor: 'X11'!

"_________________________________________________________"
"depth primitive accessors"
primXPixmapFormatValuesDepth
    <cCall: 'X11_XPixmapFormatValues_depth_get' plugin: 'x11'>
    self primitiveFailed
!
primXPixmapFormatValuesDepth: val
    <cCall: 'X11_XPixmapFormatValues_depth_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"depth accessors"
depth
    ^self primXPixmapFormatValuesDepth
!
depth: val
    ^self primXPixmapFormatValuesDepth: val
!

"_________________________________________________________"
"bits_per_pixel primitive accessors"
primXPixmapFormatValuesBitsPerPixel
    <cCall: 'X11_XPixmapFormatValues_bits_per_pixel_get' plugin: 'x11'>
    self primitiveFailed
!
primXPixmapFormatValuesBitsPerPixel: val
    <cCall: 'X11_XPixmapFormatValues_bits_per_pixel_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"bits_per_pixel accessors"
bitsperpixel
    ^self primXPixmapFormatValuesBitsPerPixel
!
bitsperpixel: val
    ^self primXPixmapFormatValuesBitsPerPixel: val
!

"_________________________________________________________"
"scanline_pad primitive accessors"
primXPixmapFormatValuesScanlinePad
    <cCall: 'X11_XPixmapFormatValues_scanline_pad_get' plugin: 'x11'>
    self primitiveFailed
!
primXPixmapFormatValuesScanlinePad: val
    <cCall: 'X11_XPixmapFormatValues_scanline_pad_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"scanline_pad accessors"
scanlinepad
    ^self primXPixmapFormatValuesScanlinePad
!
scanlinepad: val
    ^self primXPixmapFormatValuesScanlinePad: val
!






primX11XPixmapFormatValuesDelete
    <cCall: 'X11_delete_XPixmapFormatValues' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XPixmapFormatValuesDelete.
!


name
    ^'X11XPixmapFormatValues'

! !

!X11XPixmapFormatValues methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XPixmapFormatValues methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XPoint
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XPoint class methodsFor: 'initialize-release'!

primX11XPointCreate
    <cCall: 'X11_new_XPoint' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XPointCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XPoint  methodsFor: 'X11'!

"_________________________________________________________"
"x primitive accessors"
primXPointX
    <cCall: 'X11_XPoint_x_get' plugin: 'x11'>
    self primitiveFailed
!
primXPointX: val
    <cCall: 'X11_XPoint_x_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"x accessors"
x
    ^self primXPointX
!
x: val
    ^self primXPointX: val
!

"_________________________________________________________"
"y primitive accessors"
primXPointY
    <cCall: 'X11_XPoint_y_get' plugin: 'x11'>
    self primitiveFailed
!
primXPointY: val
    <cCall: 'X11_XPoint_y_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"y accessors"
y
    ^self primXPointY
!
y: val
    ^self primXPointY: val
!






primX11XPointDelete
    <cCall: 'X11_delete_XPoint' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XPointDelete.
!


name
    ^'X11XPoint'

! !

!X11XPoint methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XPoint methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XCirculateRequestEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XCirculateRequestEvent class methodsFor: 'initialize-release'!

primX11XCirculateRequestEventCreate
    <cCall: 'X11_new_XCirculateRequestEvent' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XCirculateRequestEventCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XCirculateRequestEvent  methodsFor: 'X11'!

"_________________________________________________________"
"type primitive accessors"
primXCirculateRequestEventType
    <cCall: 'X11_XCirculateRequestEvent_type_get' plugin: 'x11'>
    self primitiveFailed
!
primXCirculateRequestEventType: val
    <cCall: 'X11_XCirculateRequestEvent_type_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"type accessors"
type
    ^self primXCirculateRequestEventType
!
type: val
    ^self primXCirculateRequestEventType: val
!

"_________________________________________________________"
"serial primitive accessors"
primXCirculateRequestEventSerial
    <cCall: 'X11_XCirculateRequestEvent_serial_get' plugin: 'x11'>
    self primitiveFailed
!
primXCirculateRequestEventSerial: val
    <cCall: 'X11_XCirculateRequestEvent_serial_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"serial accessors"
serial
    ^self primXCirculateRequestEventSerial
!
serial: val
    ^self primXCirculateRequestEventSerial: val
!

"_________________________________________________________"
"send_event primitive accessors"
primXCirculateRequestEventSendEvent
    <cCall: 'X11_XCirculateRequestEvent_send_event_get' plugin: 'x11'>
    self primitiveFailed
!
primXCirculateRequestEventSendEvent: val
    <cCall: 'X11_XCirculateRequestEvent_send_event_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"send_event accessors"
sendevent
    ^self primXCirculateRequestEventSendEvent
!
sendevent: val
    ^self primXCirculateRequestEventSendEvent: val
!

"_________________________________________________________"
"display primitive accessors"
primXCirculateRequestEventDisplay
    <cCall: 'X11_XCirculateRequestEvent_display_get' plugin: 'x11'>
    self primitiveFailed
!
primXCirculateRequestEventDisplay: val
    <cCall: 'X11_XCirculateRequestEvent_display_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"display accessors"
display
    ^self primXCirculateRequestEventDisplay
!
display: val
    ^self primXCirculateRequestEventDisplay: val
!

"_________________________________________________________"
"parent primitive accessors"
primXCirculateRequestEventParent
    <cCall: 'X11_XCirculateRequestEvent_parent_get' plugin: 'x11'>
    self primitiveFailed
!
primXCirculateRequestEventParent: val
    <cCall: 'X11_XCirculateRequestEvent_parent_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"parent accessors"
parent
    ^self primXCirculateRequestEventParent
!
parent: val
    ^self primXCirculateRequestEventParent: val
!

"_________________________________________________________"
"window primitive accessors"
primXCirculateRequestEventWindow
    <cCall: 'X11_XCirculateRequestEvent_window_get' plugin: 'x11'>
    self primitiveFailed
!
primXCirculateRequestEventWindow: val
    <cCall: 'X11_XCirculateRequestEvent_window_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"window accessors"
window
    ^self primXCirculateRequestEventWindow
!
window: val
    ^self primXCirculateRequestEventWindow: val
!

"_________________________________________________________"
"place primitive accessors"
primXCirculateRequestEventPlace
    <cCall: 'X11_XCirculateRequestEvent_place_get' plugin: 'x11'>
    self primitiveFailed
!
primXCirculateRequestEventPlace: val
    <cCall: 'X11_XCirculateRequestEvent_place_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"place accessors"
place
    ^self primXCirculateRequestEventPlace
!
place: val
    ^self primXCirculateRequestEventPlace: val
!






primX11XCirculateRequestEventDelete
    <cCall: 'X11_delete_XCirculateRequestEvent' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XCirculateRequestEventDelete.
!


name
    ^'X11XCirculateRequestEvent'

! !

!X11XCirculateRequestEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XCirculateRequestEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11GC
        instanceVariableNames: ''
        classVariableNames: ''!

!X11GC class methodsFor: 'initialize-release'!

primX11GCCreate
    <cCall: 'X11_new_GC' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11GCCreate).
!

initialize
    finalizationRequest := true.
! !

!X11GC  methodsFor: 'X11'!



"_________________________________________________________"
"XGContextFromGC primitive function"
primXGContextFromGC
    <cCall: 'X11_XGContextFromGC' plugin: 'x11'>
    self primitiveFailed
!




primX11GCDelete
    <cCall: 'X11_delete_GC' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11GCDelete.
!


name
    ^'X11GC'

! !

!X11GC methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11GC methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XAnyEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XAnyEvent class methodsFor: 'initialize-release'!

primX11XAnyEventCreate
    <cCall: 'X11_new_XAnyEvent' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XAnyEventCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XAnyEvent  methodsFor: 'X11'!

"_________________________________________________________"
"type primitive accessors"
primXAnyEventType
    <cCall: 'X11_XAnyEvent_type_get' plugin: 'x11'>
    self primitiveFailed
!
primXAnyEventType: val
    <cCall: 'X11_XAnyEvent_type_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"type accessors"
type
    ^self primXAnyEventType
!
type: val
    ^self primXAnyEventType: val
!

"_________________________________________________________"
"serial primitive accessors"
primXAnyEventSerial
    <cCall: 'X11_XAnyEvent_serial_get' plugin: 'x11'>
    self primitiveFailed
!
primXAnyEventSerial: val
    <cCall: 'X11_XAnyEvent_serial_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"serial accessors"
serial
    ^self primXAnyEventSerial
!
serial: val
    ^self primXAnyEventSerial: val
!

"_________________________________________________________"
"send_event primitive accessors"
primXAnyEventSendEvent
    <cCall: 'X11_XAnyEvent_send_event_get' plugin: 'x11'>
    self primitiveFailed
!
primXAnyEventSendEvent: val
    <cCall: 'X11_XAnyEvent_send_event_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"send_event accessors"
sendevent
    ^self primXAnyEventSendEvent
!
sendevent: val
    ^self primXAnyEventSendEvent: val
!

"_________________________________________________________"
"display primitive accessors"
primXAnyEventDisplay
    <cCall: 'X11_XAnyEvent_display_get' plugin: 'x11'>
    self primitiveFailed
!
primXAnyEventDisplay: val
    <cCall: 'X11_XAnyEvent_display_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"display accessors"
display
    ^self primXAnyEventDisplay
!
display: val
    ^self primXAnyEventDisplay: val
!

"_________________________________________________________"
"window primitive accessors"
primXAnyEventWindow
    <cCall: 'X11_XAnyEvent_window_get' plugin: 'x11'>
    self primitiveFailed
!
primXAnyEventWindow: val
    <cCall: 'X11_XAnyEvent_window_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"window accessors"
window
    ^self primXAnyEventWindow
!
window: val
    ^self primXAnyEventWindow: val
!






primX11XAnyEventDelete
    <cCall: 'X11_delete_XAnyEvent' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XAnyEventDelete.
!


name
    ^'X11XAnyEvent'

! !

!X11XAnyEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XAnyEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XArc
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XArc class methodsFor: 'initialize-release'!

primX11XArcCreate
    <cCall: 'X11_new_XArc' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XArcCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XArc  methodsFor: 'X11'!

"_________________________________________________________"
"x primitive accessors"
primXArcX
    <cCall: 'X11_XArc_x_get' plugin: 'x11'>
    self primitiveFailed
!
primXArcX: val
    <cCall: 'X11_XArc_x_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"x accessors"
x
    ^self primXArcX
!
x: val
    ^self primXArcX: val
!

"_________________________________________________________"
"y primitive accessors"
primXArcY
    <cCall: 'X11_XArc_y_get' plugin: 'x11'>
    self primitiveFailed
!
primXArcY: val
    <cCall: 'X11_XArc_y_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"y accessors"
y
    ^self primXArcY
!
y: val
    ^self primXArcY: val
!

"_________________________________________________________"
"width primitive accessors"
primXArcWidth
    <cCall: 'X11_XArc_width_get' plugin: 'x11'>
    self primitiveFailed
!
primXArcWidth: val
    <cCall: 'X11_XArc_width_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"width accessors"
width
    ^self primXArcWidth
!
width: val
    ^self primXArcWidth: val
!

"_________________________________________________________"
"height primitive accessors"
primXArcHeight
    <cCall: 'X11_XArc_height_get' plugin: 'x11'>
    self primitiveFailed
!
primXArcHeight: val
    <cCall: 'X11_XArc_height_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"height accessors"
height
    ^self primXArcHeight
!
height: val
    ^self primXArcHeight: val
!

"_________________________________________________________"
"angle1 primitive accessors"
primXArcAngle1
    <cCall: 'X11_XArc_angle1_get' plugin: 'x11'>
    self primitiveFailed
!
primXArcAngle1: val
    <cCall: 'X11_XArc_angle1_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"angle1 accessors"
angle1
    ^self primXArcAngle1
!
angle1: val
    ^self primXArcAngle1: val
!

"_________________________________________________________"
"angle2 primitive accessors"
primXArcAngle2
    <cCall: 'X11_XArc_angle2_get' plugin: 'x11'>
    self primitiveFailed
!
primXArcAngle2: val
    <cCall: 'X11_XArc_angle2_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"angle2 accessors"
angle2
    ^self primXArcAngle2
!
angle2: val
    ^self primXArcAngle2: val
!






primX11XArcDelete
    <cCall: 'X11_delete_XArc' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XArcDelete.
!


name
    ^'X11XArc'

! !

!X11XArc methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XArc methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XGravityEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XGravityEvent class methodsFor: 'initialize-release'!

primX11XGravityEventCreate
    <cCall: 'X11_new_XGravityEvent' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XGravityEventCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XGravityEvent  methodsFor: 'X11'!

"_________________________________________________________"
"type primitive accessors"
primXGravityEventType
    <cCall: 'X11_XGravityEvent_type_get' plugin: 'x11'>
    self primitiveFailed
!
primXGravityEventType: val
    <cCall: 'X11_XGravityEvent_type_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"type accessors"
type
    ^self primXGravityEventType
!
type: val
    ^self primXGravityEventType: val
!

"_________________________________________________________"
"serial primitive accessors"
primXGravityEventSerial
    <cCall: 'X11_XGravityEvent_serial_get' plugin: 'x11'>
    self primitiveFailed
!
primXGravityEventSerial: val
    <cCall: 'X11_XGravityEvent_serial_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"serial accessors"
serial
    ^self primXGravityEventSerial
!
serial: val
    ^self primXGravityEventSerial: val
!

"_________________________________________________________"
"send_event primitive accessors"
primXGravityEventSendEvent
    <cCall: 'X11_XGravityEvent_send_event_get' plugin: 'x11'>
    self primitiveFailed
!
primXGravityEventSendEvent: val
    <cCall: 'X11_XGravityEvent_send_event_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"send_event accessors"
sendevent
    ^self primXGravityEventSendEvent
!
sendevent: val
    ^self primXGravityEventSendEvent: val
!

"_________________________________________________________"
"display primitive accessors"
primXGravityEventDisplay
    <cCall: 'X11_XGravityEvent_display_get' plugin: 'x11'>
    self primitiveFailed
!
primXGravityEventDisplay: val
    <cCall: 'X11_XGravityEvent_display_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"display accessors"
display
    ^self primXGravityEventDisplay
!
display: val
    ^self primXGravityEventDisplay: val
!

"_________________________________________________________"
"event primitive accessors"
primXGravityEventEvent
    <cCall: 'X11_XGravityEvent_event_get' plugin: 'x11'>
    self primitiveFailed
!
primXGravityEventEvent: val
    <cCall: 'X11_XGravityEvent_event_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"event accessors"
event
    ^self primXGravityEventEvent
!
event: val
    ^self primXGravityEventEvent: val
!

"_________________________________________________________"
"window primitive accessors"
primXGravityEventWindow
    <cCall: 'X11_XGravityEvent_window_get' plugin: 'x11'>
    self primitiveFailed
!
primXGravityEventWindow: val
    <cCall: 'X11_XGravityEvent_window_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"window accessors"
window
    ^self primXGravityEventWindow
!
window: val
    ^self primXGravityEventWindow: val
!

"_________________________________________________________"
"x primitive accessors"
primXGravityEventX
    <cCall: 'X11_XGravityEvent_x_get' plugin: 'x11'>
    self primitiveFailed
!
primXGravityEventX: val
    <cCall: 'X11_XGravityEvent_x_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"x accessors"
x
    ^self primXGravityEventX
!
x: val
    ^self primXGravityEventX: val
!

"_________________________________________________________"
"y primitive accessors"
primXGravityEventY
    <cCall: 'X11_XGravityEvent_y_get' plugin: 'x11'>
    self primitiveFailed
!
primXGravityEventY: val
    <cCall: 'X11_XGravityEvent_y_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"y accessors"
y
    ^self primXGravityEventY
!
y: val
    ^self primXGravityEventY: val
!






primX11XGravityEventDelete
    <cCall: 'X11_delete_XGravityEvent' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XGravityEventDelete.
!


name
    ^'X11XGravityEvent'

! !

!X11XGravityEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XGravityEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XDestroyWindowEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XDestroyWindowEvent class methodsFor: 'initialize-release'!

primX11XDestroyWindowEventCreate
    <cCall: 'X11_new_XDestroyWindowEvent' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XDestroyWindowEventCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XDestroyWindowEvent  methodsFor: 'X11'!

"_________________________________________________________"
"type primitive accessors"
primXDestroyWindowEventType
    <cCall: 'X11_XDestroyWindowEvent_type_get' plugin: 'x11'>
    self primitiveFailed
!
primXDestroyWindowEventType: val
    <cCall: 'X11_XDestroyWindowEvent_type_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"type accessors"
type
    ^self primXDestroyWindowEventType
!
type: val
    ^self primXDestroyWindowEventType: val
!

"_________________________________________________________"
"serial primitive accessors"
primXDestroyWindowEventSerial
    <cCall: 'X11_XDestroyWindowEvent_serial_get' plugin: 'x11'>
    self primitiveFailed
!
primXDestroyWindowEventSerial: val
    <cCall: 'X11_XDestroyWindowEvent_serial_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"serial accessors"
serial
    ^self primXDestroyWindowEventSerial
!
serial: val
    ^self primXDestroyWindowEventSerial: val
!

"_________________________________________________________"
"send_event primitive accessors"
primXDestroyWindowEventSendEvent
    <cCall: 'X11_XDestroyWindowEvent_send_event_get' plugin: 'x11'>
    self primitiveFailed
!
primXDestroyWindowEventSendEvent: val
    <cCall: 'X11_XDestroyWindowEvent_send_event_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"send_event accessors"
sendevent
    ^self primXDestroyWindowEventSendEvent
!
sendevent: val
    ^self primXDestroyWindowEventSendEvent: val
!

"_________________________________________________________"
"display primitive accessors"
primXDestroyWindowEventDisplay
    <cCall: 'X11_XDestroyWindowEvent_display_get' plugin: 'x11'>
    self primitiveFailed
!
primXDestroyWindowEventDisplay: val
    <cCall: 'X11_XDestroyWindowEvent_display_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"display accessors"
display
    ^self primXDestroyWindowEventDisplay
!
display: val
    ^self primXDestroyWindowEventDisplay: val
!

"_________________________________________________________"
"event primitive accessors"
primXDestroyWindowEventEvent
    <cCall: 'X11_XDestroyWindowEvent_event_get' plugin: 'x11'>
    self primitiveFailed
!
primXDestroyWindowEventEvent: val
    <cCall: 'X11_XDestroyWindowEvent_event_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"event accessors"
event
    ^self primXDestroyWindowEventEvent
!
event: val
    ^self primXDestroyWindowEventEvent: val
!

"_________________________________________________________"
"window primitive accessors"
primXDestroyWindowEventWindow
    <cCall: 'X11_XDestroyWindowEvent_window_get' plugin: 'x11'>
    self primitiveFailed
!
primXDestroyWindowEventWindow: val
    <cCall: 'X11_XDestroyWindowEvent_window_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"window accessors"
window
    ^self primXDestroyWindowEventWindow
!
window: val
    ^self primXDestroyWindowEventWindow: val
!






primX11XDestroyWindowEventDelete
    <cCall: 'X11_delete_XDestroyWindowEvent' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XDestroyWindowEventDelete.
!


name
    ^'X11XDestroyWindowEvent'

! !

!X11XDestroyWindowEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XDestroyWindowEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XExtData
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XExtData class methodsFor: 'initialize-release'!

primX11XExtDataCreate
    <cCall: 'X11_new_XExtData' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XExtDataCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XExtData  methodsFor: 'X11'!

"_________________________________________________________"
"number primitive accessors"
primXExtDataNumber
    <cCall: 'X11_XExtData_number_get' plugin: 'x11'>
    self primitiveFailed
!
primXExtDataNumber: val
    <cCall: 'X11_XExtData_number_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"number accessors"
number
    ^self primXExtDataNumber
!
number: val
    ^self primXExtDataNumber: val
!

"_________________________________________________________"
"next primitive accessors"
primXExtDataNext
    <cCall: 'X11_XExtData_next_get' plugin: 'x11'>
    self primitiveFailed
!
primXExtDataNext: val
    <cCall: 'X11_XExtData_next_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"next accessors"
next
    ^self primXExtDataNext
!
next: val
    ^self primXExtDataNext: val
!

"_________________________________________________________"
"free_private primitive accessors"
primXExtDataFreePrivate
    <cCall: 'X11_XExtData_free_private_get' plugin: 'x11'>
    self primitiveFailed
!
primXExtDataFreePrivate: val
    <cCall: 'X11_XExtData_free_private_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"free_private accessors"
freeprivate
    ^self primXExtDataFreePrivate
!
freeprivate: val
    ^self primXExtDataFreePrivate: val
!

"_________________________________________________________"
"private_data primitive accessors"
primXExtDataPrivateData
    <cCall: 'X11_XExtData_private_data_get' plugin: 'x11'>
    self primitiveFailed
!
primXExtDataPrivateData: val
    <cCall: 'X11_XExtData_private_data_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"private_data accessors"
privatedata
    ^self primXExtDataPrivateData
!
privatedata: val
    ^self primXExtDataPrivateData: val
!



"_________________________________________________________"
"XFindOnExtensionList primitive function"
primXFindOnExtensionList: arg1
    <cCall: 'X11_XFindOnExtensionList' plugin: 'x11'>
    self primitiveFailed
!




primX11XExtDataDelete
    <cCall: 'X11_delete_XExtData' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XExtDataDelete.
!


name
    ^'X11XExtData'

! !

!X11XExtData methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XExtData methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XPropertyEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XPropertyEvent class methodsFor: 'initialize-release'!

primX11XPropertyEventCreate
    <cCall: 'X11_new_XPropertyEvent' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XPropertyEventCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XPropertyEvent  methodsFor: 'X11'!

"_________________________________________________________"
"type primitive accessors"
primXPropertyEventType
    <cCall: 'X11_XPropertyEvent_type_get' plugin: 'x11'>
    self primitiveFailed
!
primXPropertyEventType: val
    <cCall: 'X11_XPropertyEvent_type_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"type accessors"
type
    ^self primXPropertyEventType
!
type: val
    ^self primXPropertyEventType: val
!

"_________________________________________________________"
"serial primitive accessors"
primXPropertyEventSerial
    <cCall: 'X11_XPropertyEvent_serial_get' plugin: 'x11'>
    self primitiveFailed
!
primXPropertyEventSerial: val
    <cCall: 'X11_XPropertyEvent_serial_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"serial accessors"
serial
    ^self primXPropertyEventSerial
!
serial: val
    ^self primXPropertyEventSerial: val
!

"_________________________________________________________"
"send_event primitive accessors"
primXPropertyEventSendEvent
    <cCall: 'X11_XPropertyEvent_send_event_get' plugin: 'x11'>
    self primitiveFailed
!
primXPropertyEventSendEvent: val
    <cCall: 'X11_XPropertyEvent_send_event_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"send_event accessors"
sendevent
    ^self primXPropertyEventSendEvent
!
sendevent: val
    ^self primXPropertyEventSendEvent: val
!

"_________________________________________________________"
"display primitive accessors"
primXPropertyEventDisplay
    <cCall: 'X11_XPropertyEvent_display_get' plugin: 'x11'>
    self primitiveFailed
!
primXPropertyEventDisplay: val
    <cCall: 'X11_XPropertyEvent_display_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"display accessors"
display
    ^self primXPropertyEventDisplay
!
display: val
    ^self primXPropertyEventDisplay: val
!

"_________________________________________________________"
"window primitive accessors"
primXPropertyEventWindow
    <cCall: 'X11_XPropertyEvent_window_get' plugin: 'x11'>
    self primitiveFailed
!
primXPropertyEventWindow: val
    <cCall: 'X11_XPropertyEvent_window_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"window accessors"
window
    ^self primXPropertyEventWindow
!
window: val
    ^self primXPropertyEventWindow: val
!

"_________________________________________________________"
"atom primitive accessors"
primXPropertyEventAtom
    <cCall: 'X11_XPropertyEvent_atom_get' plugin: 'x11'>
    self primitiveFailed
!
primXPropertyEventAtom: val
    <cCall: 'X11_XPropertyEvent_atom_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"atom accessors"
atom
    ^self primXPropertyEventAtom
!
atom: val
    ^self primXPropertyEventAtom: val
!

"_________________________________________________________"
"time primitive accessors"
primXPropertyEventTime
    <cCall: 'X11_XPropertyEvent_time_get' plugin: 'x11'>
    self primitiveFailed
!
primXPropertyEventTime: val
    <cCall: 'X11_XPropertyEvent_time_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"time accessors"
time
    ^self primXPropertyEventTime
!
time: val
    ^self primXPropertyEventTime: val
!

"_________________________________________________________"
"state primitive accessors"
primXPropertyEventState
    <cCall: 'X11_XPropertyEvent_state_get' plugin: 'x11'>
    self primitiveFailed
!
primXPropertyEventState: val
    <cCall: 'X11_XPropertyEvent_state_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"state accessors"
state
    ^self primXPropertyEventState
!
state: val
    ^self primXPropertyEventState: val
!






primX11XPropertyEventDelete
    <cCall: 'X11_delete_XPropertyEvent' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XPropertyEventDelete.
!


name
    ^'X11XPropertyEvent'

! !

!X11XPropertyEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XPropertyEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XOM
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XOM class methodsFor: 'initialize-release'!

primX11XOMCreate
    <cCall: 'X11_new_XOM' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XOMCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XOM  methodsFor: 'X11'!



"_________________________________________________________"
"XCloseOM primitive function"
primXCloseOM
    <cCall: 'X11_XCloseOM' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XSetOMValues primitive function"
primXSetOMValues
    <cCall: 'X11_XSetOMValues' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XGetOMValues primitive function"
primXGetOMValues
    <cCall: 'X11_XGetOMValues' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XDisplayOfOM primitive function"
primXDisplayOfOM
    <cCall: 'X11_XDisplayOfOM' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XLocaleOfOM primitive function"
primXLocaleOfOM
    <cCall: 'X11_XLocaleOfOM' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XCreateOC primitive function"
primXCreateOC
    <cCall: 'X11_XCreateOC' plugin: 'x11'>
    self primitiveFailed
!




primX11XOMDelete
    <cCall: 'X11_delete_XOM' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XOMDelete.
!


name
    ^'X11XOM'

! !

!X11XOM methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XOM methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11Display
        instanceVariableNames: ''
        classVariableNames: ''!

!X11Display class methodsFor: 'initialize-release'!

primX11DisplayCreate
    <cCall: 'X11_new_Display' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11DisplayCreate).
!

initialize
    finalizationRequest := true.
! !

!X11Display  methodsFor: 'X11'!



"_________________________________________________________"
"XLoadQueryFont primitive function"
primXLoadQueryFont: arg1
    <cCall: 'X11_XLoadQueryFont' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XQueryFont primitive function"
primXQueryFont: arg1
    <cCall: 'X11_XQueryFont' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XGetMotionEvents primitive function"
primXGetMotionEvents: arg1 start: arg4 stop: arg5 neventsReturn: arg6
    <cCall: 'X11_XGetMotionEvents' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XGetModifierMapping primitive function"
primXGetModifierMapping
    <cCall: 'X11_XGetModifierMapping' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XCreateImage primitive function"
primXCreateImage: arg1 depth: arg4 format: arg5 offset: arg6 data: arg7 width: arg8 height: arg9 bitmapPad: arg10 bytesPerLine: arg11
    <cCall: 'X11_XCreateImage' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XGetImage primitive function"
primXGetImage: arg1 x: arg4 y: arg5 width: arg6 height: arg7 planeMask: arg8 format: arg9
    <cCall: 'X11_XGetImage' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XGetSubImage primitive function"
primXGetSubImage: arg1 x: arg4 y: arg5 width: arg6 height: arg7 planeMask: arg8 format: arg9 destImage: arg10 destX: arg11 destY: arg12
    <cCall: 'X11_XGetSubImage' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XFetchBytes primitive function"
primXFetchBytes: arg1
    <cCall: 'X11_XFetchBytes' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XFetchBuffer primitive function"
primXFetchBuffer: arg1 buffer: arg4
    <cCall: 'X11_XFetchBuffer' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XGetAtomName primitive function"
primXGetAtomName: arg1
    <cCall: 'X11_XGetAtomName' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XGetAtomNames primitive function"
primXGetAtomNames: arg1 count: arg4 namesReturn: arg5
    <cCall: 'X11_XGetAtomNames' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XGetDefault primitive function"
primXGetDefault: arg1 option: arg4
    <cCall: 'X11_XGetDefault' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XSynchronize primitive function commented out."
"primXSynchronize"
"_________________________________________________________"
"XSetAfterFunction primitive function commented out."
"primXSetAfterFunction"
"_________________________________________________________"
"XInternAtom primitive function"
primXInternAtom: arg1 onlyIfExists: arg4
    <cCall: 'X11_XInternAtom' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XInternAtoms primitive function"
primXInternAtoms: arg1 count: arg4 onlyIfExists: arg5 atomsReturn: arg6
    <cCall: 'X11_XInternAtoms' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XCopyColormapAndFree primitive function"
primXCopyColormapAndFree: arg1
    <cCall: 'X11_XCopyColormapAndFree' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XCreateColormap primitive function"
primXCreateColormap: arg1 visual: arg4 alloc: arg5
    <cCall: 'X11_XCreateColormap' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XCreatePixmapCursor primitive function"
primXCreatePixmapCursor: arg1 mask: arg4 foregroundColor: arg5 backgroundColor: arg6 x: arg7 y: arg8
    <cCall: 'X11_XCreatePixmapCursor' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XCreateGlyphCursor primitive function"
primXCreateGlyphCursor: arg1 maskFont: arg4 sourceChar: arg5 maskChar: arg6 foregroundColor: arg7 backgroundColor: arg8
    <cCall: 'X11_XCreateGlyphCursor' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XCreateFontCursor primitive function"
primXCreateFontCursor: arg1
    <cCall: 'X11_XCreateFontCursor' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XLoadFont primitive function"
primXLoadFont: arg1
    <cCall: 'X11_XLoadFont' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XCreateGC primitive function"
primXCreateGC: arg1 valuemask: arg4 values: arg5
    <cCall: 'X11_XCreateGC' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XFlushGC primitive function"
primXFlushGC: arg1
    <cCall: 'X11_XFlushGC' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XCreatePixmap primitive function"
primXCreatePixmap: arg1 width: arg4 height: arg5 depth: arg6
    <cCall: 'X11_XCreatePixmap' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XCreateBitmapFromData primitive function"
primXCreateBitmapFromData: arg1 data: arg4 width: arg5 height: arg6
    <cCall: 'X11_XCreateBitmapFromData' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XCreatePixmapFromBitmapData primitive function"
primXCreatePixmapFromBitmapData: arg1 data: arg4 width: arg5 height: arg6 fg: arg7 bg: arg8 depth: arg9
    <cCall: 'X11_XCreatePixmapFromBitmapData' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XCreateSimpleWindow primitive function"
primXCreateSimpleWindow: arg1 x: arg4 y: arg5 width: arg6 height: arg7 borderWidth: arg8 border: arg9 background: arg10
    <cCall: 'X11_XCreateSimpleWindow' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XGetSelectionOwner primitive function"
primXGetSelectionOwner: arg1
    <cCall: 'X11_XGetSelectionOwner' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XCreateWindow primitive function"
primXCreateWindow: arg1 x: arg4 y: arg5 width: arg6 height: arg7 borderWidth: arg8 depth: arg9 class: arg10 visual: arg11 valuemask: arg12 attributes: arg13
    <cCall: 'X11_XCreateWindow' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XListInstalledColormaps primitive function"
primXListInstalledColormaps: arg1 numReturn: arg4
    <cCall: 'X11_XListInstalledColormaps' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XListFonts primitive function"
primXListFonts: arg1 maxnames: arg4 actualCountReturn: arg5
    <cCall: 'X11_XListFonts' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XListFontsWithInfo primitive function"
primXListFontsWithInfo: arg1 maxnames: arg4 countReturn: arg5 infoReturn: arg6
    <cCall: 'X11_XListFontsWithInfo' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XGetFontPath primitive function"
primXGetFontPath: arg1
    <cCall: 'X11_XGetFontPath' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XListExtensions primitive function"
primXListExtensions: arg1
    <cCall: 'X11_XListExtensions' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XListProperties primitive function"
primXListProperties: arg1 numPropReturn: arg4
    <cCall: 'X11_XListProperties' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XListHosts primitive function"
primXListHosts: arg1 stateReturn: arg4
    <cCall: 'X11_XListHosts' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XKeycodeToKeysym primitive function"
primXKeycodeToKeysym: arg1 keycodeEntry: arg4 index: arg5
    <cCall: 'X11_XKeycodeToKeysym' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XGetKeyboardMapping primitive function"
primXGetKeyboardMapping: arg1 keycodeEntry: arg4 keycodeCount: arg5 keysymsPerKeycodeReturn: arg6
    <cCall: 'X11_XGetKeyboardMapping' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XMaxRequestSize primitive function"
primXMaxRequestSize
    <cCall: 'X11_XMaxRequestSize' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XExtendedMaxRequestSize primitive function"
primXExtendedMaxRequestSize
    <cCall: 'X11_XExtendedMaxRequestSize' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XResourceManagerString primitive function"
primXResourceManagerString
    <cCall: 'X11_XResourceManagerString' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XDisplayMotionBufferSize primitive function"
primXDisplayMotionBufferSize
    <cCall: 'X11_XDisplayMotionBufferSize' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XLockDisplay primitive function"
primXLockDisplay
    <cCall: 'X11_XLockDisplay' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XUnlockDisplay primitive function"
primXUnlockDisplay
    <cCall: 'X11_XUnlockDisplay' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XInitExtension primitive function"
primXInitExtension: arg1
    <cCall: 'X11_XInitExtension' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XAddExtension primitive function"
primXAddExtension
    <cCall: 'X11_XAddExtension' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XRootWindow primitive function"
primXRootWindow: arg1
    <cCall: 'X11_XRootWindow' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XDefaultRootWindow primitive function"
primXDefaultRootWindow
    <cCall: 'X11_XDefaultRootWindow' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XDefaultVisual primitive function"
primXDefaultVisual: arg1
    <cCall: 'X11_XDefaultVisual' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XDefaultGC primitive function"
primXDefaultGC: arg1
    <cCall: 'X11_XDefaultGC' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XBlackPixel primitive function"
primXBlackPixel: arg1
    <cCall: 'X11_XBlackPixel' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XWhitePixel primitive function"
primXWhitePixel: arg1
    <cCall: 'X11_XWhitePixel' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XNextRequest primitive function"
primXNextRequest
    <cCall: 'X11_XNextRequest' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XLastKnownRequestProcessed primitive function"
primXLastKnownRequestProcessed
    <cCall: 'X11_XLastKnownRequestProcessed' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XServerVendor primitive function"
primXServerVendor
    <cCall: 'X11_XServerVendor' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XDisplayString primitive function"
primXDisplayString
    <cCall: 'X11_XDisplayString' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XDefaultColormap primitive function"
primXDefaultColormap: arg1
    <cCall: 'X11_XDefaultColormap' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XScreenOfDisplay primitive function"
primXScreenOfDisplay: arg1
    <cCall: 'X11_XScreenOfDisplay' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XDefaultScreenOfDisplay primitive function"
primXDefaultScreenOfDisplay
    <cCall: 'X11_XDefaultScreenOfDisplay' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XListPixmapFormats primitive function"
primXListPixmapFormats: arg1
    <cCall: 'X11_XListPixmapFormats' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XListDepths primitive function"
primXListDepths: arg1 countReturn: arg4
    <cCall: 'X11_XListDepths' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XReconfigureWMWindow primitive function"
primXReconfigureWMWindow: arg1 screenNumber: arg4 mask: arg5 changes: arg6
    <cCall: 'X11_XReconfigureWMWindow' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XGetWMProtocols primitive function"
primXGetWMProtocols: arg1 protocolsReturn: arg4 countReturn: arg5
    <cCall: 'X11_XGetWMProtocols' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XSetWMProtocols primitive function"
primXSetWMProtocols: arg1 protocols: arg4 count: arg5
    <cCall: 'X11_XSetWMProtocols' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XIconifyWindow primitive function"
primXIconifyWindow: arg1 screenNumber: arg4
    <cCall: 'X11_XIconifyWindow' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XWithdrawWindow primitive function"
primXWithdrawWindow: arg1 screenNumber: arg4
    <cCall: 'X11_XWithdrawWindow' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XGetCommand primitive function"
primXGetCommand: arg1 argvReturn: arg4 argcReturn: arg5
    <cCall: 'X11_XGetCommand' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XGetWMColormapWindows primitive function"
primXGetWMColormapWindows: arg1 windowsReturn: arg4 countReturn: arg5
    <cCall: 'X11_XGetWMColormapWindows' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XSetWMColormapWindows primitive function"
primXSetWMColormapWindows: arg1 colormapWindows: arg4 count: arg5
    <cCall: 'X11_XSetWMColormapWindows' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XSetTransientForHint primitive function"
primXSetTransientForHint: arg1 propWindow: arg4
    <cCall: 'X11_XSetTransientForHint' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XActivateScreenSaver primitive function"
primXActivateScreenSaver
    <cCall: 'X11_XActivateScreenSaver' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XAddHost primitive function"
primXAddHost: arg1
    <cCall: 'X11_XAddHost' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XAddHosts primitive function"
primXAddHosts: arg1 numHosts: arg4
    <cCall: 'X11_XAddHosts' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XAddToSaveSet primitive function"
primXAddToSaveSet: arg1
    <cCall: 'X11_XAddToSaveSet' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XAllocColor primitive function"
primXAllocColor: arg1 screenInOut: arg4
    <cCall: 'X11_XAllocColor' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XAllocColorCells primitive function"
primXAllocColorCells: arg1 contig: arg4 planeMasksReturn: arg5 nplanes: arg6 pixelsReturn: arg7 npixels: arg8
    <cCall: 'X11_XAllocColorCells' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XAllocColorPlanes primitive function"
primXAllocColorPlanes: arg1 contig: arg4 pixelsReturn: arg5 ncolors: arg6 nreds: arg7 ngreens: arg8 nblues: arg9 rmaskReturn: arg10 gmaskReturn: arg11 bmaskReturn: arg12
    <cCall: 'X11_XAllocColorPlanes' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XAllocNamedColor primitive function"
primXAllocNamedColor: arg1 colorName: arg4 screenDefReturn: arg5 exactDefReturn: arg6
    <cCall: 'X11_XAllocNamedColor' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XAllowEvents primitive function"
primXAllowEvents: arg1 time: arg4
    <cCall: 'X11_XAllowEvents' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XAutoRepeatOff primitive function"
primXAutoRepeatOff
    <cCall: 'X11_XAutoRepeatOff' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XAutoRepeatOn primitive function"
primXAutoRepeatOn
    <cCall: 'X11_XAutoRepeatOn' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XBell primitive function"
primXBell: arg1
    <cCall: 'X11_XBell' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XBitmapBitOrder primitive function"
primXBitmapBitOrder
    <cCall: 'X11_XBitmapBitOrder' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XBitmapPad primitive function"
primXBitmapPad
    <cCall: 'X11_XBitmapPad' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XBitmapUnit primitive function"
primXBitmapUnit
    <cCall: 'X11_XBitmapUnit' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XChangeActivePointerGrab primitive function"
primXChangeActivePointerGrab: arg1 cursor: arg4 time: arg5
    <cCall: 'X11_XChangeActivePointerGrab' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XChangeGC primitive function"
primXChangeGC: arg1 valuemask: arg4 values: arg5
    <cCall: 'X11_XChangeGC' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XChangeKeyboardControl primitive function"
primXChangeKeyboardControl: arg1 values: arg4
    <cCall: 'X11_XChangeKeyboardControl' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XChangeKeyboardMapping primitive function"
primXChangeKeyboardMapping: arg1 keysymsPerKeycode: arg4 keysyms: arg5 numCodes: arg6
    <cCall: 'X11_XChangeKeyboardMapping' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XChangePointerControl primitive function"
primXChangePointerControl: arg1 doThreshold: arg4 accelNumerator: arg5 accelDenominator: arg6 threshold: arg7
    <cCall: 'X11_XChangePointerControl' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XChangeProperty primitive function"
primXChangeProperty: arg1 property: arg4 type: arg5 format: arg6 mode: arg7 data: arg8 nelements: arg9
    <cCall: 'X11_XChangeProperty' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XChangeSaveSet primitive function"
primXChangeSaveSet: arg1 changeMode: arg4
    <cCall: 'X11_XChangeSaveSet' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XChangeWindowAttributes primitive function"
primXChangeWindowAttributes: arg1 valuemask: arg4 attributes: arg5
    <cCall: 'X11_XChangeWindowAttributes' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XCheckIfEvent primitive function"
primXCheckIfEvent: arg1 display: arg4 event: arg5 arg: arg6 predicate: arg7 arg: arg8
    <cCall: 'X11_XCheckIfEvent' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XCheckMaskEvent primitive function"
primXCheckMaskEvent: arg1 eventReturn: arg4
    <cCall: 'X11_XCheckMaskEvent' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XCheckTypedEvent primitive function"
primXCheckTypedEvent: arg1 eventReturn: arg4
    <cCall: 'X11_XCheckTypedEvent' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XCheckTypedWindowEvent primitive function"
primXCheckTypedWindowEvent: arg1 eventType: arg4 eventReturn: arg5
    <cCall: 'X11_XCheckTypedWindowEvent' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XCheckWindowEvent primitive function"
primXCheckWindowEvent: arg1 eventMask: arg4 eventReturn: arg5
    <cCall: 'X11_XCheckWindowEvent' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XCirculateSubwindows primitive function"
primXCirculateSubwindows: arg1 direction: arg4
    <cCall: 'X11_XCirculateSubwindows' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XCirculateSubwindowsDown primitive function"
primXCirculateSubwindowsDown: arg1
    <cCall: 'X11_XCirculateSubwindowsDown' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XCirculateSubwindowsUp primitive function"
primXCirculateSubwindowsUp: arg1
    <cCall: 'X11_XCirculateSubwindowsUp' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XClearArea primitive function"
primXClearArea: arg1 x: arg4 y: arg5 width: arg6 height: arg7 exposures: arg8
    <cCall: 'X11_XClearArea' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XClearWindow primitive function"
primXClearWindow: arg1
    <cCall: 'X11_XClearWindow' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XCloseDisplay primitive function"
primXCloseDisplay
    <cCall: 'X11_XCloseDisplay' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XConfigureWindow primitive function"
primXConfigureWindow: arg1 valueMask: arg4 values: arg5
    <cCall: 'X11_XConfigureWindow' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XConnectionNumber primitive function"
primXConnectionNumber
    <cCall: 'X11_XConnectionNumber' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XConvertSelection primitive function"
primXConvertSelection: arg1 target: arg4 property: arg5 requestor: arg6 time: arg7
    <cCall: 'X11_XConvertSelection' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XCopyArea primitive function"
primXCopyArea: arg1 dest: arg4 gc: arg5 srcX: arg6 srcY: arg7 width: arg8 height: arg9 destX: arg10 destY: arg11
    <cCall: 'X11_XCopyArea' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XCopyGC primitive function"
primXCopyGC: arg1 valuemask: arg4 dest: arg5
    <cCall: 'X11_XCopyGC' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XCopyPlane primitive function"
primXCopyPlane: arg1 dest: arg4 gc: arg5 srcX: arg6 srcY: arg7 width: arg8 height: arg9 destX: arg10 destY: arg11 plane: arg12
    <cCall: 'X11_XCopyPlane' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XDefaultDepth primitive function"
primXDefaultDepth: arg1
    <cCall: 'X11_XDefaultDepth' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XDefaultScreen primitive function"
primXDefaultScreen
    <cCall: 'X11_XDefaultScreen' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XDefineCursor primitive function"
primXDefineCursor: arg1 cursor: arg4
    <cCall: 'X11_XDefineCursor' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XDeleteProperty primitive function"
primXDeleteProperty: arg1 property: arg4
    <cCall: 'X11_XDeleteProperty' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XDestroyWindow primitive function"
primXDestroyWindow: arg1
    <cCall: 'X11_XDestroyWindow' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XDestroySubwindows primitive function"
primXDestroySubwindows: arg1
    <cCall: 'X11_XDestroySubwindows' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XDisableAccessControl primitive function"
primXDisableAccessControl
    <cCall: 'X11_XDisableAccessControl' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XDisplayCells primitive function"
primXDisplayCells: arg1
    <cCall: 'X11_XDisplayCells' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XDisplayHeight primitive function"
primXDisplayHeight: arg1
    <cCall: 'X11_XDisplayHeight' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XDisplayHeightMM primitive function"
primXDisplayHeightMM: arg1
    <cCall: 'X11_XDisplayHeightMM' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XDisplayKeycodes primitive function"
primXDisplayKeycodes: arg1 maxKeycodesReturn: arg4
    <cCall: 'X11_XDisplayKeycodes' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XDisplayPlanes primitive function"
primXDisplayPlanes: arg1
    <cCall: 'X11_XDisplayPlanes' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XDisplayWidth primitive function"
primXDisplayWidth: arg1
    <cCall: 'X11_XDisplayWidth' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XDisplayWidthMM primitive function"
primXDisplayWidthMM: arg1
    <cCall: 'X11_XDisplayWidthMM' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XDrawArc primitive function"
primXDrawArc: arg1 gc: arg4 x: arg5 y: arg6 width: arg7 height: arg8 angle1: arg9 angle2: arg10
    <cCall: 'X11_XDrawArc' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XDrawArcs primitive function"
primXDrawArcs: arg1 gc: arg4 arcs: arg5 narcs: arg6
    <cCall: 'X11_XDrawArcs' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XDrawImageString primitive function"
primXDrawImageString: arg1 gc: arg4 x: arg5 y: arg6 string: arg7 length: arg8
    <cCall: 'X11_XDrawImageString' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XDrawImageString16 primitive function"
primXDrawImageString16: arg1 gc: arg4 x: arg5 y: arg6 string: arg7 length: arg8
    <cCall: 'X11_XDrawImageString16' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XDrawLine primitive function"
primXDrawLine: arg1 gc: arg4 x1: arg5 y1: arg6 x2: arg7 y2: arg8
    <cCall: 'X11_XDrawLine' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XDrawLines primitive function"
primXDrawLines: arg1 gc: arg4 points: arg5 npoints: arg6 mode: arg7
    <cCall: 'X11_XDrawLines' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XDrawPoint primitive function"
primXDrawPoint: arg1 gc: arg4 x: arg5 y: arg6
    <cCall: 'X11_XDrawPoint' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XDrawPoints primitive function"
primXDrawPoints: arg1 gc: arg4 points: arg5 npoints: arg6 mode: arg7
    <cCall: 'X11_XDrawPoints' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XDrawRectangle primitive function"
primXDrawRectangle: arg1 gc: arg4 x: arg5 y: arg6 width: arg7 height: arg8
    <cCall: 'X11_XDrawRectangle' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XDrawRectangles primitive function"
primXDrawRectangles: arg1 gc: arg4 rectangles: arg5 nrectangles: arg6
    <cCall: 'X11_XDrawRectangles' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XDrawSegments primitive function"
primXDrawSegments: arg1 gc: arg4 segments: arg5 nsegments: arg6
    <cCall: 'X11_XDrawSegments' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XDrawString primitive function"
primXDrawString: arg1 gc: arg4 x: arg5 y: arg6 string: arg7 length: arg8
    <cCall: 'X11_XDrawString' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XDrawString16 primitive function"
primXDrawString16: arg1 gc: arg4 x: arg5 y: arg6 string: arg7 length: arg8
    <cCall: 'X11_XDrawString16' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XDrawText primitive function"
primXDrawText: arg1 gc: arg4 x: arg5 y: arg6 items: arg7 nitems: arg8
    <cCall: 'X11_XDrawText' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XDrawText16 primitive function"
primXDrawText16: arg1 gc: arg4 x: arg5 y: arg6 items: arg7 nitems: arg8
    <cCall: 'X11_XDrawText16' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XEnableAccessControl primitive function"
primXEnableAccessControl
    <cCall: 'X11_XEnableAccessControl' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XEventsQueued primitive function"
primXEventsQueued: arg1
    <cCall: 'X11_XEventsQueued' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XFetchName primitive function"
primXFetchName: arg1 windowNameReturn: arg4
    <cCall: 'X11_XFetchName' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XFillArc primitive function"
primXFillArc: arg1 gc: arg4 x: arg5 y: arg6 width: arg7 height: arg8 angle1: arg9 angle2: arg10
    <cCall: 'X11_XFillArc' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XFillArcs primitive function"
primXFillArcs: arg1 gc: arg4 arcs: arg5 narcs: arg6
    <cCall: 'X11_XFillArcs' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XFillPolygon primitive function"
primXFillPolygon: arg1 gc: arg4 points: arg5 npoints: arg6 shape: arg7 mode: arg8
    <cCall: 'X11_XFillPolygon' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XFillRectangle primitive function"
primXFillRectangle: arg1 gc: arg4 x: arg5 y: arg6 width: arg7 height: arg8
    <cCall: 'X11_XFillRectangle' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XFillRectangles primitive function"
primXFillRectangles: arg1 gc: arg4 rectangles: arg5 nrectangles: arg6
    <cCall: 'X11_XFillRectangles' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XFlush primitive function"
primXFlush
    <cCall: 'X11_XFlush' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XForceScreenSaver primitive function"
primXForceScreenSaver: arg1
    <cCall: 'X11_XForceScreenSaver' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XFreeColormap primitive function"
primXFreeColormap: arg1
    <cCall: 'X11_XFreeColormap' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XFreeColors primitive function"
primXFreeColors: arg1 pixels: arg4 npixels: arg5 planes: arg6
    <cCall: 'X11_XFreeColors' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XFreeCursor primitive function"
primXFreeCursor: arg1
    <cCall: 'X11_XFreeCursor' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XFreeFont primitive function"
primXFreeFont: arg1
    <cCall: 'X11_XFreeFont' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XFreeGC primitive function"
primXFreeGC: arg1
    <cCall: 'X11_XFreeGC' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XFreePixmap primitive function"
primXFreePixmap: arg1
    <cCall: 'X11_XFreePixmap' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XGeometry primitive function"
primXGeometry: arg1 position: arg4 defaultPosition: arg5 bwidth: arg6 fwidth: arg7 fheight: arg8 xadder: arg9 yadder: arg10 xReturn: arg11 yReturn: arg12 widthReturn: arg13 heightReturn: arg14
    <cCall: 'X11_XGeometry' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XGetErrorDatabaseText primitive function"
primXGetErrorDatabaseText: arg1 message: arg4 defaultString: arg5 bufferReturn: arg6 length: arg7
    <cCall: 'X11_XGetErrorDatabaseText' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XGetErrorText primitive function"
primXGetErrorText: arg1 bufferReturn: arg4 length: arg5
    <cCall: 'X11_XGetErrorText' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XGetGCValues primitive function"
primXGetGCValues: arg1 valuemask: arg4 valuesReturn: arg5
    <cCall: 'X11_XGetGCValues' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XGetGeometry primitive function"
primXGetGeometry: arg1 rootReturn: arg4 xReturn: arg5 yReturn: arg6 widthReturn: arg7 heightReturn: arg8 borderWidthReturn: arg9 depthReturn: arg10
    <cCall: 'X11_XGetGeometry' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XGetIconName primitive function"
primXGetIconName: arg1 iconNameReturn: arg4
    <cCall: 'X11_XGetIconName' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XGetInputFocus primitive function"
primXGetInputFocus: arg1 revertToReturn: arg4
    <cCall: 'X11_XGetInputFocus' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XGetKeyboardControl primitive function"
primXGetKeyboardControl: arg1
    <cCall: 'X11_XGetKeyboardControl' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XGetPointerControl primitive function"
primXGetPointerControl: arg1 accelDenominatorReturn: arg4 thresholdReturn: arg5
    <cCall: 'X11_XGetPointerControl' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XGetPointerMapping primitive function"
primXGetPointerMapping: arg1 nmap: arg4
    <cCall: 'X11_XGetPointerMapping' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XGetScreenSaver primitive function"
primXGetScreenSaver: arg1 intervalReturn: arg4 preferBlankingReturn: arg5 allowExposuresReturn: arg6
    <cCall: 'X11_XGetScreenSaver' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XGetTransientForHint primitive function"
primXGetTransientForHint: arg1 propWindowReturn: arg4
    <cCall: 'X11_XGetTransientForHint' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XGetWindowProperty primitive function"
primXGetWindowProperty: arg1 property: arg4 longOffset: arg5 longLength: arg6 delete: arg7 reqType: arg8 actualTypeReturn: arg9 actualFormatReturn: arg10 nitemsReturn: arg11 bytesAfterReturn: arg12 propReturn: arg13
    <cCall: 'X11_XGetWindowProperty' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XGetWindowAttributes primitive function"
primXGetWindowAttributes: arg1 windowAttributesReturn: arg4
    <cCall: 'X11_XGetWindowAttributes' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XGrabButton primitive function"
primXGrabButton: arg1 modifiers: arg4 grabWindow: arg5 ownerEvents: arg6 eventMask: arg7 pointerMode: arg8 keyboardMode: arg9 confineTo: arg10 cursor: arg11
    <cCall: 'X11_XGrabButton' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XGrabKey primitive function"
primXGrabKey: arg1 modifiers: arg4 grabWindow: arg5 ownerEvents: arg6 pointerMode: arg7 keyboardMode: arg8
    <cCall: 'X11_XGrabKey' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XGrabKeyboard primitive function"
primXGrabKeyboard: arg1 ownerEvents: arg4 pointerMode: arg5 keyboardMode: arg6 time: arg7
    <cCall: 'X11_XGrabKeyboard' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XGrabPointer primitive function"
primXGrabPointer: arg1 ownerEvents: arg4 eventMask: arg5 pointerMode: arg6 keyboardMode: arg7 confineTo: arg8 cursor: arg9 time: arg10
    <cCall: 'X11_XGrabPointer' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XGrabServer primitive function"
primXGrabServer
    <cCall: 'X11_XGrabServer' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XIfEvent primitive function"
primXIfEvent: arg1 display: arg4 event: arg5 arg: arg6 predicate: arg7 arg: arg8
    <cCall: 'X11_XIfEvent' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XImageByteOrder primitive function"
primXImageByteOrder
    <cCall: 'X11_XImageByteOrder' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XInstallColormap primitive function"
primXInstallColormap: arg1
    <cCall: 'X11_XInstallColormap' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XKeysymToKeycode primitive function"
primXKeysymToKeycode: arg1
    <cCall: 'X11_XKeysymToKeycode' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XKillClient primitive function"
primXKillClient: arg1
    <cCall: 'X11_XKillClient' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XLookupColor primitive function"
primXLookupColor: arg1 colorName: arg4 exactDefReturn: arg5 screenDefReturn: arg6
    <cCall: 'X11_XLookupColor' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XLowerWindow primitive function"
primXLowerWindow: arg1
    <cCall: 'X11_XLowerWindow' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XMapRaised primitive function"
primXMapRaised: arg1
    <cCall: 'X11_XMapRaised' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XMapSubwindows primitive function"
primXMapSubwindows: arg1
    <cCall: 'X11_XMapSubwindows' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XMapWindow primitive function"
primXMapWindow: arg1
    <cCall: 'X11_XMapWindow' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XMaskEvent primitive function"
primXMaskEvent: arg1 eventReturn: arg4
    <cCall: 'X11_XMaskEvent' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XMoveResizeWindow primitive function"
primXMoveResizeWindow: arg1 x: arg4 y: arg5 width: arg6 height: arg7
    <cCall: 'X11_XMoveResizeWindow' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XMoveWindow primitive function"
primXMoveWindow: arg1 x: arg4 y: arg5
    <cCall: 'X11_XMoveWindow' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XNextEvent primitive function"
primXNextEvent: arg1
    <cCall: 'X11_XNextEvent' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XNoOp primitive function"
primXNoOp
    <cCall: 'X11_XNoOp' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XParseColor primitive function"
primXParseColor: arg1 spec: arg4 exactDefReturn: arg5
    <cCall: 'X11_XParseColor' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XPeekEvent primitive function"
primXPeekEvent: arg1
    <cCall: 'X11_XPeekEvent' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XPeekIfEvent primitive function"
primXPeekIfEvent: arg1 display: arg4 event: arg5 arg: arg6 predicate: arg7 arg: arg8
    <cCall: 'X11_XPeekIfEvent' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XPending primitive function"
primXPending
    <cCall: 'X11_XPending' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XProtocolRevision primitive function"
primXProtocolRevision
    <cCall: 'X11_XProtocolRevision' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XProtocolVersion primitive function"
primXProtocolVersion
    <cCall: 'X11_XProtocolVersion' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XPutBackEvent primitive function"
primXPutBackEvent: arg1
    <cCall: 'X11_XPutBackEvent' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XPutImage primitive function"
primXPutImage: arg1 gc: arg4 image: arg5 srcX: arg6 srcY: arg7 destX: arg8 destY: arg9 width: arg10 height: arg11
    <cCall: 'X11_XPutImage' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XQLength primitive function"
primXQLength
    <cCall: 'X11_XQLength' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XQueryBestCursor primitive function"
primXQueryBestCursor: arg1 width: arg4 height: arg5 widthReturn: arg6 heightReturn: arg7
    <cCall: 'X11_XQueryBestCursor' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XQueryBestSize primitive function"
primXQueryBestSize: arg1 whichScreen: arg4 width: arg5 height: arg6 widthReturn: arg7 heightReturn: arg8
    <cCall: 'X11_XQueryBestSize' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XQueryBestStipple primitive function"
primXQueryBestStipple: arg1 width: arg4 height: arg5 widthReturn: arg6 heightReturn: arg7
    <cCall: 'X11_XQueryBestStipple' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XQueryBestTile primitive function"
primXQueryBestTile: arg1 width: arg4 height: arg5 widthReturn: arg6 heightReturn: arg7
    <cCall: 'X11_XQueryBestTile' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XQueryColor primitive function"
primXQueryColor: arg1 defInOut: arg4
    <cCall: 'X11_XQueryColor' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XQueryColors primitive function"
primXQueryColors: arg1 defsInOut: arg4 ncolors: arg5
    <cCall: 'X11_XQueryColors' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XQueryExtension primitive function"
primXQueryExtension: arg1 majorOpcodeReturn: arg4 firstEventReturn: arg5 firstErrorReturn: arg6
    <cCall: 'X11_XQueryExtension' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XQueryKeymap primitive function"
primXQueryKeymap: arg1
    <cCall: 'X11_XQueryKeymap' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XQueryPointer primitive function"
primXQueryPointer: arg1 rootReturn: arg4 childReturn: arg5 rootXReturn: arg6 rootYReturn: arg7 winXReturn: arg8 winYReturn: arg9 maskReturn: arg10
    <cCall: 'X11_XQueryPointer' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XQueryTextExtents primitive function"
primXQueryTextExtents: arg1 string: arg4 nchars: arg5 directionReturn: arg6 fontAscentReturn: arg7 fontDescentReturn: arg8 overallReturn: arg9
    <cCall: 'X11_XQueryTextExtents' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XQueryTextExtents16 primitive function"
primXQueryTextExtents16: arg1 string: arg4 nchars: arg5 directionReturn: arg6 fontAscentReturn: arg7 fontDescentReturn: arg8 overallReturn: arg9
    <cCall: 'X11_XQueryTextExtents16' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XQueryTree primitive function"
primXQueryTree: arg1 rootReturn: arg4 parentReturn: arg5 childrenReturn: arg6 nchildrenReturn: arg7
    <cCall: 'X11_XQueryTree' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XRaiseWindow primitive function"
primXRaiseWindow: arg1
    <cCall: 'X11_XRaiseWindow' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XReadBitmapFile primitive function"
primXReadBitmapFile: arg1 filename: arg4 widthReturn: arg5 heightReturn: arg6 bitmapReturn: arg7 xHotReturn: arg8 yHotReturn: arg9
    <cCall: 'X11_XReadBitmapFile' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XRebindKeysym primitive function"
primXRebindKeysym: arg1 list: arg4 modCount: arg5 string: arg6 bytesString: arg7
    <cCall: 'X11_XRebindKeysym' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XRecolorCursor primitive function"
primXRecolorCursor: arg1 foregroundColor: arg4 backgroundColor: arg5
    <cCall: 'X11_XRecolorCursor' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XRemoveFromSaveSet primitive function"
primXRemoveFromSaveSet: arg1
    <cCall: 'X11_XRemoveFromSaveSet' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XRemoveHost primitive function"
primXRemoveHost: arg1
    <cCall: 'X11_XRemoveHost' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XRemoveHosts primitive function"
primXRemoveHosts: arg1 numHosts: arg4
    <cCall: 'X11_XRemoveHosts' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XReparentWindow primitive function"
primXReparentWindow: arg1 parent: arg4 x: arg5 y: arg6
    <cCall: 'X11_XReparentWindow' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XResetScreenSaver primitive function"
primXResetScreenSaver
    <cCall: 'X11_XResetScreenSaver' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XResizeWindow primitive function"
primXResizeWindow: arg1 width: arg4 height: arg5
    <cCall: 'X11_XResizeWindow' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XRestackWindows primitive function"
primXRestackWindows: arg1 nwindows: arg4
    <cCall: 'X11_XRestackWindows' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XRotateBuffers primitive function"
primXRotateBuffers: arg1
    <cCall: 'X11_XRotateBuffers' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XRotateWindowProperties primitive function"
primXRotateWindowProperties: arg1 properties: arg4 numProp: arg5 npositions: arg6
    <cCall: 'X11_XRotateWindowProperties' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XScreenCount primitive function"
primXScreenCount
    <cCall: 'X11_XScreenCount' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XSelectInput primitive function"
primXSelectInput: arg1 eventMask: arg4
    <cCall: 'X11_XSelectInput' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XSendEvent primitive function"
primXSendEvent: arg1 propagate: arg4 eventMask: arg5 eventSend: arg6
    <cCall: 'X11_XSendEvent' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XSetAccessControl primitive function"
primXSetAccessControl: arg1
    <cCall: 'X11_XSetAccessControl' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XSetArcMode primitive function"
primXSetArcMode: arg1 arcMode: arg4
    <cCall: 'X11_XSetArcMode' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XSetBackground primitive function"
primXSetBackground: arg1 background: arg4
    <cCall: 'X11_XSetBackground' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XSetClipMask primitive function"
primXSetClipMask: arg1 pixmap: arg4
    <cCall: 'X11_XSetClipMask' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XSetClipOrigin primitive function"
primXSetClipOrigin: arg1 clipXOrigin: arg4 clipYOrigin: arg5
    <cCall: 'X11_XSetClipOrigin' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XSetClipRectangles primitive function"
primXSetClipRectangles: arg1 clipXOrigin: arg4 clipYOrigin: arg5 rectangles: arg6 n: arg7 ordering: arg8
    <cCall: 'X11_XSetClipRectangles' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XSetCloseDownMode primitive function"
primXSetCloseDownMode: arg1
    <cCall: 'X11_XSetCloseDownMode' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XSetCommand primitive function"
primXSetCommand: arg1 argv: arg4 argc: arg5
    <cCall: 'X11_XSetCommand' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XSetDashes primitive function"
primXSetDashes: arg1 dashOffset: arg4 dashList: arg5 n: arg6
    <cCall: 'X11_XSetDashes' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XSetFillRule primitive function"
primXSetFillRule: arg1 fillRule: arg4
    <cCall: 'X11_XSetFillRule' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XSetFillStyle primitive function"
primXSetFillStyle: arg1 fillStyle: arg4
    <cCall: 'X11_XSetFillStyle' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XSetFont primitive function"
primXSetFont: arg1 font: arg4
    <cCall: 'X11_XSetFont' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XSetFontPath primitive function"
primXSetFontPath: arg1 ndirs: arg4
    <cCall: 'X11_XSetFontPath' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XSetForeground primitive function"
primXSetForeground: arg1 foreground: arg4
    <cCall: 'X11_XSetForeground' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XSetFunction primitive function"
primXSetFunction: arg1 function: arg4
    <cCall: 'X11_XSetFunction' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XSetGraphicsExposures primitive function"
primXSetGraphicsExposures: arg1 graphicsExposures: arg4
    <cCall: 'X11_XSetGraphicsExposures' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XSetIconName primitive function"
primXSetIconName: arg1 iconName: arg4
    <cCall: 'X11_XSetIconName' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XSetInputFocus primitive function"
primXSetInputFocus: arg1 revertTo: arg4 time: arg5
    <cCall: 'X11_XSetInputFocus' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XSetLineAttributes primitive function"
primXSetLineAttributes: arg1 lineWidth: arg4 lineStyle: arg5 capStyle: arg6 joinStyle: arg7
    <cCall: 'X11_XSetLineAttributes' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XSetModifierMapping primitive function"
primXSetModifierMapping: arg1
    <cCall: 'X11_XSetModifierMapping' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XSetPlaneMask primitive function"
primXSetPlaneMask: arg1 planeMask: arg4
    <cCall: 'X11_XSetPlaneMask' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XSetPointerMapping primitive function"
primXSetPointerMapping: arg1 nmap: arg4
    <cCall: 'X11_XSetPointerMapping' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XSetScreenSaver primitive function"
primXSetScreenSaver: arg1 interval: arg4 preferBlanking: arg5 allowExposures: arg6
    <cCall: 'X11_XSetScreenSaver' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XSetSelectionOwner primitive function"
primXSetSelectionOwner: arg1 owner: arg4 time: arg5
    <cCall: 'X11_XSetSelectionOwner' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XSetState primitive function"
primXSetState: arg1 foreground: arg4 background: arg5 function: arg6 planeMask: arg7
    <cCall: 'X11_XSetState' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XSetStipple primitive function"
primXSetStipple: arg1 stipple: arg4
    <cCall: 'X11_XSetStipple' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XSetSubwindowMode primitive function"
primXSetSubwindowMode: arg1 subwindowMode: arg4
    <cCall: 'X11_XSetSubwindowMode' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XSetTSOrigin primitive function"
primXSetTSOrigin: arg1 tsXOrigin: arg4 tsYOrigin: arg5
    <cCall: 'X11_XSetTSOrigin' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XSetTile primitive function"
primXSetTile: arg1 tile: arg4
    <cCall: 'X11_XSetTile' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XSetWindowBackground primitive function"
primXSetWindowBackground: arg1 backgroundPixel: arg4
    <cCall: 'X11_XSetWindowBackground' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XSetWindowBackgroundPixmap primitive function"
primXSetWindowBackgroundPixmap: arg1 backgroundPixmap: arg4
    <cCall: 'X11_XSetWindowBackgroundPixmap' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XSetWindowBorder primitive function"
primXSetWindowBorder: arg1 borderPixel: arg4
    <cCall: 'X11_XSetWindowBorder' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XSetWindowBorderPixmap primitive function"
primXSetWindowBorderPixmap: arg1 borderPixmap: arg4
    <cCall: 'X11_XSetWindowBorderPixmap' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XSetWindowBorderWidth primitive function"
primXSetWindowBorderWidth: arg1 width: arg4
    <cCall: 'X11_XSetWindowBorderWidth' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XSetWindowColormap primitive function"
primXSetWindowColormap: arg1 colormap: arg4
    <cCall: 'X11_XSetWindowColormap' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XStoreBuffer primitive function"
primXStoreBuffer: arg1 nbytes: arg4 buffer: arg5
    <cCall: 'X11_XStoreBuffer' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XStoreBytes primitive function"
primXStoreBytes: arg1 nbytes: arg4
    <cCall: 'X11_XStoreBytes' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XStoreColor primitive function"
primXStoreColor: arg1 color: arg4
    <cCall: 'X11_XStoreColor' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XStoreColors primitive function"
primXStoreColors: arg1 color: arg4 ncolors: arg5
    <cCall: 'X11_XStoreColors' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XStoreName primitive function"
primXStoreName: arg1 windowName: arg4
    <cCall: 'X11_XStoreName' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XStoreNamedColor primitive function"
primXStoreNamedColor: arg1 color: arg4 pixel: arg5 flags: arg6
    <cCall: 'X11_XStoreNamedColor' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XSync primitive function"
primXSync: arg1
    <cCall: 'X11_XSync' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XTranslateCoordinates primitive function"
primXTranslateCoordinates: arg1 destW: arg4 srcX: arg5 srcY: arg6 destXReturn: arg7 destYReturn: arg8 childReturn: arg9
    <cCall: 'X11_XTranslateCoordinates' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XUndefineCursor primitive function"
primXUndefineCursor: arg1
    <cCall: 'X11_XUndefineCursor' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XUngrabButton primitive function"
primXUngrabButton: arg1 modifiers: arg4 grabWindow: arg5
    <cCall: 'X11_XUngrabButton' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XUngrabKey primitive function"
primXUngrabKey: arg1 modifiers: arg4 grabWindow: arg5
    <cCall: 'X11_XUngrabKey' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XUngrabKeyboard primitive function"
primXUngrabKeyboard: arg1
    <cCall: 'X11_XUngrabKeyboard' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XUngrabPointer primitive function"
primXUngrabPointer: arg1
    <cCall: 'X11_XUngrabPointer' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XUngrabServer primitive function"
primXUngrabServer
    <cCall: 'X11_XUngrabServer' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XUninstallColormap primitive function"
primXUninstallColormap: arg1
    <cCall: 'X11_XUninstallColormap' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XUnloadFont primitive function"
primXUnloadFont: arg1
    <cCall: 'X11_XUnloadFont' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XUnmapSubwindows primitive function"
primXUnmapSubwindows: arg1
    <cCall: 'X11_XUnmapSubwindows' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XUnmapWindow primitive function"
primXUnmapWindow: arg1
    <cCall: 'X11_XUnmapWindow' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XVendorRelease primitive function"
primXVendorRelease
    <cCall: 'X11_XVendorRelease' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XWarpPointer primitive function"
primXWarpPointer: arg1 destW: arg4 srcX: arg5 srcY: arg6 srcWidth: arg7 srcHeight: arg8 destX: arg9 destY: arg10
    <cCall: 'X11_XWarpPointer' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XWindowEvent primitive function"
primXWindowEvent: arg1 eventMask: arg4 eventReturn: arg5
    <cCall: 'X11_XWindowEvent' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XWriteBitmapFile primitive function"
primXWriteBitmapFile: arg1 bitmap: arg4 width: arg5 height: arg6 xHot: arg7 yHot: arg8
    <cCall: 'X11_XWriteBitmapFile' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XOpenOM primitive function"
primXOpenOM: arg1 resName: arg4 resClass: arg5
    <cCall: 'X11_XOpenOM' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XCreateFontSet primitive function"
primXCreateFontSet: arg1 missingCharsetList: arg4 missingCharsetCount: arg5 defString: arg6
    <cCall: 'X11_XCreateFontSet' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XFreeFontSet primitive function"
primXFreeFontSet: arg1
    <cCall: 'X11_XFreeFontSet' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XmbDrawText primitive function"
primXmbDrawText: arg1 gc: arg4 x: arg5 y: arg6 textItems: arg7 nitems: arg8
    <cCall: 'X11_XmbDrawText' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XwcDrawText primitive function"
primXwcDrawText: arg1 gc: arg4 x: arg5 y: arg6 textItems: arg7 nitems: arg8
    <cCall: 'X11_XwcDrawText' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XmbDrawString primitive function"
primXmbDrawString: arg1 fontSet: arg4 gc: arg5 x: arg6 y: arg7 text: arg8 bytesText: arg9
    <cCall: 'X11_XmbDrawString' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XwcDrawString primitive function"
primXwcDrawString: arg1 fontSet: arg4 gc: arg5 x: arg6 y: arg7 text: arg8 numWchars: arg9
    <cCall: 'X11_XwcDrawString' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XmbDrawImageString primitive function"
primXmbDrawImageString: arg1 fontSet: arg4 gc: arg5 x: arg6 y: arg7 text: arg8 bytesText: arg9
    <cCall: 'X11_XmbDrawImageString' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XwcDrawImageString primitive function"
primXwcDrawImageString: arg1 fontSet: arg4 gc: arg5 x: arg6 y: arg7 text: arg8 numWchars: arg9
    <cCall: 'X11_XwcDrawImageString' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XOpenIM primitive function"
primXOpenIM: arg1 resName: arg4 resClass: arg5
    <cCall: 'X11_XOpenIM' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XRegisterIMInstantiateCallback primitive function commented out."
"primXRegisterIMInstantiateCallback"
"_________________________________________________________"
"XUnregisterIMInstantiateCallback primitive function commented out."
"primXUnregisterIMInstantiateCallback"
"_________________________________________________________"
"XInternalConnectionNumbers primitive function"
primXInternalConnectionNumbers: arg1 countReturn: arg4
    <cCall: 'X11_XInternalConnectionNumbers' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XProcessInternalConnection primitive function"
primXProcessInternalConnection: arg1
    <cCall: 'X11_XProcessInternalConnection' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XAddConnectionWatch primitive function"
primXAddConnectionWatch: arg1 clientData: arg4
    <cCall: 'X11_XAddConnectionWatch' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XRemoveConnectionWatch primitive function"
primXRemoveConnectionWatch: arg1 clientData: arg4
    <cCall: 'X11_XRemoveConnectionWatch' plugin: 'x11'>
    self primitiveFailed
!




primX11DisplayDelete
    <cCall: 'X11_delete_Display' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11DisplayDelete.
!


name
    ^'X11Display'

! !

!X11Display methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11Display methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XHostAddress
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XHostAddress class methodsFor: 'initialize-release'!

primX11XHostAddressCreate
    <cCall: 'X11_new_XHostAddress' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XHostAddressCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XHostAddress  methodsFor: 'X11'!

"_________________________________________________________"
"family primitive accessors"
primXHostAddressFamily
    <cCall: 'X11_XHostAddress_family_get' plugin: 'x11'>
    self primitiveFailed
!
primXHostAddressFamily: val
    <cCall: 'X11_XHostAddress_family_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"family accessors"
family
    ^self primXHostAddressFamily
!
family: val
    ^self primXHostAddressFamily: val
!

"_________________________________________________________"
"length primitive accessors"
primXHostAddressLength
    <cCall: 'X11_XHostAddress_length_get' plugin: 'x11'>
    self primitiveFailed
!
primXHostAddressLength: val
    <cCall: 'X11_XHostAddress_length_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"length accessors"
length
    ^self primXHostAddressLength
!
length: val
    ^self primXHostAddressLength: val
!

"_________________________________________________________"
"address primitive accessors"
primXHostAddressAddress
    <cCall: 'X11_XHostAddress_address_get' plugin: 'x11'>
    self primitiveFailed
!
primXHostAddressAddress: val
    <cCall: 'X11_XHostAddress_address_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"address accessors"
address
    ^self primXHostAddressAddress
!
address: val
    ^self primXHostAddressAddress: val
!






primX11XHostAddressDelete
    <cCall: 'X11_delete_XHostAddress' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XHostAddressDelete.
!


name
    ^'X11XHostAddress'

! !

!X11XHostAddress methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XHostAddress methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11Depth
        instanceVariableNames: ''
        classVariableNames: ''!

!X11Depth class methodsFor: 'initialize-release'!

primX11DepthCreate
    <cCall: 'X11_new_Depth' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11DepthCreate).
!

initialize
    finalizationRequest := true.
! !

!X11Depth  methodsFor: 'X11'!

"_________________________________________________________"
"depth primitive accessors"
primDepthDepth
    <cCall: 'X11_Depth_depth_get' plugin: 'x11'>
    self primitiveFailed
!
primDepthDepth: val
    <cCall: 'X11_Depth_depth_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"depth accessors"
depth
    ^self primDepthDepth
!
depth: val
    ^self primDepthDepth: val
!

"_________________________________________________________"
"nvisuals primitive accessors"
primDepthNvisuals
    <cCall: 'X11_Depth_nvisuals_get' plugin: 'x11'>
    self primitiveFailed
!
primDepthNvisuals: val
    <cCall: 'X11_Depth_nvisuals_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"nvisuals accessors"
nvisuals
    ^self primDepthNvisuals
!
nvisuals: val
    ^self primDepthNvisuals: val
!

"_________________________________________________________"
"visuals primitive accessors"
primDepthVisuals
    <cCall: 'X11_Depth_visuals_get' plugin: 'x11'>
    self primitiveFailed
!
primDepthVisuals: val
    <cCall: 'X11_Depth_visuals_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"visuals accessors"
visuals
    ^self primDepthVisuals
!
visuals: val
    ^self primDepthVisuals: val
!






primX11DepthDelete
    <cCall: 'X11_delete_Depth' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11DepthDelete.
!


name
    ^'X11Depth'

! !

!X11Depth methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11Depth methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XEDataObject
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XEDataObject class methodsFor: 'initialize-release'!

primX11XEDataObjectCreate
    <cCall: 'X11_new_XEDataObject' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XEDataObjectCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XEDataObject  methodsFor: 'X11'!

"_________________________________________________________"
"display primitive accessors"
primXEDataObjectDisplay
    <cCall: 'X11_XEDataObject_display_get' plugin: 'x11'>
    self primitiveFailed
!
primXEDataObjectDisplay: val
    <cCall: 'X11_XEDataObject_display_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"display accessors"
display
    ^self primXEDataObjectDisplay
!
display: val
    ^self primXEDataObjectDisplay: val
!

"_________________________________________________________"
"gc primitive accessors"
primXEDataObjectGc
    <cCall: 'X11_XEDataObject_gc_get' plugin: 'x11'>
    self primitiveFailed
!
primXEDataObjectGc: val
    <cCall: 'X11_XEDataObject_gc_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"gc accessors"
gc
    ^self primXEDataObjectGc
!
gc: val
    ^self primXEDataObjectGc: val
!

"_________________________________________________________"
"visual primitive accessors"
primXEDataObjectVisual
    <cCall: 'X11_XEDataObject_visual_get' plugin: 'x11'>
    self primitiveFailed
!
primXEDataObjectVisual: val
    <cCall: 'X11_XEDataObject_visual_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"visual accessors"
visual
    ^self primXEDataObjectVisual
!
visual: val
    ^self primXEDataObjectVisual: val
!

"_________________________________________________________"
"screen primitive accessors"
primXEDataObjectScreen
    <cCall: 'X11_XEDataObject_screen_get' plugin: 'x11'>
    self primitiveFailed
!
primXEDataObjectScreen: val
    <cCall: 'X11_XEDataObject_screen_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"screen accessors"
screen
    ^self primXEDataObjectScreen
!
screen: val
    ^self primXEDataObjectScreen: val
!

"_________________________________________________________"
"pixmap_format primitive accessors"
primXEDataObjectPixmapFormat
    <cCall: 'X11_XEDataObject_pixmap_format_get' plugin: 'x11'>
    self primitiveFailed
!
primXEDataObjectPixmapFormat: val
    <cCall: 'X11_XEDataObject_pixmap_format_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"pixmap_format accessors"
pixmapformat
    ^self primXEDataObjectPixmapFormat
!
pixmapformat: val
    ^self primXEDataObjectPixmapFormat: val
!

"_________________________________________________________"
"font primitive accessors"
primXEDataObjectFont
    <cCall: 'X11_XEDataObject_font_get' plugin: 'x11'>
    self primitiveFailed
!
primXEDataObjectFont: val
    <cCall: 'X11_XEDataObject_font_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"font accessors"
font
    ^self primXEDataObjectFont
!
font: val
    ^self primXEDataObjectFont: val
!






primX11XEDataObjectDelete
    <cCall: 'X11_delete_XEDataObject' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XEDataObjectDelete.
!


name
    ^'X11XEDataObject'

! !

!X11XEDataObject methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XEDataObject methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11Screen
        instanceVariableNames: ''
        classVariableNames: ''!

!X11Screen class methodsFor: 'initialize-release'!

primX11ScreenCreate
    <cCall: 'X11_new_Screen' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11ScreenCreate).
!

initialize
    finalizationRequest := true.
! !

!X11Screen  methodsFor: 'X11'!

"_________________________________________________________"
"ext_data primitive accessors"
primScreenExtData
    <cCall: 'X11_Screen_ext_data_get' plugin: 'x11'>
    self primitiveFailed
!
primScreenExtData: val
    <cCall: 'X11_Screen_ext_data_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"ext_data accessors"
extdata
    ^self primScreenExtData
!
extdata: val
    ^self primScreenExtData: val
!

"_________________________________________________________"
"display primitive accessors"
primScreenDisplay
    <cCall: 'X11_Screen_display_get' plugin: 'x11'>
    self primitiveFailed
!
primScreenDisplay: val
    <cCall: 'X11_Screen_display_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"display accessors"
display
    ^self primScreenDisplay
!
display: val
    ^self primScreenDisplay: val
!

"_________________________________________________________"
"root primitive accessors"
primScreenRoot
    <cCall: 'X11_Screen_root_get' plugin: 'x11'>
    self primitiveFailed
!
primScreenRoot: val
    <cCall: 'X11_Screen_root_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"root accessors"
root
    ^self primScreenRoot
!
root: val
    ^self primScreenRoot: val
!

"_________________________________________________________"
"width primitive accessors"
primScreenWidth
    <cCall: 'X11_Screen_width_get' plugin: 'x11'>
    self primitiveFailed
!
primScreenWidth: val
    <cCall: 'X11_Screen_width_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"width accessors"
width
    ^self primScreenWidth
!
width: val
    ^self primScreenWidth: val
!

"_________________________________________________________"
"height primitive accessors"
primScreenHeight
    <cCall: 'X11_Screen_height_get' plugin: 'x11'>
    self primitiveFailed
!
primScreenHeight: val
    <cCall: 'X11_Screen_height_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"height accessors"
height
    ^self primScreenHeight
!
height: val
    ^self primScreenHeight: val
!

"_________________________________________________________"
"mwidth primitive accessors"
primScreenMwidth
    <cCall: 'X11_Screen_mwidth_get' plugin: 'x11'>
    self primitiveFailed
!
primScreenMwidth: val
    <cCall: 'X11_Screen_mwidth_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"mwidth accessors"
mwidth
    ^self primScreenMwidth
!
mwidth: val
    ^self primScreenMwidth: val
!

"_________________________________________________________"
"mheight primitive accessors"
primScreenMheight
    <cCall: 'X11_Screen_mheight_get' plugin: 'x11'>
    self primitiveFailed
!
primScreenMheight: val
    <cCall: 'X11_Screen_mheight_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"mheight accessors"
mheight
    ^self primScreenMheight
!
mheight: val
    ^self primScreenMheight: val
!

"_________________________________________________________"
"ndepths primitive accessors"
primScreenNdepths
    <cCall: 'X11_Screen_ndepths_get' plugin: 'x11'>
    self primitiveFailed
!
primScreenNdepths: val
    <cCall: 'X11_Screen_ndepths_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"ndepths accessors"
ndepths
    ^self primScreenNdepths
!
ndepths: val
    ^self primScreenNdepths: val
!

"_________________________________________________________"
"depths primitive accessors"
primScreenDepths
    <cCall: 'X11_Screen_depths_get' plugin: 'x11'>
    self primitiveFailed
!
primScreenDepths: val
    <cCall: 'X11_Screen_depths_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"depths accessors"
depths
    ^self primScreenDepths
!
depths: val
    ^self primScreenDepths: val
!

"_________________________________________________________"
"root_depth primitive accessors"
primScreenRootDepth
    <cCall: 'X11_Screen_root_depth_get' plugin: 'x11'>
    self primitiveFailed
!
primScreenRootDepth: val
    <cCall: 'X11_Screen_root_depth_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"root_depth accessors"
rootdepth
    ^self primScreenRootDepth
!
rootdepth: val
    ^self primScreenRootDepth: val
!

"_________________________________________________________"
"root_visual primitive accessors"
primScreenRootVisual
    <cCall: 'X11_Screen_root_visual_get' plugin: 'x11'>
    self primitiveFailed
!
primScreenRootVisual: val
    <cCall: 'X11_Screen_root_visual_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"root_visual accessors"
rootvisual
    ^self primScreenRootVisual
!
rootvisual: val
    ^self primScreenRootVisual: val
!

"_________________________________________________________"
"default_gc primitive accessors"
primScreenDefaultGc
    <cCall: 'X11_Screen_default_gc_get' plugin: 'x11'>
    self primitiveFailed
!
primScreenDefaultGc: val
    <cCall: 'X11_Screen_default_gc_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"default_gc accessors"
defaultgc
    ^self primScreenDefaultGc
!
defaultgc: val
    ^self primScreenDefaultGc: val
!

"_________________________________________________________"
"cmap primitive accessors"
primScreenCmap
    <cCall: 'X11_Screen_cmap_get' plugin: 'x11'>
    self primitiveFailed
!
primScreenCmap: val
    <cCall: 'X11_Screen_cmap_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"cmap accessors"
cmap
    ^self primScreenCmap
!
cmap: val
    ^self primScreenCmap: val
!

"_________________________________________________________"
"white_pixel primitive accessors"
primScreenWhitePixel
    <cCall: 'X11_Screen_white_pixel_get' plugin: 'x11'>
    self primitiveFailed
!
primScreenWhitePixel: val
    <cCall: 'X11_Screen_white_pixel_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"white_pixel accessors"
whitepixel
    ^self primScreenWhitePixel
!
whitepixel: val
    ^self primScreenWhitePixel: val
!

"_________________________________________________________"
"black_pixel primitive accessors"
primScreenBlackPixel
    <cCall: 'X11_Screen_black_pixel_get' plugin: 'x11'>
    self primitiveFailed
!
primScreenBlackPixel: val
    <cCall: 'X11_Screen_black_pixel_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"black_pixel accessors"
blackpixel
    ^self primScreenBlackPixel
!
blackpixel: val
    ^self primScreenBlackPixel: val
!

"_________________________________________________________"
"max_maps primitive accessors"
primScreenMaxMaps
    <cCall: 'X11_Screen_max_maps_get' plugin: 'x11'>
    self primitiveFailed
!
primScreenMaxMaps: val
    <cCall: 'X11_Screen_max_maps_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"max_maps accessors"
maxmaps
    ^self primScreenMaxMaps
!
maxmaps: val
    ^self primScreenMaxMaps: val
!

"_________________________________________________________"
"min_maps primitive accessors"
primScreenMinMaps
    <cCall: 'X11_Screen_min_maps_get' plugin: 'x11'>
    self primitiveFailed
!
primScreenMinMaps: val
    <cCall: 'X11_Screen_min_maps_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"min_maps accessors"
minmaps
    ^self primScreenMinMaps
!
minmaps: val
    ^self primScreenMinMaps: val
!

"_________________________________________________________"
"backing_store primitive accessors"
primScreenBackingStore
    <cCall: 'X11_Screen_backing_store_get' plugin: 'x11'>
    self primitiveFailed
!
primScreenBackingStore: val
    <cCall: 'X11_Screen_backing_store_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"backing_store accessors"
backingstore
    ^self primScreenBackingStore
!
backingstore: val
    ^self primScreenBackingStore: val
!

"_________________________________________________________"
"save_unders primitive accessors"
primScreenSaveUnders
    <cCall: 'X11_Screen_save_unders_get' plugin: 'x11'>
    self primitiveFailed
!
primScreenSaveUnders: val
    <cCall: 'X11_Screen_save_unders_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"save_unders accessors"
saveunders
    ^self primScreenSaveUnders
!
saveunders: val
    ^self primScreenSaveUnders: val
!

"_________________________________________________________"
"root_input_mask primitive accessors"
primScreenRootInputMask
    <cCall: 'X11_Screen_root_input_mask_get' plugin: 'x11'>
    self primitiveFailed
!
primScreenRootInputMask: val
    <cCall: 'X11_Screen_root_input_mask_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"root_input_mask accessors"
rootinputmask
    ^self primScreenRootInputMask
!
rootinputmask: val
    ^self primScreenRootInputMask: val
!



"_________________________________________________________"
"XScreenResourceString primitive function"
primXScreenResourceString
    <cCall: 'X11_XScreenResourceString' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XRootWindowOfScreen primitive function"
primXRootWindowOfScreen
    <cCall: 'X11_XRootWindowOfScreen' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XDefaultVisualOfScreen primitive function"
primXDefaultVisualOfScreen
    <cCall: 'X11_XDefaultVisualOfScreen' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XDefaultGCOfScreen primitive function"
primXDefaultGCOfScreen
    <cCall: 'X11_XDefaultGCOfScreen' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XBlackPixelOfScreen primitive function"
primXBlackPixelOfScreen
    <cCall: 'X11_XBlackPixelOfScreen' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XWhitePixelOfScreen primitive function"
primXWhitePixelOfScreen
    <cCall: 'X11_XWhitePixelOfScreen' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XDefaultColormapOfScreen primitive function"
primXDefaultColormapOfScreen
    <cCall: 'X11_XDefaultColormapOfScreen' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XDisplayOfScreen primitive function"
primXDisplayOfScreen
    <cCall: 'X11_XDisplayOfScreen' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XEventMaskOfScreen primitive function"
primXEventMaskOfScreen
    <cCall: 'X11_XEventMaskOfScreen' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XScreenNumberOfScreen primitive function"
primXScreenNumberOfScreen
    <cCall: 'X11_XScreenNumberOfScreen' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XCellsOfScreen primitive function"
primXCellsOfScreen
    <cCall: 'X11_XCellsOfScreen' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XDefaultDepthOfScreen primitive function"
primXDefaultDepthOfScreen
    <cCall: 'X11_XDefaultDepthOfScreen' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XDoesBackingStore primitive function"
primXDoesBackingStore
    <cCall: 'X11_XDoesBackingStore' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XDoesSaveUnders primitive function"
primXDoesSaveUnders
    <cCall: 'X11_XDoesSaveUnders' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XHeightMMOfScreen primitive function"
primXHeightMMOfScreen
    <cCall: 'X11_XHeightMMOfScreen' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XHeightOfScreen primitive function"
primXHeightOfScreen
    <cCall: 'X11_XHeightOfScreen' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XMaxCmapsOfScreen primitive function"
primXMaxCmapsOfScreen
    <cCall: 'X11_XMaxCmapsOfScreen' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XMinCmapsOfScreen primitive function"
primXMinCmapsOfScreen
    <cCall: 'X11_XMinCmapsOfScreen' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XPlanesOfScreen primitive function"
primXPlanesOfScreen
    <cCall: 'X11_XPlanesOfScreen' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XWidthMMOfScreen primitive function"
primXWidthMMOfScreen
    <cCall: 'X11_XWidthMMOfScreen' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XWidthOfScreen primitive function"
primXWidthOfScreen
    <cCall: 'X11_XWidthOfScreen' plugin: 'x11'>
    self primitiveFailed
!




primX11ScreenDelete
    <cCall: 'X11_delete_Screen' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11ScreenDelete.
!


name
    ^'X11Screen'

! !

!X11Screen methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11Screen methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XIMStringConversionText
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XIMStringConversionText class methodsFor: 'initialize-release'!

primX11XIMStringConversionTextCreate
    <cCall: 'X11_new_XIMStringConversionText' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XIMStringConversionTextCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XIMStringConversionText  methodsFor: 'X11'!

"_________________________________________________________"
"length primitive accessors"
primXIMStringConversionTextLength
    <cCall: 'X11_XIMStringConversionText_length_get' plugin: 'x11'>
    self primitiveFailed
!
primXIMStringConversionTextLength: val
    <cCall: 'X11_XIMStringConversionText_length_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"length accessors"
length
    ^self primXIMStringConversionTextLength
!
length: val
    ^self primXIMStringConversionTextLength: val
!

"_________________________________________________________"
"feedback primitive accessors"
primXIMStringConversionTextFeedback
    <cCall: 'X11_XIMStringConversionText_feedback_get' plugin: 'x11'>
    self primitiveFailed
!
primXIMStringConversionTextFeedback: val
    <cCall: 'X11_XIMStringConversionText_feedback_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"feedback accessors"
feedback
    ^self primXIMStringConversionTextFeedback
!
feedback: val
    ^self primXIMStringConversionTextFeedback: val
!

"_________________________________________________________"
"encoding_is_wchar primitive accessors"
primXIMStringConversionTextEncodingIsWchar
    <cCall: 'X11_XIMStringConversionText_encoding_is_wchar_get' plugin: 'x11'>
    self primitiveFailed
!
primXIMStringConversionTextEncodingIsWchar: val
    <cCall: 'X11_XIMStringConversionText_encoding_is_wchar_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"encoding_is_wchar accessors"
encodingiswchar
    ^self primXIMStringConversionTextEncodingIsWchar
!
encodingiswchar: val
    ^self primXIMStringConversionTextEncodingIsWchar: val
!

"_________________________________________________________"
"string primitive accessors"
primXIMStringConversionTextString
    <cCall: 'X11_XIMStringConversionText_string_get' plugin: 'x11'>
    self primitiveFailed
!
primXIMStringConversionTextString: val
    <cCall: 'X11_XIMStringConversionText_string_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"string accessors"
string
    ^self primXIMStringConversionTextString
!
string: val
    ^self primXIMStringConversionTextString: val
!






primX11XIMStringConversionTextDelete
    <cCall: 'X11_delete_XIMStringConversionText' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XIMStringConversionTextDelete.
!


name
    ^'X11XIMStringConversionText'

! !

!X11XIMStringConversionText methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XIMStringConversionText methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XImage
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XImage class methodsFor: 'initialize-release'!

primX11XImageCreate
    <cCall: 'X11_new_XImage' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XImageCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XImage  methodsFor: 'X11'!

"_________________________________________________________"
"width primitive accessors"
primXImageWidth
    <cCall: 'X11_XImage_width_get' plugin: 'x11'>
    self primitiveFailed
!
primXImageWidth: val
    <cCall: 'X11_XImage_width_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"width accessors"
width
    ^self primXImageWidth
!
width: val
    ^self primXImageWidth: val
!

"_________________________________________________________"
"height primitive accessors"
primXImageHeight
    <cCall: 'X11_XImage_height_get' plugin: 'x11'>
    self primitiveFailed
!
primXImageHeight: val
    <cCall: 'X11_XImage_height_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"height accessors"
height
    ^self primXImageHeight
!
height: val
    ^self primXImageHeight: val
!

"_________________________________________________________"
"xoffset primitive accessors"
primXImageXoffset
    <cCall: 'X11_XImage_xoffset_get' plugin: 'x11'>
    self primitiveFailed
!
primXImageXoffset: val
    <cCall: 'X11_XImage_xoffset_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"xoffset accessors"
xoffset
    ^self primXImageXoffset
!
xoffset: val
    ^self primXImageXoffset: val
!

"_________________________________________________________"
"format primitive accessors"
primXImageFormat
    <cCall: 'X11_XImage_format_get' plugin: 'x11'>
    self primitiveFailed
!
primXImageFormat: val
    <cCall: 'X11_XImage_format_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"format accessors"
format
    ^self primXImageFormat
!
format: val
    ^self primXImageFormat: val
!

"_________________________________________________________"
"data primitive accessors"
primXImageData
    <cCall: 'X11_XImage_data_get' plugin: 'x11'>
    self primitiveFailed
!
primXImageData: val
    <cCall: 'X11_XImage_data_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"data accessors"
data
    ^self primXImageData
!
data: val
    ^self primXImageData: val
!

"_________________________________________________________"
"byte_order primitive accessors"
primXImageByteOrder
    <cCall: 'X11_XImage_byte_order_get' plugin: 'x11'>
    self primitiveFailed
!
primXImageByteOrder: val
    <cCall: 'X11_XImage_byte_order_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"byte_order accessors"
byteorder
    ^self primXImageByteOrder
!
byteorder: val
    ^self primXImageByteOrder: val
!

"_________________________________________________________"
"bitmap_unit primitive accessors"
primXImageBitmapUnit
    <cCall: 'X11_XImage_bitmap_unit_get' plugin: 'x11'>
    self primitiveFailed
!
primXImageBitmapUnit: val
    <cCall: 'X11_XImage_bitmap_unit_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"bitmap_unit accessors"
bitmapunit
    ^self primXImageBitmapUnit
!
bitmapunit: val
    ^self primXImageBitmapUnit: val
!

"_________________________________________________________"
"bitmap_bit_order primitive accessors"
primXImageBitmapBitOrder
    <cCall: 'X11_XImage_bitmap_bit_order_get' plugin: 'x11'>
    self primitiveFailed
!
primXImageBitmapBitOrder: val
    <cCall: 'X11_XImage_bitmap_bit_order_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"bitmap_bit_order accessors"
bitmapbitorder
    ^self primXImageBitmapBitOrder
!
bitmapbitorder: val
    ^self primXImageBitmapBitOrder: val
!

"_________________________________________________________"
"bitmap_pad primitive accessors"
primXImageBitmapPad
    <cCall: 'X11_XImage_bitmap_pad_get' plugin: 'x11'>
    self primitiveFailed
!
primXImageBitmapPad: val
    <cCall: 'X11_XImage_bitmap_pad_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"bitmap_pad accessors"
bitmappad
    ^self primXImageBitmapPad
!
bitmappad: val
    ^self primXImageBitmapPad: val
!

"_________________________________________________________"
"depth primitive accessors"
primXImageDepth
    <cCall: 'X11_XImage_depth_get' plugin: 'x11'>
    self primitiveFailed
!
primXImageDepth: val
    <cCall: 'X11_XImage_depth_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"depth accessors"
depth
    ^self primXImageDepth
!
depth: val
    ^self primXImageDepth: val
!

"_________________________________________________________"
"bytes_per_line primitive accessors"
primXImageBytesPerLine
    <cCall: 'X11_XImage_bytes_per_line_get' plugin: 'x11'>
    self primitiveFailed
!
primXImageBytesPerLine: val
    <cCall: 'X11_XImage_bytes_per_line_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"bytes_per_line accessors"
bytesperline
    ^self primXImageBytesPerLine
!
bytesperline: val
    ^self primXImageBytesPerLine: val
!

"_________________________________________________________"
"bits_per_pixel primitive accessors"
primXImageBitsPerPixel
    <cCall: 'X11_XImage_bits_per_pixel_get' plugin: 'x11'>
    self primitiveFailed
!
primXImageBitsPerPixel: val
    <cCall: 'X11_XImage_bits_per_pixel_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"bits_per_pixel accessors"
bitsperpixel
    ^self primXImageBitsPerPixel
!
bitsperpixel: val
    ^self primXImageBitsPerPixel: val
!

"_________________________________________________________"
"red_mask primitive accessors"
primXImageRedMask
    <cCall: 'X11_XImage_red_mask_get' plugin: 'x11'>
    self primitiveFailed
!
primXImageRedMask: val
    <cCall: 'X11_XImage_red_mask_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"red_mask accessors"
redmask
    ^self primXImageRedMask
!
redmask: val
    ^self primXImageRedMask: val
!

"_________________________________________________________"
"green_mask primitive accessors"
primXImageGreenMask
    <cCall: 'X11_XImage_green_mask_get' plugin: 'x11'>
    self primitiveFailed
!
primXImageGreenMask: val
    <cCall: 'X11_XImage_green_mask_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"green_mask accessors"
greenmask
    ^self primXImageGreenMask
!
greenmask: val
    ^self primXImageGreenMask: val
!

"_________________________________________________________"
"blue_mask primitive accessors"
primXImageBlueMask
    <cCall: 'X11_XImage_blue_mask_get' plugin: 'x11'>
    self primitiveFailed
!
primXImageBlueMask: val
    <cCall: 'X11_XImage_blue_mask_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"blue_mask accessors"
bluemask
    ^self primXImageBlueMask
!
bluemask: val
    ^self primXImageBlueMask: val
!

"_________________________________________________________"
"obdata primitive accessors"
primXImageObdata
    <cCall: 'X11_XImage_obdata_get' plugin: 'x11'>
    self primitiveFailed
!
primXImageObdata: val
    <cCall: 'X11_XImage_obdata_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"obdata accessors"
obdata
    ^self primXImageObdata
!
obdata: val
    ^self primXImageObdata: val
!

"_________________________________________________________"
"f primitive accessors"
primXImageF
    <cCall: 'X11_XImage_f_get' plugin: 'x11'>
    self primitiveFailed
!
primXImageF: val
    <cCall: 'X11_XImage_f_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"f accessors"
f
    ^self primXImageF
!
f: val
    ^self primXImageF: val
!



"_________________________________________________________"
"XInitImage primitive function"
primXInitImage
    <cCall: 'X11_XInitImage' plugin: 'x11'>
    self primitiveFailed
!




primX11XImageDelete
    <cCall: 'X11_delete_XImage' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XImageDelete.
!


name
    ^'X11XImage'

! !

!X11XImage methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XImage methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XRectangle
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XRectangle class methodsFor: 'initialize-release'!

primX11XRectangleCreate
    <cCall: 'X11_new_XRectangle' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XRectangleCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XRectangle  methodsFor: 'X11'!

"_________________________________________________________"
"x primitive accessors"
primXRectangleX
    <cCall: 'X11_XRectangle_x_get' plugin: 'x11'>
    self primitiveFailed
!
primXRectangleX: val
    <cCall: 'X11_XRectangle_x_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"x accessors"
x
    ^self primXRectangleX
!
x: val
    ^self primXRectangleX: val
!

"_________________________________________________________"
"y primitive accessors"
primXRectangleY
    <cCall: 'X11_XRectangle_y_get' plugin: 'x11'>
    self primitiveFailed
!
primXRectangleY: val
    <cCall: 'X11_XRectangle_y_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"y accessors"
y
    ^self primXRectangleY
!
y: val
    ^self primXRectangleY: val
!

"_________________________________________________________"
"width primitive accessors"
primXRectangleWidth
    <cCall: 'X11_XRectangle_width_get' plugin: 'x11'>
    self primitiveFailed
!
primXRectangleWidth: val
    <cCall: 'X11_XRectangle_width_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"width accessors"
width
    ^self primXRectangleWidth
!
width: val
    ^self primXRectangleWidth: val
!

"_________________________________________________________"
"height primitive accessors"
primXRectangleHeight
    <cCall: 'X11_XRectangle_height_get' plugin: 'x11'>
    self primitiveFailed
!
primXRectangleHeight: val
    <cCall: 'X11_XRectangle_height_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"height accessors"
height
    ^self primXRectangleHeight
!
height: val
    ^self primXRectangleHeight: val
!






primX11XRectangleDelete
    <cCall: 'X11_delete_XRectangle' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XRectangleDelete.
!


name
    ^'X11XRectangle'

! !

!X11XRectangle methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XRectangle methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XNoExposeEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XNoExposeEvent class methodsFor: 'initialize-release'!

primX11XNoExposeEventCreate
    <cCall: 'X11_new_XNoExposeEvent' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XNoExposeEventCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XNoExposeEvent  methodsFor: 'X11'!

"_________________________________________________________"
"type primitive accessors"
primXNoExposeEventType
    <cCall: 'X11_XNoExposeEvent_type_get' plugin: 'x11'>
    self primitiveFailed
!
primXNoExposeEventType: val
    <cCall: 'X11_XNoExposeEvent_type_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"type accessors"
type
    ^self primXNoExposeEventType
!
type: val
    ^self primXNoExposeEventType: val
!

"_________________________________________________________"
"serial primitive accessors"
primXNoExposeEventSerial
    <cCall: 'X11_XNoExposeEvent_serial_get' plugin: 'x11'>
    self primitiveFailed
!
primXNoExposeEventSerial: val
    <cCall: 'X11_XNoExposeEvent_serial_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"serial accessors"
serial
    ^self primXNoExposeEventSerial
!
serial: val
    ^self primXNoExposeEventSerial: val
!

"_________________________________________________________"
"send_event primitive accessors"
primXNoExposeEventSendEvent
    <cCall: 'X11_XNoExposeEvent_send_event_get' plugin: 'x11'>
    self primitiveFailed
!
primXNoExposeEventSendEvent: val
    <cCall: 'X11_XNoExposeEvent_send_event_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"send_event accessors"
sendevent
    ^self primXNoExposeEventSendEvent
!
sendevent: val
    ^self primXNoExposeEventSendEvent: val
!

"_________________________________________________________"
"display primitive accessors"
primXNoExposeEventDisplay
    <cCall: 'X11_XNoExposeEvent_display_get' plugin: 'x11'>
    self primitiveFailed
!
primXNoExposeEventDisplay: val
    <cCall: 'X11_XNoExposeEvent_display_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"display accessors"
display
    ^self primXNoExposeEventDisplay
!
display: val
    ^self primXNoExposeEventDisplay: val
!

"_________________________________________________________"
"drawable primitive accessors"
primXNoExposeEventDrawable
    <cCall: 'X11_XNoExposeEvent_drawable_get' plugin: 'x11'>
    self primitiveFailed
!
primXNoExposeEventDrawable: val
    <cCall: 'X11_XNoExposeEvent_drawable_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"drawable accessors"
drawable
    ^self primXNoExposeEventDrawable
!
drawable: val
    ^self primXNoExposeEventDrawable: val
!

"_________________________________________________________"
"major_code primitive accessors"
primXNoExposeEventMajorCode
    <cCall: 'X11_XNoExposeEvent_major_code_get' plugin: 'x11'>
    self primitiveFailed
!
primXNoExposeEventMajorCode: val
    <cCall: 'X11_XNoExposeEvent_major_code_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"major_code accessors"
majorcode
    ^self primXNoExposeEventMajorCode
!
majorcode: val
    ^self primXNoExposeEventMajorCode: val
!

"_________________________________________________________"
"minor_code primitive accessors"
primXNoExposeEventMinorCode
    <cCall: 'X11_XNoExposeEvent_minor_code_get' plugin: 'x11'>
    self primitiveFailed
!
primXNoExposeEventMinorCode: val
    <cCall: 'X11_XNoExposeEvent_minor_code_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"minor_code accessors"
minorcode
    ^self primXNoExposeEventMinorCode
!
minorcode: val
    ^self primXNoExposeEventMinorCode: val
!






primX11XNoExposeEventDelete
    <cCall: 'X11_delete_XNoExposeEvent' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XNoExposeEventDelete.
!


name
    ^'X11XNoExposeEvent'

! !

!X11XNoExposeEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XNoExposeEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XEvent class methodsFor: 'initialize-release'!

primX11XEventCreate
    <cCall: 'X11_new_XEvent' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XEventCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XEvent  methodsFor: 'X11'!

"_________________________________________________________"
"type primitive accessors"
primXEventType
    <cCall: 'X11_XEvent_type_get' plugin: 'x11'>
    self primitiveFailed
!
primXEventType: val
    <cCall: 'X11_XEvent_type_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"type accessors"
type
    ^self primXEventType
!
type: val
    ^self primXEventType: val
!

"_________________________________________________________"
"xany primitive accessors"
primXEventXany
    <cCall: 'X11_XEvent_xany_get' plugin: 'x11'>
    self primitiveFailed
!
primXEventXany: val
    <cCall: 'X11_XEvent_xany_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"xany accessors"
xany
    ^self primXEventXany
!
xany: val
    ^self primXEventXany: val
!

"_________________________________________________________"
"xkey primitive accessors"
primXEventXkey
    <cCall: 'X11_XEvent_xkey_get' plugin: 'x11'>
    self primitiveFailed
!
primXEventXkey: val
    <cCall: 'X11_XEvent_xkey_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"xkey accessors"
xkey
    ^self primXEventXkey
!
xkey: val
    ^self primXEventXkey: val
!

"_________________________________________________________"
"xbutton primitive accessors"
primXEventXbutton
    <cCall: 'X11_XEvent_xbutton_get' plugin: 'x11'>
    self primitiveFailed
!
primXEventXbutton: val
    <cCall: 'X11_XEvent_xbutton_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"xbutton accessors"
xbutton
    ^self primXEventXbutton
!
xbutton: val
    ^self primXEventXbutton: val
!

"_________________________________________________________"
"xmotion primitive accessors"
primXEventXmotion
    <cCall: 'X11_XEvent_xmotion_get' plugin: 'x11'>
    self primitiveFailed
!
primXEventXmotion: val
    <cCall: 'X11_XEvent_xmotion_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"xmotion accessors"
xmotion
    ^self primXEventXmotion
!
xmotion: val
    ^self primXEventXmotion: val
!

"_________________________________________________________"
"xcrossing primitive accessors"
primXEventXcrossing
    <cCall: 'X11_XEvent_xcrossing_get' plugin: 'x11'>
    self primitiveFailed
!
primXEventXcrossing: val
    <cCall: 'X11_XEvent_xcrossing_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"xcrossing accessors"
xcrossing
    ^self primXEventXcrossing
!
xcrossing: val
    ^self primXEventXcrossing: val
!

"_________________________________________________________"
"xfocus primitive accessors"
primXEventXfocus
    <cCall: 'X11_XEvent_xfocus_get' plugin: 'x11'>
    self primitiveFailed
!
primXEventXfocus: val
    <cCall: 'X11_XEvent_xfocus_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"xfocus accessors"
xfocus
    ^self primXEventXfocus
!
xfocus: val
    ^self primXEventXfocus: val
!

"_________________________________________________________"
"xexpose primitive accessors"
primXEventXexpose
    <cCall: 'X11_XEvent_xexpose_get' plugin: 'x11'>
    self primitiveFailed
!
primXEventXexpose: val
    <cCall: 'X11_XEvent_xexpose_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"xexpose accessors"
xexpose
    ^self primXEventXexpose
!
xexpose: val
    ^self primXEventXexpose: val
!

"_________________________________________________________"
"xgraphicsexpose primitive accessors"
primXEventXgraphicsexpose
    <cCall: 'X11_XEvent_xgraphicsexpose_get' plugin: 'x11'>
    self primitiveFailed
!
primXEventXgraphicsexpose: val
    <cCall: 'X11_XEvent_xgraphicsexpose_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"xgraphicsexpose accessors"
xgraphicsexpose
    ^self primXEventXgraphicsexpose
!
xgraphicsexpose: val
    ^self primXEventXgraphicsexpose: val
!

"_________________________________________________________"
"xnoexpose primitive accessors"
primXEventXnoexpose
    <cCall: 'X11_XEvent_xnoexpose_get' plugin: 'x11'>
    self primitiveFailed
!
primXEventXnoexpose: val
    <cCall: 'X11_XEvent_xnoexpose_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"xnoexpose accessors"
xnoexpose
    ^self primXEventXnoexpose
!
xnoexpose: val
    ^self primXEventXnoexpose: val
!

"_________________________________________________________"
"xvisibility primitive accessors"
primXEventXvisibility
    <cCall: 'X11_XEvent_xvisibility_get' plugin: 'x11'>
    self primitiveFailed
!
primXEventXvisibility: val
    <cCall: 'X11_XEvent_xvisibility_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"xvisibility accessors"
xvisibility
    ^self primXEventXvisibility
!
xvisibility: val
    ^self primXEventXvisibility: val
!

"_________________________________________________________"
"xcreatewindow primitive accessors"
primXEventXcreatewindow
    <cCall: 'X11_XEvent_xcreatewindow_get' plugin: 'x11'>
    self primitiveFailed
!
primXEventXcreatewindow: val
    <cCall: 'X11_XEvent_xcreatewindow_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"xcreatewindow accessors"
xcreatewindow
    ^self primXEventXcreatewindow
!
xcreatewindow: val
    ^self primXEventXcreatewindow: val
!

"_________________________________________________________"
"xdestroywindow primitive accessors"
primXEventXdestroywindow
    <cCall: 'X11_XEvent_xdestroywindow_get' plugin: 'x11'>
    self primitiveFailed
!
primXEventXdestroywindow: val
    <cCall: 'X11_XEvent_xdestroywindow_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"xdestroywindow accessors"
xdestroywindow
    ^self primXEventXdestroywindow
!
xdestroywindow: val
    ^self primXEventXdestroywindow: val
!

"_________________________________________________________"
"xunmap primitive accessors"
primXEventXunmap
    <cCall: 'X11_XEvent_xunmap_get' plugin: 'x11'>
    self primitiveFailed
!
primXEventXunmap: val
    <cCall: 'X11_XEvent_xunmap_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"xunmap accessors"
xunmap
    ^self primXEventXunmap
!
xunmap: val
    ^self primXEventXunmap: val
!

"_________________________________________________________"
"xmap primitive accessors"
primXEventXmap
    <cCall: 'X11_XEvent_xmap_get' plugin: 'x11'>
    self primitiveFailed
!
primXEventXmap: val
    <cCall: 'X11_XEvent_xmap_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"xmap accessors"
xmap
    ^self primXEventXmap
!
xmap: val
    ^self primXEventXmap: val
!

"_________________________________________________________"
"xmaprequest primitive accessors"
primXEventXmaprequest
    <cCall: 'X11_XEvent_xmaprequest_get' plugin: 'x11'>
    self primitiveFailed
!
primXEventXmaprequest: val
    <cCall: 'X11_XEvent_xmaprequest_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"xmaprequest accessors"
xmaprequest
    ^self primXEventXmaprequest
!
xmaprequest: val
    ^self primXEventXmaprequest: val
!

"_________________________________________________________"
"xreparent primitive accessors"
primXEventXreparent
    <cCall: 'X11_XEvent_xreparent_get' plugin: 'x11'>
    self primitiveFailed
!
primXEventXreparent: val
    <cCall: 'X11_XEvent_xreparent_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"xreparent accessors"
xreparent
    ^self primXEventXreparent
!
xreparent: val
    ^self primXEventXreparent: val
!

"_________________________________________________________"
"xconfigure primitive accessors"
primXEventXconfigure
    <cCall: 'X11_XEvent_xconfigure_get' plugin: 'x11'>
    self primitiveFailed
!
primXEventXconfigure: val
    <cCall: 'X11_XEvent_xconfigure_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"xconfigure accessors"
xconfigure
    ^self primXEventXconfigure
!
xconfigure: val
    ^self primXEventXconfigure: val
!

"_________________________________________________________"
"xgravity primitive accessors"
primXEventXgravity
    <cCall: 'X11_XEvent_xgravity_get' plugin: 'x11'>
    self primitiveFailed
!
primXEventXgravity: val
    <cCall: 'X11_XEvent_xgravity_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"xgravity accessors"
xgravity
    ^self primXEventXgravity
!
xgravity: val
    ^self primXEventXgravity: val
!

"_________________________________________________________"
"xresizerequest primitive accessors"
primXEventXresizerequest
    <cCall: 'X11_XEvent_xresizerequest_get' plugin: 'x11'>
    self primitiveFailed
!
primXEventXresizerequest: val
    <cCall: 'X11_XEvent_xresizerequest_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"xresizerequest accessors"
xresizerequest
    ^self primXEventXresizerequest
!
xresizerequest: val
    ^self primXEventXresizerequest: val
!

"_________________________________________________________"
"xconfigurerequest primitive accessors"
primXEventXconfigurerequest
    <cCall: 'X11_XEvent_xconfigurerequest_get' plugin: 'x11'>
    self primitiveFailed
!
primXEventXconfigurerequest: val
    <cCall: 'X11_XEvent_xconfigurerequest_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"xconfigurerequest accessors"
xconfigurerequest
    ^self primXEventXconfigurerequest
!
xconfigurerequest: val
    ^self primXEventXconfigurerequest: val
!

"_________________________________________________________"
"xcirculate primitive accessors"
primXEventXcirculate
    <cCall: 'X11_XEvent_xcirculate_get' plugin: 'x11'>
    self primitiveFailed
!
primXEventXcirculate: val
    <cCall: 'X11_XEvent_xcirculate_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"xcirculate accessors"
xcirculate
    ^self primXEventXcirculate
!
xcirculate: val
    ^self primXEventXcirculate: val
!

"_________________________________________________________"
"xcirculaterequest primitive accessors"
primXEventXcirculaterequest
    <cCall: 'X11_XEvent_xcirculaterequest_get' plugin: 'x11'>
    self primitiveFailed
!
primXEventXcirculaterequest: val
    <cCall: 'X11_XEvent_xcirculaterequest_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"xcirculaterequest accessors"
xcirculaterequest
    ^self primXEventXcirculaterequest
!
xcirculaterequest: val
    ^self primXEventXcirculaterequest: val
!

"_________________________________________________________"
"xproperty primitive accessors"
primXEventXproperty
    <cCall: 'X11_XEvent_xproperty_get' plugin: 'x11'>
    self primitiveFailed
!
primXEventXproperty: val
    <cCall: 'X11_XEvent_xproperty_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"xproperty accessors"
xproperty
    ^self primXEventXproperty
!
xproperty: val
    ^self primXEventXproperty: val
!

"_________________________________________________________"
"xselectionclear primitive accessors"
primXEventXselectionclear
    <cCall: 'X11_XEvent_xselectionclear_get' plugin: 'x11'>
    self primitiveFailed
!
primXEventXselectionclear: val
    <cCall: 'X11_XEvent_xselectionclear_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"xselectionclear accessors"
xselectionclear
    ^self primXEventXselectionclear
!
xselectionclear: val
    ^self primXEventXselectionclear: val
!

"_________________________________________________________"
"xselectionrequest primitive accessors"
primXEventXselectionrequest
    <cCall: 'X11_XEvent_xselectionrequest_get' plugin: 'x11'>
    self primitiveFailed
!
primXEventXselectionrequest: val
    <cCall: 'X11_XEvent_xselectionrequest_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"xselectionrequest accessors"
xselectionrequest
    ^self primXEventXselectionrequest
!
xselectionrequest: val
    ^self primXEventXselectionrequest: val
!

"_________________________________________________________"
"xselection primitive accessors"
primXEventXselection
    <cCall: 'X11_XEvent_xselection_get' plugin: 'x11'>
    self primitiveFailed
!
primXEventXselection: val
    <cCall: 'X11_XEvent_xselection_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"xselection accessors"
xselection
    ^self primXEventXselection
!
xselection: val
    ^self primXEventXselection: val
!

"_________________________________________________________"
"xcolormap primitive accessors"
primXEventXcolormap
    <cCall: 'X11_XEvent_xcolormap_get' plugin: 'x11'>
    self primitiveFailed
!
primXEventXcolormap: val
    <cCall: 'X11_XEvent_xcolormap_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"xcolormap accessors"
xcolormap
    ^self primXEventXcolormap
!
xcolormap: val
    ^self primXEventXcolormap: val
!

"_________________________________________________________"
"xclient primitive accessors"
primXEventXclient
    <cCall: 'X11_XEvent_xclient_get' plugin: 'x11'>
    self primitiveFailed
!
primXEventXclient: val
    <cCall: 'X11_XEvent_xclient_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"xclient accessors"
xclient
    ^self primXEventXclient
!
xclient: val
    ^self primXEventXclient: val
!

"_________________________________________________________"
"xmapping primitive accessors"
primXEventXmapping
    <cCall: 'X11_XEvent_xmapping_get' plugin: 'x11'>
    self primitiveFailed
!
primXEventXmapping: val
    <cCall: 'X11_XEvent_xmapping_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"xmapping accessors"
xmapping
    ^self primXEventXmapping
!
xmapping: val
    ^self primXEventXmapping: val
!

"_________________________________________________________"
"xerror primitive accessors"
primXEventXerror
    <cCall: 'X11_XEvent_xerror_get' plugin: 'x11'>
    self primitiveFailed
!
primXEventXerror: val
    <cCall: 'X11_XEvent_xerror_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"xerror accessors"
xerror
    ^self primXEventXerror
!
xerror: val
    ^self primXEventXerror: val
!

"_________________________________________________________"
"xkeymap primitive accessors"
primXEventXkeymap
    <cCall: 'X11_XEvent_xkeymap_get' plugin: 'x11'>
    self primitiveFailed
!
primXEventXkeymap: val
    <cCall: 'X11_XEvent_xkeymap_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"xkeymap accessors"
xkeymap
    ^self primXEventXkeymap
!
xkeymap: val
    ^self primXEventXkeymap: val
!

"_________________________________________________________"
"pad primitive accessors"
primXEventPad
    <cCall: 'X11_XEvent_pad_get' plugin: 'x11'>
    self primitiveFailed
!
primXEventPad: val
    <cCall: 'X11_XEvent_pad_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"pad accessors"
pad
    ^self primXEventPad
!
pad: val
    ^self primXEventPad: val
!



"_________________________________________________________"
"XFilterEvent primitive function"
primXFilterEvent: arg1
    <cCall: 'X11_XFilterEvent' plugin: 'x11'>
    self primitiveFailed
!




primX11XEventDelete
    <cCall: 'X11_delete_XEvent' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XEventDelete.
!


name
    ^'X11XEvent'

! !

!X11XEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XFontStruct
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XFontStruct class methodsFor: 'initialize-release'!

primX11XFontStructCreate
    <cCall: 'X11_new_XFontStruct' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XFontStructCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XFontStruct  methodsFor: 'X11'!

"_________________________________________________________"
"ext_data primitive accessors"
primXFontStructExtData
    <cCall: 'X11_XFontStruct_ext_data_get' plugin: 'x11'>
    self primitiveFailed
!
primXFontStructExtData: val
    <cCall: 'X11_XFontStruct_ext_data_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"ext_data accessors"
extdata
    ^self primXFontStructExtData
!
extdata: val
    ^self primXFontStructExtData: val
!

"_________________________________________________________"
"fid primitive accessors"
primXFontStructFid
    <cCall: 'X11_XFontStruct_fid_get' plugin: 'x11'>
    self primitiveFailed
!
primXFontStructFid: val
    <cCall: 'X11_XFontStruct_fid_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"fid accessors"
fid
    ^self primXFontStructFid
!
fid: val
    ^self primXFontStructFid: val
!

"_________________________________________________________"
"direction primitive accessors"
primXFontStructDirection
    <cCall: 'X11_XFontStruct_direction_get' plugin: 'x11'>
    self primitiveFailed
!
primXFontStructDirection: val
    <cCall: 'X11_XFontStruct_direction_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"direction accessors"
direction
    ^self primXFontStructDirection
!
direction: val
    ^self primXFontStructDirection: val
!

"_________________________________________________________"
"min_char_or_byte2 primitive accessors"
primXFontStructMinCharOrByte2
    <cCall: 'X11_XFontStruct_min_char_or_byte2_get' plugin: 'x11'>
    self primitiveFailed
!
primXFontStructMinCharOrByte2: val
    <cCall: 'X11_XFontStruct_min_char_or_byte2_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"min_char_or_byte2 accessors"
mincharorbyte2
    ^self primXFontStructMinCharOrByte2
!
mincharorbyte2: val
    ^self primXFontStructMinCharOrByte2: val
!

"_________________________________________________________"
"max_char_or_byte2 primitive accessors"
primXFontStructMaxCharOrByte2
    <cCall: 'X11_XFontStruct_max_char_or_byte2_get' plugin: 'x11'>
    self primitiveFailed
!
primXFontStructMaxCharOrByte2: val
    <cCall: 'X11_XFontStruct_max_char_or_byte2_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"max_char_or_byte2 accessors"
maxcharorbyte2
    ^self primXFontStructMaxCharOrByte2
!
maxcharorbyte2: val
    ^self primXFontStructMaxCharOrByte2: val
!

"_________________________________________________________"
"min_byte1 primitive accessors"
primXFontStructMinByte1
    <cCall: 'X11_XFontStruct_min_byte1_get' plugin: 'x11'>
    self primitiveFailed
!
primXFontStructMinByte1: val
    <cCall: 'X11_XFontStruct_min_byte1_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"min_byte1 accessors"
minbyte1
    ^self primXFontStructMinByte1
!
minbyte1: val
    ^self primXFontStructMinByte1: val
!

"_________________________________________________________"
"max_byte1 primitive accessors"
primXFontStructMaxByte1
    <cCall: 'X11_XFontStruct_max_byte1_get' plugin: 'x11'>
    self primitiveFailed
!
primXFontStructMaxByte1: val
    <cCall: 'X11_XFontStruct_max_byte1_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"max_byte1 accessors"
maxbyte1
    ^self primXFontStructMaxByte1
!
maxbyte1: val
    ^self primXFontStructMaxByte1: val
!

"_________________________________________________________"
"all_chars_exist primitive accessors"
primXFontStructAllCharsExist
    <cCall: 'X11_XFontStruct_all_chars_exist_get' plugin: 'x11'>
    self primitiveFailed
!
primXFontStructAllCharsExist: val
    <cCall: 'X11_XFontStruct_all_chars_exist_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"all_chars_exist accessors"
allcharsexist
    ^self primXFontStructAllCharsExist
!
allcharsexist: val
    ^self primXFontStructAllCharsExist: val
!

"_________________________________________________________"
"default_char primitive accessors"
primXFontStructDefaultChar
    <cCall: 'X11_XFontStruct_default_char_get' plugin: 'x11'>
    self primitiveFailed
!
primXFontStructDefaultChar: val
    <cCall: 'X11_XFontStruct_default_char_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"default_char accessors"
defaultchar
    ^self primXFontStructDefaultChar
!
defaultchar: val
    ^self primXFontStructDefaultChar: val
!

"_________________________________________________________"
"n_properties primitive accessors"
primXFontStructNProperties
    <cCall: 'X11_XFontStruct_n_properties_get' plugin: 'x11'>
    self primitiveFailed
!
primXFontStructNProperties: val
    <cCall: 'X11_XFontStruct_n_properties_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"n_properties accessors"
nproperties
    ^self primXFontStructNProperties
!
nproperties: val
    ^self primXFontStructNProperties: val
!

"_________________________________________________________"
"properties primitive accessors"
primXFontStructProperties
    <cCall: 'X11_XFontStruct_properties_get' plugin: 'x11'>
    self primitiveFailed
!
primXFontStructProperties: val
    <cCall: 'X11_XFontStruct_properties_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"properties accessors"
properties
    ^self primXFontStructProperties
!
properties: val
    ^self primXFontStructProperties: val
!

"_________________________________________________________"
"min_bounds primitive accessors"
primXFontStructMinBounds
    <cCall: 'X11_XFontStruct_min_bounds_get' plugin: 'x11'>
    self primitiveFailed
!
primXFontStructMinBounds: val
    <cCall: 'X11_XFontStruct_min_bounds_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"min_bounds accessors"
minbounds
    ^self primXFontStructMinBounds
!
minbounds: val
    ^self primXFontStructMinBounds: val
!

"_________________________________________________________"
"max_bounds primitive accessors"
primXFontStructMaxBounds
    <cCall: 'X11_XFontStruct_max_bounds_get' plugin: 'x11'>
    self primitiveFailed
!
primXFontStructMaxBounds: val
    <cCall: 'X11_XFontStruct_max_bounds_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"max_bounds accessors"
maxbounds
    ^self primXFontStructMaxBounds
!
maxbounds: val
    ^self primXFontStructMaxBounds: val
!

"_________________________________________________________"
"per_char primitive accessors"
primXFontStructPerChar
    <cCall: 'X11_XFontStruct_per_char_get' plugin: 'x11'>
    self primitiveFailed
!
primXFontStructPerChar: val
    <cCall: 'X11_XFontStruct_per_char_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"per_char accessors"
perchar
    ^self primXFontStructPerChar
!
perchar: val
    ^self primXFontStructPerChar: val
!

"_________________________________________________________"
"ascent primitive accessors"
primXFontStructAscent
    <cCall: 'X11_XFontStruct_ascent_get' plugin: 'x11'>
    self primitiveFailed
!
primXFontStructAscent: val
    <cCall: 'X11_XFontStruct_ascent_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"ascent accessors"
ascent
    ^self primXFontStructAscent
!
ascent: val
    ^self primXFontStructAscent: val
!

"_________________________________________________________"
"descent primitive accessors"
primXFontStructDescent
    <cCall: 'X11_XFontStruct_descent_get' plugin: 'x11'>
    self primitiveFailed
!
primXFontStructDescent: val
    <cCall: 'X11_XFontStruct_descent_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"descent accessors"
descent
    ^self primXFontStructDescent
!
descent: val
    ^self primXFontStructDescent: val
!



"_________________________________________________________"
"XGetFontProperty primitive function"
primXGetFontProperty: arg1 valueReturn: arg4
    <cCall: 'X11_XGetFontProperty' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XTextExtents primitive function"
primXTextExtents: arg1 nchars: arg4 directionReturn: arg5 fontAscentReturn: arg6 fontDescentReturn: arg7 overallReturn: arg8
    <cCall: 'X11_XTextExtents' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XTextExtents16 primitive function"
primXTextExtents16: arg1 nchars: arg4 directionReturn: arg5 fontAscentReturn: arg6 fontDescentReturn: arg7 overallReturn: arg8
    <cCall: 'X11_XTextExtents16' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XTextWidth primitive function"
primXTextWidth: arg1 count: arg4
    <cCall: 'X11_XTextWidth' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XTextWidth16 primitive function"
primXTextWidth16: arg1 count: arg4
    <cCall: 'X11_XTextWidth16' plugin: 'x11'>
    self primitiveFailed
!




primX11XFontStructDelete
    <cCall: 'X11_delete_XFontStruct' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XFontStructDelete.
!


name
    ^'X11XFontStruct'

! !

!X11XFontStruct methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XFontStruct methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XKeyboardControl
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XKeyboardControl class methodsFor: 'initialize-release'!

primX11XKeyboardControlCreate
    <cCall: 'X11_new_XKeyboardControl' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XKeyboardControlCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XKeyboardControl  methodsFor: 'X11'!

"_________________________________________________________"
"key_click_percent primitive accessors"
primXKeyboardControlKeyClickPercent
    <cCall: 'X11_XKeyboardControl_key_click_percent_get' plugin: 'x11'>
    self primitiveFailed
!
primXKeyboardControlKeyClickPercent: val
    <cCall: 'X11_XKeyboardControl_key_click_percent_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"key_click_percent accessors"
keyclickpercent
    ^self primXKeyboardControlKeyClickPercent
!
keyclickpercent: val
    ^self primXKeyboardControlKeyClickPercent: val
!

"_________________________________________________________"
"bell_percent primitive accessors"
primXKeyboardControlBellPercent
    <cCall: 'X11_XKeyboardControl_bell_percent_get' plugin: 'x11'>
    self primitiveFailed
!
primXKeyboardControlBellPercent: val
    <cCall: 'X11_XKeyboardControl_bell_percent_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"bell_percent accessors"
bellpercent
    ^self primXKeyboardControlBellPercent
!
bellpercent: val
    ^self primXKeyboardControlBellPercent: val
!

"_________________________________________________________"
"bell_pitch primitive accessors"
primXKeyboardControlBellPitch
    <cCall: 'X11_XKeyboardControl_bell_pitch_get' plugin: 'x11'>
    self primitiveFailed
!
primXKeyboardControlBellPitch: val
    <cCall: 'X11_XKeyboardControl_bell_pitch_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"bell_pitch accessors"
bellpitch
    ^self primXKeyboardControlBellPitch
!
bellpitch: val
    ^self primXKeyboardControlBellPitch: val
!

"_________________________________________________________"
"bell_duration primitive accessors"
primXKeyboardControlBellDuration
    <cCall: 'X11_XKeyboardControl_bell_duration_get' plugin: 'x11'>
    self primitiveFailed
!
primXKeyboardControlBellDuration: val
    <cCall: 'X11_XKeyboardControl_bell_duration_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"bell_duration accessors"
bellduration
    ^self primXKeyboardControlBellDuration
!
bellduration: val
    ^self primXKeyboardControlBellDuration: val
!

"_________________________________________________________"
"led primitive accessors"
primXKeyboardControlLed
    <cCall: 'X11_XKeyboardControl_led_get' plugin: 'x11'>
    self primitiveFailed
!
primXKeyboardControlLed: val
    <cCall: 'X11_XKeyboardControl_led_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"led accessors"
led
    ^self primXKeyboardControlLed
!
led: val
    ^self primXKeyboardControlLed: val
!

"_________________________________________________________"
"led_mode primitive accessors"
primXKeyboardControlLedMode
    <cCall: 'X11_XKeyboardControl_led_mode_get' plugin: 'x11'>
    self primitiveFailed
!
primXKeyboardControlLedMode: val
    <cCall: 'X11_XKeyboardControl_led_mode_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"led_mode accessors"
ledmode
    ^self primXKeyboardControlLedMode
!
ledmode: val
    ^self primXKeyboardControlLedMode: val
!

"_________________________________________________________"
"key primitive accessors"
primXKeyboardControlKey
    <cCall: 'X11_XKeyboardControl_key_get' plugin: 'x11'>
    self primitiveFailed
!
primXKeyboardControlKey: val
    <cCall: 'X11_XKeyboardControl_key_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"key accessors"
key
    ^self primXKeyboardControlKey
!
key: val
    ^self primXKeyboardControlKey: val
!

"_________________________________________________________"
"auto_repeat_mode primitive accessors"
primXKeyboardControlAutoRepeatMode
    <cCall: 'X11_XKeyboardControl_auto_repeat_mode_get' plugin: 'x11'>
    self primitiveFailed
!
primXKeyboardControlAutoRepeatMode: val
    <cCall: 'X11_XKeyboardControl_auto_repeat_mode_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"auto_repeat_mode accessors"
autorepeatmode
    ^self primXKeyboardControlAutoRepeatMode
!
autorepeatmode: val
    ^self primXKeyboardControlAutoRepeatMode: val
!






primX11XKeyboardControlDelete
    <cCall: 'X11_delete_XKeyboardControl' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XKeyboardControlDelete.
!


name
    ^'X11XKeyboardControl'

! !

!X11XKeyboardControl methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XKeyboardControl methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XIM
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XIM class methodsFor: 'initialize-release'!

primX11XIMCreate
    <cCall: 'X11_new_XIM' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XIMCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XIM  methodsFor: 'X11'!



"_________________________________________________________"
"XCloseIM primitive function"
primXCloseIM
    <cCall: 'X11_XCloseIM' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XGetIMValues primitive function"
primXGetIMValues
    <cCall: 'X11_XGetIMValues' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XSetIMValues primitive function"
primXSetIMValues
    <cCall: 'X11_XSetIMValues' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XDisplayOfIM primitive function"
primXDisplayOfIM
    <cCall: 'X11_XDisplayOfIM' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XLocaleOfIM primitive function"
primXLocaleOfIM
    <cCall: 'X11_XLocaleOfIM' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XCreateIC primitive function"
primXCreateIC
    <cCall: 'X11_XCreateIC' plugin: 'x11'>
    self primitiveFailed
!




primX11XIMDelete
    <cCall: 'X11_delete_XIM' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XIMDelete.
!


name
    ^'X11XIM'

! !

!X11XIM methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XIM methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XFontSet
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XFontSet class methodsFor: 'initialize-release'!

primX11XFontSetCreate
    <cCall: 'X11_new_XFontSet' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XFontSetCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XFontSet  methodsFor: 'X11'!



"_________________________________________________________"
"XFontsOfFontSet primitive function"
primXFontsOfFontSet: arg1 fontNameList: arg4
    <cCall: 'X11_XFontsOfFontSet' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XBaseFontNameListOfFontSet primitive function"
primXBaseFontNameListOfFontSet
    <cCall: 'X11_XBaseFontNameListOfFontSet' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XLocaleOfFontSet primitive function"
primXLocaleOfFontSet
    <cCall: 'X11_XLocaleOfFontSet' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XContextDependentDrawing primitive function"
primXContextDependentDrawing
    <cCall: 'X11_XContextDependentDrawing' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XDirectionalDependentDrawing primitive function"
primXDirectionalDependentDrawing
    <cCall: 'X11_XDirectionalDependentDrawing' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XContextualDrawing primitive function"
primXContextualDrawing
    <cCall: 'X11_XContextualDrawing' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XExtentsOfFontSet primitive function"
primXExtentsOfFontSet
    <cCall: 'X11_XExtentsOfFontSet' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XmbTextEscapement primitive function"
primXmbTextEscapement: arg1 bytesText: arg4
    <cCall: 'X11_XmbTextEscapement' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XwcTextEscapement primitive function"
primXwcTextEscapement: arg1 numWchars: arg4
    <cCall: 'X11_XwcTextEscapement' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XmbTextExtents primitive function"
primXmbTextExtents: arg1 bytesText: arg4 overallInkReturn: arg5 overallLogicalReturn: arg6
    <cCall: 'X11_XmbTextExtents' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XwcTextExtents primitive function"
primXwcTextExtents: arg1 numWchars: arg4 overallInkReturn: arg5 overallLogicalReturn: arg6
    <cCall: 'X11_XwcTextExtents' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XmbTextPerCharExtents primitive function"
primXmbTextPerCharExtents: arg1 bytesText: arg4 inkExtentsBuffer: arg5 logicalExtentsBuffer: arg6 bufferSize: arg7 numChars: arg8 overallInkReturn: arg9 overallLogicalReturn: arg10
    <cCall: 'X11_XmbTextPerCharExtents' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XwcTextPerCharExtents primitive function"
primXwcTextPerCharExtents: arg1 numWchars: arg4 inkExtentsBuffer: arg5 logicalExtentsBuffer: arg6 bufferSize: arg7 numChars: arg8 overallInkReturn: arg9 overallLogicalReturn: arg10
    <cCall: 'X11_XwcTextPerCharExtents' plugin: 'x11'>
    self primitiveFailed
!




primX11XFontSetDelete
    <cCall: 'X11_delete_XFontSet' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XFontSetDelete.
!


name
    ^'X11XFontSet'

! !

!X11XFontSet methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XFontSet methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XIMTextString
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XIMTextString class methodsFor: 'initialize-release'!

primX11XIMTextStringCreate
    <cCall: 'X11_new_XIMText_string' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XIMTextStringCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XIMTextString  methodsFor: 'X11'!

"_________________________________________________________"
"multi_byte primitive accessors"
primXIMTextStringMultiByte
    <cCall: 'X11_XIMText_string_multi_byte_get' plugin: 'x11'>
    self primitiveFailed
!
primXIMTextStringMultiByte: val
    <cCall: 'X11_XIMText_string_multi_byte_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"multi_byte accessors"
multibyte
    ^self primXIMTextStringMultiByte
!
multibyte: val
    ^self primXIMTextStringMultiByte: val
!

"_________________________________________________________"
"wide_char primitive accessors"
primXIMTextStringWideChar
    <cCall: 'X11_XIMText_string_wide_char_get' plugin: 'x11'>
    self primitiveFailed
!
primXIMTextStringWideChar: val
    <cCall: 'X11_XIMText_string_wide_char_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"wide_char accessors"
widechar
    ^self primXIMTextStringWideChar
!
widechar: val
    ^self primXIMTextStringWideChar: val
!






primX11XIMTextStringDelete
    <cCall: 'X11_delete_XIMText_string' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XIMTextStringDelete.
!


name
    ^'X11XIMTextString'

! !

!X11XIMTextString methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XIMTextString methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XImageF
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XImageF class methodsFor: 'initialize-release'!

primX11XImageFCreate
    <cCall: 'X11_new_XImage_f' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XImageFCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XImageF  methodsFor: 'X11'!

"_________________________________________________________"
"create_image primitive accessors"
primXImageFCreateImage
    <cCall: 'X11_XImage_f_create_image_get' plugin: 'x11'>
    self primitiveFailed
!
primXImageFCreateImage: val
    <cCall: 'X11_XImage_f_create_image_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"create_image accessors"
createimage
    ^self primXImageFCreateImage
!
createimage: val
    ^self primXImageFCreateImage: val
!

"_________________________________________________________"
"destroy_image primitive accessors"
primXImageFDestroyImage
    <cCall: 'X11_XImage_f_destroy_image_get' plugin: 'x11'>
    self primitiveFailed
!
primXImageFDestroyImage: val
    <cCall: 'X11_XImage_f_destroy_image_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"destroy_image accessors"
destroyimage
    ^self primXImageFDestroyImage
!
destroyimage: val
    ^self primXImageFDestroyImage: val
!

"_________________________________________________________"
"get_pixel primitive accessors"
primXImageFGetPixel
    <cCall: 'X11_XImage_f_get_pixel_get' plugin: 'x11'>
    self primitiveFailed
!
primXImageFGetPixel: val
    <cCall: 'X11_XImage_f_get_pixel_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"get_pixel accessors"
getpixel
    ^self primXImageFGetPixel
!
getpixel: val
    ^self primXImageFGetPixel: val
!

"_________________________________________________________"
"put_pixel primitive accessors"
primXImageFPutPixel
    <cCall: 'X11_XImage_f_put_pixel_get' plugin: 'x11'>
    self primitiveFailed
!
primXImageFPutPixel: val
    <cCall: 'X11_XImage_f_put_pixel_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"put_pixel accessors"
putpixel
    ^self primXImageFPutPixel
!
putpixel: val
    ^self primXImageFPutPixel: val
!

"_________________________________________________________"
"sub_image primitive accessors"
primXImageFSubImage
    <cCall: 'X11_XImage_f_sub_image_get' plugin: 'x11'>
    self primitiveFailed
!
primXImageFSubImage: val
    <cCall: 'X11_XImage_f_sub_image_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"sub_image accessors"
subimage
    ^self primXImageFSubImage
!
subimage: val
    ^self primXImageFSubImage: val
!

"_________________________________________________________"
"add_pixel primitive accessors"
primXImageFAddPixel
    <cCall: 'X11_XImage_f_add_pixel_get' plugin: 'x11'>
    self primitiveFailed
!
primXImageFAddPixel: val
    <cCall: 'X11_XImage_f_add_pixel_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"add_pixel accessors"
addpixel
    ^self primXImageFAddPixel
!
addpixel: val
    ^self primXImageFAddPixel: val
!






primX11XImageFDelete
    <cCall: 'X11_delete_XImage_f' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XImageFDelete.
!


name
    ^'X11XImageF'

! !

!X11XImageF methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XImageF methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XVisibilityEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XVisibilityEvent class methodsFor: 'initialize-release'!

primX11XVisibilityEventCreate
    <cCall: 'X11_new_XVisibilityEvent' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XVisibilityEventCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XVisibilityEvent  methodsFor: 'X11'!

"_________________________________________________________"
"type primitive accessors"
primXVisibilityEventType
    <cCall: 'X11_XVisibilityEvent_type_get' plugin: 'x11'>
    self primitiveFailed
!
primXVisibilityEventType: val
    <cCall: 'X11_XVisibilityEvent_type_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"type accessors"
type
    ^self primXVisibilityEventType
!
type: val
    ^self primXVisibilityEventType: val
!

"_________________________________________________________"
"serial primitive accessors"
primXVisibilityEventSerial
    <cCall: 'X11_XVisibilityEvent_serial_get' plugin: 'x11'>
    self primitiveFailed
!
primXVisibilityEventSerial: val
    <cCall: 'X11_XVisibilityEvent_serial_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"serial accessors"
serial
    ^self primXVisibilityEventSerial
!
serial: val
    ^self primXVisibilityEventSerial: val
!

"_________________________________________________________"
"send_event primitive accessors"
primXVisibilityEventSendEvent
    <cCall: 'X11_XVisibilityEvent_send_event_get' plugin: 'x11'>
    self primitiveFailed
!
primXVisibilityEventSendEvent: val
    <cCall: 'X11_XVisibilityEvent_send_event_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"send_event accessors"
sendevent
    ^self primXVisibilityEventSendEvent
!
sendevent: val
    ^self primXVisibilityEventSendEvent: val
!

"_________________________________________________________"
"display primitive accessors"
primXVisibilityEventDisplay
    <cCall: 'X11_XVisibilityEvent_display_get' plugin: 'x11'>
    self primitiveFailed
!
primXVisibilityEventDisplay: val
    <cCall: 'X11_XVisibilityEvent_display_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"display accessors"
display
    ^self primXVisibilityEventDisplay
!
display: val
    ^self primXVisibilityEventDisplay: val
!

"_________________________________________________________"
"window primitive accessors"
primXVisibilityEventWindow
    <cCall: 'X11_XVisibilityEvent_window_get' plugin: 'x11'>
    self primitiveFailed
!
primXVisibilityEventWindow: val
    <cCall: 'X11_XVisibilityEvent_window_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"window accessors"
window
    ^self primXVisibilityEventWindow
!
window: val
    ^self primXVisibilityEventWindow: val
!

"_________________________________________________________"
"state primitive accessors"
primXVisibilityEventState
    <cCall: 'X11_XVisibilityEvent_state_get' plugin: 'x11'>
    self primitiveFailed
!
primXVisibilityEventState: val
    <cCall: 'X11_XVisibilityEvent_state_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"state accessors"
state
    ^self primXVisibilityEventState
!
state: val
    ^self primXVisibilityEventState: val
!






primX11XVisibilityEventDelete
    <cCall: 'X11_delete_XVisibilityEvent' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XVisibilityEventDelete.
!


name
    ^'X11XVisibilityEvent'

! !

!X11XVisibilityEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XVisibilityEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XSelectionRequestEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XSelectionRequestEvent class methodsFor: 'initialize-release'!

primX11XSelectionRequestEventCreate
    <cCall: 'X11_new_XSelectionRequestEvent' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XSelectionRequestEventCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XSelectionRequestEvent  methodsFor: 'X11'!

"_________________________________________________________"
"type primitive accessors"
primXSelectionRequestEventType
    <cCall: 'X11_XSelectionRequestEvent_type_get' plugin: 'x11'>
    self primitiveFailed
!
primXSelectionRequestEventType: val
    <cCall: 'X11_XSelectionRequestEvent_type_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"type accessors"
type
    ^self primXSelectionRequestEventType
!
type: val
    ^self primXSelectionRequestEventType: val
!

"_________________________________________________________"
"serial primitive accessors"
primXSelectionRequestEventSerial
    <cCall: 'X11_XSelectionRequestEvent_serial_get' plugin: 'x11'>
    self primitiveFailed
!
primXSelectionRequestEventSerial: val
    <cCall: 'X11_XSelectionRequestEvent_serial_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"serial accessors"
serial
    ^self primXSelectionRequestEventSerial
!
serial: val
    ^self primXSelectionRequestEventSerial: val
!

"_________________________________________________________"
"send_event primitive accessors"
primXSelectionRequestEventSendEvent
    <cCall: 'X11_XSelectionRequestEvent_send_event_get' plugin: 'x11'>
    self primitiveFailed
!
primXSelectionRequestEventSendEvent: val
    <cCall: 'X11_XSelectionRequestEvent_send_event_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"send_event accessors"
sendevent
    ^self primXSelectionRequestEventSendEvent
!
sendevent: val
    ^self primXSelectionRequestEventSendEvent: val
!

"_________________________________________________________"
"display primitive accessors"
primXSelectionRequestEventDisplay
    <cCall: 'X11_XSelectionRequestEvent_display_get' plugin: 'x11'>
    self primitiveFailed
!
primXSelectionRequestEventDisplay: val
    <cCall: 'X11_XSelectionRequestEvent_display_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"display accessors"
display
    ^self primXSelectionRequestEventDisplay
!
display: val
    ^self primXSelectionRequestEventDisplay: val
!

"_________________________________________________________"
"owner primitive accessors"
primXSelectionRequestEventOwner
    <cCall: 'X11_XSelectionRequestEvent_owner_get' plugin: 'x11'>
    self primitiveFailed
!
primXSelectionRequestEventOwner: val
    <cCall: 'X11_XSelectionRequestEvent_owner_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"owner accessors"
owner
    ^self primXSelectionRequestEventOwner
!
owner: val
    ^self primXSelectionRequestEventOwner: val
!

"_________________________________________________________"
"requestor primitive accessors"
primXSelectionRequestEventRequestor
    <cCall: 'X11_XSelectionRequestEvent_requestor_get' plugin: 'x11'>
    self primitiveFailed
!
primXSelectionRequestEventRequestor: val
    <cCall: 'X11_XSelectionRequestEvent_requestor_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"requestor accessors"
requestor
    ^self primXSelectionRequestEventRequestor
!
requestor: val
    ^self primXSelectionRequestEventRequestor: val
!

"_________________________________________________________"
"selection primitive accessors"
primXSelectionRequestEventSelection
    <cCall: 'X11_XSelectionRequestEvent_selection_get' plugin: 'x11'>
    self primitiveFailed
!
primXSelectionRequestEventSelection: val
    <cCall: 'X11_XSelectionRequestEvent_selection_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"selection accessors"
selection
    ^self primXSelectionRequestEventSelection
!
selection: val
    ^self primXSelectionRequestEventSelection: val
!

"_________________________________________________________"
"target primitive accessors"
primXSelectionRequestEventTarget
    <cCall: 'X11_XSelectionRequestEvent_target_get' plugin: 'x11'>
    self primitiveFailed
!
primXSelectionRequestEventTarget: val
    <cCall: 'X11_XSelectionRequestEvent_target_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"target accessors"
target
    ^self primXSelectionRequestEventTarget
!
target: val
    ^self primXSelectionRequestEventTarget: val
!

"_________________________________________________________"
"property primitive accessors"
primXSelectionRequestEventProperty
    <cCall: 'X11_XSelectionRequestEvent_property_get' plugin: 'x11'>
    self primitiveFailed
!
primXSelectionRequestEventProperty: val
    <cCall: 'X11_XSelectionRequestEvent_property_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"property accessors"
property
    ^self primXSelectionRequestEventProperty
!
property: val
    ^self primXSelectionRequestEventProperty: val
!

"_________________________________________________________"
"time primitive accessors"
primXSelectionRequestEventTime
    <cCall: 'X11_XSelectionRequestEvent_time_get' plugin: 'x11'>
    self primitiveFailed
!
primXSelectionRequestEventTime: val
    <cCall: 'X11_XSelectionRequestEvent_time_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"time accessors"
time
    ^self primXSelectionRequestEventTime
!
time: val
    ^self primXSelectionRequestEventTime: val
!






primX11XSelectionRequestEventDelete
    <cCall: 'X11_delete_XSelectionRequestEvent' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XSelectionRequestEventDelete.
!


name
    ^'X11XSelectionRequestEvent'

! !

!X11XSelectionRequestEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XSelectionRequestEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XSelectionClearEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XSelectionClearEvent class methodsFor: 'initialize-release'!

primX11XSelectionClearEventCreate
    <cCall: 'X11_new_XSelectionClearEvent' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XSelectionClearEventCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XSelectionClearEvent  methodsFor: 'X11'!

"_________________________________________________________"
"type primitive accessors"
primXSelectionClearEventType
    <cCall: 'X11_XSelectionClearEvent_type_get' plugin: 'x11'>
    self primitiveFailed
!
primXSelectionClearEventType: val
    <cCall: 'X11_XSelectionClearEvent_type_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"type accessors"
type
    ^self primXSelectionClearEventType
!
type: val
    ^self primXSelectionClearEventType: val
!

"_________________________________________________________"
"serial primitive accessors"
primXSelectionClearEventSerial
    <cCall: 'X11_XSelectionClearEvent_serial_get' plugin: 'x11'>
    self primitiveFailed
!
primXSelectionClearEventSerial: val
    <cCall: 'X11_XSelectionClearEvent_serial_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"serial accessors"
serial
    ^self primXSelectionClearEventSerial
!
serial: val
    ^self primXSelectionClearEventSerial: val
!

"_________________________________________________________"
"send_event primitive accessors"
primXSelectionClearEventSendEvent
    <cCall: 'X11_XSelectionClearEvent_send_event_get' plugin: 'x11'>
    self primitiveFailed
!
primXSelectionClearEventSendEvent: val
    <cCall: 'X11_XSelectionClearEvent_send_event_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"send_event accessors"
sendevent
    ^self primXSelectionClearEventSendEvent
!
sendevent: val
    ^self primXSelectionClearEventSendEvent: val
!

"_________________________________________________________"
"display primitive accessors"
primXSelectionClearEventDisplay
    <cCall: 'X11_XSelectionClearEvent_display_get' plugin: 'x11'>
    self primitiveFailed
!
primXSelectionClearEventDisplay: val
    <cCall: 'X11_XSelectionClearEvent_display_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"display accessors"
display
    ^self primXSelectionClearEventDisplay
!
display: val
    ^self primXSelectionClearEventDisplay: val
!

"_________________________________________________________"
"window primitive accessors"
primXSelectionClearEventWindow
    <cCall: 'X11_XSelectionClearEvent_window_get' plugin: 'x11'>
    self primitiveFailed
!
primXSelectionClearEventWindow: val
    <cCall: 'X11_XSelectionClearEvent_window_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"window accessors"
window
    ^self primXSelectionClearEventWindow
!
window: val
    ^self primXSelectionClearEventWindow: val
!

"_________________________________________________________"
"selection primitive accessors"
primXSelectionClearEventSelection
    <cCall: 'X11_XSelectionClearEvent_selection_get' plugin: 'x11'>
    self primitiveFailed
!
primXSelectionClearEventSelection: val
    <cCall: 'X11_XSelectionClearEvent_selection_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"selection accessors"
selection
    ^self primXSelectionClearEventSelection
!
selection: val
    ^self primXSelectionClearEventSelection: val
!

"_________________________________________________________"
"time primitive accessors"
primXSelectionClearEventTime
    <cCall: 'X11_XSelectionClearEvent_time_get' plugin: 'x11'>
    self primitiveFailed
!
primXSelectionClearEventTime: val
    <cCall: 'X11_XSelectionClearEvent_time_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"time accessors"
time
    ^self primXSelectionClearEventTime
!
time: val
    ^self primXSelectionClearEventTime: val
!






primX11XSelectionClearEventDelete
    <cCall: 'X11_delete_XSelectionClearEvent' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XSelectionClearEventDelete.
!


name
    ^'X11XSelectionClearEvent'

! !

!X11XSelectionClearEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XSelectionClearEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XIMValuesList
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XIMValuesList class methodsFor: 'initialize-release'!

primX11XIMValuesListCreate
    <cCall: 'X11_new_XIMValuesList' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XIMValuesListCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XIMValuesList  methodsFor: 'X11'!

"_________________________________________________________"
"count_values primitive accessors"
primXIMValuesListCountValues
    <cCall: 'X11_XIMValuesList_count_values_get' plugin: 'x11'>
    self primitiveFailed
!
primXIMValuesListCountValues: val
    <cCall: 'X11_XIMValuesList_count_values_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"count_values accessors"
countvalues
    ^self primXIMValuesListCountValues
!
countvalues: val
    ^self primXIMValuesListCountValues: val
!

"_________________________________________________________"
"supported_values primitive accessors"
primXIMValuesListSupportedValues
    <cCall: 'X11_XIMValuesList_supported_values_get' plugin: 'x11'>
    self primitiveFailed
!
primXIMValuesListSupportedValues: val
    <cCall: 'X11_XIMValuesList_supported_values_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"supported_values accessors"
supportedvalues
    ^self primXIMValuesListSupportedValues
!
supportedvalues: val
    ^self primXIMValuesListSupportedValues: val
!






primX11XIMValuesListDelete
    <cCall: 'X11_delete_XIMValuesList' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XIMValuesListDelete.
!


name
    ^'X11XIMValuesList'

! !

!X11XIMValuesList methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XIMValuesList methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XIMText
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XIMText class methodsFor: 'initialize-release'!

primX11XIMTextCreate
    <cCall: 'X11_new_XIMText' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XIMTextCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XIMText  methodsFor: 'X11'!

"_________________________________________________________"
"length primitive accessors"
primXIMTextLength
    <cCall: 'X11_XIMText_length_get' plugin: 'x11'>
    self primitiveFailed
!
primXIMTextLength: val
    <cCall: 'X11_XIMText_length_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"length accessors"
length
    ^self primXIMTextLength
!
length: val
    ^self primXIMTextLength: val
!

"_________________________________________________________"
"feedback primitive accessors"
primXIMTextFeedback
    <cCall: 'X11_XIMText_feedback_get' plugin: 'x11'>
    self primitiveFailed
!
primXIMTextFeedback: val
    <cCall: 'X11_XIMText_feedback_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"feedback accessors"
feedback
    ^self primXIMTextFeedback
!
feedback: val
    ^self primXIMTextFeedback: val
!

"_________________________________________________________"
"encoding_is_wchar primitive accessors"
primXIMTextEncodingIsWchar
    <cCall: 'X11_XIMText_encoding_is_wchar_get' plugin: 'x11'>
    self primitiveFailed
!
primXIMTextEncodingIsWchar: val
    <cCall: 'X11_XIMText_encoding_is_wchar_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"encoding_is_wchar accessors"
encodingiswchar
    ^self primXIMTextEncodingIsWchar
!
encodingiswchar: val
    ^self primXIMTextEncodingIsWchar: val
!

"_________________________________________________________"
"string primitive accessors"
primXIMTextString
    <cCall: 'X11_XIMText_string_get' plugin: 'x11'>
    self primitiveFailed
!
primXIMTextString: val
    <cCall: 'X11_XIMText_string_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"string accessors"
string
    ^self primXIMTextString
!
string: val
    ^self primXIMTextString: val
!






primX11XIMTextDelete
    <cCall: 'X11_delete_XIMText' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XIMTextDelete.
!


name
    ^'X11XIMText'

! !

!X11XIMText methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XIMText methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XSetWindowAttributes
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XSetWindowAttributes class methodsFor: 'initialize-release'!

primX11XSetWindowAttributesCreate
    <cCall: 'X11_new_XSetWindowAttributes' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XSetWindowAttributesCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XSetWindowAttributes  methodsFor: 'X11'!

"_________________________________________________________"
"background_pixmap primitive accessors"
primXSetWindowAttributesBackgroundPixmap
    <cCall: 'X11_XSetWindowAttributes_background_pixmap_get' plugin: 'x11'>
    self primitiveFailed
!
primXSetWindowAttributesBackgroundPixmap: val
    <cCall: 'X11_XSetWindowAttributes_background_pixmap_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"background_pixmap accessors"
backgroundpixmap
    ^self primXSetWindowAttributesBackgroundPixmap
!
backgroundpixmap: val
    ^self primXSetWindowAttributesBackgroundPixmap: val
!

"_________________________________________________________"
"background_pixel primitive accessors"
primXSetWindowAttributesBackgroundPixel
    <cCall: 'X11_XSetWindowAttributes_background_pixel_get' plugin: 'x11'>
    self primitiveFailed
!
primXSetWindowAttributesBackgroundPixel: val
    <cCall: 'X11_XSetWindowAttributes_background_pixel_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"background_pixel accessors"
backgroundpixel
    ^self primXSetWindowAttributesBackgroundPixel
!
backgroundpixel: val
    ^self primXSetWindowAttributesBackgroundPixel: val
!

"_________________________________________________________"
"border_pixmap primitive accessors"
primXSetWindowAttributesBorderPixmap
    <cCall: 'X11_XSetWindowAttributes_border_pixmap_get' plugin: 'x11'>
    self primitiveFailed
!
primXSetWindowAttributesBorderPixmap: val
    <cCall: 'X11_XSetWindowAttributes_border_pixmap_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"border_pixmap accessors"
borderpixmap
    ^self primXSetWindowAttributesBorderPixmap
!
borderpixmap: val
    ^self primXSetWindowAttributesBorderPixmap: val
!

"_________________________________________________________"
"border_pixel primitive accessors"
primXSetWindowAttributesBorderPixel
    <cCall: 'X11_XSetWindowAttributes_border_pixel_get' plugin: 'x11'>
    self primitiveFailed
!
primXSetWindowAttributesBorderPixel: val
    <cCall: 'X11_XSetWindowAttributes_border_pixel_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"border_pixel accessors"
borderpixel
    ^self primXSetWindowAttributesBorderPixel
!
borderpixel: val
    ^self primXSetWindowAttributesBorderPixel: val
!

"_________________________________________________________"
"bit_gravity primitive accessors"
primXSetWindowAttributesBitGravity
    <cCall: 'X11_XSetWindowAttributes_bit_gravity_get' plugin: 'x11'>
    self primitiveFailed
!
primXSetWindowAttributesBitGravity: val
    <cCall: 'X11_XSetWindowAttributes_bit_gravity_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"bit_gravity accessors"
bitgravity
    ^self primXSetWindowAttributesBitGravity
!
bitgravity: val
    ^self primXSetWindowAttributesBitGravity: val
!

"_________________________________________________________"
"win_gravity primitive accessors"
primXSetWindowAttributesWinGravity
    <cCall: 'X11_XSetWindowAttributes_win_gravity_get' plugin: 'x11'>
    self primitiveFailed
!
primXSetWindowAttributesWinGravity: val
    <cCall: 'X11_XSetWindowAttributes_win_gravity_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"win_gravity accessors"
wingravity
    ^self primXSetWindowAttributesWinGravity
!
wingravity: val
    ^self primXSetWindowAttributesWinGravity: val
!

"_________________________________________________________"
"backing_store primitive accessors"
primXSetWindowAttributesBackingStore
    <cCall: 'X11_XSetWindowAttributes_backing_store_get' plugin: 'x11'>
    self primitiveFailed
!
primXSetWindowAttributesBackingStore: val
    <cCall: 'X11_XSetWindowAttributes_backing_store_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"backing_store accessors"
backingstore
    ^self primXSetWindowAttributesBackingStore
!
backingstore: val
    ^self primXSetWindowAttributesBackingStore: val
!

"_________________________________________________________"
"backing_planes primitive accessors"
primXSetWindowAttributesBackingPlanes
    <cCall: 'X11_XSetWindowAttributes_backing_planes_get' plugin: 'x11'>
    self primitiveFailed
!
primXSetWindowAttributesBackingPlanes: val
    <cCall: 'X11_XSetWindowAttributes_backing_planes_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"backing_planes accessors"
backingplanes
    ^self primXSetWindowAttributesBackingPlanes
!
backingplanes: val
    ^self primXSetWindowAttributesBackingPlanes: val
!

"_________________________________________________________"
"backing_pixel primitive accessors"
primXSetWindowAttributesBackingPixel
    <cCall: 'X11_XSetWindowAttributes_backing_pixel_get' plugin: 'x11'>
    self primitiveFailed
!
primXSetWindowAttributesBackingPixel: val
    <cCall: 'X11_XSetWindowAttributes_backing_pixel_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"backing_pixel accessors"
backingpixel
    ^self primXSetWindowAttributesBackingPixel
!
backingpixel: val
    ^self primXSetWindowAttributesBackingPixel: val
!

"_________________________________________________________"
"save_under primitive accessors"
primXSetWindowAttributesSaveUnder
    <cCall: 'X11_XSetWindowAttributes_save_under_get' plugin: 'x11'>
    self primitiveFailed
!
primXSetWindowAttributesSaveUnder: val
    <cCall: 'X11_XSetWindowAttributes_save_under_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"save_under accessors"
saveunder
    ^self primXSetWindowAttributesSaveUnder
!
saveunder: val
    ^self primXSetWindowAttributesSaveUnder: val
!

"_________________________________________________________"
"event_mask primitive accessors"
primXSetWindowAttributesEventMask
    <cCall: 'X11_XSetWindowAttributes_event_mask_get' plugin: 'x11'>
    self primitiveFailed
!
primXSetWindowAttributesEventMask: val
    <cCall: 'X11_XSetWindowAttributes_event_mask_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"event_mask accessors"
eventmask
    ^self primXSetWindowAttributesEventMask
!
eventmask: val
    ^self primXSetWindowAttributesEventMask: val
!

"_________________________________________________________"
"do_not_propagate_mask primitive accessors"
primXSetWindowAttributesDoNotPropagateMask
    <cCall: 'X11_XSetWindowAttributes_do_not_propagate_mask_get' plugin: 'x11'>
    self primitiveFailed
!
primXSetWindowAttributesDoNotPropagateMask: val
    <cCall: 'X11_XSetWindowAttributes_do_not_propagate_mask_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"do_not_propagate_mask accessors"
donotpropagatemask
    ^self primXSetWindowAttributesDoNotPropagateMask
!
donotpropagatemask: val
    ^self primXSetWindowAttributesDoNotPropagateMask: val
!

"_________________________________________________________"
"override_redirect primitive accessors"
primXSetWindowAttributesOverrideRedirect
    <cCall: 'X11_XSetWindowAttributes_override_redirect_get' plugin: 'x11'>
    self primitiveFailed
!
primXSetWindowAttributesOverrideRedirect: val
    <cCall: 'X11_XSetWindowAttributes_override_redirect_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"override_redirect accessors"
overrideredirect
    ^self primXSetWindowAttributesOverrideRedirect
!
overrideredirect: val
    ^self primXSetWindowAttributesOverrideRedirect: val
!

"_________________________________________________________"
"colormap primitive accessors"
primXSetWindowAttributesColormap
    <cCall: 'X11_XSetWindowAttributes_colormap_get' plugin: 'x11'>
    self primitiveFailed
!
primXSetWindowAttributesColormap: val
    <cCall: 'X11_XSetWindowAttributes_colormap_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"colormap accessors"
colormap
    ^self primXSetWindowAttributesColormap
!
colormap: val
    ^self primXSetWindowAttributesColormap: val
!

"_________________________________________________________"
"cursor primitive accessors"
primXSetWindowAttributesCursor
    <cCall: 'X11_XSetWindowAttributes_cursor_get' plugin: 'x11'>
    self primitiveFailed
!
primXSetWindowAttributesCursor: val
    <cCall: 'X11_XSetWindowAttributes_cursor_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"cursor accessors"
cursor
    ^self primXSetWindowAttributesCursor
!
cursor: val
    ^self primXSetWindowAttributesCursor: val
!






primX11XSetWindowAttributesDelete
    <cCall: 'X11_delete_XSetWindowAttributes' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XSetWindowAttributesDelete.
!


name
    ^'X11XSetWindowAttributes'

! !

!X11XSetWindowAttributes methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XSetWindowAttributes methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XKeyboardState
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XKeyboardState class methodsFor: 'initialize-release'!

primX11XKeyboardStateCreate
    <cCall: 'X11_new_XKeyboardState' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XKeyboardStateCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XKeyboardState  methodsFor: 'X11'!

"_________________________________________________________"
"key_click_percent primitive accessors"
primXKeyboardStateKeyClickPercent
    <cCall: 'X11_XKeyboardState_key_click_percent_get' plugin: 'x11'>
    self primitiveFailed
!
primXKeyboardStateKeyClickPercent: val
    <cCall: 'X11_XKeyboardState_key_click_percent_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"key_click_percent accessors"
keyclickpercent
    ^self primXKeyboardStateKeyClickPercent
!
keyclickpercent: val
    ^self primXKeyboardStateKeyClickPercent: val
!

"_________________________________________________________"
"bell_percent primitive accessors"
primXKeyboardStateBellPercent
    <cCall: 'X11_XKeyboardState_bell_percent_get' plugin: 'x11'>
    self primitiveFailed
!
primXKeyboardStateBellPercent: val
    <cCall: 'X11_XKeyboardState_bell_percent_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"bell_percent accessors"
bellpercent
    ^self primXKeyboardStateBellPercent
!
bellpercent: val
    ^self primXKeyboardStateBellPercent: val
!

"_________________________________________________________"
"bell_pitch primitive accessors"
primXKeyboardStateBellPitch
    <cCall: 'X11_XKeyboardState_bell_pitch_get' plugin: 'x11'>
    self primitiveFailed
!
primXKeyboardStateBellPitch: val
    <cCall: 'X11_XKeyboardState_bell_pitch_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"bell_pitch accessors"
bellpitch
    ^self primXKeyboardStateBellPitch
!
bellpitch: val
    ^self primXKeyboardStateBellPitch: val
!

"_________________________________________________________"
"bell_duration primitive accessors"
primXKeyboardStateBellDuration
    <cCall: 'X11_XKeyboardState_bell_duration_get' plugin: 'x11'>
    self primitiveFailed
!
primXKeyboardStateBellDuration: val
    <cCall: 'X11_XKeyboardState_bell_duration_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"bell_duration accessors"
bellduration
    ^self primXKeyboardStateBellDuration
!
bellduration: val
    ^self primXKeyboardStateBellDuration: val
!

"_________________________________________________________"
"led_mask primitive accessors"
primXKeyboardStateLedMask
    <cCall: 'X11_XKeyboardState_led_mask_get' plugin: 'x11'>
    self primitiveFailed
!
primXKeyboardStateLedMask: val
    <cCall: 'X11_XKeyboardState_led_mask_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"led_mask accessors"
ledmask
    ^self primXKeyboardStateLedMask
!
ledmask: val
    ^self primXKeyboardStateLedMask: val
!

"_________________________________________________________"
"global_auto_repeat primitive accessors"
primXKeyboardStateGlobalAutoRepeat
    <cCall: 'X11_XKeyboardState_global_auto_repeat_get' plugin: 'x11'>
    self primitiveFailed
!
primXKeyboardStateGlobalAutoRepeat: val
    <cCall: 'X11_XKeyboardState_global_auto_repeat_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"global_auto_repeat accessors"
globalautorepeat
    ^self primXKeyboardStateGlobalAutoRepeat
!
globalautorepeat: val
    ^self primXKeyboardStateGlobalAutoRepeat: val
!

"_________________________________________________________"
"auto_repeats primitive accessors"
primXKeyboardStateAutoRepeats
    <cCall: 'X11_XKeyboardState_auto_repeats_get' plugin: 'x11'>
    self primitiveFailed
!
primXKeyboardStateAutoRepeats: val
    <cCall: 'X11_XKeyboardState_auto_repeats_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"auto_repeats accessors"
autorepeats
    ^self primXKeyboardStateAutoRepeats
!
autorepeats: val
    ^self primXKeyboardStateAutoRepeats: val
!






primX11XKeyboardStateDelete
    <cCall: 'X11_delete_XKeyboardState' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XKeyboardStateDelete.
!


name
    ^'X11XKeyboardState'

! !

!X11XKeyboardState methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XKeyboardState methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XCirculateEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XCirculateEvent class methodsFor: 'initialize-release'!

primX11XCirculateEventCreate
    <cCall: 'X11_new_XCirculateEvent' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XCirculateEventCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XCirculateEvent  methodsFor: 'X11'!

"_________________________________________________________"
"type primitive accessors"
primXCirculateEventType
    <cCall: 'X11_XCirculateEvent_type_get' plugin: 'x11'>
    self primitiveFailed
!
primXCirculateEventType: val
    <cCall: 'X11_XCirculateEvent_type_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"type accessors"
type
    ^self primXCirculateEventType
!
type: val
    ^self primXCirculateEventType: val
!

"_________________________________________________________"
"serial primitive accessors"
primXCirculateEventSerial
    <cCall: 'X11_XCirculateEvent_serial_get' plugin: 'x11'>
    self primitiveFailed
!
primXCirculateEventSerial: val
    <cCall: 'X11_XCirculateEvent_serial_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"serial accessors"
serial
    ^self primXCirculateEventSerial
!
serial: val
    ^self primXCirculateEventSerial: val
!

"_________________________________________________________"
"send_event primitive accessors"
primXCirculateEventSendEvent
    <cCall: 'X11_XCirculateEvent_send_event_get' plugin: 'x11'>
    self primitiveFailed
!
primXCirculateEventSendEvent: val
    <cCall: 'X11_XCirculateEvent_send_event_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"send_event accessors"
sendevent
    ^self primXCirculateEventSendEvent
!
sendevent: val
    ^self primXCirculateEventSendEvent: val
!

"_________________________________________________________"
"display primitive accessors"
primXCirculateEventDisplay
    <cCall: 'X11_XCirculateEvent_display_get' plugin: 'x11'>
    self primitiveFailed
!
primXCirculateEventDisplay: val
    <cCall: 'X11_XCirculateEvent_display_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"display accessors"
display
    ^self primXCirculateEventDisplay
!
display: val
    ^self primXCirculateEventDisplay: val
!

"_________________________________________________________"
"event primitive accessors"
primXCirculateEventEvent
    <cCall: 'X11_XCirculateEvent_event_get' plugin: 'x11'>
    self primitiveFailed
!
primXCirculateEventEvent: val
    <cCall: 'X11_XCirculateEvent_event_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"event accessors"
event
    ^self primXCirculateEventEvent
!
event: val
    ^self primXCirculateEventEvent: val
!

"_________________________________________________________"
"window primitive accessors"
primXCirculateEventWindow
    <cCall: 'X11_XCirculateEvent_window_get' plugin: 'x11'>
    self primitiveFailed
!
primXCirculateEventWindow: val
    <cCall: 'X11_XCirculateEvent_window_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"window accessors"
window
    ^self primXCirculateEventWindow
!
window: val
    ^self primXCirculateEventWindow: val
!

"_________________________________________________________"
"place primitive accessors"
primXCirculateEventPlace
    <cCall: 'X11_XCirculateEvent_place_get' plugin: 'x11'>
    self primitiveFailed
!
primXCirculateEventPlace: val
    <cCall: 'X11_XCirculateEvent_place_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"place accessors"
place
    ^self primXCirculateEventPlace
!
place: val
    ^self primXCirculateEventPlace: val
!






primX11XCirculateEventDelete
    <cCall: 'X11_delete_XCirculateEvent' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XCirculateEventDelete.
!


name
    ^'X11XCirculateEvent'

! !

!X11XCirculateEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XCirculateEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XTimeCoord
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XTimeCoord class methodsFor: 'initialize-release'!

primX11XTimeCoordCreate
    <cCall: 'X11_new_XTimeCoord' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XTimeCoordCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XTimeCoord  methodsFor: 'X11'!

"_________________________________________________________"
"time primitive accessors"
primXTimeCoordTime
    <cCall: 'X11_XTimeCoord_time_get' plugin: 'x11'>
    self primitiveFailed
!
primXTimeCoordTime: val
    <cCall: 'X11_XTimeCoord_time_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"time accessors"
time
    ^self primXTimeCoordTime
!
time: val
    ^self primXTimeCoordTime: val
!

"_________________________________________________________"
"x primitive accessors"
primXTimeCoordX
    <cCall: 'X11_XTimeCoord_x_get' plugin: 'x11'>
    self primitiveFailed
!
primXTimeCoordX: val
    <cCall: 'X11_XTimeCoord_x_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"x accessors"
x
    ^self primXTimeCoordX
!
x: val
    ^self primXTimeCoordX: val
!

"_________________________________________________________"
"y primitive accessors"
primXTimeCoordY
    <cCall: 'X11_XTimeCoord_y_get' plugin: 'x11'>
    self primitiveFailed
!
primXTimeCoordY: val
    <cCall: 'X11_XTimeCoord_y_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"y accessors"
y
    ^self primXTimeCoordY
!
y: val
    ^self primXTimeCoordY: val
!






primX11XTimeCoordDelete
    <cCall: 'X11_delete_XTimeCoord' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XTimeCoordDelete.
!


name
    ^'X11XTimeCoord'

! !

!X11XTimeCoord methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XTimeCoord methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XCreateWindowEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XCreateWindowEvent class methodsFor: 'initialize-release'!

primX11XCreateWindowEventCreate
    <cCall: 'X11_new_XCreateWindowEvent' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XCreateWindowEventCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XCreateWindowEvent  methodsFor: 'X11'!

"_________________________________________________________"
"type primitive accessors"
primXCreateWindowEventType
    <cCall: 'X11_XCreateWindowEvent_type_get' plugin: 'x11'>
    self primitiveFailed
!
primXCreateWindowEventType: val
    <cCall: 'X11_XCreateWindowEvent_type_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"type accessors"
type
    ^self primXCreateWindowEventType
!
type: val
    ^self primXCreateWindowEventType: val
!

"_________________________________________________________"
"serial primitive accessors"
primXCreateWindowEventSerial
    <cCall: 'X11_XCreateWindowEvent_serial_get' plugin: 'x11'>
    self primitiveFailed
!
primXCreateWindowEventSerial: val
    <cCall: 'X11_XCreateWindowEvent_serial_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"serial accessors"
serial
    ^self primXCreateWindowEventSerial
!
serial: val
    ^self primXCreateWindowEventSerial: val
!

"_________________________________________________________"
"send_event primitive accessors"
primXCreateWindowEventSendEvent
    <cCall: 'X11_XCreateWindowEvent_send_event_get' plugin: 'x11'>
    self primitiveFailed
!
primXCreateWindowEventSendEvent: val
    <cCall: 'X11_XCreateWindowEvent_send_event_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"send_event accessors"
sendevent
    ^self primXCreateWindowEventSendEvent
!
sendevent: val
    ^self primXCreateWindowEventSendEvent: val
!

"_________________________________________________________"
"display primitive accessors"
primXCreateWindowEventDisplay
    <cCall: 'X11_XCreateWindowEvent_display_get' plugin: 'x11'>
    self primitiveFailed
!
primXCreateWindowEventDisplay: val
    <cCall: 'X11_XCreateWindowEvent_display_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"display accessors"
display
    ^self primXCreateWindowEventDisplay
!
display: val
    ^self primXCreateWindowEventDisplay: val
!

"_________________________________________________________"
"parent primitive accessors"
primXCreateWindowEventParent
    <cCall: 'X11_XCreateWindowEvent_parent_get' plugin: 'x11'>
    self primitiveFailed
!
primXCreateWindowEventParent: val
    <cCall: 'X11_XCreateWindowEvent_parent_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"parent accessors"
parent
    ^self primXCreateWindowEventParent
!
parent: val
    ^self primXCreateWindowEventParent: val
!

"_________________________________________________________"
"window primitive accessors"
primXCreateWindowEventWindow
    <cCall: 'X11_XCreateWindowEvent_window_get' plugin: 'x11'>
    self primitiveFailed
!
primXCreateWindowEventWindow: val
    <cCall: 'X11_XCreateWindowEvent_window_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"window accessors"
window
    ^self primXCreateWindowEventWindow
!
window: val
    ^self primXCreateWindowEventWindow: val
!

"_________________________________________________________"
"x primitive accessors"
primXCreateWindowEventX
    <cCall: 'X11_XCreateWindowEvent_x_get' plugin: 'x11'>
    self primitiveFailed
!
primXCreateWindowEventX: val
    <cCall: 'X11_XCreateWindowEvent_x_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"x accessors"
x
    ^self primXCreateWindowEventX
!
x: val
    ^self primXCreateWindowEventX: val
!

"_________________________________________________________"
"y primitive accessors"
primXCreateWindowEventY
    <cCall: 'X11_XCreateWindowEvent_y_get' plugin: 'x11'>
    self primitiveFailed
!
primXCreateWindowEventY: val
    <cCall: 'X11_XCreateWindowEvent_y_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"y accessors"
y
    ^self primXCreateWindowEventY
!
y: val
    ^self primXCreateWindowEventY: val
!

"_________________________________________________________"
"width primitive accessors"
primXCreateWindowEventWidth
    <cCall: 'X11_XCreateWindowEvent_width_get' plugin: 'x11'>
    self primitiveFailed
!
primXCreateWindowEventWidth: val
    <cCall: 'X11_XCreateWindowEvent_width_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"width accessors"
width
    ^self primXCreateWindowEventWidth
!
width: val
    ^self primXCreateWindowEventWidth: val
!

"_________________________________________________________"
"height primitive accessors"
primXCreateWindowEventHeight
    <cCall: 'X11_XCreateWindowEvent_height_get' plugin: 'x11'>
    self primitiveFailed
!
primXCreateWindowEventHeight: val
    <cCall: 'X11_XCreateWindowEvent_height_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"height accessors"
height
    ^self primXCreateWindowEventHeight
!
height: val
    ^self primXCreateWindowEventHeight: val
!

"_________________________________________________________"
"border_width primitive accessors"
primXCreateWindowEventBorderWidth
    <cCall: 'X11_XCreateWindowEvent_border_width_get' plugin: 'x11'>
    self primitiveFailed
!
primXCreateWindowEventBorderWidth: val
    <cCall: 'X11_XCreateWindowEvent_border_width_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"border_width accessors"
borderwidth
    ^self primXCreateWindowEventBorderWidth
!
borderwidth: val
    ^self primXCreateWindowEventBorderWidth: val
!

"_________________________________________________________"
"override_redirect primitive accessors"
primXCreateWindowEventOverrideRedirect
    <cCall: 'X11_XCreateWindowEvent_override_redirect_get' plugin: 'x11'>
    self primitiveFailed
!
primXCreateWindowEventOverrideRedirect: val
    <cCall: 'X11_XCreateWindowEvent_override_redirect_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"override_redirect accessors"
overrideredirect
    ^self primXCreateWindowEventOverrideRedirect
!
overrideredirect: val
    ^self primXCreateWindowEventOverrideRedirect: val
!






primX11XCreateWindowEventDelete
    <cCall: 'X11_delete_XCreateWindowEvent' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XCreateWindowEventDelete.
!


name
    ^'X11XCreateWindowEvent'

! !

!X11XCreateWindowEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XCreateWindowEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XSegment
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XSegment class methodsFor: 'initialize-release'!

primX11XSegmentCreate
    <cCall: 'X11_new_XSegment' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XSegmentCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XSegment  methodsFor: 'X11'!

"_________________________________________________________"
"x1 primitive accessors"
primXSegmentX1
    <cCall: 'X11_XSegment_x1_get' plugin: 'x11'>
    self primitiveFailed
!
primXSegmentX1: val
    <cCall: 'X11_XSegment_x1_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"x1 accessors"
x1
    ^self primXSegmentX1
!
x1: val
    ^self primXSegmentX1: val
!

"_________________________________________________________"
"y1 primitive accessors"
primXSegmentY1
    <cCall: 'X11_XSegment_y1_get' plugin: 'x11'>
    self primitiveFailed
!
primXSegmentY1: val
    <cCall: 'X11_XSegment_y1_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"y1 accessors"
y1
    ^self primXSegmentY1
!
y1: val
    ^self primXSegmentY1: val
!

"_________________________________________________________"
"x2 primitive accessors"
primXSegmentX2
    <cCall: 'X11_XSegment_x2_get' plugin: 'x11'>
    self primitiveFailed
!
primXSegmentX2: val
    <cCall: 'X11_XSegment_x2_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"x2 accessors"
x2
    ^self primXSegmentX2
!
x2: val
    ^self primXSegmentX2: val
!

"_________________________________________________________"
"y2 primitive accessors"
primXSegmentY2
    <cCall: 'X11_XSegment_y2_get' plugin: 'x11'>
    self primitiveFailed
!
primXSegmentY2: val
    <cCall: 'X11_XSegment_y2_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"y2 accessors"
y2
    ^self primXSegmentY2
!
y2: val
    ^self primXSegmentY2: val
!






primX11XSegmentDelete
    <cCall: 'X11_delete_XSegment' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XSegmentDelete.
!


name
    ^'X11XSegment'

! !

!X11XSegment methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XSegment methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11ScreenFormat
        instanceVariableNames: ''
        classVariableNames: ''!

!X11ScreenFormat class methodsFor: 'initialize-release'!

primX11ScreenFormatCreate
    <cCall: 'X11_new_ScreenFormat' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11ScreenFormatCreate).
!

initialize
    finalizationRequest := true.
! !

!X11ScreenFormat  methodsFor: 'X11'!

"_________________________________________________________"
"ext_data primitive accessors"
primScreenFormatExtData
    <cCall: 'X11_ScreenFormat_ext_data_get' plugin: 'x11'>
    self primitiveFailed
!
primScreenFormatExtData: val
    <cCall: 'X11_ScreenFormat_ext_data_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"ext_data accessors"
extdata
    ^self primScreenFormatExtData
!
extdata: val
    ^self primScreenFormatExtData: val
!

"_________________________________________________________"
"depth primitive accessors"
primScreenFormatDepth
    <cCall: 'X11_ScreenFormat_depth_get' plugin: 'x11'>
    self primitiveFailed
!
primScreenFormatDepth: val
    <cCall: 'X11_ScreenFormat_depth_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"depth accessors"
depth
    ^self primScreenFormatDepth
!
depth: val
    ^self primScreenFormatDepth: val
!

"_________________________________________________________"
"bits_per_pixel primitive accessors"
primScreenFormatBitsPerPixel
    <cCall: 'X11_ScreenFormat_bits_per_pixel_get' plugin: 'x11'>
    self primitiveFailed
!
primScreenFormatBitsPerPixel: val
    <cCall: 'X11_ScreenFormat_bits_per_pixel_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"bits_per_pixel accessors"
bitsperpixel
    ^self primScreenFormatBitsPerPixel
!
bitsperpixel: val
    ^self primScreenFormatBitsPerPixel: val
!

"_________________________________________________________"
"scanline_pad primitive accessors"
primScreenFormatScanlinePad
    <cCall: 'X11_ScreenFormat_scanline_pad_get' plugin: 'x11'>
    self primitiveFailed
!
primScreenFormatScanlinePad: val
    <cCall: 'X11_ScreenFormat_scanline_pad_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"scanline_pad accessors"
scanlinepad
    ^self primScreenFormatScanlinePad
!
scanlinepad: val
    ^self primScreenFormatScanlinePad: val
!






primX11ScreenFormatDelete
    <cCall: 'X11_delete_ScreenFormat' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11ScreenFormatDelete.
!


name
    ^'X11ScreenFormat'

! !

!X11ScreenFormat methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11ScreenFormat methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XServerInterpretedAddress
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XServerInterpretedAddress class methodsFor: 'initialize-release'!

primX11XServerInterpretedAddressCreate
    <cCall: 'X11_new_XServerInterpretedAddress' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XServerInterpretedAddressCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XServerInterpretedAddress  methodsFor: 'X11'!

"_________________________________________________________"
"typelength primitive accessors"
primXServerInterpretedAddressTypelength
    <cCall: 'X11_XServerInterpretedAddress_typelength_get' plugin: 'x11'>
    self primitiveFailed
!
primXServerInterpretedAddressTypelength: val
    <cCall: 'X11_XServerInterpretedAddress_typelength_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"typelength accessors"
typelength
    ^self primXServerInterpretedAddressTypelength
!
typelength: val
    ^self primXServerInterpretedAddressTypelength: val
!

"_________________________________________________________"
"valuelength primitive accessors"
primXServerInterpretedAddressValuelength
    <cCall: 'X11_XServerInterpretedAddress_valuelength_get' plugin: 'x11'>
    self primitiveFailed
!
primXServerInterpretedAddressValuelength: val
    <cCall: 'X11_XServerInterpretedAddress_valuelength_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"valuelength accessors"
valuelength
    ^self primXServerInterpretedAddressValuelength
!
valuelength: val
    ^self primXServerInterpretedAddressValuelength: val
!

"_________________________________________________________"
"type primitive accessors"
primXServerInterpretedAddressType
    <cCall: 'X11_XServerInterpretedAddress_type_get' plugin: 'x11'>
    self primitiveFailed
!
primXServerInterpretedAddressType: val
    <cCall: 'X11_XServerInterpretedAddress_type_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"type accessors"
type
    ^self primXServerInterpretedAddressType
!
type: val
    ^self primXServerInterpretedAddressType: val
!

"_________________________________________________________"
"value primitive accessors"
primXServerInterpretedAddressValue
    <cCall: 'X11_XServerInterpretedAddress_value_get' plugin: 'x11'>
    self primitiveFailed
!
primXServerInterpretedAddressValue: val
    <cCall: 'X11_XServerInterpretedAddress_value_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"value accessors"
value
    ^self primXServerInterpretedAddressValue
!
value: val
    ^self primXServerInterpretedAddressValue: val
!






primX11XServerInterpretedAddressDelete
    <cCall: 'X11_delete_XServerInterpretedAddress' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XServerInterpretedAddressDelete.
!


name
    ^'X11XServerInterpretedAddress'

! !

!X11XServerInterpretedAddress methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XServerInterpretedAddress methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XConfigureEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XConfigureEvent class methodsFor: 'initialize-release'!

primX11XConfigureEventCreate
    <cCall: 'X11_new_XConfigureEvent' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XConfigureEventCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XConfigureEvent  methodsFor: 'X11'!

"_________________________________________________________"
"type primitive accessors"
primXConfigureEventType
    <cCall: 'X11_XConfigureEvent_type_get' plugin: 'x11'>
    self primitiveFailed
!
primXConfigureEventType: val
    <cCall: 'X11_XConfigureEvent_type_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"type accessors"
type
    ^self primXConfigureEventType
!
type: val
    ^self primXConfigureEventType: val
!

"_________________________________________________________"
"serial primitive accessors"
primXConfigureEventSerial
    <cCall: 'X11_XConfigureEvent_serial_get' plugin: 'x11'>
    self primitiveFailed
!
primXConfigureEventSerial: val
    <cCall: 'X11_XConfigureEvent_serial_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"serial accessors"
serial
    ^self primXConfigureEventSerial
!
serial: val
    ^self primXConfigureEventSerial: val
!

"_________________________________________________________"
"send_event primitive accessors"
primXConfigureEventSendEvent
    <cCall: 'X11_XConfigureEvent_send_event_get' plugin: 'x11'>
    self primitiveFailed
!
primXConfigureEventSendEvent: val
    <cCall: 'X11_XConfigureEvent_send_event_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"send_event accessors"
sendevent
    ^self primXConfigureEventSendEvent
!
sendevent: val
    ^self primXConfigureEventSendEvent: val
!

"_________________________________________________________"
"display primitive accessors"
primXConfigureEventDisplay
    <cCall: 'X11_XConfigureEvent_display_get' plugin: 'x11'>
    self primitiveFailed
!
primXConfigureEventDisplay: val
    <cCall: 'X11_XConfigureEvent_display_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"display accessors"
display
    ^self primXConfigureEventDisplay
!
display: val
    ^self primXConfigureEventDisplay: val
!

"_________________________________________________________"
"event primitive accessors"
primXConfigureEventEvent
    <cCall: 'X11_XConfigureEvent_event_get' plugin: 'x11'>
    self primitiveFailed
!
primXConfigureEventEvent: val
    <cCall: 'X11_XConfigureEvent_event_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"event accessors"
event
    ^self primXConfigureEventEvent
!
event: val
    ^self primXConfigureEventEvent: val
!

"_________________________________________________________"
"window primitive accessors"
primXConfigureEventWindow
    <cCall: 'X11_XConfigureEvent_window_get' plugin: 'x11'>
    self primitiveFailed
!
primXConfigureEventWindow: val
    <cCall: 'X11_XConfigureEvent_window_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"window accessors"
window
    ^self primXConfigureEventWindow
!
window: val
    ^self primXConfigureEventWindow: val
!

"_________________________________________________________"
"x primitive accessors"
primXConfigureEventX
    <cCall: 'X11_XConfigureEvent_x_get' plugin: 'x11'>
    self primitiveFailed
!
primXConfigureEventX: val
    <cCall: 'X11_XConfigureEvent_x_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"x accessors"
x
    ^self primXConfigureEventX
!
x: val
    ^self primXConfigureEventX: val
!

"_________________________________________________________"
"y primitive accessors"
primXConfigureEventY
    <cCall: 'X11_XConfigureEvent_y_get' plugin: 'x11'>
    self primitiveFailed
!
primXConfigureEventY: val
    <cCall: 'X11_XConfigureEvent_y_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"y accessors"
y
    ^self primXConfigureEventY
!
y: val
    ^self primXConfigureEventY: val
!

"_________________________________________________________"
"width primitive accessors"
primXConfigureEventWidth
    <cCall: 'X11_XConfigureEvent_width_get' plugin: 'x11'>
    self primitiveFailed
!
primXConfigureEventWidth: val
    <cCall: 'X11_XConfigureEvent_width_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"width accessors"
width
    ^self primXConfigureEventWidth
!
width: val
    ^self primXConfigureEventWidth: val
!

"_________________________________________________________"
"height primitive accessors"
primXConfigureEventHeight
    <cCall: 'X11_XConfigureEvent_height_get' plugin: 'x11'>
    self primitiveFailed
!
primXConfigureEventHeight: val
    <cCall: 'X11_XConfigureEvent_height_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"height accessors"
height
    ^self primXConfigureEventHeight
!
height: val
    ^self primXConfigureEventHeight: val
!

"_________________________________________________________"
"border_width primitive accessors"
primXConfigureEventBorderWidth
    <cCall: 'X11_XConfigureEvent_border_width_get' plugin: 'x11'>
    self primitiveFailed
!
primXConfigureEventBorderWidth: val
    <cCall: 'X11_XConfigureEvent_border_width_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"border_width accessors"
borderwidth
    ^self primXConfigureEventBorderWidth
!
borderwidth: val
    ^self primXConfigureEventBorderWidth: val
!

"_________________________________________________________"
"above primitive accessors"
primXConfigureEventAbove
    <cCall: 'X11_XConfigureEvent_above_get' plugin: 'x11'>
    self primitiveFailed
!
primXConfigureEventAbove: val
    <cCall: 'X11_XConfigureEvent_above_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"above accessors"
above
    ^self primXConfigureEventAbove
!
above: val
    ^self primXConfigureEventAbove: val
!

"_________________________________________________________"
"override_redirect primitive accessors"
primXConfigureEventOverrideRedirect
    <cCall: 'X11_XConfigureEvent_override_redirect_get' plugin: 'x11'>
    self primitiveFailed
!
primXConfigureEventOverrideRedirect: val
    <cCall: 'X11_XConfigureEvent_override_redirect_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"override_redirect accessors"
overrideredirect
    ^self primXConfigureEventOverrideRedirect
!
overrideredirect: val
    ^self primXConfigureEventOverrideRedirect: val
!






primX11XConfigureEventDelete
    <cCall: 'X11_delete_XConfigureEvent' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XConfigureEventDelete.
!


name
    ^'X11XConfigureEvent'

! !

!X11XConfigureEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XConfigureEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XOMCharSetList
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XOMCharSetList class methodsFor: 'initialize-release'!

primX11XOMCharSetListCreate
    <cCall: 'X11_new_XOMCharSetList' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XOMCharSetListCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XOMCharSetList  methodsFor: 'X11'!

"_________________________________________________________"
"charset_count primitive accessors"
primXOMCharSetListCharsetCount
    <cCall: 'X11_XOMCharSetList_charset_count_get' plugin: 'x11'>
    self primitiveFailed
!
primXOMCharSetListCharsetCount: val
    <cCall: 'X11_XOMCharSetList_charset_count_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"charset_count accessors"
charsetcount
    ^self primXOMCharSetListCharsetCount
!
charsetcount: val
    ^self primXOMCharSetListCharsetCount: val
!

"_________________________________________________________"
"charset_list primitive accessors"
primXOMCharSetListCharsetList
    <cCall: 'X11_XOMCharSetList_charset_list_get' plugin: 'x11'>
    self primitiveFailed
!
primXOMCharSetListCharsetList: val
    <cCall: 'X11_XOMCharSetList_charset_list_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"charset_list accessors"
charsetlist
    ^self primXOMCharSetListCharsetList
!
charsetlist: val
    ^self primXOMCharSetListCharsetList: val
!






primX11XOMCharSetListDelete
    <cCall: 'X11_delete_XOMCharSetList' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XOMCharSetListDelete.
!


name
    ^'X11XOMCharSetList'

! !

!X11XOMCharSetList methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XOMCharSetList methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XButtonEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XButtonEvent class methodsFor: 'initialize-release'!

primX11XButtonEventCreate
    <cCall: 'X11_new_XButtonEvent' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XButtonEventCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XButtonEvent  methodsFor: 'X11'!

"_________________________________________________________"
"type primitive accessors"
primXButtonEventType
    <cCall: 'X11_XButtonEvent_type_get' plugin: 'x11'>
    self primitiveFailed
!
primXButtonEventType: val
    <cCall: 'X11_XButtonEvent_type_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"type accessors"
type
    ^self primXButtonEventType
!
type: val
    ^self primXButtonEventType: val
!

"_________________________________________________________"
"serial primitive accessors"
primXButtonEventSerial
    <cCall: 'X11_XButtonEvent_serial_get' plugin: 'x11'>
    self primitiveFailed
!
primXButtonEventSerial: val
    <cCall: 'X11_XButtonEvent_serial_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"serial accessors"
serial
    ^self primXButtonEventSerial
!
serial: val
    ^self primXButtonEventSerial: val
!

"_________________________________________________________"
"send_event primitive accessors"
primXButtonEventSendEvent
    <cCall: 'X11_XButtonEvent_send_event_get' plugin: 'x11'>
    self primitiveFailed
!
primXButtonEventSendEvent: val
    <cCall: 'X11_XButtonEvent_send_event_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"send_event accessors"
sendevent
    ^self primXButtonEventSendEvent
!
sendevent: val
    ^self primXButtonEventSendEvent: val
!

"_________________________________________________________"
"display primitive accessors"
primXButtonEventDisplay
    <cCall: 'X11_XButtonEvent_display_get' plugin: 'x11'>
    self primitiveFailed
!
primXButtonEventDisplay: val
    <cCall: 'X11_XButtonEvent_display_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"display accessors"
display
    ^self primXButtonEventDisplay
!
display: val
    ^self primXButtonEventDisplay: val
!

"_________________________________________________________"
"window primitive accessors"
primXButtonEventWindow
    <cCall: 'X11_XButtonEvent_window_get' plugin: 'x11'>
    self primitiveFailed
!
primXButtonEventWindow: val
    <cCall: 'X11_XButtonEvent_window_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"window accessors"
window
    ^self primXButtonEventWindow
!
window: val
    ^self primXButtonEventWindow: val
!

"_________________________________________________________"
"root primitive accessors"
primXButtonEventRoot
    <cCall: 'X11_XButtonEvent_root_get' plugin: 'x11'>
    self primitiveFailed
!
primXButtonEventRoot: val
    <cCall: 'X11_XButtonEvent_root_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"root accessors"
root
    ^self primXButtonEventRoot
!
root: val
    ^self primXButtonEventRoot: val
!

"_________________________________________________________"
"subwindow primitive accessors"
primXButtonEventSubwindow
    <cCall: 'X11_XButtonEvent_subwindow_get' plugin: 'x11'>
    self primitiveFailed
!
primXButtonEventSubwindow: val
    <cCall: 'X11_XButtonEvent_subwindow_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"subwindow accessors"
subwindow
    ^self primXButtonEventSubwindow
!
subwindow: val
    ^self primXButtonEventSubwindow: val
!

"_________________________________________________________"
"time primitive accessors"
primXButtonEventTime
    <cCall: 'X11_XButtonEvent_time_get' plugin: 'x11'>
    self primitiveFailed
!
primXButtonEventTime: val
    <cCall: 'X11_XButtonEvent_time_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"time accessors"
time
    ^self primXButtonEventTime
!
time: val
    ^self primXButtonEventTime: val
!

"_________________________________________________________"
"x primitive accessors"
primXButtonEventX
    <cCall: 'X11_XButtonEvent_x_get' plugin: 'x11'>
    self primitiveFailed
!
primXButtonEventX: val
    <cCall: 'X11_XButtonEvent_x_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"x accessors"
x
    ^self primXButtonEventX
!
x: val
    ^self primXButtonEventX: val
!

"_________________________________________________________"
"y primitive accessors"
primXButtonEventY
    <cCall: 'X11_XButtonEvent_y_get' plugin: 'x11'>
    self primitiveFailed
!
primXButtonEventY: val
    <cCall: 'X11_XButtonEvent_y_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"y accessors"
y
    ^self primXButtonEventY
!
y: val
    ^self primXButtonEventY: val
!

"_________________________________________________________"
"x_root primitive accessors"
primXButtonEventXRoot
    <cCall: 'X11_XButtonEvent_x_root_get' plugin: 'x11'>
    self primitiveFailed
!
primXButtonEventXRoot: val
    <cCall: 'X11_XButtonEvent_x_root_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"x_root accessors"
xroot
    ^self primXButtonEventXRoot
!
xroot: val
    ^self primXButtonEventXRoot: val
!

"_________________________________________________________"
"y_root primitive accessors"
primXButtonEventYRoot
    <cCall: 'X11_XButtonEvent_y_root_get' plugin: 'x11'>
    self primitiveFailed
!
primXButtonEventYRoot: val
    <cCall: 'X11_XButtonEvent_y_root_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"y_root accessors"
yroot
    ^self primXButtonEventYRoot
!
yroot: val
    ^self primXButtonEventYRoot: val
!

"_________________________________________________________"
"state primitive accessors"
primXButtonEventState
    <cCall: 'X11_XButtonEvent_state_get' plugin: 'x11'>
    self primitiveFailed
!
primXButtonEventState: val
    <cCall: 'X11_XButtonEvent_state_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"state accessors"
state
    ^self primXButtonEventState
!
state: val
    ^self primXButtonEventState: val
!

"_________________________________________________________"
"button primitive accessors"
primXButtonEventButton
    <cCall: 'X11_XButtonEvent_button_get' plugin: 'x11'>
    self primitiveFailed
!
primXButtonEventButton: val
    <cCall: 'X11_XButtonEvent_button_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"button accessors"
button
    ^self primXButtonEventButton
!
button: val
    ^self primXButtonEventButton: val
!

"_________________________________________________________"
"same_screen primitive accessors"
primXButtonEventSameScreen
    <cCall: 'X11_XButtonEvent_same_screen_get' plugin: 'x11'>
    self primitiveFailed
!
primXButtonEventSameScreen: val
    <cCall: 'X11_XButtonEvent_same_screen_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"same_screen accessors"
samescreen
    ^self primXButtonEventSameScreen
!
samescreen: val
    ^self primXButtonEventSameScreen: val
!






primX11XButtonEventDelete
    <cCall: 'X11_delete_XButtonEvent' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XButtonEventDelete.
!


name
    ^'X11XButtonEvent'

! !

!X11XButtonEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XButtonEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XKeymapEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XKeymapEvent class methodsFor: 'initialize-release'!

primX11XKeymapEventCreate
    <cCall: 'X11_new_XKeymapEvent' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XKeymapEventCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XKeymapEvent  methodsFor: 'X11'!

"_________________________________________________________"
"type primitive accessors"
primXKeymapEventType
    <cCall: 'X11_XKeymapEvent_type_get' plugin: 'x11'>
    self primitiveFailed
!
primXKeymapEventType: val
    <cCall: 'X11_XKeymapEvent_type_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"type accessors"
type
    ^self primXKeymapEventType
!
type: val
    ^self primXKeymapEventType: val
!

"_________________________________________________________"
"serial primitive accessors"
primXKeymapEventSerial
    <cCall: 'X11_XKeymapEvent_serial_get' plugin: 'x11'>
    self primitiveFailed
!
primXKeymapEventSerial: val
    <cCall: 'X11_XKeymapEvent_serial_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"serial accessors"
serial
    ^self primXKeymapEventSerial
!
serial: val
    ^self primXKeymapEventSerial: val
!

"_________________________________________________________"
"send_event primitive accessors"
primXKeymapEventSendEvent
    <cCall: 'X11_XKeymapEvent_send_event_get' plugin: 'x11'>
    self primitiveFailed
!
primXKeymapEventSendEvent: val
    <cCall: 'X11_XKeymapEvent_send_event_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"send_event accessors"
sendevent
    ^self primXKeymapEventSendEvent
!
sendevent: val
    ^self primXKeymapEventSendEvent: val
!

"_________________________________________________________"
"display primitive accessors"
primXKeymapEventDisplay
    <cCall: 'X11_XKeymapEvent_display_get' plugin: 'x11'>
    self primitiveFailed
!
primXKeymapEventDisplay: val
    <cCall: 'X11_XKeymapEvent_display_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"display accessors"
display
    ^self primXKeymapEventDisplay
!
display: val
    ^self primXKeymapEventDisplay: val
!

"_________________________________________________________"
"window primitive accessors"
primXKeymapEventWindow
    <cCall: 'X11_XKeymapEvent_window_get' plugin: 'x11'>
    self primitiveFailed
!
primXKeymapEventWindow: val
    <cCall: 'X11_XKeymapEvent_window_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"window accessors"
window
    ^self primXKeymapEventWindow
!
window: val
    ^self primXKeymapEventWindow: val
!

"_________________________________________________________"
"key_vector primitive accessors"
primXKeymapEventKeyVector
    <cCall: 'X11_XKeymapEvent_key_vector_get' plugin: 'x11'>
    self primitiveFailed
!
primXKeymapEventKeyVector: val
    <cCall: 'X11_XKeymapEvent_key_vector_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"key_vector accessors"
keyvector
    ^self primXKeymapEventKeyVector
!
keyvector: val
    ^self primXKeymapEventKeyVector: val
!






primX11XKeymapEventDelete
    <cCall: 'X11_delete_XKeymapEvent' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XKeymapEventDelete.
!


name
    ^'X11XKeymapEvent'

! !

!X11XKeymapEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XKeymapEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XGraphicsExposeEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XGraphicsExposeEvent class methodsFor: 'initialize-release'!

primX11XGraphicsExposeEventCreate
    <cCall: 'X11_new_XGraphicsExposeEvent' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XGraphicsExposeEventCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XGraphicsExposeEvent  methodsFor: 'X11'!

"_________________________________________________________"
"type primitive accessors"
primXGraphicsExposeEventType
    <cCall: 'X11_XGraphicsExposeEvent_type_get' plugin: 'x11'>
    self primitiveFailed
!
primXGraphicsExposeEventType: val
    <cCall: 'X11_XGraphicsExposeEvent_type_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"type accessors"
type
    ^self primXGraphicsExposeEventType
!
type: val
    ^self primXGraphicsExposeEventType: val
!

"_________________________________________________________"
"serial primitive accessors"
primXGraphicsExposeEventSerial
    <cCall: 'X11_XGraphicsExposeEvent_serial_get' plugin: 'x11'>
    self primitiveFailed
!
primXGraphicsExposeEventSerial: val
    <cCall: 'X11_XGraphicsExposeEvent_serial_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"serial accessors"
serial
    ^self primXGraphicsExposeEventSerial
!
serial: val
    ^self primXGraphicsExposeEventSerial: val
!

"_________________________________________________________"
"send_event primitive accessors"
primXGraphicsExposeEventSendEvent
    <cCall: 'X11_XGraphicsExposeEvent_send_event_get' plugin: 'x11'>
    self primitiveFailed
!
primXGraphicsExposeEventSendEvent: val
    <cCall: 'X11_XGraphicsExposeEvent_send_event_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"send_event accessors"
sendevent
    ^self primXGraphicsExposeEventSendEvent
!
sendevent: val
    ^self primXGraphicsExposeEventSendEvent: val
!

"_________________________________________________________"
"display primitive accessors"
primXGraphicsExposeEventDisplay
    <cCall: 'X11_XGraphicsExposeEvent_display_get' plugin: 'x11'>
    self primitiveFailed
!
primXGraphicsExposeEventDisplay: val
    <cCall: 'X11_XGraphicsExposeEvent_display_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"display accessors"
display
    ^self primXGraphicsExposeEventDisplay
!
display: val
    ^self primXGraphicsExposeEventDisplay: val
!

"_________________________________________________________"
"drawable primitive accessors"
primXGraphicsExposeEventDrawable
    <cCall: 'X11_XGraphicsExposeEvent_drawable_get' plugin: 'x11'>
    self primitiveFailed
!
primXGraphicsExposeEventDrawable: val
    <cCall: 'X11_XGraphicsExposeEvent_drawable_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"drawable accessors"
drawable
    ^self primXGraphicsExposeEventDrawable
!
drawable: val
    ^self primXGraphicsExposeEventDrawable: val
!

"_________________________________________________________"
"x primitive accessors"
primXGraphicsExposeEventX
    <cCall: 'X11_XGraphicsExposeEvent_x_get' plugin: 'x11'>
    self primitiveFailed
!
primXGraphicsExposeEventX: val
    <cCall: 'X11_XGraphicsExposeEvent_x_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"x accessors"
x
    ^self primXGraphicsExposeEventX
!
x: val
    ^self primXGraphicsExposeEventX: val
!

"_________________________________________________________"
"y primitive accessors"
primXGraphicsExposeEventY
    <cCall: 'X11_XGraphicsExposeEvent_y_get' plugin: 'x11'>
    self primitiveFailed
!
primXGraphicsExposeEventY: val
    <cCall: 'X11_XGraphicsExposeEvent_y_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"y accessors"
y
    ^self primXGraphicsExposeEventY
!
y: val
    ^self primXGraphicsExposeEventY: val
!

"_________________________________________________________"
"width primitive accessors"
primXGraphicsExposeEventWidth
    <cCall: 'X11_XGraphicsExposeEvent_width_get' plugin: 'x11'>
    self primitiveFailed
!
primXGraphicsExposeEventWidth: val
    <cCall: 'X11_XGraphicsExposeEvent_width_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"width accessors"
width
    ^self primXGraphicsExposeEventWidth
!
width: val
    ^self primXGraphicsExposeEventWidth: val
!

"_________________________________________________________"
"height primitive accessors"
primXGraphicsExposeEventHeight
    <cCall: 'X11_XGraphicsExposeEvent_height_get' plugin: 'x11'>
    self primitiveFailed
!
primXGraphicsExposeEventHeight: val
    <cCall: 'X11_XGraphicsExposeEvent_height_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"height accessors"
height
    ^self primXGraphicsExposeEventHeight
!
height: val
    ^self primXGraphicsExposeEventHeight: val
!

"_________________________________________________________"
"count primitive accessors"
primXGraphicsExposeEventCount
    <cCall: 'X11_XGraphicsExposeEvent_count_get' plugin: 'x11'>
    self primitiveFailed
!
primXGraphicsExposeEventCount: val
    <cCall: 'X11_XGraphicsExposeEvent_count_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"count accessors"
count
    ^self primXGraphicsExposeEventCount
!
count: val
    ^self primXGraphicsExposeEventCount: val
!

"_________________________________________________________"
"major_code primitive accessors"
primXGraphicsExposeEventMajorCode
    <cCall: 'X11_XGraphicsExposeEvent_major_code_get' plugin: 'x11'>
    self primitiveFailed
!
primXGraphicsExposeEventMajorCode: val
    <cCall: 'X11_XGraphicsExposeEvent_major_code_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"major_code accessors"
majorcode
    ^self primXGraphicsExposeEventMajorCode
!
majorcode: val
    ^self primXGraphicsExposeEventMajorCode: val
!

"_________________________________________________________"
"minor_code primitive accessors"
primXGraphicsExposeEventMinorCode
    <cCall: 'X11_XGraphicsExposeEvent_minor_code_get' plugin: 'x11'>
    self primitiveFailed
!
primXGraphicsExposeEventMinorCode: val
    <cCall: 'X11_XGraphicsExposeEvent_minor_code_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"minor_code accessors"
minorcode
    ^self primXGraphicsExposeEventMinorCode
!
minorcode: val
    ^self primXGraphicsExposeEventMinorCode: val
!






primX11XGraphicsExposeEventDelete
    <cCall: 'X11_delete_XGraphicsExposeEvent' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XGraphicsExposeEventDelete.
!


name
    ^'X11XGraphicsExposeEvent'

! !

!X11XGraphicsExposeEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XGraphicsExposeEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XFontSetExtents
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XFontSetExtents class methodsFor: 'initialize-release'!

primX11XFontSetExtentsCreate
    <cCall: 'X11_new_XFontSetExtents' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XFontSetExtentsCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XFontSetExtents  methodsFor: 'X11'!

"_________________________________________________________"
"max_ink_extent primitive accessors"
primXFontSetExtentsMaxInkExtent
    <cCall: 'X11_XFontSetExtents_max_ink_extent_get' plugin: 'x11'>
    self primitiveFailed
!
primXFontSetExtentsMaxInkExtent: val
    <cCall: 'X11_XFontSetExtents_max_ink_extent_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"max_ink_extent accessors"
maxinkextent
    ^self primXFontSetExtentsMaxInkExtent
!
maxinkextent: val
    ^self primXFontSetExtentsMaxInkExtent: val
!

"_________________________________________________________"
"max_logical_extent primitive accessors"
primXFontSetExtentsMaxLogicalExtent
    <cCall: 'X11_XFontSetExtents_max_logical_extent_get' plugin: 'x11'>
    self primitiveFailed
!
primXFontSetExtentsMaxLogicalExtent: val
    <cCall: 'X11_XFontSetExtents_max_logical_extent_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"max_logical_extent accessors"
maxlogicalextent
    ^self primXFontSetExtentsMaxLogicalExtent
!
maxlogicalextent: val
    ^self primXFontSetExtentsMaxLogicalExtent: val
!






primX11XFontSetExtentsDelete
    <cCall: 'X11_delete_XFontSetExtents' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XFontSetExtentsDelete.
!


name
    ^'X11XFontSetExtents'

! !

!X11XFontSetExtents methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XFontSetExtents methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XResizeRequestEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XResizeRequestEvent class methodsFor: 'initialize-release'!

primX11XResizeRequestEventCreate
    <cCall: 'X11_new_XResizeRequestEvent' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XResizeRequestEventCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XResizeRequestEvent  methodsFor: 'X11'!

"_________________________________________________________"
"type primitive accessors"
primXResizeRequestEventType
    <cCall: 'X11_XResizeRequestEvent_type_get' plugin: 'x11'>
    self primitiveFailed
!
primXResizeRequestEventType: val
    <cCall: 'X11_XResizeRequestEvent_type_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"type accessors"
type
    ^self primXResizeRequestEventType
!
type: val
    ^self primXResizeRequestEventType: val
!

"_________________________________________________________"
"serial primitive accessors"
primXResizeRequestEventSerial
    <cCall: 'X11_XResizeRequestEvent_serial_get' plugin: 'x11'>
    self primitiveFailed
!
primXResizeRequestEventSerial: val
    <cCall: 'X11_XResizeRequestEvent_serial_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"serial accessors"
serial
    ^self primXResizeRequestEventSerial
!
serial: val
    ^self primXResizeRequestEventSerial: val
!

"_________________________________________________________"
"send_event primitive accessors"
primXResizeRequestEventSendEvent
    <cCall: 'X11_XResizeRequestEvent_send_event_get' plugin: 'x11'>
    self primitiveFailed
!
primXResizeRequestEventSendEvent: val
    <cCall: 'X11_XResizeRequestEvent_send_event_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"send_event accessors"
sendevent
    ^self primXResizeRequestEventSendEvent
!
sendevent: val
    ^self primXResizeRequestEventSendEvent: val
!

"_________________________________________________________"
"display primitive accessors"
primXResizeRequestEventDisplay
    <cCall: 'X11_XResizeRequestEvent_display_get' plugin: 'x11'>
    self primitiveFailed
!
primXResizeRequestEventDisplay: val
    <cCall: 'X11_XResizeRequestEvent_display_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"display accessors"
display
    ^self primXResizeRequestEventDisplay
!
display: val
    ^self primXResizeRequestEventDisplay: val
!

"_________________________________________________________"
"window primitive accessors"
primXResizeRequestEventWindow
    <cCall: 'X11_XResizeRequestEvent_window_get' plugin: 'x11'>
    self primitiveFailed
!
primXResizeRequestEventWindow: val
    <cCall: 'X11_XResizeRequestEvent_window_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"window accessors"
window
    ^self primXResizeRequestEventWindow
!
window: val
    ^self primXResizeRequestEventWindow: val
!

"_________________________________________________________"
"width primitive accessors"
primXResizeRequestEventWidth
    <cCall: 'X11_XResizeRequestEvent_width_get' plugin: 'x11'>
    self primitiveFailed
!
primXResizeRequestEventWidth: val
    <cCall: 'X11_XResizeRequestEvent_width_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"width accessors"
width
    ^self primXResizeRequestEventWidth
!
width: val
    ^self primXResizeRequestEventWidth: val
!

"_________________________________________________________"
"height primitive accessors"
primXResizeRequestEventHeight
    <cCall: 'X11_XResizeRequestEvent_height_get' plugin: 'x11'>
    self primitiveFailed
!
primXResizeRequestEventHeight: val
    <cCall: 'X11_XResizeRequestEvent_height_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"height accessors"
height
    ^self primXResizeRequestEventHeight
!
height: val
    ^self primXResizeRequestEventHeight: val
!






primX11XResizeRequestEventDelete
    <cCall: 'X11_delete_XResizeRequestEvent' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XResizeRequestEventDelete.
!


name
    ^'X11XResizeRequestEvent'

! !

!X11XResizeRequestEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XResizeRequestEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XIMStringConversionTextString
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XIMStringConversionTextString class methodsFor: 'initialize-release'!

primX11XIMStringConversionTextStringCreate
    <cCall: 'X11_new_XIMStringConversionText_string' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XIMStringConversionTextStringCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XIMStringConversionTextString  methodsFor: 'X11'!

"_________________________________________________________"
"mbs primitive accessors"
primXIMStringConversionTextStringMbs
    <cCall: 'X11_XIMStringConversionText_string_mbs_get' plugin: 'x11'>
    self primitiveFailed
!
primXIMStringConversionTextStringMbs: val
    <cCall: 'X11_XIMStringConversionText_string_mbs_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"mbs accessors"
mbs
    ^self primXIMStringConversionTextStringMbs
!
mbs: val
    ^self primXIMStringConversionTextStringMbs: val
!

"_________________________________________________________"
"wcs primitive accessors"
primXIMStringConversionTextStringWcs
    <cCall: 'X11_XIMStringConversionText_string_wcs_get' plugin: 'x11'>
    self primitiveFailed
!
primXIMStringConversionTextStringWcs: val
    <cCall: 'X11_XIMStringConversionText_string_wcs_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"wcs accessors"
wcs
    ^self primXIMStringConversionTextStringWcs
!
wcs: val
    ^self primXIMStringConversionTextStringWcs: val
!






primX11XIMStringConversionTextStringDelete
    <cCall: 'X11_delete_XIMStringConversionText_string' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XIMStringConversionTextStringDelete.
!


name
    ^'X11XIMStringConversionTextString'

! !

!X11XIMStringConversionTextString methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XIMStringConversionTextString methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XWindowAttributes
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XWindowAttributes class methodsFor: 'initialize-release'!

primX11XWindowAttributesCreate
    <cCall: 'X11_new_XWindowAttributes' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XWindowAttributesCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XWindowAttributes  methodsFor: 'X11'!

"_________________________________________________________"
"x primitive accessors"
primXWindowAttributesX
    <cCall: 'X11_XWindowAttributes_x_get' plugin: 'x11'>
    self primitiveFailed
!
primXWindowAttributesX: val
    <cCall: 'X11_XWindowAttributes_x_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"x accessors"
x
    ^self primXWindowAttributesX
!
x: val
    ^self primXWindowAttributesX: val
!

"_________________________________________________________"
"y primitive accessors"
primXWindowAttributesY
    <cCall: 'X11_XWindowAttributes_y_get' plugin: 'x11'>
    self primitiveFailed
!
primXWindowAttributesY: val
    <cCall: 'X11_XWindowAttributes_y_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"y accessors"
y
    ^self primXWindowAttributesY
!
y: val
    ^self primXWindowAttributesY: val
!

"_________________________________________________________"
"width primitive accessors"
primXWindowAttributesWidth
    <cCall: 'X11_XWindowAttributes_width_get' plugin: 'x11'>
    self primitiveFailed
!
primXWindowAttributesWidth: val
    <cCall: 'X11_XWindowAttributes_width_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"width accessors"
width
    ^self primXWindowAttributesWidth
!
width: val
    ^self primXWindowAttributesWidth: val
!

"_________________________________________________________"
"height primitive accessors"
primXWindowAttributesHeight
    <cCall: 'X11_XWindowAttributes_height_get' plugin: 'x11'>
    self primitiveFailed
!
primXWindowAttributesHeight: val
    <cCall: 'X11_XWindowAttributes_height_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"height accessors"
height
    ^self primXWindowAttributesHeight
!
height: val
    ^self primXWindowAttributesHeight: val
!

"_________________________________________________________"
"border_width primitive accessors"
primXWindowAttributesBorderWidth
    <cCall: 'X11_XWindowAttributes_border_width_get' plugin: 'x11'>
    self primitiveFailed
!
primXWindowAttributesBorderWidth: val
    <cCall: 'X11_XWindowAttributes_border_width_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"border_width accessors"
borderwidth
    ^self primXWindowAttributesBorderWidth
!
borderwidth: val
    ^self primXWindowAttributesBorderWidth: val
!

"_________________________________________________________"
"depth primitive accessors"
primXWindowAttributesDepth
    <cCall: 'X11_XWindowAttributes_depth_get' plugin: 'x11'>
    self primitiveFailed
!
primXWindowAttributesDepth: val
    <cCall: 'X11_XWindowAttributes_depth_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"depth accessors"
depth
    ^self primXWindowAttributesDepth
!
depth: val
    ^self primXWindowAttributesDepth: val
!

"_________________________________________________________"
"visual primitive accessors"
primXWindowAttributesVisual
    <cCall: 'X11_XWindowAttributes_visual_get' plugin: 'x11'>
    self primitiveFailed
!
primXWindowAttributesVisual: val
    <cCall: 'X11_XWindowAttributes_visual_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"visual accessors"
visual
    ^self primXWindowAttributesVisual
!
visual: val
    ^self primXWindowAttributesVisual: val
!

"_________________________________________________________"
"root primitive accessors"
primXWindowAttributesRoot
    <cCall: 'X11_XWindowAttributes_root_get' plugin: 'x11'>
    self primitiveFailed
!
primXWindowAttributesRoot: val
    <cCall: 'X11_XWindowAttributes_root_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"root accessors"
root
    ^self primXWindowAttributesRoot
!
root: val
    ^self primXWindowAttributesRoot: val
!

"_________________________________________________________"
"class primitive accessors"
primXWindowAttributesClass
    <cCall: 'X11_XWindowAttributes_class_get' plugin: 'x11'>
    self primitiveFailed
!
primXWindowAttributesClass: val
    <cCall: 'X11_XWindowAttributes_class_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"class accessors"
class
    ^self primXWindowAttributesClass
!
class: val
    ^self primXWindowAttributesClass: val
!

"_________________________________________________________"
"bit_gravity primitive accessors"
primXWindowAttributesBitGravity
    <cCall: 'X11_XWindowAttributes_bit_gravity_get' plugin: 'x11'>
    self primitiveFailed
!
primXWindowAttributesBitGravity: val
    <cCall: 'X11_XWindowAttributes_bit_gravity_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"bit_gravity accessors"
bitgravity
    ^self primXWindowAttributesBitGravity
!
bitgravity: val
    ^self primXWindowAttributesBitGravity: val
!

"_________________________________________________________"
"win_gravity primitive accessors"
primXWindowAttributesWinGravity
    <cCall: 'X11_XWindowAttributes_win_gravity_get' plugin: 'x11'>
    self primitiveFailed
!
primXWindowAttributesWinGravity: val
    <cCall: 'X11_XWindowAttributes_win_gravity_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"win_gravity accessors"
wingravity
    ^self primXWindowAttributesWinGravity
!
wingravity: val
    ^self primXWindowAttributesWinGravity: val
!

"_________________________________________________________"
"backing_store primitive accessors"
primXWindowAttributesBackingStore
    <cCall: 'X11_XWindowAttributes_backing_store_get' plugin: 'x11'>
    self primitiveFailed
!
primXWindowAttributesBackingStore: val
    <cCall: 'X11_XWindowAttributes_backing_store_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"backing_store accessors"
backingstore
    ^self primXWindowAttributesBackingStore
!
backingstore: val
    ^self primXWindowAttributesBackingStore: val
!

"_________________________________________________________"
"backing_planes primitive accessors"
primXWindowAttributesBackingPlanes
    <cCall: 'X11_XWindowAttributes_backing_planes_get' plugin: 'x11'>
    self primitiveFailed
!
primXWindowAttributesBackingPlanes: val
    <cCall: 'X11_XWindowAttributes_backing_planes_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"backing_planes accessors"
backingplanes
    ^self primXWindowAttributesBackingPlanes
!
backingplanes: val
    ^self primXWindowAttributesBackingPlanes: val
!

"_________________________________________________________"
"backing_pixel primitive accessors"
primXWindowAttributesBackingPixel
    <cCall: 'X11_XWindowAttributes_backing_pixel_get' plugin: 'x11'>
    self primitiveFailed
!
primXWindowAttributesBackingPixel: val
    <cCall: 'X11_XWindowAttributes_backing_pixel_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"backing_pixel accessors"
backingpixel
    ^self primXWindowAttributesBackingPixel
!
backingpixel: val
    ^self primXWindowAttributesBackingPixel: val
!

"_________________________________________________________"
"save_under primitive accessors"
primXWindowAttributesSaveUnder
    <cCall: 'X11_XWindowAttributes_save_under_get' plugin: 'x11'>
    self primitiveFailed
!
primXWindowAttributesSaveUnder: val
    <cCall: 'X11_XWindowAttributes_save_under_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"save_under accessors"
saveunder
    ^self primXWindowAttributesSaveUnder
!
saveunder: val
    ^self primXWindowAttributesSaveUnder: val
!

"_________________________________________________________"
"colormap primitive accessors"
primXWindowAttributesColormap
    <cCall: 'X11_XWindowAttributes_colormap_get' plugin: 'x11'>
    self primitiveFailed
!
primXWindowAttributesColormap: val
    <cCall: 'X11_XWindowAttributes_colormap_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"colormap accessors"
colormap
    ^self primXWindowAttributesColormap
!
colormap: val
    ^self primXWindowAttributesColormap: val
!

"_________________________________________________________"
"map_installed primitive accessors"
primXWindowAttributesMapInstalled
    <cCall: 'X11_XWindowAttributes_map_installed_get' plugin: 'x11'>
    self primitiveFailed
!
primXWindowAttributesMapInstalled: val
    <cCall: 'X11_XWindowAttributes_map_installed_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"map_installed accessors"
mapinstalled
    ^self primXWindowAttributesMapInstalled
!
mapinstalled: val
    ^self primXWindowAttributesMapInstalled: val
!

"_________________________________________________________"
"map_state primitive accessors"
primXWindowAttributesMapState
    <cCall: 'X11_XWindowAttributes_map_state_get' plugin: 'x11'>
    self primitiveFailed
!
primXWindowAttributesMapState: val
    <cCall: 'X11_XWindowAttributes_map_state_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"map_state accessors"
mapstate
    ^self primXWindowAttributesMapState
!
mapstate: val
    ^self primXWindowAttributesMapState: val
!

"_________________________________________________________"
"all_event_masks primitive accessors"
primXWindowAttributesAllEventMasks
    <cCall: 'X11_XWindowAttributes_all_event_masks_get' plugin: 'x11'>
    self primitiveFailed
!
primXWindowAttributesAllEventMasks: val
    <cCall: 'X11_XWindowAttributes_all_event_masks_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"all_event_masks accessors"
alleventmasks
    ^self primXWindowAttributesAllEventMasks
!
alleventmasks: val
    ^self primXWindowAttributesAllEventMasks: val
!

"_________________________________________________________"
"your_event_mask primitive accessors"
primXWindowAttributesYourEventMask
    <cCall: 'X11_XWindowAttributes_your_event_mask_get' plugin: 'x11'>
    self primitiveFailed
!
primXWindowAttributesYourEventMask: val
    <cCall: 'X11_XWindowAttributes_your_event_mask_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"your_event_mask accessors"
youreventmask
    ^self primXWindowAttributesYourEventMask
!
youreventmask: val
    ^self primXWindowAttributesYourEventMask: val
!

"_________________________________________________________"
"do_not_propagate_mask primitive accessors"
primXWindowAttributesDoNotPropagateMask
    <cCall: 'X11_XWindowAttributes_do_not_propagate_mask_get' plugin: 'x11'>
    self primitiveFailed
!
primXWindowAttributesDoNotPropagateMask: val
    <cCall: 'X11_XWindowAttributes_do_not_propagate_mask_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"do_not_propagate_mask accessors"
donotpropagatemask
    ^self primXWindowAttributesDoNotPropagateMask
!
donotpropagatemask: val
    ^self primXWindowAttributesDoNotPropagateMask: val
!

"_________________________________________________________"
"override_redirect primitive accessors"
primXWindowAttributesOverrideRedirect
    <cCall: 'X11_XWindowAttributes_override_redirect_get' plugin: 'x11'>
    self primitiveFailed
!
primXWindowAttributesOverrideRedirect: val
    <cCall: 'X11_XWindowAttributes_override_redirect_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"override_redirect accessors"
overrideredirect
    ^self primXWindowAttributesOverrideRedirect
!
overrideredirect: val
    ^self primXWindowAttributesOverrideRedirect: val
!

"_________________________________________________________"
"screen primitive accessors"
primXWindowAttributesScreen
    <cCall: 'X11_XWindowAttributes_screen_get' plugin: 'x11'>
    self primitiveFailed
!
primXWindowAttributesScreen: val
    <cCall: 'X11_XWindowAttributes_screen_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"screen accessors"
screen
    ^self primXWindowAttributesScreen
!
screen: val
    ^self primXWindowAttributesScreen: val
!






primX11XWindowAttributesDelete
    <cCall: 'X11_delete_XWindowAttributes' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XWindowAttributesDelete.
!


name
    ^'X11XWindowAttributes'

! !

!X11XWindowAttributes methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XWindowAttributes methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XMappingEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XMappingEvent class methodsFor: 'initialize-release'!

primX11XMappingEventCreate
    <cCall: 'X11_new_XMappingEvent' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XMappingEventCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XMappingEvent  methodsFor: 'X11'!

"_________________________________________________________"
"type primitive accessors"
primXMappingEventType
    <cCall: 'X11_XMappingEvent_type_get' plugin: 'x11'>
    self primitiveFailed
!
primXMappingEventType: val
    <cCall: 'X11_XMappingEvent_type_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"type accessors"
type
    ^self primXMappingEventType
!
type: val
    ^self primXMappingEventType: val
!

"_________________________________________________________"
"serial primitive accessors"
primXMappingEventSerial
    <cCall: 'X11_XMappingEvent_serial_get' plugin: 'x11'>
    self primitiveFailed
!
primXMappingEventSerial: val
    <cCall: 'X11_XMappingEvent_serial_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"serial accessors"
serial
    ^self primXMappingEventSerial
!
serial: val
    ^self primXMappingEventSerial: val
!

"_________________________________________________________"
"send_event primitive accessors"
primXMappingEventSendEvent
    <cCall: 'X11_XMappingEvent_send_event_get' plugin: 'x11'>
    self primitiveFailed
!
primXMappingEventSendEvent: val
    <cCall: 'X11_XMappingEvent_send_event_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"send_event accessors"
sendevent
    ^self primXMappingEventSendEvent
!
sendevent: val
    ^self primXMappingEventSendEvent: val
!

"_________________________________________________________"
"display primitive accessors"
primXMappingEventDisplay
    <cCall: 'X11_XMappingEvent_display_get' plugin: 'x11'>
    self primitiveFailed
!
primXMappingEventDisplay: val
    <cCall: 'X11_XMappingEvent_display_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"display accessors"
display
    ^self primXMappingEventDisplay
!
display: val
    ^self primXMappingEventDisplay: val
!

"_________________________________________________________"
"window primitive accessors"
primXMappingEventWindow
    <cCall: 'X11_XMappingEvent_window_get' plugin: 'x11'>
    self primitiveFailed
!
primXMappingEventWindow: val
    <cCall: 'X11_XMappingEvent_window_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"window accessors"
window
    ^self primXMappingEventWindow
!
window: val
    ^self primXMappingEventWindow: val
!

"_________________________________________________________"
"request primitive accessors"
primXMappingEventRequest
    <cCall: 'X11_XMappingEvent_request_get' plugin: 'x11'>
    self primitiveFailed
!
primXMappingEventRequest: val
    <cCall: 'X11_XMappingEvent_request_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"request accessors"
request
    ^self primXMappingEventRequest
!
request: val
    ^self primXMappingEventRequest: val
!

"_________________________________________________________"
"first_keycode primitive accessors"
primXMappingEventFirstKeycode
    <cCall: 'X11_XMappingEvent_first_keycode_get' plugin: 'x11'>
    self primitiveFailed
!
primXMappingEventFirstKeycode: val
    <cCall: 'X11_XMappingEvent_first_keycode_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"first_keycode accessors"
firstkeycode
    ^self primXMappingEventFirstKeycode
!
firstkeycode: val
    ^self primXMappingEventFirstKeycode: val
!

"_________________________________________________________"
"count primitive accessors"
primXMappingEventCount
    <cCall: 'X11_XMappingEvent_count_get' plugin: 'x11'>
    self primitiveFailed
!
primXMappingEventCount: val
    <cCall: 'X11_XMappingEvent_count_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"count accessors"
count
    ^self primXMappingEventCount
!
count: val
    ^self primXMappingEventCount: val
!



"_________________________________________________________"
"XRefreshKeyboardMapping primitive function"
primXRefreshKeyboardMapping
    <cCall: 'X11_XRefreshKeyboardMapping' plugin: 'x11'>
    self primitiveFailed
!




primX11XMappingEventDelete
    <cCall: 'X11_delete_XMappingEvent' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XMappingEventDelete.
!


name
    ^'X11XMappingEvent'

! !

!X11XMappingEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XMappingEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XIMStringConversionCallbackStruct
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XIMStringConversionCallbackStruct class methodsFor: 'initialize-release'!

primX11XIMStringConversionCallbackStructCreate
    <cCall: 'X11_new_XIMStringConversionCallbackStruct' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XIMStringConversionCallbackStructCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XIMStringConversionCallbackStruct  methodsFor: 'X11'!

"_________________________________________________________"
"position primitive accessors"
primXIMStringConversionCallbackStructPosition
    <cCall: 'X11_XIMStringConversionCallbackStruct_position_get' plugin: 'x11'>
    self primitiveFailed
!
primXIMStringConversionCallbackStructPosition: val
    <cCall: 'X11_XIMStringConversionCallbackStruct_position_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"position accessors"
position
    ^self primXIMStringConversionCallbackStructPosition
!
position: val
    ^self primXIMStringConversionCallbackStructPosition: val
!

"_________________________________________________________"
"direction primitive accessors"
primXIMStringConversionCallbackStructDirection
    <cCall: 'X11_XIMStringConversionCallbackStruct_direction_get' plugin: 'x11'>
    self primitiveFailed
!
primXIMStringConversionCallbackStructDirection: val
    <cCall: 'X11_XIMStringConversionCallbackStruct_direction_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"direction accessors"
direction
    ^self primXIMStringConversionCallbackStructDirection
!
direction: val
    ^self primXIMStringConversionCallbackStructDirection: val
!

"_________________________________________________________"
"operation primitive accessors"
primXIMStringConversionCallbackStructOperation
    <cCall: 'X11_XIMStringConversionCallbackStruct_operation_get' plugin: 'x11'>
    self primitiveFailed
!
primXIMStringConversionCallbackStructOperation: val
    <cCall: 'X11_XIMStringConversionCallbackStruct_operation_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"operation accessors"
operation
    ^self primXIMStringConversionCallbackStructOperation
!
operation: val
    ^self primXIMStringConversionCallbackStructOperation: val
!

"_________________________________________________________"
"factor primitive accessors"
primXIMStringConversionCallbackStructFactor
    <cCall: 'X11_XIMStringConversionCallbackStruct_factor_get' plugin: 'x11'>
    self primitiveFailed
!
primXIMStringConversionCallbackStructFactor: val
    <cCall: 'X11_XIMStringConversionCallbackStruct_factor_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"factor accessors"
factor
    ^self primXIMStringConversionCallbackStructFactor
!
factor: val
    ^self primXIMStringConversionCallbackStructFactor: val
!

"_________________________________________________________"
"text primitive accessors"
primXIMStringConversionCallbackStructText
    <cCall: 'X11_XIMStringConversionCallbackStruct_text_get' plugin: 'x11'>
    self primitiveFailed
!
primXIMStringConversionCallbackStructText: val
    <cCall: 'X11_XIMStringConversionCallbackStruct_text_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"text accessors"
text
    ^self primXIMStringConversionCallbackStructText
!
text: val
    ^self primXIMStringConversionCallbackStructText: val
!






primX11XIMStringConversionCallbackStructDelete
    <cCall: 'X11_delete_XIMStringConversionCallbackStruct' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XIMStringConversionCallbackStructDelete.
!


name
    ^'X11XIMStringConversionCallbackStruct'

! !

!X11XIMStringConversionCallbackStruct methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XIMStringConversionCallbackStruct methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XOMOrientation
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XOMOrientation class methodsFor: 'initialize-release'!

primX11XOMOrientationCreate
    <cCall: 'X11_new_XOMOrientation' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XOMOrientationCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XOMOrientation  methodsFor: 'X11'!

"_________________________________________________________"
"num_orientation primitive accessors"
primXOMOrientationNumOrientation
    <cCall: 'X11_XOMOrientation_num_orientation_get' plugin: 'x11'>
    self primitiveFailed
!
primXOMOrientationNumOrientation: val
    <cCall: 'X11_XOMOrientation_num_orientation_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"num_orientation accessors"
numorientation
    ^self primXOMOrientationNumOrientation
!
numorientation: val
    ^self primXOMOrientationNumOrientation: val
!

"_________________________________________________________"
"orientation primitive accessors"
primXOMOrientationOrientation
    <cCall: 'X11_XOMOrientation_orientation_get' plugin: 'x11'>
    self primitiveFailed
!
primXOMOrientationOrientation: val
    <cCall: 'X11_XOMOrientation_orientation_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"orientation accessors"
orientation
    ^self primXOMOrientationOrientation
!
orientation: val
    ^self primXOMOrientationOrientation: val
!






primX11XOMOrientationDelete
    <cCall: 'X11_delete_XOMOrientation' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XOMOrientationDelete.
!


name
    ^'X11XOMOrientation'

! !

!X11XOMOrientation methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XOMOrientation methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XWindowChanges
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XWindowChanges class methodsFor: 'initialize-release'!

primX11XWindowChangesCreate
    <cCall: 'X11_new_XWindowChanges' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XWindowChangesCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XWindowChanges  methodsFor: 'X11'!

"_________________________________________________________"
"x primitive accessors"
primXWindowChangesX
    <cCall: 'X11_XWindowChanges_x_get' plugin: 'x11'>
    self primitiveFailed
!
primXWindowChangesX: val
    <cCall: 'X11_XWindowChanges_x_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"x accessors"
x
    ^self primXWindowChangesX
!
x: val
    ^self primXWindowChangesX: val
!

"_________________________________________________________"
"y primitive accessors"
primXWindowChangesY
    <cCall: 'X11_XWindowChanges_y_get' plugin: 'x11'>
    self primitiveFailed
!
primXWindowChangesY: val
    <cCall: 'X11_XWindowChanges_y_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"y accessors"
y
    ^self primXWindowChangesY
!
y: val
    ^self primXWindowChangesY: val
!

"_________________________________________________________"
"width primitive accessors"
primXWindowChangesWidth
    <cCall: 'X11_XWindowChanges_width_get' plugin: 'x11'>
    self primitiveFailed
!
primXWindowChangesWidth: val
    <cCall: 'X11_XWindowChanges_width_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"width accessors"
width
    ^self primXWindowChangesWidth
!
width: val
    ^self primXWindowChangesWidth: val
!

"_________________________________________________________"
"height primitive accessors"
primXWindowChangesHeight
    <cCall: 'X11_XWindowChanges_height_get' plugin: 'x11'>
    self primitiveFailed
!
primXWindowChangesHeight: val
    <cCall: 'X11_XWindowChanges_height_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"height accessors"
height
    ^self primXWindowChangesHeight
!
height: val
    ^self primXWindowChangesHeight: val
!

"_________________________________________________________"
"border_width primitive accessors"
primXWindowChangesBorderWidth
    <cCall: 'X11_XWindowChanges_border_width_get' plugin: 'x11'>
    self primitiveFailed
!
primXWindowChangesBorderWidth: val
    <cCall: 'X11_XWindowChanges_border_width_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"border_width accessors"
borderwidth
    ^self primXWindowChangesBorderWidth
!
borderwidth: val
    ^self primXWindowChangesBorderWidth: val
!

"_________________________________________________________"
"sibling primitive accessors"
primXWindowChangesSibling
    <cCall: 'X11_XWindowChanges_sibling_get' plugin: 'x11'>
    self primitiveFailed
!
primXWindowChangesSibling: val
    <cCall: 'X11_XWindowChanges_sibling_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"sibling accessors"
sibling
    ^self primXWindowChangesSibling
!
sibling: val
    ^self primXWindowChangesSibling: val
!

"_________________________________________________________"
"stack_mode primitive accessors"
primXWindowChangesStackMode
    <cCall: 'X11_XWindowChanges_stack_mode_get' plugin: 'x11'>
    self primitiveFailed
!
primXWindowChangesStackMode: val
    <cCall: 'X11_XWindowChanges_stack_mode_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"stack_mode accessors"
stackmode
    ^self primXWindowChangesStackMode
!
stackmode: val
    ^self primXWindowChangesStackMode: val
!






primX11XWindowChangesDelete
    <cCall: 'X11_delete_XWindowChanges' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XWindowChangesDelete.
!


name
    ^'X11XWindowChanges'

! !

!X11XWindowChanges methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XWindowChanges methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XClientMessageEventData
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XClientMessageEventData class methodsFor: 'initialize-release'!

primX11XClientMessageEventDataCreate
    <cCall: 'X11_new_XClientMessageEvent_data' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XClientMessageEventDataCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XClientMessageEventData  methodsFor: 'X11'!

"_________________________________________________________"
"b primitive accessors"
primXClientMessageEventDataB
    <cCall: 'X11_XClientMessageEvent_data_b_get' plugin: 'x11'>
    self primitiveFailed
!
primXClientMessageEventDataB: val
    <cCall: 'X11_XClientMessageEvent_data_b_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"b accessors"
b
    ^self primXClientMessageEventDataB
!
b: val
    ^self primXClientMessageEventDataB: val
!

"_________________________________________________________"
"s primitive accessors"
primXClientMessageEventDataS
    <cCall: 'X11_XClientMessageEvent_data_s_get' plugin: 'x11'>
    self primitiveFailed
!
primXClientMessageEventDataS: val
    <cCall: 'X11_XClientMessageEvent_data_s_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"s accessors"
s
    ^self primXClientMessageEventDataS
!
s: val
    ^self primXClientMessageEventDataS: val
!

"_________________________________________________________"
"l primitive accessors"
primXClientMessageEventDataL
    <cCall: 'X11_XClientMessageEvent_data_l_get' plugin: 'x11'>
    self primitiveFailed
!
primXClientMessageEventDataL: val
    <cCall: 'X11_XClientMessageEvent_data_l_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"l accessors"
l
    ^self primXClientMessageEventDataL
!
l: val
    ^self primXClientMessageEventDataL: val
!






primX11XClientMessageEventDataDelete
    <cCall: 'X11_delete_XClientMessageEvent_data' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XClientMessageEventDataDelete.
!


name
    ^'X11XClientMessageEventData'

! !

!X11XClientMessageEventData methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XClientMessageEventData methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XExtCodes
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XExtCodes class methodsFor: 'initialize-release'!

primX11XExtCodesCreate
    <cCall: 'X11_new_XExtCodes' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XExtCodesCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XExtCodes  methodsFor: 'X11'!

"_________________________________________________________"
"extension primitive accessors"
primXExtCodesExtension
    <cCall: 'X11_XExtCodes_extension_get' plugin: 'x11'>
    self primitiveFailed
!
primXExtCodesExtension: val
    <cCall: 'X11_XExtCodes_extension_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"extension accessors"
extension
    ^self primXExtCodesExtension
!
extension: val
    ^self primXExtCodesExtension: val
!

"_________________________________________________________"
"major_opcode primitive accessors"
primXExtCodesMajorOpcode
    <cCall: 'X11_XExtCodes_major_opcode_get' plugin: 'x11'>
    self primitiveFailed
!
primXExtCodesMajorOpcode: val
    <cCall: 'X11_XExtCodes_major_opcode_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"major_opcode accessors"
majoropcode
    ^self primXExtCodesMajorOpcode
!
majoropcode: val
    ^self primXExtCodesMajorOpcode: val
!

"_________________________________________________________"
"first_event primitive accessors"
primXExtCodesFirstEvent
    <cCall: 'X11_XExtCodes_first_event_get' plugin: 'x11'>
    self primitiveFailed
!
primXExtCodesFirstEvent: val
    <cCall: 'X11_XExtCodes_first_event_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"first_event accessors"
firstevent
    ^self primXExtCodesFirstEvent
!
firstevent: val
    ^self primXExtCodesFirstEvent: val
!

"_________________________________________________________"
"first_error primitive accessors"
primXExtCodesFirstError
    <cCall: 'X11_XExtCodes_first_error_get' plugin: 'x11'>
    self primitiveFailed
!
primXExtCodesFirstError: val
    <cCall: 'X11_XExtCodes_first_error_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"first_error accessors"
firsterror
    ^self primXExtCodesFirstError
!
firsterror: val
    ^self primXExtCodesFirstError: val
!






primX11XExtCodesDelete
    <cCall: 'X11_delete_XExtCodes' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XExtCodesDelete.
!


name
    ^'X11XExtCodes'

! !

!X11XExtCodes methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XExtCodes methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XGCValues
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XGCValues class methodsFor: 'initialize-release'!

primX11XGCValuesCreate
    <cCall: 'X11_new_XGCValues' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XGCValuesCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XGCValues  methodsFor: 'X11'!

"_________________________________________________________"
"function primitive accessors"
primXGCValuesFunction
    <cCall: 'X11_XGCValues_function_get' plugin: 'x11'>
    self primitiveFailed
!
primXGCValuesFunction: val
    <cCall: 'X11_XGCValues_function_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"function accessors"
function
    ^self primXGCValuesFunction
!
function: val
    ^self primXGCValuesFunction: val
!

"_________________________________________________________"
"plane_mask primitive accessors"
primXGCValuesPlaneMask
    <cCall: 'X11_XGCValues_plane_mask_get' plugin: 'x11'>
    self primitiveFailed
!
primXGCValuesPlaneMask: val
    <cCall: 'X11_XGCValues_plane_mask_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"plane_mask accessors"
planemask
    ^self primXGCValuesPlaneMask
!
planemask: val
    ^self primXGCValuesPlaneMask: val
!

"_________________________________________________________"
"foreground primitive accessors"
primXGCValuesForeground
    <cCall: 'X11_XGCValues_foreground_get' plugin: 'x11'>
    self primitiveFailed
!
primXGCValuesForeground: val
    <cCall: 'X11_XGCValues_foreground_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"foreground accessors"
foreground
    ^self primXGCValuesForeground
!
foreground: val
    ^self primXGCValuesForeground: val
!

"_________________________________________________________"
"background primitive accessors"
primXGCValuesBackground
    <cCall: 'X11_XGCValues_background_get' plugin: 'x11'>
    self primitiveFailed
!
primXGCValuesBackground: val
    <cCall: 'X11_XGCValues_background_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"background accessors"
background
    ^self primXGCValuesBackground
!
background: val
    ^self primXGCValuesBackground: val
!

"_________________________________________________________"
"line_width primitive accessors"
primXGCValuesLineWidth
    <cCall: 'X11_XGCValues_line_width_get' plugin: 'x11'>
    self primitiveFailed
!
primXGCValuesLineWidth: val
    <cCall: 'X11_XGCValues_line_width_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"line_width accessors"
linewidth
    ^self primXGCValuesLineWidth
!
linewidth: val
    ^self primXGCValuesLineWidth: val
!

"_________________________________________________________"
"line_style primitive accessors"
primXGCValuesLineStyle
    <cCall: 'X11_XGCValues_line_style_get' plugin: 'x11'>
    self primitiveFailed
!
primXGCValuesLineStyle: val
    <cCall: 'X11_XGCValues_line_style_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"line_style accessors"
linestyle
    ^self primXGCValuesLineStyle
!
linestyle: val
    ^self primXGCValuesLineStyle: val
!

"_________________________________________________________"
"cap_style primitive accessors"
primXGCValuesCapStyle
    <cCall: 'X11_XGCValues_cap_style_get' plugin: 'x11'>
    self primitiveFailed
!
primXGCValuesCapStyle: val
    <cCall: 'X11_XGCValues_cap_style_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"cap_style accessors"
capstyle
    ^self primXGCValuesCapStyle
!
capstyle: val
    ^self primXGCValuesCapStyle: val
!

"_________________________________________________________"
"join_style primitive accessors"
primXGCValuesJoinStyle
    <cCall: 'X11_XGCValues_join_style_get' plugin: 'x11'>
    self primitiveFailed
!
primXGCValuesJoinStyle: val
    <cCall: 'X11_XGCValues_join_style_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"join_style accessors"
joinstyle
    ^self primXGCValuesJoinStyle
!
joinstyle: val
    ^self primXGCValuesJoinStyle: val
!

"_________________________________________________________"
"fill_style primitive accessors"
primXGCValuesFillStyle
    <cCall: 'X11_XGCValues_fill_style_get' plugin: 'x11'>
    self primitiveFailed
!
primXGCValuesFillStyle: val
    <cCall: 'X11_XGCValues_fill_style_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"fill_style accessors"
fillstyle
    ^self primXGCValuesFillStyle
!
fillstyle: val
    ^self primXGCValuesFillStyle: val
!

"_________________________________________________________"
"fill_rule primitive accessors"
primXGCValuesFillRule
    <cCall: 'X11_XGCValues_fill_rule_get' plugin: 'x11'>
    self primitiveFailed
!
primXGCValuesFillRule: val
    <cCall: 'X11_XGCValues_fill_rule_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"fill_rule accessors"
fillrule
    ^self primXGCValuesFillRule
!
fillrule: val
    ^self primXGCValuesFillRule: val
!

"_________________________________________________________"
"arc_mode primitive accessors"
primXGCValuesArcMode
    <cCall: 'X11_XGCValues_arc_mode_get' plugin: 'x11'>
    self primitiveFailed
!
primXGCValuesArcMode: val
    <cCall: 'X11_XGCValues_arc_mode_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"arc_mode accessors"
arcmode
    ^self primXGCValuesArcMode
!
arcmode: val
    ^self primXGCValuesArcMode: val
!

"_________________________________________________________"
"tile primitive accessors"
primXGCValuesTile
    <cCall: 'X11_XGCValues_tile_get' plugin: 'x11'>
    self primitiveFailed
!
primXGCValuesTile: val
    <cCall: 'X11_XGCValues_tile_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"tile accessors"
tile
    ^self primXGCValuesTile
!
tile: val
    ^self primXGCValuesTile: val
!

"_________________________________________________________"
"stipple primitive accessors"
primXGCValuesStipple
    <cCall: 'X11_XGCValues_stipple_get' plugin: 'x11'>
    self primitiveFailed
!
primXGCValuesStipple: val
    <cCall: 'X11_XGCValues_stipple_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"stipple accessors"
stipple
    ^self primXGCValuesStipple
!
stipple: val
    ^self primXGCValuesStipple: val
!

"_________________________________________________________"
"ts_x_origin primitive accessors"
primXGCValuesTsXOrigin
    <cCall: 'X11_XGCValues_ts_x_origin_get' plugin: 'x11'>
    self primitiveFailed
!
primXGCValuesTsXOrigin: val
    <cCall: 'X11_XGCValues_ts_x_origin_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"ts_x_origin accessors"
tsxorigin
    ^self primXGCValuesTsXOrigin
!
tsxorigin: val
    ^self primXGCValuesTsXOrigin: val
!

"_________________________________________________________"
"ts_y_origin primitive accessors"
primXGCValuesTsYOrigin
    <cCall: 'X11_XGCValues_ts_y_origin_get' plugin: 'x11'>
    self primitiveFailed
!
primXGCValuesTsYOrigin: val
    <cCall: 'X11_XGCValues_ts_y_origin_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"ts_y_origin accessors"
tsyorigin
    ^self primXGCValuesTsYOrigin
!
tsyorigin: val
    ^self primXGCValuesTsYOrigin: val
!

"_________________________________________________________"
"font primitive accessors"
primXGCValuesFont
    <cCall: 'X11_XGCValues_font_get' plugin: 'x11'>
    self primitiveFailed
!
primXGCValuesFont: val
    <cCall: 'X11_XGCValues_font_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"font accessors"
font
    ^self primXGCValuesFont
!
font: val
    ^self primXGCValuesFont: val
!

"_________________________________________________________"
"subwindow_mode primitive accessors"
primXGCValuesSubwindowMode
    <cCall: 'X11_XGCValues_subwindow_mode_get' plugin: 'x11'>
    self primitiveFailed
!
primXGCValuesSubwindowMode: val
    <cCall: 'X11_XGCValues_subwindow_mode_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"subwindow_mode accessors"
subwindowmode
    ^self primXGCValuesSubwindowMode
!
subwindowmode: val
    ^self primXGCValuesSubwindowMode: val
!

"_________________________________________________________"
"graphics_exposures primitive accessors"
primXGCValuesGraphicsExposures
    <cCall: 'X11_XGCValues_graphics_exposures_get' plugin: 'x11'>
    self primitiveFailed
!
primXGCValuesGraphicsExposures: val
    <cCall: 'X11_XGCValues_graphics_exposures_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"graphics_exposures accessors"
graphicsexposures
    ^self primXGCValuesGraphicsExposures
!
graphicsexposures: val
    ^self primXGCValuesGraphicsExposures: val
!

"_________________________________________________________"
"clip_x_origin primitive accessors"
primXGCValuesClipXOrigin
    <cCall: 'X11_XGCValues_clip_x_origin_get' plugin: 'x11'>
    self primitiveFailed
!
primXGCValuesClipXOrigin: val
    <cCall: 'X11_XGCValues_clip_x_origin_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"clip_x_origin accessors"
clipxorigin
    ^self primXGCValuesClipXOrigin
!
clipxorigin: val
    ^self primXGCValuesClipXOrigin: val
!

"_________________________________________________________"
"clip_y_origin primitive accessors"
primXGCValuesClipYOrigin
    <cCall: 'X11_XGCValues_clip_y_origin_get' plugin: 'x11'>
    self primitiveFailed
!
primXGCValuesClipYOrigin: val
    <cCall: 'X11_XGCValues_clip_y_origin_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"clip_y_origin accessors"
clipyorigin
    ^self primXGCValuesClipYOrigin
!
clipyorigin: val
    ^self primXGCValuesClipYOrigin: val
!

"_________________________________________________________"
"clip_mask primitive accessors"
primXGCValuesClipMask
    <cCall: 'X11_XGCValues_clip_mask_get' plugin: 'x11'>
    self primitiveFailed
!
primXGCValuesClipMask: val
    <cCall: 'X11_XGCValues_clip_mask_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"clip_mask accessors"
clipmask
    ^self primXGCValuesClipMask
!
clipmask: val
    ^self primXGCValuesClipMask: val
!

"_________________________________________________________"
"dash_offset primitive accessors"
primXGCValuesDashOffset
    <cCall: 'X11_XGCValues_dash_offset_get' plugin: 'x11'>
    self primitiveFailed
!
primXGCValuesDashOffset: val
    <cCall: 'X11_XGCValues_dash_offset_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"dash_offset accessors"
dashoffset
    ^self primXGCValuesDashOffset
!
dashoffset: val
    ^self primXGCValuesDashOffset: val
!

"_________________________________________________________"
"dashes primitive accessors"
primXGCValuesDashes
    <cCall: 'X11_XGCValues_dashes_get' plugin: 'x11'>
    self primitiveFailed
!
primXGCValuesDashes: val
    <cCall: 'X11_XGCValues_dashes_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"dashes accessors"
dashes
    ^self primXGCValuesDashes
!
dashes: val
    ^self primXGCValuesDashes: val
!






primX11XGCValuesDelete
    <cCall: 'X11_delete_XGCValues' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XGCValuesDelete.
!


name
    ^'X11XGCValues'

! !

!X11XGCValues methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XGCValues methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XOC
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XOC class methodsFor: 'initialize-release'!

primX11XOCCreate
    <cCall: 'X11_new_XOC' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XOCCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XOC  methodsFor: 'X11'!



"_________________________________________________________"
"XDestroyOC primitive function"
primXDestroyOC
    <cCall: 'X11_XDestroyOC' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XOMOfOC primitive function"
primXOMOfOC
    <cCall: 'X11_XOMOfOC' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XSetOCValues primitive function"
primXSetOCValues
    <cCall: 'X11_XSetOCValues' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XGetOCValues primitive function"
primXGetOCValues
    <cCall: 'X11_XGetOCValues' plugin: 'x11'>
    self primitiveFailed
!




primX11XOCDelete
    <cCall: 'X11_delete_XOC' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XOCDelete.
!


name
    ^'X11XOC'

! !

!X11XOC methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XOC methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XFocusChangeEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XFocusChangeEvent class methodsFor: 'initialize-release'!

primX11XFocusChangeEventCreate
    <cCall: 'X11_new_XFocusChangeEvent' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XFocusChangeEventCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XFocusChangeEvent  methodsFor: 'X11'!

"_________________________________________________________"
"type primitive accessors"
primXFocusChangeEventType
    <cCall: 'X11_XFocusChangeEvent_type_get' plugin: 'x11'>
    self primitiveFailed
!
primXFocusChangeEventType: val
    <cCall: 'X11_XFocusChangeEvent_type_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"type accessors"
type
    ^self primXFocusChangeEventType
!
type: val
    ^self primXFocusChangeEventType: val
!

"_________________________________________________________"
"serial primitive accessors"
primXFocusChangeEventSerial
    <cCall: 'X11_XFocusChangeEvent_serial_get' plugin: 'x11'>
    self primitiveFailed
!
primXFocusChangeEventSerial: val
    <cCall: 'X11_XFocusChangeEvent_serial_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"serial accessors"
serial
    ^self primXFocusChangeEventSerial
!
serial: val
    ^self primXFocusChangeEventSerial: val
!

"_________________________________________________________"
"send_event primitive accessors"
primXFocusChangeEventSendEvent
    <cCall: 'X11_XFocusChangeEvent_send_event_get' plugin: 'x11'>
    self primitiveFailed
!
primXFocusChangeEventSendEvent: val
    <cCall: 'X11_XFocusChangeEvent_send_event_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"send_event accessors"
sendevent
    ^self primXFocusChangeEventSendEvent
!
sendevent: val
    ^self primXFocusChangeEventSendEvent: val
!

"_________________________________________________________"
"display primitive accessors"
primXFocusChangeEventDisplay
    <cCall: 'X11_XFocusChangeEvent_display_get' plugin: 'x11'>
    self primitiveFailed
!
primXFocusChangeEventDisplay: val
    <cCall: 'X11_XFocusChangeEvent_display_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"display accessors"
display
    ^self primXFocusChangeEventDisplay
!
display: val
    ^self primXFocusChangeEventDisplay: val
!

"_________________________________________________________"
"window primitive accessors"
primXFocusChangeEventWindow
    <cCall: 'X11_XFocusChangeEvent_window_get' plugin: 'x11'>
    self primitiveFailed
!
primXFocusChangeEventWindow: val
    <cCall: 'X11_XFocusChangeEvent_window_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"window accessors"
window
    ^self primXFocusChangeEventWindow
!
window: val
    ^self primXFocusChangeEventWindow: val
!

"_________________________________________________________"
"mode primitive accessors"
primXFocusChangeEventMode
    <cCall: 'X11_XFocusChangeEvent_mode_get' plugin: 'x11'>
    self primitiveFailed
!
primXFocusChangeEventMode: val
    <cCall: 'X11_XFocusChangeEvent_mode_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"mode accessors"
mode
    ^self primXFocusChangeEventMode
!
mode: val
    ^self primXFocusChangeEventMode: val
!

"_________________________________________________________"
"detail primitive accessors"
primXFocusChangeEventDetail
    <cCall: 'X11_XFocusChangeEvent_detail_get' plugin: 'x11'>
    self primitiveFailed
!
primXFocusChangeEventDetail: val
    <cCall: 'X11_XFocusChangeEvent_detail_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"detail accessors"
detail
    ^self primXFocusChangeEventDetail
!
detail: val
    ^self primXFocusChangeEventDetail: val
!






primX11XFocusChangeEventDelete
    <cCall: 'X11_delete_XFocusChangeEvent' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XFocusChangeEventDelete.
!


name
    ^'X11XFocusChangeEvent'

! !

!X11XFocusChangeEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XFocusChangeEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XConfigureRequestEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XConfigureRequestEvent class methodsFor: 'initialize-release'!

primX11XConfigureRequestEventCreate
    <cCall: 'X11_new_XConfigureRequestEvent' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XConfigureRequestEventCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XConfigureRequestEvent  methodsFor: 'X11'!

"_________________________________________________________"
"type primitive accessors"
primXConfigureRequestEventType
    <cCall: 'X11_XConfigureRequestEvent_type_get' plugin: 'x11'>
    self primitiveFailed
!
primXConfigureRequestEventType: val
    <cCall: 'X11_XConfigureRequestEvent_type_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"type accessors"
type
    ^self primXConfigureRequestEventType
!
type: val
    ^self primXConfigureRequestEventType: val
!

"_________________________________________________________"
"serial primitive accessors"
primXConfigureRequestEventSerial
    <cCall: 'X11_XConfigureRequestEvent_serial_get' plugin: 'x11'>
    self primitiveFailed
!
primXConfigureRequestEventSerial: val
    <cCall: 'X11_XConfigureRequestEvent_serial_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"serial accessors"
serial
    ^self primXConfigureRequestEventSerial
!
serial: val
    ^self primXConfigureRequestEventSerial: val
!

"_________________________________________________________"
"send_event primitive accessors"
primXConfigureRequestEventSendEvent
    <cCall: 'X11_XConfigureRequestEvent_send_event_get' plugin: 'x11'>
    self primitiveFailed
!
primXConfigureRequestEventSendEvent: val
    <cCall: 'X11_XConfigureRequestEvent_send_event_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"send_event accessors"
sendevent
    ^self primXConfigureRequestEventSendEvent
!
sendevent: val
    ^self primXConfigureRequestEventSendEvent: val
!

"_________________________________________________________"
"display primitive accessors"
primXConfigureRequestEventDisplay
    <cCall: 'X11_XConfigureRequestEvent_display_get' plugin: 'x11'>
    self primitiveFailed
!
primXConfigureRequestEventDisplay: val
    <cCall: 'X11_XConfigureRequestEvent_display_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"display accessors"
display
    ^self primXConfigureRequestEventDisplay
!
display: val
    ^self primXConfigureRequestEventDisplay: val
!

"_________________________________________________________"
"parent primitive accessors"
primXConfigureRequestEventParent
    <cCall: 'X11_XConfigureRequestEvent_parent_get' plugin: 'x11'>
    self primitiveFailed
!
primXConfigureRequestEventParent: val
    <cCall: 'X11_XConfigureRequestEvent_parent_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"parent accessors"
parent
    ^self primXConfigureRequestEventParent
!
parent: val
    ^self primXConfigureRequestEventParent: val
!

"_________________________________________________________"
"window primitive accessors"
primXConfigureRequestEventWindow
    <cCall: 'X11_XConfigureRequestEvent_window_get' plugin: 'x11'>
    self primitiveFailed
!
primXConfigureRequestEventWindow: val
    <cCall: 'X11_XConfigureRequestEvent_window_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"window accessors"
window
    ^self primXConfigureRequestEventWindow
!
window: val
    ^self primXConfigureRequestEventWindow: val
!

"_________________________________________________________"
"x primitive accessors"
primXConfigureRequestEventX
    <cCall: 'X11_XConfigureRequestEvent_x_get' plugin: 'x11'>
    self primitiveFailed
!
primXConfigureRequestEventX: val
    <cCall: 'X11_XConfigureRequestEvent_x_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"x accessors"
x
    ^self primXConfigureRequestEventX
!
x: val
    ^self primXConfigureRequestEventX: val
!

"_________________________________________________________"
"y primitive accessors"
primXConfigureRequestEventY
    <cCall: 'X11_XConfigureRequestEvent_y_get' plugin: 'x11'>
    self primitiveFailed
!
primXConfigureRequestEventY: val
    <cCall: 'X11_XConfigureRequestEvent_y_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"y accessors"
y
    ^self primXConfigureRequestEventY
!
y: val
    ^self primXConfigureRequestEventY: val
!

"_________________________________________________________"
"width primitive accessors"
primXConfigureRequestEventWidth
    <cCall: 'X11_XConfigureRequestEvent_width_get' plugin: 'x11'>
    self primitiveFailed
!
primXConfigureRequestEventWidth: val
    <cCall: 'X11_XConfigureRequestEvent_width_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"width accessors"
width
    ^self primXConfigureRequestEventWidth
!
width: val
    ^self primXConfigureRequestEventWidth: val
!

"_________________________________________________________"
"height primitive accessors"
primXConfigureRequestEventHeight
    <cCall: 'X11_XConfigureRequestEvent_height_get' plugin: 'x11'>
    self primitiveFailed
!
primXConfigureRequestEventHeight: val
    <cCall: 'X11_XConfigureRequestEvent_height_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"height accessors"
height
    ^self primXConfigureRequestEventHeight
!
height: val
    ^self primXConfigureRequestEventHeight: val
!

"_________________________________________________________"
"border_width primitive accessors"
primXConfigureRequestEventBorderWidth
    <cCall: 'X11_XConfigureRequestEvent_border_width_get' plugin: 'x11'>
    self primitiveFailed
!
primXConfigureRequestEventBorderWidth: val
    <cCall: 'X11_XConfigureRequestEvent_border_width_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"border_width accessors"
borderwidth
    ^self primXConfigureRequestEventBorderWidth
!
borderwidth: val
    ^self primXConfigureRequestEventBorderWidth: val
!

"_________________________________________________________"
"above primitive accessors"
primXConfigureRequestEventAbove
    <cCall: 'X11_XConfigureRequestEvent_above_get' plugin: 'x11'>
    self primitiveFailed
!
primXConfigureRequestEventAbove: val
    <cCall: 'X11_XConfigureRequestEvent_above_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"above accessors"
above
    ^self primXConfigureRequestEventAbove
!
above: val
    ^self primXConfigureRequestEventAbove: val
!

"_________________________________________________________"
"detail primitive accessors"
primXConfigureRequestEventDetail
    <cCall: 'X11_XConfigureRequestEvent_detail_get' plugin: 'x11'>
    self primitiveFailed
!
primXConfigureRequestEventDetail: val
    <cCall: 'X11_XConfigureRequestEvent_detail_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"detail accessors"
detail
    ^self primXConfigureRequestEventDetail
!
detail: val
    ^self primXConfigureRequestEventDetail: val
!

"_________________________________________________________"
"value_mask primitive accessors"
primXConfigureRequestEventValueMask
    <cCall: 'X11_XConfigureRequestEvent_value_mask_get' plugin: 'x11'>
    self primitiveFailed
!
primXConfigureRequestEventValueMask: val
    <cCall: 'X11_XConfigureRequestEvent_value_mask_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"value_mask accessors"
valuemask
    ^self primXConfigureRequestEventValueMask
!
valuemask: val
    ^self primXConfigureRequestEventValueMask: val
!






primX11XConfigureRequestEventDelete
    <cCall: 'X11_delete_XConfigureRequestEvent' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XConfigureRequestEventDelete.
!


name
    ^'X11XConfigureRequestEvent'

! !

!X11XConfigureRequestEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XConfigureRequestEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XClientMessageEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XClientMessageEvent class methodsFor: 'initialize-release'!

primX11XClientMessageEventCreate
    <cCall: 'X11_new_XClientMessageEvent' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XClientMessageEventCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XClientMessageEvent  methodsFor: 'X11'!

"_________________________________________________________"
"type primitive accessors"
primXClientMessageEventType
    <cCall: 'X11_XClientMessageEvent_type_get' plugin: 'x11'>
    self primitiveFailed
!
primXClientMessageEventType: val
    <cCall: 'X11_XClientMessageEvent_type_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"type accessors"
type
    ^self primXClientMessageEventType
!
type: val
    ^self primXClientMessageEventType: val
!

"_________________________________________________________"
"serial primitive accessors"
primXClientMessageEventSerial
    <cCall: 'X11_XClientMessageEvent_serial_get' plugin: 'x11'>
    self primitiveFailed
!
primXClientMessageEventSerial: val
    <cCall: 'X11_XClientMessageEvent_serial_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"serial accessors"
serial
    ^self primXClientMessageEventSerial
!
serial: val
    ^self primXClientMessageEventSerial: val
!

"_________________________________________________________"
"send_event primitive accessors"
primXClientMessageEventSendEvent
    <cCall: 'X11_XClientMessageEvent_send_event_get' plugin: 'x11'>
    self primitiveFailed
!
primXClientMessageEventSendEvent: val
    <cCall: 'X11_XClientMessageEvent_send_event_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"send_event accessors"
sendevent
    ^self primXClientMessageEventSendEvent
!
sendevent: val
    ^self primXClientMessageEventSendEvent: val
!

"_________________________________________________________"
"display primitive accessors"
primXClientMessageEventDisplay
    <cCall: 'X11_XClientMessageEvent_display_get' plugin: 'x11'>
    self primitiveFailed
!
primXClientMessageEventDisplay: val
    <cCall: 'X11_XClientMessageEvent_display_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"display accessors"
display
    ^self primXClientMessageEventDisplay
!
display: val
    ^self primXClientMessageEventDisplay: val
!

"_________________________________________________________"
"window primitive accessors"
primXClientMessageEventWindow
    <cCall: 'X11_XClientMessageEvent_window_get' plugin: 'x11'>
    self primitiveFailed
!
primXClientMessageEventWindow: val
    <cCall: 'X11_XClientMessageEvent_window_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"window accessors"
window
    ^self primXClientMessageEventWindow
!
window: val
    ^self primXClientMessageEventWindow: val
!

"_________________________________________________________"
"message_type primitive accessors"
primXClientMessageEventMessageType
    <cCall: 'X11_XClientMessageEvent_message_type_get' plugin: 'x11'>
    self primitiveFailed
!
primXClientMessageEventMessageType: val
    <cCall: 'X11_XClientMessageEvent_message_type_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"message_type accessors"
messagetype
    ^self primXClientMessageEventMessageType
!
messagetype: val
    ^self primXClientMessageEventMessageType: val
!

"_________________________________________________________"
"format primitive accessors"
primXClientMessageEventFormat
    <cCall: 'X11_XClientMessageEvent_format_get' plugin: 'x11'>
    self primitiveFailed
!
primXClientMessageEventFormat: val
    <cCall: 'X11_XClientMessageEvent_format_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"format accessors"
format
    ^self primXClientMessageEventFormat
!
format: val
    ^self primXClientMessageEventFormat: val
!

"_________________________________________________________"
"data primitive accessors"
primXClientMessageEventData
    <cCall: 'X11_XClientMessageEvent_data_get' plugin: 'x11'>
    self primitiveFailed
!
primXClientMessageEventData: val
    <cCall: 'X11_XClientMessageEvent_data_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"data accessors"
data
    ^self primXClientMessageEventData
!
data: val
    ^self primXClientMessageEventData: val
!






primX11XClientMessageEventDelete
    <cCall: 'X11_delete_XClientMessageEvent' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XClientMessageEventDelete.
!


name
    ^'X11XClientMessageEvent'

! !

!X11XClientMessageEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XClientMessageEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XwcTextItem
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XwcTextItem class methodsFor: 'initialize-release'!

primX11XwcTextItemCreate
    <cCall: 'X11_new_XwcTextItem' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XwcTextItemCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XwcTextItem  methodsFor: 'X11'!

"_________________________________________________________"
"chars primitive accessors"
primXwcTextItemChars
    <cCall: 'X11_XwcTextItem_chars_get' plugin: 'x11'>
    self primitiveFailed
!
primXwcTextItemChars: val
    <cCall: 'X11_XwcTextItem_chars_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"chars accessors"
chars
    ^self primXwcTextItemChars
!
chars: val
    ^self primXwcTextItemChars: val
!

"_________________________________________________________"
"nchars primitive accessors"
primXwcTextItemNchars
    <cCall: 'X11_XwcTextItem_nchars_get' plugin: 'x11'>
    self primitiveFailed
!
primXwcTextItemNchars: val
    <cCall: 'X11_XwcTextItem_nchars_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"nchars accessors"
nchars
    ^self primXwcTextItemNchars
!
nchars: val
    ^self primXwcTextItemNchars: val
!

"_________________________________________________________"
"delta primitive accessors"
primXwcTextItemDelta
    <cCall: 'X11_XwcTextItem_delta_get' plugin: 'x11'>
    self primitiveFailed
!
primXwcTextItemDelta: val
    <cCall: 'X11_XwcTextItem_delta_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"delta accessors"
delta
    ^self primXwcTextItemDelta
!
delta: val
    ^self primXwcTextItemDelta: val
!

"_________________________________________________________"
"font_set primitive accessors"
primXwcTextItemFontSet
    <cCall: 'X11_XwcTextItem_font_set_get' plugin: 'x11'>
    self primitiveFailed
!
primXwcTextItemFontSet: val
    <cCall: 'X11_XwcTextItem_font_set_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"font_set accessors"
fontset
    ^self primXwcTextItemFontSet
!
fontset: val
    ^self primXwcTextItemFontSet: val
!






primX11XwcTextItemDelete
    <cCall: 'X11_delete_XwcTextItem' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XwcTextItemDelete.
!


name
    ^'X11XwcTextItem'

! !

!X11XwcTextItem methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XwcTextItem methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XModifierKeymap
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XModifierKeymap class methodsFor: 'initialize-release'!

primX11XModifierKeymapCreate
    <cCall: 'X11_new_XModifierKeymap' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XModifierKeymapCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XModifierKeymap  methodsFor: 'X11'!

"_________________________________________________________"
"max_keypermod primitive accessors"
primXModifierKeymapMaxKeypermod
    <cCall: 'X11_XModifierKeymap_max_keypermod_get' plugin: 'x11'>
    self primitiveFailed
!
primXModifierKeymapMaxKeypermod: val
    <cCall: 'X11_XModifierKeymap_max_keypermod_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"max_keypermod accessors"
maxkeypermod
    ^self primXModifierKeymapMaxKeypermod
!
maxkeypermod: val
    ^self primXModifierKeymapMaxKeypermod: val
!

"_________________________________________________________"
"modifiermap primitive accessors"
primXModifierKeymapModifiermap
    <cCall: 'X11_XModifierKeymap_modifiermap_get' plugin: 'x11'>
    self primitiveFailed
!
primXModifierKeymapModifiermap: val
    <cCall: 'X11_XModifierKeymap_modifiermap_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"modifiermap accessors"
modifiermap
    ^self primXModifierKeymapModifiermap
!
modifiermap: val
    ^self primXModifierKeymapModifiermap: val
!



"_________________________________________________________"
"XDeleteModifiermapEntry primitive function"
primXDeleteModifiermapEntry: arg1 keycodeEntry: arg4 modifier: arg5
    <cCall: 'X11_XDeleteModifiermapEntry' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XInsertModifiermapEntry primitive function"
primXInsertModifiermapEntry: arg1 keycodeEntry: arg4 modifier: arg5
    <cCall: 'X11_XInsertModifiermapEntry' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XFreeModifiermap primitive function"
primXFreeModifiermap
    <cCall: 'X11_XFreeModifiermap' plugin: 'x11'>
    self primitiveFailed
!




primX11XModifierKeymapDelete
    <cCall: 'X11_delete_XModifierKeymap' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XModifierKeymapDelete.
!


name
    ^'X11XModifierKeymap'

! !

!X11XModifierKeymap methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XModifierKeymap methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XColormapEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XColormapEvent class methodsFor: 'initialize-release'!

primX11XColormapEventCreate
    <cCall: 'X11_new_XColormapEvent' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XColormapEventCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XColormapEvent  methodsFor: 'X11'!

"_________________________________________________________"
"type primitive accessors"
primXColormapEventType
    <cCall: 'X11_XColormapEvent_type_get' plugin: 'x11'>
    self primitiveFailed
!
primXColormapEventType: val
    <cCall: 'X11_XColormapEvent_type_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"type accessors"
type
    ^self primXColormapEventType
!
type: val
    ^self primXColormapEventType: val
!

"_________________________________________________________"
"serial primitive accessors"
primXColormapEventSerial
    <cCall: 'X11_XColormapEvent_serial_get' plugin: 'x11'>
    self primitiveFailed
!
primXColormapEventSerial: val
    <cCall: 'X11_XColormapEvent_serial_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"serial accessors"
serial
    ^self primXColormapEventSerial
!
serial: val
    ^self primXColormapEventSerial: val
!

"_________________________________________________________"
"send_event primitive accessors"
primXColormapEventSendEvent
    <cCall: 'X11_XColormapEvent_send_event_get' plugin: 'x11'>
    self primitiveFailed
!
primXColormapEventSendEvent: val
    <cCall: 'X11_XColormapEvent_send_event_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"send_event accessors"
sendevent
    ^self primXColormapEventSendEvent
!
sendevent: val
    ^self primXColormapEventSendEvent: val
!

"_________________________________________________________"
"display primitive accessors"
primXColormapEventDisplay
    <cCall: 'X11_XColormapEvent_display_get' plugin: 'x11'>
    self primitiveFailed
!
primXColormapEventDisplay: val
    <cCall: 'X11_XColormapEvent_display_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"display accessors"
display
    ^self primXColormapEventDisplay
!
display: val
    ^self primXColormapEventDisplay: val
!

"_________________________________________________________"
"window primitive accessors"
primXColormapEventWindow
    <cCall: 'X11_XColormapEvent_window_get' plugin: 'x11'>
    self primitiveFailed
!
primXColormapEventWindow: val
    <cCall: 'X11_XColormapEvent_window_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"window accessors"
window
    ^self primXColormapEventWindow
!
window: val
    ^self primXColormapEventWindow: val
!

"_________________________________________________________"
"colormap primitive accessors"
primXColormapEventColormap
    <cCall: 'X11_XColormapEvent_colormap_get' plugin: 'x11'>
    self primitiveFailed
!
primXColormapEventColormap: val
    <cCall: 'X11_XColormapEvent_colormap_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"colormap accessors"
colormap
    ^self primXColormapEventColormap
!
colormap: val
    ^self primXColormapEventColormap: val
!

"_________________________________________________________"
"new primitive accessors"
primXColormapEventNew
    <cCall: 'X11_XColormapEvent_new_get' plugin: 'x11'>
    self primitiveFailed
!
primXColormapEventNew: val
    <cCall: 'X11_XColormapEvent_new_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"new accessors"
new
    ^self primXColormapEventNew
!
new: val
    ^self primXColormapEventNew: val
!

"_________________________________________________________"
"state primitive accessors"
primXColormapEventState
    <cCall: 'X11_XColormapEvent_state_get' plugin: 'x11'>
    self primitiveFailed
!
primXColormapEventState: val
    <cCall: 'X11_XColormapEvent_state_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"state accessors"
state
    ^self primXColormapEventState
!
state: val
    ^self primXColormapEventState: val
!






primX11XColormapEventDelete
    <cCall: 'X11_delete_XColormapEvent' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XColormapEventDelete.
!


name
    ^'X11XColormapEvent'

! !

!X11XColormapEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XColormapEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XMotionEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XMotionEvent class methodsFor: 'initialize-release'!

primX11XMotionEventCreate
    <cCall: 'X11_new_XMotionEvent' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XMotionEventCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XMotionEvent  methodsFor: 'X11'!

"_________________________________________________________"
"type primitive accessors"
primXMotionEventType
    <cCall: 'X11_XMotionEvent_type_get' plugin: 'x11'>
    self primitiveFailed
!
primXMotionEventType: val
    <cCall: 'X11_XMotionEvent_type_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"type accessors"
type
    ^self primXMotionEventType
!
type: val
    ^self primXMotionEventType: val
!

"_________________________________________________________"
"serial primitive accessors"
primXMotionEventSerial
    <cCall: 'X11_XMotionEvent_serial_get' plugin: 'x11'>
    self primitiveFailed
!
primXMotionEventSerial: val
    <cCall: 'X11_XMotionEvent_serial_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"serial accessors"
serial
    ^self primXMotionEventSerial
!
serial: val
    ^self primXMotionEventSerial: val
!

"_________________________________________________________"
"send_event primitive accessors"
primXMotionEventSendEvent
    <cCall: 'X11_XMotionEvent_send_event_get' plugin: 'x11'>
    self primitiveFailed
!
primXMotionEventSendEvent: val
    <cCall: 'X11_XMotionEvent_send_event_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"send_event accessors"
sendevent
    ^self primXMotionEventSendEvent
!
sendevent: val
    ^self primXMotionEventSendEvent: val
!

"_________________________________________________________"
"display primitive accessors"
primXMotionEventDisplay
    <cCall: 'X11_XMotionEvent_display_get' plugin: 'x11'>
    self primitiveFailed
!
primXMotionEventDisplay: val
    <cCall: 'X11_XMotionEvent_display_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"display accessors"
display
    ^self primXMotionEventDisplay
!
display: val
    ^self primXMotionEventDisplay: val
!

"_________________________________________________________"
"window primitive accessors"
primXMotionEventWindow
    <cCall: 'X11_XMotionEvent_window_get' plugin: 'x11'>
    self primitiveFailed
!
primXMotionEventWindow: val
    <cCall: 'X11_XMotionEvent_window_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"window accessors"
window
    ^self primXMotionEventWindow
!
window: val
    ^self primXMotionEventWindow: val
!

"_________________________________________________________"
"root primitive accessors"
primXMotionEventRoot
    <cCall: 'X11_XMotionEvent_root_get' plugin: 'x11'>
    self primitiveFailed
!
primXMotionEventRoot: val
    <cCall: 'X11_XMotionEvent_root_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"root accessors"
root
    ^self primXMotionEventRoot
!
root: val
    ^self primXMotionEventRoot: val
!

"_________________________________________________________"
"subwindow primitive accessors"
primXMotionEventSubwindow
    <cCall: 'X11_XMotionEvent_subwindow_get' plugin: 'x11'>
    self primitiveFailed
!
primXMotionEventSubwindow: val
    <cCall: 'X11_XMotionEvent_subwindow_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"subwindow accessors"
subwindow
    ^self primXMotionEventSubwindow
!
subwindow: val
    ^self primXMotionEventSubwindow: val
!

"_________________________________________________________"
"time primitive accessors"
primXMotionEventTime
    <cCall: 'X11_XMotionEvent_time_get' plugin: 'x11'>
    self primitiveFailed
!
primXMotionEventTime: val
    <cCall: 'X11_XMotionEvent_time_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"time accessors"
time
    ^self primXMotionEventTime
!
time: val
    ^self primXMotionEventTime: val
!

"_________________________________________________________"
"x primitive accessors"
primXMotionEventX
    <cCall: 'X11_XMotionEvent_x_get' plugin: 'x11'>
    self primitiveFailed
!
primXMotionEventX: val
    <cCall: 'X11_XMotionEvent_x_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"x accessors"
x
    ^self primXMotionEventX
!
x: val
    ^self primXMotionEventX: val
!

"_________________________________________________________"
"y primitive accessors"
primXMotionEventY
    <cCall: 'X11_XMotionEvent_y_get' plugin: 'x11'>
    self primitiveFailed
!
primXMotionEventY: val
    <cCall: 'X11_XMotionEvent_y_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"y accessors"
y
    ^self primXMotionEventY
!
y: val
    ^self primXMotionEventY: val
!

"_________________________________________________________"
"x_root primitive accessors"
primXMotionEventXRoot
    <cCall: 'X11_XMotionEvent_x_root_get' plugin: 'x11'>
    self primitiveFailed
!
primXMotionEventXRoot: val
    <cCall: 'X11_XMotionEvent_x_root_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"x_root accessors"
xroot
    ^self primXMotionEventXRoot
!
xroot: val
    ^self primXMotionEventXRoot: val
!

"_________________________________________________________"
"y_root primitive accessors"
primXMotionEventYRoot
    <cCall: 'X11_XMotionEvent_y_root_get' plugin: 'x11'>
    self primitiveFailed
!
primXMotionEventYRoot: val
    <cCall: 'X11_XMotionEvent_y_root_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"y_root accessors"
yroot
    ^self primXMotionEventYRoot
!
yroot: val
    ^self primXMotionEventYRoot: val
!

"_________________________________________________________"
"state primitive accessors"
primXMotionEventState
    <cCall: 'X11_XMotionEvent_state_get' plugin: 'x11'>
    self primitiveFailed
!
primXMotionEventState: val
    <cCall: 'X11_XMotionEvent_state_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"state accessors"
state
    ^self primXMotionEventState
!
state: val
    ^self primXMotionEventState: val
!

"_________________________________________________________"
"is_hint primitive accessors"
primXMotionEventIsHint
    <cCall: 'X11_XMotionEvent_is_hint_get' plugin: 'x11'>
    self primitiveFailed
!
primXMotionEventIsHint: val
    <cCall: 'X11_XMotionEvent_is_hint_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"is_hint accessors"
ishint
    ^self primXMotionEventIsHint
!
ishint: val
    ^self primXMotionEventIsHint: val
!

"_________________________________________________________"
"same_screen primitive accessors"
primXMotionEventSameScreen
    <cCall: 'X11_XMotionEvent_same_screen_get' plugin: 'x11'>
    self primitiveFailed
!
primXMotionEventSameScreen: val
    <cCall: 'X11_XMotionEvent_same_screen_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"same_screen accessors"
samescreen
    ^self primXMotionEventSameScreen
!
samescreen: val
    ^self primXMotionEventSameScreen: val
!






primX11XMotionEventDelete
    <cCall: 'X11_delete_XMotionEvent' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XMotionEventDelete.
!


name
    ^'X11XMotionEvent'

! !

!X11XMotionEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XMotionEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XTextItem16
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XTextItem16 class methodsFor: 'initialize-release'!

primX11XTextItem16Create
    <cCall: 'X11_new_XTextItem16' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XTextItem16Create).
!

initialize
    finalizationRequest := true.
! !

!X11XTextItem16  methodsFor: 'X11'!

"_________________________________________________________"
"chars primitive accessors"
primXTextItem16Chars
    <cCall: 'X11_XTextItem16_chars_get' plugin: 'x11'>
    self primitiveFailed
!
primXTextItem16Chars: val
    <cCall: 'X11_XTextItem16_chars_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"chars accessors"
chars
    ^self primXTextItem16Chars
!
chars: val
    ^self primXTextItem16Chars: val
!

"_________________________________________________________"
"nchars primitive accessors"
primXTextItem16Nchars
    <cCall: 'X11_XTextItem16_nchars_get' plugin: 'x11'>
    self primitiveFailed
!
primXTextItem16Nchars: val
    <cCall: 'X11_XTextItem16_nchars_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"nchars accessors"
nchars
    ^self primXTextItem16Nchars
!
nchars: val
    ^self primXTextItem16Nchars: val
!

"_________________________________________________________"
"delta primitive accessors"
primXTextItem16Delta
    <cCall: 'X11_XTextItem16_delta_get' plugin: 'x11'>
    self primitiveFailed
!
primXTextItem16Delta: val
    <cCall: 'X11_XTextItem16_delta_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"delta accessors"
delta
    ^self primXTextItem16Delta
!
delta: val
    ^self primXTextItem16Delta: val
!

"_________________________________________________________"
"font primitive accessors"
primXTextItem16Font
    <cCall: 'X11_XTextItem16_font_get' plugin: 'x11'>
    self primitiveFailed
!
primXTextItem16Font: val
    <cCall: 'X11_XTextItem16_font_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"font accessors"
font
    ^self primXTextItem16Font
!
font: val
    ^self primXTextItem16Font: val
!






primX11XTextItem16Delete
    <cCall: 'X11_delete_XTextItem16' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XTextItem16Delete.
!


name
    ^'X11XTextItem16'

! !

!X11XTextItem16 methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XTextItem16 methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XIMPreeditStateNotifyCallbackStruct
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XIMPreeditStateNotifyCallbackStruct class methodsFor: 'initialize-release'!

primX11XIMPreeditStateNotifyCallbackStructCreate
    <cCall: 'X11_new_XIMPreeditStateNotifyCallbackStruct' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XIMPreeditStateNotifyCallbackStructCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XIMPreeditStateNotifyCallbackStruct  methodsFor: 'X11'!

"_________________________________________________________"
"state primitive accessors"
primXIMPreeditStateNotifyCallbackStructState
    <cCall: 'X11_XIMPreeditStateNotifyCallbackStruct_state_get' plugin: 'x11'>
    self primitiveFailed
!
primXIMPreeditStateNotifyCallbackStructState: val
    <cCall: 'X11_XIMPreeditStateNotifyCallbackStruct_state_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"state accessors"
state
    ^self primXIMPreeditStateNotifyCallbackStructState
!
state: val
    ^self primXIMPreeditStateNotifyCallbackStructState: val
!






primX11XIMPreeditStateNotifyCallbackStructDelete
    <cCall: 'X11_delete_XIMPreeditStateNotifyCallbackStruct' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XIMPreeditStateNotifyCallbackStructDelete.
!


name
    ^'X11XIMPreeditStateNotifyCallbackStruct'

! !

!X11XIMPreeditStateNotifyCallbackStruct methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XIMPreeditStateNotifyCallbackStruct methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XIMCallback
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XIMCallback class methodsFor: 'initialize-release'!

primX11XIMCallbackCreate
    <cCall: 'X11_new_XIMCallback' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XIMCallbackCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XIMCallback  methodsFor: 'X11'!

"_________________________________________________________"
"client_data primitive accessors"
primXIMCallbackClientData
    <cCall: 'X11_XIMCallback_client_data_get' plugin: 'x11'>
    self primitiveFailed
!
primXIMCallbackClientData: val
    <cCall: 'X11_XIMCallback_client_data_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"client_data accessors"
clientdata
    ^self primXIMCallbackClientData
!
clientdata: val
    ^self primXIMCallbackClientData: val
!

"_________________________________________________________"
"callback primitive accessors"
primXIMCallbackCallback
    <cCall: 'X11_XIMCallback_callback_get' plugin: 'x11'>
    self primitiveFailed
!
primXIMCallbackCallback: val
    <cCall: 'X11_XIMCallback_callback_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"callback accessors"
callback
    ^self primXIMCallbackCallback
!
callback: val
    ^self primXIMCallbackCallback: val
!






primX11XIMCallbackDelete
    <cCall: 'X11_delete_XIMCallback' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XIMCallbackDelete.
!


name
    ^'X11XIMCallback'

! !

!X11XIMCallback methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XIMCallback methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XIC
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XIC class methodsFor: 'initialize-release'!

primX11XICCreate
    <cCall: 'X11_new_XIC' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XICCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XIC  methodsFor: 'X11'!



"_________________________________________________________"
"XDestroyIC primitive function"
primXDestroyIC
    <cCall: 'X11_XDestroyIC' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XSetICFocus primitive function"
primXSetICFocus
    <cCall: 'X11_XSetICFocus' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XUnsetICFocus primitive function"
primXUnsetICFocus
    <cCall: 'X11_XUnsetICFocus' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XwcResetIC primitive function"
primXwcResetIC
    <cCall: 'X11_XwcResetIC' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XmbResetIC primitive function"
primXmbResetIC
    <cCall: 'X11_XmbResetIC' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XSetICValues primitive function"
primXSetICValues
    <cCall: 'X11_XSetICValues' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XGetICValues primitive function"
primXGetICValues
    <cCall: 'X11_XGetICValues' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XIMOfIC primitive function"
primXIMOfIC
    <cCall: 'X11_XIMOfIC' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XmbLookupString primitive function"
primXmbLookupString: arg1 bufferReturn: arg4 bytesBuffer: arg5 keysymReturn: arg6 statusReturn: arg7
    <cCall: 'X11_XmbLookupString' plugin: 'x11'>
    self primitiveFailed
!

"_________________________________________________________"
"XwcLookupString primitive function"
primXwcLookupString: arg1 bufferReturn: arg4 wcharsBuffer: arg5 keysymReturn: arg6 statusReturn: arg7
    <cCall: 'X11_XwcLookupString' plugin: 'x11'>
    self primitiveFailed
!




primX11XICDelete
    <cCall: 'X11_delete_XIC' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XICDelete.
!


name
    ^'X11XIC'

! !

!X11XIC methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XIC methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XCharStruct
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XCharStruct class methodsFor: 'initialize-release'!

primX11XCharStructCreate
    <cCall: 'X11_new_XCharStruct' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XCharStructCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XCharStruct  methodsFor: 'X11'!

"_________________________________________________________"
"lbearing primitive accessors"
primXCharStructLbearing
    <cCall: 'X11_XCharStruct_lbearing_get' plugin: 'x11'>
    self primitiveFailed
!
primXCharStructLbearing: val
    <cCall: 'X11_XCharStruct_lbearing_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"lbearing accessors"
lbearing
    ^self primXCharStructLbearing
!
lbearing: val
    ^self primXCharStructLbearing: val
!

"_________________________________________________________"
"rbearing primitive accessors"
primXCharStructRbearing
    <cCall: 'X11_XCharStruct_rbearing_get' plugin: 'x11'>
    self primitiveFailed
!
primXCharStructRbearing: val
    <cCall: 'X11_XCharStruct_rbearing_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"rbearing accessors"
rbearing
    ^self primXCharStructRbearing
!
rbearing: val
    ^self primXCharStructRbearing: val
!

"_________________________________________________________"
"width primitive accessors"
primXCharStructWidth
    <cCall: 'X11_XCharStruct_width_get' plugin: 'x11'>
    self primitiveFailed
!
primXCharStructWidth: val
    <cCall: 'X11_XCharStruct_width_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"width accessors"
width
    ^self primXCharStructWidth
!
width: val
    ^self primXCharStructWidth: val
!

"_________________________________________________________"
"ascent primitive accessors"
primXCharStructAscent
    <cCall: 'X11_XCharStruct_ascent_get' plugin: 'x11'>
    self primitiveFailed
!
primXCharStructAscent: val
    <cCall: 'X11_XCharStruct_ascent_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"ascent accessors"
ascent
    ^self primXCharStructAscent
!
ascent: val
    ^self primXCharStructAscent: val
!

"_________________________________________________________"
"descent primitive accessors"
primXCharStructDescent
    <cCall: 'X11_XCharStruct_descent_get' plugin: 'x11'>
    self primitiveFailed
!
primXCharStructDescent: val
    <cCall: 'X11_XCharStruct_descent_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"descent accessors"
descent
    ^self primXCharStructDescent
!
descent: val
    ^self primXCharStructDescent: val
!

"_________________________________________________________"
"attributes primitive accessors"
primXCharStructAttributes
    <cCall: 'X11_XCharStruct_attributes_get' plugin: 'x11'>
    self primitiveFailed
!
primXCharStructAttributes: val
    <cCall: 'X11_XCharStruct_attributes_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"attributes accessors"
attributes
    ^self primXCharStructAttributes
!
attributes: val
    ^self primXCharStructAttributes: val
!






primX11XCharStructDelete
    <cCall: 'X11_delete_XCharStruct' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XCharStructDelete.
!


name
    ^'X11XCharStruct'

! !

!X11XCharStruct methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XCharStruct methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XmbTextItem
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XmbTextItem class methodsFor: 'initialize-release'!

primX11XmbTextItemCreate
    <cCall: 'X11_new_XmbTextItem' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XmbTextItemCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XmbTextItem  methodsFor: 'X11'!

"_________________________________________________________"
"chars primitive accessors"
primXmbTextItemChars
    <cCall: 'X11_XmbTextItem_chars_get' plugin: 'x11'>
    self primitiveFailed
!
primXmbTextItemChars: val
    <cCall: 'X11_XmbTextItem_chars_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"chars accessors"
chars
    ^self primXmbTextItemChars
!
chars: val
    ^self primXmbTextItemChars: val
!

"_________________________________________________________"
"nchars primitive accessors"
primXmbTextItemNchars
    <cCall: 'X11_XmbTextItem_nchars_get' plugin: 'x11'>
    self primitiveFailed
!
primXmbTextItemNchars: val
    <cCall: 'X11_XmbTextItem_nchars_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"nchars accessors"
nchars
    ^self primXmbTextItemNchars
!
nchars: val
    ^self primXmbTextItemNchars: val
!

"_________________________________________________________"
"delta primitive accessors"
primXmbTextItemDelta
    <cCall: 'X11_XmbTextItem_delta_get' plugin: 'x11'>
    self primitiveFailed
!
primXmbTextItemDelta: val
    <cCall: 'X11_XmbTextItem_delta_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"delta accessors"
delta
    ^self primXmbTextItemDelta
!
delta: val
    ^self primXmbTextItemDelta: val
!

"_________________________________________________________"
"font_set primitive accessors"
primXmbTextItemFontSet
    <cCall: 'X11_XmbTextItem_font_set_get' plugin: 'x11'>
    self primitiveFailed
!
primXmbTextItemFontSet: val
    <cCall: 'X11_XmbTextItem_font_set_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"font_set accessors"
fontset
    ^self primXmbTextItemFontSet
!
fontset: val
    ^self primXmbTextItemFontSet: val
!






primX11XmbTextItemDelete
    <cCall: 'X11_delete_XmbTextItem' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XmbTextItemDelete.
!


name
    ^'X11XmbTextItem'

! !

!X11XmbTextItem methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XmbTextItem methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XChar2b
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XChar2b class methodsFor: 'initialize-release'!

primX11XChar2bCreate
    <cCall: 'X11_new_XChar2b' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XChar2bCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XChar2b  methodsFor: 'X11'!

"_________________________________________________________"
"byte1 primitive accessors"
primXChar2bByte1
    <cCall: 'X11_XChar2b_byte1_get' plugin: 'x11'>
    self primitiveFailed
!
primXChar2bByte1: val
    <cCall: 'X11_XChar2b_byte1_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"byte1 accessors"
byte1
    ^self primXChar2bByte1
!
byte1: val
    ^self primXChar2bByte1: val
!

"_________________________________________________________"
"byte2 primitive accessors"
primXChar2bByte2
    <cCall: 'X11_XChar2b_byte2_get' plugin: 'x11'>
    self primitiveFailed
!
primXChar2bByte2: val
    <cCall: 'X11_XChar2b_byte2_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"byte2 accessors"
byte2
    ^self primXChar2bByte2
!
byte2: val
    ^self primXChar2bByte2: val
!






primX11XChar2bDelete
    <cCall: 'X11_delete_XChar2b' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XChar2bDelete.
!


name
    ^'X11XChar2b'

! !

!X11XChar2b methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XChar2b methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XMapEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XMapEvent class methodsFor: 'initialize-release'!

primX11XMapEventCreate
    <cCall: 'X11_new_XMapEvent' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XMapEventCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XMapEvent  methodsFor: 'X11'!

"_________________________________________________________"
"type primitive accessors"
primXMapEventType
    <cCall: 'X11_XMapEvent_type_get' plugin: 'x11'>
    self primitiveFailed
!
primXMapEventType: val
    <cCall: 'X11_XMapEvent_type_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"type accessors"
type
    ^self primXMapEventType
!
type: val
    ^self primXMapEventType: val
!

"_________________________________________________________"
"serial primitive accessors"
primXMapEventSerial
    <cCall: 'X11_XMapEvent_serial_get' plugin: 'x11'>
    self primitiveFailed
!
primXMapEventSerial: val
    <cCall: 'X11_XMapEvent_serial_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"serial accessors"
serial
    ^self primXMapEventSerial
!
serial: val
    ^self primXMapEventSerial: val
!

"_________________________________________________________"
"send_event primitive accessors"
primXMapEventSendEvent
    <cCall: 'X11_XMapEvent_send_event_get' plugin: 'x11'>
    self primitiveFailed
!
primXMapEventSendEvent: val
    <cCall: 'X11_XMapEvent_send_event_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"send_event accessors"
sendevent
    ^self primXMapEventSendEvent
!
sendevent: val
    ^self primXMapEventSendEvent: val
!

"_________________________________________________________"
"display primitive accessors"
primXMapEventDisplay
    <cCall: 'X11_XMapEvent_display_get' plugin: 'x11'>
    self primitiveFailed
!
primXMapEventDisplay: val
    <cCall: 'X11_XMapEvent_display_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"display accessors"
display
    ^self primXMapEventDisplay
!
display: val
    ^self primXMapEventDisplay: val
!

"_________________________________________________________"
"event primitive accessors"
primXMapEventEvent
    <cCall: 'X11_XMapEvent_event_get' plugin: 'x11'>
    self primitiveFailed
!
primXMapEventEvent: val
    <cCall: 'X11_XMapEvent_event_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"event accessors"
event
    ^self primXMapEventEvent
!
event: val
    ^self primXMapEventEvent: val
!

"_________________________________________________________"
"window primitive accessors"
primXMapEventWindow
    <cCall: 'X11_XMapEvent_window_get' plugin: 'x11'>
    self primitiveFailed
!
primXMapEventWindow: val
    <cCall: 'X11_XMapEvent_window_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"window accessors"
window
    ^self primXMapEventWindow
!
window: val
    ^self primXMapEventWindow: val
!

"_________________________________________________________"
"override_redirect primitive accessors"
primXMapEventOverrideRedirect
    <cCall: 'X11_XMapEvent_override_redirect_get' plugin: 'x11'>
    self primitiveFailed
!
primXMapEventOverrideRedirect: val
    <cCall: 'X11_XMapEvent_override_redirect_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"override_redirect accessors"
overrideredirect
    ^self primXMapEventOverrideRedirect
!
overrideredirect: val
    ^self primXMapEventOverrideRedirect: val
!






primX11XMapEventDelete
    <cCall: 'X11_delete_XMapEvent' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XMapEventDelete.
!


name
    ^'X11XMapEvent'

! !

!X11XMapEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XMapEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XIMHotKeyTrigger
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XIMHotKeyTrigger class methodsFor: 'initialize-release'!

primX11XIMHotKeyTriggerCreate
    <cCall: 'X11_new_XIMHotKeyTrigger' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XIMHotKeyTriggerCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XIMHotKeyTrigger  methodsFor: 'X11'!

"_________________________________________________________"
"keysym primitive accessors"
primXIMHotKeyTriggerKeysym
    <cCall: 'X11_XIMHotKeyTrigger_keysym_get' plugin: 'x11'>
    self primitiveFailed
!
primXIMHotKeyTriggerKeysym: val
    <cCall: 'X11_XIMHotKeyTrigger_keysym_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"keysym accessors"
keysym
    ^self primXIMHotKeyTriggerKeysym
!
keysym: val
    ^self primXIMHotKeyTriggerKeysym: val
!

"_________________________________________________________"
"modifier primitive accessors"
primXIMHotKeyTriggerModifier
    <cCall: 'X11_XIMHotKeyTrigger_modifier_get' plugin: 'x11'>
    self primitiveFailed
!
primXIMHotKeyTriggerModifier: val
    <cCall: 'X11_XIMHotKeyTrigger_modifier_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"modifier accessors"
modifier
    ^self primXIMHotKeyTriggerModifier
!
modifier: val
    ^self primXIMHotKeyTriggerModifier: val
!

"_________________________________________________________"
"modifier_mask primitive accessors"
primXIMHotKeyTriggerModifierMask
    <cCall: 'X11_XIMHotKeyTrigger_modifier_mask_get' plugin: 'x11'>
    self primitiveFailed
!
primXIMHotKeyTriggerModifierMask: val
    <cCall: 'X11_XIMHotKeyTrigger_modifier_mask_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"modifier_mask accessors"
modifiermask
    ^self primXIMHotKeyTriggerModifierMask
!
modifiermask: val
    ^self primXIMHotKeyTriggerModifierMask: val
!






primX11XIMHotKeyTriggerDelete
    <cCall: 'X11_delete_XIMHotKeyTrigger' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XIMHotKeyTriggerDelete.
!


name
    ^'X11XIMHotKeyTrigger'

! !

!X11XIMHotKeyTrigger methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XIMHotKeyTrigger methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XIMStyles
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XIMStyles class methodsFor: 'initialize-release'!

primX11XIMStylesCreate
    <cCall: 'X11_new_XIMStyles' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XIMStylesCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XIMStyles  methodsFor: 'X11'!

"_________________________________________________________"
"count_styles primitive accessors"
primXIMStylesCountStyles
    <cCall: 'X11_XIMStyles_count_styles_get' plugin: 'x11'>
    self primitiveFailed
!
primXIMStylesCountStyles: val
    <cCall: 'X11_XIMStyles_count_styles_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"count_styles accessors"
countstyles
    ^self primXIMStylesCountStyles
!
countstyles: val
    ^self primXIMStylesCountStyles: val
!

"_________________________________________________________"
"supported_styles primitive accessors"
primXIMStylesSupportedStyles
    <cCall: 'X11_XIMStyles_supported_styles_get' plugin: 'x11'>
    self primitiveFailed
!
primXIMStylesSupportedStyles: val
    <cCall: 'X11_XIMStyles_supported_styles_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"supported_styles accessors"
supportedstyles
    ^self primXIMStylesSupportedStyles
!
supportedstyles: val
    ^self primXIMStylesSupportedStyles: val
!






primX11XIMStylesDelete
    <cCall: 'X11_delete_XIMStyles' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XIMStylesDelete.
!


name
    ^'X11XIMStyles'

! !

!X11XIMStyles methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XIMStyles methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XExposeEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XExposeEvent class methodsFor: 'initialize-release'!

primX11XExposeEventCreate
    <cCall: 'X11_new_XExposeEvent' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XExposeEventCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XExposeEvent  methodsFor: 'X11'!

"_________________________________________________________"
"type primitive accessors"
primXExposeEventType
    <cCall: 'X11_XExposeEvent_type_get' plugin: 'x11'>
    self primitiveFailed
!
primXExposeEventType: val
    <cCall: 'X11_XExposeEvent_type_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"type accessors"
type
    ^self primXExposeEventType
!
type: val
    ^self primXExposeEventType: val
!

"_________________________________________________________"
"serial primitive accessors"
primXExposeEventSerial
    <cCall: 'X11_XExposeEvent_serial_get' plugin: 'x11'>
    self primitiveFailed
!
primXExposeEventSerial: val
    <cCall: 'X11_XExposeEvent_serial_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"serial accessors"
serial
    ^self primXExposeEventSerial
!
serial: val
    ^self primXExposeEventSerial: val
!

"_________________________________________________________"
"send_event primitive accessors"
primXExposeEventSendEvent
    <cCall: 'X11_XExposeEvent_send_event_get' plugin: 'x11'>
    self primitiveFailed
!
primXExposeEventSendEvent: val
    <cCall: 'X11_XExposeEvent_send_event_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"send_event accessors"
sendevent
    ^self primXExposeEventSendEvent
!
sendevent: val
    ^self primXExposeEventSendEvent: val
!

"_________________________________________________________"
"display primitive accessors"
primXExposeEventDisplay
    <cCall: 'X11_XExposeEvent_display_get' plugin: 'x11'>
    self primitiveFailed
!
primXExposeEventDisplay: val
    <cCall: 'X11_XExposeEvent_display_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"display accessors"
display
    ^self primXExposeEventDisplay
!
display: val
    ^self primXExposeEventDisplay: val
!

"_________________________________________________________"
"window primitive accessors"
primXExposeEventWindow
    <cCall: 'X11_XExposeEvent_window_get' plugin: 'x11'>
    self primitiveFailed
!
primXExposeEventWindow: val
    <cCall: 'X11_XExposeEvent_window_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"window accessors"
window
    ^self primXExposeEventWindow
!
window: val
    ^self primXExposeEventWindow: val
!

"_________________________________________________________"
"x primitive accessors"
primXExposeEventX
    <cCall: 'X11_XExposeEvent_x_get' plugin: 'x11'>
    self primitiveFailed
!
primXExposeEventX: val
    <cCall: 'X11_XExposeEvent_x_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"x accessors"
x
    ^self primXExposeEventX
!
x: val
    ^self primXExposeEventX: val
!

"_________________________________________________________"
"y primitive accessors"
primXExposeEventY
    <cCall: 'X11_XExposeEvent_y_get' plugin: 'x11'>
    self primitiveFailed
!
primXExposeEventY: val
    <cCall: 'X11_XExposeEvent_y_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"y accessors"
y
    ^self primXExposeEventY
!
y: val
    ^self primXExposeEventY: val
!

"_________________________________________________________"
"width primitive accessors"
primXExposeEventWidth
    <cCall: 'X11_XExposeEvent_width_get' plugin: 'x11'>
    self primitiveFailed
!
primXExposeEventWidth: val
    <cCall: 'X11_XExposeEvent_width_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"width accessors"
width
    ^self primXExposeEventWidth
!
width: val
    ^self primXExposeEventWidth: val
!

"_________________________________________________________"
"height primitive accessors"
primXExposeEventHeight
    <cCall: 'X11_XExposeEvent_height_get' plugin: 'x11'>
    self primitiveFailed
!
primXExposeEventHeight: val
    <cCall: 'X11_XExposeEvent_height_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"height accessors"
height
    ^self primXExposeEventHeight
!
height: val
    ^self primXExposeEventHeight: val
!

"_________________________________________________________"
"count primitive accessors"
primXExposeEventCount
    <cCall: 'X11_XExposeEvent_count_get' plugin: 'x11'>
    self primitiveFailed
!
primXExposeEventCount: val
    <cCall: 'X11_XExposeEvent_count_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"count accessors"
count
    ^self primXExposeEventCount
!
count: val
    ^self primXExposeEventCount: val
!






primX11XExposeEventDelete
    <cCall: 'X11_delete_XExposeEvent' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XExposeEventDelete.
!


name
    ^'X11XExposeEvent'

! !

!X11XExposeEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XExposeEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XReparentEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XReparentEvent class methodsFor: 'initialize-release'!

primX11XReparentEventCreate
    <cCall: 'X11_new_XReparentEvent' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XReparentEventCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XReparentEvent  methodsFor: 'X11'!

"_________________________________________________________"
"type primitive accessors"
primXReparentEventType
    <cCall: 'X11_XReparentEvent_type_get' plugin: 'x11'>
    self primitiveFailed
!
primXReparentEventType: val
    <cCall: 'X11_XReparentEvent_type_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"type accessors"
type
    ^self primXReparentEventType
!
type: val
    ^self primXReparentEventType: val
!

"_________________________________________________________"
"serial primitive accessors"
primXReparentEventSerial
    <cCall: 'X11_XReparentEvent_serial_get' plugin: 'x11'>
    self primitiveFailed
!
primXReparentEventSerial: val
    <cCall: 'X11_XReparentEvent_serial_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"serial accessors"
serial
    ^self primXReparentEventSerial
!
serial: val
    ^self primXReparentEventSerial: val
!

"_________________________________________________________"
"send_event primitive accessors"
primXReparentEventSendEvent
    <cCall: 'X11_XReparentEvent_send_event_get' plugin: 'x11'>
    self primitiveFailed
!
primXReparentEventSendEvent: val
    <cCall: 'X11_XReparentEvent_send_event_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"send_event accessors"
sendevent
    ^self primXReparentEventSendEvent
!
sendevent: val
    ^self primXReparentEventSendEvent: val
!

"_________________________________________________________"
"display primitive accessors"
primXReparentEventDisplay
    <cCall: 'X11_XReparentEvent_display_get' plugin: 'x11'>
    self primitiveFailed
!
primXReparentEventDisplay: val
    <cCall: 'X11_XReparentEvent_display_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"display accessors"
display
    ^self primXReparentEventDisplay
!
display: val
    ^self primXReparentEventDisplay: val
!

"_________________________________________________________"
"event primitive accessors"
primXReparentEventEvent
    <cCall: 'X11_XReparentEvent_event_get' plugin: 'x11'>
    self primitiveFailed
!
primXReparentEventEvent: val
    <cCall: 'X11_XReparentEvent_event_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"event accessors"
event
    ^self primXReparentEventEvent
!
event: val
    ^self primXReparentEventEvent: val
!

"_________________________________________________________"
"window primitive accessors"
primXReparentEventWindow
    <cCall: 'X11_XReparentEvent_window_get' plugin: 'x11'>
    self primitiveFailed
!
primXReparentEventWindow: val
    <cCall: 'X11_XReparentEvent_window_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"window accessors"
window
    ^self primXReparentEventWindow
!
window: val
    ^self primXReparentEventWindow: val
!

"_________________________________________________________"
"parent primitive accessors"
primXReparentEventParent
    <cCall: 'X11_XReparentEvent_parent_get' plugin: 'x11'>
    self primitiveFailed
!
primXReparentEventParent: val
    <cCall: 'X11_XReparentEvent_parent_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"parent accessors"
parent
    ^self primXReparentEventParent
!
parent: val
    ^self primXReparentEventParent: val
!

"_________________________________________________________"
"x primitive accessors"
primXReparentEventX
    <cCall: 'X11_XReparentEvent_x_get' plugin: 'x11'>
    self primitiveFailed
!
primXReparentEventX: val
    <cCall: 'X11_XReparentEvent_x_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"x accessors"
x
    ^self primXReparentEventX
!
x: val
    ^self primXReparentEventX: val
!

"_________________________________________________________"
"y primitive accessors"
primXReparentEventY
    <cCall: 'X11_XReparentEvent_y_get' plugin: 'x11'>
    self primitiveFailed
!
primXReparentEventY: val
    <cCall: 'X11_XReparentEvent_y_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"y accessors"
y
    ^self primXReparentEventY
!
y: val
    ^self primXReparentEventY: val
!

"_________________________________________________________"
"override_redirect primitive accessors"
primXReparentEventOverrideRedirect
    <cCall: 'X11_XReparentEvent_override_redirect_get' plugin: 'x11'>
    self primitiveFailed
!
primXReparentEventOverrideRedirect: val
    <cCall: 'X11_XReparentEvent_override_redirect_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"override_redirect accessors"
overrideredirect
    ^self primXReparentEventOverrideRedirect
!
overrideredirect: val
    ^self primXReparentEventOverrideRedirect: val
!






primX11XReparentEventDelete
    <cCall: 'X11_delete_XReparentEvent' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XReparentEventDelete.
!


name
    ^'X11XReparentEvent'

! !

!X11XReparentEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XReparentEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XUnmapEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XUnmapEvent class methodsFor: 'initialize-release'!

primX11XUnmapEventCreate
    <cCall: 'X11_new_XUnmapEvent' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XUnmapEventCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XUnmapEvent  methodsFor: 'X11'!

"_________________________________________________________"
"type primitive accessors"
primXUnmapEventType
    <cCall: 'X11_XUnmapEvent_type_get' plugin: 'x11'>
    self primitiveFailed
!
primXUnmapEventType: val
    <cCall: 'X11_XUnmapEvent_type_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"type accessors"
type
    ^self primXUnmapEventType
!
type: val
    ^self primXUnmapEventType: val
!

"_________________________________________________________"
"serial primitive accessors"
primXUnmapEventSerial
    <cCall: 'X11_XUnmapEvent_serial_get' plugin: 'x11'>
    self primitiveFailed
!
primXUnmapEventSerial: val
    <cCall: 'X11_XUnmapEvent_serial_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"serial accessors"
serial
    ^self primXUnmapEventSerial
!
serial: val
    ^self primXUnmapEventSerial: val
!

"_________________________________________________________"
"send_event primitive accessors"
primXUnmapEventSendEvent
    <cCall: 'X11_XUnmapEvent_send_event_get' plugin: 'x11'>
    self primitiveFailed
!
primXUnmapEventSendEvent: val
    <cCall: 'X11_XUnmapEvent_send_event_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"send_event accessors"
sendevent
    ^self primXUnmapEventSendEvent
!
sendevent: val
    ^self primXUnmapEventSendEvent: val
!

"_________________________________________________________"
"display primitive accessors"
primXUnmapEventDisplay
    <cCall: 'X11_XUnmapEvent_display_get' plugin: 'x11'>
    self primitiveFailed
!
primXUnmapEventDisplay: val
    <cCall: 'X11_XUnmapEvent_display_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"display accessors"
display
    ^self primXUnmapEventDisplay
!
display: val
    ^self primXUnmapEventDisplay: val
!

"_________________________________________________________"
"event primitive accessors"
primXUnmapEventEvent
    <cCall: 'X11_XUnmapEvent_event_get' plugin: 'x11'>
    self primitiveFailed
!
primXUnmapEventEvent: val
    <cCall: 'X11_XUnmapEvent_event_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"event accessors"
event
    ^self primXUnmapEventEvent
!
event: val
    ^self primXUnmapEventEvent: val
!

"_________________________________________________________"
"window primitive accessors"
primXUnmapEventWindow
    <cCall: 'X11_XUnmapEvent_window_get' plugin: 'x11'>
    self primitiveFailed
!
primXUnmapEventWindow: val
    <cCall: 'X11_XUnmapEvent_window_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"window accessors"
window
    ^self primXUnmapEventWindow
!
window: val
    ^self primXUnmapEventWindow: val
!

"_________________________________________________________"
"from_configure primitive accessors"
primXUnmapEventFromConfigure
    <cCall: 'X11_XUnmapEvent_from_configure_get' plugin: 'x11'>
    self primitiveFailed
!
primXUnmapEventFromConfigure: val
    <cCall: 'X11_XUnmapEvent_from_configure_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"from_configure accessors"
fromconfigure
    ^self primXUnmapEventFromConfigure
!
fromconfigure: val
    ^self primXUnmapEventFromConfigure: val
!






primX11XUnmapEventDelete
    <cCall: 'X11_delete_XUnmapEvent' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XUnmapEventDelete.
!


name
    ^'X11XUnmapEvent'

! !

!X11XUnmapEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XUnmapEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XIMHotKeyTriggers
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XIMHotKeyTriggers class methodsFor: 'initialize-release'!

primX11XIMHotKeyTriggersCreate
    <cCall: 'X11_new_XIMHotKeyTriggers' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XIMHotKeyTriggersCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XIMHotKeyTriggers  methodsFor: 'X11'!

"_________________________________________________________"
"num_hot_key primitive accessors"
primXIMHotKeyTriggersNumHotKey
    <cCall: 'X11_XIMHotKeyTriggers_num_hot_key_get' plugin: 'x11'>
    self primitiveFailed
!
primXIMHotKeyTriggersNumHotKey: val
    <cCall: 'X11_XIMHotKeyTriggers_num_hot_key_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"num_hot_key accessors"
numhotkey
    ^self primXIMHotKeyTriggersNumHotKey
!
numhotkey: val
    ^self primXIMHotKeyTriggersNumHotKey: val
!

"_________________________________________________________"
"key primitive accessors"
primXIMHotKeyTriggersKey
    <cCall: 'X11_XIMHotKeyTriggers_key_get' plugin: 'x11'>
    self primitiveFailed
!
primXIMHotKeyTriggersKey: val
    <cCall: 'X11_XIMHotKeyTriggers_key_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"key accessors"
key
    ^self primXIMHotKeyTriggersKey
!
key: val
    ^self primXIMHotKeyTriggersKey: val
!






primX11XIMHotKeyTriggersDelete
    <cCall: 'X11_delete_XIMHotKeyTriggers' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XIMHotKeyTriggersDelete.
!


name
    ^'X11XIMHotKeyTriggers'

! !

!X11XIMHotKeyTriggers methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XIMHotKeyTriggers methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XIMPreeditCaretCallbackStruct
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XIMPreeditCaretCallbackStruct class methodsFor: 'initialize-release'!

primX11XIMPreeditCaretCallbackStructCreate
    <cCall: 'X11_new_XIMPreeditCaretCallbackStruct' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XIMPreeditCaretCallbackStructCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XIMPreeditCaretCallbackStruct  methodsFor: 'X11'!

"_________________________________________________________"
"position primitive accessors"
primXIMPreeditCaretCallbackStructPosition
    <cCall: 'X11_XIMPreeditCaretCallbackStruct_position_get' plugin: 'x11'>
    self primitiveFailed
!
primXIMPreeditCaretCallbackStructPosition: val
    <cCall: 'X11_XIMPreeditCaretCallbackStruct_position_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"position accessors"
position
    ^self primXIMPreeditCaretCallbackStructPosition
!
position: val
    ^self primXIMPreeditCaretCallbackStructPosition: val
!

"_________________________________________________________"
"direction primitive accessors"
primXIMPreeditCaretCallbackStructDirection
    <cCall: 'X11_XIMPreeditCaretCallbackStruct_direction_get' plugin: 'x11'>
    self primitiveFailed
!
primXIMPreeditCaretCallbackStructDirection: val
    <cCall: 'X11_XIMPreeditCaretCallbackStruct_direction_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"direction accessors"
direction
    ^self primXIMPreeditCaretCallbackStructDirection
!
direction: val
    ^self primXIMPreeditCaretCallbackStructDirection: val
!

"_________________________________________________________"
"style primitive accessors"
primXIMPreeditCaretCallbackStructStyle
    <cCall: 'X11_XIMPreeditCaretCallbackStruct_style_get' plugin: 'x11'>
    self primitiveFailed
!
primXIMPreeditCaretCallbackStructStyle: val
    <cCall: 'X11_XIMPreeditCaretCallbackStruct_style_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"style accessors"
style
    ^self primXIMPreeditCaretCallbackStructStyle
!
style: val
    ^self primXIMPreeditCaretCallbackStructStyle: val
!






primX11XIMPreeditCaretCallbackStructDelete
    <cCall: 'X11_delete_XIMPreeditCaretCallbackStruct' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XIMPreeditCaretCallbackStructDelete.
!


name
    ^'X11XIMPreeditCaretCallbackStruct'

! !

!X11XIMPreeditCaretCallbackStruct methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XIMPreeditCaretCallbackStruct methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XErrorEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XErrorEvent class methodsFor: 'initialize-release'!

primX11XErrorEventCreate
    <cCall: 'X11_new_XErrorEvent' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XErrorEventCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XErrorEvent  methodsFor: 'X11'!

"_________________________________________________________"
"type primitive accessors"
primXErrorEventType
    <cCall: 'X11_XErrorEvent_type_get' plugin: 'x11'>
    self primitiveFailed
!
primXErrorEventType: val
    <cCall: 'X11_XErrorEvent_type_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"type accessors"
type
    ^self primXErrorEventType
!
type: val
    ^self primXErrorEventType: val
!

"_________________________________________________________"
"display primitive accessors"
primXErrorEventDisplay
    <cCall: 'X11_XErrorEvent_display_get' plugin: 'x11'>
    self primitiveFailed
!
primXErrorEventDisplay: val
    <cCall: 'X11_XErrorEvent_display_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"display accessors"
display
    ^self primXErrorEventDisplay
!
display: val
    ^self primXErrorEventDisplay: val
!

"_________________________________________________________"
"resourceid primitive accessors"
primXErrorEventResourceid
    <cCall: 'X11_XErrorEvent_resourceid_get' plugin: 'x11'>
    self primitiveFailed
!
primXErrorEventResourceid: val
    <cCall: 'X11_XErrorEvent_resourceid_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"resourceid accessors"
resourceid
    ^self primXErrorEventResourceid
!
resourceid: val
    ^self primXErrorEventResourceid: val
!

"_________________________________________________________"
"serial primitive accessors"
primXErrorEventSerial
    <cCall: 'X11_XErrorEvent_serial_get' plugin: 'x11'>
    self primitiveFailed
!
primXErrorEventSerial: val
    <cCall: 'X11_XErrorEvent_serial_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"serial accessors"
serial
    ^self primXErrorEventSerial
!
serial: val
    ^self primXErrorEventSerial: val
!

"_________________________________________________________"
"error_code primitive accessors"
primXErrorEventErrorCode
    <cCall: 'X11_XErrorEvent_error_code_get' plugin: 'x11'>
    self primitiveFailed
!
primXErrorEventErrorCode: val
    <cCall: 'X11_XErrorEvent_error_code_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"error_code accessors"
errorcode
    ^self primXErrorEventErrorCode
!
errorcode: val
    ^self primXErrorEventErrorCode: val
!

"_________________________________________________________"
"request_code primitive accessors"
primXErrorEventRequestCode
    <cCall: 'X11_XErrorEvent_request_code_get' plugin: 'x11'>
    self primitiveFailed
!
primXErrorEventRequestCode: val
    <cCall: 'X11_XErrorEvent_request_code_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"request_code accessors"
requestcode
    ^self primXErrorEventRequestCode
!
requestcode: val
    ^self primXErrorEventRequestCode: val
!

"_________________________________________________________"
"minor_code primitive accessors"
primXErrorEventMinorCode
    <cCall: 'X11_XErrorEvent_minor_code_get' plugin: 'x11'>
    self primitiveFailed
!
primXErrorEventMinorCode: val
    <cCall: 'X11_XErrorEvent_minor_code_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"minor_code accessors"
minorcode
    ^self primXErrorEventMinorCode
!
minorcode: val
    ^self primXErrorEventMinorCode: val
!






primX11XErrorEventDelete
    <cCall: 'X11_delete_XErrorEvent' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XErrorEventDelete.
!


name
    ^'X11XErrorEvent'

! !

!X11XErrorEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XErrorEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #X11XColor
        instanceVariableNames: ''
        classVariableNames: ''!

!X11XColor class methodsFor: 'initialize-release'!

primX11XColorCreate
    <cCall: 'X11_new_XColor' plugin: 'x11'>
    self primitiveFailed
!

create
    ^self handle: (self primX11XColorCreate).
!

initialize
    finalizationRequest := true.
! !

!X11XColor  methodsFor: 'X11'!

"_________________________________________________________"
"pixel primitive accessors"
primXColorPixel
    <cCall: 'X11_XColor_pixel_get' plugin: 'x11'>
    self primitiveFailed
!
primXColorPixel: val
    <cCall: 'X11_XColor_pixel_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"pixel accessors"
pixel
    ^self primXColorPixel
!
pixel: val
    ^self primXColorPixel: val
!

"_________________________________________________________"
"red primitive accessors"
primXColorRed
    <cCall: 'X11_XColor_red_get' plugin: 'x11'>
    self primitiveFailed
!
primXColorRed: val
    <cCall: 'X11_XColor_red_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"red accessors"
red
    ^self primXColorRed
!
red: val
    ^self primXColorRed: val
!

"_________________________________________________________"
"green primitive accessors"
primXColorGreen
    <cCall: 'X11_XColor_green_get' plugin: 'x11'>
    self primitiveFailed
!
primXColorGreen: val
    <cCall: 'X11_XColor_green_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"green accessors"
green
    ^self primXColorGreen
!
green: val
    ^self primXColorGreen: val
!

"_________________________________________________________"
"blue primitive accessors"
primXColorBlue
    <cCall: 'X11_XColor_blue_get' plugin: 'x11'>
    self primitiveFailed
!
primXColorBlue: val
    <cCall: 'X11_XColor_blue_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"blue accessors"
blue
    ^self primXColorBlue
!
blue: val
    ^self primXColorBlue: val
!

"_________________________________________________________"
"flags primitive accessors"
primXColorFlags
    <cCall: 'X11_XColor_flags_get' plugin: 'x11'>
    self primitiveFailed
!
primXColorFlags: val
    <cCall: 'X11_XColor_flags_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"flags accessors"
flags
    ^self primXColorFlags
!
flags: val
    ^self primXColorFlags: val
!

"_________________________________________________________"
"pad primitive accessors"
primXColorPad
    <cCall: 'X11_XColor_pad_get' plugin: 'x11'>
    self primitiveFailed
!
primXColorPad: val
    <cCall: 'X11_XColor_pad_set' plugin: 'x11'>
    self primitiveFailed
!
"........................................................"
"pad accessors"
pad
    ^self primXColorPad
!
pad: val
    ^self primXColorPad: val
!






primX11XColorDelete
    <cCall: 'X11_delete_XColor' plugin: 'x11'>
    self primitiveFailed
!

delete
    ^self primX11XColorDelete.
!


name
    ^'X11XColor'

! !

!X11XColor methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!X11XColor methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
