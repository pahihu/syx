#include <syx/syx.h>
#include <readline/readline.h>
#include <readline/history.h>

SYX_FUNC_PRIMITIVE(Readline_readline)
{
  char *s = readline (SYX_OBJECT_STRING(es->message_arguments[0]));
  SYX_PRIM_RETURN(syx_string_new (s));
}

SYX_FUNC_PRIMITIVE(Readline_addHistory)
{
  add_history (SYX_OBJECT_STRING(es->message_arguments[0]));
  SYX_PRIM_RETURN(es->message_receiver);
}

syx_bool
syx_plugin_initialize (void)
{
  return TRUE;
}

void
syx_plugin_finalize (void)
{
}
