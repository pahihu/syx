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

!CompilerIdentifierToken methodsFor: 'testing'!

isNameConst
    ^self isNameColon not
!

isNameColon
    ^self last = $:
! !

!CompilerLexer class methodsFor: 'initialize-release'!

initialize
    ClosingTokenTable := { $.. $]. $). $}. $;. $". $\ }.
    SingleBinaryTable := { ${. $[. $(. $). $]. $}. $!. $^ }
! !

!CompilerLexer class methodsFor: 'instance creation'!

readFrom: readStream
    ^self new initializeStream: readStream
!

text: aString
    ^self readFrom: (ReadStream on: aString)
! !

!CompilerLexer methodsFor: 'basic'!

next
    ^lastChar := stream next
! !

!CompilerLexer methodsFor: 'initialize-release'!

initializeStream: readStream
    stream := readStream
! !

!CompilerLexer methodsFor: 'accessing'!

stream
    ^stream
!

text
    ^stream contents
!

lastToken
    ^lastToken
!

lastChar
    ^lastChar
! !

!CompilerLexer methodsFor: 'parsing'!

skipBlankAndComments
    [ self next = $"
        ifTrue: [
            [ self next notNil and: [ lastChar ~= $" ] ]
		whileTrue.
            self next ].
	lastChar notNil and: [ lastChar isWhiteSpace | (lastChar = $") ] ] whileTrue
!

identifierToken
    | s |
    s := WriteStream with: (CompilerIdentifierToken with: lastChar).
    [ stream atEnd or: [ self next isAlphaNumeric not ] ]
	whileFalse: [
	    s nextPut: lastChar ].

    lastChar = $:
	ifTrue: [ s nextPut: $: ]
	ifFalse: [ 
	    stream atEnd
		ifFalse: [ stream skip: -1 ] ].

    ^s contents
!

symbolToken
    | s |
    self next isDigit | (lastChar isWhiteSpace)
	ifTrue: [ self error: 'Invalid symbol' ].
    s := WriteStream with: lastChar asString.
    
    (self isBinarySecond: lastChar)
	ifTrue: [
	    (self isBinarySecond: self next)
		ifTrue: [ s nextPut: lastChar ]
		ifFalse: [
		    stream atEnd
			ifFalse: [ stream skip: -1 ] ] ]
	ifFalse: [
	    [ stream atEnd not and: [ self next isAlphaNumeric | (lastChar = $:) ] ]
		whileTrue: [
		    s nextPut: lastChar ].
	    stream atEnd
		ifFalse: [ stream skip: -1 ] ].

    ^s contents asSymbol
!

literalArrayToken
    | s |
    s := WriteStream on: Array new.
    [ self nextToken isNil or: [ lastToken class = CompilerClosingToken and: [ lastToken first = $) ] ] ]
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
	    s nextPut: token ].
    ^s contents
!

numberToken
    | ret |
    stream skip: -1.
    ^Number readFrom: stream
!

stringToken
    | s |
    s := WriteStream on: String new.
    [ lastChar = $' ]
	whileTrue: [
	    [ stream atEnd or: [ self next = $' ] ]
		whileFalse: [
		    s nextPut: lastChar ].
	    self next = $'
		ifTrue: [ s nextPut: $' ] ].
    stream atEnd
	ifFalse: [ stream skip: -1 ].

    ^s contents
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

expect: aToken toBe: discriminatorBlock instanceOf: aClass otherwise: exceptionBlock
    ^(aToken class = aClass and: [ discriminatorBlock value: aToken ])
	ifTrue: [ aToken ]
	ifFalse: [ exceptionBlock value ]
!

expect: aToken equalTo: anObject instanceOf: aClass otherwise: exceptionBlock
    ^self expect: aToken toBe: [ :t | t = (aClass withAll: anObject) ] instanceOf: aClass otherwise: exceptionBlock
!

expect: aToken equalTo: anObject instanceOf: aClass
    ^self expect: aToken equalTo: anObject instanceOf: aClass
	  otherwise: [ self error: 'Expected ', anObject printString, ' got ', aToken printString ]
!

nextToken
    | binary |
    self skipBlankAndComments.

    lastChar ifNil: [ ^lastToken := nil ].
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
		ifFalse: [ stream skip: -1. ^lastToken := self symbolToken ] ].
    lastChar = $'
	ifTrue: [ ^lastToken := self stringToken ].
    (self isClosing: lastChar)
	ifTrue: [ ^lastToken := CompilerClosingToken with: lastChar ].
    (self isSingleBinary: lastChar)
	ifTrue: [ ^lastToken := CompilerBinaryToken with: lastChar ].
    
    binary := CompilerBinaryToken with: lastChar.
    (self isBinarySecond: self next)
	ifTrue: [ binary := binary, lastChar asString ]
	ifFalse: [ 
	    stream atEnd
		ifFalse: [ stream skip: -1 ] ].
    ^lastToken := binary
! !


" THE BYTECODE "

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
    ^(literals indexOf: anObject
	       ifAbsent: [
		   ObjectMemory setConstant: anObject.
		   literals add: anObject.
		   literals size ]) - 1
!

pushInstance: anIndex
    stackSize := stackSize + 1.
    ^self nextPutCommand: 0 withArgument: anIndex - 1
!

pushArgument: anIndex
    stackSize := stackSize + 1.
    ^self nextPutCommand: 1 withArgument: anIndex
!

pushTemporary: anIndex
    stackSize := stackSize + 1.
    ^self nextPutCommand: 2 withArgument: anIndex - 1
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
	    [ #nil ] -> [ 0 ].
	    [ #true ] -> [ 1 ].
	    [ #false ] -> [ 2 ].
	    [ #thisContext ] -> [ 3 ] }
	otherwise: [ self error: 'Unknown constant' ].
    ^self nextPutCommand: 4 withArgument: argument
!

pushVariableBinding: aVariableBinding
    stackSize := stackSize + 1.
    ^self nextPutCommand: 5 withArgument: (self genLiteral: aVariableBinding)
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
    ^self nextPutCommand: 8 withArgument: anIndex - 1
!

assignTemporary: anIndex
    ^self nextPutCommand: 9 withArgument: anIndex - 1
!

assignBindingVariable: aBindingVariable
    ^self nextPutCommand: 10 withArgument: (self genLiteral: aBindingVariable)
!

sendMessage: aMessage ofArguments: numArguments toSuper: aBoolean
    | binding |
    binding := VariableBinding key: aMessage asSymbol value: 0.
    self nextPutCommand: 11 withArgument: numArguments.
    ^self nextPutCommand: (aBoolean
			      ifTrue: [ 13 ]
			      ifFalse: [ 12 ])
	  withArgument: (self genLiteral: binding)
!

duplicateAt: anIndex
    | coll |
    coll := collection copyFrom: anIndex + 1 to: endPos.
    self
	position: anIndex;
	doSpecial: #duplicate.
    coll do: [ :ea |
	super nextPut: ea ]
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
    ^self nextPut: anArgument
! !



" THE PARSER "

!CompilerParser class methodsFor: 'instance creation'!

initialize
    PrimitiveTable := #(
 	    'Processor_yield'
	    'Object_class'
	    'Behavior_new'
	    'Behavior_newColon'
	    'Object_at'
	    'Object_at_put'
	    'Object_size'
	    'Object_identityEqual'
	    'Object_identityHash'
	    'Object_hash'
	    'Object_equal'
	    'Object_resize'
	    'Object_copy'

	    'ArrayedCollection_replaceFromToWith'
	    'ByteArray_newColon'
	    'ByteArray_at'
	    'ByteArray_at_put'
	    
	    'BlockClosure_asContext'
	    'BlockClosure_value'
	    'BlockClosure_valueWith'
	    'BlockClosure_valueWithArguments'
	    'BlockClosure_on_do'
	    'BlockClosure_newProcess'

	    'String_asSymbol'
	    'Float_print'

	    'Processor_enter'
	    'Processor_swapWith'
	    'Processor_leaveTo_andAnswer'
	    
	    'Character_new'
	    'Character_value'
	    
	    'Semaphore_signal'
	    'Semaphore_wait'
	    'Semaphore_waitFor'
	    
	    'String_compile'
	    'String_hash'

	    'FileStream_fileOp'

	    'SmallInteger_plus'
	    'SmallInteger_minus'
	    'SmallInteger_lt'
	    'SmallInteger_gt'
	    'SmallInteger_le'
	    'SmallInteger_ge'
	    'SmallInteger_eq'
	    'SmallInteger_ne'
	    'SmallInteger_div'
	    'SmallInteger_mul'
	    'SmallInteger_mod'
	    'SmallInteger_bitAnd'
	    'SmallInteger_bitOr'
	    'SmallInteger_bitXor'
	    'SmallInteger_bitShift'
	    'SmallInteger_asFloat'
	    'SmallInteger_asLargeInteger'

	    'LargeInteger_plus'
	    'LargeInteger_minus'
	    'LargeInteger_lt'
	    'LargeInteger_gt'
	    'LargeInteger_le'
	    'LargeInteger_ge'
	    'LargeInteger_eq'
	    'LargeInteger_ne'
	    'LargeInteger_div'
	    'LargeInteger_intDiv'
	    'LargeInteger_quo'
	    'LargeInteger_mul'
	    'LargeInteger_mod'
	    'LargeInteger_bitAnd'
	    'LargeInteger_bitOr'
	    'LargeInteger_bitXor'
	    'LargeInteger_bitShift'
	    'LargeInteger_clear'
	    'LargeInteger_asFloat'

	    'Float_plus'
	    'Float_minus'
	    'Float_mul'
	    'Float_div'
	    'Float_lt'
	    'Float_gt'
	    'Float_le'
	    'Float_ge'
	    'Float_eq'
	    'Float_ne'
	    'Float_ceil'
	    'Float_floor'
	    'Float_trunc'
	    
	    'ObjectMemory_snapshot'
	    'ObjectMemory_garbageCollect'

	    'Smalltalk_quit'
	    'Smalltalk_loadPlugin'
	    'Smalltalk_unloadPlugin')
!
	    
new
    ^self shouldNotImplement
!

compilerLexerClass
    ^CompilerLexer
!

compilerBytecodeClass
    ^CompilerBytecode
!

text: aString for: aClass
    ^self on: (self compilerLexerClass text: aString) for: aClass
!

on: aCompilerLexer for: aClass
    ^self basicNew
	initializeLexer: aCompilerLexer class: aClass
! !

!CompilerParser methodsFor: 'initialize-release'!

initializeLexer: aCompilerLexer class: aClass
    lexer := aCompilerLexer.
    class := aClass.
    bytecode := CompilerParser compilerBytecodeClass on: ByteArray new.

    temporaryNames := OrderedCollection new.

    argumentNames := OrderedCollection new.

    instanceNames := Array new.
    class allSuperclassesDo: [ :ea |
	instanceNames := ea instanceVariableNames, instanceNames ].
    instanceNames := instanceNames, class instanceVariableNames.

    inBlock := false.

    argumentScopes := Stack new.
    temporaryScopes := Stack new.
    duplicateIndexes := Stack new
! !

!CompilerParser methodsFor: 'accessing'!

lexer
    ^lexer
!

bytecode
    ^bytecode
!

argumentNames
    ^argumentNames
!

temporaryNames
    ^temporaryNames
!

argumentScopes
    ^argumentScopes
!

temporaryScopes
    ^temporaryScopes
!

methodMessage
    ^methodMessage
!

methodPrimitive
    ^methodPrimitive
! !

!CompilerParser methodsFor: 'variable names'!

indexOfTemporary: anIdentifier ifPresent: aBlock
    | name |
    name := anIdentifier asSymbol.
    temporaryScopes contents reverseDo: [ :scope |
	temporaryNames from: scope key to: scope value keysAndValuesDo: [ :i :ea |
	    ea asSymbol = name
		ifTrue: [ ^aBlock value: i ] ] ].
!

indexOfArgument: anIdentifier ifPresent: aBlock
    | name |
    name := anIdentifier asSymbol.
    argumentScopes contents reverseDo: [ :scope |
	argumentNames from: scope key to: scope value keysAndValuesDo: [ :i :ea |
	    ea asSymbol = name
		ifTrue: [ ^aBlock value: i ] ] ].
!

indexOfInstance: aSymbol ifPresent: aBlock
    | index |
    index := instanceNames indexOf: aSymbol ifAbsent: [ nil ].
    index ifNotNil: [ aBlock value: index ]
! !

!CompilerParser methodsFor: 'parsing'!

parse
    lexer nextToken
	ifNil: [ ^self ].
    
    self parseMessagePattern.

    inBlock
	ifFalse: [ self parsePrimitive ].

    self parseTemporaries.
    inBlock
	ifTrue: [ bytecode pushConstant: #nil ].
    self parseBody.
    bytecode doSpecial: #selfReturn
!

parseMessagePattern
    inBlock
	ifTrue: [ self parseBlockMessagePattern ]
	ifFalse: [ self parseMethodMessagePattern ]
!

parseBlockMessagePattern
    | token argNum |
    token := lexer lastToken.
    argNum := argumentNames size + 1.

    lexer expect: token equalTo: ':' instanceOf: CompilerBinaryToken
	  otherwise: [ ^argumentScopes push: argNum -> (argNum - 1) ].

    [ token class = CompilerBinaryToken and: [ token first = $: ] ]
	whileTrue: [
	    token := lexer expect: lexer nextToken
			   toBe: [ :t | t isNameConst ]
			   instanceOf: CompilerIdentifierToken
			   otherwise: [ ^self error: 'Invalid argument name' ].
	    argumentNames add: token.
	    token := lexer nextToken ].

    lexer expect: token equalTo: '|' instanceOf: CompilerBinaryToken.

    argumentScopes push: argNum -> argumentNames size.
    lexer nextToken
!

parseMethodMessagePattern
    | token argNum keywordMessage |
    token := lexer lastToken.
    argNum := argumentNames size + 1.
    keywordMessage := WriteStream on: String new.

    (token class = CompilerIdentifierToken and: [ token isNameConst ])
	ifTrue: [
	    methodMessage := token asSymbol.
	    argumentScopes push: argNum -> (argNum - 1).
	    ^lexer nextToken ].

    token class = CompilerBinaryToken
	ifTrue: [
	    methodMessage := token asSymbol.
	    token := lexer nextToken.
	    token class = CompilerIdentifierToken
		ifFalse: [ ^self error: 'Expected name constant for argument name' ].
	    argumentNames add: token.
	    argumentScopes push: argNum -> argNum.
	    ^lexer nextToken ].

    token class = CompilerIdentifierToken
	ifFalse: [ ^self error: 'Invalid message pattern' ].

    [ token class = CompilerIdentifierToken ]
	whileTrue: [
	    keywordMessage nextPutAll: token.
	    token := lexer expect: lexer nextToken
			   toBe: [ :t | t isNameConst ]
			   instanceOf: CompilerIdentifierToken
			   otherwise: [ self error: 'Expected name const' ].
	    argumentNames add: token.
	    token := lexer nextToken ].

    argumentScopes push: argNum -> argumentNames size.
    methodMessage := keywordMessage contents asSymbol
!

parseSystemPrimitive
   | token |
    token := lexer nextToken.
    token isString
	ifFalse: [ ^self error: 'Expected a string containing the primitive to be called' ].
    
    methodPrimitive := PrimitiveTable
	indexOf: token
	ifAbsent: [ ^self error: 'Unknown primitive named ', token ].
    
    token := lexer expect: lexer nextToken
		   equalTo: '>'
		   instanceOf: CompilerBinaryToken.
    lexer nextToken
!

parsePluginPrimitive
    | token |
    token := lexer nextToken.
    token isString
	ifFalse: [ ^self error: 'Expected a string containing the primitive to be called' ].
    
    bytecode genLiteral: token asSymbol.
    
    token := lexer expect: lexer nextToken
		   equalTo: 'plugin:'
		   instanceOf: CompilerIdentifierToken.
    token := lexer nextToken.
    token isString
	ifFalse: [ ^self error: 'Expected a string containing the plugin name' ].
    bytecode genLiteral: token asSymbol.

    token := lexer expect: lexer nextToken
		   equalTo: '>'
		   instanceOf: CompilerBinaryToken.
    
    methodPrimitive := -2.
    lexer nextToken
!

parsePrimitive
    | token |
    lexer expect: lexer lastToken
	  equalTo: '<'
	  instanceOf: CompilerBinaryToken
	  otherwise: [ ^methodPrimitive := -1 ].

    token := lexer expect: lexer nextToken
		   toBe: [ :t | t isNameColon ]
		   instanceOf: CompilerIdentifierToken
		   otherwise: [ self error: 'Expected name colon' ].

    token
	caseOf: {
		 [ 'primitive:' ] -> [ self parseSystemPrimitive ].
		 [ 'cCall:' ] -> [ self parsePluginPrimitive ] }
	otherwise: [ ^self error: 'Expected primitive: or cCall:' ]
!

parseTemporaries
    | token tmpNum |
    token := lexer lastToken.
    tmpNum := temporaryNames size + 1.

    lexer expect: token equalTo: '|' instanceOf: CompilerBinaryToken
	  otherwise: [ ^temporaryScopes push: tmpNum -> (tmpNum - 1) ].
    
    [ (token := lexer nextToken) class = CompilerIdentifierToken and: [ token isNameConst ] ]
	whileTrue: [ temporaryNames add: token ].
    
    lexer expect: token equalTo: '|' instanceOf: CompilerBinaryToken.
    temporaryScopes push: tmpNum -> temporaryNames size.
    lexer nextToken
!

parseBody
    | token closedBraces |
    token := lexer lastToken.
    closedBraces := false.
    
    [ token notNil ]
	whileTrue: [
	    (inBlock and: [ token class = CompilerClosingToken and: [ token first = $] ] ] )
		ifTrue: [ ^self ].

	    self parseStatement.
	    token := lexer lastToken.

	    (token class = CompilerClosingToken and: [ token first = $. ])
	        ifTrue: [
		    token := lexer nextToken.
		    token isNil | token class = CompilerClosingToken
			ifFalse: [ bytecode doSpecial: #popTop ] ] ].
    inBlock
	ifTrue: [ self error: 'Expected ] after block' ]
!

parseStatement
    | token |
    token := lexer lastToken.
    lexer expect: token equalTo: '^' instanceOf: CompilerBinaryToken
	  otherwise: [ ^self parseExpression ].

    lexer nextToken.
    self parseExpression.
    bytecode doSpecial: #stackReturn
!

parseExpression
    | token assignName superTerm |
    token := lexer lastToken.
    superTerm := false.
    (token class = CompilerIdentifierToken and: [ token isNameConst ])
	ifTrue: [
	    assignName := token.
	    ((token := lexer nextToken) class = CompilerBinaryToken and: [ token asSymbol = #:= ] )
		ifTrue: [
		    lexer nextToken.
		    self parseAssignment: assignName ]
		ifFalse: [
		    superTerm := self parseNameTerm: assignName ] ]
	ifFalse: [
	    superTerm := self parseTerm ].
    self doContinuation: superTerm
!

parseAssignment: assignName
    | binding |
    self indexOfTemporary: assignName
	 ifPresent: [ :i | self parseExpression. ^bytecode assignTemporary: i ].
    self indexOfInstance: assignName
	 ifPresent: [ :i | self parseExpression. ^bytecode assignInstance: i ].

    self error: 'Unassignable variable named: ', assignName
!

parseNameTerm: anIdentifier
    | name binding |
    name := anIdentifier asSymbol.
    (#(self super) includes: name)
	ifTrue: [
	    bytecode pushArgument: 0.
	    ^name = #super ].

    (#(nil true false thisContext) includes: name)
	ifTrue: [ bytecode pushConstant: name. ^false ].

    self indexOfArgument: name
	 ifPresent: [ :i | bytecode pushArgument: i. ^false ].
    self indexOfTemporary: name
	 ifPresent: [ :i | bytecode pushTemporary: i. ^false ].
    self indexOfInstance: name
	 ifPresent: [ :i | bytecode pushInstance: i. ^false ].

    binding := VariableBinding key: name on: Smalltalk.
    binding value: binding value - 1.
    bytecode pushVariableBinding: binding.
    ^false
!

parseTerm
    | token superTerm |
    token := lexer lastToken.
    superTerm := false.
    token class
	caseOf: {
	    [ CompilerIdentifierToken ] -> [ 
		token isNameColon
		    ifTrue: [ ^self error: 'Unexpected name colon identifier' ].
		superTerm := self parseNameTerm: token ].
	    [ CompilerBinaryToken ] -> [
		token := String withAll: token.
		token caseOf: {
		    [ '(' ] -> [
			lexer nextToken.
			self parseExpression.
			lexer expect: lexer lastToken
			      equalTo: ')'
			      instanceOf: CompilerClosingToken ].
		    [ '[' ] -> [ self parseBlock ].
		    [ '{' ] -> [ self parseArray ].
		    [ '-' ] -> [ bytecode pushLiteral: lexer nextToken negated ] } ].
	    [ UndefinedObject ] -> [ ^self error: 'Unexpected end of input' ] }
	otherwise: [ bytecode pushLiteral: token ].
    lexer nextToken.
    ^superTerm
!

parseBlock
    | block closure oldBytecode blockState |
    oldBytecode := bytecode.
    blockState := inBlock.

    bytecode := CompilerParser compilerBytecodeClass on: ByteArray new.
    inBlock := true.

    self parse.

    block := CompiledBlock fromParser: self.
    closure := BlockClosure new: block.
    bytecode := oldBytecode.
    inBlock := blockState.
    temporaryScopes pop.
    argumentScopes pop.

    bytecode pushBlockClosure: closure
!

parseArray
    | token numElements |
    token := lexer nextToken.
    numElements := 0.
    [ token notNil and: [ token class = CompilerClosingToken and: [ token first = $} ] ] ]
	whileFalse: [
	    self parseExpression.
	    numElements := numElements + 1.
	    token := lexer lastToken.
	    (token class = CompilerClosingToken and: [ token first = $. ])
		ifTrue: [ token := lexer nextToken ] ].
    bytecode pushArray: numElements
!

doContinuation: toSuper
    | token superReceiver |
    duplicateIndexes push: 0.
    superReceiver := self doKeyContinuation: toSuper.
    token := lexer lastToken.

    [ token class = CompilerClosingToken and: [ token first = $; ] ]
	whileTrue: [
	    bytecode
		duplicateAt: duplicateIndexes peek;
		doSpecial: #popTop.
	    lexer nextToken.
	    self doKeyContinuation: superReceiver.
	    token := lexer lastToken ].

    duplicateIndexes pop
!

doKeyContinuation: toSuper
    | token superReceiver conditionalBranch |
    superReceiver := self doBinaryContinuation: toSuper cascading: true.
    token := lexer lastToken.
    (token class = CompilerIdentifierToken and: [ token isNameColon ])
	ifTrue: [
	    | numArgs message |
	    duplicateIndexes peekPut: bytecode size.

	    token asSymbol = #ifTrue:
		ifTrue: [
		    conditionalBranch := #branchIfTrue ].
	    token asSymbol = #ifFalse:
		ifTrue: [
		    conditionalBranch := #branchIfFalse ].
	    conditionalBranch
		ifNotNil: [
		    | jump conditionJump |
		    lexer nextToken.
		    jump := self parseOptimizedBlock: conditionalBranch doPop: false.
		    token := lexer lastToken.
		    (token class = CompilerIdentifierToken
			 and: [ conditionalBranch = #branchIfTrue & (token asSymbol = #ifFalse:)
				    or: [ conditionalBranch = #branchIfFalse & (token asSymbol = #ifTrue:) ] ] )
			ifTrue: [
			    lexer nextToken.
			    
			    "skip else block if condition"
			    bytecode doSpecial: #branch.
			    bytecode nextPut: 0.
			    conditionJump := bytecode position - 2.

			    "jump here if not condition"
			    bytecode
				position: jump;
				nextPut: bytecode size / 2;
				setToEnd.
			    jump := self parseOptimizedBlock: #branch doPop: true.
			    "we don't need any jump after else block"
			    bytecode
				position: jump;
				nextPut: 0;
				"jump here if condition"
				position: conditionJump;
				nextPut: bytecode size / 2;
				setToEnd ].
		    ^false ].
	    token asSymbol = #whileTrue:
		ifTrue: [
		    conditionalBranch := #branchIfTrue ].
	    token asSymbol = #whileFalse:
		ifTrue: [
		    conditionalBranch := #branchIfFalse ].
	    conditionalBranch
		ifNotNil: [
		    | loopJump conditionJump |
		    lexer nextToken.
		    loopJump := bytecode size / 2.
		    bytecode doSpecial: #duplicate.
		    bytecode sendMessage: #value ofArguments: 0 toSuper: false.
		    conditionJump := self parseOptimizedBlock: conditionalBranch doPop: false.
		    bytecode
			doSpecial: #popTop;
			doSpecial: #branch;
			nextPut: loopJump;
			position: conditionJump;
			nextPut: bytecode size / 2;
			setToEnd;
			doSpecial: #popTop.

		    ^false ].

	    numArgs := 0.
	    message := WriteStream on: String new.
	    [token class = CompilerIdentifierToken and: [ token isNameColon ]]
		whileTrue: [
		    message nextPutAll: token.
		    numArgs := numArgs + 1.
		    lexer nextToken.

		    superReceiver := self parseTerm.
		    self doBinaryContinuation: superReceiver cascading: false.
		    
		    token := lexer lastToken ].
	    
	    bytecode sendMessage: message contents ofArguments: numArgs toSuper: superReceiver.
	    ^false ].
    ^superReceiver
!

parseOptimizedBlock: branchType doPop: aBoolean
    | jump blockState token |
    bytecode doSpecial: branchType.
    bytecode nextPut: 0.
    jump := bytecode position - 2.
    
    aBoolean
	ifTrue: [ bytecode doSpecial: #popTop ].
    
    blockState := inBlock.
    inBlock := true.

    token := lexer lastToken.
    (token class = CompilerBinaryToken and: [ token first = $[ ])
	ifTrue: [
	    lexer nextToken.
	    self parseTemporaries.
	    self parseBody.
	    lexer nextToken.
	    temporaryScopes pop ]
	ifFalse: [
	    self doBinaryContinuation: self parseTerm cascading: false.
	    bytecode sendMessage: #value ofArguments: 0 toSuper: false ].

    inBlock := blockState.
    bytecode
	position: jump;
	nextPut: bytecode size / 2;
	setToEnd.
    ^jump
!

doBinaryContinuation: toSuper cascading: aBoolean
    | token superReceiver doCascade |
    superReceiver := self doUnaryContinuation: toSuper cascading: aBoolean.
    token := lexer lastToken.
    doCascade := aBoolean.
    [ token class = CompilerBinaryToken ]
	whileTrue: [
	    | message |
	    doCascade ifTrue: [
		duplicateIndexes peekPut: bytecode size.
		doCascade := false ].

            message := token.
	    lexer nextToken.
	    superReceiver := self parseTerm.
	    self doUnaryContinuation: superReceiver cascading: false.
	    token := lexer lastToken.
	    bytecode sendMessage: message ofArguments: 1 toSuper: superReceiver ].
    ^superReceiver
!
    
doUnaryContinuation: toSuper cascading: aBoolean
    | token superReceiver |
    superReceiver := toSuper.
    token := lexer lastToken.
    [ token class = CompilerIdentifierToken and: [ token isNameConst ] ]
	whileTrue: [
	    aBoolean
		ifTrue: [ duplicateIndexes peekPut: bytecode size ].
	    bytecode sendMessage: token ofArguments: 0 toSuper: superReceiver.
	    token := lexer nextToken.
	    superReceiver := false ].
    ^superReceiver
! !
