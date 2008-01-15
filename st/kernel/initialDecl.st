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

"Basic meta"

nil subclass: #Object
    instanceVariableNames: ''
    classVariableNames: ''!

Object subclass: #Behavior
       instanceVariableNames: 'name superclass instanceVariableNames instanceSize methodDictionary subclasses finalizationRequest'
       classVariableNames: ''!

Object subclass: #UndefinedObject
       instanceVariableNames: ''
       classVariableNames: ''!

Behavior subclass: #Class
	 instanceVariableNames: 'classVariables'
         classVariableNames: ''!

Behavior subclass: #Metaclass
	 instanceVariableNames: 'instanceClass'
         classVariableNames: ''!

"Collections"

Object subclass: #Collection
       instanceVariableNames: ''
       classVariableNames: ''!

Collection subclass: #Set
	   instanceVariableNames: 'tally'
	   classVariableNames: ''!

Collection subclass: #SequenceableCollection
	   instanceVariableNames: ''
           classVariableNames: ''!

SequenceableCollection subclass: #Interval
	   instanceVariableNames: 'start stop step'
	   classVariableNames: ''!

SequenceableCollection subclass: #ArrayedCollection
		       instanceVariableNames: ''
                       classVariableNames: ''!

ArrayedCollection subclass: #Array
		  instanceVariableNames: ''
                  classVariableNames: ''!

ArrayedCollection subclass: #ByteArray
		  instanceVariableNames: ''
                  classVariableNames: ''!

SequenceableCollection subclass: #OrderedCollection
		       instanceVariableNames: 'firstIndex lastIndex'
                       classVariableNames: ''!

Object subclass: #Stack
       instanceVariableNames: 'collection top'
       classVariableNames: ''!

Set subclass: #Bag
    instanceVariableNames: ''
    classVariableNames: ''!

"Execution"

Object subclass: #ContextPart
       instanceVariableNames: 'parent method ap tp sp ip receiver returnContext'
       classVariableNames: ''!

ContextPart subclass: #MethodContext
	    instanceVariableNames: ''
            classVariableNames: ''!

MethodContext subclass: #BlockContext
	    instanceVariableNames: 'outerContext handledException handlerBlock ensureBlock'
            classVariableNames: ''!

Object subclass: #Process
       instanceVariableNames: 'context stack suspended returnedObject next scheduled'
       classVariableNames: ''!

Object subclass: #Semaphore
       instanceVariableNames: 'waitingProcesses signals'
       classVariableNames: ''!

Object subclass: #CompiledCode
       instanceVariableNames: 'bytecodes argumentCount literals stackSize text class'
       classVariableNames: ''!

CompiledCode subclass: #CompiledMethod
	     instanceVariableNames: 'argumentStackSize temporaryStackSize selector primitive'
             classVariableNames: ''!

CompiledCode subclass: #CompiledBlock
	     instanceVariableNames: 'argumentStackTop'
	     classVariableNames: ''!

Object subclass: #BlockClosure
       instanceVariableNames: 'block definedContext'
       classVariableNames: ''!


"Management"

Object subclass: #ProcessorScheduler
       instanceVariableNames: 'processByteslice firstProcess activeProcess'
       classVariableNames: ''!

Object subclass: #ObjectMemory
       instanceVariableNames: ''
       classVariableNames: ''!

"Streams"

Object subclass: #Stream
       instanceVariableNames: 'accessMode'
       classVariableNames: ''!

Stream subclass: #PositionableStream
       instanceVariableNames: 'collection curPos endPos'
       classVariableNames: ''!

Stream subclass: #Random
       instanceVariableNames: 'seed'
       classVariableNames: ''!

PositionableStream subclass: #ReadStream
		   instanceVariableNames: ''
		   classVariableNames: ''!

PositionableStream subclass: #WriteStream
		   instanceVariableNames: ''
                   classVariableNames: ''!

WriteStream subclass: #ReadWriteStream
	    instanceVariableNames: ''
            classVariableNames: ''!

ReadWriteStream subclass: #ByteStream
		instanceVariableNames: ''
                classVariableNames: ''!

ByteStream subclass: #FileStream
	   instanceVariableNames: 'handle name filePtr peek'
           classVariableNames: ''!

FileStream subclass: #StdIOStream
	   instanceVariableNames: ''
	   classVariableNames: ''!

"Basic data types"

ByteArray subclass: #String
	  instanceVariableNames: ''
          classVariableNames: ''!

String subclass: #Symbol
       instanceVariableNames: ''
       classVariableNames: ''!

Object subclass: #Magnitude
       instanceVariableNames: ''
       classVariableNames: ''!

Object subclass: #CObject
       instanceVariableNames: 'handle'
       classVariableNames: ''!

Magnitude subclass: #Character
	  instanceVariableNames: ''
          classVariableNames: 'WhiteSpaceTable XDigitsTable'!

Magnitude subclass: #Number
	  instanceVariableNames: ''
          classVariableNames: ''!

Magnitude subclass: #CPointer
	  instanceVariableNames: ''
          classVariableNames: ''!

Magnitude subclass: #Date
          instanceVariableNames: 'days day month year'
          classVariableNames: 'DayNames MonthNames'!

Magnitude subclass: #DateTime
	  instanceVariableNames: 'offset second minute hour mday month year wday yday'
	  classVariableNames: ''!

Magnitude subclass: #Duration
	  instanceVariableNames: 'seconds'
	  classVariableNames: ''!

Number subclass: #Integer
       instanceVariableNames: ''
       classVariableNames: ''!

Integer subclass: #SmallInteger
	instanceVariableNames: ''
	classVariableNames: ''!

Integer subclass: #LargeInteger
	instanceVariableNames: ''
	classVariableNames: ''!

Number subclass: #Fraction
       instanceVarableNames: 'numerator denominator'
       classVariableNames: ''!

Number subclass: #Float
       instanceVariableNames: ''
       classVariableNames: ''!

Object subclass: #Boolean
       instanceVariableNames: ''
       classVariableNames: ''!

Boolean subclass: #True
	instanceVariableNames: ''
        classVariableNames: ''!

Boolean subclass: #False
	instanceVariableNames: ''
        classVariableNames: ''!

"Dictionaries"

Object subclass: #Association
       instanceVariableNames: 'key value'
       classVariableNames: ''!

Association subclass: #VariableBinding
	    instanceVariableNames: 'dictionary'
	    classVariableNames: ''!

Collection subclass: #Dictionary
	   instanceVariableNames: 'tally'
	   classVariableNames: ''!

Dictionary subclass: #IdentityDictionary
	   instanceVariableNames: ''
	   classVariableNames: ''!

IdentityDictionary subclass: #SystemDictionary
		   instanceVariableNames: 'systemInitializationRequests commandLine startupProcess startupObject'
		   classVariableNames: ''!



"WinWorkspace"

Object subclass: #WinWorkspace
       instanceVariableNames: ''
       classVariableNames: ''!

"Compiler"

Object subclass: #CompilerLexer
       instanceVariableNames: 'lastChar lastToken stream'
       classVariableNames: 'ClosingTokenTable SingleBinaryTable'!

WriteStream subclass: #CompilerBytecode
	    instanceVariableNames: 'literals stackSize'
	    classVariableNames: ''!

Object subclass: #CompilerParser
       instanceVariableNames: 'lexer class bytecode argumentScopes temporaryScopes duplicateIndexes methodPrimitive methodMessage inBlock temporaryNames argumentNames instanceNames'
       classVariableNames: 'PrimitiveTable'!

String subclass: #CompilerIdentifierToken
       instanceVariableNames: ''
       classVariableNames: ''!

String subclass: #CompilerClosingToken
       instanceVariableNames: ''
       classVariableNames: ''!

String subclass: #CompilerBinaryToken
       instanceVariableNames: ''
       classVariableNames: ''!

"Console"

Object subclass: #CommandLine
       instanceVariableNames: 'commandLineArguments arguments options'
       classVariableNames: ''!

Object subclass: #Console
       instanceVariableNames: 'haveReadline'
       classVariableNames: ''!

"Exceptions"

Object subclass: #Signal
       instanceVariableNames: 'handlerContext signalerContext messageText'
       classVariableNames: ''!

Signal subclass: #Exception
       instanceVariableNames: ''
       classVariableNames: ''!

Exception subclass: #Error
	  instanceVariableNames: ''
          classVariableNames: ''!

Error subclass: #NotImplemented
      instanceVariableNames: ''
      classVariableNames: ''!

Error subclass: #VMError
      instanceVariableNames: ''
      classVariableNames: ''!

Error subclass: #Halt
      instanceVariableNames: ''
      classVariableNames: ''!

Error subclass: #ZeroDivide
      instanceVariableNames: ''
      classVariableNames: ''!

VMError subclass: #PrimitiveFailed
	instanceVariableNames: ''
        classVariableNames: ''!

VMError subclass: #SystemSignal
	instanceVariableNames: ''
	classVariableNames: ''!

PrimitiveFailed subclass: #WrongArgumentCount
		instanceVariableNames: ''
		classVariableNames: ''!

Halt subclass: #MessageNotUnderstood
     instanceVariableNames: 'message receiver'
     classVariableNames: ''!

NotImplemented subclass: #NotYetImplemented
	       instanceVariableNames: ''
               classVariableNames: ''!

NotImplemented subclass: #ShouldNotImplement
	       instanceVariableNames: ''
               classVariableNames: ''!

ShouldNotImplement subclass: #SubclassResponsibility
		   instanceVariableNames: ''
                   classVariableNames: ''!

Error subclass: #InvalidValue
      instanceVariableNames: ''
      classVariableNames: ''!

InvalidValue subclass: #InvalidArgument
	     instanceVariableNames: ''
             classVariableNames: ''!

InvalidArgument subclass: #NotFound
		instanceVariableNames: ''
                classVariableNames: ''!

SystemSignal subclass: #UserInterrupt
	     instanceVariableNames: ''
	     classVariableNames: ''!

SystemSignal subclass: #TerminationSignal
	     instanceVariableNames: ''
	     classVariableNames: ''!

SystemSignal subclass: #AbnormalTermination
	     instanceVariableNames: ''
	     classVariableNames: ''!

SystemSignal subclass: #FloatingPointException
	     instanceVariableNames: ''
	     classVariableNames: ''!
