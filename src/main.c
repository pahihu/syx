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
  syx_bool quit = FALSE;
  static struct option long_options[] = {
    {"root", 1, 0, 0},
    {"image", 1, 0, 0},
    {"scratch", 0, 0, 0},
    {0, 0, 0, 0}
  };

  while (TRUE)
    {
      c = getopt_long (argc, argv, "r:i:sS",
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
	    default:
	      exit (EXIT_FAILURE);
	    }

	case 'r':
	  root_path = strdup (optarg);
	  break;
	case 'i':
	  image_path = strdup (optarg);
	  break;
	case 'S':
	  quit = TRUE;
	case 's':
	  scratch = TRUE;
	  break;
	default:
	  exit (EXIT_FAILURE);
	}
    }

  if (!syx_init (root_path))
    syx_error ("Couldn't initialize Syx for root %s\n", root_path);

  if (image_path)
    syx_set_image_path (image_path);
   
  if (scratch)
    {
      syx_build_basic ();

      context = syx_send_unary_message (syx_nil, syx_globals_at ("Console"), "run");
      process = syx_process_new (context);
      SYX_PROCESS_SUSPENDED(process) = syx_false;
      
      syx_scheduler_add_process (process);

      if (!syx_memory_save_image (NULL))
	syx_warning ("Can't save the image\n");

      if (quit)
	{
	  syx_quit ();
	  exit (EXIT_SUCCESS);
	}
    }
  else
    {
      if (!syx_memory_load_image (NULL))
	syx_error ("Image not found\n");
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
