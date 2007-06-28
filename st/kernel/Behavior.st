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

!Behavior methodsFor: 'accessing'!

name
    ^name
!

superclass
    ^superclass
!

printString
    ^self name asString
! !

!Behavior methodsFor: 'instance creation'!

basicNew
    <primitive: 'Behavior_new'>
	^self primitiveFailed
!

new
    <primitive: 'Behavior_new'>
	^self primitiveFailed
!

basicNew: anInteger
    <primitive: 'Behavior_newColon'>
	^self primitiveFailed
!

new: anInteger
    <primitive: 'Behavior_newColon'>
	^self primitiveFailed
! !

!Behavior methodsFor: 'enumerating'!

allSuperclassesDo: aBlock  
    "Invokes aBlock for all superclasses, both direct and indirect."
    | class superclass |
    class := self.
    [ superclass := class superclass.
      class := superclass.
      superclass notNil ]
	whileTrue: [ aBlock value: superclass ]
! !
