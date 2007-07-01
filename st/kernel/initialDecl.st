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
       instanceVariableNames: 'name superclass instanceVariableNames instanceSize methodDict'
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

Collection subclass: #SequenceableCollection
	   instanceVariableNames: ''
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
		       instanceVariableNames: ''
                       classVariableNames: ''!

"Execution"

Object subclass: #ContextPart
       instanceVariableNames: 'parent method stack sp ip receiver arguments temporaries returnContext'
       classVariableNames: ''!

ContextPart subclass: #MethodContext
	    instanceVariableNames: ''
            classVariableNames: ''!

MethodContext subclass: #BlockContext
	    instanceVariableNames: 'outerContext handledException handlerBlock'
            classVariableNames: ''!

Object subclass: #Process
       instanceVariableNames: 'context suspended returnedObject next scheduled'
       classVariableNames: ''!

Object subclass: #Semaphore
       instanceVariableNames: 'waitingProcesses signals'
       classVariableNames: ''!

OrderedCollection subclass: #CompiledCode
		  instanceVariableNames: 'selector bytecodes literals argumentsCount temporariesCount stackSize primitive'
                  classVariableNames: ''!

CompiledCode subclass: #CompiledMethod
	     instanceVariableNames: ''
             classVariableNames: ''!

CompiledMethod subclass: #CompiledBlock
	       instanceVariableNames: 'argumentsTop'
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
       instanceVariableNames: ''
       classVariableNames: ''!

Stream subclass: #PositionableStream
       instanceVariableNames: 'collection ptr endPtr access'
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
	   instanceVariableNames: 'fd name filePtr'
           classVariableNames: ''!

"Basic data types"

ByteArray subclass: #String
	  instanceVariableNames: ''
          classVariableNames: ''!

Object subclass: #Symbol
       instanceVariableNames: ''
       classVariableNames: ''!

Object subclass: #Magnitude
       instanceVariableNames: ''
       classVariableNames: ''!

Magnitude subclass: #Character
	  instanceVariableNames: ''
          classVariableNames: ''!

Magnitude subclass: #Number
	  instanceVariableNames: ''
          classVariableNames: ''!

Magnitude subclass: #CPointer
	  instanceVariableNames: ''
          classVariableNames: ''!

Number subclass: #SmallInteger
       instanceVariableNames: ''
       classVariableNames: ''!

Number subclass: #LargeInteger
       instanceVariableNames: ''
       classVariableNames: ''!

LargeInteger subclass: #LargePositiveInteger
	     instanceVariableNames: ''
	     classVariableNames: ''!

LargeInteger subclass: #LargeNegativeInteger
	     instanceVariableNames: ''
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

Association subclass: #Link
	    instanceVariableNames: 'next'
            classVariableNames: ''!

Association subclass: #VariableBinding
	    instanceVariableNames: 'dictionary'
	    classVariableNames: ''!

Object subclass: #Dictionary
       instanceVariableNames: 'hashTable'
       classVariableNames: ''!

Dictionary subclass: #SystemDictionary
	   instanceVariableNames: ''
           classVariableNames: ''!

"Gtk"

Object subclass: #Gtk
       instanceVariableNames: ''
       classVariableNames: ''!

Object subclass: #GObject
       instanceVariableNames: 'handle'
       classVariableNames: ''!

GObject subclass: #GtkWidget
	instanceVariableNames: ''
        classVariableNames: ''!

GtkWidget subclass: #GtkWindow
	  instanceVariableNames: ''
          classVariableNames: ''!

"Console"

Object subclass: #Console
       instanceVariableNames: 'haveReadline'
       classVariableNames: ''!

"Exceptions"

Object subclass: #Signal
       instanceVariableNames: 'handlerContext signalerContext'
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

VMError subclass: #PrimitiveFailed
	instanceVariableNames: ''
        classVariableNames: ''!

Halt subclass: #MessageNotUnderstood
     instanceVariableNames: ''
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
