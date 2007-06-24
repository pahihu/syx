#ifdef HAVE_CONFIG_H
  #include "config.h"
#endif

#include <syx/syx.h>
#include <stdlib.h>
#include <getopt.h>
#include <unistd.h>
#include <fcntl.h>

/*! \mainpage Smalltalk YX
    
    \b Smalltalk \b YX is an open source Smalltalk-80 implementation. 
    It's written in C and has these purposes:

        - Readable code 
        - Flexibility trough easy creations of plugins 
        - Portable to most important platforms 
        - Optimized 
        - Modern 
        - Embedding in C applications 
        - Easy to use, powerful and well-structured environment 
        - Small
*/

static syx_string
_find_image_path (syx_symbol root_path)
{
  syx_string path;

  // first look at the environment
  path = getenv ("SYX_IMAGE_PATH");
  if (path)
    return path;

  // look in the working directory
  if (!access ("default.sim", R_OK))
    return "default.sim";

  // look in the root directory
  if (root_path)
    {
      path = syx_malloc (strlen (root_path) + 12);
      sprintf (path, "%s%c%s", root_path, SYX_PATH_SEPARATOR, "default.sim");
      if (!access (path, R_OK))
	return path;

      syx_free (path);
    }

  // return the default path defined by the installation
  return SYX_IMAGE_PATH;
}

static void
_getopt_do (int argc, char **argv)
{
  SyxOop context;
  SyxOop process;

  syx_char c;
  int opt_idx;
  syx_string root_path = NULL;
  syx_string image_path = NULL;
  syx_bool scratch = FALSE;
  static struct option long_options[] = {
    {"root", 1, 0, 0},
    {"image", 1, 0, 0},
    {"scratch", 0, 0, 0},
    {0, 0, 0, 0}
  };

  while (TRUE)
    {
      c = getopt_long (argc, argv, "r:i:s",
		       long_options, &opt_idx);
      if (c == -1)
	break;

      switch (c)
	{
	case 0:
	  switch (opt_idx)
	    {
	    case 0:
	      root_path = strdup (optarg);
	      break;
	    case 1:
	      image_path = strdup (optarg);
	      break;
	    case 2:
	      scratch = TRUE;
	      break;
	    }

	case 'r':
	  root_path = strdup (optarg);
	  break;
	case 'i':
	  image_path = strdup (optarg);
	  break;
	case 's':
	  scratch = TRUE;
	}
    }

  if (!image_path)
    image_path = _find_image_path (root_path);

  if (!root_path)
    root_path = SYX_ROOT_PATH;

  if (!syx_init (root_path))
    syx_error ("Couldn't initialize Syx for root %s\n", root_path);

  if (scratch)
    {
      syx_build_basic ();

      context = syx_send_unary_message (syx_nil, syx_globals_at ("Console"), "run");
      process = syx_process_new (context);
      SYX_PROCESS_SUSPENDED(process) = syx_false;
      
      syx_scheduler_add_process (process);

      if (!syx_memory_save_image (image_path))
	syx_warning ("Can't save the image at %s\n", image_path);
    }
  else
    {
      if (!syx_memory_load_image (image_path))
	syx_error ("Image not found at %s\n", image_path);
    }

  syx_globals_at_put (syx_symbol_new ("ImageFileName"), syx_string_new (image_path));
}

int main(int argc, char **argv)
{
  _getopt_do (argc, argv);
  
  syx_scheduler_run ();

  syx_quit ();

  return 0;
}
