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

Object subclass: #Model
       instanceVariableNames: 'dependents'
       classVariableNames: ''!

Model subclass: #View
      instanceVariableNames: 'model mainWidget mainContainer'
      classVariableNames: ''!

" MODEL "

!Model class methodsFor: 'instance creation'!

new
    ^self basicNew initialize
! !

!Model methodsFor: 'initialize-release'!

initialize
    dependents := Bag new
! !

!Model methodsFor: 'dependents'!

addDependent: anObject
    dependents add: anObject
!

removeDependent: anObject
    dependents remove: anObject
! !

!Model methodsFor: 'changing'!

changed: aspectSymbol
    dependents do: [ :ea |
	ea update: aspectSymbol ]
! !


" VIEW "

!View class methodsFor: 'instance creation'!

model: aModel
    ^self basicNew initialize; model: aModel; yourself
! !

!View methodsFor: 'initialize-release'!

initialize
    super initialize.
    self setupUi
!

setupUi

!

open
    self subclassResponsibility
! !

!View methodsFor: 'accessing'!

model
    ^model
!

model: aModel
    model ifNotNil: [
	model removeDependent: self ].
    model := aModel.
    model addDependent: self
! !

!View methodsFor: 'updating'!

update: aspectSymbol
    self subclassResponsibility
! !


" CONTROLLER "

!Controller class methodsFor: 'instance creation'!

defaultViewClass
    self subclassResponsibility
!

defaultModelClass
    self subclassResponsibility
!

open
    ^(self model: self defaultModelClass new) open
!

model: aModel
    ^self model: aModel view: (self defaultViewClass model: aModel)
!

model: aModel view: aView
    ^self new model: aModel; view: aView; yourself
! !

!Controller methodsFor: 'accessing'!

model
    ^model
!

model: aModel
    model := aModel
!

view
    ^view
!

view: aView
    view ifNotNil: [ view removeDependent: self ].
    view := aView.
    view addDependent: self
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

Model subclass: #WorkspaceModel
      instanceVariableNames: 'text'
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

register
    RegisteredApplications add: self
!

unregister
    RegisteredApplications remove: self
! !


" VIEW "

!WorkspaceView methodsFor: 'updating'!

update: aspectSymbol
    aspectSymbol = #text
	ifTrue: [ self displayText ]
! !


" CONTROLLER "

!Workspace class methodsFor: 'instance creation'!

defaultModelClass
    ^WorkspaceModel
! !

!Workspace methodsFor: 'updating'!

update: aspectSymbol
    aspectSymbol = #doIt
	ifTrue: [
	    model text: view getText.
	    ^[ model text doIt ] on: Error do: [ :ex | ex debug ] ].

    aspectSymbol = #quit
	ifTrue: [ Smalltalk quit ].

    aspectSymbol = #clear
	ifTrue: [ model text: '' ]
! !

" MODEL "

!WorkspaceModel methodsFor: 'accessing'!

text
    ^text
!

text: aString
    text := aString.
    self changed: #text
! !
