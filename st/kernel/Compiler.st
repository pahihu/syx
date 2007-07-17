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


" THE LEXER "


String subclass: #CompilerIdentifierToken
       instanceVariableNames: ''
       classVariableNames: ''!

String subclass: #CompilerClosingToken
       instanceVariableNames: ''
       classVariableNames: ''!

String subclass: #CompilerBinaryToken
       instanceVariableNames: ''
       classVariableNames: ''!

!CompilerLexer class methodsFor: 'initialize-release'!

initialize
    ClosingTokenTable := { $.. $]. $). $}. $;. $". $\ }.
    SingleBinaryTable := { ${. $[. $(. $). $]. $}. $!. $^ }
! !

!CompilerLexer methodsFor: 'basic'!

next
    ^lastChar := super next
! !

!CompilerLexer methodsFor: 'parsing'!

skipBlankAndComments
    [ self next = $"
        ifTrue: [
            [ self next notNil & (lastChar ~= $") ]
		whileTrue.
            self next ].
	lastChar notNil and: [ lastChar isWhiteSpace | (lastChar = $") ] ] whileTrue
!

identifierToken
    | stream |
    stream := WriteStream with: (CompilerIdentifierToken with: lastChar).
    [ self atEnd or: [ self next isAlphaNumeric not ] ]
	whileFalse: [
	    stream nextPut: lastChar ].

    lastChar = $:
	ifTrue: [ stream nextPut: $: ]
	ifFalse: [ self skip: -1 ].

    ^stream contents
!

symbolToken
    | stream |
    self next isDigit | (lastChar isWhiteSpace)
	ifTrue: [ self error: 'Invalid symbol' ].
    stream := WriteStream with: lastChar asString.
    
    [ self atEnd not and: [ self next isAlphaNumeric | (lastChar = $:) ] ]
	whileTrue: [
	    stream nextPut: lastChar ].
    self skip: -1.

    ^stream contents asSymbol
!

literalArrayToken
    | stream |
    stream := WriteStream on: Array new.
    [ self nextToken isNil or: [ lastToken class = CompilerClosingToken & (lastToken first = $)) ] ]
	whileFalse: [
	    | token |
	    token := lastToken class
		caseOf: {
		    [ CompilerClosingToken ] -> [ self error: 'Illegal text in array' ].
		    [ CompilerIdentifierToken ] -> [ lastToken asSymbol ].
		    [ CompilerBinaryToken ] -> [
			lastToken first = $(
			    ifTrue: [ self literalArrayToken ]
			    ifFalse: [ lastToken asSymbol ] ] }
		otherwise: [ lastToken ].
	    stream nextPut: token ].
    ^stream contents
!

numberToken
    | ret |
    self skip: -1.
    ret := Number fromStream: self.
    self skip: -1.
    ^ret
!

stringToken
    | stream |
    stream := WriteStream on: String new.
    [ lastChar = $' ]
	whileTrue: [
	    [ self atEnd or: [ self next = $' ] ]
		whileFalse: [
		    stream nextPut: lastChar ].
	    self next = $'
		ifTrue: [ stream nextPut: $' ] ].

    ^stream contents
!

isClosing: aCharacter
    ^ClosingTokenTable includes: aCharacter
!

isSingleBinary: aCharacter
    ^SingleBinaryTable includes: aCharacter
!

isBinarySecond: aCharacter
    ^(aCharacter isAlphaNumeric | aCharacter isWhiteSpace |
     (aCharacter = $-) | (self isClosing: aCharacter) | (self isSingleBinary: aCharacter)) not
!

nextToken
    | binary |
    self skipBlankAndComments.

    lastChar ifNil: [ ^nil ].
    lastChar isLetter
	ifTrue: [ ^lastToken := self identifierToken ].
    lastChar isDigit
	ifTrue: [ ^lastToken := self numberToken ].
    lastChar = $$
	ifTrue: [ ^lastToken := self next ].
    lastChar = $#
	ifTrue: [
	    self next = $(
		ifTrue: [ ^lastToken := self literalArrayToken ]
		ifFalse: [ self skip: -1. ^lastToken := self symbolToken ] ].
    lastChar = $'
	ifTrue: [ ^lastToken := self stringToken ].
    (self isClosing: lastChar)
	ifTrue: [ ^lastToken := CompilerClosingToken with: lastChar ].
    (self isSingleBinary: lastChar)
	ifTrue: [ ^lastToken := CompilerBinaryToken with: lastChar ].
    
    binary := CompilerBinaryToken with: lastChar.
    (self isBinarySecond: self next)
	ifTrue: [ binary := binary, lastChar asString ]
	ifFalse: [ self skip: -1 ].
    ^binary
! !


" THE PARSER "

!CompilerBytecode class methodsFor: 'instance creation'!

new
    ^(self on: ByteArray new) initialize
! !

!CompilerBytecode methodsFor: 'basic'!

initialize
    super initialize.
    stackSize := 1.
    literals := OrderedCollection new
!

nextPut: anInstruction
    "Write a 16-bit integer into the stream"
    super nextPut: (anInstruction bitAnd: 16rFF).
    super nextPut: anInstruction >> 8.
    ^anInstruction
!

command: aSymbol
    ^CompilerBytecodeCommands at: aSymbol
!

nextPutCommand: aCommand withArgument: anArgument
    anArgument > 16r7FF
	ifTrue: [ ^self extend: aCommand withArgument: anArgument ]
    ^self nextPut: aCommand << 11 + anArgument
! !

!CompilerBytecode methodsFor: 'accessing'!

literals
    ^literals asArray
!

stackSize
    ^stackSize
! !

!CompilerBytecode methodsFor: 'bytecodes'!

genLiteral: anObject
    ^literals indexOf: anObject
	      ifAbsent: [ literals add: anObject.
			  literals size - 1 ]
!

pushInstance: anIndex
    stackSize := stackSize + 1.
    ^self nextPutCommand: 0 withArgument: anIndex
!

pushArgument: anIndex
    stackSize := stackSize + 1.
    ^self nextPutCommand: 1 withArgument: anIndex
!

pushTemporary: anIndex
    stackSize := stackSize + 1.
    ^self nextPutCommand: 2 withArgument: anIndex
!

pushLiteral: anObject
    stackSize := stackSize + 1.
    ^self nextPutCommand: 3 withArgument: (self genLiteral: anObject)
!

pushConstant: aConstant
    | argument |
    stackSize := stackSize + 1.
    argument := aConstant
	caseOf: {
	    [ nil ] -> [ 0 ].
	    [ true ] -> [ 1 ].
	    [ false ] -> [ 2 ].
	    [ #context ] -> [ 3 ] }
	otherwise: [ self error: 'Unknown constant' ].
    ^self nextPutCommand: 4 withArgument: argument
!

pushBindingVariable: aBindingVariable
    stackSize := stackSize + 1.
    ^self nextPutCommand: 5 withArguments: (self genLiteral: aBindingVariable)
!

pushArray: numElements
    stackSize := stackSize + 1.
    ^self nextPutCommand: 6 withArgument: numElements
!

pushBlockClosure: aBlockClosure
    stackSize := stackSize + 1.
    ^self nextPutCommand: 7 withArgument: (self genLiteral: aBlockClosure)
!

assignInstance: anIndex
    ^self nextPutCommand: 8 withArgument: anIndex
!

assignTemporary: anIndex
    ^self nextPutCommand: 9 withArgument: anIndex
!

assignBindingVariable: aBindingVariable
    ^self nextPutCommand: 10 withArgument: (self genLiteral: aBindingVariable)
!

sendMessage: aMessage ofArguments: numArguments toSuper: aBoolean
    | binding |
    binding := VariableBinding key: aMessage value: 0.
    self nextPutCommand: 11 withArgument: numArguments.
    ^self nextPutCommand: (aBoolean
			      ifTrue: [ 13 ]
			      ifFalse: [ 12 ])
	 withArgument: (self genLiteral: binding)
!

doSpecial: specialSymbol
    | argument |
    argument := specialSymbol
	caseOf: {
	    [ #popTop ] -> [ 0 ].
	    [ #selfReturn ] -> [ 1 ].
	    [ #stackReturn ] -> [ 2 ].
	    [ #duplicate ] -> [ 3 ].
	    [ #branch ] -> [ 4 ].
	    [ #branchIfTrue ] -> [ 5 ].
	    [ #branchIfFalse ] -> [ 6 ] }
	otherwise: [ self error: 'Unknown special command ', specialSymbol printString ].
    ^self nextPutCommand: 16 withArgument: argument
!

extend: aCommand withArgument: anArgument
    self nextPutCommand: 16r1F withArgument: aCommand.
    ^self nextPut: anInteger
! !
