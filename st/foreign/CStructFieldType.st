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

Object subclass: #CStructFieldType
       instanceVariableNames: 'name bytes nestedStruct'
       classVariableNames: 'CStructFieldBytes'!

!CStructFieldType class methodsFor: 'C types bytes'!

sizeOfChar
     ^1
!

sizeOfShortInt
     ^2
!

sizeOfInt
     ^4
!

sizeOfLong
     <primitive: 'CStructFieldType_sizeOfLong'>
          self primitiveFailed
!

sizeOfPointer
     <primitive: 'CStructFieldType_sizeOfPointer'>
          self primitiveFailed
!

sizeOfFloat
     ^4
!

sizeOfDouble
     ^8
! !

!CStructFieldType class methodsFor: 'initialize-release'!

initialize
     CStructFieldBytes := IdentityDictionary new.
     CStructFieldBytes
          at: #char put: self sizeOfChar;
          at: #shortInt put: self sizeOfShortInt;
          at: #int put: self sizeOfInt;
          at: #long put: self sizeOfLong;
          at: #pointer put: self sizeOfPointer;
          at: #float put: self sizeOfFloat;
          at: #double put: self sizeOfDouble
! !

!CStructFieldType class methodsFor: 'instance creation'!

fromName: aSymbol
     ^CStructFieldType new name: aSymbol
! !

!CStructFieldType methodsFor: 'accessing'!

name: aSymbol
     aSymbol isCapitalized
           ifTrue: [ self nestedStruct: (Smalltalk at: aSymbol) ]
           ifFalse: [ bytes := CStructFieldBytes at: aSymbol. name := aSymbol ]
!

name
     ^name
!

bytes
     ^bytes
!

bytes: aNumber
     bytes := aNumber
!

nestedStruct
     ^nestedStruct
!

nestedStruct: aClass
     nestedStruct := aClass.
     name := nestedStruct name.
     bytes := nestedStruct bytes
! !

!CStructFieldType methodsFor: 'generator'!

compileAccessorsOn: aClass named: aSymbol withOffset: anOffset
     | writeSelector |
     writeSelector := (aSymbol asString copyWith: $:) asSymbol.
     self
        compileReadAccessorOn: aClass named: aSymbol withOffset: anOffset;
        compileWriteAccessorOn: aClass named: writeSelector withOffset: anOffset
!

compileReadAccessorOn: aClass named: aSymbol withOffset: anOffset
     | stream |
     stream := WriteStream on: String new.
     stream
        nextPutAll: aSymbol; nl;
        nextPutAll: '^self primOn: handle type: #'; nextPutAll: name;
        nextPutAll: ' at: '; nextPutAll: anOffset printString.
     aClass compile: stream contents
!

compileWriteAccessorOn: aClass named: aSymbol withOffset: anOffset
     | stream |
     stream := WriteStream on: String new.
     stream
        nextPutAll: aSymbol; nextPutAll: ' anObject'; nl;
        nextPutAll: 'self primOn: handle type: #'; nextPutAll: name;
        nextPutAll: ' at: '; nextPutAll: anOffset printString;
        nextPutAll: ' put: anObject'.
     aClass compile: stream contents
! !
     