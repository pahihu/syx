#!/usr/bin/env syx
| choice menu |

'Smalltalk YX simple example menu:' displayNl.
menu := ['1 - Reverse a string' displayNl.
         '2 - Do a math operation with 2 numbers' displayNl.
         'q - Quit' displayNl.
         'Choice: ' display.
          stdout flush ].

choice := nil.
[ menu value. (choice := stdin next asLowercase) = $q ]
    whileFalse: [
	"Get rid of \n character"
	stdin next.
	choice
	    caseOf: {

		[$1] -> [
		    | s |
		    s := (stdin next: 1024) copyWithout: Character nl.
		    s reverse displayNl ].

		[$2] -> [
		    | n1 n2 op |
		    'First number: ' display.
		    n1 := Number readFrom: stdin.
		    'Operation (+, /, -, *, <, >, =, ...): ' display.
		    op := ((stdin next: 1024) copyWithout: Character nl) asSymbol.
		    'Second number: ' display.
		    n2 := Number readFrom: stdin.
		    ('Result: ', (n1 perform: op with: n2) displayString) displayNl ].

		}
	    otherwise: [ 'Not a valid choice' displayNl ].
	Transcript cr ].

'See you soon. Bye.' displayNl
