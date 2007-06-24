#ifndef SYX_ERROR_H
#define SYX_ERROR_H

#include <stdio.h>
#include "syx-types.h"
#include "syx-object.h"

typedef syx_uint32 SyxErrorType;

typedef struct SyxErrorEntry SyxErrorEntry;

struct SyxErrorEntry
{
  syx_symbol name;
  SyxOop class;
};

void syx_error_init (void);
void syx_error_clear (void);
SyxErrorType syx_error_register (syx_symbol name, SyxOop class);
SyxErrorEntry *syx_error_lookup (SyxErrorType type);

#define syx_signal(type, args...)					\
  syx_interp_enter_context (syx_send_message (syx_interp_get_current_context (), \
					      syx_error_lookup (type)->class, \
					      "signal",			\
					      args))

#define syx_error(args...)			\
  {						\
    fprintf (stderr, "ERROR: ");		\
    fprintf (stderr, args);			\
    exit (EXIT_FAILURE);			\
  }

#define syx_warning(args...)			\
  {						\
    fprintf (stderr, "WARNING: ");		\
    fprintf (stderr, args);			\
  }

#define syx_perror(args...)			\
  {						\
    perror (args);				\
    exit (EXIT_FAILURE);			\
  }

#define syx_debug(args...)			\
  printf (args)					
    

#endif /* SYX_ERROR_H */
