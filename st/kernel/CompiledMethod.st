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

!CompiledCode methodsFor: 'initialize-release'!

initializeParser: aCompilerParser
    bytecodes
	ifNotNil: [ ^self error: 'Already initialized' ].

    bytecodes := aCompilerParser bytecode contents.
    stackSize := aCompilerParser bytecode stackSize.
    literals := aCompilerParser bytecode literals.
    text := aCompilerParser lexer text
! !

!CompiledCode class methodsFor: 'instance creation'!

fromParser: aCompilerParser
    ^self new initializeParser: aCompilerParser
! !

!CompiledMethod methodsFor: 'initialize-release'!

initializeParser: aCompilerParser
    super initializeParser: aCompilerParser.
    argumentStackSize := aCompilerParser argumentNames size.
    temporaryStackSize := aCompilerParser temporaryNames size.
    selector := aCompilerParser methodMessage.
    primitive := aCompilerParser methodPrimitive
! !

!CompiledMethod methodsFor: 'accessing'!

argumentStackSize
    ^argumentStackSize
!

temporaryStackSize
    ^temporaryStackSize
!

selector
    ^selector
! !

!CompiledBlock methodsFor: 'initialize-release'!

initializeParser: aCompilerParser
    super initializeParser: aCompilerParser.
    argumentStackTop := aCompilerParser argumentScopes peek key - 1
! !
