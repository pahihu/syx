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

#ifdef WINDOWS
#include <windows.h>
#endif

static void
_help (void)
{
  printf ("This is Smalltalk YX. Usage:\n\n"
	  "\tsyx [options] [ filename [ arguments ] ] \n\n"
	  "Options:\n\n"
	  "  -r --root=DIR\t\tSpecify the root path of Syx\n\t\t\t(default: %s).\n\n"
	  "  -i --image=IMAGEFILE\tLoad the image IMAGEFILE, also SYX_IMAGE_PATH=x\n"
	  "\t\t\t(default: %s)\n\n"
	  "  -s --scratch\t\tBuild the environment from scratch and save the image.\n"
	  "  -S\t\t\tLike --scratch. Exits once the environment is built.\n"
	  "  -c\t\t\tContinue startup process after loading files\n"
	  "\t\t\tfrom the command line.\n\n",
	  SYX_ROOT_PATH, SYX_IMAGE_PATH);

  printf ("  --recovery=IMAGEFILE\tLoad the default image and save the recovered copy\n"
	  "\t\t\tof it to IMAGEFILE.\n\n"
	  "  -v --version\t\tPrint version information and then exit.\n"
	  "  -h --help\t\tPrint this message.\n\n"
	  "For more informations, please visit the homepage: http://code.google.com/p/syx.\n"
	  "Report bugs to \"lethalman88@gmail.com\".\n");
  exit (EXIT_SUCCESS);
}

static void
_version (void)
{
  printf ("Syx %s\nVisit the homepage: http://code.google.com/p/syx\n"
	  "Copyright (c) 2007 Luca Bruno\n",
	  SYX_VERSION);
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

/* Thanks to Krzysztof Kowalczyk for this getopt */

enum {
  ARG_UNKNOWN,
  ARG_ERROR,
  ARG_ROOT,
  ARG_IMAGE,
  ARG_SCRATCH,
  ARG_SCRATCH_AND_QUIT,
  ARG_VERSION,
  ARG_RECOVERY,
  ARG_HELP,
  ARG_CONTINUE_STARTUP
};

struct {
  const char* arg_name;
  int         arg_enum;
  int         need_param;
} arg_defs[] = {
  {"--root", ARG_ROOT, 1},
  {"--image", ARG_IMAGE, 1},
  {"--scratch", ARG_SCRATCH, 0},
  {"--version", ARG_VERSION, 0},
  {"--recovery", ARG_RECOVERY, 1},
  {"--help", ARG_HELP, 0},
  {"-r", ARG_ROOT, 1},
  {"-i", ARG_IMAGE, 1},
  {"-s", ARG_SCRATCH, 0},
  {"-S", ARG_SCRATCH_AND_QUIT, 0},
  {"-v", ARG_VERSION, 0},
  {"-h", ARG_HELP, 0},
  {"-c", ARG_CONTINUE_STARTUP, 0},
  {NULL, 0}
};

static int curr_arg=1;


static int
arg_enum_from_name (int argc, const char** argv, const char** arg_val)
{
  const char *arg;
  int i;

  if (curr_arg >= argc)
    return ARG_UNKNOWN;

  arg = argv[curr_arg];
  i = 0;

  *arg_val = NULL;
  for (i=0; arg_defs[i].arg_name; i++)
    {
      size_t len = strlen(arg_defs[i].arg_name);
      if (!strncmp(arg, arg_defs[i].arg_name, len))
        {
          curr_arg++;
          if (arg_defs[i].need_param)
            {
              if ((strlen(arg) > len) && ('=' == arg[len]))
                *arg_val = arg + len + 1;
              else if (curr_arg < argc && *argv[curr_arg] != '-')
                {
                  *arg_val = argv[curr_arg];
                  curr_arg++;
                }
              else
                {
                  printf("Error: %s option expects an argument\n", arg_defs[i].arg_name);
                  return ARG_ERROR;
                }
            }
          return arg_defs[i].arg_enum;
        }
    }
  return ARG_UNKNOWN;
}

static void
_parse_args (int argc, char **argv)
{
  syx_string root_path = NULL;
  syx_string image_path = NULL;
  syx_symbol recovery = NULL;
  syx_bool scratch = FALSE;
  syx_bool quit = FALSE;
  syx_bool continuestartup = FALSE;
  syx_bool init;

  while (curr_arg < argc)
    {
      const char* arg_val;
      int arg_enum = arg_enum_from_name(argc, (const char **)argv, &arg_val);
      switch (arg_enum)
        {
	case ARG_UNKNOWN:
	  /* exit loop */
	  goto end_of_arg;
	case ARG_ROOT:
	  root_path = syx_strdup (arg_val);
	  break;
	case ARG_IMAGE:
	  image_path = syx_strdup (arg_val);
	  break;
	case ARG_SCRATCH_AND_QUIT:
	  quit = TRUE;
	  /* fall through */
	case ARG_SCRATCH:
	  scratch = TRUE;
	  break;
	case ARG_VERSION:
	  _version();
	  exit (EXIT_FAILURE);
	case ARG_RECOVERY:
	  recovery = arg_val;
	  break;
	case ARG_ERROR:
	case ARG_HELP:
	  _help ();
	  exit (EXIT_FAILURE);
	case ARG_CONTINUE_STARTUP:
	  continuestartup = TRUE;
	  break;
        }
    }

 end_of_arg:
  init = syx_init (argc-curr_arg, argv+curr_arg, root_path);

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

      /* Force WinWorkspace startup on WinCE */
#ifdef WINCE
      SYX_OBJECT_VARS(syx_globals)[4] = syx_globals_at ("WinWorkspace");
#endif
    }
}

int main(int argc, char **argv)
{
  _parse_args(argc, argv);

  syx_scheduler_run ();

  syx_quit ();

  return 0;
}
