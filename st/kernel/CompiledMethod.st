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

!CompiledCode methodsFor: 'accessing'!

bytecodes
    ^bytecodes
!

argumentCount
    ^argumentCount
!

temporaryCount
    ^temporaryCount
!

stackSize
    ^stackSize
!

methodClass
    ^class
!

text
    ^text
!

selector
    ^nil
! !

!CompiledMethod class methodsFor: 'instance creation'!

fromParser: aCompilerParser
    ^CompiledMethod new initializeParser: aCompilerParser
! !

!CompiledMethod methodsFor: 'initialize-release'!

initializeParser: aCompilerParser
    bytecodes
	ifNotNil: [ ^self error: 'Already initialized' ].

    bytecodes := aCompilerParser bytecode contents.
    stackSize := aCompilerParser bytecode stackSize.
    literals := aCompilerParser bytecode literals.
    argumentCount := aCompilerParser argumentNames size.
    temporaryCount := aCompilerParser temporaryNames size.
    selector := aCompilerParser methodMessage.
    primitive := aCompilerParser methodPrimitive.
    text := aCompilerParser lexer text
! !

!CompiledMethod methodsFor: 'accessing'!

selector
    ^selector
! !

!CompiledBlock methodsFor: 'initialize-release'!

initializeParser: aCompilerParser
    super initializeParser: aCompilerParser.
    argumentsTop := aCompilerParser argumentScopes peek key
! !
