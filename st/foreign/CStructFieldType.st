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

!CStructFieldType class methodsFor: 'initialize-release'!

initialize
     CStructFieldSizes := IdentityDictionary new.
     CStructFieldSizes
          at: #char put: 1;
          at: #shortInt put: 2;
          at: #int put: 4;
          at: #largeInteger put: 8;
          at: #pointer put: 4
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