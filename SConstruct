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
   BoolOption ('release', 'do a release build', 'no'))
env = Environment (options=opts)

# My 64bit LFS keep its toolchain in /tools64 and set LD_LIBRARY_PATH for tests
if env['PLATFORM'] == 'posix':
   env['ENV']['PATH'] = '/tools64/bin:' + env['ENV']['PATH']

# Specify the alternative toolchain for Windows
env['tools'] = ['default', 'mingw']
   
# Custimize the help message
env.Help (opts.GenerateHelpText (env) + """
     Type: 'scons'               to build Syx.
     	   'scons release=yes'   to build with high optimization
	                         and no debugging informations.
           'scons test'          to test Syx.
           'scons doc'           to create reference documentation (requires Doxygen).
     	   'scons install'       to install Syx.
	   """)

# Configuration
conf = Configure (env, config_h='config.h')

for h in ['string.h', 'unistd.h', 'sys/stat.h', 'time.h', 'stdio.h', 'assert.h', 'fcntl.h', 'sys/types.h']:
   if not conf.CheckCHeader (h):
      print "Can't build Syx without %s header!" % h

conf.Finish ()

# Flags
env.MergeFlags ('-I.. -L#syx')
if not env['release']:
   env.MergeFlags ('-g -O')
else:
   env.MergeFlags ('-O3')

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
