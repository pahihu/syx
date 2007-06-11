"Basic meta"

nil subclass: #Object
    instanceVariableNames: ''!

Object subclass: #Behavior
       instanceVariableNames: 'name superclass instanceVariables instanceSize methodDict'!

Object subclass: #UndefinedObject
       instanceVariableNames: ''!

Behavior subclass: #Class
	 instanceVariableNames: ''!

Behavior subclass: #Metaclass
	 instanceVariableNames: ''!

"Collections"

Object subclass: #Collection
       instanceVariableNames: ''!

Collection subclass: #SequenceableCollection
	   instanceVariableNames: ''!

SequenceableCollection subclass: #ArrayedCollection
		       instanceVariableNames: ''!

ArrayedCollection subclass: #Array
		  instanceVariableNames: ''!

ArrayedCollection subclass: #ByteArray
		  instanceVariableNames: ''!

Array subclass: #Semaphore
      instanceVariableNames: 'signals'!

SequenceableCollection subclass: #OrderedCollection
		       instanceVariableNames: ''!

"Execution"

Object subclass: #ContextPart
       instanceVariableNames: 'parent method stack sp ip receiver arguments temporaries returnContext'!

ContextPart subclass: #MethodContext
	    instanceVariableNames: ''!

ContextPart subclass: #BlockContext
	    instanceVariableNames: 'outerContext handledException handlerBlock'!

Object subclass: #Process
       instanceVariableNames: 'context suspended returnedObject next scheduled'!

OrderedCollection subclass: #CompiledCode
		  instanceVariableNames: 'selector bytecodes literals argumentsCount temporariesCount stackSize primitive'!

CompiledCode subclass: #CompiledMethod
	     instanceVariableNames: ''!

CompiledMethod subclass: #CompiledBlock
	     instanceVariableNames: 'argumentsTop'!

Object subclass: #BlockClosure
       instanceVariableNames: 'block definedContext'!

"Exceptions"

Object subclass: #Signal
       instanceVariableNames: 'handlerContext signalerContext'!

Signal subclass: #Exception
       instanceVariableNames: ''!

Exception subclass: #Error
	  instanceVariableNames: 'description'!

"Management"

Object subclass: #ProcessorScheduler
       instanceVariableNames: 'byteslice firstProcess activeProcess'!

Object subclass: #ObjectMemory
       instanceVariableNames: ''!

"Streams"

Object subclass: #Stream
       instanceVariableNames: ''!

Stream subclass: #PositionableStream
       instanceVariableNames: 'collection ptr endPtr access'!

PositionableStream subclass: #WriteStream
		   instanceVariableNames: ''!

WriteStream subclass: #ReadWriteStream
	    instanceVariableNames: ''!

ReadWriteStream subclass: #ByteStream
		instanceVariableNames: ''!

ByteStream subclass: #FileStream
	   instanceVariableNames: 'fd name filePtr'!

"Basic data types"

ByteArray subclass: #String
	       instanceVariableNames: ''!

Object subclass: #Symbol
       instanceVariableNames: ''!

Object subclass: #Magnitude
       instanceVariableNames: ''!

Magnitude subclass: #Character
	  instanceVariableNames: ''!

Magnitude subclass: #Number
	  instanceVariableNames: ''!

Number subclass: #SmallInteger
       instanceVariableNames: ''!

Object subclass: #Boolean
       instanceVariableNames: ''!

Boolean subclass: #True
	instanceVariableNames: ''!

Boolean subclass: #False
	instanceVariableNames: ''!

"Dictionaries"

Magnitude subclass: #LookupKey
	  instanceVariableNames: 'key value'!

LookupKey subclass: #Association
	  instanceVariableNames: ''!

LookupKey subclass: #Link
	  instanceVariableNames: 'next'!

Object subclass: #Dictionary
       instanceVariableNames: 'hashTable'!

Dictionary subclass: #SystemDictionary
	   instanceVariableNames: ''!

"Gtk"

Object subclass: #Gtk
       instanceVariableNames: ''!

Object subclass: #GObject
       instanceVariableNames: ''!

GObject subclass: #GtkButton
	instanceVariableNames: ''!

GObject subclass: #GtkWindow
	instanceVariableNames: ''!

"Console"

Object subclass: #Console
       instanceVariableNames: ''!
