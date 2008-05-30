"Thanks to Dominic Letz for this example"

Object subclass: #WebBrowser
        instanceVariableNames: ''
        classVariableNames: ''!

!WebBrowser class methodsFor: 'instance creation'!

run
    ^self new run: (Smalltalk environmentVariableAt: 'QUERY_STRING'); yourself
! !

!WebBrowser methodsFor: 'as yet unclassified'!

showHead
    Transcript
	show: 'Content-Type: text/html'; cr; cr;
	show: '<html><head><title>proto code browser</title></head><body>'; cr;
	show: '<table border="2" width="100%"><tr>'
!

showClasses
    '<td width="20%">' displayNl.
    (Smalltalk select: [ :ea | ea isClass ])
	do: [ :ea |
	    ('<a href="?', ea displayString, '">', ea displayString, '</a><br/>') displayNl ].
    '</td>' displayNl
!

showMethodsOf: aClass
    '<table>' displayNl.
    aClass methodDictionary keysDo: [ :key |
	('<tr><td><a href="?', aClass displayString, '&', key asString displayString, '">') displayNl.
	(key asString displayString, '</td></tr>') displayNl ].
    '</table>' displayNl.
!

showParentOf: aClass
    ('Parent: <a href="?', aClass superclass displayString, '">',
	 aClass superclass displayString, '</a>') displayNl.
!

showMembersOf: aClass
    'Members:<br/>' displayNl.
    '<ul>' displayNl.
    aClass instanceVariableNames do: [:name |
	('<li>', name displayString, '</li>') displayNl ].
    '</ul>' displayNl.
!

inspectClass: aClass
    aClass ifNil: [ ^self ].

    '<td valign="top">' displayNl.

    self showMethodsOf: aClass.
    '<hr />' displayNl.  
    self showParentOf: aClass.
    '<br />' displayNl.
    self showMembersOf: aClass.

    '</td>' displayNl
!

inspectMethod: aMethod
    aMethod isNil ifFalse: [
	'<td valign="top">' displayNl.
	('<pre>', aMethod text, '</pre>') displayNl.
	'</td>' displayNl ]
!
    
run: queryString
    | args classes class method |
    self showHead.
    
    args := #().
    queryString
	ifNotNil: [ args := queryString subStrings: '&' ].
    args do: [:each |
	(each displayString, '<br/>') displayNl ].
    
    classes := Object allSubclasses.
    args notEmpty ifTrue: [
	class := Smalltalk at: args first asSymbol.
	(args size > 1) ifTrue: [
	    method := class methodDictionary at: args second asSymbol ] ].
    
    
    self showClasses.
    self inspectClass: class.
    self inspectMethod: method.
    
    '</tr></table>' displayNl.
    '<p><small>Mailme: dominic.letz AT berlin.de</small></p>' displayNl.
    '</body></html>' displayNl.
! !
