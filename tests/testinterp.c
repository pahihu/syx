#include <assert.h>
#include <stdio.h>
#include "../syx/syx.h"

inline SyxObject 
*_interpret (syx_symbol text)
{
  SyxParser *parser;
  SyxLexer *lexer;
  SyxObject *method, *context, *process;
  GError *error = NULL;
  static GTimer *timer = NULL;

  if (!timer)
    timer = g_timer_new ();

  lexer = syx_lexer_new (text);						
  method = syx_method_new ();						
  parser = syx_parser_new (lexer, method, NULL);
  assert (syx_parser_parse (parser, &error) == TRUE);
  syx_parser_free (parser, FALSE);
  syx_lexer_free (lexer, FALSE);
  context = syx_method_context_new (SYX_NIL, method, SYX_NIL, syx_array_new (0, NULL));
  process = syx_process_new (context);

  g_timer_start (timer);
  syx_process_execute_blocking (process);
  g_timer_stop (timer);
  printf ("Time elapsed: %f\n\n", g_timer_elapsed (timer, NULL));

  return SYX_PROCESS_RETURNED_OBJECT(process);
}

int
main (int argc, char *argv[])
{
  SyxObject *ret_obj;

  syx_init ("..");
  syx_build_basic ();

  puts ("- Test assignment");
  ret_obj = _interpret ("method | a | ^a := 123");
  assert (SYX_SMALL_INTEGER(ret_obj) == 123);

  puts ("- Test single messages");
  ret_obj = _interpret ("method ^Object class class hash");
  assert (syx_metaclass_class == ret_obj);

  puts ("- Test evaluating a simple block");
  ret_obj = _interpret ("method ^[321] value");
  assert (SYX_SMALL_INTEGER(ret_obj) == 321);

  puts ("- Test block stack return");
  ret_obj = _interpret ("method [^321] value");
  assert (SYX_SMALL_INTEGER(ret_obj) == 321);

  puts ("- Test a block with a single argument");
  ret_obj = _interpret ("method [:s | ^s] value: 123");
  assert (SYX_SMALL_INTEGER(ret_obj) == 123);

  puts ("- Test temporary scope in blocks");
  ret_obj = _interpret ("method | tmp | tmp := 123. [ | tmp | tmp := 321 ] value. ^tmp");
  assert (SYX_SMALL_INTEGER(ret_obj) == 123);

  puts ("- Another test for temporary scope in blocks");
  ret_obj = _interpret ("method | tmp | tmp := 123. [ tmp := 321 ] value. ^tmp");
  assert (SYX_SMALL_INTEGER(ret_obj) == 321);

  puts ("- Test nested blocks with arguments");
  ret_obj = _interpret ("method ^[ :s | [ :s | s ] value: 321] value: 123");
  assert (SYX_SMALL_INTEGER(ret_obj) == 321);
  
  puts ("- Another text for nested blocks and arguments");
  ret_obj = _interpret ("method ^[ :s | [ s] value] value: 123");
  assert (SYX_SMALL_INTEGER(ret_obj) == 123);

  puts ("- Test ifTrue");
  ret_obj = _interpret ("method | var | var := 123. var = 321 ifTrue: [^false]. var = 123 ifTrue: [^true]");
  assert (SYX_IS_TRUE (ret_obj));

  puts ("- Test ifFalse");
  ret_obj = _interpret ("method ^false ifTrue: [ 123 ] ifFalse: [ 321 ]");
  assert (SYX_SMALL_INTEGER(ret_obj) == 321);

  puts ("- Test temporaries in optimized blocks");
  ret_obj = _interpret ("method | tmp | tmp := 123. true ifTrue: [ | tmp | tmp := 321 ]. ^tmp");
  assert (SYX_SMALL_INTEGER(ret_obj) == 123);

  puts ("- Test exception handling");
  ret_obj = _interpret ("method ^[Signal signal] on: Signal do: [:ex | true]");
  assert (SYX_IS_TRUE (ret_obj));

  puts ("- Test resuming");
  ret_obj = _interpret ("method ^[Signal signal. 123] on: Signal do: [ :ex | ex resume. 321]");
  assert (SYX_SMALL_INTEGER(ret_obj) == 123);

  puts ("- Test pass");
  ret_obj = _interpret ("method ^[[Error signal. 123] on: Error do: [ :ex | ex pass. 213]] on: Exception do: [:ex | 321]");
  assert (SYX_SMALL_INTEGER(ret_obj) == 321);

  puts ("- Test ensuring");
  ret_obj = _interpret ("method [Signal signal. 123] ensure: [^321]. 213");
  assert (SYX_SMALL_INTEGER(ret_obj) == 321);

  puts ("- Test loops");
  ret_obj = _interpret ("method | var | var := 0. 1 to: 500 do: [:i | var := i]. ^var");
  assert (SYX_SMALL_INTEGER(ret_obj) == 500);

  return 0;
}
