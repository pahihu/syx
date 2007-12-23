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

CObject subclass: #CStruct
        instanceVariableNames: ''
        classVariableNames: ''!

!CStruct class methodsFor: 'initialize-release'!

initialize
    (CStructGenerator new: self fields)
         compileAccessorsOn: self
!

fields
    "Example:
     ^#((char field1)
        (shortInt field2)
        (int field3)
        (long field4)
        (pointer field5)
        (float field6)
        (double field7)
        (NestedCStruct field8))"

    ^#()
! !

!CStruct methodsFor: 'primitives'!

primOn: handle type: type at: offset
    <primitive: 'CStruct_on_type_at'>
        self primitiveFailed
!

primOn: handle type: type at: offset put: anObject
    <primitive: 'CStruct_on_type_at_put'>
        self primitiveFailed
! !