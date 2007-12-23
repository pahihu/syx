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

Object subclass: #CStructGenerator
       instanceVariableNames: 'fields fieldSpecs'
       classVariableNames: ''!

!CStructGenerator class methodsFor: 'instance creation'!

new: anArrayOfFields
    ^self new fields: anArrayOfFields
! !

!CStructGenerator methodsFor: 'accessing'!

fields: anArrayOfFields
    fields := anArrayOfFields.
    fieldSpecs := self generateFieldSpecs
!

fields
    ^fields
!

fieldSpecs: anArrayOfFieldSpecs
    fieldSpecs := anArrayOfFieldSpecs
!

fieldSpecs
    ^fieldSpecs
! !

!CStructGenerator methodsFor: 'generator'!

generateFieldSpecs
    | specs |
    specs := fields collect: [ :field |
                    CStructFieldSpec new
                    type: (CStructFieldType fromFieldArray: field);
                    name: field last ].
    self alignFields: specs.
    ^specs
!

compileAccessorsOn: aClass
    fieldSpecs do: [ :spec |
          spec compileAccessorsOn: aClass ]
! !

!CStructGenerator methodsFor: 'alignment'!

alignFields: specs
    | prevField |
    specs ifNil: [ ^self ].
    specs collect: [ :spec |
          spec alignAccordingToPreviousField: prevField.
          prevField := spec ]
! !