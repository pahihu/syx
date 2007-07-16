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
	ifTrue: [ ^lastToken := self symbolToken ].
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
