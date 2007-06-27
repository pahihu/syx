#include "syx-memory.h"
#include "syx-error.h"
#include "syx-types.h"
#include "syx-object.h"

#include <assert.h>

static SyxErrorEntry **_syx_error_entries;
SyxErrorType _syx_error_entries_top;

//! Initialize the error reporting system
/*!
  This function must be called after the image has been loaded or a new image is built.
  Usually, user programs don't need to call this directly.
*/
void
syx_error_init (void)
{
  syx_bool initialized = FALSE;
  if (initialized)
    syx_error_clear ();

  _syx_error_entries_top = 0;
  assert (syx_error_register ("interpreter", syx_globals_at ("VMError")) == SYX_ERROR_INTERP);
  assert (syx_error_register ("message not understood",
			      syx_globals_at ("MessageNotUnderstood")) == SYX_ERROR_NOT_UNDERSTOOD);
  assert (syx_error_register ("not found",
			      syx_globals_at ("NotFound")) == SYX_ERROR_NOT_FOUND);
  initialized = TRUE;
}

//! Clear all memory allocated to by the error reporting system
/*!
  This function must be called after all other memory has been released and we're really ready to quit,
  so that any other call won't report errors.
  Usually, user programs don't need to call this directly.
*/
void
syx_error_clear (void)
{
  syx_int32 i;
  for (i=0; i < _syx_error_entries_top; i++)
    syx_free (_syx_error_entries[i]);

  syx_free (_syx_error_entries);
}

SyxErrorType
syx_error_register (syx_symbol name, SyxOop class)
{
  SyxErrorEntry *entry = syx_malloc (sizeof (SyxErrorEntry));
  if (!_syx_error_entries)
    _syx_error_entries = syx_calloc (++_syx_error_entries_top, sizeof (SyxErrorEntry *));
  else
    _syx_error_entries = syx_realloc (_syx_error_entries,
				      (++_syx_error_entries_top) * sizeof (SyxErrorEntry *));

  entry->name = name;
  entry->class = class;

  _syx_error_entries[_syx_error_entries_top - 1] = entry;
  return _syx_error_entries_top - 1;
}

SyxErrorEntry *
syx_error_lookup (SyxErrorType type)
{
  if (type >= _syx_error_entries_top)
    return NULL;

  return _syx_error_entries[type];
}
