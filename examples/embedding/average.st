| avgAndSum |
avgAndSum := Smalltalk cCall: 'average' withArguments: #(10 20 30 40 50).
('The average is ', avgAndSum first printString) displayNl.
('The sum is ', avgAndSum second printString) displayNl
