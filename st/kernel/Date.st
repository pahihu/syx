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

!Date class methodsFor: 'initialize-release'!

initialize
    DayNames := IdentityDictionary new.
    MonthNames := IdentityDictionary new.
    self
        initializeDayNames;
        initializeMonthNames
!

initializeDayNames
    DayNames
        at: #monday put: 1; at: #mon put: 1;
        at: #tuesday put: 2; at: #tue put: 2;
        at: #wednesday put: 3; at: #wed put: 3;
        at: #thursday put: 4; at: #thu put: 4;
        at: #friday put: 5; at: #fri put: 5;
        at: #saturday put: 6; at: #sat put: 6;
        at: #sunday put: 7; at: #sun put: 7
!

initializeMonthNames
    MonthNames
        at: #january put: 1; at: #jan put: 1;
        at: #february put: 2; at: #feb put: 2;
        at: #march put: 3; at: #mar put: 3;
        at: #april put: 4; at: #apr put: 4;
        at: #may put: 5;
        at: #june put: 6; at: #jun put: 6;
        at: #julay put: 7; at: #jul put: 7;
        at: #august put: 8; at: #aug put: 8;
        at: #september put: 9; at: #sep put: 9;
        at: #october put: 10; at: #oct put: 10;
        at: #november put: 11; at: #nov put: 11;
        at: #december put: 12; at: #dec put: 12
! !

!Date class methodsFor: 'general inquiries'!

dayOfWeek: dayName
    "Answer the index in a week of the given dayName"
    ^DayNames at: dayName asString asLowercase asSymbol
!

nameOfDay: dayIndex
    "Answer the name of the day given its index in a week"
    ^#(#Monday #Tuesday #WednesDay #Thursday #Friday #Saturday #Sunday)
        at: dayIndex
!

indexOfMonth: monthName
    "Answer the index in a year of the given monthName"
    ^MonthNames at: monthName asString asLowercase asSymbol
!

nameOfMonth: monthIndex
    "Answer the name of the month given its index in a year"
    ^#(#January #February #March #April #May #June #July #August #September #October #November #December)
        at: monthIndex
!

daysInMonth: monthName forYear: yearInteger
    "Answer the number of days of the monthName in the given yearInteger"
    | monthIndex |
    monthIndex := self indexOfMonth: monthName.
    monthIndex = 2
        ifTrue: [
            (self leapYear: yearInteger) = 1
                ifTrue: [ ^29 ]
                ifFalse: [ ^28 ] ].
    ^#(31 nil 31 30 31 30 31 31 30 31 30 31)
        at: monthIndex
!

daysInYear: yearInteger
    "Answer the number of days in the given yearInteger"
    (self leapYear: yearInteger) = 1
        ifTrue: [ ^366 ]
        ifFalse: [ ^365 ]
!

leapYear: yearInteger
    "Answer 1 if the given yearInteger is leap otherwise 0"
    yearInteger \\ 400 = 0
        ifTrue: [ ^1 ]
        ifFalse: [
            yearInteger \\ 100 = 0
                ifTrue: [ ^0 ].
            yearInteger \\ 4 = 0
                ifTrue: [ ^1 ] ].
    ^0
!

dateAndTimeNow
    self notYetImplemented
! !

!Date methodsFor: 'accessing'!

days: days
    days := days
!

day: dayOfMonth
    day := dayOfMonth
!

month: monthIndexOfYear
    month := monthIndexOfYear
!

year: yearInteger
    year := yearInteger
!

day
    ^day
!

month
    ^month
!

year
    ^year
!

days
    ^days
! !
    
