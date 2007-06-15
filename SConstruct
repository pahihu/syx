import os

EnsurePythonVersion (2,2)

opts = Options()
opts.AddOptions (
   PathOption('prefix', 
              'Installation prefix', 
              '/usr/local', []),
   PathOption('exec_prefix',
              'Installation prefix for executables and object code libraries',
              '$prefix', []),
   PathOption('bindir', 
              'Installation prefix for user executables', 
              '$exec_prefix/bin', []),
   PathOption('datadir',
              'Installation prefix for read-only architecture-independent data', 
              '$prefix/share', []),
   PathOption('libdir',
              'Installation prefix for object code libraries', 
              '$exec_prefix/lib', []),
   PathOption('includedir',
              'Installation prefix for C header files', 
              '$prefix/include', []),
   EnumOption ('debug', """Debug output and symbols""", 'normal',
               allowed_values=('no', 'normal', 'warning', 'full'),
               ignorecase=True))

env = Environment (options=opts)

# My 64bit LFS keep its toolchain in /tools64 and set LD_LIBRARY_PATH for tests
if env['PLATFORM'] == 'posix':
   env['ENV']['PATH'] = '/tools64/bin:' + env['ENV']['PATH']

# Specify the alternative toolchain for Windows
env['tools'] = ['default', 'mingw']
   
# Custimize the help message
env.Help (opts.GenerateHelpText (env) + """
     Type: 'scons'               to build Syx.
     	   'scons debug=no'      release build with high optimization.
           'scons debug=normal'  add debug symbols (default).
           'scons debug=warning' normal debug plus warning messages.
           'scons debug=full'    trace the entire execution stack of Smalltalk.
           'scons test'          to test Syx.
           'scons doc'           to create reference documentation (requires Doxygen).
     	   'scons install'       to install Syx.
	   """)

# Configuration
conf = Configure (env, config_h='config.h')

for h in ['string.h', 'unistd.h', 'sys/stat.h', 'time.h', 'stdio.h', 'assert.h', 'fcntl.h', 'sys/types.h']:
   if not conf.CheckCHeader (h):
      print "Can't build Syx without %s header!" % h

for f in ['strndup', 'memdup']:
   conf.CheckFunc (f)

conf.Finish ()

# Flags
env.MergeFlags ('-I.. -L#syx')
if env['debug'] == 'no':
   env.MergeFlags ('-O3')
elif env['debug'] == 'normal':
   env.MergeFlags ('-g -O')
elif env['debug'] == 'warning':
   env.MergeFlags ('-g -O -DSYX_DEBUG_WARNING')
elif env['debug'] == 'full':
   env.MergeFlags ('-g -O -DSYX_DEBUG_WARNING -DSYX_DEBUG_FULL')

env.MergeFlags ('-Wall -DHAVE_CONFIG_H')

# Test builder
def builder_test (target, source, env):
   print
   app = str (source[0].path)
   relapp = os.path.splitext (os.path.basename (str (source[0].abspath)))[0]
   f = open(target[0].abspath, 'w')
   if env.Execute (app) == 0:
      print 'PASS: %s' % relapp
      f.write ('PASSED')
   else:
      print 'FAIL: %s' % relapp
      f.write ('FAILED')
   f.close ()

action = env.Action (builder_test, lambda *args, **kwargs: '')
builder = env.Builder (action=action)
env.Append(BUILDERS = { 'Test' : builder })

# Doc builder

env.Alias ('doc', env.Command ('doxygen.log', 'Doxyfile',
                               'doxygen $SOURCES > $TARGET'))

# Build
env.SConscript (dirs=['syx', 'tests'], exports=['env'])

# Command aliases
env.Alias ('install', [env['includedir'],
                       env['libdir'],
                       env['bindir'],
                       env['datadir']])
