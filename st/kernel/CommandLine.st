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

!CommandLine class methodsFor: 'instance creation'!

new
    ^self basicNew initialize
!

new: commandLineArguments
    ^self new
        commandLineArguments: commandLineArguments;
        yourself
! !

!CommandLine methodsFor: 'initialize-release'!

initialize
    arguments := OrderedCollection new.
    options := Dictionary new
! !

!CommandLine methodsFor: 'accessing'!

commandLineArguments: anArray
    commandLineArguments := anArray.
    self initialize
!

commandLineArguments
    ^commandLineArguments
!

options
    ^options
!

arguments
    ^arguments
! !

!CommandLine methodsFor: 'parser'!

parse: optionsSpec
    | i |
    i := 1.
    [ i <= commandLineArguments size ]
        whileTrue: [
            | arg |
            arg := commandLineArguments at: i.
            arg first = $-
                ifTrue: [ i := self parseCommandLineOptionAt: i forSpec: optionsSpec ]
                ifFalse: [ arguments add: arg ].
            i := i + 1 ]
!

parseCommandLineOptionAt: anIndex forSpec: optionsSpec
    | arg symArg |
    arg := commandLineArguments at: anIndex.

    "Check for single options without argument"
    symArg := (String with: arg second) asSymbol.
    (optionsSpec includes: symArg)
        ifTrue: [
            options at: symArg put: true.
            ^anIndex ].

    "Check for options with argument"
    symArg := (String with: arg second with: $:) asSymbol.
    (optionsSpec includes: symArg)
        ifTrue: [
            anIndex = commandLineArguments size
                ifTrue: [ self error: arg, ' expects an argument' ].
            
            options at: symArg put: (commandLineArguments at: anIndex + 1).
            ^anIndex + 1 ].

    self error: arg, ' is an unknown option'
! !
