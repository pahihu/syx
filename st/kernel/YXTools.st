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

Object subclass: #Controller
       instanceVariableNames: 'model view'
       classVariableNames: ''!

Object subclass: #EventDispatcher
       instanceVariableNames: 'events'
       classVariableNames: ''!

Object subclass: #View
       instanceVariableNames: 'eventDispatcher mainWidget mainContainer'
       classVariableNames: ''!

!View class methodsFor: 'instance creation'!

new
    ^self basicNew initialize
! !

!View methodsFor: 'initialize-release'!

initialize
    eventDispatcher := EventDispatcher new.
    self setupBasicDispatcher.
    self setupDispatcher.
    self setupUi
!

setupBasicDispatcher
    eventDispatcher
	registerAll: #(create show close destroy)
!

setupDispatcher

!

setupUi

!

open

!

when: eventName send: message
    eventDispatcher when: eventName send: message
! !

!EventDispatcher class methodsFor: 'instance creation'!

new
    ^self basicNew initialize
! !

!EventDispatcher methodsFor: 'initialize-release'!

initialize
    events := IdentityDictionary new
!

register: eventName
    events at: eventName asSymbol put: Bag new
!

registerAll: eventNames
    eventNames do: [ :ea |
	self register: ea ]
!

when: eventName send: message
    | bag |
    bag := events at: eventName.
    bag add: message
!

dispatch: eventName
    self dispatch: eventName withArguments: #()
!

dispatch: eventName with: anObject
    self dispatch: eventName withArguments: {anObject}
!

dispatch: eventName withArguments: anArray
    | bag |
    bag := events at: eventName.
    bag do: [ :message |
	message key perform: message value withArguments: anArray ]
! !

!Controller class methodsFor: 'instance creation'!

defaultView
    self subclassResponsibility
!

open
    ^(self view: self defaultView) open
!

openOn: aModel
    ^(self on: aModel) open
!

on: aModel view: aView
    ^self basicNew initializeModel: aModel view: aView
!

on: aModel
    ^self on: aModel view: self defaultView
!

view: aView
    ^self on: nil view: aView
! !

!Controller methodsFor: 'initialize-release'!

initializeModel: aModel view: aView
    model := aModel.
    view := aView.
    self setupModel.
    self setupView
!

setupModel

!

setupView

! !

!Controller methodsFor: 'opening'!

open
    view open
! !




" GUI "

Controller subclass: #Application
	   instanceVariableNames: ''
	   classVariableNames: 'RegisteredApplications'!

Application subclass: #Workspace
	    instanceVariableNames: ''
	    classVariableNames: ''!

View subclass: #WorkspaceView
     instanceVariableNames: ''
     classVariableNames: ''!

!Application class methodsFor: 'initialize-release'!

initialize
    RegisteredApplications := Set new
! !

!Application methodsFor: 'initialize-release'!

open
    super open.
    self register
!

setupView
    view
	when: #close send: self -> #unregister
!

register
    RegisteredApplications add: self
!

unregister
    RegisteredApplications remove: self
! !

!WorkspaceView methodsFor: 'initialize-release'!

setupDispatcher
    super setupDispatcher.
    eventDispatcher registerAll: #(doIt clear quit)
! !


!Workspace methodsFor: 'initialize-release'!

setupView
    view
	when: #doIt send: self -> #onDoIt:;
	when: #quit send: Smalltalk -> #quit
! !

!Workspace methodsFor: 'events'!

onDoIt: aString
    [ aString doIt ] on: Error do: [ :ex | ex debug ]
! !
