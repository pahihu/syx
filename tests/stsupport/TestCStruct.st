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

Object subclass: #TestCStruct
       instanceVariableNames: 'generator'
       classVariableNames: ''!

CStruct subclass: #Test1Struct
        instanceVariableNames: ''
        classVariableNames: ''!

CStruct subclass: #Test2Struct
        instanceVariableNames: ''
        classVariableNames: ''!

CStruct subclass: #Test3Struct
        instanceVariableNames: ''
        classVariableNames: ''!

!Test1Struct class methodsFor: 'initialize-release'!

fields
    ^#((f1 char) (f2 char) (f3 char) (f4 char)
      (f5 int) (f6 long))
! !

!Test2Struct class methodsFor: 'initialize-release'!

fields
    ^#((f1 char) (f2 char)
       (f3 shortInt) (f4 shortInt)
       (f5 int) (f6 int)
       (f7 pointer) (f8 pointer)
       (f9 char) (f10 int)
       (f11 char) (f12 pointer)
       (f13 shortInt) (f14 pointer))
! !

!Test3Struct class methodsFor: 'initialize-release'!

fields
    ^#((f1 shortInt) (f2 int) (f3 char) (f4 double) (f5 float) (f6 long))
! !

!Test3Struct methodsFor: 'assertion'!

assertField: aSymbol toBe: anObject
   | gotObject |
   gotObject := self perform: aSymbol.
   anObject = gotObject
       ifFalse: [ self error: aSymbol asString, ' is ', gotObject printString, ' expected ', anObject printString ]
! !

!Test3Struct methodsFor: 'test'!

testRead
   self assertField: #f1 toBe: 240.
   self assertField: #f2 toBe: 7143.
   self assertField: #f3 toBe: $R.
   self assertField: #f4 toBe: 199.11822.
   self assertField: #f5 toBe: 23.5.
!

testWrite
   self
        f1: 320;
        f2: 10293;
        f3: $,;
        f4: 291.4837;
        f5: 76.119
! !

!TestCStruct class methodsFor: 'initialize-release'!

initialize
   Test3Struct initialize
! !

!TestCStruct methodsFor: 'test'!

testOffsets: anArray from: aCStructSymbol
    | generator fields |
    fields := (Smalltalk at: aCStructSymbol) fields.
    generator := CStructGenerator new: fields.
    generator fieldSpecs with: anArray do: [ :spec :offset |
         self assertOffsetOf: spec toBe: offset ]
!

testRead: cPointer
    (Test3Struct handle: cPointer) testRead
!

testWrite: cPointer
    (Test3Struct handle: cPointer) testWrite
! !

!TestCStruct methodsFor: 'assertion'!

assertOffsetOf: aFieldSpec toBe: anOffset
    aFieldSpec offset = anOffset
         ifFalse: [ self error: aFieldSpec name asString, ' at ', aFieldSpec offset printString, ' expected ', anOffset printString ]
! !