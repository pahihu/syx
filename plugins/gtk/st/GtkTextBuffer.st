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

!GtkTextBuffer class methodsFor: 'instance creation'!

primNew: aTextTagTable
    <cCall: 'Gtk_gtk_text_buffer_new' plugin: 'gtk'>
	self primitiveFailed
!

new: aTextTagTable
    ^self handle: (self primNew: aTextTagTable)
!

new
    ^self new: nil
! !

!GtkTextBuffer methodsFor: 'primitives'!

lineCount
    <cCall: 'Gtk_gtk_text_buffer_get_line_count' plugin: 'gtk'>
	self primitiveFailed
!

charCount
    <cCall: 'Gtk_gtk_text_buffer_get_char_count' plugin: 'gtk'>
	self primitiveFailed
!

primTagTable
    <cCall: 'Gtk_gtk_text_buffer_get_tag_table' plugin: 'gtk'>
	self primitiveFailed
!

tagTable
    ^GtkTextTagTable handle: (self primTagTable)
!

primInsert: iter text: text len: len
    <cCall: 'Gtk_gtk_text_buffer_insert' plugin: 'gtk'>
	self primitiveFailed
!

at: aTextIter insert: aString
    ^self primInsert: aTextIter text: aString len: aString size
!

primInsert: text len: len
    <cCall: 'Gtk_gtk_text_buffer_insert_at_cursor' plugin: 'gtk'>
	self primitiveFailed
!

insert: aString
    ^self primInsert: aString len: aString size
!

primInsert: iter text: text len: len editable: editable
    <cCall: 'Gtk_gtk_text_buffer_insert_interactive' plugin: 'gtk'>
	self primitiveFailed
!

at: aTextIter interactiveInsert: aString defaultEditable: aBoolean
    ^self primInsert: aTextIter text: aString len: aString size editable: aBoolean
!

primInsert: text len: len editable: editable
    <cCall: 'Gtk_gtk_text_buffer_insert_interactive_at_cursor' plugin: 'gtk'>
	self primitiveFailed
!

interactiveInsert: aString defaultEditable: aBoolean
    ^self primInsert: aString len: aString size editable: aBoolean
!

insertAt: iter from: startIter to: stopIter
    <cCall: 'Gtk_gtk_text_buffer_insert_range' plugin: 'gtk'>
	self primitiveFailed
!

interactiveInsertAt: iter from: startIter to: stopIter
    <cCall: 'Gtk_gtk_text_buffer_insert_range_interactive' plugin: 'gtk'>
	self primitiveFailed
!

removeFrom: startIter to: endIter
    <cCall: 'Gtk_gtk_text_buffer_delete' plugin: 'gtk'>
	self primitiveFailed
!

interactiveRemoveFrom: startIter to: endIter defaultEditable: aBoolean
    <cCall: 'Gtk_gtk_text_buffer_delete_interactive' plugin: 'gtk'>
	self primitiveFailed
!

at: aTextIter interactiveBackspace: interactiveBoolean defaultEditable: editableBoolean
    <cCall: 'Gtk_gtk_text_buffer_backspace' plugin: 'gtk'>
	self primitiveFailed
!

primText: aString len: len
    <cCall: 'Gtk_gtk_text_buffer_set_text' plugin: 'gtk'>
	self primitiveFailed
!

text: aString
    ^self primText: aString len: aString size
!

textFrom: startIter to: endIter includeHiddenChars: aBoolean
    <cCall: 'Gtk_gtk_text_buffer_get_text' plugin: 'gtk'>
	self primitiveFailed
!

sliceFrom: startIter to: endIter includeHiddenChars: aBoolean
    <cCall: 'Gtk_gtk_text_buffer_get_slice' plugin: 'gtk'>
	self primitiveFailed
!

at: textIter insertPixbuf: aGdkPixbuf
    <cCall: 'Gtk_gtk_text_buffer_insert_pixbuf' plugin: 'gtk'>
	self primitiveFailed
!

at: textIter insertChildAnchor: textChildAnchor
    <cCall: 'Gtk_gtk_text_buffer_insert_child_anchor' plugin: 'gtk'>
	self primitiveFailed
!

primNewChildAnchorAt: textIter
    <cCall: 'Gtk_gtk_text_buffer_create_child_anchor' plugin: 'gtk'>
	self primitiveFailed
!

newChildAnchorAt: textIter
    ^GtkTextChildAnchor handle: (self primNewChildAnchorAt: textIter)
!

primNewMark: markName at: textIter leftGravity: aBoolean
    <cCall: 'Gtk_gtk_text_buffer_create_mark' plugin: 'gtk'>
	self primitiveFailed
!

newMark: markName at: textIter leftGravity: aBoolean
    ^GtkTextMark handle: (self primNewMark: markName at: textIter leftGravity: aBoolean)
!

moveMark: textMark to: textIter
    <cCall: 'Gtk_gtk_text_buffer_move_mark' plugin: 'gtk'>
	self primitiveFailed
!

moveMarkNamed: markName to: textIter
    <cCall: 'Gtk_gtk_text_buffer_move_mark_by_name' plugin: 'gtk'>
	self primitiveFailed
!

removeMark: textMark
    <cCall: 'Gtk_gtk_text_buffer_delete_mark' plugin: 'gtk'>
	self primitiveFailed
!

removeMarkNamed: markName
    <cCall: 'Gtk_gtk_text_buffer_delete_mark_by_name' plugin: 'gtk'>
	self primitiveFailed
!

primMarkNamed: markName
    <cCall: 'Gtk_gtk_text_buffer_get_mark' plugin: 'gtk'>
	self primitiveFailed
!

markNamed: markName
    ^GtkTextMark handle: markName
!

primInsert
    <cCall: 'Gtk_gtk_text_buffer_get_insert' plugin: 'gtk'>
	self primitiveFailed
!

insert
    ^GtkTextMark handle: self primInsert
!

primSelectionBound
    <cCall: 'Gtk_gtk_text_buffer_get_selection_bound' plugin: 'gtk'>
	self primitiveFailed
!

selectionBound
    ^GtkTextMark handle: self primSelectionBound
!

hasSelection
    <cCall: 'Gtk_gtk_text_buffer_get_has_selection' plugin: 'gtk'>
	self primitiveFailed
!

placeCursorAt: textIter
    <cCall: 'Gtk_gtk_text_buffer_place_cursor' plugin: 'gtk'>
	self primitiveFailed
!

selectFrom: insIter to: boundIter
    <cCall: 'Gtk_gtk_text_buffer_select_range' plugin: 'gtk'>
	self primitiveFailed
!

applyTag: textTag from: startIter to: endIter
    <cCall: 'Gtk_gtk_text_buffer_apply_tag' plugin: 'gtk'>
	self primitiveFailed
!

removeTag: textTag from: startIter to: endIter
    <cCall: 'Gtk_gtk_text_buffer_remove_tag' plugin: 'gtk'>
	self primitiveFailed
!

applyTagNamed: tagName from: startIter to: endIter
    <cCall: 'Gtk_gtk_text_buffer_apply_tag_by_name' plugin: 'gtk'>
	self primitiveFailed
!

removeTagNamed: tagName from: startIter to: endIter
    <cCall: 'Gtk_gtk_text_buffer_remove_tag_by_name' plugin: 'gtk'>
	self primitiveFailed
!

removeAllTagsFrom: startIter to: endIter
    <cCall: 'Gtk_gtk_text_buffer_remove_all_tags' plugin: 'gtk'>
	self primitiveFailed
!

primCreateTag: tagName unused: unused
    <cCall: 'Gtk_gtk_text_buffer_create_tag' plugin: 'gtk'>
	self primitiveFailed
!

newTag: tagName
    ^GtkTextTag handle: (self primCreateTag: tagName unused: nil)
!

primIter: iter atLine: lineNumber offset: charOffset
    <cCall: 'Gtk_gtk_text_buffer_get_iter_at_line_offset' plugin: 'gtk'>
	self primitiveFailed
!

iterAtLine: lineNumber offset: charOffset
    | iter |
    iter := GtkTextIter new.
    self primIter: iter atLine: lineNumber offset: charOffset.
    ^iter
!

primIter: iter atOffset: charOffset
    <cCall: 'Gtk_gtk_text_buffer_get_iter_at_offset' plugin: 'gtk'>
	self primitiveFailed
!

iterAtOffset: charOffset
    | iter |
    iter := GtkTextIter new.
    self primIter: iter atOffset: charOffset.
    ^iter
!

primIter: iter atLine: lineNumber index: byteIndex
    <cCall: 'Gtk_gtk_text_buffer_get_iter_at_line_index' plugin: 'gtk'>
	self primitiveFailed
!

iterAtLine: lineNumber index: byteIndex
    | iter |
    iter := GtkTextIter new.
    self primIter: iter atLine: lineNumber index: byteIndex.
    ^iter
!

primIter: iter atMark: textMark
    <cCall: 'Gtk_gtk_text_buffer_get_iter_at_mark' plugin: 'gtk'>
	self primitiveFailed
!

iterAtMark: textMark
    | iter |
    iter := GtkTextIter new.
    self primIter: iter atMark: textMark.
    ^iter
!

primIter: iter atChildAnchor: textChildAnchor
    <cCall: 'Gtk_gtk_text_buffer_get_iter_at_child_anchor' plugin: 'gtk'>
	self primitiveFailed
!

iterAtChildAnchor: textChildAnchor
    | iter |
    iter := GtkTextIter new.
    self primIter: iter atChildAnchor: textChildAnchor.
    ^iter
!

primStartIter: iter
    <cCall: 'Gtk_gtk_text_buffer_get_start_iter' plugin: 'gtk'>
	self primitiveFailed
!

startIter
    | iter |
    iter := GtkTextIter new.
    self primStartIter: iter.
    ^iter
!

primEndIter: iter
    <cCall: 'Gtk_gtk_text_buffer_get_end_iter' plugin: 'gtk'>
	self primitiveFailed
!

endIter
    | iter |
    iter := GtkTextIter new.
    self primEndIter: iter.
    ^iter
!

primGetBounds: start end: end
    <cCall: 'Gtk_gtk_text_buffer_get_bounds' plugin: 'gtk'>
	self primitiveFailed
!

bounds
    | iter1 iter2 |
    iter1 := GtkTextIter new.
    iter2 := GtkTextIter new.
    self primGetBounds: iter1 end: iter2.
    ^{iter1. iter2}
!

modified
    <cCall: 'Gtk_gtk_text_buffer_get_modified' plugin: 'gtk'>
	self primitiveFailed
!

modified: aBoolean
    <cCall: 'Gtk_gtk_text_buffer_set_modified' plugin: 'gtk'>
	self primitiveFailed
!

removeSelection: interactiveBoolean defaultEditable: editableBoolean
    <cCall: 'Gtk_gtk_text_buffer_delete_selection' plugin: 'gtk'>
	self primitiveFailed
!

pasteClipboard: aClipboard at: textIter defaultEditable: aBoolean
    <cCall: 'Gtk_gtk_text_buffer_paste_clipboard' plugin: 'gtk'>
	self primitiveFailed
!

copyClipboard: aClipboard
    <cCall: 'Gtk_gtk_text_buffer_copy_clipboard' plugin: 'gtk'>
	self primitiveFailed
!

cutClipboard: aClipboard defaultEditable: aBoolean
    <cCall: 'Gtk_gtk_text_buffer_cut_clipboard' plugin: 'gtk'>
	self primitiveFailed
!

primSelectionBounds: start end: end
    <cCall: 'Gtk_gtk_text_buffer_get_selection_bounds' plugin: 'gtk'>
	self primitiveFailed
!

selectionBounds
    | start end |
    start := GtkTextIter new.
    end := GtkTextIter new.
    self primSelectionBounds: start end: end.
    ^{start. end}
!

beginUserAction
    <cCall: 'Gtk_gtk_text_buffer_begin_user_action' plugin: 'gtk'>
	self primitiveFailed
!

endUserAction
    <cCall: 'Gtk_gtk_text_buffer_end_user_action' plugin: 'gtk'>
	self primitiveFailed
!

addSelectionClipboard: aClipboard
    <cCall: 'Gtk_gtk_text_buffer_add_selection_clipboard' plugin: 'gtk'>
	self primitiveFailed
!

removeSelectionClipboard: aClipboard
    <cCall: 'Gtk_gtk_text_buffer_remove_selection_clipboard' plugin: 'gtk'>
	self primitiveFailed
! !
