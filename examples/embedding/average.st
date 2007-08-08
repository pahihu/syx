| avgAndSum |
avgAndSum := Smalltalk cCall: 'average' withArguments: #(10 20 30 40 50).
('The average is ', avgAndSum first printString) printNl.
('The sum is ', avgAndSum second printString) printNl
