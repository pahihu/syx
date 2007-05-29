"Basic meta"

nil subclass: #Object
    instanceVariableNames: ''!

Object subclass: #Behavior
       instanceVariableNames: 'name superclass methodDict'!

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

ArrayedCollection variableSubclass: #Array
       instanceVariableNames: ''!

ArrayedCollection variableSubclass: #CharacterArray
		  instanceVariableNames: ''!

Array variableSubclass: #Semaphore
      instanceVariableNames: 'signals'!

SequenceableCollection variableSubclass: #OrderedCollection
		       instanceVariableNames: ''!

"Execution"

Object subclass: #Primitive
       instanceVariableNames: 'name module'!

Object subclass: #ContextPart
       instanceVariableNames: ''!

ContextPart subclass: #MethodContext
	    instanceVariableNames: ''!

ContextPart subclass: #BlockContext
	    instanceVariableNames: 'returnContext handledException handlerBlock outerContext'!

Object subclass: #Process
       instanceVariableNames: 'context isSuspended'!

OrderedCollection variableSubclass: #CompiledCode
		  instanceVariableNames: 'literals numArgs numTemps text'!

CompiledCode subclass: #CompiledMethod
	     instanceVariableNames: 'selector category primitive'!

CompiledCode subclass: #CompiledBlock
	     instanceVariableNames: ''!

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
       instanceVariableNames: 'activeProcess processList processTimeslice'!

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
	   instanceVariableNames: 'fd name'!

"Basic data types"

CharacterArray variableSubclass: #String
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

Object subclass: #Dictionary
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
