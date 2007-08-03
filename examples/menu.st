| choice menu |

'Smalltalk YX simple example menu:' printNl.
menu := ['1 - Reverse a string' printNl.
	 '2 - Do a math operation with 2 numbers' printNl.
	 'q - Quit' printNl.
	 'Choice: ' print].

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
		    s reverse printNl ].

		[$2] -> [
		    | n1 n2 op |
		    'First number: ' print.
		    n1 := Number readFrom: stdin.
		    'Operation (+, /, -, *, <, >, =, ...): ' print.
		    op := ((stdin next: 1024) copyWithout: Character nl) asSymbol.
		    'Second number: ' print.
		    n2 := Number readFrom: stdin.
		    ('Result: ', (n1 perform: op with: n2) printString) printNl ].

		}
	    otherwise: [ 'Not a valid choice' printNl ].
	Transcript cr ].

'See you soon. Bye.' printNl
