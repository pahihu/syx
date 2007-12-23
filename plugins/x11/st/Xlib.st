CStruct subclass: #XlibXlib
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXlib class methodsFor: 'initialize-release'!

initialize
    finalizationRequest := true.
! !

!XlibXlib class methodsFor: 'Xlib'!



"_________________________________________________________"
"maxKeysPerMod primitive function"
primXNewModifiermap: arg1
    <cCall: 'Xlib_XNewModifiermap' plugin: 'x11'>
!

"_________________________________________________________"
"displayName primitive function"
primXOpenDisplay: arg1
    <cCall: 'Xlib_XOpenDisplay' plugin: 'x11'>
!

"_________________________________________________________"
"XrmInitialize primitive function"
primXrmInitialize
    <cCall: 'Xlib_XrmInitialize' plugin: 'x11'>
!

"_________________________________________________________"
"string primitive function"
primXDisplayName: arg1
    <cCall: 'Xlib_XDisplayName' plugin: 'x11'>
!

"_________________________________________________________"
"keysym primitive function"
primXKeysymToString: arg1
    <cCall: 'Xlib_XKeysymToString' plugin: 'x11'>
!

"_________________________________________________________"
"string primitive function"
primXStringToKeysym: arg1
    <cCall: 'Xlib_XStringToKeysym' plugin: 'x11'>
!

"_________________________________________________________"
"XInitThreads primitive function"
primXInitThreads
    <cCall: 'Xlib_XInitThreads' plugin: 'x11'>
!

"_________________________________________________________"
"XAllPlanes primitive function"
primXAllPlanes
    <cCall: 'Xlib_XAllPlanes' plugin: 'x11'>
!

"_________________________________________________________"
"handler primitive function"
primXSetErrorHandler: arg1
    <cCall: 'Xlib_XSetErrorHandler' plugin: 'x11'>
!

"_________________________________________________________"
"handler primitive function"
primXSetIOErrorHandler: arg1
    <cCall: 'Xlib_XSetIOErrorHandler' plugin: 'x11'>
!

"_________________________________________________________"
"list primitive function"
primXFreeStringList: arg1
    <cCall: 'Xlib_XFreeStringList' plugin: 'x11'>
!

"_________________________________________________________"
"data primitive function"
primXFree: arg1
    <cCall: 'Xlib_XFree' plugin: 'x11'>
!

"_________________________________________________________"
"list primitive function"
primXFreeExtensionList: arg1
    <cCall: 'Xlib_XFreeExtensionList' plugin: 'x11'>
!

"_________________________________________________________"
"actualCount primitive function"
primXFreeFontInfo: arg1 freeInfo: arg2 actualCount: arg3
    <cCall: 'Xlib_XFreeFontInfo' plugin: 'x11'>
!

"_________________________________________________________"
"list primitive function"
primXFreeFontNames: arg1
    <cCall: 'Xlib_XFreeFontNames' plugin: 'x11'>
!

"_________________________________________________________"
"list primitive function"
primXFreeFontPath: arg1
    <cCall: 'Xlib_XFreeFontPath' plugin: 'x11'>
!

"_________________________________________________________"
"heightReturn primitive function"
primXParseGeometry: arg1 xReturn: arg2 yReturn: arg3 widthReturn: arg4 heightReturn: arg5
    <cCall: 'Xlib_XParseGeometry' plugin: 'x11'>
!

"_________________________________________________________"
"yHotReturn primitive function"
primXReadBitmapFileData: arg1 widthReturn: arg2 heightReturn: arg3 dataReturn: arg4 xHotReturn: arg5 yHotReturn: arg6
    <cCall: 'Xlib_XReadBitmapFileData' plugin: 'x11'>
!

"_________________________________________________________"
"XSupportsLocale primitive function"
primXSupportsLocale
    <cCall: 'Xlib_XSupportsLocale' plugin: 'x11'>
!

"_________________________________________________________"
"modifierList primitive function"
primXSetLocaleModifiers: arg1
    <cCall: 'Xlib_XSetLocaleModifiers' plugin: 'x11'>
!

"_________________________________________________________"
"unused primitive function"
primXVaCreateNestedList: arg1
    <cCall: 'Xlib_XVaCreateNestedList' plugin: 'x11'>
!





name
    ^'XlibXlib'

! !

!XlibXlib methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXlib methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXIMStatusDrawCallbackStruct
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXIMStatusDrawCallbackStruct class methodsFor: 'initialize-release'!

primXlibXIMStatusDrawCallbackStructCreate
    <cCall: 'Xlib_new_XIMStatusDrawCallbackStruct' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXIMStatusDrawCallbackStructCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXIMStatusDrawCallbackStruct  methodsFor: 'Xlib'!

"_________________________________________________________"
"type primitive accessors"
primXIMStatusDrawCallbackStructType
    <cCall: 'Xlib_XIMStatusDrawCallbackStruct_type_get' plugin: 'x11'>
!
primXIMStatusDrawCallbackStructType: val
    <cCall: 'Xlib_XIMStatusDrawCallbackStruct_type_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XIMStatusDrawCallbackStruct_data_get' plugin: 'x11'>
!
primXIMStatusDrawCallbackStructData: val
    <cCall: 'Xlib_XIMStatusDrawCallbackStruct_data_set' plugin: 'x11'>
!
"........................................................"
"data accessors"
data
    ^self primXIMStatusDrawCallbackStructData
!
data: val
    ^self primXIMStatusDrawCallbackStructData: val
!






primXlibXIMStatusDrawCallbackStructDelete
    <cCall: 'Xlib_delete_XIMStatusDrawCallbackStruct' plugin: 'x11'>
!

delete
    ^self primXlibXIMStatusDrawCallbackStructDelete.
!


name
    ^'XlibXIMStatusDrawCallbackStruct'

! !

!XlibXIMStatusDrawCallbackStruct methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXIMStatusDrawCallbackStruct methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXIMPreeditDrawCallbackStruct
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXIMPreeditDrawCallbackStruct class methodsFor: 'initialize-release'!

primXlibXIMPreeditDrawCallbackStructCreate
    <cCall: 'Xlib_new_XIMPreeditDrawCallbackStruct' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXIMPreeditDrawCallbackStructCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXIMPreeditDrawCallbackStruct  methodsFor: 'Xlib'!

"_________________________________________________________"
"caret primitive accessors"
primXIMPreeditDrawCallbackStructCaret
    <cCall: 'Xlib_XIMPreeditDrawCallbackStruct_caret_get' plugin: 'x11'>
!
primXIMPreeditDrawCallbackStructCaret: val
    <cCall: 'Xlib_XIMPreeditDrawCallbackStruct_caret_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XIMPreeditDrawCallbackStruct_chg_first_get' plugin: 'x11'>
!
primXIMPreeditDrawCallbackStructChgFirst: val
    <cCall: 'Xlib_XIMPreeditDrawCallbackStruct_chg_first_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XIMPreeditDrawCallbackStruct_chg_length_get' plugin: 'x11'>
!
primXIMPreeditDrawCallbackStructChgLength: val
    <cCall: 'Xlib_XIMPreeditDrawCallbackStruct_chg_length_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XIMPreeditDrawCallbackStruct_text_get' plugin: 'x11'>
!
primXIMPreeditDrawCallbackStructText: val
    <cCall: 'Xlib_XIMPreeditDrawCallbackStruct_text_set' plugin: 'x11'>
!
"........................................................"
"text accessors"
text
    ^self primXIMPreeditDrawCallbackStructText
!
text: val
    ^self primXIMPreeditDrawCallbackStructText: val
!






primXlibXIMPreeditDrawCallbackStructDelete
    <cCall: 'Xlib_delete_XIMPreeditDrawCallbackStruct' plugin: 'x11'>
!

delete
    ^self primXlibXIMPreeditDrawCallbackStructDelete.
!


name
    ^'XlibXIMPreeditDrawCallbackStruct'

! !

!XlibXIMPreeditDrawCallbackStruct methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXIMPreeditDrawCallbackStruct methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXKeyEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXKeyEvent class methodsFor: 'initialize-release'!

primXlibXKeyEventCreate
    <cCall: 'Xlib_new_XKeyEvent' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXKeyEventCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXKeyEvent  methodsFor: 'Xlib'!

"_________________________________________________________"
"type primitive accessors"
primXKeyEventType
    <cCall: 'Xlib_XKeyEvent_type_get' plugin: 'x11'>
!
primXKeyEventType: val
    <cCall: 'Xlib_XKeyEvent_type_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XKeyEvent_serial_get' plugin: 'x11'>
!
primXKeyEventSerial: val
    <cCall: 'Xlib_XKeyEvent_serial_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XKeyEvent_send_event_get' plugin: 'x11'>
!
primXKeyEventSendEvent: val
    <cCall: 'Xlib_XKeyEvent_send_event_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XKeyEvent_display_get' plugin: 'x11'>
!
primXKeyEventDisplay: val
    <cCall: 'Xlib_XKeyEvent_display_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XKeyEvent_window_get' plugin: 'x11'>
!
primXKeyEventWindow: val
    <cCall: 'Xlib_XKeyEvent_window_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XKeyEvent_root_get' plugin: 'x11'>
!
primXKeyEventRoot: val
    <cCall: 'Xlib_XKeyEvent_root_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XKeyEvent_subwindow_get' plugin: 'x11'>
!
primXKeyEventSubwindow: val
    <cCall: 'Xlib_XKeyEvent_subwindow_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XKeyEvent_time_get' plugin: 'x11'>
!
primXKeyEventTime: val
    <cCall: 'Xlib_XKeyEvent_time_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XKeyEvent_x_get' plugin: 'x11'>
!
primXKeyEventX: val
    <cCall: 'Xlib_XKeyEvent_x_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XKeyEvent_y_get' plugin: 'x11'>
!
primXKeyEventY: val
    <cCall: 'Xlib_XKeyEvent_y_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XKeyEvent_x_root_get' plugin: 'x11'>
!
primXKeyEventXRoot: val
    <cCall: 'Xlib_XKeyEvent_x_root_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XKeyEvent_y_root_get' plugin: 'x11'>
!
primXKeyEventYRoot: val
    <cCall: 'Xlib_XKeyEvent_y_root_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XKeyEvent_state_get' plugin: 'x11'>
!
primXKeyEventState: val
    <cCall: 'Xlib_XKeyEvent_state_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XKeyEvent_keycode_get' plugin: 'x11'>
!
primXKeyEventKeycode: val
    <cCall: 'Xlib_XKeyEvent_keycode_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XKeyEvent_same_screen_get' plugin: 'x11'>
!
primXKeyEventSameScreen: val
    <cCall: 'Xlib_XKeyEvent_same_screen_set' plugin: 'x11'>
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
"index primitive function"
primXLookupKeysym: arg1
    <cCall: 'Xlib_XLookupKeysym' plugin: 'x11'>
!




primXlibXKeyEventDelete
    <cCall: 'Xlib_delete_XKeyEvent' plugin: 'x11'>
!

delete
    ^self primXlibXKeyEventDelete.
!


name
    ^'XlibXKeyEvent'

! !

!XlibXKeyEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXKeyEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXMapRequestEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXMapRequestEvent class methodsFor: 'initialize-release'!

primXlibXMapRequestEventCreate
    <cCall: 'Xlib_new_XMapRequestEvent' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXMapRequestEventCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXMapRequestEvent  methodsFor: 'Xlib'!

"_________________________________________________________"
"type primitive accessors"
primXMapRequestEventType
    <cCall: 'Xlib_XMapRequestEvent_type_get' plugin: 'x11'>
!
primXMapRequestEventType: val
    <cCall: 'Xlib_XMapRequestEvent_type_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XMapRequestEvent_serial_get' plugin: 'x11'>
!
primXMapRequestEventSerial: val
    <cCall: 'Xlib_XMapRequestEvent_serial_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XMapRequestEvent_send_event_get' plugin: 'x11'>
!
primXMapRequestEventSendEvent: val
    <cCall: 'Xlib_XMapRequestEvent_send_event_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XMapRequestEvent_display_get' plugin: 'x11'>
!
primXMapRequestEventDisplay: val
    <cCall: 'Xlib_XMapRequestEvent_display_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XMapRequestEvent_parent_get' plugin: 'x11'>
!
primXMapRequestEventParent: val
    <cCall: 'Xlib_XMapRequestEvent_parent_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XMapRequestEvent_window_get' plugin: 'x11'>
!
primXMapRequestEventWindow: val
    <cCall: 'Xlib_XMapRequestEvent_window_set' plugin: 'x11'>
!
"........................................................"
"window accessors"
window
    ^self primXMapRequestEventWindow
!
window: val
    ^self primXMapRequestEventWindow: val
!






primXlibXMapRequestEventDelete
    <cCall: 'Xlib_delete_XMapRequestEvent' plugin: 'x11'>
!

delete
    ^self primXlibXMapRequestEventDelete.
!


name
    ^'XlibXMapRequestEvent'

! !

!XlibXMapRequestEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXMapRequestEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXTextItem
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXTextItem class methodsFor: 'initialize-release'!

primXlibXTextItemCreate
    <cCall: 'Xlib_new_XTextItem' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXTextItemCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXTextItem  methodsFor: 'Xlib'!

"_________________________________________________________"
"chars primitive accessors"
primXTextItemChars
    <cCall: 'Xlib_XTextItem_chars_get' plugin: 'x11'>
!
primXTextItemChars: val
    <cCall: 'Xlib_XTextItem_chars_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XTextItem_nchars_get' plugin: 'x11'>
!
primXTextItemNchars: val
    <cCall: 'Xlib_XTextItem_nchars_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XTextItem_delta_get' plugin: 'x11'>
!
primXTextItemDelta: val
    <cCall: 'Xlib_XTextItem_delta_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XTextItem_font_get' plugin: 'x11'>
!
primXTextItemFont: val
    <cCall: 'Xlib_XTextItem_font_set' plugin: 'x11'>
!
"........................................................"
"font accessors"
font
    ^self primXTextItemFont
!
font: val
    ^self primXTextItemFont: val
!






primXlibXTextItemDelete
    <cCall: 'Xlib_delete_XTextItem' plugin: 'x11'>
!

delete
    ^self primXlibXTextItemDelete.
!


name
    ^'XlibXTextItem'

! !

!XlibXTextItem methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXTextItem methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibVisual
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibVisual class methodsFor: 'initialize-release'!

primXlibVisualCreate
    <cCall: 'Xlib_new_Visual' plugin: 'x11'>
!

create
    ^self handle: (self primXlibVisualCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibVisual  methodsFor: 'Xlib'!

"_________________________________________________________"
"ext_data primitive accessors"
primVisualExtData
    <cCall: 'Xlib_Visual_ext_data_get' plugin: 'x11'>
!
primVisualExtData: val
    <cCall: 'Xlib_Visual_ext_data_set' plugin: 'x11'>
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
    <cCall: 'Xlib_Visual_visualid_get' plugin: 'x11'>
!
primVisualVisualid: val
    <cCall: 'Xlib_Visual_visualid_set' plugin: 'x11'>
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
    <cCall: 'Xlib_Visual_class_get' plugin: 'x11'>
!
primVisualClass: val
    <cCall: 'Xlib_Visual_class_set' plugin: 'x11'>
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
    <cCall: 'Xlib_Visual_red_mask_get' plugin: 'x11'>
!
primVisualRedMask: val
    <cCall: 'Xlib_Visual_red_mask_set' plugin: 'x11'>
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
    <cCall: 'Xlib_Visual_green_mask_get' plugin: 'x11'>
!
primVisualGreenMask: val
    <cCall: 'Xlib_Visual_green_mask_set' plugin: 'x11'>
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
    <cCall: 'Xlib_Visual_blue_mask_get' plugin: 'x11'>
!
primVisualBlueMask: val
    <cCall: 'Xlib_Visual_blue_mask_set' plugin: 'x11'>
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
    <cCall: 'Xlib_Visual_bits_per_rgb_get' plugin: 'x11'>
!
primVisualBitsPerRgb: val
    <cCall: 'Xlib_Visual_bits_per_rgb_set' plugin: 'x11'>
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
    <cCall: 'Xlib_Visual_map_entries_get' plugin: 'x11'>
!
primVisualMapEntries: val
    <cCall: 'Xlib_Visual_map_entries_set' plugin: 'x11'>
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
"visual primitive function"
primXVisualIDFromVisual
    <cCall: 'Xlib_XVisualIDFromVisual' plugin: 'x11'>
!




primXlibVisualDelete
    <cCall: 'Xlib_delete_Visual' plugin: 'x11'>
!

delete
    ^self primXlibVisualDelete.
!


name
    ^'XlibVisual'

! !

!XlibVisual methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibVisual methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXCrossingEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXCrossingEvent class methodsFor: 'initialize-release'!

primXlibXCrossingEventCreate
    <cCall: 'Xlib_new_XCrossingEvent' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXCrossingEventCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXCrossingEvent  methodsFor: 'Xlib'!

"_________________________________________________________"
"type primitive accessors"
primXCrossingEventType
    <cCall: 'Xlib_XCrossingEvent_type_get' plugin: 'x11'>
!
primXCrossingEventType: val
    <cCall: 'Xlib_XCrossingEvent_type_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XCrossingEvent_serial_get' plugin: 'x11'>
!
primXCrossingEventSerial: val
    <cCall: 'Xlib_XCrossingEvent_serial_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XCrossingEvent_send_event_get' plugin: 'x11'>
!
primXCrossingEventSendEvent: val
    <cCall: 'Xlib_XCrossingEvent_send_event_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XCrossingEvent_display_get' plugin: 'x11'>
!
primXCrossingEventDisplay: val
    <cCall: 'Xlib_XCrossingEvent_display_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XCrossingEvent_window_get' plugin: 'x11'>
!
primXCrossingEventWindow: val
    <cCall: 'Xlib_XCrossingEvent_window_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XCrossingEvent_root_get' plugin: 'x11'>
!
primXCrossingEventRoot: val
    <cCall: 'Xlib_XCrossingEvent_root_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XCrossingEvent_subwindow_get' plugin: 'x11'>
!
primXCrossingEventSubwindow: val
    <cCall: 'Xlib_XCrossingEvent_subwindow_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XCrossingEvent_time_get' plugin: 'x11'>
!
primXCrossingEventTime: val
    <cCall: 'Xlib_XCrossingEvent_time_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XCrossingEvent_x_get' plugin: 'x11'>
!
primXCrossingEventX: val
    <cCall: 'Xlib_XCrossingEvent_x_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XCrossingEvent_y_get' plugin: 'x11'>
!
primXCrossingEventY: val
    <cCall: 'Xlib_XCrossingEvent_y_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XCrossingEvent_x_root_get' plugin: 'x11'>
!
primXCrossingEventXRoot: val
    <cCall: 'Xlib_XCrossingEvent_x_root_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XCrossingEvent_y_root_get' plugin: 'x11'>
!
primXCrossingEventYRoot: val
    <cCall: 'Xlib_XCrossingEvent_y_root_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XCrossingEvent_mode_get' plugin: 'x11'>
!
primXCrossingEventMode: val
    <cCall: 'Xlib_XCrossingEvent_mode_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XCrossingEvent_detail_get' plugin: 'x11'>
!
primXCrossingEventDetail: val
    <cCall: 'Xlib_XCrossingEvent_detail_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XCrossingEvent_same_screen_get' plugin: 'x11'>
!
primXCrossingEventSameScreen: val
    <cCall: 'Xlib_XCrossingEvent_same_screen_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XCrossingEvent_focus_get' plugin: 'x11'>
!
primXCrossingEventFocus: val
    <cCall: 'Xlib_XCrossingEvent_focus_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XCrossingEvent_state_get' plugin: 'x11'>
!
primXCrossingEventState: val
    <cCall: 'Xlib_XCrossingEvent_state_set' plugin: 'x11'>
!
"........................................................"
"state accessors"
state
    ^self primXCrossingEventState
!
state: val
    ^self primXCrossingEventState: val
!






primXlibXCrossingEventDelete
    <cCall: 'Xlib_delete_XCrossingEvent' plugin: 'x11'>
!

delete
    ^self primXlibXCrossingEventDelete.
!


name
    ^'XlibXCrossingEvent'

! !

!XlibXCrossingEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXCrossingEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXIMStatusDrawCallbackStructData
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXIMStatusDrawCallbackStructData class methodsFor: 'initialize-release'!

primXlibXIMStatusDrawCallbackStructDataCreate
    <cCall: 'Xlib_new_XIMStatusDrawCallbackStruct_data' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXIMStatusDrawCallbackStructDataCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXIMStatusDrawCallbackStructData  methodsFor: 'Xlib'!

"_________________________________________________________"
"text primitive accessors"
primXIMStatusDrawCallbackStructDataText
    <cCall: 'Xlib_XIMStatusDrawCallbackStruct_data_text_get' plugin: 'x11'>
!
primXIMStatusDrawCallbackStructDataText: val
    <cCall: 'Xlib_XIMStatusDrawCallbackStruct_data_text_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XIMStatusDrawCallbackStruct_data_bitmap_get' plugin: 'x11'>
!
primXIMStatusDrawCallbackStructDataBitmap: val
    <cCall: 'Xlib_XIMStatusDrawCallbackStruct_data_bitmap_set' plugin: 'x11'>
!
"........................................................"
"bitmap accessors"
bitmap
    ^self primXIMStatusDrawCallbackStructDataBitmap
!
bitmap: val
    ^self primXIMStatusDrawCallbackStructDataBitmap: val
!






primXlibXIMStatusDrawCallbackStructDataDelete
    <cCall: 'Xlib_delete_XIMStatusDrawCallbackStruct_data' plugin: 'x11'>
!

delete
    ^self primXlibXIMStatusDrawCallbackStructDataDelete.
!


name
    ^'XlibXIMStatusDrawCallbackStructData'

! !

!XlibXIMStatusDrawCallbackStructData methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXIMStatusDrawCallbackStructData methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXOMFontInfo
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXOMFontInfo class methodsFor: 'initialize-release'!

primXlibXOMFontInfoCreate
    <cCall: 'Xlib_new_XOMFontInfo' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXOMFontInfoCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXOMFontInfo  methodsFor: 'Xlib'!

"_________________________________________________________"
"num_font primitive accessors"
primXOMFontInfoNumFont
    <cCall: 'Xlib_XOMFontInfo_num_font_get' plugin: 'x11'>
!
primXOMFontInfoNumFont: val
    <cCall: 'Xlib_XOMFontInfo_num_font_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XOMFontInfo_font_struct_list_get' plugin: 'x11'>
!
primXOMFontInfoFontStructList: val
    <cCall: 'Xlib_XOMFontInfo_font_struct_list_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XOMFontInfo_font_name_list_get' plugin: 'x11'>
!
primXOMFontInfoFontNameList: val
    <cCall: 'Xlib_XOMFontInfo_font_name_list_set' plugin: 'x11'>
!
"........................................................"
"font_name_list accessors"
fontnamelist
    ^self primXOMFontInfoFontNameList
!
fontnamelist: val
    ^self primXOMFontInfoFontNameList: val
!






primXlibXOMFontInfoDelete
    <cCall: 'Xlib_delete_XOMFontInfo' plugin: 'x11'>
!

delete
    ^self primXlibXOMFontInfoDelete.
!


name
    ^'XlibXOMFontInfo'

! !

!XlibXOMFontInfo methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXOMFontInfo methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXFontProp
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXFontProp class methodsFor: 'initialize-release'!

primXlibXFontPropCreate
    <cCall: 'Xlib_new_XFontProp' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXFontPropCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXFontProp  methodsFor: 'Xlib'!

"_________________________________________________________"
"name primitive accessors"
primXFontPropName
    <cCall: 'Xlib_XFontProp_name_get' plugin: 'x11'>
!
primXFontPropName: val
    <cCall: 'Xlib_XFontProp_name_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XFontProp_card32_get' plugin: 'x11'>
!
primXFontPropCard32: val
    <cCall: 'Xlib_XFontProp_card32_set' plugin: 'x11'>
!
"........................................................"
"card32 accessors"
card32
    ^self primXFontPropCard32
!
card32: val
    ^self primXFontPropCard32: val
!






primXlibXFontPropDelete
    <cCall: 'Xlib_delete_XFontProp' plugin: 'x11'>
!

delete
    ^self primXlibXFontPropDelete.
!


name
    ^'XlibXFontProp'

! !

!XlibXFontProp methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXFontProp methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXSelectionEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXSelectionEvent class methodsFor: 'initialize-release'!

primXlibXSelectionEventCreate
    <cCall: 'Xlib_new_XSelectionEvent' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXSelectionEventCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXSelectionEvent  methodsFor: 'Xlib'!

"_________________________________________________________"
"type primitive accessors"
primXSelectionEventType
    <cCall: 'Xlib_XSelectionEvent_type_get' plugin: 'x11'>
!
primXSelectionEventType: val
    <cCall: 'Xlib_XSelectionEvent_type_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XSelectionEvent_serial_get' plugin: 'x11'>
!
primXSelectionEventSerial: val
    <cCall: 'Xlib_XSelectionEvent_serial_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XSelectionEvent_send_event_get' plugin: 'x11'>
!
primXSelectionEventSendEvent: val
    <cCall: 'Xlib_XSelectionEvent_send_event_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XSelectionEvent_display_get' plugin: 'x11'>
!
primXSelectionEventDisplay: val
    <cCall: 'Xlib_XSelectionEvent_display_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XSelectionEvent_requestor_get' plugin: 'x11'>
!
primXSelectionEventRequestor: val
    <cCall: 'Xlib_XSelectionEvent_requestor_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XSelectionEvent_selection_get' plugin: 'x11'>
!
primXSelectionEventSelection: val
    <cCall: 'Xlib_XSelectionEvent_selection_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XSelectionEvent_target_get' plugin: 'x11'>
!
primXSelectionEventTarget: val
    <cCall: 'Xlib_XSelectionEvent_target_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XSelectionEvent_property_get' plugin: 'x11'>
!
primXSelectionEventProperty: val
    <cCall: 'Xlib_XSelectionEvent_property_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XSelectionEvent_time_get' plugin: 'x11'>
!
primXSelectionEventTime: val
    <cCall: 'Xlib_XSelectionEvent_time_set' plugin: 'x11'>
!
"........................................................"
"time accessors"
time
    ^self primXSelectionEventTime
!
time: val
    ^self primXSelectionEventTime: val
!






primXlibXSelectionEventDelete
    <cCall: 'Xlib_delete_XSelectionEvent' plugin: 'x11'>
!

delete
    ^self primXlibXSelectionEventDelete.
!


name
    ^'XlibXSelectionEvent'

! !

!XlibXSelectionEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXSelectionEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXPixmapFormatValues
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXPixmapFormatValues class methodsFor: 'initialize-release'!

primXlibXPixmapFormatValuesCreate
    <cCall: 'Xlib_new_XPixmapFormatValues' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXPixmapFormatValuesCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXPixmapFormatValues  methodsFor: 'Xlib'!

"_________________________________________________________"
"depth primitive accessors"
primXPixmapFormatValuesDepth
    <cCall: 'Xlib_XPixmapFormatValues_depth_get' plugin: 'x11'>
!
primXPixmapFormatValuesDepth: val
    <cCall: 'Xlib_XPixmapFormatValues_depth_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XPixmapFormatValues_bits_per_pixel_get' plugin: 'x11'>
!
primXPixmapFormatValuesBitsPerPixel: val
    <cCall: 'Xlib_XPixmapFormatValues_bits_per_pixel_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XPixmapFormatValues_scanline_pad_get' plugin: 'x11'>
!
primXPixmapFormatValuesScanlinePad: val
    <cCall: 'Xlib_XPixmapFormatValues_scanline_pad_set' plugin: 'x11'>
!
"........................................................"
"scanline_pad accessors"
scanlinepad
    ^self primXPixmapFormatValuesScanlinePad
!
scanlinepad: val
    ^self primXPixmapFormatValuesScanlinePad: val
!






primXlibXPixmapFormatValuesDelete
    <cCall: 'Xlib_delete_XPixmapFormatValues' plugin: 'x11'>
!

delete
    ^self primXlibXPixmapFormatValuesDelete.
!


name
    ^'XlibXPixmapFormatValues'

! !

!XlibXPixmapFormatValues methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXPixmapFormatValues methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXPoint
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXPoint class methodsFor: 'initialize-release'!

primXlibXPointCreate
    <cCall: 'Xlib_new_XPoint' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXPointCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXPoint  methodsFor: 'Xlib'!

"_________________________________________________________"
"x primitive accessors"
primXPointX
    <cCall: 'Xlib_XPoint_x_get' plugin: 'x11'>
!
primXPointX: val
    <cCall: 'Xlib_XPoint_x_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XPoint_y_get' plugin: 'x11'>
!
primXPointY: val
    <cCall: 'Xlib_XPoint_y_set' plugin: 'x11'>
!
"........................................................"
"y accessors"
y
    ^self primXPointY
!
y: val
    ^self primXPointY: val
!






primXlibXPointDelete
    <cCall: 'Xlib_delete_XPoint' plugin: 'x11'>
!

delete
    ^self primXlibXPointDelete.
!


name
    ^'XlibXPoint'

! !

!XlibXPoint methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXPoint methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXCirculateRequestEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXCirculateRequestEvent class methodsFor: 'initialize-release'!

primXlibXCirculateRequestEventCreate
    <cCall: 'Xlib_new_XCirculateRequestEvent' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXCirculateRequestEventCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXCirculateRequestEvent  methodsFor: 'Xlib'!

"_________________________________________________________"
"type primitive accessors"
primXCirculateRequestEventType
    <cCall: 'Xlib_XCirculateRequestEvent_type_get' plugin: 'x11'>
!
primXCirculateRequestEventType: val
    <cCall: 'Xlib_XCirculateRequestEvent_type_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XCirculateRequestEvent_serial_get' plugin: 'x11'>
!
primXCirculateRequestEventSerial: val
    <cCall: 'Xlib_XCirculateRequestEvent_serial_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XCirculateRequestEvent_send_event_get' plugin: 'x11'>
!
primXCirculateRequestEventSendEvent: val
    <cCall: 'Xlib_XCirculateRequestEvent_send_event_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XCirculateRequestEvent_display_get' plugin: 'x11'>
!
primXCirculateRequestEventDisplay: val
    <cCall: 'Xlib_XCirculateRequestEvent_display_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XCirculateRequestEvent_parent_get' plugin: 'x11'>
!
primXCirculateRequestEventParent: val
    <cCall: 'Xlib_XCirculateRequestEvent_parent_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XCirculateRequestEvent_window_get' plugin: 'x11'>
!
primXCirculateRequestEventWindow: val
    <cCall: 'Xlib_XCirculateRequestEvent_window_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XCirculateRequestEvent_place_get' plugin: 'x11'>
!
primXCirculateRequestEventPlace: val
    <cCall: 'Xlib_XCirculateRequestEvent_place_set' plugin: 'x11'>
!
"........................................................"
"place accessors"
place
    ^self primXCirculateRequestEventPlace
!
place: val
    ^self primXCirculateRequestEventPlace: val
!






primXlibXCirculateRequestEventDelete
    <cCall: 'Xlib_delete_XCirculateRequestEvent' plugin: 'x11'>
!

delete
    ^self primXlibXCirculateRequestEventDelete.
!


name
    ^'XlibXCirculateRequestEvent'

! !

!XlibXCirculateRequestEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXCirculateRequestEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibGC
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibGC class methodsFor: 'initialize-release'!

primXlibGCCreate
    <cCall: 'Xlib_new_GC' plugin: 'x11'>
!

create
    ^self handle: (self primXlibGCCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibGC  methodsFor: 'Xlib'!



"_________________________________________________________"
"gc primitive function"
primXGContextFromGC
    <cCall: 'Xlib_XGContextFromGC' plugin: 'x11'>
!




primXlibGCDelete
    <cCall: 'Xlib_delete_GC' plugin: 'x11'>
!

delete
    ^self primXlibGCDelete.
!


name
    ^'XlibGC'

! !

!XlibGC methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibGC methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXAnyEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXAnyEvent class methodsFor: 'initialize-release'!

primXlibXAnyEventCreate
    <cCall: 'Xlib_new_XAnyEvent' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXAnyEventCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXAnyEvent  methodsFor: 'Xlib'!

"_________________________________________________________"
"type primitive accessors"
primXAnyEventType
    <cCall: 'Xlib_XAnyEvent_type_get' plugin: 'x11'>
!
primXAnyEventType: val
    <cCall: 'Xlib_XAnyEvent_type_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XAnyEvent_serial_get' plugin: 'x11'>
!
primXAnyEventSerial: val
    <cCall: 'Xlib_XAnyEvent_serial_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XAnyEvent_send_event_get' plugin: 'x11'>
!
primXAnyEventSendEvent: val
    <cCall: 'Xlib_XAnyEvent_send_event_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XAnyEvent_display_get' plugin: 'x11'>
!
primXAnyEventDisplay: val
    <cCall: 'Xlib_XAnyEvent_display_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XAnyEvent_window_get' plugin: 'x11'>
!
primXAnyEventWindow: val
    <cCall: 'Xlib_XAnyEvent_window_set' plugin: 'x11'>
!
"........................................................"
"window accessors"
window
    ^self primXAnyEventWindow
!
window: val
    ^self primXAnyEventWindow: val
!






primXlibXAnyEventDelete
    <cCall: 'Xlib_delete_XAnyEvent' plugin: 'x11'>
!

delete
    ^self primXlibXAnyEventDelete.
!


name
    ^'XlibXAnyEvent'

! !

!XlibXAnyEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXAnyEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXArc
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXArc class methodsFor: 'initialize-release'!

primXlibXArcCreate
    <cCall: 'Xlib_new_XArc' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXArcCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXArc  methodsFor: 'Xlib'!

"_________________________________________________________"
"x primitive accessors"
primXArcX
    <cCall: 'Xlib_XArc_x_get' plugin: 'x11'>
!
primXArcX: val
    <cCall: 'Xlib_XArc_x_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XArc_y_get' plugin: 'x11'>
!
primXArcY: val
    <cCall: 'Xlib_XArc_y_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XArc_width_get' plugin: 'x11'>
!
primXArcWidth: val
    <cCall: 'Xlib_XArc_width_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XArc_height_get' plugin: 'x11'>
!
primXArcHeight: val
    <cCall: 'Xlib_XArc_height_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XArc_angle1_get' plugin: 'x11'>
!
primXArcAngle1: val
    <cCall: 'Xlib_XArc_angle1_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XArc_angle2_get' plugin: 'x11'>
!
primXArcAngle2: val
    <cCall: 'Xlib_XArc_angle2_set' plugin: 'x11'>
!
"........................................................"
"angle2 accessors"
angle2
    ^self primXArcAngle2
!
angle2: val
    ^self primXArcAngle2: val
!






primXlibXArcDelete
    <cCall: 'Xlib_delete_XArc' plugin: 'x11'>
!

delete
    ^self primXlibXArcDelete.
!


name
    ^'XlibXArc'

! !

!XlibXArc methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXArc methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXGravityEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXGravityEvent class methodsFor: 'initialize-release'!

primXlibXGravityEventCreate
    <cCall: 'Xlib_new_XGravityEvent' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXGravityEventCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXGravityEvent  methodsFor: 'Xlib'!

"_________________________________________________________"
"type primitive accessors"
primXGravityEventType
    <cCall: 'Xlib_XGravityEvent_type_get' plugin: 'x11'>
!
primXGravityEventType: val
    <cCall: 'Xlib_XGravityEvent_type_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XGravityEvent_serial_get' plugin: 'x11'>
!
primXGravityEventSerial: val
    <cCall: 'Xlib_XGravityEvent_serial_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XGravityEvent_send_event_get' plugin: 'x11'>
!
primXGravityEventSendEvent: val
    <cCall: 'Xlib_XGravityEvent_send_event_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XGravityEvent_display_get' plugin: 'x11'>
!
primXGravityEventDisplay: val
    <cCall: 'Xlib_XGravityEvent_display_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XGravityEvent_event_get' plugin: 'x11'>
!
primXGravityEventEvent: val
    <cCall: 'Xlib_XGravityEvent_event_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XGravityEvent_window_get' plugin: 'x11'>
!
primXGravityEventWindow: val
    <cCall: 'Xlib_XGravityEvent_window_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XGravityEvent_x_get' plugin: 'x11'>
!
primXGravityEventX: val
    <cCall: 'Xlib_XGravityEvent_x_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XGravityEvent_y_get' plugin: 'x11'>
!
primXGravityEventY: val
    <cCall: 'Xlib_XGravityEvent_y_set' plugin: 'x11'>
!
"........................................................"
"y accessors"
y
    ^self primXGravityEventY
!
y: val
    ^self primXGravityEventY: val
!






primXlibXGravityEventDelete
    <cCall: 'Xlib_delete_XGravityEvent' plugin: 'x11'>
!

delete
    ^self primXlibXGravityEventDelete.
!


name
    ^'XlibXGravityEvent'

! !

!XlibXGravityEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXGravityEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXDestroyWindowEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXDestroyWindowEvent class methodsFor: 'initialize-release'!

primXlibXDestroyWindowEventCreate
    <cCall: 'Xlib_new_XDestroyWindowEvent' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXDestroyWindowEventCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXDestroyWindowEvent  methodsFor: 'Xlib'!

"_________________________________________________________"
"type primitive accessors"
primXDestroyWindowEventType
    <cCall: 'Xlib_XDestroyWindowEvent_type_get' plugin: 'x11'>
!
primXDestroyWindowEventType: val
    <cCall: 'Xlib_XDestroyWindowEvent_type_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XDestroyWindowEvent_serial_get' plugin: 'x11'>
!
primXDestroyWindowEventSerial: val
    <cCall: 'Xlib_XDestroyWindowEvent_serial_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XDestroyWindowEvent_send_event_get' plugin: 'x11'>
!
primXDestroyWindowEventSendEvent: val
    <cCall: 'Xlib_XDestroyWindowEvent_send_event_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XDestroyWindowEvent_display_get' plugin: 'x11'>
!
primXDestroyWindowEventDisplay: val
    <cCall: 'Xlib_XDestroyWindowEvent_display_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XDestroyWindowEvent_event_get' plugin: 'x11'>
!
primXDestroyWindowEventEvent: val
    <cCall: 'Xlib_XDestroyWindowEvent_event_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XDestroyWindowEvent_window_get' plugin: 'x11'>
!
primXDestroyWindowEventWindow: val
    <cCall: 'Xlib_XDestroyWindowEvent_window_set' plugin: 'x11'>
!
"........................................................"
"window accessors"
window
    ^self primXDestroyWindowEventWindow
!
window: val
    ^self primXDestroyWindowEventWindow: val
!






primXlibXDestroyWindowEventDelete
    <cCall: 'Xlib_delete_XDestroyWindowEvent' plugin: 'x11'>
!

delete
    ^self primXlibXDestroyWindowEventDelete.
!


name
    ^'XlibXDestroyWindowEvent'

! !

!XlibXDestroyWindowEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXDestroyWindowEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXExtData
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXExtData class methodsFor: 'initialize-release'!

primXlibXExtDataCreate
    <cCall: 'Xlib_new_XExtData' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXExtDataCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXExtData  methodsFor: 'Xlib'!

"_________________________________________________________"
"number primitive accessors"
primXExtDataNumber
    <cCall: 'Xlib_XExtData_number_get' plugin: 'x11'>
!
primXExtDataNumber: val
    <cCall: 'Xlib_XExtData_number_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XExtData_next_get' plugin: 'x11'>
!
primXExtDataNext: val
    <cCall: 'Xlib_XExtData_next_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XExtData_free_private_get' plugin: 'x11'>
!
primXExtDataFreePrivate: val
    <cCall: 'Xlib_XExtData_free_private_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XExtData_private_data_get' plugin: 'x11'>
!
primXExtDataPrivateData: val
    <cCall: 'Xlib_XExtData_private_data_set' plugin: 'x11'>
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
"number primitive function"
primXFindOnExtensionList: arg1
    <cCall: 'Xlib_XFindOnExtensionList' plugin: 'x11'>
!




primXlibXExtDataDelete
    <cCall: 'Xlib_delete_XExtData' plugin: 'x11'>
!

delete
    ^self primXlibXExtDataDelete.
!


name
    ^'XlibXExtData'

! !

!XlibXExtData methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXExtData methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXPropertyEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXPropertyEvent class methodsFor: 'initialize-release'!

primXlibXPropertyEventCreate
    <cCall: 'Xlib_new_XPropertyEvent' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXPropertyEventCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXPropertyEvent  methodsFor: 'Xlib'!

"_________________________________________________________"
"type primitive accessors"
primXPropertyEventType
    <cCall: 'Xlib_XPropertyEvent_type_get' plugin: 'x11'>
!
primXPropertyEventType: val
    <cCall: 'Xlib_XPropertyEvent_type_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XPropertyEvent_serial_get' plugin: 'x11'>
!
primXPropertyEventSerial: val
    <cCall: 'Xlib_XPropertyEvent_serial_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XPropertyEvent_send_event_get' plugin: 'x11'>
!
primXPropertyEventSendEvent: val
    <cCall: 'Xlib_XPropertyEvent_send_event_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XPropertyEvent_display_get' plugin: 'x11'>
!
primXPropertyEventDisplay: val
    <cCall: 'Xlib_XPropertyEvent_display_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XPropertyEvent_window_get' plugin: 'x11'>
!
primXPropertyEventWindow: val
    <cCall: 'Xlib_XPropertyEvent_window_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XPropertyEvent_atom_get' plugin: 'x11'>
!
primXPropertyEventAtom: val
    <cCall: 'Xlib_XPropertyEvent_atom_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XPropertyEvent_time_get' plugin: 'x11'>
!
primXPropertyEventTime: val
    <cCall: 'Xlib_XPropertyEvent_time_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XPropertyEvent_state_get' plugin: 'x11'>
!
primXPropertyEventState: val
    <cCall: 'Xlib_XPropertyEvent_state_set' plugin: 'x11'>
!
"........................................................"
"state accessors"
state
    ^self primXPropertyEventState
!
state: val
    ^self primXPropertyEventState: val
!






primXlibXPropertyEventDelete
    <cCall: 'Xlib_delete_XPropertyEvent' plugin: 'x11'>
!

delete
    ^self primXlibXPropertyEventDelete.
!


name
    ^'XlibXPropertyEvent'

! !

!XlibXPropertyEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXPropertyEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXOM
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXOM class methodsFor: 'initialize-release'!

primXlibXOMCreate
    <cCall: 'Xlib_new_XOM' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXOMCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXOM  methodsFor: 'Xlib'!



"_________________________________________________________"
"om primitive function"
primXCloseOM
    <cCall: 'Xlib_XCloseOM' plugin: 'x11'>
!

"_________________________________________________________"
"om primitive function"
primXSetOMValues
    <cCall: 'Xlib_XSetOMValues' plugin: 'x11'>
!

"_________________________________________________________"
"om primitive function"
primXGetOMValues
    <cCall: 'Xlib_XGetOMValues' plugin: 'x11'>
!

"_________________________________________________________"
"om primitive function"
primXDisplayOfOM
    <cCall: 'Xlib_XDisplayOfOM' plugin: 'x11'>
!

"_________________________________________________________"
"om primitive function"
primXLocaleOfOM
    <cCall: 'Xlib_XLocaleOfOM' plugin: 'x11'>
!

"_________________________________________________________"
"om primitive function"
primXCreateOC
    <cCall: 'Xlib_XCreateOC' plugin: 'x11'>
!




primXlibXOMDelete
    <cCall: 'Xlib_delete_XOM' plugin: 'x11'>
!

delete
    ^self primXlibXOMDelete.
!


name
    ^'XlibXOM'

! !

!XlibXOM methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXOM methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibDisplay
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibDisplay class methodsFor: 'initialize-release'!

primXlibDisplayCreate
    <cCall: 'Xlib_new_Display' plugin: 'x11'>
!

create
    ^self handle: (self primXlibDisplayCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibDisplay  methodsFor: 'Xlib'!



"_________________________________________________________"
"name primitive function"
primXLoadQueryFont: arg1
    <cCall: 'Xlib_XLoadQueryFont' plugin: 'x11'>
!

"_________________________________________________________"
"fontID primitive function"
primXQueryFont: arg1
    <cCall: 'Xlib_XQueryFont' plugin: 'x11'>
!

"_________________________________________________________"
"neventsReturn primitive function"
primXGetMotionEvents: arg1 start: arg4 stop: arg5 neventsReturn: arg6
    <cCall: 'Xlib_XGetMotionEvents' plugin: 'x11'>
!

"_________________________________________________________"
"display primitive function"
primXGetModifierMapping
    <cCall: 'Xlib_XGetModifierMapping' plugin: 'x11'>
!

"_________________________________________________________"
"bytesPerLine primitive function"
primXCreateImage: arg1 depth: arg4 format: arg5 offset: arg6 data: arg7 width: arg8 height: arg9 bitmapPad: arg10 bytesPerLine: arg11
    <cCall: 'Xlib_XCreateImage' plugin: 'x11'>
!

"_________________________________________________________"
"format primitive function"
primXGetImage: arg1 x: arg4 y: arg5 width: arg6 height: arg7 planeMask: arg8 format: arg9
    <cCall: 'Xlib_XGetImage' plugin: 'x11'>
!

"_________________________________________________________"
"destY primitive function"
primXGetSubImage: arg1 x: arg4 y: arg5 width: arg6 height: arg7 planeMask: arg8 format: arg9 destImage: arg10 destX: arg11 destY: arg12
    <cCall: 'Xlib_XGetSubImage' plugin: 'x11'>
!

"_________________________________________________________"
"nbytesReturn primitive function"
primXFetchBytes: arg1
    <cCall: 'Xlib_XFetchBytes' plugin: 'x11'>
!

"_________________________________________________________"
"buffer primitive function"
primXFetchBuffer: arg1 buffer: arg4
    <cCall: 'Xlib_XFetchBuffer' plugin: 'x11'>
!

"_________________________________________________________"
"atom primitive function"
primXGetAtomName: arg1
    <cCall: 'Xlib_XGetAtomName' plugin: 'x11'>
!

"_________________________________________________________"
"namesReturn primitive function"
primXGetAtomNames: arg1 count: arg4 namesReturn: arg5
    <cCall: 'Xlib_XGetAtomNames' plugin: 'x11'>
!

"_________________________________________________________"
"option primitive function"
primXGetDefault: arg1 option: arg4
    <cCall: 'Xlib_XGetDefault' plugin: 'x11'>
!

"_________________________________________________________"
"XSynchronize primitive function commented out."
"primXSynchronize"
"_________________________________________________________"
"XSetAfterFunction primitive function commented out."
"primXSetAfterFunction"
"_________________________________________________________"
"onlyIfExists primitive function"
primXInternAtom: arg1 onlyIfExists: arg4
    <cCall: 'Xlib_XInternAtom' plugin: 'x11'>
!

"_________________________________________________________"
"atomsReturn primitive function"
primXInternAtoms: arg1 count: arg4 onlyIfExists: arg5 atomsReturn: arg6
    <cCall: 'Xlib_XInternAtoms' plugin: 'x11'>
!

"_________________________________________________________"
"colormap primitive function"
primXCopyColormapAndFree: arg1
    <cCall: 'Xlib_XCopyColormapAndFree' plugin: 'x11'>
!

"_________________________________________________________"
"alloc primitive function"
primXCreateColormap: arg1 visual: arg4 alloc: arg5
    <cCall: 'Xlib_XCreateColormap' plugin: 'x11'>
!

"_________________________________________________________"
"y primitive function"
primXCreatePixmapCursor: arg1 mask: arg4 foregroundColor: arg5 backgroundColor: arg6 x: arg7 y: arg8
    <cCall: 'Xlib_XCreatePixmapCursor' plugin: 'x11'>
!

"_________________________________________________________"
"backgroundColor primitive function"
primXCreateGlyphCursor: arg1 maskFont: arg4 sourceChar: arg5 maskChar: arg6 foregroundColor: arg7 backgroundColor: arg8
    <cCall: 'Xlib_XCreateGlyphCursor' plugin: 'x11'>
!

"_________________________________________________________"
"shape primitive function"
primXCreateFontCursor: arg1
    <cCall: 'Xlib_XCreateFontCursor' plugin: 'x11'>
!

"_________________________________________________________"
"name primitive function"
primXLoadFont: arg1
    <cCall: 'Xlib_XLoadFont' plugin: 'x11'>
!

"_________________________________________________________"
"values primitive function"
primXCreateGC: arg1 valuemask: arg4 values: arg5
    <cCall: 'Xlib_XCreateGC' plugin: 'x11'>
!

"_________________________________________________________"
"gc primitive function"
primXFlushGC: arg1
    <cCall: 'Xlib_XFlushGC' plugin: 'x11'>
!

"_________________________________________________________"
"depth primitive function"
primXCreatePixmap: arg1 width: arg4 height: arg5 depth: arg6
    <cCall: 'Xlib_XCreatePixmap' plugin: 'x11'>
!

"_________________________________________________________"
"height primitive function"
primXCreateBitmapFromData: arg1 data: arg4 width: arg5 height: arg6
    <cCall: 'Xlib_XCreateBitmapFromData' plugin: 'x11'>
!

"_________________________________________________________"
"depth primitive function"
primXCreatePixmapFromBitmapData: arg1 data: arg4 width: arg5 height: arg6 fg: arg7 bg: arg8 depth: arg9
    <cCall: 'Xlib_XCreatePixmapFromBitmapData' plugin: 'x11'>
!

"_________________________________________________________"
"background primitive function"
primXCreateSimpleWindow: arg1 x: arg4 y: arg5 width: arg6 height: arg7 borderWidth: arg8 border: arg9 background: arg10
    <cCall: 'Xlib_XCreateSimpleWindow' plugin: 'x11'>
!

"_________________________________________________________"
"selection primitive function"
primXGetSelectionOwner: arg1
    <cCall: 'Xlib_XGetSelectionOwner' plugin: 'x11'>
!

"_________________________________________________________"
"attributes primitive function"
primXCreateWindow: arg1 x: arg4 y: arg5 width: arg6 height: arg7 borderWidth: arg8 depth: arg9 class: arg10 visual: arg11 valuemask: arg12 attributes: arg13
    <cCall: 'Xlib_XCreateWindow' plugin: 'x11'>
!

"_________________________________________________________"
"numReturn primitive function"
primXListInstalledColormaps: arg1 numReturn: arg4
    <cCall: 'Xlib_XListInstalledColormaps' plugin: 'x11'>
!

"_________________________________________________________"
"actualCountReturn primitive function"
primXListFonts: arg1 maxnames: arg4 actualCountReturn: arg5
    <cCall: 'Xlib_XListFonts' plugin: 'x11'>
!

"_________________________________________________________"
"infoReturn primitive function"
primXListFontsWithInfo: arg1 maxnames: arg4 countReturn: arg5 infoReturn: arg6
    <cCall: 'Xlib_XListFontsWithInfo' plugin: 'x11'>
!

"_________________________________________________________"
"npathsReturn primitive function"
primXGetFontPath: arg1
    <cCall: 'Xlib_XGetFontPath' plugin: 'x11'>
!

"_________________________________________________________"
"nextensionsReturn primitive function"
primXListExtensions: arg1
    <cCall: 'Xlib_XListExtensions' plugin: 'x11'>
!

"_________________________________________________________"
"numPropReturn primitive function"
primXListProperties: arg1 numPropReturn: arg4
    <cCall: 'Xlib_XListProperties' plugin: 'x11'>
!

"_________________________________________________________"
"stateReturn primitive function"
primXListHosts: arg1 stateReturn: arg4
    <cCall: 'Xlib_XListHosts' plugin: 'x11'>
!

"_________________________________________________________"
"index primitive function"
primXKeycodeToKeysym: arg1 keycode: arg4 index: arg5
    <cCall: 'Xlib_XKeycodeToKeysym' plugin: 'x11'>
!

"_________________________________________________________"
"keysymsPerKeycodeReturn primitive function"
primXGetKeyboardMapping: arg1 firstKeycode: arg4 keycodeCount: arg5 keysymsPerKeycodeReturn: arg6
    <cCall: 'Xlib_XGetKeyboardMapping' plugin: 'x11'>
!

"_________________________________________________________"
"display primitive function"
primXMaxRequestSize
    <cCall: 'Xlib_XMaxRequestSize' plugin: 'x11'>
!

"_________________________________________________________"
"display primitive function"
primXExtendedMaxRequestSize
    <cCall: 'Xlib_XExtendedMaxRequestSize' plugin: 'x11'>
!

"_________________________________________________________"
"display primitive function"
primXResourceManagerString
    <cCall: 'Xlib_XResourceManagerString' plugin: 'x11'>
!

"_________________________________________________________"
"display primitive function"
primXDisplayMotionBufferSize
    <cCall: 'Xlib_XDisplayMotionBufferSize' plugin: 'x11'>
!

"_________________________________________________________"
"display primitive function"
primXLockDisplay
    <cCall: 'Xlib_XLockDisplay' plugin: 'x11'>
!

"_________________________________________________________"
"display primitive function"
primXUnlockDisplay
    <cCall: 'Xlib_XUnlockDisplay' plugin: 'x11'>
!

"_________________________________________________________"
"name primitive function"
primXInitExtension: arg1
    <cCall: 'Xlib_XInitExtension' plugin: 'x11'>
!

"_________________________________________________________"
"display primitive function"
primXAddExtension
    <cCall: 'Xlib_XAddExtension' plugin: 'x11'>
!

"_________________________________________________________"
"screenNumber primitive function"
primXRootWindow: arg1
    <cCall: 'Xlib_XRootWindow' plugin: 'x11'>
!

"_________________________________________________________"
"display primitive function"
primXDefaultRootWindow
    <cCall: 'Xlib_XDefaultRootWindow' plugin: 'x11'>
!

"_________________________________________________________"
"screenNumber primitive function"
primXDefaultVisual: arg1
    <cCall: 'Xlib_XDefaultVisual' plugin: 'x11'>
!

"_________________________________________________________"
"screenNumber primitive function"
primXDefaultGC: arg1
    <cCall: 'Xlib_XDefaultGC' plugin: 'x11'>
!

"_________________________________________________________"
"screenNumber primitive function"
primXBlackPixel: arg1
    <cCall: 'Xlib_XBlackPixel' plugin: 'x11'>
!

"_________________________________________________________"
"screenNumber primitive function"
primXWhitePixel: arg1
    <cCall: 'Xlib_XWhitePixel' plugin: 'x11'>
!

"_________________________________________________________"
"display primitive function"
primXNextRequest
    <cCall: 'Xlib_XNextRequest' plugin: 'x11'>
!

"_________________________________________________________"
"display primitive function"
primXLastKnownRequestProcessed
    <cCall: 'Xlib_XLastKnownRequestProcessed' plugin: 'x11'>
!

"_________________________________________________________"
"display primitive function"
primXServerVendor
    <cCall: 'Xlib_XServerVendor' plugin: 'x11'>
!

"_________________________________________________________"
"display primitive function"
primXDisplayString
    <cCall: 'Xlib_XDisplayString' plugin: 'x11'>
!

"_________________________________________________________"
"screenNumber primitive function"
primXDefaultColormap: arg1
    <cCall: 'Xlib_XDefaultColormap' plugin: 'x11'>
!

"_________________________________________________________"
"screenNumber primitive function"
primXScreenOfDisplay: arg1
    <cCall: 'Xlib_XScreenOfDisplay' plugin: 'x11'>
!

"_________________________________________________________"
"display primitive function"
primXDefaultScreenOfDisplay
    <cCall: 'Xlib_XDefaultScreenOfDisplay' plugin: 'x11'>
!

"_________________________________________________________"
"countReturn primitive function"
primXListPixmapFormats: arg1
    <cCall: 'Xlib_XListPixmapFormats' plugin: 'x11'>
!

"_________________________________________________________"
"countReturn primitive function"
primXListDepths: arg1 countReturn: arg4
    <cCall: 'Xlib_XListDepths' plugin: 'x11'>
!

"_________________________________________________________"
"changes primitive function"
primXReconfigureWMWindow: arg1 screenNumber: arg4 mask: arg5 changes: arg6
    <cCall: 'Xlib_XReconfigureWMWindow' plugin: 'x11'>
!

"_________________________________________________________"
"countReturn primitive function"
primXGetWMProtocols: arg1 protocolsReturn: arg4 countReturn: arg5
    <cCall: 'Xlib_XGetWMProtocols' plugin: 'x11'>
!

"_________________________________________________________"
"count primitive function"
primXSetWMProtocols: arg1 protocols: arg4 count: arg5
    <cCall: 'Xlib_XSetWMProtocols' plugin: 'x11'>
!

"_________________________________________________________"
"screenNumber primitive function"
primXIconifyWindow: arg1 screenNumber: arg4
    <cCall: 'Xlib_XIconifyWindow' plugin: 'x11'>
!

"_________________________________________________________"
"screenNumber primitive function"
primXWithdrawWindow: arg1 screenNumber: arg4
    <cCall: 'Xlib_XWithdrawWindow' plugin: 'x11'>
!

"_________________________________________________________"
"argcReturn primitive function"
primXGetCommand: arg1 argvReturn: arg4 argcReturn: arg5
    <cCall: 'Xlib_XGetCommand' plugin: 'x11'>
!

"_________________________________________________________"
"countReturn primitive function"
primXGetWMColormapWindows: arg1 windowsReturn: arg4 countReturn: arg5
    <cCall: 'Xlib_XGetWMColormapWindows' plugin: 'x11'>
!

"_________________________________________________________"
"count primitive function"
primXSetWMColormapWindows: arg1 colormapWindows: arg4 count: arg5
    <cCall: 'Xlib_XSetWMColormapWindows' plugin: 'x11'>
!

"_________________________________________________________"
"propWindow primitive function"
primXSetTransientForHint: arg1 propWindow: arg4
    <cCall: 'Xlib_XSetTransientForHint' plugin: 'x11'>
!

"_________________________________________________________"
"display primitive function"
primXActivateScreenSaver
    <cCall: 'Xlib_XActivateScreenSaver' plugin: 'x11'>
!

"_________________________________________________________"
"host primitive function"
primXAddHost: arg1
    <cCall: 'Xlib_XAddHost' plugin: 'x11'>
!

"_________________________________________________________"
"numHosts primitive function"
primXAddHosts: arg1 numHosts: arg4
    <cCall: 'Xlib_XAddHosts' plugin: 'x11'>
!

"_________________________________________________________"
"w primitive function"
primXAddToSaveSet: arg1
    <cCall: 'Xlib_XAddToSaveSet' plugin: 'x11'>
!

"_________________________________________________________"
"screenInOut primitive function"
primXAllocColor: arg1 screenInOut: arg4
    <cCall: 'Xlib_XAllocColor' plugin: 'x11'>
!

"_________________________________________________________"
"npixels primitive function"
primXAllocColorCells: arg1 contig: arg4 planeMasksReturn: arg5 nplanes: arg6 pixelsReturn: arg7 npixels: arg8
    <cCall: 'Xlib_XAllocColorCells' plugin: 'x11'>
!

"_________________________________________________________"
"bmaskReturn primitive function"
primXAllocColorPlanes: arg1 contig: arg4 pixelsReturn: arg5 ncolors: arg6 nreds: arg7 ngreens: arg8 nblues: arg9 rmaskReturn: arg10 gmaskReturn: arg11 bmaskReturn: arg12
    <cCall: 'Xlib_XAllocColorPlanes' plugin: 'x11'>
!

"_________________________________________________________"
"exactDefReturn primitive function"
primXAllocNamedColor: arg1 colorName: arg4 screenDefReturn: arg5 exactDefReturn: arg6
    <cCall: 'Xlib_XAllocNamedColor' plugin: 'x11'>
!

"_________________________________________________________"
"time primitive function"
primXAllowEvents: arg1 time: arg4
    <cCall: 'Xlib_XAllowEvents' plugin: 'x11'>
!

"_________________________________________________________"
"display primitive function"
primXAutoRepeatOff
    <cCall: 'Xlib_XAutoRepeatOff' plugin: 'x11'>
!

"_________________________________________________________"
"display primitive function"
primXAutoRepeatOn
    <cCall: 'Xlib_XAutoRepeatOn' plugin: 'x11'>
!

"_________________________________________________________"
"percent primitive function"
primXBell: arg1
    <cCall: 'Xlib_XBell' plugin: 'x11'>
!

"_________________________________________________________"
"display primitive function"
primXBitmapBitOrder
    <cCall: 'Xlib_XBitmapBitOrder' plugin: 'x11'>
!

"_________________________________________________________"
"display primitive function"
primXBitmapPad
    <cCall: 'Xlib_XBitmapPad' plugin: 'x11'>
!

"_________________________________________________________"
"display primitive function"
primXBitmapUnit
    <cCall: 'Xlib_XBitmapUnit' plugin: 'x11'>
!

"_________________________________________________________"
"time primitive function"
primXChangeActivePointerGrab: arg1 cursor: arg4 time: arg5
    <cCall: 'Xlib_XChangeActivePointerGrab' plugin: 'x11'>
!

"_________________________________________________________"
"values primitive function"
primXChangeGC: arg1 valuemask: arg4 values: arg5
    <cCall: 'Xlib_XChangeGC' plugin: 'x11'>
!

"_________________________________________________________"
"values primitive function"
primXChangeKeyboardControl: arg1 values: arg4
    <cCall: 'Xlib_XChangeKeyboardControl' plugin: 'x11'>
!

"_________________________________________________________"
"numCodes primitive function"
primXChangeKeyboardMapping: arg1 keysymsPerKeycode: arg4 keysyms: arg5 numCodes: arg6
    <cCall: 'Xlib_XChangeKeyboardMapping' plugin: 'x11'>
!

"_________________________________________________________"
"threshold primitive function"
primXChangePointerControl: arg1 doThreshold: arg4 accelNumerator: arg5 accelDenominator: arg6 threshold: arg7
    <cCall: 'Xlib_XChangePointerControl' plugin: 'x11'>
!

"_________________________________________________________"
"nelements primitive function"
primXChangeProperty: arg1 property: arg4 type: arg5 format: arg6 mode: arg7 data: arg8 nelements: arg9
    <cCall: 'Xlib_XChangeProperty' plugin: 'x11'>
!

"_________________________________________________________"
"changeMode primitive function"
primXChangeSaveSet: arg1 changeMode: arg4
    <cCall: 'Xlib_XChangeSaveSet' plugin: 'x11'>
!

"_________________________________________________________"
"attributes primitive function"
primXChangeWindowAttributes: arg1 valuemask: arg4 attributes: arg5
    <cCall: 'Xlib_XChangeWindowAttributes' plugin: 'x11'>
!

"_________________________________________________________"
"arg primitive function"
primXCheckIfEvent: arg1 display: arg4 event: arg5 arg: arg6 predicate: arg7 arg: arg8
    <cCall: 'Xlib_XCheckIfEvent' plugin: 'x11'>
!

"_________________________________________________________"
"eventReturn primitive function"
primXCheckMaskEvent: arg1 eventReturn: arg4
    <cCall: 'Xlib_XCheckMaskEvent' plugin: 'x11'>
!

"_________________________________________________________"
"eventReturn primitive function"
primXCheckTypedEvent: arg1 eventReturn: arg4
    <cCall: 'Xlib_XCheckTypedEvent' plugin: 'x11'>
!

"_________________________________________________________"
"eventReturn primitive function"
primXCheckTypedWindowEvent: arg1 eventType: arg4 eventReturn: arg5
    <cCall: 'Xlib_XCheckTypedWindowEvent' plugin: 'x11'>
!

"_________________________________________________________"
"eventReturn primitive function"
primXCheckWindowEvent: arg1 eventMask: arg4 eventReturn: arg5
    <cCall: 'Xlib_XCheckWindowEvent' plugin: 'x11'>
!

"_________________________________________________________"
"direction primitive function"
primXCirculateSubwindows: arg1 direction: arg4
    <cCall: 'Xlib_XCirculateSubwindows' plugin: 'x11'>
!

"_________________________________________________________"
"w primitive function"
primXCirculateSubwindowsDown: arg1
    <cCall: 'Xlib_XCirculateSubwindowsDown' plugin: 'x11'>
!

"_________________________________________________________"
"w primitive function"
primXCirculateSubwindowsUp: arg1
    <cCall: 'Xlib_XCirculateSubwindowsUp' plugin: 'x11'>
!

"_________________________________________________________"
"exposures primitive function"
primXClearArea: arg1 x: arg4 y: arg5 width: arg6 height: arg7 exposures: arg8
    <cCall: 'Xlib_XClearArea' plugin: 'x11'>
!

"_________________________________________________________"
"w primitive function"
primXClearWindow: arg1
    <cCall: 'Xlib_XClearWindow' plugin: 'x11'>
!

"_________________________________________________________"
"display primitive function"
primXCloseDisplay
    <cCall: 'Xlib_XCloseDisplay' plugin: 'x11'>
!

"_________________________________________________________"
"values primitive function"
primXConfigureWindow: arg1 valueMask: arg4 values: arg5
    <cCall: 'Xlib_XConfigureWindow' plugin: 'x11'>
!

"_________________________________________________________"
"display primitive function"
primXConnectionNumber
    <cCall: 'Xlib_XConnectionNumber' plugin: 'x11'>
!

"_________________________________________________________"
"time primitive function"
primXConvertSelection: arg1 target: arg4 property: arg5 requestor: arg6 time: arg7
    <cCall: 'Xlib_XConvertSelection' plugin: 'x11'>
!

"_________________________________________________________"
"destY primitive function"
primXCopyArea: arg1 dest: arg4 gc: arg5 srcX: arg6 srcY: arg7 width: arg8 height: arg9 destX: arg10 destY: arg11
    <cCall: 'Xlib_XCopyArea' plugin: 'x11'>
!

"_________________________________________________________"
"dest primitive function"
primXCopyGC: arg1 valuemask: arg4 dest: arg5
    <cCall: 'Xlib_XCopyGC' plugin: 'x11'>
!

"_________________________________________________________"
"plane primitive function"
primXCopyPlane: arg1 dest: arg4 gc: arg5 srcX: arg6 srcY: arg7 width: arg8 height: arg9 destX: arg10 destY: arg11 plane: arg12
    <cCall: 'Xlib_XCopyPlane' plugin: 'x11'>
!

"_________________________________________________________"
"screenNumber primitive function"
primXDefaultDepth: arg1
    <cCall: 'Xlib_XDefaultDepth' plugin: 'x11'>
!

"_________________________________________________________"
"display primitive function"
primXDefaultScreen
    <cCall: 'Xlib_XDefaultScreen' plugin: 'x11'>
!

"_________________________________________________________"
"cursor primitive function"
primXDefineCursor: arg1 cursor: arg4
    <cCall: 'Xlib_XDefineCursor' plugin: 'x11'>
!

"_________________________________________________________"
"property primitive function"
primXDeleteProperty: arg1 property: arg4
    <cCall: 'Xlib_XDeleteProperty' plugin: 'x11'>
!

"_________________________________________________________"
"w primitive function"
primXDestroyWindow: arg1
    <cCall: 'Xlib_XDestroyWindow' plugin: 'x11'>
!

"_________________________________________________________"
"w primitive function"
primXDestroySubwindows: arg1
    <cCall: 'Xlib_XDestroySubwindows' plugin: 'x11'>
!

"_________________________________________________________"
"display primitive function"
primXDisableAccessControl
    <cCall: 'Xlib_XDisableAccessControl' plugin: 'x11'>
!

"_________________________________________________________"
"screenNumber primitive function"
primXDisplayCells: arg1
    <cCall: 'Xlib_XDisplayCells' plugin: 'x11'>
!

"_________________________________________________________"
"screenNumber primitive function"
primXDisplayHeight: arg1
    <cCall: 'Xlib_XDisplayHeight' plugin: 'x11'>
!

"_________________________________________________________"
"screenNumber primitive function"
primXDisplayHeightMM: arg1
    <cCall: 'Xlib_XDisplayHeightMM' plugin: 'x11'>
!

"_________________________________________________________"
"maxKeycodesReturn primitive function"
primXDisplayKeycodes: arg1 maxKeycodesReturn: arg4
    <cCall: 'Xlib_XDisplayKeycodes' plugin: 'x11'>
!

"_________________________________________________________"
"screenNumber primitive function"
primXDisplayPlanes: arg1
    <cCall: 'Xlib_XDisplayPlanes' plugin: 'x11'>
!

"_________________________________________________________"
"screenNumber primitive function"
primXDisplayWidth: arg1
    <cCall: 'Xlib_XDisplayWidth' plugin: 'x11'>
!

"_________________________________________________________"
"screenNumber primitive function"
primXDisplayWidthMM: arg1
    <cCall: 'Xlib_XDisplayWidthMM' plugin: 'x11'>
!

"_________________________________________________________"
"angle2 primitive function"
primXDrawArc: arg1 gc: arg4 x: arg5 y: arg6 width: arg7 height: arg8 angle1: arg9 angle2: arg10
    <cCall: 'Xlib_XDrawArc' plugin: 'x11'>
!

"_________________________________________________________"
"narcs primitive function"
primXDrawArcs: arg1 gc: arg4 arcs: arg5 narcs: arg6
    <cCall: 'Xlib_XDrawArcs' plugin: 'x11'>
!

"_________________________________________________________"
"length primitive function"
primXDrawImageString: arg1 gc: arg4 x: arg5 y: arg6 string: arg7 length: arg8
    <cCall: 'Xlib_XDrawImageString' plugin: 'x11'>
!

"_________________________________________________________"
"length primitive function"
primXDrawImageString16: arg1 gc: arg4 x: arg5 y: arg6 string: arg7 length: arg8
    <cCall: 'Xlib_XDrawImageString16' plugin: 'x11'>
!

"_________________________________________________________"
"y2 primitive function"
primXDrawLine: arg1 gc: arg4 x1: arg5 y1: arg6 x2: arg7 y2: arg8
    <cCall: 'Xlib_XDrawLine' plugin: 'x11'>
!

"_________________________________________________________"
"mode primitive function"
primXDrawLines: arg1 gc: arg4 points: arg5 npoints: arg6 mode: arg7
    <cCall: 'Xlib_XDrawLines' plugin: 'x11'>
!

"_________________________________________________________"
"y primitive function"
primXDrawPoint: arg1 gc: arg4 x: arg5 y: arg6
    <cCall: 'Xlib_XDrawPoint' plugin: 'x11'>
!

"_________________________________________________________"
"mode primitive function"
primXDrawPoints: arg1 gc: arg4 points: arg5 npoints: arg6 mode: arg7
    <cCall: 'Xlib_XDrawPoints' plugin: 'x11'>
!

"_________________________________________________________"
"height primitive function"
primXDrawRectangle: arg1 gc: arg4 x: arg5 y: arg6 width: arg7 height: arg8
    <cCall: 'Xlib_XDrawRectangle' plugin: 'x11'>
!

"_________________________________________________________"
"nrectangles primitive function"
primXDrawRectangles: arg1 gc: arg4 rectangles: arg5 nrectangles: arg6
    <cCall: 'Xlib_XDrawRectangles' plugin: 'x11'>
!

"_________________________________________________________"
"nsegments primitive function"
primXDrawSegments: arg1 gc: arg4 segments: arg5 nsegments: arg6
    <cCall: 'Xlib_XDrawSegments' plugin: 'x11'>
!

"_________________________________________________________"
"length primitive function"
primXDrawString: arg1 gc: arg4 x: arg5 y: arg6 string: arg7 length: arg8
    <cCall: 'Xlib_XDrawString' plugin: 'x11'>
!

"_________________________________________________________"
"length primitive function"
primXDrawString16: arg1 gc: arg4 x: arg5 y: arg6 string: arg7 length: arg8
    <cCall: 'Xlib_XDrawString16' plugin: 'x11'>
!

"_________________________________________________________"
"nitems primitive function"
primXDrawText: arg1 gc: arg4 x: arg5 y: arg6 items: arg7 nitems: arg8
    <cCall: 'Xlib_XDrawText' plugin: 'x11'>
!

"_________________________________________________________"
"nitems primitive function"
primXDrawText16: arg1 gc: arg4 x: arg5 y: arg6 items: arg7 nitems: arg8
    <cCall: 'Xlib_XDrawText16' plugin: 'x11'>
!

"_________________________________________________________"
"display primitive function"
primXEnableAccessControl
    <cCall: 'Xlib_XEnableAccessControl' plugin: 'x11'>
!

"_________________________________________________________"
"mode primitive function"
primXEventsQueued: arg1
    <cCall: 'Xlib_XEventsQueued' plugin: 'x11'>
!

"_________________________________________________________"
"windowNameReturn primitive function"
primXFetchName: arg1 windowNameReturn: arg4
    <cCall: 'Xlib_XFetchName' plugin: 'x11'>
!

"_________________________________________________________"
"angle2 primitive function"
primXFillArc: arg1 gc: arg4 x: arg5 y: arg6 width: arg7 height: arg8 angle1: arg9 angle2: arg10
    <cCall: 'Xlib_XFillArc' plugin: 'x11'>
!

"_________________________________________________________"
"narcs primitive function"
primXFillArcs: arg1 gc: arg4 arcs: arg5 narcs: arg6
    <cCall: 'Xlib_XFillArcs' plugin: 'x11'>
!

"_________________________________________________________"
"mode primitive function"
primXFillPolygon: arg1 gc: arg4 points: arg5 npoints: arg6 shape: arg7 mode: arg8
    <cCall: 'Xlib_XFillPolygon' plugin: 'x11'>
!

"_________________________________________________________"
"height primitive function"
primXFillRectangle: arg1 gc: arg4 x: arg5 y: arg6 width: arg7 height: arg8
    <cCall: 'Xlib_XFillRectangle' plugin: 'x11'>
!

"_________________________________________________________"
"nrectangles primitive function"
primXFillRectangles: arg1 gc: arg4 rectangles: arg5 nrectangles: arg6
    <cCall: 'Xlib_XFillRectangles' plugin: 'x11'>
!

"_________________________________________________________"
"display primitive function"
primXFlush
    <cCall: 'Xlib_XFlush' plugin: 'x11'>
!

"_________________________________________________________"
"mode primitive function"
primXForceScreenSaver: arg1
    <cCall: 'Xlib_XForceScreenSaver' plugin: 'x11'>
!

"_________________________________________________________"
"colormap primitive function"
primXFreeColormap: arg1
    <cCall: 'Xlib_XFreeColormap' plugin: 'x11'>
!

"_________________________________________________________"
"planes primitive function"
primXFreeColors: arg1 pixels: arg4 npixels: arg5 planes: arg6
    <cCall: 'Xlib_XFreeColors' plugin: 'x11'>
!

"_________________________________________________________"
"cursor primitive function"
primXFreeCursor: arg1
    <cCall: 'Xlib_XFreeCursor' plugin: 'x11'>
!

"_________________________________________________________"
"fontStruct primitive function"
primXFreeFont: arg1
    <cCall: 'Xlib_XFreeFont' plugin: 'x11'>
!

"_________________________________________________________"
"gc primitive function"
primXFreeGC: arg1
    <cCall: 'Xlib_XFreeGC' plugin: 'x11'>
!

"_________________________________________________________"
"pixmap primitive function"
primXFreePixmap: arg1
    <cCall: 'Xlib_XFreePixmap' plugin: 'x11'>
!

"_________________________________________________________"
"heightReturn primitive function"
primXGeometry: arg1 position: arg4 defaultPosition: arg5 bwidth: arg6 fwidth: arg7 fheight: arg8 xadder: arg9 yadder: arg10 xReturn: arg11 yReturn: arg12 widthReturn: arg13 heightReturn: arg14
    <cCall: 'Xlib_XGeometry' plugin: 'x11'>
!

"_________________________________________________________"
"length primitive function"
primXGetErrorDatabaseText: arg1 message: arg4 defaultString: arg5 bufferReturn: arg6 length: arg7
    <cCall: 'Xlib_XGetErrorDatabaseText' plugin: 'x11'>
!

"_________________________________________________________"
"length primitive function"
primXGetErrorText: arg1 bufferReturn: arg4 length: arg5
    <cCall: 'Xlib_XGetErrorText' plugin: 'x11'>
!

"_________________________________________________________"
"valuesReturn primitive function"
primXGetGCValues: arg1 valuemask: arg4 valuesReturn: arg5
    <cCall: 'Xlib_XGetGCValues' plugin: 'x11'>
!

"_________________________________________________________"
"depthReturn primitive function"
primXGetGeometry: arg1 rootReturn: arg4 xReturn: arg5 yReturn: arg6 widthReturn: arg7 heightReturn: arg8 borderWidthReturn: arg9 depthReturn: arg10
    <cCall: 'Xlib_XGetGeometry' plugin: 'x11'>
!

"_________________________________________________________"
"iconNameReturn primitive function"
primXGetIconName: arg1 iconNameReturn: arg4
    <cCall: 'Xlib_XGetIconName' plugin: 'x11'>
!

"_________________________________________________________"
"revertToReturn primitive function"
primXGetInputFocus: arg1 revertToReturn: arg4
    <cCall: 'Xlib_XGetInputFocus' plugin: 'x11'>
!

"_________________________________________________________"
"valuesReturn primitive function"
primXGetKeyboardControl: arg1
    <cCall: 'Xlib_XGetKeyboardControl' plugin: 'x11'>
!

"_________________________________________________________"
"thresholdReturn primitive function"
primXGetPointerControl: arg1 accelDenominatorReturn: arg4 thresholdReturn: arg5
    <cCall: 'Xlib_XGetPointerControl' plugin: 'x11'>
!

"_________________________________________________________"
"nmap primitive function"
primXGetPointerMapping: arg1 nmap: arg4
    <cCall: 'Xlib_XGetPointerMapping' plugin: 'x11'>
!

"_________________________________________________________"
"allowExposuresReturn primitive function"
primXGetScreenSaver: arg1 intervalReturn: arg4 preferBlankingReturn: arg5 allowExposuresReturn: arg6
    <cCall: 'Xlib_XGetScreenSaver' plugin: 'x11'>
!

"_________________________________________________________"
"propWindowReturn primitive function"
primXGetTransientForHint: arg1 propWindowReturn: arg4
    <cCall: 'Xlib_XGetTransientForHint' plugin: 'x11'>
!

"_________________________________________________________"
"propReturn primitive function"
primXGetWindowProperty: arg1 property: arg4 longOffset: arg5 longLength: arg6 delete: arg7 reqType: arg8 actualTypeReturn: arg9 actualFormatReturn: arg10 nitemsReturn: arg11 bytesAfterReturn: arg12 propReturn: arg13
    <cCall: 'Xlib_XGetWindowProperty' plugin: 'x11'>
!

"_________________________________________________________"
"windowAttributesReturn primitive function"
primXGetWindowAttributes: arg1 windowAttributesReturn: arg4
    <cCall: 'Xlib_XGetWindowAttributes' plugin: 'x11'>
!

"_________________________________________________________"
"cursor primitive function"
primXGrabButton: arg1 modifiers: arg4 grabWindow: arg5 ownerEvents: arg6 eventMask: arg7 pointerMode: arg8 keyboardMode: arg9 confineTo: arg10 cursor: arg11
    <cCall: 'Xlib_XGrabButton' plugin: 'x11'>
!

"_________________________________________________________"
"keyboardMode primitive function"
primXGrabKey: arg1 modifiers: arg4 grabWindow: arg5 ownerEvents: arg6 pointerMode: arg7 keyboardMode: arg8
    <cCall: 'Xlib_XGrabKey' plugin: 'x11'>
!

"_________________________________________________________"
"time primitive function"
primXGrabKeyboard: arg1 ownerEvents: arg4 pointerMode: arg5 keyboardMode: arg6 time: arg7
    <cCall: 'Xlib_XGrabKeyboard' plugin: 'x11'>
!

"_________________________________________________________"
"time primitive function"
primXGrabPointer: arg1 ownerEvents: arg4 eventMask: arg5 pointerMode: arg6 keyboardMode: arg7 confineTo: arg8 cursor: arg9 time: arg10
    <cCall: 'Xlib_XGrabPointer' plugin: 'x11'>
!

"_________________________________________________________"
"display primitive function"
primXGrabServer
    <cCall: 'Xlib_XGrabServer' plugin: 'x11'>
!

"_________________________________________________________"
"arg primitive function"
primXIfEvent: arg1 display: arg4 event: arg5 arg: arg6 predicate: arg7 arg: arg8
    <cCall: 'Xlib_XIfEvent' plugin: 'x11'>
!

"_________________________________________________________"
"display primitive function"
primXImageByteOrder
    <cCall: 'Xlib_XImageByteOrder' plugin: 'x11'>
!

"_________________________________________________________"
"colormap primitive function"
primXInstallColormap: arg1
    <cCall: 'Xlib_XInstallColormap' plugin: 'x11'>
!

"_________________________________________________________"
"keysym primitive function"
primXKeysymToKeycode: arg1
    <cCall: 'Xlib_XKeysymToKeycode' plugin: 'x11'>
!

"_________________________________________________________"
"resource primitive function"
primXKillClient: arg1
    <cCall: 'Xlib_XKillClient' plugin: 'x11'>
!

"_________________________________________________________"
"screenDefReturn primitive function"
primXLookupColor: arg1 colorName: arg4 exactDefReturn: arg5 screenDefReturn: arg6
    <cCall: 'Xlib_XLookupColor' plugin: 'x11'>
!

"_________________________________________________________"
"w primitive function"
primXLowerWindow: arg1
    <cCall: 'Xlib_XLowerWindow' plugin: 'x11'>
!

"_________________________________________________________"
"w primitive function"
primXMapRaised: arg1
    <cCall: 'Xlib_XMapRaised' plugin: 'x11'>
!

"_________________________________________________________"
"w primitive function"
primXMapSubwindows: arg1
    <cCall: 'Xlib_XMapSubwindows' plugin: 'x11'>
!

"_________________________________________________________"
"w primitive function"
primXMapWindow: arg1
    <cCall: 'Xlib_XMapWindow' plugin: 'x11'>
!

"_________________________________________________________"
"eventReturn primitive function"
primXMaskEvent: arg1 eventReturn: arg4
    <cCall: 'Xlib_XMaskEvent' plugin: 'x11'>
!

"_________________________________________________________"
"height primitive function"
primXMoveResizeWindow: arg1 x: arg4 y: arg5 width: arg6 height: arg7
    <cCall: 'Xlib_XMoveResizeWindow' plugin: 'x11'>
!

"_________________________________________________________"
"y primitive function"
primXMoveWindow: arg1 x: arg4 y: arg5
    <cCall: 'Xlib_XMoveWindow' plugin: 'x11'>
!

"_________________________________________________________"
"eventReturn primitive function"
primXNextEvent: arg1
    <cCall: 'Xlib_XNextEvent' plugin: 'x11'>
!

"_________________________________________________________"
"display primitive function"
primXNoOp
    <cCall: 'Xlib_XNoOp' plugin: 'x11'>
!

"_________________________________________________________"
"exactDefReturn primitive function"
primXParseColor: arg1 spec: arg4 exactDefReturn: arg5
    <cCall: 'Xlib_XParseColor' plugin: 'x11'>
!

"_________________________________________________________"
"eventReturn primitive function"
primXPeekEvent: arg1
    <cCall: 'Xlib_XPeekEvent' plugin: 'x11'>
!

"_________________________________________________________"
"arg primitive function"
primXPeekIfEvent: arg1 display: arg4 event: arg5 arg: arg6 predicate: arg7 arg: arg8
    <cCall: 'Xlib_XPeekIfEvent' plugin: 'x11'>
!

"_________________________________________________________"
"display primitive function"
primXPending
    <cCall: 'Xlib_XPending' plugin: 'x11'>
!

"_________________________________________________________"
"display primitive function"
primXProtocolRevision
    <cCall: 'Xlib_XProtocolRevision' plugin: 'x11'>
!

"_________________________________________________________"
"display primitive function"
primXProtocolVersion
    <cCall: 'Xlib_XProtocolVersion' plugin: 'x11'>
!

"_________________________________________________________"
"event primitive function"
primXPutBackEvent: arg1
    <cCall: 'Xlib_XPutBackEvent' plugin: 'x11'>
!

"_________________________________________________________"
"height primitive function"
primXPutImage: arg1 gc: arg4 image: arg5 srcX: arg6 srcY: arg7 destX: arg8 destY: arg9 width: arg10 height: arg11
    <cCall: 'Xlib_XPutImage' plugin: 'x11'>
!

"_________________________________________________________"
"display primitive function"
primXQLength
    <cCall: 'Xlib_XQLength' plugin: 'x11'>
!

"_________________________________________________________"
"heightReturn primitive function"
primXQueryBestCursor: arg1 width: arg4 height: arg5 widthReturn: arg6 heightReturn: arg7
    <cCall: 'Xlib_XQueryBestCursor' plugin: 'x11'>
!

"_________________________________________________________"
"heightReturn primitive function"
primXQueryBestSize: arg1 whichScreen: arg4 width: arg5 height: arg6 widthReturn: arg7 heightReturn: arg8
    <cCall: 'Xlib_XQueryBestSize' plugin: 'x11'>
!

"_________________________________________________________"
"heightReturn primitive function"
primXQueryBestStipple: arg1 width: arg4 height: arg5 widthReturn: arg6 heightReturn: arg7
    <cCall: 'Xlib_XQueryBestStipple' plugin: 'x11'>
!

"_________________________________________________________"
"heightReturn primitive function"
primXQueryBestTile: arg1 width: arg4 height: arg5 widthReturn: arg6 heightReturn: arg7
    <cCall: 'Xlib_XQueryBestTile' plugin: 'x11'>
!

"_________________________________________________________"
"defInOut primitive function"
primXQueryColor: arg1 defInOut: arg4
    <cCall: 'Xlib_XQueryColor' plugin: 'x11'>
!

"_________________________________________________________"
"ncolors primitive function"
primXQueryColors: arg1 defsInOut: arg4 ncolors: arg5
    <cCall: 'Xlib_XQueryColors' plugin: 'x11'>
!

"_________________________________________________________"
"firstErrorReturn primitive function"
primXQueryExtension: arg1 majorOpcodeReturn: arg4 firstEventReturn: arg5 firstErrorReturn: arg6
    <cCall: 'Xlib_XQueryExtension' plugin: 'x11'>
!

"_________________________________________________________"
"keysReturn primitive function"
primXQueryKeymap: arg1
    <cCall: 'Xlib_XQueryKeymap' plugin: 'x11'>
!

"_________________________________________________________"
"maskReturn primitive function"
primXQueryPointer: arg1 rootReturn: arg4 childReturn: arg5 rootXReturn: arg6 rootYReturn: arg7 winXReturn: arg8 winYReturn: arg9 maskReturn: arg10
    <cCall: 'Xlib_XQueryPointer' plugin: 'x11'>
!

"_________________________________________________________"
"overallReturn primitive function"
primXQueryTextExtents: arg1 string: arg4 nchars: arg5 directionReturn: arg6 fontAscentReturn: arg7 fontDescentReturn: arg8 overallReturn: arg9
    <cCall: 'Xlib_XQueryTextExtents' plugin: 'x11'>
!

"_________________________________________________________"
"overallReturn primitive function"
primXQueryTextExtents16: arg1 string: arg4 nchars: arg5 directionReturn: arg6 fontAscentReturn: arg7 fontDescentReturn: arg8 overallReturn: arg9
    <cCall: 'Xlib_XQueryTextExtents16' plugin: 'x11'>
!

"_________________________________________________________"
"nchildrenReturn primitive function"
primXQueryTree: arg1 rootReturn: arg4 parentReturn: arg5 childrenReturn: arg6 nchildrenReturn: arg7
    <cCall: 'Xlib_XQueryTree' plugin: 'x11'>
!

"_________________________________________________________"
"w primitive function"
primXRaiseWindow: arg1
    <cCall: 'Xlib_XRaiseWindow' plugin: 'x11'>
!

"_________________________________________________________"
"yHotReturn primitive function"
primXReadBitmapFile: arg1 filename: arg4 widthReturn: arg5 heightReturn: arg6 bitmapReturn: arg7 xHotReturn: arg8 yHotReturn: arg9
    <cCall: 'Xlib_XReadBitmapFile' plugin: 'x11'>
!

"_________________________________________________________"
"bytesString primitive function"
primXRebindKeysym: arg1 list: arg4 modCount: arg5 string: arg6 bytesString: arg7
    <cCall: 'Xlib_XRebindKeysym' plugin: 'x11'>
!

"_________________________________________________________"
"backgroundColor primitive function"
primXRecolorCursor: arg1 foregroundColor: arg4 backgroundColor: arg5
    <cCall: 'Xlib_XRecolorCursor' plugin: 'x11'>
!

"_________________________________________________________"
"w primitive function"
primXRemoveFromSaveSet: arg1
    <cCall: 'Xlib_XRemoveFromSaveSet' plugin: 'x11'>
!

"_________________________________________________________"
"host primitive function"
primXRemoveHost: arg1
    <cCall: 'Xlib_XRemoveHost' plugin: 'x11'>
!

"_________________________________________________________"
"numHosts primitive function"
primXRemoveHosts: arg1 numHosts: arg4
    <cCall: 'Xlib_XRemoveHosts' plugin: 'x11'>
!

"_________________________________________________________"
"y primitive function"
primXReparentWindow: arg1 parent: arg4 x: arg5 y: arg6
    <cCall: 'Xlib_XReparentWindow' plugin: 'x11'>
!

"_________________________________________________________"
"display primitive function"
primXResetScreenSaver
    <cCall: 'Xlib_XResetScreenSaver' plugin: 'x11'>
!

"_________________________________________________________"
"height primitive function"
primXResizeWindow: arg1 width: arg4 height: arg5
    <cCall: 'Xlib_XResizeWindow' plugin: 'x11'>
!

"_________________________________________________________"
"nwindows primitive function"
primXRestackWindows: arg1 nwindows: arg4
    <cCall: 'Xlib_XRestackWindows' plugin: 'x11'>
!

"_________________________________________________________"
"rotate primitive function"
primXRotateBuffers: arg1
    <cCall: 'Xlib_XRotateBuffers' plugin: 'x11'>
!

"_________________________________________________________"
"npositions primitive function"
primXRotateWindowProperties: arg1 properties: arg4 numProp: arg5 npositions: arg6
    <cCall: 'Xlib_XRotateWindowProperties' plugin: 'x11'>
!

"_________________________________________________________"
"display primitive function"
primXScreenCount
    <cCall: 'Xlib_XScreenCount' plugin: 'x11'>
!

"_________________________________________________________"
"eventMask primitive function"
primXSelectInput: arg1 eventMask: arg4
    <cCall: 'Xlib_XSelectInput' plugin: 'x11'>
!

"_________________________________________________________"
"eventSend primitive function"
primXSendEvent: arg1 propagate: arg4 eventMask: arg5 eventSend: arg6
    <cCall: 'Xlib_XSendEvent' plugin: 'x11'>
!

"_________________________________________________________"
"mode primitive function"
primXSetAccessControl: arg1
    <cCall: 'Xlib_XSetAccessControl' plugin: 'x11'>
!

"_________________________________________________________"
"arcMode primitive function"
primXSetArcMode: arg1 arcMode: arg4
    <cCall: 'Xlib_XSetArcMode' plugin: 'x11'>
!

"_________________________________________________________"
"background primitive function"
primXSetBackground: arg1 background: arg4
    <cCall: 'Xlib_XSetBackground' plugin: 'x11'>
!

"_________________________________________________________"
"pixmap primitive function"
primXSetClipMask: arg1 pixmap: arg4
    <cCall: 'Xlib_XSetClipMask' plugin: 'x11'>
!

"_________________________________________________________"
"clipYOrigin primitive function"
primXSetClipOrigin: arg1 clipXOrigin: arg4 clipYOrigin: arg5
    <cCall: 'Xlib_XSetClipOrigin' plugin: 'x11'>
!

"_________________________________________________________"
"ordering primitive function"
primXSetClipRectangles: arg1 clipXOrigin: arg4 clipYOrigin: arg5 rectangles: arg6 n: arg7 ordering: arg8
    <cCall: 'Xlib_XSetClipRectangles' plugin: 'x11'>
!

"_________________________________________________________"
"closeMode primitive function"
primXSetCloseDownMode: arg1
    <cCall: 'Xlib_XSetCloseDownMode' plugin: 'x11'>
!

"_________________________________________________________"
"argc primitive function"
primXSetCommand: arg1 argv: arg4 argc: arg5
    <cCall: 'Xlib_XSetCommand' plugin: 'x11'>
!

"_________________________________________________________"
"n primitive function"
primXSetDashes: arg1 dashOffset: arg4 dashList: arg5 n: arg6
    <cCall: 'Xlib_XSetDashes' plugin: 'x11'>
!

"_________________________________________________________"
"fillRule primitive function"
primXSetFillRule: arg1 fillRule: arg4
    <cCall: 'Xlib_XSetFillRule' plugin: 'x11'>
!

"_________________________________________________________"
"fillStyle primitive function"
primXSetFillStyle: arg1 fillStyle: arg4
    <cCall: 'Xlib_XSetFillStyle' plugin: 'x11'>
!

"_________________________________________________________"
"font primitive function"
primXSetFont: arg1 font: arg4
    <cCall: 'Xlib_XSetFont' plugin: 'x11'>
!

"_________________________________________________________"
"ndirs primitive function"
primXSetFontPath: arg1 ndirs: arg4
    <cCall: 'Xlib_XSetFontPath' plugin: 'x11'>
!

"_________________________________________________________"
"foreground primitive function"
primXSetForeground: arg1 foreground: arg4
    <cCall: 'Xlib_XSetForeground' plugin: 'x11'>
!

"_________________________________________________________"
"function primitive function"
primXSetFunction: arg1 function: arg4
    <cCall: 'Xlib_XSetFunction' plugin: 'x11'>
!

"_________________________________________________________"
"graphicsExposures primitive function"
primXSetGraphicsExposures: arg1 graphicsExposures: arg4
    <cCall: 'Xlib_XSetGraphicsExposures' plugin: 'x11'>
!

"_________________________________________________________"
"iconName primitive function"
primXSetIconName: arg1 iconName: arg4
    <cCall: 'Xlib_XSetIconName' plugin: 'x11'>
!

"_________________________________________________________"
"time primitive function"
primXSetInputFocus: arg1 revertTo: arg4 time: arg5
    <cCall: 'Xlib_XSetInputFocus' plugin: 'x11'>
!

"_________________________________________________________"
"joinStyle primitive function"
primXSetLineAttributes: arg1 lineWidth: arg4 lineStyle: arg5 capStyle: arg6 joinStyle: arg7
    <cCall: 'Xlib_XSetLineAttributes' plugin: 'x11'>
!

"_________________________________________________________"
"modmap primitive function"
primXSetModifierMapping: arg1
    <cCall: 'Xlib_XSetModifierMapping' plugin: 'x11'>
!

"_________________________________________________________"
"planeMask primitive function"
primXSetPlaneMask: arg1 planeMask: arg4
    <cCall: 'Xlib_XSetPlaneMask' plugin: 'x11'>
!

"_________________________________________________________"
"nmap primitive function"
primXSetPointerMapping: arg1 nmap: arg4
    <cCall: 'Xlib_XSetPointerMapping' plugin: 'x11'>
!

"_________________________________________________________"
"allowExposures primitive function"
primXSetScreenSaver: arg1 interval: arg4 preferBlanking: arg5 allowExposures: arg6
    <cCall: 'Xlib_XSetScreenSaver' plugin: 'x11'>
!

"_________________________________________________________"
"time primitive function"
primXSetSelectionOwner: arg1 owner: arg4 time: arg5
    <cCall: 'Xlib_XSetSelectionOwner' plugin: 'x11'>
!

"_________________________________________________________"
"planeMask primitive function"
primXSetState: arg1 foreground: arg4 background: arg5 function: arg6 planeMask: arg7
    <cCall: 'Xlib_XSetState' plugin: 'x11'>
!

"_________________________________________________________"
"stipple primitive function"
primXSetStipple: arg1 stipple: arg4
    <cCall: 'Xlib_XSetStipple' plugin: 'x11'>
!

"_________________________________________________________"
"subwindowMode primitive function"
primXSetSubwindowMode: arg1 subwindowMode: arg4
    <cCall: 'Xlib_XSetSubwindowMode' plugin: 'x11'>
!

"_________________________________________________________"
"tsYOrigin primitive function"
primXSetTSOrigin: arg1 tsXOrigin: arg4 tsYOrigin: arg5
    <cCall: 'Xlib_XSetTSOrigin' plugin: 'x11'>
!

"_________________________________________________________"
"tile primitive function"
primXSetTile: arg1 tile: arg4
    <cCall: 'Xlib_XSetTile' plugin: 'x11'>
!

"_________________________________________________________"
"backgroundPixel primitive function"
primXSetWindowBackground: arg1 backgroundPixel: arg4
    <cCall: 'Xlib_XSetWindowBackground' plugin: 'x11'>
!

"_________________________________________________________"
"backgroundPixmap primitive function"
primXSetWindowBackgroundPixmap: arg1 backgroundPixmap: arg4
    <cCall: 'Xlib_XSetWindowBackgroundPixmap' plugin: 'x11'>
!

"_________________________________________________________"
"borderPixel primitive function"
primXSetWindowBorder: arg1 borderPixel: arg4
    <cCall: 'Xlib_XSetWindowBorder' plugin: 'x11'>
!

"_________________________________________________________"
"borderPixmap primitive function"
primXSetWindowBorderPixmap: arg1 borderPixmap: arg4
    <cCall: 'Xlib_XSetWindowBorderPixmap' plugin: 'x11'>
!

"_________________________________________________________"
"width primitive function"
primXSetWindowBorderWidth: arg1 width: arg4
    <cCall: 'Xlib_XSetWindowBorderWidth' plugin: 'x11'>
!

"_________________________________________________________"
"colormap primitive function"
primXSetWindowColormap: arg1 colormap: arg4
    <cCall: 'Xlib_XSetWindowColormap' plugin: 'x11'>
!

"_________________________________________________________"
"buffer primitive function"
primXStoreBuffer: arg1 nbytes: arg4 buffer: arg5
    <cCall: 'Xlib_XStoreBuffer' plugin: 'x11'>
!

"_________________________________________________________"
"nbytes primitive function"
primXStoreBytes: arg1 nbytes: arg4
    <cCall: 'Xlib_XStoreBytes' plugin: 'x11'>
!

"_________________________________________________________"
"color primitive function"
primXStoreColor: arg1 color: arg4
    <cCall: 'Xlib_XStoreColor' plugin: 'x11'>
!

"_________________________________________________________"
"ncolors primitive function"
primXStoreColors: arg1 color: arg4 ncolors: arg5
    <cCall: 'Xlib_XStoreColors' plugin: 'x11'>
!

"_________________________________________________________"
"windowName primitive function"
primXStoreName: arg1 windowName: arg4
    <cCall: 'Xlib_XStoreName' plugin: 'x11'>
!

"_________________________________________________________"
"flags primitive function"
primXStoreNamedColor: arg1 color: arg4 pixel: arg5 flags: arg6
    <cCall: 'Xlib_XStoreNamedColor' plugin: 'x11'>
!

"_________________________________________________________"
"discard primitive function"
primXSync: arg1
    <cCall: 'Xlib_XSync' plugin: 'x11'>
!

"_________________________________________________________"
"childReturn primitive function"
primXTranslateCoordinates: arg1 destW: arg4 srcX: arg5 srcY: arg6 destXReturn: arg7 destYReturn: arg8 childReturn: arg9
    <cCall: 'Xlib_XTranslateCoordinates' plugin: 'x11'>
!

"_________________________________________________________"
"w primitive function"
primXUndefineCursor: arg1
    <cCall: 'Xlib_XUndefineCursor' plugin: 'x11'>
!

"_________________________________________________________"
"grabWindow primitive function"
primXUngrabButton: arg1 modifiers: arg4 grabWindow: arg5
    <cCall: 'Xlib_XUngrabButton' plugin: 'x11'>
!

"_________________________________________________________"
"grabWindow primitive function"
primXUngrabKey: arg1 modifiers: arg4 grabWindow: arg5
    <cCall: 'Xlib_XUngrabKey' plugin: 'x11'>
!

"_________________________________________________________"
"time primitive function"
primXUngrabKeyboard: arg1
    <cCall: 'Xlib_XUngrabKeyboard' plugin: 'x11'>
!

"_________________________________________________________"
"time primitive function"
primXUngrabPointer: arg1
    <cCall: 'Xlib_XUngrabPointer' plugin: 'x11'>
!

"_________________________________________________________"
"display primitive function"
primXUngrabServer
    <cCall: 'Xlib_XUngrabServer' plugin: 'x11'>
!

"_________________________________________________________"
"colormap primitive function"
primXUninstallColormap: arg1
    <cCall: 'Xlib_XUninstallColormap' plugin: 'x11'>
!

"_________________________________________________________"
"font primitive function"
primXUnloadFont: arg1
    <cCall: 'Xlib_XUnloadFont' plugin: 'x11'>
!

"_________________________________________________________"
"w primitive function"
primXUnmapSubwindows: arg1
    <cCall: 'Xlib_XUnmapSubwindows' plugin: 'x11'>
!

"_________________________________________________________"
"w primitive function"
primXUnmapWindow: arg1
    <cCall: 'Xlib_XUnmapWindow' plugin: 'x11'>
!

"_________________________________________________________"
"display primitive function"
primXVendorRelease
    <cCall: 'Xlib_XVendorRelease' plugin: 'x11'>
!

"_________________________________________________________"
"destY primitive function"
primXWarpPointer: arg1 destW: arg4 srcX: arg5 srcY: arg6 srcWidth: arg7 srcHeight: arg8 destX: arg9 destY: arg10
    <cCall: 'Xlib_XWarpPointer' plugin: 'x11'>
!

"_________________________________________________________"
"eventReturn primitive function"
primXWindowEvent: arg1 eventMask: arg4 eventReturn: arg5
    <cCall: 'Xlib_XWindowEvent' plugin: 'x11'>
!

"_________________________________________________________"
"yHot primitive function"
primXWriteBitmapFile: arg1 bitmap: arg4 width: arg5 height: arg6 xHot: arg7 yHot: arg8
    <cCall: 'Xlib_XWriteBitmapFile' plugin: 'x11'>
!

"_________________________________________________________"
"resClass primitive function"
primXOpenOM: arg1 resName: arg4 resClass: arg5
    <cCall: 'Xlib_XOpenOM' plugin: 'x11'>
!

"_________________________________________________________"
"defString primitive function"
primXCreateFontSet: arg1 missingCharsetList: arg4 missingCharsetCount: arg5 defString: arg6
    <cCall: 'Xlib_XCreateFontSet' plugin: 'x11'>
!

"_________________________________________________________"
"fontSet primitive function"
primXFreeFontSet: arg1
    <cCall: 'Xlib_XFreeFontSet' plugin: 'x11'>
!

"_________________________________________________________"
"nitems primitive function"
primXmbDrawText: arg1 gc: arg4 x: arg5 y: arg6 textItems: arg7 nitems: arg8
    <cCall: 'Xlib_XmbDrawText' plugin: 'x11'>
!

"_________________________________________________________"
"nitems primitive function"
primXwcDrawText: arg1 gc: arg4 x: arg5 y: arg6 textItems: arg7 nitems: arg8
    <cCall: 'Xlib_XwcDrawText' plugin: 'x11'>
!

"_________________________________________________________"
"bytesText primitive function"
primXmbDrawString: arg1 fontSet: arg4 gc: arg5 x: arg6 y: arg7 text: arg8 bytesText: arg9
    <cCall: 'Xlib_XmbDrawString' plugin: 'x11'>
!

"_________________________________________________________"
"numWchars primitive function"
primXwcDrawString: arg1 fontSet: arg4 gc: arg5 x: arg6 y: arg7 text: arg8 numWchars: arg9
    <cCall: 'Xlib_XwcDrawString' plugin: 'x11'>
!

"_________________________________________________________"
"bytesText primitive function"
primXmbDrawImageString: arg1 fontSet: arg4 gc: arg5 x: arg6 y: arg7 text: arg8 bytesText: arg9
    <cCall: 'Xlib_XmbDrawImageString' plugin: 'x11'>
!

"_________________________________________________________"
"numWchars primitive function"
primXwcDrawImageString: arg1 fontSet: arg4 gc: arg5 x: arg6 y: arg7 text: arg8 numWchars: arg9
    <cCall: 'Xlib_XwcDrawImageString' plugin: 'x11'>
!

"_________________________________________________________"
"resClass primitive function"
primXOpenIM: arg1 resName: arg4 resClass: arg5
    <cCall: 'Xlib_XOpenIM' plugin: 'x11'>
!

"_________________________________________________________"
"clientData primitive function"
primXRegisterIMInstantiateCallback: arg1 resName: arg4 resClass: arg5 callback: arg6 clientData: arg7
    <cCall: 'Xlib_XRegisterIMInstantiateCallback' plugin: 'x11'>
!

"_________________________________________________________"
"clientData primitive function"
primXUnregisterIMInstantiateCallback: arg1 resName: arg4 resClass: arg5 callback: arg6 clientData: arg7
    <cCall: 'Xlib_XUnregisterIMInstantiateCallback' plugin: 'x11'>
!

"_________________________________________________________"
"countReturn primitive function"
primXInternalConnectionNumbers: arg1 countReturn: arg4
    <cCall: 'Xlib_XInternalConnectionNumbers' plugin: 'x11'>
!

"_________________________________________________________"
"fd primitive function"
primXProcessInternalConnection: arg1
    <cCall: 'Xlib_XProcessInternalConnection' plugin: 'x11'>
!

"_________________________________________________________"
"clientData primitive function"
primXAddConnectionWatch: arg1 clientData: arg4
    <cCall: 'Xlib_XAddConnectionWatch' plugin: 'x11'>
!

"_________________________________________________________"
"clientData primitive function"
primXRemoveConnectionWatch: arg1 clientData: arg4
    <cCall: 'Xlib_XRemoveConnectionWatch' plugin: 'x11'>
!




primXlibDisplayDelete
    <cCall: 'Xlib_delete_Display' plugin: 'x11'>
!

delete
    ^self primXlibDisplayDelete.
!


name
    ^'XlibDisplay'

! !

!XlibDisplay methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibDisplay methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXHostAddress
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXHostAddress class methodsFor: 'initialize-release'!

primXlibXHostAddressCreate
    <cCall: 'Xlib_new_XHostAddress' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXHostAddressCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXHostAddress  methodsFor: 'Xlib'!

"_________________________________________________________"
"family primitive accessors"
primXHostAddressFamily
    <cCall: 'Xlib_XHostAddress_family_get' plugin: 'x11'>
!
primXHostAddressFamily: val
    <cCall: 'Xlib_XHostAddress_family_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XHostAddress_length_get' plugin: 'x11'>
!
primXHostAddressLength: val
    <cCall: 'Xlib_XHostAddress_length_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XHostAddress_address_get' plugin: 'x11'>
!
primXHostAddressAddress: val
    <cCall: 'Xlib_XHostAddress_address_set' plugin: 'x11'>
!
"........................................................"
"address accessors"
address
    ^self primXHostAddressAddress
!
address: val
    ^self primXHostAddressAddress: val
!






primXlibXHostAddressDelete
    <cCall: 'Xlib_delete_XHostAddress' plugin: 'x11'>
!

delete
    ^self primXlibXHostAddressDelete.
!


name
    ^'XlibXHostAddress'

! !

!XlibXHostAddress methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXHostAddress methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibDepth
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibDepth class methodsFor: 'initialize-release'!

primXlibDepthCreate
    <cCall: 'Xlib_new_Depth' plugin: 'x11'>
!

create
    ^self handle: (self primXlibDepthCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibDepth  methodsFor: 'Xlib'!

"_________________________________________________________"
"depth primitive accessors"
primDepthDepth
    <cCall: 'Xlib_Depth_depth_get' plugin: 'x11'>
!
primDepthDepth: val
    <cCall: 'Xlib_Depth_depth_set' plugin: 'x11'>
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
    <cCall: 'Xlib_Depth_nvisuals_get' plugin: 'x11'>
!
primDepthNvisuals: val
    <cCall: 'Xlib_Depth_nvisuals_set' plugin: 'x11'>
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
    <cCall: 'Xlib_Depth_visuals_get' plugin: 'x11'>
!
primDepthVisuals: val
    <cCall: 'Xlib_Depth_visuals_set' plugin: 'x11'>
!
"........................................................"
"visuals accessors"
visuals
    ^self primDepthVisuals
!
visuals: val
    ^self primDepthVisuals: val
!






primXlibDepthDelete
    <cCall: 'Xlib_delete_Depth' plugin: 'x11'>
!

delete
    ^self primXlibDepthDelete.
!


name
    ^'XlibDepth'

! !

!XlibDepth methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibDepth methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXEDataObject
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXEDataObject class methodsFor: 'initialize-release'!

primXlibXEDataObjectCreate
    <cCall: 'Xlib_new_XEDataObject' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXEDataObjectCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXEDataObject  methodsFor: 'Xlib'!

"_________________________________________________________"
"display primitive accessors"
primXEDataObjectDisplay
    <cCall: 'Xlib_XEDataObject_display_get' plugin: 'x11'>
!
primXEDataObjectDisplay: val
    <cCall: 'Xlib_XEDataObject_display_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XEDataObject_gc_get' plugin: 'x11'>
!
primXEDataObjectGc: val
    <cCall: 'Xlib_XEDataObject_gc_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XEDataObject_visual_get' plugin: 'x11'>
!
primXEDataObjectVisual: val
    <cCall: 'Xlib_XEDataObject_visual_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XEDataObject_screen_get' plugin: 'x11'>
!
primXEDataObjectScreen: val
    <cCall: 'Xlib_XEDataObject_screen_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XEDataObject_pixmap_format_get' plugin: 'x11'>
!
primXEDataObjectPixmapFormat: val
    <cCall: 'Xlib_XEDataObject_pixmap_format_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XEDataObject_font_get' plugin: 'x11'>
!
primXEDataObjectFont: val
    <cCall: 'Xlib_XEDataObject_font_set' plugin: 'x11'>
!
"........................................................"
"font accessors"
font
    ^self primXEDataObjectFont
!
font: val
    ^self primXEDataObjectFont: val
!






primXlibXEDataObjectDelete
    <cCall: 'Xlib_delete_XEDataObject' plugin: 'x11'>
!

delete
    ^self primXlibXEDataObjectDelete.
!


name
    ^'XlibXEDataObject'

! !

!XlibXEDataObject methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXEDataObject methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibScreen
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibScreen class methodsFor: 'initialize-release'!

primXlibScreenCreate
    <cCall: 'Xlib_new_Screen' plugin: 'x11'>
!

create
    ^self handle: (self primXlibScreenCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibScreen  methodsFor: 'Xlib'!

"_________________________________________________________"
"ext_data primitive accessors"
primScreenExtData
    <cCall: 'Xlib_Screen_ext_data_get' plugin: 'x11'>
!
primScreenExtData: val
    <cCall: 'Xlib_Screen_ext_data_set' plugin: 'x11'>
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
    <cCall: 'Xlib_Screen_display_get' plugin: 'x11'>
!
primScreenDisplay: val
    <cCall: 'Xlib_Screen_display_set' plugin: 'x11'>
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
    <cCall: 'Xlib_Screen_root_get' plugin: 'x11'>
!
primScreenRoot: val
    <cCall: 'Xlib_Screen_root_set' plugin: 'x11'>
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
    <cCall: 'Xlib_Screen_width_get' plugin: 'x11'>
!
primScreenWidth: val
    <cCall: 'Xlib_Screen_width_set' plugin: 'x11'>
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
    <cCall: 'Xlib_Screen_height_get' plugin: 'x11'>
!
primScreenHeight: val
    <cCall: 'Xlib_Screen_height_set' plugin: 'x11'>
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
    <cCall: 'Xlib_Screen_mwidth_get' plugin: 'x11'>
!
primScreenMwidth: val
    <cCall: 'Xlib_Screen_mwidth_set' plugin: 'x11'>
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
    <cCall: 'Xlib_Screen_mheight_get' plugin: 'x11'>
!
primScreenMheight: val
    <cCall: 'Xlib_Screen_mheight_set' plugin: 'x11'>
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
    <cCall: 'Xlib_Screen_ndepths_get' plugin: 'x11'>
!
primScreenNdepths: val
    <cCall: 'Xlib_Screen_ndepths_set' plugin: 'x11'>
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
    <cCall: 'Xlib_Screen_depths_get' plugin: 'x11'>
!
primScreenDepths: val
    <cCall: 'Xlib_Screen_depths_set' plugin: 'x11'>
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
    <cCall: 'Xlib_Screen_root_depth_get' plugin: 'x11'>
!
primScreenRootDepth: val
    <cCall: 'Xlib_Screen_root_depth_set' plugin: 'x11'>
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
    <cCall: 'Xlib_Screen_root_visual_get' plugin: 'x11'>
!
primScreenRootVisual: val
    <cCall: 'Xlib_Screen_root_visual_set' plugin: 'x11'>
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
    <cCall: 'Xlib_Screen_default_gc_get' plugin: 'x11'>
!
primScreenDefaultGc: val
    <cCall: 'Xlib_Screen_default_gc_set' plugin: 'x11'>
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
    <cCall: 'Xlib_Screen_cmap_get' plugin: 'x11'>
!
primScreenCmap: val
    <cCall: 'Xlib_Screen_cmap_set' plugin: 'x11'>
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
    <cCall: 'Xlib_Screen_white_pixel_get' plugin: 'x11'>
!
primScreenWhitePixel: val
    <cCall: 'Xlib_Screen_white_pixel_set' plugin: 'x11'>
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
    <cCall: 'Xlib_Screen_black_pixel_get' plugin: 'x11'>
!
primScreenBlackPixel: val
    <cCall: 'Xlib_Screen_black_pixel_set' plugin: 'x11'>
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
    <cCall: 'Xlib_Screen_max_maps_get' plugin: 'x11'>
!
primScreenMaxMaps: val
    <cCall: 'Xlib_Screen_max_maps_set' plugin: 'x11'>
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
    <cCall: 'Xlib_Screen_min_maps_get' plugin: 'x11'>
!
primScreenMinMaps: val
    <cCall: 'Xlib_Screen_min_maps_set' plugin: 'x11'>
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
    <cCall: 'Xlib_Screen_backing_store_get' plugin: 'x11'>
!
primScreenBackingStore: val
    <cCall: 'Xlib_Screen_backing_store_set' plugin: 'x11'>
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
    <cCall: 'Xlib_Screen_save_unders_get' plugin: 'x11'>
!
primScreenSaveUnders: val
    <cCall: 'Xlib_Screen_save_unders_set' plugin: 'x11'>
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
    <cCall: 'Xlib_Screen_root_input_mask_get' plugin: 'x11'>
!
primScreenRootInputMask: val
    <cCall: 'Xlib_Screen_root_input_mask_set' plugin: 'x11'>
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
"screen primitive function"
primXScreenResourceString
    <cCall: 'Xlib_XScreenResourceString' plugin: 'x11'>
!

"_________________________________________________________"
"screen primitive function"
primXRootWindowOfScreen
    <cCall: 'Xlib_XRootWindowOfScreen' plugin: 'x11'>
!

"_________________________________________________________"
"screen primitive function"
primXDefaultVisualOfScreen
    <cCall: 'Xlib_XDefaultVisualOfScreen' plugin: 'x11'>
!

"_________________________________________________________"
"screen primitive function"
primXDefaultGCOfScreen
    <cCall: 'Xlib_XDefaultGCOfScreen' plugin: 'x11'>
!

"_________________________________________________________"
"screen primitive function"
primXBlackPixelOfScreen
    <cCall: 'Xlib_XBlackPixelOfScreen' plugin: 'x11'>
!

"_________________________________________________________"
"screen primitive function"
primXWhitePixelOfScreen
    <cCall: 'Xlib_XWhitePixelOfScreen' plugin: 'x11'>
!

"_________________________________________________________"
"screen primitive function"
primXDefaultColormapOfScreen
    <cCall: 'Xlib_XDefaultColormapOfScreen' plugin: 'x11'>
!

"_________________________________________________________"
"screen primitive function"
primXDisplayOfScreen
    <cCall: 'Xlib_XDisplayOfScreen' plugin: 'x11'>
!

"_________________________________________________________"
"screen primitive function"
primXEventMaskOfScreen
    <cCall: 'Xlib_XEventMaskOfScreen' plugin: 'x11'>
!

"_________________________________________________________"
"screen primitive function"
primXScreenNumberOfScreen
    <cCall: 'Xlib_XScreenNumberOfScreen' plugin: 'x11'>
!

"_________________________________________________________"
"screen primitive function"
primXCellsOfScreen
    <cCall: 'Xlib_XCellsOfScreen' plugin: 'x11'>
!

"_________________________________________________________"
"screen primitive function"
primXDefaultDepthOfScreen
    <cCall: 'Xlib_XDefaultDepthOfScreen' plugin: 'x11'>
!

"_________________________________________________________"
"screen primitive function"
primXDoesBackingStore
    <cCall: 'Xlib_XDoesBackingStore' plugin: 'x11'>
!

"_________________________________________________________"
"screen primitive function"
primXDoesSaveUnders
    <cCall: 'Xlib_XDoesSaveUnders' plugin: 'x11'>
!

"_________________________________________________________"
"screen primitive function"
primXHeightMMOfScreen
    <cCall: 'Xlib_XHeightMMOfScreen' plugin: 'x11'>
!

"_________________________________________________________"
"screen primitive function"
primXHeightOfScreen
    <cCall: 'Xlib_XHeightOfScreen' plugin: 'x11'>
!

"_________________________________________________________"
"screen primitive function"
primXMaxCmapsOfScreen
    <cCall: 'Xlib_XMaxCmapsOfScreen' plugin: 'x11'>
!

"_________________________________________________________"
"screen primitive function"
primXMinCmapsOfScreen
    <cCall: 'Xlib_XMinCmapsOfScreen' plugin: 'x11'>
!

"_________________________________________________________"
"screen primitive function"
primXPlanesOfScreen
    <cCall: 'Xlib_XPlanesOfScreen' plugin: 'x11'>
!

"_________________________________________________________"
"screen primitive function"
primXWidthMMOfScreen
    <cCall: 'Xlib_XWidthMMOfScreen' plugin: 'x11'>
!

"_________________________________________________________"
"screen primitive function"
primXWidthOfScreen
    <cCall: 'Xlib_XWidthOfScreen' plugin: 'x11'>
!




primXlibScreenDelete
    <cCall: 'Xlib_delete_Screen' plugin: 'x11'>
!

delete
    ^self primXlibScreenDelete.
!


name
    ^'XlibScreen'

! !

!XlibScreen methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibScreen methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXIMStringConversionText
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXIMStringConversionText class methodsFor: 'initialize-release'!

primXlibXIMStringConversionTextCreate
    <cCall: 'Xlib_new_XIMStringConversionText' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXIMStringConversionTextCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXIMStringConversionText  methodsFor: 'Xlib'!

"_________________________________________________________"
"length primitive accessors"
primXIMStringConversionTextLength
    <cCall: 'Xlib_XIMStringConversionText_length_get' plugin: 'x11'>
!
primXIMStringConversionTextLength: val
    <cCall: 'Xlib_XIMStringConversionText_length_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XIMStringConversionText_feedback_get' plugin: 'x11'>
!
primXIMStringConversionTextFeedback: val
    <cCall: 'Xlib_XIMStringConversionText_feedback_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XIMStringConversionText_encoding_is_wchar_get' plugin: 'x11'>
!
primXIMStringConversionTextEncodingIsWchar: val
    <cCall: 'Xlib_XIMStringConversionText_encoding_is_wchar_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XIMStringConversionText_string_get' plugin: 'x11'>
!
primXIMStringConversionTextString: val
    <cCall: 'Xlib_XIMStringConversionText_string_set' plugin: 'x11'>
!
"........................................................"
"string accessors"
string
    ^self primXIMStringConversionTextString
!
string: val
    ^self primXIMStringConversionTextString: val
!






primXlibXIMStringConversionTextDelete
    <cCall: 'Xlib_delete_XIMStringConversionText' plugin: 'x11'>
!

delete
    ^self primXlibXIMStringConversionTextDelete.
!


name
    ^'XlibXIMStringConversionText'

! !

!XlibXIMStringConversionText methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXIMStringConversionText methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXImage
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXImage class methodsFor: 'initialize-release'!

primXlibXImageCreate
    <cCall: 'Xlib_new_XImage' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXImageCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXImage  methodsFor: 'Xlib'!

"_________________________________________________________"
"width primitive accessors"
primXImageWidth
    <cCall: 'Xlib_XImage_width_get' plugin: 'x11'>
!
primXImageWidth: val
    <cCall: 'Xlib_XImage_width_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XImage_height_get' plugin: 'x11'>
!
primXImageHeight: val
    <cCall: 'Xlib_XImage_height_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XImage_xoffset_get' plugin: 'x11'>
!
primXImageXoffset: val
    <cCall: 'Xlib_XImage_xoffset_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XImage_format_get' plugin: 'x11'>
!
primXImageFormat: val
    <cCall: 'Xlib_XImage_format_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XImage_data_get' plugin: 'x11'>
!
primXImageData: val
    <cCall: 'Xlib_XImage_data_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XImage_byte_order_get' plugin: 'x11'>
!
primXImageByteOrder: val
    <cCall: 'Xlib_XImage_byte_order_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XImage_bitmap_unit_get' plugin: 'x11'>
!
primXImageBitmapUnit: val
    <cCall: 'Xlib_XImage_bitmap_unit_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XImage_bitmap_bit_order_get' plugin: 'x11'>
!
primXImageBitmapBitOrder: val
    <cCall: 'Xlib_XImage_bitmap_bit_order_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XImage_bitmap_pad_get' plugin: 'x11'>
!
primXImageBitmapPad: val
    <cCall: 'Xlib_XImage_bitmap_pad_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XImage_depth_get' plugin: 'x11'>
!
primXImageDepth: val
    <cCall: 'Xlib_XImage_depth_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XImage_bytes_per_line_get' plugin: 'x11'>
!
primXImageBytesPerLine: val
    <cCall: 'Xlib_XImage_bytes_per_line_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XImage_bits_per_pixel_get' plugin: 'x11'>
!
primXImageBitsPerPixel: val
    <cCall: 'Xlib_XImage_bits_per_pixel_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XImage_red_mask_get' plugin: 'x11'>
!
primXImageRedMask: val
    <cCall: 'Xlib_XImage_red_mask_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XImage_green_mask_get' plugin: 'x11'>
!
primXImageGreenMask: val
    <cCall: 'Xlib_XImage_green_mask_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XImage_blue_mask_get' plugin: 'x11'>
!
primXImageBlueMask: val
    <cCall: 'Xlib_XImage_blue_mask_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XImage_obdata_get' plugin: 'x11'>
!
primXImageObdata: val
    <cCall: 'Xlib_XImage_obdata_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XImage_f_get' plugin: 'x11'>
!
primXImageF: val
    <cCall: 'Xlib_XImage_f_set' plugin: 'x11'>
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
"image primitive function"
primXInitImage
    <cCall: 'Xlib_XInitImage' plugin: 'x11'>
!




primXlibXImageDelete
    <cCall: 'Xlib_delete_XImage' plugin: 'x11'>
!

delete
    ^self primXlibXImageDelete.
!


name
    ^'XlibXImage'

! !

!XlibXImage methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXImage methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXRectangle
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXRectangle class methodsFor: 'initialize-release'!

primXlibXRectangleCreate
    <cCall: 'Xlib_new_XRectangle' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXRectangleCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXRectangle  methodsFor: 'Xlib'!

"_________________________________________________________"
"x primitive accessors"
primXRectangleX
    <cCall: 'Xlib_XRectangle_x_get' plugin: 'x11'>
!
primXRectangleX: val
    <cCall: 'Xlib_XRectangle_x_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XRectangle_y_get' plugin: 'x11'>
!
primXRectangleY: val
    <cCall: 'Xlib_XRectangle_y_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XRectangle_width_get' plugin: 'x11'>
!
primXRectangleWidth: val
    <cCall: 'Xlib_XRectangle_width_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XRectangle_height_get' plugin: 'x11'>
!
primXRectangleHeight: val
    <cCall: 'Xlib_XRectangle_height_set' plugin: 'x11'>
!
"........................................................"
"height accessors"
height
    ^self primXRectangleHeight
!
height: val
    ^self primXRectangleHeight: val
!






primXlibXRectangleDelete
    <cCall: 'Xlib_delete_XRectangle' plugin: 'x11'>
!

delete
    ^self primXlibXRectangleDelete.
!


name
    ^'XlibXRectangle'

! !

!XlibXRectangle methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXRectangle methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXNoExposeEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXNoExposeEvent class methodsFor: 'initialize-release'!

primXlibXNoExposeEventCreate
    <cCall: 'Xlib_new_XNoExposeEvent' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXNoExposeEventCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXNoExposeEvent  methodsFor: 'Xlib'!

"_________________________________________________________"
"type primitive accessors"
primXNoExposeEventType
    <cCall: 'Xlib_XNoExposeEvent_type_get' plugin: 'x11'>
!
primXNoExposeEventType: val
    <cCall: 'Xlib_XNoExposeEvent_type_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XNoExposeEvent_serial_get' plugin: 'x11'>
!
primXNoExposeEventSerial: val
    <cCall: 'Xlib_XNoExposeEvent_serial_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XNoExposeEvent_send_event_get' plugin: 'x11'>
!
primXNoExposeEventSendEvent: val
    <cCall: 'Xlib_XNoExposeEvent_send_event_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XNoExposeEvent_display_get' plugin: 'x11'>
!
primXNoExposeEventDisplay: val
    <cCall: 'Xlib_XNoExposeEvent_display_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XNoExposeEvent_drawable_get' plugin: 'x11'>
!
primXNoExposeEventDrawable: val
    <cCall: 'Xlib_XNoExposeEvent_drawable_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XNoExposeEvent_major_code_get' plugin: 'x11'>
!
primXNoExposeEventMajorCode: val
    <cCall: 'Xlib_XNoExposeEvent_major_code_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XNoExposeEvent_minor_code_get' plugin: 'x11'>
!
primXNoExposeEventMinorCode: val
    <cCall: 'Xlib_XNoExposeEvent_minor_code_set' plugin: 'x11'>
!
"........................................................"
"minor_code accessors"
minorcode
    ^self primXNoExposeEventMinorCode
!
minorcode: val
    ^self primXNoExposeEventMinorCode: val
!






primXlibXNoExposeEventDelete
    <cCall: 'Xlib_delete_XNoExposeEvent' plugin: 'x11'>
!

delete
    ^self primXlibXNoExposeEventDelete.
!


name
    ^'XlibXNoExposeEvent'

! !

!XlibXNoExposeEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXNoExposeEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXEvent class methodsFor: 'initialize-release'!

primXlibXEventCreate
    <cCall: 'Xlib_new_XEvent' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXEventCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXEvent  methodsFor: 'Xlib'!

"_________________________________________________________"
"type primitive accessors"
primXEventType
    <cCall: 'Xlib_XEvent_type_get' plugin: 'x11'>
!
primXEventType: val
    <cCall: 'Xlib_XEvent_type_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XEvent_xany_get' plugin: 'x11'>
!
primXEventXany: val
    <cCall: 'Xlib_XEvent_xany_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XEvent_xkey_get' plugin: 'x11'>
!
primXEventXkey: val
    <cCall: 'Xlib_XEvent_xkey_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XEvent_xbutton_get' plugin: 'x11'>
!
primXEventXbutton: val
    <cCall: 'Xlib_XEvent_xbutton_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XEvent_xmotion_get' plugin: 'x11'>
!
primXEventXmotion: val
    <cCall: 'Xlib_XEvent_xmotion_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XEvent_xcrossing_get' plugin: 'x11'>
!
primXEventXcrossing: val
    <cCall: 'Xlib_XEvent_xcrossing_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XEvent_xfocus_get' plugin: 'x11'>
!
primXEventXfocus: val
    <cCall: 'Xlib_XEvent_xfocus_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XEvent_xexpose_get' plugin: 'x11'>
!
primXEventXexpose: val
    <cCall: 'Xlib_XEvent_xexpose_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XEvent_xgraphicsexpose_get' plugin: 'x11'>
!
primXEventXgraphicsexpose: val
    <cCall: 'Xlib_XEvent_xgraphicsexpose_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XEvent_xnoexpose_get' plugin: 'x11'>
!
primXEventXnoexpose: val
    <cCall: 'Xlib_XEvent_xnoexpose_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XEvent_xvisibility_get' plugin: 'x11'>
!
primXEventXvisibility: val
    <cCall: 'Xlib_XEvent_xvisibility_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XEvent_xcreatewindow_get' plugin: 'x11'>
!
primXEventXcreatewindow: val
    <cCall: 'Xlib_XEvent_xcreatewindow_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XEvent_xdestroywindow_get' plugin: 'x11'>
!
primXEventXdestroywindow: val
    <cCall: 'Xlib_XEvent_xdestroywindow_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XEvent_xunmap_get' plugin: 'x11'>
!
primXEventXunmap: val
    <cCall: 'Xlib_XEvent_xunmap_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XEvent_xmap_get' plugin: 'x11'>
!
primXEventXmap: val
    <cCall: 'Xlib_XEvent_xmap_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XEvent_xmaprequest_get' plugin: 'x11'>
!
primXEventXmaprequest: val
    <cCall: 'Xlib_XEvent_xmaprequest_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XEvent_xreparent_get' plugin: 'x11'>
!
primXEventXreparent: val
    <cCall: 'Xlib_XEvent_xreparent_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XEvent_xconfigure_get' plugin: 'x11'>
!
primXEventXconfigure: val
    <cCall: 'Xlib_XEvent_xconfigure_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XEvent_xgravity_get' plugin: 'x11'>
!
primXEventXgravity: val
    <cCall: 'Xlib_XEvent_xgravity_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XEvent_xresizerequest_get' plugin: 'x11'>
!
primXEventXresizerequest: val
    <cCall: 'Xlib_XEvent_xresizerequest_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XEvent_xconfigurerequest_get' plugin: 'x11'>
!
primXEventXconfigurerequest: val
    <cCall: 'Xlib_XEvent_xconfigurerequest_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XEvent_xcirculate_get' plugin: 'x11'>
!
primXEventXcirculate: val
    <cCall: 'Xlib_XEvent_xcirculate_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XEvent_xcirculaterequest_get' plugin: 'x11'>
!
primXEventXcirculaterequest: val
    <cCall: 'Xlib_XEvent_xcirculaterequest_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XEvent_xproperty_get' plugin: 'x11'>
!
primXEventXproperty: val
    <cCall: 'Xlib_XEvent_xproperty_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XEvent_xselectionclear_get' plugin: 'x11'>
!
primXEventXselectionclear: val
    <cCall: 'Xlib_XEvent_xselectionclear_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XEvent_xselectionrequest_get' plugin: 'x11'>
!
primXEventXselectionrequest: val
    <cCall: 'Xlib_XEvent_xselectionrequest_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XEvent_xselection_get' plugin: 'x11'>
!
primXEventXselection: val
    <cCall: 'Xlib_XEvent_xselection_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XEvent_xcolormap_get' plugin: 'x11'>
!
primXEventXcolormap: val
    <cCall: 'Xlib_XEvent_xcolormap_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XEvent_xclient_get' plugin: 'x11'>
!
primXEventXclient: val
    <cCall: 'Xlib_XEvent_xclient_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XEvent_xmapping_get' plugin: 'x11'>
!
primXEventXmapping: val
    <cCall: 'Xlib_XEvent_xmapping_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XEvent_xerror_get' plugin: 'x11'>
!
primXEventXerror: val
    <cCall: 'Xlib_XEvent_xerror_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XEvent_xkeymap_get' plugin: 'x11'>
!
primXEventXkeymap: val
    <cCall: 'Xlib_XEvent_xkeymap_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XEvent_pad_get' plugin: 'x11'>
!
primXEventPad: val
    <cCall: 'Xlib_XEvent_pad_set' plugin: 'x11'>
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
"window primitive function"
primXFilterEvent: arg1
    <cCall: 'Xlib_XFilterEvent' plugin: 'x11'>
!




primXlibXEventDelete
    <cCall: 'Xlib_delete_XEvent' plugin: 'x11'>
!

delete
    ^self primXlibXEventDelete.
!


name
    ^'XlibXEvent'

! !

!XlibXEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXFontStruct
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXFontStruct class methodsFor: 'initialize-release'!

primXlibXFontStructCreate
    <cCall: 'Xlib_new_XFontStruct' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXFontStructCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXFontStruct  methodsFor: 'Xlib'!

"_________________________________________________________"
"ext_data primitive accessors"
primXFontStructExtData
    <cCall: 'Xlib_XFontStruct_ext_data_get' plugin: 'x11'>
!
primXFontStructExtData: val
    <cCall: 'Xlib_XFontStruct_ext_data_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XFontStruct_fid_get' plugin: 'x11'>
!
primXFontStructFid: val
    <cCall: 'Xlib_XFontStruct_fid_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XFontStruct_direction_get' plugin: 'x11'>
!
primXFontStructDirection: val
    <cCall: 'Xlib_XFontStruct_direction_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XFontStruct_min_char_or_byte2_get' plugin: 'x11'>
!
primXFontStructMinCharOrByte2: val
    <cCall: 'Xlib_XFontStruct_min_char_or_byte2_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XFontStruct_max_char_or_byte2_get' plugin: 'x11'>
!
primXFontStructMaxCharOrByte2: val
    <cCall: 'Xlib_XFontStruct_max_char_or_byte2_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XFontStruct_min_byte1_get' plugin: 'x11'>
!
primXFontStructMinByte1: val
    <cCall: 'Xlib_XFontStruct_min_byte1_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XFontStruct_max_byte1_get' plugin: 'x11'>
!
primXFontStructMaxByte1: val
    <cCall: 'Xlib_XFontStruct_max_byte1_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XFontStruct_all_chars_exist_get' plugin: 'x11'>
!
primXFontStructAllCharsExist: val
    <cCall: 'Xlib_XFontStruct_all_chars_exist_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XFontStruct_default_char_get' plugin: 'x11'>
!
primXFontStructDefaultChar: val
    <cCall: 'Xlib_XFontStruct_default_char_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XFontStruct_n_properties_get' plugin: 'x11'>
!
primXFontStructNProperties: val
    <cCall: 'Xlib_XFontStruct_n_properties_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XFontStruct_properties_get' plugin: 'x11'>
!
primXFontStructProperties: val
    <cCall: 'Xlib_XFontStruct_properties_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XFontStruct_min_bounds_get' plugin: 'x11'>
!
primXFontStructMinBounds: val
    <cCall: 'Xlib_XFontStruct_min_bounds_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XFontStruct_max_bounds_get' plugin: 'x11'>
!
primXFontStructMaxBounds: val
    <cCall: 'Xlib_XFontStruct_max_bounds_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XFontStruct_per_char_get' plugin: 'x11'>
!
primXFontStructPerChar: val
    <cCall: 'Xlib_XFontStruct_per_char_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XFontStruct_ascent_get' plugin: 'x11'>
!
primXFontStructAscent: val
    <cCall: 'Xlib_XFontStruct_ascent_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XFontStruct_descent_get' plugin: 'x11'>
!
primXFontStructDescent: val
    <cCall: 'Xlib_XFontStruct_descent_set' plugin: 'x11'>
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
"valueReturn primitive function"
primXGetFontProperty: arg1 valueReturn: arg4
    <cCall: 'Xlib_XGetFontProperty' plugin: 'x11'>
!

"_________________________________________________________"
"overallReturn primitive function"
primXTextExtents: arg1 nchars: arg4 directionReturn: arg5 fontAscentReturn: arg6 fontDescentReturn: arg7 overallReturn: arg8
    <cCall: 'Xlib_XTextExtents' plugin: 'x11'>
!

"_________________________________________________________"
"overallReturn primitive function"
primXTextExtents16: arg1 nchars: arg4 directionReturn: arg5 fontAscentReturn: arg6 fontDescentReturn: arg7 overallReturn: arg8
    <cCall: 'Xlib_XTextExtents16' plugin: 'x11'>
!

"_________________________________________________________"
"count primitive function"
primXTextWidth: arg1 count: arg4
    <cCall: 'Xlib_XTextWidth' plugin: 'x11'>
!

"_________________________________________________________"
"count primitive function"
primXTextWidth16: arg1 count: arg4
    <cCall: 'Xlib_XTextWidth16' plugin: 'x11'>
!




primXlibXFontStructDelete
    <cCall: 'Xlib_delete_XFontStruct' plugin: 'x11'>
!

delete
    ^self primXlibXFontStructDelete.
!


name
    ^'XlibXFontStruct'

! !

!XlibXFontStruct methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXFontStruct methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXKeyboardControl
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXKeyboardControl class methodsFor: 'initialize-release'!

primXlibXKeyboardControlCreate
    <cCall: 'Xlib_new_XKeyboardControl' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXKeyboardControlCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXKeyboardControl  methodsFor: 'Xlib'!

"_________________________________________________________"
"key_click_percent primitive accessors"
primXKeyboardControlKeyClickPercent
    <cCall: 'Xlib_XKeyboardControl_key_click_percent_get' plugin: 'x11'>
!
primXKeyboardControlKeyClickPercent: val
    <cCall: 'Xlib_XKeyboardControl_key_click_percent_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XKeyboardControl_bell_percent_get' plugin: 'x11'>
!
primXKeyboardControlBellPercent: val
    <cCall: 'Xlib_XKeyboardControl_bell_percent_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XKeyboardControl_bell_pitch_get' plugin: 'x11'>
!
primXKeyboardControlBellPitch: val
    <cCall: 'Xlib_XKeyboardControl_bell_pitch_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XKeyboardControl_bell_duration_get' plugin: 'x11'>
!
primXKeyboardControlBellDuration: val
    <cCall: 'Xlib_XKeyboardControl_bell_duration_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XKeyboardControl_led_get' plugin: 'x11'>
!
primXKeyboardControlLed: val
    <cCall: 'Xlib_XKeyboardControl_led_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XKeyboardControl_led_mode_get' plugin: 'x11'>
!
primXKeyboardControlLedMode: val
    <cCall: 'Xlib_XKeyboardControl_led_mode_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XKeyboardControl_key_get' plugin: 'x11'>
!
primXKeyboardControlKey: val
    <cCall: 'Xlib_XKeyboardControl_key_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XKeyboardControl_auto_repeat_mode_get' plugin: 'x11'>
!
primXKeyboardControlAutoRepeatMode: val
    <cCall: 'Xlib_XKeyboardControl_auto_repeat_mode_set' plugin: 'x11'>
!
"........................................................"
"auto_repeat_mode accessors"
autorepeatmode
    ^self primXKeyboardControlAutoRepeatMode
!
autorepeatmode: val
    ^self primXKeyboardControlAutoRepeatMode: val
!






primXlibXKeyboardControlDelete
    <cCall: 'Xlib_delete_XKeyboardControl' plugin: 'x11'>
!

delete
    ^self primXlibXKeyboardControlDelete.
!


name
    ^'XlibXKeyboardControl'

! !

!XlibXKeyboardControl methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXKeyboardControl methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXIM
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXIM class methodsFor: 'initialize-release'!

primXlibXIMCreate
    <cCall: 'Xlib_new_XIM' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXIMCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXIM  methodsFor: 'Xlib'!



"_________________________________________________________"
"im primitive function"
primXCloseIM
    <cCall: 'Xlib_XCloseIM' plugin: 'x11'>
!

"_________________________________________________________"
"im primitive function"
primXGetIMValues
    <cCall: 'Xlib_XGetIMValues' plugin: 'x11'>
!

"_________________________________________________________"
"im primitive function"
primXSetIMValues
    <cCall: 'Xlib_XSetIMValues' plugin: 'x11'>
!

"_________________________________________________________"
"im primitive function"
primXDisplayOfIM
    <cCall: 'Xlib_XDisplayOfIM' plugin: 'x11'>
!

"_________________________________________________________"
"im primitive function"
primXLocaleOfIM
    <cCall: 'Xlib_XLocaleOfIM' plugin: 'x11'>
!

"_________________________________________________________"
"im primitive function"
primXCreateIC
    <cCall: 'Xlib_XCreateIC' plugin: 'x11'>
!




primXlibXIMDelete
    <cCall: 'Xlib_delete_XIM' plugin: 'x11'>
!

delete
    ^self primXlibXIMDelete.
!


name
    ^'XlibXIM'

! !

!XlibXIM methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXIM methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXFontSet
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXFontSet class methodsFor: 'initialize-release'!

primXlibXFontSetCreate
    <cCall: 'Xlib_new_XFontSet' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXFontSetCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXFontSet  methodsFor: 'Xlib'!



"_________________________________________________________"
"fontNameList primitive function"
primXFontsOfFontSet: arg1 fontNameList: arg4
    <cCall: 'Xlib_XFontsOfFontSet' plugin: 'x11'>
!

"_________________________________________________________"
"fontSet primitive function"
primXBaseFontNameListOfFontSet
    <cCall: 'Xlib_XBaseFontNameListOfFontSet' plugin: 'x11'>
!

"_________________________________________________________"
"fontSet primitive function"
primXLocaleOfFontSet
    <cCall: 'Xlib_XLocaleOfFontSet' plugin: 'x11'>
!

"_________________________________________________________"
"fontSet primitive function"
primXContextDependentDrawing
    <cCall: 'Xlib_XContextDependentDrawing' plugin: 'x11'>
!

"_________________________________________________________"
"fontSet primitive function"
primXDirectionalDependentDrawing
    <cCall: 'Xlib_XDirectionalDependentDrawing' plugin: 'x11'>
!

"_________________________________________________________"
"fontSet primitive function"
primXContextualDrawing
    <cCall: 'Xlib_XContextualDrawing' plugin: 'x11'>
!

"_________________________________________________________"
"fontSet primitive function"
primXExtentsOfFontSet
    <cCall: 'Xlib_XExtentsOfFontSet' plugin: 'x11'>
!

"_________________________________________________________"
"bytesText primitive function"
primXmbTextEscapement: arg1 bytesText: arg4
    <cCall: 'Xlib_XmbTextEscapement' plugin: 'x11'>
!

"_________________________________________________________"
"numWchars primitive function"
primXwcTextEscapement: arg1 numWchars: arg4
    <cCall: 'Xlib_XwcTextEscapement' plugin: 'x11'>
!

"_________________________________________________________"
"overallLogicalReturn primitive function"
primXmbTextExtents: arg1 bytesText: arg4 overallInkReturn: arg5 overallLogicalReturn: arg6
    <cCall: 'Xlib_XmbTextExtents' plugin: 'x11'>
!

"_________________________________________________________"
"overallLogicalReturn primitive function"
primXwcTextExtents: arg1 numWchars: arg4 overallInkReturn: arg5 overallLogicalReturn: arg6
    <cCall: 'Xlib_XwcTextExtents' plugin: 'x11'>
!

"_________________________________________________________"
"overallLogicalReturn primitive function"
primXmbTextPerCharExtents: arg1 bytesText: arg4 inkExtentsBuffer: arg5 logicalExtentsBuffer: arg6 bufferSize: arg7 numChars: arg8 overallInkReturn: arg9 overallLogicalReturn: arg10
    <cCall: 'Xlib_XmbTextPerCharExtents' plugin: 'x11'>
!

"_________________________________________________________"
"overallLogicalReturn primitive function"
primXwcTextPerCharExtents: arg1 numWchars: arg4 inkExtentsBuffer: arg5 logicalExtentsBuffer: arg6 bufferSize: arg7 numChars: arg8 overallInkReturn: arg9 overallLogicalReturn: arg10
    <cCall: 'Xlib_XwcTextPerCharExtents' plugin: 'x11'>
!




primXlibXFontSetDelete
    <cCall: 'Xlib_delete_XFontSet' plugin: 'x11'>
!

delete
    ^self primXlibXFontSetDelete.
!


name
    ^'XlibXFontSet'

! !

!XlibXFontSet methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXFontSet methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXIMTextString
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXIMTextString class methodsFor: 'initialize-release'!

primXlibXIMTextStringCreate
    <cCall: 'Xlib_new_XIMText_string' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXIMTextStringCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXIMTextString  methodsFor: 'Xlib'!

"_________________________________________________________"
"multi_byte primitive accessors"
primXIMTextStringMultiByte
    <cCall: 'Xlib_XIMText_string_multi_byte_get' plugin: 'x11'>
!
primXIMTextStringMultiByte: val
    <cCall: 'Xlib_XIMText_string_multi_byte_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XIMText_string_wide_char_get' plugin: 'x11'>
!
primXIMTextStringWideChar: val
    <cCall: 'Xlib_XIMText_string_wide_char_set' plugin: 'x11'>
!
"........................................................"
"wide_char accessors"
widechar
    ^self primXIMTextStringWideChar
!
widechar: val
    ^self primXIMTextStringWideChar: val
!






primXlibXIMTextStringDelete
    <cCall: 'Xlib_delete_XIMText_string' plugin: 'x11'>
!

delete
    ^self primXlibXIMTextStringDelete.
!


name
    ^'XlibXIMTextString'

! !

!XlibXIMTextString methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXIMTextString methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXImageF
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXImageF class methodsFor: 'initialize-release'!

primXlibXImageFCreate
    <cCall: 'Xlib_new_XImage_f' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXImageFCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXImageF  methodsFor: 'Xlib'!

"_________________________________________________________"
"create_image primitive accessors"
primXImageFCreateImage
    <cCall: 'Xlib_XImage_f_create_image_get' plugin: 'x11'>
!
primXImageFCreateImage: val
    <cCall: 'Xlib_XImage_f_create_image_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XImage_f_destroy_image_get' plugin: 'x11'>
!
primXImageFDestroyImage: val
    <cCall: 'Xlib_XImage_f_destroy_image_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XImage_f_get_pixel_get' plugin: 'x11'>
!
primXImageFGetPixel: val
    <cCall: 'Xlib_XImage_f_get_pixel_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XImage_f_put_pixel_get' plugin: 'x11'>
!
primXImageFPutPixel: val
    <cCall: 'Xlib_XImage_f_put_pixel_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XImage_f_sub_image_get' plugin: 'x11'>
!
primXImageFSubImage: val
    <cCall: 'Xlib_XImage_f_sub_image_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XImage_f_add_pixel_get' plugin: 'x11'>
!
primXImageFAddPixel: val
    <cCall: 'Xlib_XImage_f_add_pixel_set' plugin: 'x11'>
!
"........................................................"
"add_pixel accessors"
addpixel
    ^self primXImageFAddPixel
!
addpixel: val
    ^self primXImageFAddPixel: val
!






primXlibXImageFDelete
    <cCall: 'Xlib_delete_XImage_f' plugin: 'x11'>
!

delete
    ^self primXlibXImageFDelete.
!


name
    ^'XlibXImageF'

! !

!XlibXImageF methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXImageF methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXVisibilityEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXVisibilityEvent class methodsFor: 'initialize-release'!

primXlibXVisibilityEventCreate
    <cCall: 'Xlib_new_XVisibilityEvent' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXVisibilityEventCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXVisibilityEvent  methodsFor: 'Xlib'!

"_________________________________________________________"
"type primitive accessors"
primXVisibilityEventType
    <cCall: 'Xlib_XVisibilityEvent_type_get' plugin: 'x11'>
!
primXVisibilityEventType: val
    <cCall: 'Xlib_XVisibilityEvent_type_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XVisibilityEvent_serial_get' plugin: 'x11'>
!
primXVisibilityEventSerial: val
    <cCall: 'Xlib_XVisibilityEvent_serial_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XVisibilityEvent_send_event_get' plugin: 'x11'>
!
primXVisibilityEventSendEvent: val
    <cCall: 'Xlib_XVisibilityEvent_send_event_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XVisibilityEvent_display_get' plugin: 'x11'>
!
primXVisibilityEventDisplay: val
    <cCall: 'Xlib_XVisibilityEvent_display_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XVisibilityEvent_window_get' plugin: 'x11'>
!
primXVisibilityEventWindow: val
    <cCall: 'Xlib_XVisibilityEvent_window_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XVisibilityEvent_state_get' plugin: 'x11'>
!
primXVisibilityEventState: val
    <cCall: 'Xlib_XVisibilityEvent_state_set' plugin: 'x11'>
!
"........................................................"
"state accessors"
state
    ^self primXVisibilityEventState
!
state: val
    ^self primXVisibilityEventState: val
!






primXlibXVisibilityEventDelete
    <cCall: 'Xlib_delete_XVisibilityEvent' plugin: 'x11'>
!

delete
    ^self primXlibXVisibilityEventDelete.
!


name
    ^'XlibXVisibilityEvent'

! !

!XlibXVisibilityEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXVisibilityEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXSelectionRequestEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXSelectionRequestEvent class methodsFor: 'initialize-release'!

primXlibXSelectionRequestEventCreate
    <cCall: 'Xlib_new_XSelectionRequestEvent' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXSelectionRequestEventCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXSelectionRequestEvent  methodsFor: 'Xlib'!

"_________________________________________________________"
"type primitive accessors"
primXSelectionRequestEventType
    <cCall: 'Xlib_XSelectionRequestEvent_type_get' plugin: 'x11'>
!
primXSelectionRequestEventType: val
    <cCall: 'Xlib_XSelectionRequestEvent_type_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XSelectionRequestEvent_serial_get' plugin: 'x11'>
!
primXSelectionRequestEventSerial: val
    <cCall: 'Xlib_XSelectionRequestEvent_serial_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XSelectionRequestEvent_send_event_get' plugin: 'x11'>
!
primXSelectionRequestEventSendEvent: val
    <cCall: 'Xlib_XSelectionRequestEvent_send_event_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XSelectionRequestEvent_display_get' plugin: 'x11'>
!
primXSelectionRequestEventDisplay: val
    <cCall: 'Xlib_XSelectionRequestEvent_display_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XSelectionRequestEvent_owner_get' plugin: 'x11'>
!
primXSelectionRequestEventOwner: val
    <cCall: 'Xlib_XSelectionRequestEvent_owner_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XSelectionRequestEvent_requestor_get' plugin: 'x11'>
!
primXSelectionRequestEventRequestor: val
    <cCall: 'Xlib_XSelectionRequestEvent_requestor_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XSelectionRequestEvent_selection_get' plugin: 'x11'>
!
primXSelectionRequestEventSelection: val
    <cCall: 'Xlib_XSelectionRequestEvent_selection_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XSelectionRequestEvent_target_get' plugin: 'x11'>
!
primXSelectionRequestEventTarget: val
    <cCall: 'Xlib_XSelectionRequestEvent_target_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XSelectionRequestEvent_property_get' plugin: 'x11'>
!
primXSelectionRequestEventProperty: val
    <cCall: 'Xlib_XSelectionRequestEvent_property_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XSelectionRequestEvent_time_get' plugin: 'x11'>
!
primXSelectionRequestEventTime: val
    <cCall: 'Xlib_XSelectionRequestEvent_time_set' plugin: 'x11'>
!
"........................................................"
"time accessors"
time
    ^self primXSelectionRequestEventTime
!
time: val
    ^self primXSelectionRequestEventTime: val
!






primXlibXSelectionRequestEventDelete
    <cCall: 'Xlib_delete_XSelectionRequestEvent' plugin: 'x11'>
!

delete
    ^self primXlibXSelectionRequestEventDelete.
!


name
    ^'XlibXSelectionRequestEvent'

! !

!XlibXSelectionRequestEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXSelectionRequestEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXSelectionClearEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXSelectionClearEvent class methodsFor: 'initialize-release'!

primXlibXSelectionClearEventCreate
    <cCall: 'Xlib_new_XSelectionClearEvent' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXSelectionClearEventCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXSelectionClearEvent  methodsFor: 'Xlib'!

"_________________________________________________________"
"type primitive accessors"
primXSelectionClearEventType
    <cCall: 'Xlib_XSelectionClearEvent_type_get' plugin: 'x11'>
!
primXSelectionClearEventType: val
    <cCall: 'Xlib_XSelectionClearEvent_type_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XSelectionClearEvent_serial_get' plugin: 'x11'>
!
primXSelectionClearEventSerial: val
    <cCall: 'Xlib_XSelectionClearEvent_serial_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XSelectionClearEvent_send_event_get' plugin: 'x11'>
!
primXSelectionClearEventSendEvent: val
    <cCall: 'Xlib_XSelectionClearEvent_send_event_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XSelectionClearEvent_display_get' plugin: 'x11'>
!
primXSelectionClearEventDisplay: val
    <cCall: 'Xlib_XSelectionClearEvent_display_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XSelectionClearEvent_window_get' plugin: 'x11'>
!
primXSelectionClearEventWindow: val
    <cCall: 'Xlib_XSelectionClearEvent_window_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XSelectionClearEvent_selection_get' plugin: 'x11'>
!
primXSelectionClearEventSelection: val
    <cCall: 'Xlib_XSelectionClearEvent_selection_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XSelectionClearEvent_time_get' plugin: 'x11'>
!
primXSelectionClearEventTime: val
    <cCall: 'Xlib_XSelectionClearEvent_time_set' plugin: 'x11'>
!
"........................................................"
"time accessors"
time
    ^self primXSelectionClearEventTime
!
time: val
    ^self primXSelectionClearEventTime: val
!






primXlibXSelectionClearEventDelete
    <cCall: 'Xlib_delete_XSelectionClearEvent' plugin: 'x11'>
!

delete
    ^self primXlibXSelectionClearEventDelete.
!


name
    ^'XlibXSelectionClearEvent'

! !

!XlibXSelectionClearEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXSelectionClearEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXIMValuesList
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXIMValuesList class methodsFor: 'initialize-release'!

primXlibXIMValuesListCreate
    <cCall: 'Xlib_new_XIMValuesList' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXIMValuesListCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXIMValuesList  methodsFor: 'Xlib'!

"_________________________________________________________"
"count_values primitive accessors"
primXIMValuesListCountValues
    <cCall: 'Xlib_XIMValuesList_count_values_get' plugin: 'x11'>
!
primXIMValuesListCountValues: val
    <cCall: 'Xlib_XIMValuesList_count_values_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XIMValuesList_supported_values_get' plugin: 'x11'>
!
primXIMValuesListSupportedValues: val
    <cCall: 'Xlib_XIMValuesList_supported_values_set' plugin: 'x11'>
!
"........................................................"
"supported_values accessors"
supportedvalues
    ^self primXIMValuesListSupportedValues
!
supportedvalues: val
    ^self primXIMValuesListSupportedValues: val
!






primXlibXIMValuesListDelete
    <cCall: 'Xlib_delete_XIMValuesList' plugin: 'x11'>
!

delete
    ^self primXlibXIMValuesListDelete.
!


name
    ^'XlibXIMValuesList'

! !

!XlibXIMValuesList methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXIMValuesList methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXIMText
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXIMText class methodsFor: 'initialize-release'!

primXlibXIMTextCreate
    <cCall: 'Xlib_new_XIMText' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXIMTextCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXIMText  methodsFor: 'Xlib'!

"_________________________________________________________"
"length primitive accessors"
primXIMTextLength
    <cCall: 'Xlib_XIMText_length_get' plugin: 'x11'>
!
primXIMTextLength: val
    <cCall: 'Xlib_XIMText_length_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XIMText_feedback_get' plugin: 'x11'>
!
primXIMTextFeedback: val
    <cCall: 'Xlib_XIMText_feedback_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XIMText_encoding_is_wchar_get' plugin: 'x11'>
!
primXIMTextEncodingIsWchar: val
    <cCall: 'Xlib_XIMText_encoding_is_wchar_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XIMText_string_get' plugin: 'x11'>
!
primXIMTextString: val
    <cCall: 'Xlib_XIMText_string_set' plugin: 'x11'>
!
"........................................................"
"string accessors"
string
    ^self primXIMTextString
!
string: val
    ^self primXIMTextString: val
!






primXlibXIMTextDelete
    <cCall: 'Xlib_delete_XIMText' plugin: 'x11'>
!

delete
    ^self primXlibXIMTextDelete.
!


name
    ^'XlibXIMText'

! !

!XlibXIMText methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXIMText methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXSetWindowAttributes
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXSetWindowAttributes class methodsFor: 'initialize-release'!

primXlibXSetWindowAttributesCreate
    <cCall: 'Xlib_new_XSetWindowAttributes' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXSetWindowAttributesCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXSetWindowAttributes  methodsFor: 'Xlib'!

"_________________________________________________________"
"background_pixmap primitive accessors"
primXSetWindowAttributesBackgroundPixmap
    <cCall: 'Xlib_XSetWindowAttributes_background_pixmap_get' plugin: 'x11'>
!
primXSetWindowAttributesBackgroundPixmap: val
    <cCall: 'Xlib_XSetWindowAttributes_background_pixmap_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XSetWindowAttributes_background_pixel_get' plugin: 'x11'>
!
primXSetWindowAttributesBackgroundPixel: val
    <cCall: 'Xlib_XSetWindowAttributes_background_pixel_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XSetWindowAttributes_border_pixmap_get' plugin: 'x11'>
!
primXSetWindowAttributesBorderPixmap: val
    <cCall: 'Xlib_XSetWindowAttributes_border_pixmap_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XSetWindowAttributes_border_pixel_get' plugin: 'x11'>
!
primXSetWindowAttributesBorderPixel: val
    <cCall: 'Xlib_XSetWindowAttributes_border_pixel_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XSetWindowAttributes_bit_gravity_get' plugin: 'x11'>
!
primXSetWindowAttributesBitGravity: val
    <cCall: 'Xlib_XSetWindowAttributes_bit_gravity_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XSetWindowAttributes_win_gravity_get' plugin: 'x11'>
!
primXSetWindowAttributesWinGravity: val
    <cCall: 'Xlib_XSetWindowAttributes_win_gravity_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XSetWindowAttributes_backing_store_get' plugin: 'x11'>
!
primXSetWindowAttributesBackingStore: val
    <cCall: 'Xlib_XSetWindowAttributes_backing_store_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XSetWindowAttributes_backing_planes_get' plugin: 'x11'>
!
primXSetWindowAttributesBackingPlanes: val
    <cCall: 'Xlib_XSetWindowAttributes_backing_planes_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XSetWindowAttributes_backing_pixel_get' plugin: 'x11'>
!
primXSetWindowAttributesBackingPixel: val
    <cCall: 'Xlib_XSetWindowAttributes_backing_pixel_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XSetWindowAttributes_save_under_get' plugin: 'x11'>
!
primXSetWindowAttributesSaveUnder: val
    <cCall: 'Xlib_XSetWindowAttributes_save_under_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XSetWindowAttributes_event_mask_get' plugin: 'x11'>
!
primXSetWindowAttributesEventMask: val
    <cCall: 'Xlib_XSetWindowAttributes_event_mask_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XSetWindowAttributes_do_not_propagate_mask_get' plugin: 'x11'>
!
primXSetWindowAttributesDoNotPropagateMask: val
    <cCall: 'Xlib_XSetWindowAttributes_do_not_propagate_mask_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XSetWindowAttributes_override_redirect_get' plugin: 'x11'>
!
primXSetWindowAttributesOverrideRedirect: val
    <cCall: 'Xlib_XSetWindowAttributes_override_redirect_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XSetWindowAttributes_colormap_get' plugin: 'x11'>
!
primXSetWindowAttributesColormap: val
    <cCall: 'Xlib_XSetWindowAttributes_colormap_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XSetWindowAttributes_cursor_get' plugin: 'x11'>
!
primXSetWindowAttributesCursor: val
    <cCall: 'Xlib_XSetWindowAttributes_cursor_set' plugin: 'x11'>
!
"........................................................"
"cursor accessors"
cursor
    ^self primXSetWindowAttributesCursor
!
cursor: val
    ^self primXSetWindowAttributesCursor: val
!






primXlibXSetWindowAttributesDelete
    <cCall: 'Xlib_delete_XSetWindowAttributes' plugin: 'x11'>
!

delete
    ^self primXlibXSetWindowAttributesDelete.
!


name
    ^'XlibXSetWindowAttributes'

! !

!XlibXSetWindowAttributes methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXSetWindowAttributes methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXKeyboardState
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXKeyboardState class methodsFor: 'initialize-release'!

primXlibXKeyboardStateCreate
    <cCall: 'Xlib_new_XKeyboardState' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXKeyboardStateCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXKeyboardState  methodsFor: 'Xlib'!

"_________________________________________________________"
"key_click_percent primitive accessors"
primXKeyboardStateKeyClickPercent
    <cCall: 'Xlib_XKeyboardState_key_click_percent_get' plugin: 'x11'>
!
primXKeyboardStateKeyClickPercent: val
    <cCall: 'Xlib_XKeyboardState_key_click_percent_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XKeyboardState_bell_percent_get' plugin: 'x11'>
!
primXKeyboardStateBellPercent: val
    <cCall: 'Xlib_XKeyboardState_bell_percent_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XKeyboardState_bell_pitch_get' plugin: 'x11'>
!
primXKeyboardStateBellPitch: val
    <cCall: 'Xlib_XKeyboardState_bell_pitch_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XKeyboardState_bell_duration_get' plugin: 'x11'>
!
primXKeyboardStateBellDuration: val
    <cCall: 'Xlib_XKeyboardState_bell_duration_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XKeyboardState_led_mask_get' plugin: 'x11'>
!
primXKeyboardStateLedMask: val
    <cCall: 'Xlib_XKeyboardState_led_mask_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XKeyboardState_global_auto_repeat_get' plugin: 'x11'>
!
primXKeyboardStateGlobalAutoRepeat: val
    <cCall: 'Xlib_XKeyboardState_global_auto_repeat_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XKeyboardState_auto_repeats_get' plugin: 'x11'>
!
primXKeyboardStateAutoRepeats: val
    <cCall: 'Xlib_XKeyboardState_auto_repeats_set' plugin: 'x11'>
!
"........................................................"
"auto_repeats accessors"
autorepeats
    ^self primXKeyboardStateAutoRepeats
!
autorepeats: val
    ^self primXKeyboardStateAutoRepeats: val
!






primXlibXKeyboardStateDelete
    <cCall: 'Xlib_delete_XKeyboardState' plugin: 'x11'>
!

delete
    ^self primXlibXKeyboardStateDelete.
!


name
    ^'XlibXKeyboardState'

! !

!XlibXKeyboardState methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXKeyboardState methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXCirculateEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXCirculateEvent class methodsFor: 'initialize-release'!

primXlibXCirculateEventCreate
    <cCall: 'Xlib_new_XCirculateEvent' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXCirculateEventCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXCirculateEvent  methodsFor: 'Xlib'!

"_________________________________________________________"
"type primitive accessors"
primXCirculateEventType
    <cCall: 'Xlib_XCirculateEvent_type_get' plugin: 'x11'>
!
primXCirculateEventType: val
    <cCall: 'Xlib_XCirculateEvent_type_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XCirculateEvent_serial_get' plugin: 'x11'>
!
primXCirculateEventSerial: val
    <cCall: 'Xlib_XCirculateEvent_serial_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XCirculateEvent_send_event_get' plugin: 'x11'>
!
primXCirculateEventSendEvent: val
    <cCall: 'Xlib_XCirculateEvent_send_event_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XCirculateEvent_display_get' plugin: 'x11'>
!
primXCirculateEventDisplay: val
    <cCall: 'Xlib_XCirculateEvent_display_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XCirculateEvent_event_get' plugin: 'x11'>
!
primXCirculateEventEvent: val
    <cCall: 'Xlib_XCirculateEvent_event_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XCirculateEvent_window_get' plugin: 'x11'>
!
primXCirculateEventWindow: val
    <cCall: 'Xlib_XCirculateEvent_window_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XCirculateEvent_place_get' plugin: 'x11'>
!
primXCirculateEventPlace: val
    <cCall: 'Xlib_XCirculateEvent_place_set' plugin: 'x11'>
!
"........................................................"
"place accessors"
place
    ^self primXCirculateEventPlace
!
place: val
    ^self primXCirculateEventPlace: val
!






primXlibXCirculateEventDelete
    <cCall: 'Xlib_delete_XCirculateEvent' plugin: 'x11'>
!

delete
    ^self primXlibXCirculateEventDelete.
!


name
    ^'XlibXCirculateEvent'

! !

!XlibXCirculateEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXCirculateEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXTimeCoord
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXTimeCoord class methodsFor: 'initialize-release'!

primXlibXTimeCoordCreate
    <cCall: 'Xlib_new_XTimeCoord' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXTimeCoordCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXTimeCoord  methodsFor: 'Xlib'!

"_________________________________________________________"
"time primitive accessors"
primXTimeCoordTime
    <cCall: 'Xlib_XTimeCoord_time_get' plugin: 'x11'>
!
primXTimeCoordTime: val
    <cCall: 'Xlib_XTimeCoord_time_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XTimeCoord_x_get' plugin: 'x11'>
!
primXTimeCoordX: val
    <cCall: 'Xlib_XTimeCoord_x_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XTimeCoord_y_get' plugin: 'x11'>
!
primXTimeCoordY: val
    <cCall: 'Xlib_XTimeCoord_y_set' plugin: 'x11'>
!
"........................................................"
"y accessors"
y
    ^self primXTimeCoordY
!
y: val
    ^self primXTimeCoordY: val
!






primXlibXTimeCoordDelete
    <cCall: 'Xlib_delete_XTimeCoord' plugin: 'x11'>
!

delete
    ^self primXlibXTimeCoordDelete.
!


name
    ^'XlibXTimeCoord'

! !

!XlibXTimeCoord methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXTimeCoord methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXCreateWindowEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXCreateWindowEvent class methodsFor: 'initialize-release'!

primXlibXCreateWindowEventCreate
    <cCall: 'Xlib_new_XCreateWindowEvent' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXCreateWindowEventCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXCreateWindowEvent  methodsFor: 'Xlib'!

"_________________________________________________________"
"type primitive accessors"
primXCreateWindowEventType
    <cCall: 'Xlib_XCreateWindowEvent_type_get' plugin: 'x11'>
!
primXCreateWindowEventType: val
    <cCall: 'Xlib_XCreateWindowEvent_type_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XCreateWindowEvent_serial_get' plugin: 'x11'>
!
primXCreateWindowEventSerial: val
    <cCall: 'Xlib_XCreateWindowEvent_serial_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XCreateWindowEvent_send_event_get' plugin: 'x11'>
!
primXCreateWindowEventSendEvent: val
    <cCall: 'Xlib_XCreateWindowEvent_send_event_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XCreateWindowEvent_display_get' plugin: 'x11'>
!
primXCreateWindowEventDisplay: val
    <cCall: 'Xlib_XCreateWindowEvent_display_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XCreateWindowEvent_parent_get' plugin: 'x11'>
!
primXCreateWindowEventParent: val
    <cCall: 'Xlib_XCreateWindowEvent_parent_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XCreateWindowEvent_window_get' plugin: 'x11'>
!
primXCreateWindowEventWindow: val
    <cCall: 'Xlib_XCreateWindowEvent_window_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XCreateWindowEvent_x_get' plugin: 'x11'>
!
primXCreateWindowEventX: val
    <cCall: 'Xlib_XCreateWindowEvent_x_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XCreateWindowEvent_y_get' plugin: 'x11'>
!
primXCreateWindowEventY: val
    <cCall: 'Xlib_XCreateWindowEvent_y_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XCreateWindowEvent_width_get' plugin: 'x11'>
!
primXCreateWindowEventWidth: val
    <cCall: 'Xlib_XCreateWindowEvent_width_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XCreateWindowEvent_height_get' plugin: 'x11'>
!
primXCreateWindowEventHeight: val
    <cCall: 'Xlib_XCreateWindowEvent_height_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XCreateWindowEvent_border_width_get' plugin: 'x11'>
!
primXCreateWindowEventBorderWidth: val
    <cCall: 'Xlib_XCreateWindowEvent_border_width_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XCreateWindowEvent_override_redirect_get' plugin: 'x11'>
!
primXCreateWindowEventOverrideRedirect: val
    <cCall: 'Xlib_XCreateWindowEvent_override_redirect_set' plugin: 'x11'>
!
"........................................................"
"override_redirect accessors"
overrideredirect
    ^self primXCreateWindowEventOverrideRedirect
!
overrideredirect: val
    ^self primXCreateWindowEventOverrideRedirect: val
!






primXlibXCreateWindowEventDelete
    <cCall: 'Xlib_delete_XCreateWindowEvent' plugin: 'x11'>
!

delete
    ^self primXlibXCreateWindowEventDelete.
!


name
    ^'XlibXCreateWindowEvent'

! !

!XlibXCreateWindowEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXCreateWindowEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXSegment
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXSegment class methodsFor: 'initialize-release'!

primXlibXSegmentCreate
    <cCall: 'Xlib_new_XSegment' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXSegmentCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXSegment  methodsFor: 'Xlib'!

"_________________________________________________________"
"x1 primitive accessors"
primXSegmentX1
    <cCall: 'Xlib_XSegment_x1_get' plugin: 'x11'>
!
primXSegmentX1: val
    <cCall: 'Xlib_XSegment_x1_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XSegment_y1_get' plugin: 'x11'>
!
primXSegmentY1: val
    <cCall: 'Xlib_XSegment_y1_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XSegment_x2_get' plugin: 'x11'>
!
primXSegmentX2: val
    <cCall: 'Xlib_XSegment_x2_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XSegment_y2_get' plugin: 'x11'>
!
primXSegmentY2: val
    <cCall: 'Xlib_XSegment_y2_set' plugin: 'x11'>
!
"........................................................"
"y2 accessors"
y2
    ^self primXSegmentY2
!
y2: val
    ^self primXSegmentY2: val
!






primXlibXSegmentDelete
    <cCall: 'Xlib_delete_XSegment' plugin: 'x11'>
!

delete
    ^self primXlibXSegmentDelete.
!


name
    ^'XlibXSegment'

! !

!XlibXSegment methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXSegment methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibScreenFormat
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibScreenFormat class methodsFor: 'initialize-release'!

primXlibScreenFormatCreate
    <cCall: 'Xlib_new_ScreenFormat' plugin: 'x11'>
!

create
    ^self handle: (self primXlibScreenFormatCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibScreenFormat  methodsFor: 'Xlib'!

"_________________________________________________________"
"ext_data primitive accessors"
primScreenFormatExtData
    <cCall: 'Xlib_ScreenFormat_ext_data_get' plugin: 'x11'>
!
primScreenFormatExtData: val
    <cCall: 'Xlib_ScreenFormat_ext_data_set' plugin: 'x11'>
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
    <cCall: 'Xlib_ScreenFormat_depth_get' plugin: 'x11'>
!
primScreenFormatDepth: val
    <cCall: 'Xlib_ScreenFormat_depth_set' plugin: 'x11'>
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
    <cCall: 'Xlib_ScreenFormat_bits_per_pixel_get' plugin: 'x11'>
!
primScreenFormatBitsPerPixel: val
    <cCall: 'Xlib_ScreenFormat_bits_per_pixel_set' plugin: 'x11'>
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
    <cCall: 'Xlib_ScreenFormat_scanline_pad_get' plugin: 'x11'>
!
primScreenFormatScanlinePad: val
    <cCall: 'Xlib_ScreenFormat_scanline_pad_set' plugin: 'x11'>
!
"........................................................"
"scanline_pad accessors"
scanlinepad
    ^self primScreenFormatScanlinePad
!
scanlinepad: val
    ^self primScreenFormatScanlinePad: val
!






primXlibScreenFormatDelete
    <cCall: 'Xlib_delete_ScreenFormat' plugin: 'x11'>
!

delete
    ^self primXlibScreenFormatDelete.
!


name
    ^'XlibScreenFormat'

! !

!XlibScreenFormat methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibScreenFormat methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXServerInterpretedAddress
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXServerInterpretedAddress class methodsFor: 'initialize-release'!

primXlibXServerInterpretedAddressCreate
    <cCall: 'Xlib_new_XServerInterpretedAddress' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXServerInterpretedAddressCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXServerInterpretedAddress  methodsFor: 'Xlib'!

"_________________________________________________________"
"typelength primitive accessors"
primXServerInterpretedAddressTypelength
    <cCall: 'Xlib_XServerInterpretedAddress_typelength_get' plugin: 'x11'>
!
primXServerInterpretedAddressTypelength: val
    <cCall: 'Xlib_XServerInterpretedAddress_typelength_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XServerInterpretedAddress_valuelength_get' plugin: 'x11'>
!
primXServerInterpretedAddressValuelength: val
    <cCall: 'Xlib_XServerInterpretedAddress_valuelength_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XServerInterpretedAddress_type_get' plugin: 'x11'>
!
primXServerInterpretedAddressType: val
    <cCall: 'Xlib_XServerInterpretedAddress_type_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XServerInterpretedAddress_value_get' plugin: 'x11'>
!
primXServerInterpretedAddressValue: val
    <cCall: 'Xlib_XServerInterpretedAddress_value_set' plugin: 'x11'>
!
"........................................................"
"value accessors"
value
    ^self primXServerInterpretedAddressValue
!
value: val
    ^self primXServerInterpretedAddressValue: val
!






primXlibXServerInterpretedAddressDelete
    <cCall: 'Xlib_delete_XServerInterpretedAddress' plugin: 'x11'>
!

delete
    ^self primXlibXServerInterpretedAddressDelete.
!


name
    ^'XlibXServerInterpretedAddress'

! !

!XlibXServerInterpretedAddress methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXServerInterpretedAddress methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXConfigureEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXConfigureEvent class methodsFor: 'initialize-release'!

primXlibXConfigureEventCreate
    <cCall: 'Xlib_new_XConfigureEvent' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXConfigureEventCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXConfigureEvent  methodsFor: 'Xlib'!

"_________________________________________________________"
"type primitive accessors"
primXConfigureEventType
    <cCall: 'Xlib_XConfigureEvent_type_get' plugin: 'x11'>
!
primXConfigureEventType: val
    <cCall: 'Xlib_XConfigureEvent_type_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XConfigureEvent_serial_get' plugin: 'x11'>
!
primXConfigureEventSerial: val
    <cCall: 'Xlib_XConfigureEvent_serial_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XConfigureEvent_send_event_get' plugin: 'x11'>
!
primXConfigureEventSendEvent: val
    <cCall: 'Xlib_XConfigureEvent_send_event_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XConfigureEvent_display_get' plugin: 'x11'>
!
primXConfigureEventDisplay: val
    <cCall: 'Xlib_XConfigureEvent_display_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XConfigureEvent_event_get' plugin: 'x11'>
!
primXConfigureEventEvent: val
    <cCall: 'Xlib_XConfigureEvent_event_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XConfigureEvent_window_get' plugin: 'x11'>
!
primXConfigureEventWindow: val
    <cCall: 'Xlib_XConfigureEvent_window_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XConfigureEvent_x_get' plugin: 'x11'>
!
primXConfigureEventX: val
    <cCall: 'Xlib_XConfigureEvent_x_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XConfigureEvent_y_get' plugin: 'x11'>
!
primXConfigureEventY: val
    <cCall: 'Xlib_XConfigureEvent_y_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XConfigureEvent_width_get' plugin: 'x11'>
!
primXConfigureEventWidth: val
    <cCall: 'Xlib_XConfigureEvent_width_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XConfigureEvent_height_get' plugin: 'x11'>
!
primXConfigureEventHeight: val
    <cCall: 'Xlib_XConfigureEvent_height_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XConfigureEvent_border_width_get' plugin: 'x11'>
!
primXConfigureEventBorderWidth: val
    <cCall: 'Xlib_XConfigureEvent_border_width_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XConfigureEvent_above_get' plugin: 'x11'>
!
primXConfigureEventAbove: val
    <cCall: 'Xlib_XConfigureEvent_above_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XConfigureEvent_override_redirect_get' plugin: 'x11'>
!
primXConfigureEventOverrideRedirect: val
    <cCall: 'Xlib_XConfigureEvent_override_redirect_set' plugin: 'x11'>
!
"........................................................"
"override_redirect accessors"
overrideredirect
    ^self primXConfigureEventOverrideRedirect
!
overrideredirect: val
    ^self primXConfigureEventOverrideRedirect: val
!






primXlibXConfigureEventDelete
    <cCall: 'Xlib_delete_XConfigureEvent' plugin: 'x11'>
!

delete
    ^self primXlibXConfigureEventDelete.
!


name
    ^'XlibXConfigureEvent'

! !

!XlibXConfigureEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXConfigureEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXOMCharSetList
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXOMCharSetList class methodsFor: 'initialize-release'!

primXlibXOMCharSetListCreate
    <cCall: 'Xlib_new_XOMCharSetList' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXOMCharSetListCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXOMCharSetList  methodsFor: 'Xlib'!

"_________________________________________________________"
"charset_count primitive accessors"
primXOMCharSetListCharsetCount
    <cCall: 'Xlib_XOMCharSetList_charset_count_get' plugin: 'x11'>
!
primXOMCharSetListCharsetCount: val
    <cCall: 'Xlib_XOMCharSetList_charset_count_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XOMCharSetList_charset_list_get' plugin: 'x11'>
!
primXOMCharSetListCharsetList: val
    <cCall: 'Xlib_XOMCharSetList_charset_list_set' plugin: 'x11'>
!
"........................................................"
"charset_list accessors"
charsetlist
    ^self primXOMCharSetListCharsetList
!
charsetlist: val
    ^self primXOMCharSetListCharsetList: val
!






primXlibXOMCharSetListDelete
    <cCall: 'Xlib_delete_XOMCharSetList' plugin: 'x11'>
!

delete
    ^self primXlibXOMCharSetListDelete.
!


name
    ^'XlibXOMCharSetList'

! !

!XlibXOMCharSetList methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXOMCharSetList methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXButtonEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXButtonEvent class methodsFor: 'initialize-release'!

primXlibXButtonEventCreate
    <cCall: 'Xlib_new_XButtonEvent' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXButtonEventCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXButtonEvent  methodsFor: 'Xlib'!

"_________________________________________________________"
"type primitive accessors"
primXButtonEventType
    <cCall: 'Xlib_XButtonEvent_type_get' plugin: 'x11'>
!
primXButtonEventType: val
    <cCall: 'Xlib_XButtonEvent_type_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XButtonEvent_serial_get' plugin: 'x11'>
!
primXButtonEventSerial: val
    <cCall: 'Xlib_XButtonEvent_serial_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XButtonEvent_send_event_get' plugin: 'x11'>
!
primXButtonEventSendEvent: val
    <cCall: 'Xlib_XButtonEvent_send_event_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XButtonEvent_display_get' plugin: 'x11'>
!
primXButtonEventDisplay: val
    <cCall: 'Xlib_XButtonEvent_display_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XButtonEvent_window_get' plugin: 'x11'>
!
primXButtonEventWindow: val
    <cCall: 'Xlib_XButtonEvent_window_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XButtonEvent_root_get' plugin: 'x11'>
!
primXButtonEventRoot: val
    <cCall: 'Xlib_XButtonEvent_root_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XButtonEvent_subwindow_get' plugin: 'x11'>
!
primXButtonEventSubwindow: val
    <cCall: 'Xlib_XButtonEvent_subwindow_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XButtonEvent_time_get' plugin: 'x11'>
!
primXButtonEventTime: val
    <cCall: 'Xlib_XButtonEvent_time_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XButtonEvent_x_get' plugin: 'x11'>
!
primXButtonEventX: val
    <cCall: 'Xlib_XButtonEvent_x_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XButtonEvent_y_get' plugin: 'x11'>
!
primXButtonEventY: val
    <cCall: 'Xlib_XButtonEvent_y_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XButtonEvent_x_root_get' plugin: 'x11'>
!
primXButtonEventXRoot: val
    <cCall: 'Xlib_XButtonEvent_x_root_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XButtonEvent_y_root_get' plugin: 'x11'>
!
primXButtonEventYRoot: val
    <cCall: 'Xlib_XButtonEvent_y_root_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XButtonEvent_state_get' plugin: 'x11'>
!
primXButtonEventState: val
    <cCall: 'Xlib_XButtonEvent_state_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XButtonEvent_button_get' plugin: 'x11'>
!
primXButtonEventButton: val
    <cCall: 'Xlib_XButtonEvent_button_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XButtonEvent_same_screen_get' plugin: 'x11'>
!
primXButtonEventSameScreen: val
    <cCall: 'Xlib_XButtonEvent_same_screen_set' plugin: 'x11'>
!
"........................................................"
"same_screen accessors"
samescreen
    ^self primXButtonEventSameScreen
!
samescreen: val
    ^self primXButtonEventSameScreen: val
!






primXlibXButtonEventDelete
    <cCall: 'Xlib_delete_XButtonEvent' plugin: 'x11'>
!

delete
    ^self primXlibXButtonEventDelete.
!


name
    ^'XlibXButtonEvent'

! !

!XlibXButtonEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXButtonEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXKeymapEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXKeymapEvent class methodsFor: 'initialize-release'!

primXlibXKeymapEventCreate
    <cCall: 'Xlib_new_XKeymapEvent' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXKeymapEventCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXKeymapEvent  methodsFor: 'Xlib'!

"_________________________________________________________"
"type primitive accessors"
primXKeymapEventType
    <cCall: 'Xlib_XKeymapEvent_type_get' plugin: 'x11'>
!
primXKeymapEventType: val
    <cCall: 'Xlib_XKeymapEvent_type_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XKeymapEvent_serial_get' plugin: 'x11'>
!
primXKeymapEventSerial: val
    <cCall: 'Xlib_XKeymapEvent_serial_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XKeymapEvent_send_event_get' plugin: 'x11'>
!
primXKeymapEventSendEvent: val
    <cCall: 'Xlib_XKeymapEvent_send_event_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XKeymapEvent_display_get' plugin: 'x11'>
!
primXKeymapEventDisplay: val
    <cCall: 'Xlib_XKeymapEvent_display_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XKeymapEvent_window_get' plugin: 'x11'>
!
primXKeymapEventWindow: val
    <cCall: 'Xlib_XKeymapEvent_window_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XKeymapEvent_key_vector_get' plugin: 'x11'>
!
primXKeymapEventKeyVector: val
    <cCall: 'Xlib_XKeymapEvent_key_vector_set' plugin: 'x11'>
!
"........................................................"
"key_vector accessors"
keyvector
    ^self primXKeymapEventKeyVector
!
keyvector: val
    ^self primXKeymapEventKeyVector: val
!






primXlibXKeymapEventDelete
    <cCall: 'Xlib_delete_XKeymapEvent' plugin: 'x11'>
!

delete
    ^self primXlibXKeymapEventDelete.
!


name
    ^'XlibXKeymapEvent'

! !

!XlibXKeymapEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXKeymapEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXGraphicsExposeEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXGraphicsExposeEvent class methodsFor: 'initialize-release'!

primXlibXGraphicsExposeEventCreate
    <cCall: 'Xlib_new_XGraphicsExposeEvent' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXGraphicsExposeEventCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXGraphicsExposeEvent  methodsFor: 'Xlib'!

"_________________________________________________________"
"type primitive accessors"
primXGraphicsExposeEventType
    <cCall: 'Xlib_XGraphicsExposeEvent_type_get' plugin: 'x11'>
!
primXGraphicsExposeEventType: val
    <cCall: 'Xlib_XGraphicsExposeEvent_type_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XGraphicsExposeEvent_serial_get' plugin: 'x11'>
!
primXGraphicsExposeEventSerial: val
    <cCall: 'Xlib_XGraphicsExposeEvent_serial_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XGraphicsExposeEvent_send_event_get' plugin: 'x11'>
!
primXGraphicsExposeEventSendEvent: val
    <cCall: 'Xlib_XGraphicsExposeEvent_send_event_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XGraphicsExposeEvent_display_get' plugin: 'x11'>
!
primXGraphicsExposeEventDisplay: val
    <cCall: 'Xlib_XGraphicsExposeEvent_display_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XGraphicsExposeEvent_drawable_get' plugin: 'x11'>
!
primXGraphicsExposeEventDrawable: val
    <cCall: 'Xlib_XGraphicsExposeEvent_drawable_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XGraphicsExposeEvent_x_get' plugin: 'x11'>
!
primXGraphicsExposeEventX: val
    <cCall: 'Xlib_XGraphicsExposeEvent_x_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XGraphicsExposeEvent_y_get' plugin: 'x11'>
!
primXGraphicsExposeEventY: val
    <cCall: 'Xlib_XGraphicsExposeEvent_y_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XGraphicsExposeEvent_width_get' plugin: 'x11'>
!
primXGraphicsExposeEventWidth: val
    <cCall: 'Xlib_XGraphicsExposeEvent_width_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XGraphicsExposeEvent_height_get' plugin: 'x11'>
!
primXGraphicsExposeEventHeight: val
    <cCall: 'Xlib_XGraphicsExposeEvent_height_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XGraphicsExposeEvent_count_get' plugin: 'x11'>
!
primXGraphicsExposeEventCount: val
    <cCall: 'Xlib_XGraphicsExposeEvent_count_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XGraphicsExposeEvent_major_code_get' plugin: 'x11'>
!
primXGraphicsExposeEventMajorCode: val
    <cCall: 'Xlib_XGraphicsExposeEvent_major_code_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XGraphicsExposeEvent_minor_code_get' plugin: 'x11'>
!
primXGraphicsExposeEventMinorCode: val
    <cCall: 'Xlib_XGraphicsExposeEvent_minor_code_set' plugin: 'x11'>
!
"........................................................"
"minor_code accessors"
minorcode
    ^self primXGraphicsExposeEventMinorCode
!
minorcode: val
    ^self primXGraphicsExposeEventMinorCode: val
!






primXlibXGraphicsExposeEventDelete
    <cCall: 'Xlib_delete_XGraphicsExposeEvent' plugin: 'x11'>
!

delete
    ^self primXlibXGraphicsExposeEventDelete.
!


name
    ^'XlibXGraphicsExposeEvent'

! !

!XlibXGraphicsExposeEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXGraphicsExposeEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXFontSetExtents
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXFontSetExtents class methodsFor: 'initialize-release'!

primXlibXFontSetExtentsCreate
    <cCall: 'Xlib_new_XFontSetExtents' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXFontSetExtentsCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXFontSetExtents  methodsFor: 'Xlib'!

"_________________________________________________________"
"max_ink_extent primitive accessors"
primXFontSetExtentsMaxInkExtent
    <cCall: 'Xlib_XFontSetExtents_max_ink_extent_get' plugin: 'x11'>
!
primXFontSetExtentsMaxInkExtent: val
    <cCall: 'Xlib_XFontSetExtents_max_ink_extent_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XFontSetExtents_max_logical_extent_get' plugin: 'x11'>
!
primXFontSetExtentsMaxLogicalExtent: val
    <cCall: 'Xlib_XFontSetExtents_max_logical_extent_set' plugin: 'x11'>
!
"........................................................"
"max_logical_extent accessors"
maxlogicalextent
    ^self primXFontSetExtentsMaxLogicalExtent
!
maxlogicalextent: val
    ^self primXFontSetExtentsMaxLogicalExtent: val
!






primXlibXFontSetExtentsDelete
    <cCall: 'Xlib_delete_XFontSetExtents' plugin: 'x11'>
!

delete
    ^self primXlibXFontSetExtentsDelete.
!


name
    ^'XlibXFontSetExtents'

! !

!XlibXFontSetExtents methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXFontSetExtents methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXResizeRequestEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXResizeRequestEvent class methodsFor: 'initialize-release'!

primXlibXResizeRequestEventCreate
    <cCall: 'Xlib_new_XResizeRequestEvent' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXResizeRequestEventCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXResizeRequestEvent  methodsFor: 'Xlib'!

"_________________________________________________________"
"type primitive accessors"
primXResizeRequestEventType
    <cCall: 'Xlib_XResizeRequestEvent_type_get' plugin: 'x11'>
!
primXResizeRequestEventType: val
    <cCall: 'Xlib_XResizeRequestEvent_type_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XResizeRequestEvent_serial_get' plugin: 'x11'>
!
primXResizeRequestEventSerial: val
    <cCall: 'Xlib_XResizeRequestEvent_serial_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XResizeRequestEvent_send_event_get' plugin: 'x11'>
!
primXResizeRequestEventSendEvent: val
    <cCall: 'Xlib_XResizeRequestEvent_send_event_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XResizeRequestEvent_display_get' plugin: 'x11'>
!
primXResizeRequestEventDisplay: val
    <cCall: 'Xlib_XResizeRequestEvent_display_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XResizeRequestEvent_window_get' plugin: 'x11'>
!
primXResizeRequestEventWindow: val
    <cCall: 'Xlib_XResizeRequestEvent_window_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XResizeRequestEvent_width_get' plugin: 'x11'>
!
primXResizeRequestEventWidth: val
    <cCall: 'Xlib_XResizeRequestEvent_width_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XResizeRequestEvent_height_get' plugin: 'x11'>
!
primXResizeRequestEventHeight: val
    <cCall: 'Xlib_XResizeRequestEvent_height_set' plugin: 'x11'>
!
"........................................................"
"height accessors"
height
    ^self primXResizeRequestEventHeight
!
height: val
    ^self primXResizeRequestEventHeight: val
!






primXlibXResizeRequestEventDelete
    <cCall: 'Xlib_delete_XResizeRequestEvent' plugin: 'x11'>
!

delete
    ^self primXlibXResizeRequestEventDelete.
!


name
    ^'XlibXResizeRequestEvent'

! !

!XlibXResizeRequestEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXResizeRequestEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXIMStringConversionTextString
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXIMStringConversionTextString class methodsFor: 'initialize-release'!

primXlibXIMStringConversionTextStringCreate
    <cCall: 'Xlib_new_XIMStringConversionText_string' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXIMStringConversionTextStringCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXIMStringConversionTextString  methodsFor: 'Xlib'!

"_________________________________________________________"
"mbs primitive accessors"
primXIMStringConversionTextStringMbs
    <cCall: 'Xlib_XIMStringConversionText_string_mbs_get' plugin: 'x11'>
!
primXIMStringConversionTextStringMbs: val
    <cCall: 'Xlib_XIMStringConversionText_string_mbs_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XIMStringConversionText_string_wcs_get' plugin: 'x11'>
!
primXIMStringConversionTextStringWcs: val
    <cCall: 'Xlib_XIMStringConversionText_string_wcs_set' plugin: 'x11'>
!
"........................................................"
"wcs accessors"
wcs
    ^self primXIMStringConversionTextStringWcs
!
wcs: val
    ^self primXIMStringConversionTextStringWcs: val
!






primXlibXIMStringConversionTextStringDelete
    <cCall: 'Xlib_delete_XIMStringConversionText_string' plugin: 'x11'>
!

delete
    ^self primXlibXIMStringConversionTextStringDelete.
!


name
    ^'XlibXIMStringConversionTextString'

! !

!XlibXIMStringConversionTextString methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXIMStringConversionTextString methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXWindowAttributes
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXWindowAttributes class methodsFor: 'initialize-release'!

primXlibXWindowAttributesCreate
    <cCall: 'Xlib_new_XWindowAttributes' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXWindowAttributesCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXWindowAttributes  methodsFor: 'Xlib'!

"_________________________________________________________"
"x primitive accessors"
primXWindowAttributesX
    <cCall: 'Xlib_XWindowAttributes_x_get' plugin: 'x11'>
!
primXWindowAttributesX: val
    <cCall: 'Xlib_XWindowAttributes_x_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XWindowAttributes_y_get' plugin: 'x11'>
!
primXWindowAttributesY: val
    <cCall: 'Xlib_XWindowAttributes_y_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XWindowAttributes_width_get' plugin: 'x11'>
!
primXWindowAttributesWidth: val
    <cCall: 'Xlib_XWindowAttributes_width_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XWindowAttributes_height_get' plugin: 'x11'>
!
primXWindowAttributesHeight: val
    <cCall: 'Xlib_XWindowAttributes_height_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XWindowAttributes_border_width_get' plugin: 'x11'>
!
primXWindowAttributesBorderWidth: val
    <cCall: 'Xlib_XWindowAttributes_border_width_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XWindowAttributes_depth_get' plugin: 'x11'>
!
primXWindowAttributesDepth: val
    <cCall: 'Xlib_XWindowAttributes_depth_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XWindowAttributes_visual_get' plugin: 'x11'>
!
primXWindowAttributesVisual: val
    <cCall: 'Xlib_XWindowAttributes_visual_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XWindowAttributes_root_get' plugin: 'x11'>
!
primXWindowAttributesRoot: val
    <cCall: 'Xlib_XWindowAttributes_root_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XWindowAttributes_class_get' plugin: 'x11'>
!
primXWindowAttributesClass: val
    <cCall: 'Xlib_XWindowAttributes_class_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XWindowAttributes_bit_gravity_get' plugin: 'x11'>
!
primXWindowAttributesBitGravity: val
    <cCall: 'Xlib_XWindowAttributes_bit_gravity_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XWindowAttributes_win_gravity_get' plugin: 'x11'>
!
primXWindowAttributesWinGravity: val
    <cCall: 'Xlib_XWindowAttributes_win_gravity_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XWindowAttributes_backing_store_get' plugin: 'x11'>
!
primXWindowAttributesBackingStore: val
    <cCall: 'Xlib_XWindowAttributes_backing_store_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XWindowAttributes_backing_planes_get' plugin: 'x11'>
!
primXWindowAttributesBackingPlanes: val
    <cCall: 'Xlib_XWindowAttributes_backing_planes_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XWindowAttributes_backing_pixel_get' plugin: 'x11'>
!
primXWindowAttributesBackingPixel: val
    <cCall: 'Xlib_XWindowAttributes_backing_pixel_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XWindowAttributes_save_under_get' plugin: 'x11'>
!
primXWindowAttributesSaveUnder: val
    <cCall: 'Xlib_XWindowAttributes_save_under_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XWindowAttributes_colormap_get' plugin: 'x11'>
!
primXWindowAttributesColormap: val
    <cCall: 'Xlib_XWindowAttributes_colormap_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XWindowAttributes_map_installed_get' plugin: 'x11'>
!
primXWindowAttributesMapInstalled: val
    <cCall: 'Xlib_XWindowAttributes_map_installed_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XWindowAttributes_map_state_get' plugin: 'x11'>
!
primXWindowAttributesMapState: val
    <cCall: 'Xlib_XWindowAttributes_map_state_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XWindowAttributes_all_event_masks_get' plugin: 'x11'>
!
primXWindowAttributesAllEventMasks: val
    <cCall: 'Xlib_XWindowAttributes_all_event_masks_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XWindowAttributes_your_event_mask_get' plugin: 'x11'>
!
primXWindowAttributesYourEventMask: val
    <cCall: 'Xlib_XWindowAttributes_your_event_mask_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XWindowAttributes_do_not_propagate_mask_get' plugin: 'x11'>
!
primXWindowAttributesDoNotPropagateMask: val
    <cCall: 'Xlib_XWindowAttributes_do_not_propagate_mask_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XWindowAttributes_override_redirect_get' plugin: 'x11'>
!
primXWindowAttributesOverrideRedirect: val
    <cCall: 'Xlib_XWindowAttributes_override_redirect_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XWindowAttributes_screen_get' plugin: 'x11'>
!
primXWindowAttributesScreen: val
    <cCall: 'Xlib_XWindowAttributes_screen_set' plugin: 'x11'>
!
"........................................................"
"screen accessors"
screen
    ^self primXWindowAttributesScreen
!
screen: val
    ^self primXWindowAttributesScreen: val
!






primXlibXWindowAttributesDelete
    <cCall: 'Xlib_delete_XWindowAttributes' plugin: 'x11'>
!

delete
    ^self primXlibXWindowAttributesDelete.
!


name
    ^'XlibXWindowAttributes'

! !

!XlibXWindowAttributes methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXWindowAttributes methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXMappingEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXMappingEvent class methodsFor: 'initialize-release'!

primXlibXMappingEventCreate
    <cCall: 'Xlib_new_XMappingEvent' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXMappingEventCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXMappingEvent  methodsFor: 'Xlib'!

"_________________________________________________________"
"type primitive accessors"
primXMappingEventType
    <cCall: 'Xlib_XMappingEvent_type_get' plugin: 'x11'>
!
primXMappingEventType: val
    <cCall: 'Xlib_XMappingEvent_type_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XMappingEvent_serial_get' plugin: 'x11'>
!
primXMappingEventSerial: val
    <cCall: 'Xlib_XMappingEvent_serial_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XMappingEvent_send_event_get' plugin: 'x11'>
!
primXMappingEventSendEvent: val
    <cCall: 'Xlib_XMappingEvent_send_event_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XMappingEvent_display_get' plugin: 'x11'>
!
primXMappingEventDisplay: val
    <cCall: 'Xlib_XMappingEvent_display_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XMappingEvent_window_get' plugin: 'x11'>
!
primXMappingEventWindow: val
    <cCall: 'Xlib_XMappingEvent_window_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XMappingEvent_request_get' plugin: 'x11'>
!
primXMappingEventRequest: val
    <cCall: 'Xlib_XMappingEvent_request_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XMappingEvent_first_keycode_get' plugin: 'x11'>
!
primXMappingEventFirstKeycode: val
    <cCall: 'Xlib_XMappingEvent_first_keycode_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XMappingEvent_count_get' plugin: 'x11'>
!
primXMappingEventCount: val
    <cCall: 'Xlib_XMappingEvent_count_set' plugin: 'x11'>
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
"eventMap primitive function"
primXRefreshKeyboardMapping
    <cCall: 'Xlib_XRefreshKeyboardMapping' plugin: 'x11'>
!




primXlibXMappingEventDelete
    <cCall: 'Xlib_delete_XMappingEvent' plugin: 'x11'>
!

delete
    ^self primXlibXMappingEventDelete.
!


name
    ^'XlibXMappingEvent'

! !

!XlibXMappingEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXMappingEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXIMStringConversionCallbackStruct
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXIMStringConversionCallbackStruct class methodsFor: 'initialize-release'!

primXlibXIMStringConversionCallbackStructCreate
    <cCall: 'Xlib_new_XIMStringConversionCallbackStruct' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXIMStringConversionCallbackStructCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXIMStringConversionCallbackStruct  methodsFor: 'Xlib'!

"_________________________________________________________"
"position primitive accessors"
primXIMStringConversionCallbackStructPosition
    <cCall: 'Xlib_XIMStringConversionCallbackStruct_position_get' plugin: 'x11'>
!
primXIMStringConversionCallbackStructPosition: val
    <cCall: 'Xlib_XIMStringConversionCallbackStruct_position_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XIMStringConversionCallbackStruct_direction_get' plugin: 'x11'>
!
primXIMStringConversionCallbackStructDirection: val
    <cCall: 'Xlib_XIMStringConversionCallbackStruct_direction_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XIMStringConversionCallbackStruct_operation_get' plugin: 'x11'>
!
primXIMStringConversionCallbackStructOperation: val
    <cCall: 'Xlib_XIMStringConversionCallbackStruct_operation_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XIMStringConversionCallbackStruct_factor_get' plugin: 'x11'>
!
primXIMStringConversionCallbackStructFactor: val
    <cCall: 'Xlib_XIMStringConversionCallbackStruct_factor_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XIMStringConversionCallbackStruct_text_get' plugin: 'x11'>
!
primXIMStringConversionCallbackStructText: val
    <cCall: 'Xlib_XIMStringConversionCallbackStruct_text_set' plugin: 'x11'>
!
"........................................................"
"text accessors"
text
    ^self primXIMStringConversionCallbackStructText
!
text: val
    ^self primXIMStringConversionCallbackStructText: val
!






primXlibXIMStringConversionCallbackStructDelete
    <cCall: 'Xlib_delete_XIMStringConversionCallbackStruct' plugin: 'x11'>
!

delete
    ^self primXlibXIMStringConversionCallbackStructDelete.
!


name
    ^'XlibXIMStringConversionCallbackStruct'

! !

!XlibXIMStringConversionCallbackStruct methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXIMStringConversionCallbackStruct methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXOMOrientation
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXOMOrientation class methodsFor: 'initialize-release'!

primXlibXOMOrientationCreate
    <cCall: 'Xlib_new_XOMOrientation' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXOMOrientationCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXOMOrientation  methodsFor: 'Xlib'!

"_________________________________________________________"
"num_orientation primitive accessors"
primXOMOrientationNumOrientation
    <cCall: 'Xlib_XOMOrientation_num_orientation_get' plugin: 'x11'>
!
primXOMOrientationNumOrientation: val
    <cCall: 'Xlib_XOMOrientation_num_orientation_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XOMOrientation_orientation_get' plugin: 'x11'>
!
primXOMOrientationOrientation: val
    <cCall: 'Xlib_XOMOrientation_orientation_set' plugin: 'x11'>
!
"........................................................"
"orientation accessors"
orientation
    ^self primXOMOrientationOrientation
!
orientation: val
    ^self primXOMOrientationOrientation: val
!






primXlibXOMOrientationDelete
    <cCall: 'Xlib_delete_XOMOrientation' plugin: 'x11'>
!

delete
    ^self primXlibXOMOrientationDelete.
!


name
    ^'XlibXOMOrientation'

! !

!XlibXOMOrientation methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXOMOrientation methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXWindowChanges
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXWindowChanges class methodsFor: 'initialize-release'!

primXlibXWindowChangesCreate
    <cCall: 'Xlib_new_XWindowChanges' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXWindowChangesCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXWindowChanges  methodsFor: 'Xlib'!

"_________________________________________________________"
"x primitive accessors"
primXWindowChangesX
    <cCall: 'Xlib_XWindowChanges_x_get' plugin: 'x11'>
!
primXWindowChangesX: val
    <cCall: 'Xlib_XWindowChanges_x_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XWindowChanges_y_get' plugin: 'x11'>
!
primXWindowChangesY: val
    <cCall: 'Xlib_XWindowChanges_y_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XWindowChanges_width_get' plugin: 'x11'>
!
primXWindowChangesWidth: val
    <cCall: 'Xlib_XWindowChanges_width_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XWindowChanges_height_get' plugin: 'x11'>
!
primXWindowChangesHeight: val
    <cCall: 'Xlib_XWindowChanges_height_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XWindowChanges_border_width_get' plugin: 'x11'>
!
primXWindowChangesBorderWidth: val
    <cCall: 'Xlib_XWindowChanges_border_width_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XWindowChanges_sibling_get' plugin: 'x11'>
!
primXWindowChangesSibling: val
    <cCall: 'Xlib_XWindowChanges_sibling_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XWindowChanges_stack_mode_get' plugin: 'x11'>
!
primXWindowChangesStackMode: val
    <cCall: 'Xlib_XWindowChanges_stack_mode_set' plugin: 'x11'>
!
"........................................................"
"stack_mode accessors"
stackmode
    ^self primXWindowChangesStackMode
!
stackmode: val
    ^self primXWindowChangesStackMode: val
!






primXlibXWindowChangesDelete
    <cCall: 'Xlib_delete_XWindowChanges' plugin: 'x11'>
!

delete
    ^self primXlibXWindowChangesDelete.
!


name
    ^'XlibXWindowChanges'

! !

!XlibXWindowChanges methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXWindowChanges methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXClientMessageEventData
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXClientMessageEventData class methodsFor: 'initialize-release'!

primXlibXClientMessageEventDataCreate
    <cCall: 'Xlib_new_XClientMessageEvent_data' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXClientMessageEventDataCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXClientMessageEventData  methodsFor: 'Xlib'!

"_________________________________________________________"
"b primitive accessors"
primXClientMessageEventDataB
    <cCall: 'Xlib_XClientMessageEvent_data_b_get' plugin: 'x11'>
!
primXClientMessageEventDataB: val
    <cCall: 'Xlib_XClientMessageEvent_data_b_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XClientMessageEvent_data_s_get' plugin: 'x11'>
!
primXClientMessageEventDataS: val
    <cCall: 'Xlib_XClientMessageEvent_data_s_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XClientMessageEvent_data_l_get' plugin: 'x11'>
!
primXClientMessageEventDataL: val
    <cCall: 'Xlib_XClientMessageEvent_data_l_set' plugin: 'x11'>
!
"........................................................"
"l accessors"
l
    ^self primXClientMessageEventDataL
!
l: val
    ^self primXClientMessageEventDataL: val
!






primXlibXClientMessageEventDataDelete
    <cCall: 'Xlib_delete_XClientMessageEvent_data' plugin: 'x11'>
!

delete
    ^self primXlibXClientMessageEventDataDelete.
!


name
    ^'XlibXClientMessageEventData'

! !

!XlibXClientMessageEventData methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXClientMessageEventData methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXExtCodes
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXExtCodes class methodsFor: 'initialize-release'!

primXlibXExtCodesCreate
    <cCall: 'Xlib_new_XExtCodes' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXExtCodesCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXExtCodes  methodsFor: 'Xlib'!

"_________________________________________________________"
"extension primitive accessors"
primXExtCodesExtension
    <cCall: 'Xlib_XExtCodes_extension_get' plugin: 'x11'>
!
primXExtCodesExtension: val
    <cCall: 'Xlib_XExtCodes_extension_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XExtCodes_major_opcode_get' plugin: 'x11'>
!
primXExtCodesMajorOpcode: val
    <cCall: 'Xlib_XExtCodes_major_opcode_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XExtCodes_first_event_get' plugin: 'x11'>
!
primXExtCodesFirstEvent: val
    <cCall: 'Xlib_XExtCodes_first_event_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XExtCodes_first_error_get' plugin: 'x11'>
!
primXExtCodesFirstError: val
    <cCall: 'Xlib_XExtCodes_first_error_set' plugin: 'x11'>
!
"........................................................"
"first_error accessors"
firsterror
    ^self primXExtCodesFirstError
!
firsterror: val
    ^self primXExtCodesFirstError: val
!






primXlibXExtCodesDelete
    <cCall: 'Xlib_delete_XExtCodes' plugin: 'x11'>
!

delete
    ^self primXlibXExtCodesDelete.
!


name
    ^'XlibXExtCodes'

! !

!XlibXExtCodes methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXExtCodes methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXGCValues
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXGCValues class methodsFor: 'initialize-release'!

primXlibXGCValuesCreate
    <cCall: 'Xlib_new_XGCValues' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXGCValuesCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXGCValues  methodsFor: 'Xlib'!

"_________________________________________________________"
"function primitive accessors"
primXGCValuesFunction
    <cCall: 'Xlib_XGCValues_function_get' plugin: 'x11'>
!
primXGCValuesFunction: val
    <cCall: 'Xlib_XGCValues_function_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XGCValues_plane_mask_get' plugin: 'x11'>
!
primXGCValuesPlaneMask: val
    <cCall: 'Xlib_XGCValues_plane_mask_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XGCValues_foreground_get' plugin: 'x11'>
!
primXGCValuesForeground: val
    <cCall: 'Xlib_XGCValues_foreground_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XGCValues_background_get' plugin: 'x11'>
!
primXGCValuesBackground: val
    <cCall: 'Xlib_XGCValues_background_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XGCValues_line_width_get' plugin: 'x11'>
!
primXGCValuesLineWidth: val
    <cCall: 'Xlib_XGCValues_line_width_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XGCValues_line_style_get' plugin: 'x11'>
!
primXGCValuesLineStyle: val
    <cCall: 'Xlib_XGCValues_line_style_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XGCValues_cap_style_get' plugin: 'x11'>
!
primXGCValuesCapStyle: val
    <cCall: 'Xlib_XGCValues_cap_style_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XGCValues_join_style_get' plugin: 'x11'>
!
primXGCValuesJoinStyle: val
    <cCall: 'Xlib_XGCValues_join_style_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XGCValues_fill_style_get' plugin: 'x11'>
!
primXGCValuesFillStyle: val
    <cCall: 'Xlib_XGCValues_fill_style_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XGCValues_fill_rule_get' plugin: 'x11'>
!
primXGCValuesFillRule: val
    <cCall: 'Xlib_XGCValues_fill_rule_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XGCValues_arc_mode_get' plugin: 'x11'>
!
primXGCValuesArcMode: val
    <cCall: 'Xlib_XGCValues_arc_mode_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XGCValues_tile_get' plugin: 'x11'>
!
primXGCValuesTile: val
    <cCall: 'Xlib_XGCValues_tile_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XGCValues_stipple_get' plugin: 'x11'>
!
primXGCValuesStipple: val
    <cCall: 'Xlib_XGCValues_stipple_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XGCValues_ts_x_origin_get' plugin: 'x11'>
!
primXGCValuesTsXOrigin: val
    <cCall: 'Xlib_XGCValues_ts_x_origin_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XGCValues_ts_y_origin_get' plugin: 'x11'>
!
primXGCValuesTsYOrigin: val
    <cCall: 'Xlib_XGCValues_ts_y_origin_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XGCValues_font_get' plugin: 'x11'>
!
primXGCValuesFont: val
    <cCall: 'Xlib_XGCValues_font_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XGCValues_subwindow_mode_get' plugin: 'x11'>
!
primXGCValuesSubwindowMode: val
    <cCall: 'Xlib_XGCValues_subwindow_mode_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XGCValues_graphics_exposures_get' plugin: 'x11'>
!
primXGCValuesGraphicsExposures: val
    <cCall: 'Xlib_XGCValues_graphics_exposures_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XGCValues_clip_x_origin_get' plugin: 'x11'>
!
primXGCValuesClipXOrigin: val
    <cCall: 'Xlib_XGCValues_clip_x_origin_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XGCValues_clip_y_origin_get' plugin: 'x11'>
!
primXGCValuesClipYOrigin: val
    <cCall: 'Xlib_XGCValues_clip_y_origin_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XGCValues_clip_mask_get' plugin: 'x11'>
!
primXGCValuesClipMask: val
    <cCall: 'Xlib_XGCValues_clip_mask_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XGCValues_dash_offset_get' plugin: 'x11'>
!
primXGCValuesDashOffset: val
    <cCall: 'Xlib_XGCValues_dash_offset_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XGCValues_dashes_get' plugin: 'x11'>
!
primXGCValuesDashes: val
    <cCall: 'Xlib_XGCValues_dashes_set' plugin: 'x11'>
!
"........................................................"
"dashes accessors"
dashes
    ^self primXGCValuesDashes
!
dashes: val
    ^self primXGCValuesDashes: val
!






primXlibXGCValuesDelete
    <cCall: 'Xlib_delete_XGCValues' plugin: 'x11'>
!

delete
    ^self primXlibXGCValuesDelete.
!


name
    ^'XlibXGCValues'

! !

!XlibXGCValues methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXGCValues methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXOC
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXOC class methodsFor: 'initialize-release'!

primXlibXOCCreate
    <cCall: 'Xlib_new_XOC' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXOCCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXOC  methodsFor: 'Xlib'!



"_________________________________________________________"
"oc primitive function"
primXDestroyOC
    <cCall: 'Xlib_XDestroyOC' plugin: 'x11'>
!

"_________________________________________________________"
"oc primitive function"
primXOMOfOC
    <cCall: 'Xlib_XOMOfOC' plugin: 'x11'>
!

"_________________________________________________________"
"oc primitive function"
primXSetOCValues
    <cCall: 'Xlib_XSetOCValues' plugin: 'x11'>
!

"_________________________________________________________"
"oc primitive function"
primXGetOCValues
    <cCall: 'Xlib_XGetOCValues' plugin: 'x11'>
!




primXlibXOCDelete
    <cCall: 'Xlib_delete_XOC' plugin: 'x11'>
!

delete
    ^self primXlibXOCDelete.
!


name
    ^'XlibXOC'

! !

!XlibXOC methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXOC methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXFocusChangeEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXFocusChangeEvent class methodsFor: 'initialize-release'!

primXlibXFocusChangeEventCreate
    <cCall: 'Xlib_new_XFocusChangeEvent' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXFocusChangeEventCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXFocusChangeEvent  methodsFor: 'Xlib'!

"_________________________________________________________"
"type primitive accessors"
primXFocusChangeEventType
    <cCall: 'Xlib_XFocusChangeEvent_type_get' plugin: 'x11'>
!
primXFocusChangeEventType: val
    <cCall: 'Xlib_XFocusChangeEvent_type_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XFocusChangeEvent_serial_get' plugin: 'x11'>
!
primXFocusChangeEventSerial: val
    <cCall: 'Xlib_XFocusChangeEvent_serial_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XFocusChangeEvent_send_event_get' plugin: 'x11'>
!
primXFocusChangeEventSendEvent: val
    <cCall: 'Xlib_XFocusChangeEvent_send_event_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XFocusChangeEvent_display_get' plugin: 'x11'>
!
primXFocusChangeEventDisplay: val
    <cCall: 'Xlib_XFocusChangeEvent_display_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XFocusChangeEvent_window_get' plugin: 'x11'>
!
primXFocusChangeEventWindow: val
    <cCall: 'Xlib_XFocusChangeEvent_window_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XFocusChangeEvent_mode_get' plugin: 'x11'>
!
primXFocusChangeEventMode: val
    <cCall: 'Xlib_XFocusChangeEvent_mode_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XFocusChangeEvent_detail_get' plugin: 'x11'>
!
primXFocusChangeEventDetail: val
    <cCall: 'Xlib_XFocusChangeEvent_detail_set' plugin: 'x11'>
!
"........................................................"
"detail accessors"
detail
    ^self primXFocusChangeEventDetail
!
detail: val
    ^self primXFocusChangeEventDetail: val
!






primXlibXFocusChangeEventDelete
    <cCall: 'Xlib_delete_XFocusChangeEvent' plugin: 'x11'>
!

delete
    ^self primXlibXFocusChangeEventDelete.
!


name
    ^'XlibXFocusChangeEvent'

! !

!XlibXFocusChangeEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXFocusChangeEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXConfigureRequestEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXConfigureRequestEvent class methodsFor: 'initialize-release'!

primXlibXConfigureRequestEventCreate
    <cCall: 'Xlib_new_XConfigureRequestEvent' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXConfigureRequestEventCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXConfigureRequestEvent  methodsFor: 'Xlib'!

"_________________________________________________________"
"type primitive accessors"
primXConfigureRequestEventType
    <cCall: 'Xlib_XConfigureRequestEvent_type_get' plugin: 'x11'>
!
primXConfigureRequestEventType: val
    <cCall: 'Xlib_XConfigureRequestEvent_type_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XConfigureRequestEvent_serial_get' plugin: 'x11'>
!
primXConfigureRequestEventSerial: val
    <cCall: 'Xlib_XConfigureRequestEvent_serial_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XConfigureRequestEvent_send_event_get' plugin: 'x11'>
!
primXConfigureRequestEventSendEvent: val
    <cCall: 'Xlib_XConfigureRequestEvent_send_event_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XConfigureRequestEvent_display_get' plugin: 'x11'>
!
primXConfigureRequestEventDisplay: val
    <cCall: 'Xlib_XConfigureRequestEvent_display_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XConfigureRequestEvent_parent_get' plugin: 'x11'>
!
primXConfigureRequestEventParent: val
    <cCall: 'Xlib_XConfigureRequestEvent_parent_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XConfigureRequestEvent_window_get' plugin: 'x11'>
!
primXConfigureRequestEventWindow: val
    <cCall: 'Xlib_XConfigureRequestEvent_window_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XConfigureRequestEvent_x_get' plugin: 'x11'>
!
primXConfigureRequestEventX: val
    <cCall: 'Xlib_XConfigureRequestEvent_x_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XConfigureRequestEvent_y_get' plugin: 'x11'>
!
primXConfigureRequestEventY: val
    <cCall: 'Xlib_XConfigureRequestEvent_y_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XConfigureRequestEvent_width_get' plugin: 'x11'>
!
primXConfigureRequestEventWidth: val
    <cCall: 'Xlib_XConfigureRequestEvent_width_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XConfigureRequestEvent_height_get' plugin: 'x11'>
!
primXConfigureRequestEventHeight: val
    <cCall: 'Xlib_XConfigureRequestEvent_height_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XConfigureRequestEvent_border_width_get' plugin: 'x11'>
!
primXConfigureRequestEventBorderWidth: val
    <cCall: 'Xlib_XConfigureRequestEvent_border_width_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XConfigureRequestEvent_above_get' plugin: 'x11'>
!
primXConfigureRequestEventAbove: val
    <cCall: 'Xlib_XConfigureRequestEvent_above_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XConfigureRequestEvent_detail_get' plugin: 'x11'>
!
primXConfigureRequestEventDetail: val
    <cCall: 'Xlib_XConfigureRequestEvent_detail_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XConfigureRequestEvent_value_mask_get' plugin: 'x11'>
!
primXConfigureRequestEventValueMask: val
    <cCall: 'Xlib_XConfigureRequestEvent_value_mask_set' plugin: 'x11'>
!
"........................................................"
"value_mask accessors"
valuemask
    ^self primXConfigureRequestEventValueMask
!
valuemask: val
    ^self primXConfigureRequestEventValueMask: val
!






primXlibXConfigureRequestEventDelete
    <cCall: 'Xlib_delete_XConfigureRequestEvent' plugin: 'x11'>
!

delete
    ^self primXlibXConfigureRequestEventDelete.
!


name
    ^'XlibXConfigureRequestEvent'

! !

!XlibXConfigureRequestEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXConfigureRequestEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXClientMessageEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXClientMessageEvent class methodsFor: 'initialize-release'!

primXlibXClientMessageEventCreate
    <cCall: 'Xlib_new_XClientMessageEvent' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXClientMessageEventCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXClientMessageEvent  methodsFor: 'Xlib'!

"_________________________________________________________"
"type primitive accessors"
primXClientMessageEventType
    <cCall: 'Xlib_XClientMessageEvent_type_get' plugin: 'x11'>
!
primXClientMessageEventType: val
    <cCall: 'Xlib_XClientMessageEvent_type_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XClientMessageEvent_serial_get' plugin: 'x11'>
!
primXClientMessageEventSerial: val
    <cCall: 'Xlib_XClientMessageEvent_serial_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XClientMessageEvent_send_event_get' plugin: 'x11'>
!
primXClientMessageEventSendEvent: val
    <cCall: 'Xlib_XClientMessageEvent_send_event_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XClientMessageEvent_display_get' plugin: 'x11'>
!
primXClientMessageEventDisplay: val
    <cCall: 'Xlib_XClientMessageEvent_display_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XClientMessageEvent_window_get' plugin: 'x11'>
!
primXClientMessageEventWindow: val
    <cCall: 'Xlib_XClientMessageEvent_window_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XClientMessageEvent_message_type_get' plugin: 'x11'>
!
primXClientMessageEventMessageType: val
    <cCall: 'Xlib_XClientMessageEvent_message_type_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XClientMessageEvent_format_get' plugin: 'x11'>
!
primXClientMessageEventFormat: val
    <cCall: 'Xlib_XClientMessageEvent_format_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XClientMessageEvent_data_get' plugin: 'x11'>
!
primXClientMessageEventData: val
    <cCall: 'Xlib_XClientMessageEvent_data_set' plugin: 'x11'>
!
"........................................................"
"data accessors"
data
    ^self primXClientMessageEventData
!
data: val
    ^self primXClientMessageEventData: val
!






primXlibXClientMessageEventDelete
    <cCall: 'Xlib_delete_XClientMessageEvent' plugin: 'x11'>
!

delete
    ^self primXlibXClientMessageEventDelete.
!


name
    ^'XlibXClientMessageEvent'

! !

!XlibXClientMessageEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXClientMessageEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXwcTextItem
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXwcTextItem class methodsFor: 'initialize-release'!

primXlibXwcTextItemCreate
    <cCall: 'Xlib_new_XwcTextItem' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXwcTextItemCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXwcTextItem  methodsFor: 'Xlib'!

"_________________________________________________________"
"chars primitive accessors"
primXwcTextItemChars
    <cCall: 'Xlib_XwcTextItem_chars_get' plugin: 'x11'>
!
primXwcTextItemChars: val
    <cCall: 'Xlib_XwcTextItem_chars_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XwcTextItem_nchars_get' plugin: 'x11'>
!
primXwcTextItemNchars: val
    <cCall: 'Xlib_XwcTextItem_nchars_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XwcTextItem_delta_get' plugin: 'x11'>
!
primXwcTextItemDelta: val
    <cCall: 'Xlib_XwcTextItem_delta_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XwcTextItem_font_set_get' plugin: 'x11'>
!
primXwcTextItemFontSet: val
    <cCall: 'Xlib_XwcTextItem_font_set_set' plugin: 'x11'>
!
"........................................................"
"font_set accessors"
fontset
    ^self primXwcTextItemFontSet
!
fontset: val
    ^self primXwcTextItemFontSet: val
!






primXlibXwcTextItemDelete
    <cCall: 'Xlib_delete_XwcTextItem' plugin: 'x11'>
!

delete
    ^self primXlibXwcTextItemDelete.
!


name
    ^'XlibXwcTextItem'

! !

!XlibXwcTextItem methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXwcTextItem methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXModifierKeymap
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXModifierKeymap class methodsFor: 'initialize-release'!

primXlibXModifierKeymapCreate
    <cCall: 'Xlib_new_XModifierKeymap' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXModifierKeymapCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXModifierKeymap  methodsFor: 'Xlib'!

"_________________________________________________________"
"max_keypermod primitive accessors"
primXModifierKeymapMaxKeypermod
    <cCall: 'Xlib_XModifierKeymap_max_keypermod_get' plugin: 'x11'>
!
primXModifierKeymapMaxKeypermod: val
    <cCall: 'Xlib_XModifierKeymap_max_keypermod_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XModifierKeymap_modifiermap_get' plugin: 'x11'>
!
primXModifierKeymapModifiermap: val
    <cCall: 'Xlib_XModifierKeymap_modifiermap_set' plugin: 'x11'>
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
"modifier primitive function"
primXDeleteModifiermapEntry: arg1 keycodeEntry: arg4 modifier: arg5
    <cCall: 'Xlib_XDeleteModifiermapEntry' plugin: 'x11'>
!

"_________________________________________________________"
"modifier primitive function"
primXInsertModifiermapEntry: arg1 keycodeEntry: arg4 modifier: arg5
    <cCall: 'Xlib_XInsertModifiermapEntry' plugin: 'x11'>
!

"_________________________________________________________"
"modmap primitive function"
primXFreeModifiermap
    <cCall: 'Xlib_XFreeModifiermap' plugin: 'x11'>
!




primXlibXModifierKeymapDelete
    <cCall: 'Xlib_delete_XModifierKeymap' plugin: 'x11'>
!

delete
    ^self primXlibXModifierKeymapDelete.
!


name
    ^'XlibXModifierKeymap'

! !

!XlibXModifierKeymap methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXModifierKeymap methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXColormapEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXColormapEvent class methodsFor: 'initialize-release'!

primXlibXColormapEventCreate
    <cCall: 'Xlib_new_XColormapEvent' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXColormapEventCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXColormapEvent  methodsFor: 'Xlib'!

"_________________________________________________________"
"type primitive accessors"
primXColormapEventType
    <cCall: 'Xlib_XColormapEvent_type_get' plugin: 'x11'>
!
primXColormapEventType: val
    <cCall: 'Xlib_XColormapEvent_type_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XColormapEvent_serial_get' plugin: 'x11'>
!
primXColormapEventSerial: val
    <cCall: 'Xlib_XColormapEvent_serial_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XColormapEvent_send_event_get' plugin: 'x11'>
!
primXColormapEventSendEvent: val
    <cCall: 'Xlib_XColormapEvent_send_event_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XColormapEvent_display_get' plugin: 'x11'>
!
primXColormapEventDisplay: val
    <cCall: 'Xlib_XColormapEvent_display_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XColormapEvent_window_get' plugin: 'x11'>
!
primXColormapEventWindow: val
    <cCall: 'Xlib_XColormapEvent_window_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XColormapEvent_colormap_get' plugin: 'x11'>
!
primXColormapEventColormap: val
    <cCall: 'Xlib_XColormapEvent_colormap_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XColormapEvent_new_get' plugin: 'x11'>
!
primXColormapEventNew: val
    <cCall: 'Xlib_XColormapEvent_new_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XColormapEvent_state_get' plugin: 'x11'>
!
primXColormapEventState: val
    <cCall: 'Xlib_XColormapEvent_state_set' plugin: 'x11'>
!
"........................................................"
"state accessors"
state
    ^self primXColormapEventState
!
state: val
    ^self primXColormapEventState: val
!






primXlibXColormapEventDelete
    <cCall: 'Xlib_delete_XColormapEvent' plugin: 'x11'>
!

delete
    ^self primXlibXColormapEventDelete.
!


name
    ^'XlibXColormapEvent'

! !

!XlibXColormapEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXColormapEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXMotionEvent
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXMotionEvent class methodsFor: 'initialize-release'!

primXlibXMotionEventCreate
    <cCall: 'Xlib_new_XMotionEvent' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXMotionEventCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXMotionEvent  methodsFor: 'Xlib'!

"_________________________________________________________"
"type primitive accessors"
primXMotionEventType
    <cCall: 'Xlib_XMotionEvent_type_get' plugin: 'x11'>
!
primXMotionEventType: val
    <cCall: 'Xlib_XMotionEvent_type_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XMotionEvent_serial_get' plugin: 'x11'>
!
primXMotionEventSerial: val
    <cCall: 'Xlib_XMotionEvent_serial_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XMotionEvent_send_event_get' plugin: 'x11'>
!
primXMotionEventSendEvent: val
    <cCall: 'Xlib_XMotionEvent_send_event_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XMotionEvent_display_get' plugin: 'x11'>
!
primXMotionEventDisplay: val
    <cCall: 'Xlib_XMotionEvent_display_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XMotionEvent_window_get' plugin: 'x11'>
!
primXMotionEventWindow: val
    <cCall: 'Xlib_XMotionEvent_window_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XMotionEvent_root_get' plugin: 'x11'>
!
primXMotionEventRoot: val
    <cCall: 'Xlib_XMotionEvent_root_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XMotionEvent_subwindow_get' plugin: 'x11'>
!
primXMotionEventSubwindow: val
    <cCall: 'Xlib_XMotionEvent_subwindow_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XMotionEvent_time_get' plugin: 'x11'>
!
primXMotionEventTime: val
    <cCall: 'Xlib_XMotionEvent_time_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XMotionEvent_x_get' plugin: 'x11'>
!
primXMotionEventX: val
    <cCall: 'Xlib_XMotionEvent_x_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XMotionEvent_y_get' plugin: 'x11'>
!
primXMotionEventY: val
    <cCall: 'Xlib_XMotionEvent_y_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XMotionEvent_x_root_get' plugin: 'x11'>
!
primXMotionEventXRoot: val
    <cCall: 'Xlib_XMotionEvent_x_root_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XMotionEvent_y_root_get' plugin: 'x11'>
!
primXMotionEventYRoot: val
    <cCall: 'Xlib_XMotionEvent_y_root_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XMotionEvent_state_get' plugin: 'x11'>
!
primXMotionEventState: val
    <cCall: 'Xlib_XMotionEvent_state_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XMotionEvent_is_hint_get' plugin: 'x11'>
!
primXMotionEventIsHint: val
    <cCall: 'Xlib_XMotionEvent_is_hint_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XMotionEvent_same_screen_get' plugin: 'x11'>
!
primXMotionEventSameScreen: val
    <cCall: 'Xlib_XMotionEvent_same_screen_set' plugin: 'x11'>
!
"........................................................"
"same_screen accessors"
samescreen
    ^self primXMotionEventSameScreen
!
samescreen: val
    ^self primXMotionEventSameScreen: val
!






primXlibXMotionEventDelete
    <cCall: 'Xlib_delete_XMotionEvent' plugin: 'x11'>
!

delete
    ^self primXlibXMotionEventDelete.
!


name
    ^'XlibXMotionEvent'

! !

!XlibXMotionEvent methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXMotionEvent methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXTextItem16
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXTextItem16 class methodsFor: 'initialize-release'!

primXlibXTextItem16Create
    <cCall: 'Xlib_new_XTextItem16' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXTextItem16Create).
!

initialize
    finalizationRequest := true.
! !

!XlibXTextItem16  methodsFor: 'Xlib'!

"_________________________________________________________"
"chars primitive accessors"
primXTextItem16Chars
    <cCall: 'Xlib_XTextItem16_chars_get' plugin: 'x11'>
!
primXTextItem16Chars: val
    <cCall: 'Xlib_XTextItem16_chars_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XTextItem16_nchars_get' plugin: 'x11'>
!
primXTextItem16Nchars: val
    <cCall: 'Xlib_XTextItem16_nchars_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XTextItem16_delta_get' plugin: 'x11'>
!
primXTextItem16Delta: val
    <cCall: 'Xlib_XTextItem16_delta_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XTextItem16_font_get' plugin: 'x11'>
!
primXTextItem16Font: val
    <cCall: 'Xlib_XTextItem16_font_set' plugin: 'x11'>
!
"........................................................"
"font accessors"
font
    ^self primXTextItem16Font
!
font: val
    ^self primXTextItem16Font: val
!






primXlibXTextItem16Delete
    <cCall: 'Xlib_delete_XTextItem16' plugin: 'x11'>
!

delete
    ^self primXlibXTextItem16Delete.
!


name
    ^'XlibXTextItem16'

! !

!XlibXTextItem16 methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXTextItem16 methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXIMPreeditStateNotifyCallbackStruct
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXIMPreeditStateNotifyCallbackStruct class methodsFor: 'initialize-release'!

primXlibXIMPreeditStateNotifyCallbackStructCreate
    <cCall: 'Xlib_new_XIMPreeditStateNotifyCallbackStruct' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXIMPreeditStateNotifyCallbackStructCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXIMPreeditStateNotifyCallbackStruct  methodsFor: 'Xlib'!

"_________________________________________________________"
"state primitive accessors"
primXIMPreeditStateNotifyCallbackStructState
    <cCall: 'Xlib_XIMPreeditStateNotifyCallbackStruct_state_get' plugin: 'x11'>
!
primXIMPreeditStateNotifyCallbackStructState: val
    <cCall: 'Xlib_XIMPreeditStateNotifyCallbackStruct_state_set' plugin: 'x11'>
!
"........................................................"
"state accessors"
state
    ^self primXIMPreeditStateNotifyCallbackStructState
!
state: val
    ^self primXIMPreeditStateNotifyCallbackStructState: val
!






primXlibXIMPreeditStateNotifyCallbackStructDelete
    <cCall: 'Xlib_delete_XIMPreeditStateNotifyCallbackStruct' plugin: 'x11'>
!

delete
    ^self primXlibXIMPreeditStateNotifyCallbackStructDelete.
!


name
    ^'XlibXIMPreeditStateNotifyCallbackStruct'

! !

!XlibXIMPreeditStateNotifyCallbackStruct methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXIMPreeditStateNotifyCallbackStruct methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXIMCallback
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXIMCallback class methodsFor: 'initialize-release'!

primXlibXIMCallbackCreate
    <cCall: 'Xlib_new_XIMCallback' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXIMCallbackCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXIMCallback  methodsFor: 'Xlib'!

"_________________________________________________________"
"client_data primitive accessors"
primXIMCallbackClientData
    <cCall: 'Xlib_XIMCallback_client_data_get' plugin: 'x11'>
!
primXIMCallbackClientData: val
    <cCall: 'Xlib_XIMCallback_client_data_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XIMCallback_callback_get' plugin: 'x11'>
!
primXIMCallbackCallback: val
    <cCall: 'Xlib_XIMCallback_callback_set' plugin: 'x11'>
!
"........................................................"
"callback accessors"
callback
    ^self primXIMCallbackCallback
!
callback: val
    ^self primXIMCallbackCallback: val
!






primXlibXIMCallbackDelete
    <cCall: 'Xlib_delete_XIMCallback' plugin: 'x11'>
!

delete
    ^self primXlibXIMCallbackDelete.
!


name
    ^'XlibXIMCallback'

! !

!XlibXIMCallback methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXIMCallback methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXIC
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXIC class methodsFor: 'initialize-release'!

primXlibXICCreate
    <cCall: 'Xlib_new_XIC' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXICCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXIC  methodsFor: 'Xlib'!



"_________________________________________________________"
"ic primitive function"
primXDestroyIC
    <cCall: 'Xlib_XDestroyIC' plugin: 'x11'>
!

"_________________________________________________________"
"ic primitive function"
primXSetICFocus
    <cCall: 'Xlib_XSetICFocus' plugin: 'x11'>
!

"_________________________________________________________"
"ic primitive function"
primXUnsetICFocus
    <cCall: 'Xlib_XUnsetICFocus' plugin: 'x11'>
!

"_________________________________________________________"
"ic primitive function"
primXwcResetIC
    <cCall: 'Xlib_XwcResetIC' plugin: 'x11'>
!

"_________________________________________________________"
"ic primitive function"
primXmbResetIC
    <cCall: 'Xlib_XmbResetIC' plugin: 'x11'>
!

"_________________________________________________________"
"ic primitive function"
primXSetICValues
    <cCall: 'Xlib_XSetICValues' plugin: 'x11'>
!

"_________________________________________________________"
"ic primitive function"
primXGetICValues
    <cCall: 'Xlib_XGetICValues' plugin: 'x11'>
!

"_________________________________________________________"
"ic primitive function"
primXIMOfIC
    <cCall: 'Xlib_XIMOfIC' plugin: 'x11'>
!

"_________________________________________________________"
"statusReturn primitive function"
primXmbLookupString: arg1 bufferReturn: arg4 bytesBuffer: arg5 keysymReturn: arg6 statusReturn: arg7
    <cCall: 'Xlib_XmbLookupString' plugin: 'x11'>
!

"_________________________________________________________"
"statusReturn primitive function"
primXwcLookupString: arg1 bufferReturn: arg4 wcharsBuffer: arg5 keysymReturn: arg6 statusReturn: arg7
    <cCall: 'Xlib_XwcLookupString' plugin: 'x11'>
!




primXlibXICDelete
    <cCall: 'Xlib_delete_XIC' plugin: 'x11'>
!

delete
    ^self primXlibXICDelete.
!


name
    ^'XlibXIC'

! !

!XlibXIC methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXIC methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXCharStruct
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXCharStruct class methodsFor: 'initialize-release'!

primXlibXCharStructCreate
    <cCall: 'Xlib_new_XCharStruct' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXCharStructCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXCharStruct  methodsFor: 'Xlib'!

"_________________________________________________________"
"lbearing primitive accessors"
primXCharStructLbearing
    <cCall: 'Xlib_XCharStruct_lbearing_get' plugin: 'x11'>
!
primXCharStructLbearing: val
    <cCall: 'Xlib_XCharStruct_lbearing_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XCharStruct_rbearing_get' plugin: 'x11'>
!
primXCharStructRbearing: val
    <cCall: 'Xlib_XCharStruct_rbearing_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XCharStruct_width_get' plugin: 'x11'>
!
primXCharStructWidth: val
    <cCall: 'Xlib_XCharStruct_width_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XCharStruct_ascent_get' plugin: 'x11'>
!
primXCharStructAscent: val
    <cCall: 'Xlib_XCharStruct_ascent_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XCharStruct_descent_get' plugin: 'x11'>
!
primXCharStructDescent: val
    <cCall: 'Xlib_XCharStruct_descent_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XCharStruct_attributes_get' plugin: 'x11'>
!
primXCharStructAttributes: val
    <cCall: 'Xlib_XCharStruct_attributes_set' plugin: 'x11'>
!
"........................................................"
"attributes accessors"
attributes
    ^self primXCharStructAttributes
!
attributes: val
    ^self primXCharStructAttributes: val
!






primXlibXCharStructDelete
    <cCall: 'Xlib_delete_XCharStruct' plugin: 'x11'>
!

delete
    ^self primXlibXCharStructDelete.
!


name
    ^'XlibXCharStruct'

! !

!XlibXCharStruct methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXCharStruct methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXmbTextItem
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXmbTextItem class methodsFor: 'initialize-release'!

primXlibXmbTextItemCreate
    <cCall: 'Xlib_new_XmbTextItem' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXmbTextItemCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXmbTextItem  methodsFor: 'Xlib'!

"_________________________________________________________"
"chars primitive accessors"
primXmbTextItemChars
    <cCall: 'Xlib_XmbTextItem_chars_get' plugin: 'x11'>
!
primXmbTextItemChars: val
    <cCall: 'Xlib_XmbTextItem_chars_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XmbTextItem_nchars_get' plugin: 'x11'>
!
primXmbTextItemNchars: val
    <cCall: 'Xlib_XmbTextItem_nchars_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XmbTextItem_delta_get' plugin: 'x11'>
!
primXmbTextItemDelta: val
    <cCall: 'Xlib_XmbTextItem_delta_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XmbTextItem_font_set_get' plugin: 'x11'>
!
primXmbTextItemFontSet: val
    <cCall: 'Xlib_XmbTextItem_font_set_set' plugin: 'x11'>
!
"........................................................"
"font_set accessors"
fontset
    ^self primXmbTextItemFontSet
!
fontset: val
    ^self primXmbTextItemFontSet: val
!






primXlibXmbTextItemDelete
    <cCall: 'Xlib_delete_XmbTextItem' plugin: 'x11'>
!

delete
    ^self primXlibXmbTextItemDelete.
!


name
    ^'XlibXmbTextItem'

! !

!XlibXmbTextItem methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXmbTextItem methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
CStruct subclass: #XlibXChar2b
        instanceVariableNames: ''
        classVariableNames: ''!

!XlibXChar2b class methodsFor: 'initialize-release'!

primXlibXChar2bCreate
    <cCall: 'Xlib_new_XChar2b' plugin: 'x11'>
!

create
    ^self handle: (self primXlibXChar2bCreate).
!

initialize
    finalizationRequest := true.
! !

!XlibXChar2b  methodsFor: 'Xlib'!

"_________________________________________________________"
"byte1 primitive accessors"
primXChar2bByte1
    <cCall: 'Xlib_XChar2b_byte1_get' plugin: 'x11'>
!
primXChar2bByte1: val
    <cCall: 'Xlib_XChar2b_byte1_set' plugin: 'x11'>
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
    <cCall: 'Xlib_XChar2b_byte2_get' plugin: 'x11'>
!
primXChar2bByte2: val
    <cCall: 'Xlib_XChar2b_byte2_set' plugin: 'x11'>
!
"........................................................"
"byte2 accessors"
byte2
    ^self primXChar2bByte2
!
byte2: val
    ^self primXChar2bByte2: val
!






primXlibXChar2bDelete
    <cCall: 'Xlib_delete_XChar2b' plugin: 'x11'>
!

delete
    ^self primXlibXChar2bDelete.
!


name
    ^'XlibXChar2b'

! !

!XlibXChar2b methodsFor: 'pointer'!

isHandleNil
    ^handle isNil
! !

!XlibXChar2b methodsFor: 'finalization'!

close
    handle := nil.
!

finalize
    self close
! !

"#####################################################################"
