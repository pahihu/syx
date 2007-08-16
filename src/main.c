/* 
   Copyright (c) 2007 Luca Bruno

   This file is part of Smalltalk YX.

   Permission is hereby granted, free of charge, to any person obtaining a copy
   of this software and associated documentation files (the "Software"), to deal
   in the Software without restriction, including without limitation the rights
   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell   
   copies of the Software, and to permit persons to whom the Software is
   furnished to do so, subject to the following conditions:
   
   The above copyright notice and this permission notice shall be included in
   all copies or substantial portions of the Software.
   
   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,  
   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
   FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER    
   DEALINGS IN THE SOFTWARE.
*/

#include <syx/syx.h>

#include <stdio.h>

#ifdef HAVE_GETOPT
#include <getopt.h>
#endif

#ifdef WINDOWS
#include <windows.h>
#endif

static void
_help (void)
{
  printf ("This is Smalltalk YX. Usage:\n\n"
	  "\tsyx [options] [ -- filename [arguments] ] \n\n"
	  "Options:\n\n"
	  "  -r --root=DIR\t\tSpecify the root path of Syx\n\t\t\t(default: %s).\n\n"
	  "  -i --image=IMAGEFILE\tLoad the image IMAGEFILE, also SYX_IMAGE_PATH=x\n"
	  "\t\t\t(default: %s)\n\n"
	  "  -s --scratch\t\tBuild the environment from scratch and save the image.\n"
	  "  -S\t\t\tLike --scratch. Exits once the environment is built.\n"
	  "  -c\t\t\tContinue startup process after loading files\n"
	  "\t\t\tfrom the command line.\n\n"
	  "  --recovery=IMAGEFILE\tLoad the default image and save the recovered copy\n"
	  "\t\t\tof it to IMAGEFILE.\n\n"
	  "  -v --version\t\tPrint version information and then exit.\n"
	  "  -h --help\t\tPrint this message.\n\n"
	  "For more informations, please visit the homepage: http://code.google.com/p/syx.\n"
	  "Report bugs to \"lethalman88@gmail.com\".\n",
	  SYX_ROOT_PATH, SYX_IMAGE_PATH);
  exit (EXIT_SUCCESS);
}

static void
_do_recovery (const char *rim_path)
{
  SyxOop process = syx_processor_active_process;
  SYX_PROCESS_CONTEXT(process) = syx_nil;
  SYX_PROCESS_SUSPENDED(process) = syx_true;
  SYX_PROCESS_SCHEDULED(process) = syx_false;
  syx_scheduler_remove_process (process);

  if (!syx_memory_save_image (rim_path))
    {
      printf("Can't save a recovered copy of the image at %s.\n", rim_path);
      exit (EXIT_FAILURE);
    }
  else
    {
      printf("Recovered copy of the image has been created at %s.\n", rim_path);
      exit (EXIT_SUCCESS);
    }
}

static void
_getopt_do (int argc, char **argv)
{
  syx_string root_path = NULL;
  syx_string image_path = NULL;
  syx_symbol recovery = NULL;
  syx_bool scratch = FALSE;
  syx_bool quit = FALSE;
  syx_bool continuestartup = FALSE;
  syx_bool init;

#ifdef HAVE_GETOPT
  syx_char c;
  syx_int32 opt_idx;

  static struct option long_options[] = {
    {"root", 1, 0, 0},
    {"image", 1, 0, 0},
    {"scratch", 0, 0, 0},
    {"version", 0, 0, 0},
    {"recovery", 1, 0, 0},
    {"help", 0, 0, 0},
    {0, 0, 0, 0}
  };

  while (TRUE)
    {
      c = getopt_long (argc, argv, "r:i:sSvhc",
		       long_options, &opt_idx);

      if (c == (syx_char)-1)
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
	    case 3:
	      printf ("Syx %s\nVisit the homepage: http://code.google.com/p/syx\n"
		      "Copyright (c) 2007 Luca Bruno\n",
		      SYX_VERSION);
	      exit (EXIT_SUCCESS);
	    case 4:
	      recovery = optarg;
	      break;
	    case 5:
	    default:
	      _help ();
	      exit (EXIT_FAILURE);
	    }
	  break;

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
	case 'c':
	  continuestartup = TRUE;
	  break;
	case 'v':
	  printf ("Syx %s\nVisit the homepage: http://code.google.com/p/syx\n"
		  "Copyright (c) 2007 Luca Bruno\n",
		  SYX_VERSION);
	  exit (EXIT_SUCCESS);
	case 'h':
	default:
	  _help ();
	}

    }

  init = syx_init (argc - optind, argv+optind, root_path);
#else
  init = syx_init (argc - 1, argv+1, root_path);
#endif

  if (root_path)
    syx_free (root_path);

  if (!init)
    syx_error ("Couldn't initialize Syx for root: %s\n", syx_get_root_path ());

  if (image_path)
    {
      syx_set_image_path (image_path);
      syx_free (image_path);
    }
  
  if (scratch)
    {
      syx_build_basic ();

      if (!syx_memory_save_image (NULL))
	syx_warning ("Can't save the image\n");

      if (quit)
	{
	  syx_quit ();
	  exit (EXIT_SUCCESS);
	}

      syx_initialize_system ();
    }
  else
    {
      if (!syx_memory_load_image (NULL))
	syx_error ("Image not found\n");

      if (recovery)
	_do_recovery (recovery);

      SYX_OBJECT_VARS(syx_globals)[5] = syx_boolean_new (continuestartup);

      // Force WinWorkspace startup on WinCE
#ifdef WINCE
      SYX_OBJECT_VARS(syx_globals)[4] = syx_globals_at ("WinWorkspace");
#endif
    }
}

int main(int argc, char **argv)
{
  _getopt_do (argc, argv);
  
  syx_scheduler_run ();

  syx_quit ();

  return 0;
}
