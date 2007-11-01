"Thanks to Dominic Letz for this example"

Object subclass: #WebBrowser
        instanceVariableNames: ''
        classVariableNames: ''!

!WebBrowser class methodsFor: 'instance creation'!

run: queryString
    ^self new run: queryString; yourself
! !

!WebBrowser methodsFor: 'as yet unclassified'!

showHead
    Transcript
	show: 'Content-Type: text/html'; cr; cr;
	show: '<html><head><title>proto code browser</title></head><body>'; cr;
	show: '<table border="2" width="100%"><tr>'
!

showClasses
    '<td width="20%">' printNl.
    (Smalltalk select: [ :ea | ea isClass ])
	do: [ :ea |
	    ('<a href="?', ea printString, '">', ea printString, '</a><br/>') printNl ].
    '</td>' printNl
!

showMethodsOf: aClass
    '<table>' printNl.
    aClass methodDictionary keysDo: [ :key |
	('<tr><td><a href="?', aClass printString, '&', key asString printString, '">') printNl.
	(key asString printString, '</td></tr>') printNl ].
    '</table>' printNl.
!

showParentOf: aClass
    ('Parent: <a href="?', aClass superclass printString, '">',
	 aClass superclass printString, '</a>') printNl.
!

showMembersOf: aClass
    'Members:<br/>' printNl.
    '<ul>' printNl.
    aClass instanceVariableNames do: [:name |
	('<li>', name printString, '</li>') printNl ].
    '</ul>' printNl.
!

inspectClass: aClass
    aClass ifNil: [ ^self ].

    '<td valign="top">' printNl.

    self showMethodsOf: aClass.
    '<hr />' printNl.  
    self showParentOf: aClass.
    '<br />' printNl.
    self showMembersOf: aClass.

    '</td>' printNl
!

inspectMethod: aMethod
    aMethod isNil ifFalse: [
	'<td valign="top">' printNl.
	('<pre>', aMethod text, '</pre>') printNl.
	'</td>' printNl ]
!
    
run: queryString
    | args classes class method |
    self showHead.
    
    args := #().
    args := queryString
	ifNotNil: [ queryString subStrings: '&' ].
    args do: [:each |
	(each printString, '<br/>') printNl ].
    
    classes := Object allSubclasses.
    args notEmpty ifTrue: [
	class := Smalltalk at: args first asSymbol.
	(args size > 1) ifTrue: [
	    method := class methodDictionary at: args second asSymbol ] ].
    
    
    self showClasses.
    self inspectClass: class.
    self inspectMethod: method.
    
    '</tr></table>' printNl.
    '<p><small>Mailme: dominic.letz AT berlin.de</small></p>' printNl.
    '</body></html>' printNl.
! !
