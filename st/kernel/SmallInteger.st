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

!SmallInteger methodsFor: 'arithmetic'!

+ aNumber
     <primitive: 'SmallInteger_plus'>
	 aNumber isSmallInteger
	 ifTrue: [ self asLargeInteger + aNumber asLargeInteger ]
	 ifFalse: [ ^self retrySumCoercing: aNumber ]
!

- aNumber
     <primitive: 'SmallInteger_minus'>
	 aNumber isSmallInteger
	 ifTrue: [ self asLargeInteger - aNumber asLargeInteger ]
	 ifFalse: [ ^self retryDiffCoercing: aNumber ]
!

< aNumber
     <primitive: 'SmallInteger_lt'>
	 ^self retryLesserCoercing: aNumber
!

> aNumber
     <primitive: 'SmallInteger_gt'>
	 ^self retryGreaterCoercing: aNumber
!

<= aNumber
     <primitive: 'SmallInteger_le'>
	 ^self retryLesserEqualCoercing: aNumber
!

>= aNumber
     <primitive: 'SmallInteger_ge'>
	 ^self retryGreaterEqualCoercing: aNumber
!

= aNumber
     <primitive: 'SmallInteger_eq'>
	 ^self retryEqualCoercing: aNumber
!

== aNumber
     <primitive: 'SmallInteger_eq'>
	 ^self retryEqualCoercing: aNumber
!

~= aNumber
     <primitive: 'SmallInteger_ne'>
	 ^self retryNotEqualCoercing: aNumber
!

~~ aNumber
     <primitive: 'SmallInteger_ne'>
	 ^self retryNotEqualCoercing: aNumber
! !

!SmallInteger methodsFor: 'coercing'!

asSmallInteger
    ^self
!

asFloat
    <primitive: 'SmallInteger_asFloat'>
	self primitiveFailed
!

asLargeInteger
    <primitive: 'SmallInteger_asLargeInteger'>
	self primitiveFailed
!

print
    <primitive: 'SmallInteger_print'>
	self primitiveFailed
!

generality
    ^10
!

unity
    ^1
! !
