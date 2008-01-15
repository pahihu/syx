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

!Random class methodsFor: 'instance creation'!

new
    ^self basicNew initialize
! !

!Random methodsFor: 'initialize-release'!

initialize
    seed := 0
! !

!Random methodsFor: 'accessing'!

seed
    ^seed
!

seed: anInteger
    seed := anInteger
! !

!Random methodsFor: 'basic'!

next
    "This is an implementation of the Lehmer's linear congruential method"
    | temp |
    temp := 0.
    [ temp = 0 ]
        whileTrue: [
            seed := 13849 + (27181 * seed) bitAnd: 65535.
            temp := seed / 65536.0 ].
    ^temp
! !
