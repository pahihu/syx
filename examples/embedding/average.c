#include <syx/syx.h>

SYX_FUNC_PRIMITIVE(average)
{
  syx_int32 i;
  syx_int32 sum = 0;
  SyxOop oop;

  /* obtain the number of arguments that has been sent */
  syx_int32 args = es->message_arguments_count;

  /* create the array to hold both the average and the sum */
  SyxOop result = syx_array_new_size (2);

  for (i=0; i < args; i++)
    {
      /* get the nth argument */
      oop = es->message_arguments[i];

      /* assert the object is a SmallInteger */
      if (!SYX_IS_SMALL_INTEGER (oop))
	{
	  SYX_PRIM_FAIL;
	}

      /* get the integer value of the object and sum */
      sum += SYX_SMALL_INTEGER (oop);
    }
  
  /* put into the array the two results */
  SYX_OBJECT_DATA(result)[0] = syx_small_integer_new (sum / args);
  SYX_OBJECT_DATA(result)[1] = syx_small_integer_new (sum);
  
  SYX_PRIM_RETURN(result);
}

int main (int argc, char *argv[])
{
  /* initialize Syx */
  syx_init (argc, argv, NULL);
  
  /* load the default image */
  syx_memory_load_image (NULL);
  
  /* now file in our file in blocking mode, .i.e without scheduling the Process */
  syx_file_in_blocking ("average.st");

  /* cleanup Syx */
  syx_quit ();
  
  return 0;
}
