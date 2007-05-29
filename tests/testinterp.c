#include "../syx/syx.h"

inline SyxInstance *_interpret (char *text)
{
  SyxParser *parser;
  SyxLexer *lexer;
  SyxMethod *method;
  SyxMethodContext *context;
  SyxProcess *process;
  GError *error = NULL;
  static GTimer *timer = NULL;

  if (!timer)
    timer = g_timer_new ();

  lexer = syx_lexer_new (text);						
  method = syx_method_new ();						
  parser = syx_parser_new (lexer, method, NULL, FALSE, NULL);		
  g_assert (syx_parser_parse (parser, &error) == TRUE);			
  context = syx_method_context_new (method, syx_nil, NULL, NULL);	
  process = syx_process_new (context);

  g_timer_start (timer);
  syx_process_execute_blocking (process);
  g_timer_stop (timer);
  g_print("Time elapsed: %f\n", g_timer_elapsed (timer, NULL));

  return process->last_returned_object;
}

int
main (int argc, char *argv[])
{
  SyxInstance *ret_obj;

  syx_init ("..");
  syx_build_basic ();

  g_print ("- Test assignment\n");
  ret_obj = _interpret ("method | a | ^a := 123");
  g_assert (SYX_SMALL_INTEGER(ret_obj)->value == 123);

  g_print ("- Test single messages\n");
  ret_obj = _interpret ("method ^Object class class memoryAddress");
  g_assert ((long)syx_metaclass_class == SYX_SMALL_INTEGER(ret_obj)->value);

  g_print ("- Test evaluating a simple block\n");
  ret_obj = _interpret ("method ^[321] value");
  g_assert (SYX_SMALL_INTEGER(ret_obj)->value == 321);

  g_print ("- Test block stack return\n");
  ret_obj = _interpret ("method [^321] value");
  g_assert (SYX_SMALL_INTEGER(ret_obj)->value == 321);

  g_print ("- Test a block with a single argument\n");
  ret_obj = _interpret ("method [:s | ^s] value: 123");
  g_assert (SYX_SMALL_INTEGER(ret_obj)->value == 123);

  g_print ("- Test temporary scope in blocks\n");
  ret_obj = _interpret ("method | tmp | tmp := 123. [ | tmp | tmp := 321 ] value. ^tmp");
  g_assert (SYX_SMALL_INTEGER(ret_obj)->value == 123);

  g_print ("- Another test for temporary scope in blocks\n");
  ret_obj = _interpret ("method | tmp | tmp := 123. [ tmp := 321 ] value. ^tmp");
  g_assert (SYX_SMALL_INTEGER(ret_obj)->value == 321);

  g_print ("- Test nested blocks with arguments\n");
  ret_obj = _interpret ("method ^[ :s | [ :s | s ] value: 321] value: 123");
  g_assert (SYX_SMALL_INTEGER(ret_obj)->value == 321);

  g_print ("- Another text for nested blocks and arguments\n");
  ret_obj = _interpret ("method ^[ :s | [ s] value] value: 123");
  g_assert (SYX_SMALL_INTEGER(ret_obj)->value == 123);

  g_print ("- Test ifTrue\n");
  ret_obj = _interpret ("method | var | var := 123. var = 321 ifTrue: [^false]. var = 123 ifTrue: [^true]");
  g_assert (SYX_IS_TRUE (ret_obj));

  g_print ("- Test ifFalse\n");
  ret_obj = _interpret ("method ^false ifTrue: [ 123 ] ifFalse: [ 321 ]");
  g_assert (SYX_SMALL_INTEGER(ret_obj)->value == 321);

  g_print ("- Test temporaries in optimized blocks\n");
  ret_obj = _interpret ("method | tmp | tmp := 123. true ifTrue: [ | tmp | tmp := 321 ]. ^tmp");
  g_assert (SYX_SMALL_INTEGER(ret_obj)->value == 123);

  g_print ("- Test exception handling\n");
  ret_obj = _interpret ("method ^[Signal signal] on: Signal do: [:ex | true]");
  g_assert (SYX_IS_TRUE (ret_obj));

  g_print ("- Test resuming\n");
  ret_obj = _interpret ("method ^[Signal signal. 123] on: Signal do: [ :ex | ex resume. 321]");
  g_assert (SYX_SMALL_INTEGER(ret_obj)->value == 123);

  g_print ("- Test pass\n");
  ret_obj = _interpret ("method ^[[Error signal. 123] on: Error do: [ :ex | ex pass. 213]] on: Exception do: [:ex | 321]");
  g_assert (SYX_SMALL_INTEGER(ret_obj)->value == 321);

  g_print ("- Test ensuring\n");
  ret_obj = _interpret ("method [Signal signal. 123] ensure: [^321]. 213");
  g_assert (SYX_SMALL_INTEGER(ret_obj)->value == 321);

  g_print ("- Test loops\n");
  ret_obj = _interpret ("method | var | var := 0. 1 to: 500 do: [:i | var := i]. ^var");
  g_assert (SYX_SMALL_INTEGER(ret_obj)->value == 500);

  return 0;
}
