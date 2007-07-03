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

!LargeInteger methodsFor: 'coercing'!

asLargeInteger
    ^self
!

asInteger
    ^self
!

generality
    ^20
!

zero
    ^0 asLargeInteger
!

unity
    ^1 asLargeInteger
!

coerce: aNumber
    ^aNumber asLargeInteger
! !

!LargeInteger methodsFor: 'testing'!

isSmallInteger
    ^false
!

isLargePositiveInteger
    ^self >= 0
!

isLargeNegativeInteger
    ^self < 0
!

isLargeInteger
    ^true
! !

!LargeInteger methodsFor: 'printing'!

print
    <primitive: 'LargeInteger_print'>
	self primitiveFailed
! !

!LargeInteger methodsFor: 'bit-wise operations'!

bitAnd: aNumber
    self notImplementedYet
!

bitOr: aNumber
    self notImplementedYet
!

bitXor: aNumber
    self notImplementedyet
! !
