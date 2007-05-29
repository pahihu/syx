
#ifdef HAVE_CONFIG_H
  #include <config.h>
#endif

#include <string.h>
#include "syx-types.h"
#include "syx-object.h"
#include "syx-init.h"
#include "syx-utils.h"
#include "syx-parser.h"
#include "syx-lexer.h"
#include "syx-scheduler.h"

G_BEGIN_DECLS

/* A cold parser */

#define IS_EXLMARK(token) (token.type == SYX_TOKEN_BINARY && !g_strcasecmp (g_value_get_string (token.value), "!"))

GQuark
syx_parser_error_quark (void)
{
  return g_quark_from_static_string ("syx-parser-error-quark");
}

static syx_bool
parse_class (SyxLexer *lexer, GError **error)
{
  SyxToken token = syx_lexer_get_last_token (lexer);
  SyxObject *superclass, *subclass;
  syx_symbol temp_str;
  syx_string subclass_name;
  syx_bool existing_class = TRUE;
  syx_string *splitted_names;
  SyxObject *inst_vars;
  SyxObject *inst_vars_temp[256];
  syx_varsize inst_vars_size, super_inst_vars_size;

  if (token.type != SYX_TOKEN_NAME_CONST)
    {
      if (error)
	*error = g_error_new (SYX_PARSER_ERROR,
			      SYX_PARSER_ERROR_SYNTAX,
			      "Expected a name constant");
      return FALSE;
    }

  temp_str = g_value_get_string (token.value);
  if (!g_strcasecmp (temp_str, "nil"))
    superclass = SYX_NIL;
  else
    {
      superclass = syx_globals_at (temp_str);

      if (SYX_IS_NIL (superclass))
	{
	  if (error)
	    *error = g_error_new (SYX_PARSER_ERROR,
				  SYX_PARSER_ERROR_LOOKUP,
				  "Unknown class: %s", temp_str);
	  return FALSE;
	}
    }

  syx_lexer_next_token (lexer, &token);
  if (!(token.type == SYX_TOKEN_NAME_COLON && !g_strcasecmp (temp_str, "subclass:")))
    {
      if (error)
	*error = g_error_new (SYX_PARSER_ERROR,
			      SYX_PARSER_ERROR_SYNTAX,
			      "Expected #subclass:");
      return FALSE;
    }

  syx_lexer_next_token (lexer, &token);
  if (token.type != SYX_TOKEN_SYM_CONST)
    {
      if (error)
	*error = g_error_new (SYX_PARSER_ERROR,
			      SYX_PARSER_ERROR_SYNTAX,
			      "Expected a symbol constant");
      return FALSE;
    }

  subclass_name = g_strdup (g_value_get_string (token.value));
  subclass = syx_globals_at (subclass_name);

  if (g_strcasecmp (subclass_name, "Object"))
    {
      // Create the class and its metaclass
      if (SYX_IS_NIL (subclass))
	existing_class = FALSE;
      else
	{
	  existing_class = TRUE;
	  SYX_CLASS_SUPERCLASS(subclass) = superclass;
	}
    }

  syx_lexer_next_token (lexer, &token);
  if (token.type != SYX_TOKEN_NAME_COLON)
    {
      if (error)
	*error = g_error_new (SYX_PARSER_ERROR,
			      SYX_PARSER_ERROR_SYNTAX,
			      "Expected #instanceVariableNames:");
      return FALSE;
    }

  syx_lexer_next_token (lexer, &token);
  if (token.type != SYX_TOKEN_STR_CONST)
    {
      if (error)
	*error = g_error_new (SYX_PARSER_ERROR,
			      SYX_PARSER_ERROR_SYNTAX,
			      "Expected a string as argument for #instanceVariableNames:");
      return FALSE;
    }

  splitted_names = g_strsplit_set (g_strdup (g_value_get_string (token.value)), " ", -1);

  syx_lexer_next_token (lexer, &token);
  if (!IS_EXLMARK (token))
    {
      if (error)
	*error = g_error_new (SYX_PARSER_ERROR,
			      SYX_PARSER_ERROR_SYNTAX,
			      "Class definition must terminate with an exlamation mark");
      return FALSE;
    }

  if (!existing_class)
    {
      subclass = syx_class_new (superclass);
      SYX_CLASS_NAME(subclass) = syx_string_new (subclass_name);
      syx_globals_at_put (syx_symbol_new (subclass_name), subclass);
    }

  for (inst_vars_size=0; splitted_names[inst_vars_size]; inst_vars_size++)
    inst_vars_temp[inst_vars_size] = syx_string_new (splitted_names[inst_vars_size]);

  inst_vars = syx_array_new_size (inst_vars_size);
  memcpy (SYX_OBJECT_DATA (inst_vars), inst_vars_temp, inst_vars_size * sizeof (SyxObject *));

  if (SYX_IS_NIL (superclass))
    super_inst_vars_size = 0;
  else
    super_inst_vars_size = SYX_SMALL_INTEGER (SYX_CLASS_INSTANCE_SIZE (superclass));
  SYX_CLASS_INSTANCE_SIZE(subclass) = syx_small_integer_new (inst_vars_size + super_inst_vars_size);

  if (existing_class)
    syx_free (subclass_name);

  return TRUE;
}

static syx_bool
parse_methods (SyxLexer *lexer, GError **error)
{
  SyxToken token = SYX_TOKEN_INIT;
  SyxObject *class;
  SyxParser *parser;
  SyxLexer *method_lexer;
  syx_symbol category;
  syx_string chunk;

  syx_lexer_next_token (lexer, &token);
  g_return_val_if_fail (token.type == SYX_TOKEN_NAME_CONST, FALSE);

  class = syx_globals_at (g_value_get_string (token.value));

  syx_lexer_next_token (lexer, &token);
  if (token.type == SYX_TOKEN_NAME_CONST && !G_VALUE_STRCMP (token.value, "class"))
    {
      class = syx_object_get_class (class);
      syx_lexer_next_token (lexer, &token);
    }
  g_return_val_if_fail (token.type == SYX_TOKEN_NAME_COLON && !G_VALUE_STRCMP (token.value, "methodsFor:"), FALSE);

  syx_lexer_next_token (lexer, &token);
  g_return_val_if_fail (token.type == SYX_TOKEN_STR_CONST, FALSE);

  category = g_value_get_string (token.value);

  syx_lexer_next_token (lexer, &token);
  g_return_val_if_fail (IS_EXLMARK (token), FALSE);

  while (TRUE)
    {
      chunk = syx_lexer_next_chunk (lexer);
      if (!chunk)
	break;

      method_lexer = syx_lexer_new (chunk);
      parser = syx_parser_new (method_lexer, syx_method_new (),
			       syx_class_get_all_instance_variables (class),
			       FALSE, NULL);
      syx_parser_parse (parser, NULL);
      g_free (chunk);

      syx_dictionary_at_const_put (SYX_CLASS_METHODS(class),
				   SYX_METHOD_SELECTOR(parser->method),
				   parser->method);
    }
  
  return TRUE;
}

syx_bool
syx_cold_parse (SyxLexer *lexer, GError **error)
{
  SyxToken token = SYX_TOKEN_INIT;
  syx_bool parseOk = TRUE;

  *error = NULL;

  syx_lexer_next_token (lexer, &token);
  while (parseOk && token.type != SYX_TOKEN_END)
    {
      if (IS_EXLMARK (token))
	parseOk = parse_methods (lexer, error);
      else
	parseOk = parse_class (lexer, error);
      syx_lexer_next_token (lexer, &token);
    }

  return parseOk;
}

syx_bool
syx_cold_file_in (syx_symbol filename, GError **error)
{
  SyxLexer *lexer;
  GMappedFile *file;
  g_return_val_if_fail (g_file_test (filename,
				     (G_FILE_TEST_EXISTS | G_FILE_TEST_IS_REGULAR)), FALSE);

  file = g_mapped_file_new (filename, FALSE, error);
  if (!file)
    return FALSE;

  lexer = syx_lexer_new (g_mapped_file_get_contents (file));
  g_return_val_if_fail (lexer != NULL, FALSE);

  if (!syx_cold_parse (lexer, error))
    return FALSE;
  
  g_mapped_file_free (file);
  return TRUE;
}

syx_bool
syx_semaphore_signal (SyxObject *semaphore)
{
  /*  SyxObject **signals;

  signals = &(SYX_OBJECT_DATA(semaphore)[SYX_SEMAPHORE_SIGNALS]);
  *signals.i.value++;

  while (*signals.i.value > 0 && SYX_OBJECT_SIZE (semaphore) > 0)
    {
      syx_process_set_suspended (SYX_OBJECT_DATA(semaphore)[0]);
      *signals.i.value--;
    }
  */
    return TRUE;
}

void
syx_semaphore_wait (SyxObject *semaphore)
{
  /*  SyxObject *process;

  process = syx_scheduler_get_active_process ();
  syx_process_set_suspended (SYX_OBJECT_DATASYX_PROCESS_SUSPEND (process));
  g_ptr_array_add (SYX_COLLECTION(semaphore)->array, process);*/
}

G_END_DECLS
