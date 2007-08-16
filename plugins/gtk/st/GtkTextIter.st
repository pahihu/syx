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

!GtkTextIter class methodsFor: 'instance creation'!

primNew
    <cCall: 'Gtk_new__GtkTextIter' plugin: 'gtk'>
	self primitiveFailed
!

new
    ^self handle: self primNew
! !

!GtkTextIter methodsFor: 'primitives'!

buffer
    <cCall: 'Gtk_gtk_text_iter_get_buffer' plugin: 'gtk'>
	self primitiveFailed
!

primCopy
    <cCall: 'Gtk_gtk_text_iter_copy' plugin: 'gtk'>
	self primitiveFailed
!

copy
    ^GtkTextIter handle: self primCopy
!

free
    <cCall: 'Gtk_gtk_text_iter_free' plugin: 'gtk'>
	self primitiveFailed
!

offset
    <cCall: 'Gtk_gtk_text_iter_get_offset' plugin: 'gtk'>
	self primitiveFailed
!

line
    <cCall: 'Gtk_gtk_text_iter_get_line' plugin: 'gtk'>
	self primitiveFailed
!

lineOffset
    <cCall: 'Gtk_gtk_text_iter_get_line_offset' plugin: 'gtk'>
	self primitiveFailed
!

lineIndex
    <cCall: 'Gtk_gtk_text_iter_get_line_index' plugin: 'gtk'>
	self primitiveFailed
!

visibleLineIndex
    <cCall: 'Gtk_gtk_text_iter_get_visible_line_index' plugin: 'gtk'>
	self primitiveFailed
!

visibleLineOffset
    <cCall: 'Gtk_gtk_text_iter_get_visible_line_offset' plugin: 'gtk'>
	self primitiveFailed
!

char
    <cCall: 'Gtk_gtk_text_iter_get_char' plugin: 'gtk'>
	self primitiveFailed
!

sliceUpTo: textIter
    <cCall: 'Gtk_gtk_text_iter_get_slice' plugin: 'gtk'>
	self primitiveFailed
!

textUpTo: textIter
    <cCall: 'Gtk_gtk_text_iter_get_text' plugin: 'gtk'>
	self primitiveFailed
!

visibleSliceUpTo: textIter
    <cCall: 'Gtk_gtk_text_iter_get_visible_slice' plugin: 'gtk'>
	self primitiveFailed
!

visibleTextUpTo: textIter
    <cCall: 'Gtk_gtk_text_iter_get_visible_text' plugin: 'gtk'>
	self primitiveFailed
!

pixbuf
    <cCall: 'Gtk_gtk_text_iter_get_pixbuf' plugin: 'gtk'>
	self primitiveFailed
!

marks
    "TODO"
    self notYetImplemented
!

toggledTags: toggledOnBoolean
    "TODO"
    self notYetImplemented
!

childAnchor
    <cCall: 'Gtk_gtk_text_iter_get_buffer' plugin: 'gtk'>
	self primitiveFailed
!

beginsTag: aTag
    <cCall: 'Gtk_gtk_text_iter_get_buffer' plugin: 'gtk'>
	self primitiveFailed
!

endsTag: aTag
    <cCall: 'Gtk_gtk_text_iter_get_buffer' plugin: 'gtk'>
	self primitiveFailed
!

togglesTag: aTag
    <cCall: 'Gtk_gtk_text_iter_toggles_tag' plugin: 'gtk'>
	self primitiveFailed
!

hasTag: aTag
    <cCall: 'Gtk_gtk_text_iter_has_tag' plugin: 'gtk'>
	self primitiveFailed
!

tags
    "TODO"
!

editable: defaultSetting
    <cCall: 'Gtk_gtk_text_iter_editable' plugin: 'gtk'>
	self primitiveFailed
!

canInsert: defaultEditability
    <cCall: 'Gtk_gtk_text_iter_can_insert' plugin: 'gtk'>
	self primitiveFailed
!

startsWord
    <cCall: 'Gtk_gtk_text_iter_starts_word' plugin: 'gtk'>
	self primitiveFailed
!

endsWord
    <cCall: 'Gtk_gtk_text_iter_ends_word' plugin: 'gtk'>
	self primitiveFailed
!

insideWord
    <cCall: 'Gtk_gtk_text_iter_inside_word' plugin: 'gtk'>
	self primitiveFailed
!

startsLine
    <cCall: 'Gtk_gtk_text_iter_starts_line' plugin: 'gtk'>
	self primitiveFailed
!

endsLine
    <cCall: 'Gtk_gtk_text_iter_ends_line' plugin: 'gtk'>
	self primitiveFailed
!

startsSentence
    <cCall: 'Gtk_gtk_text_iter_starts_sequence' plugin: 'gtk'>
	self primitiveFailed
!

endsSentence
    <cCall: 'Gtk_gtk_text_iter_ends_sentence' plugin: 'gtk'>
	self primitiveFailed
!

insideSentence
    <cCall: 'Gtk_gtk_text_iter_inside_sentence' plugin: 'gtk'>
	self primitiveFailed
!

isCursorPosition
    <cCall: 'Gtk_gtk_text_iter_is_cursor_position' plugin: 'gtk'>
	self primitiveFailed
!

charsInLine
    <cCall: 'Gtk_gtk_text_iter_get_chars_in_line' plugin: 'gtk'>
	self primitiveFailed
!

bytesInLine
    <cCall: 'Gtk_gtk_text_iter_get_bytes_in_line' plugin: 'gtk'>
	self primitiveFailed
!

primAttributes: p
    <cCall: 'Gtk_gtk_text_iter_get_attributes' plugin: 'gtk'>
	self primitiveFailed
!

attributes
    | attr |
    attr := GtkTextAttributes new.
    self primAttributes: attr.
    ^attr
!

primLanguage
    <cCall: 'Gtk_gtk_text_iter_get_bytes_in_line' plugin: 'gtk'>
	self primitiveFailed
!

language
    ^PangoLanguage handle: self primLanguage
!

isEnd
    <cCall: 'Gtk_gtk_text_iter_get_bytes_in_line' plugin: 'gtk'>
	self primitiveFailed
!

isStart
    <cCall: 'Gtk_gtk_text_iter_get_bytes_in_line' plugin: 'gtk'>
	self primitiveFailed
!

forwardChar
    <cCall: 'Gtk_gtk_text_iter_forward_char' plugin: 'gtk'>
	self primitiveFailed
!

backwardChar
    <cCall: 'Gtk_gtk_text_iter_backward_char' plugin: 'gtk'>
	self primitiveFailed
!

forwardChars: count
    <cCall: 'Gtk_gtk_text_iter_forward_chars' plugin: 'gtk'>
	self primitiveFailed
!

backwardChars: count
    <cCall: 'Gtk_gtk_text_iter_backward_chars' plugin: 'gtk'>
	self primitiveFailed
!

forwardLine
    <cCall: 'Gtk_gtk_text_iter_forward_line' plugin: 'gtk'>
	self primitiveFailed
!

backwardLine
    <cCall: 'Gtk_gtk_text_iter_backward_line' plugin: 'gtk'>
	self primitiveFailed
!

forwardLines: count
    <cCall: 'Gtk_gtk_text_iter_forward_lines' plugin: 'gtk'>
	self primitiveFailed
!

backwardLines: count
    <cCall: 'Gtk_gtk_text_iter_backward_lines' plugin: 'gtk'>
	self primitiveFailed
!

forwardWordEnds: count
    <cCall: 'Gtk_gtk_text_iter_forward_word_ends' plugin: 'gtk'>
	self primitiveFailed
!

backwardWordStarts: count
    <cCall: 'Gtk_gtk_text_iter_backward_word_starts' plugin: 'gtk'>
	self primitiveFailed
!

forwardWordEnd
    <cCall: 'Gtk_gtk_text_iter_forward_word_end' plugin: 'gtk'>
	self primitiveFailed
!

backwardWordStart
    <cCall: 'Gtk_gtk_text_iter_backward_word_start' plugin: 'gtk'>
	self primitiveFailed
!

forwardCursorPosition
    <cCall: 'Gtk_gtk_text_iter_forward_cursor_position' plugin: 'gtk'>
	self primitiveFailed
!

backwardCursorPosition
    <cCall: 'Gtk_gtk_text_iter_backward_cursor_position' plugin: 'gtk'>
	self primitiveFailed
!

forwardCursorPositions: count
    <cCall: 'Gtk_gtk_text_iter_forward_cursor_positions' plugin: 'gtk'>
	self primitiveFailed
!

backwardCursorPositions: count
    <cCall: 'Gtk_gtk_text_iter_backward_cursor_positions' plugin: 'gtk'>
	self primitiveFailed
!

backwardSentenceStart
    <cCall: 'Gtk_gtk_text_iter_backward_sentence_start' plugin: 'gtk'>
	self primitiveFailed
!

backwardSentenceStarts: count
    <cCall: 'Gtk_gtk_text_iter_backward_sentence_starts' plugin: 'gtk'>
	self primitiveFailed
!

forwardSentenceEnd
    <cCall: 'Gtk_gtk_text_iter_forward_sentence_end' plugin: 'gtk'>
	self primitiveFailed
!

forwardSentenceEnds: count
    <cCall: 'Gtk_gtk_text_iter_forward_sentence_ends' plugin: 'gtk'>
	self primitiveFailed
!

forwardVisibleWordEnds: count
    <cCall: 'Gtk_gtk_text_iter_forward_visible_word_ends' plugin: 'gtk'>
	self primitiveFailed
!

backwardVisibleWordStarts: count
    <cCall: 'Gtk_gtk_text_iter_backward_visible_word_starts' plugin: 'gtk'>
	self primitiveFailed
!

forwardVisibleWordEnd
    <cCall: 'Gtk_gtk_text_iter_forward_visible_word_end' plugin: 'gtk'>
	self primitiveFailed
!

backwardVisibleWordStart
    <cCall: 'Gtk_gtk_text_iter_backward_visible_word_start' plugin: 'gtk'>
	self primitiveFailed
!

forwardVisibleCursorPosition
    <cCall: 'Gtk_gtk_text_iter_forward_visible_cursor_position' plugin: 'gtk'>
	self primitiveFailed
!

backwardVisibleCursorPosition
    <cCall: 'Gtk_gtk_text_iter_backward_visible_cursor_position' plugin: 'gtk'>
	self primitiveFailed
!

forwardVisibleCursorPositions: count
    <cCall: 'Gtk_gtk_text_iter_forward_visible_cursor_positions' plugin: 'gtk'>
	self primitiveFailed
!

backwardVisibleCursorPositions: count
    <cCall: 'Gtk_gtk_text_iter_backward_visible_cursor_positions' plugin: 'gtk'>
	self primitiveFailed
!

forwardVisibleLine
    <cCall: 'Gtk_gtk_text_iter_forward_visible_line' plugin: 'gtk'>
	self primitiveFailed
!

backwardVisibleLine
    <cCall: 'Gtk_gtk_text_iter_backward_visible_line' plugin: 'gtk'>
	self primitiveFailed
!

forwardVisibleLines: count
    <cCall: 'Gtk_gtk_text_iter_forward_visible_lines' plugin: 'gtk'>
	self primitiveFailed
!

backwardVisibleLines: count
    <cCall: 'Gtk_gtk_text_iter_backward_visible_lines' plugin: 'gtk'>
	self primitiveFailed
!

offset: charOffset
    <cCall: 'Gtk_gtk_text_iter_set_offset' plugin: 'gtk'>
	self primitiveFailed
!

line: lineNumber
    <cCall: 'Gtk_gtk_text_iter_set_line' plugin: 'gtk'>
	self primitiveFailed
!

lineOffset: charOnLine
    <cCall: 'Gtk_gtk_text_iter_set_line_offset' plugin: 'gtk'>
	self primitiveFailed
!

lineIndex: byteOnLine
    <cCall: 'Gtk_gtk_text_iter_set_line_index' plugin: 'gtk'>
	self primitiveFailed
!

visibleLineIndex: byteOnLine
    <cCall: 'Gtk_gtk_text_iter_set_visible_line_index' plugin: 'gtk'>
	self primitiveFailed
!

visibleLineOffset: charOnLine
    <cCall: 'Gtk_gtk_text_iter_set_visible_line_offset' plugin: 'gtk'>
	self primitiveFailed
!

forwardToEnd
    <cCall: 'Gtk_gtk_text_iter_forward_to_end' plugin: 'gtk'>
	self primitiveFailed
!

forwardToLineEnd
    <cCall: 'Gtk_gtk_text_iter_forward_to_line_end' plugin: 'gtk'>
	self primitiveFailed
!

forwardToTagToggle: aTag
    <cCall: 'Gtk_gtk_text_iter_forward_to_tag_toggle' plugin: 'gtk'>
	self primitiveFailed
!

backwardToTagToggle: aTag
    <cCall: 'Gtk_gtk_text_iter_backward_to_tag_toggle' plugin: 'gtk'>
	self primitiveFailed
!

forwardFindChar
    "TODO"
    self notYetImplemented
!

backwardFindChar
    "TODO"
    self notYetImplemented
!

forwardSearch: aString flags: flags from: startIter to: endIter
    <cCall: 'Gtk_gtk_text_iter_forward_search' plugin: 'gtk'>
	self primitiveFailed
!

backwardSearch: aString flags: flags from: startIter to: endIter
    <cCall: 'Gtk_gtk_text_iter_backward_search' plugin: 'gtk'>
	self primitiveFailed
!

= textIter
    <cCall: 'Gtk_gtk_text_iter_equal' plugin: 'gtk'>
	self primitiveFailed
!

compare: textIter
    <cCall: 'Gtk_gtk_text_iter_compare' plugin: 'gtk'>
	self primitiveFailed
!

< textIter
    ^(self compare: textIter) < 0
!

> textIter
    ^(self compare: textIter) > 0
!

between: startIter and: endIter
    <cCall: 'Gtk_gtk_text_iter_in_range' plugin: 'gtk'>
	self primitiveFailed
!

orderWith: textIter
    <cCall: 'Gtk_gtk_text_iter_order' plugin: 'gtk'>
	self primitiveFailed
! !
