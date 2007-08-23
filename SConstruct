#################################################################################
#                                                                               #
# Copyright (c) 2007 Luca Bruno                                                 #
#                                                                               #
# This file is part of Smalltalk YX.                                            #
#                                                                               #
# Permission is hereby granted, free of charge, to any person obtaining a copy  #
# of this software and associated documentation files (the "Software"), to deal #
# in the Software without restriction, including without limitation the rights  #
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell     #
# copies of the Software, and to permit persons to whom the Software is         #
# furnished to do so, subject to the following conditions:                      #
#                                                                               #
# The above copyright notice and this permission notice shall be included in    #
# all copies or substantial portions of the Software.                           #
#                                                                               #
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR    #
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,      #
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE   #
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER        #
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING       #
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER           #
# DEALINGS IN THE SOFTWARE.                                                     #
#                                                                               #
#################################################################################

import os, glob
from SCons import Conftest

env = Environment ()

opts = Options ('options.cache')

if env['PLATFORM'] == 'win32':
   opts.AddOptions (PathOption('prefix',
                              'Installation prefix',
                              'C:\\\\Syx', PathOption.PathAccept))
   env['bindir'] = env['datadir'] = env['rootdir'] = env['libdir'] = '$prefix'
   env['plugindir'] = '$prefix\\\\lib'
   env['imagepath'] = '$prefix\\\\default.sim'
   env['includedir'] = '$prefix\\\\include'
   env['docdir'] = '$prefix\\\\doc'
else:
   opts.AddOptions (
      PathOption('prefix', 
                 'Installation prefix', 
                 '/usr/local', PathOption.PathAccept),
      PathOption('exec_prefix',
                 'Installation prefix for executables and object code libraries',
                 '$prefix', PathOption.PathAccept),
      PathOption('bindir', 
                 'Installation prefix for user executables', 
                 '$exec_prefix/bin', PathOption.PathAccept),
      PathOption('datadir',
                 'Installation prefix for machine-independent data',
                 '$prefix/share', PathOption.PathAccept),
      PathOption('rootdir',
                 'Installation prefix for all smalltalk data',
                 '$datadir/syx', PathOption.PathAccept),
      PathOption('imagepath',
                 'Installation path for the default binary image',
                 '$rootdir/default.sim', PathOption.PathAccept),
      PathOption('docdir',
                 'Installation prefix for documentation',
                 '$datadir/doc', PathOption.PathAccept),
      PathOption('libdir',
                 'Installation prefix for object code libraries', 
                 '$exec_prefix/lib', PathOption.PathAccept),
      PathOption('plugindir',
                 'Installation prefix for object code plugins',
                 '$libdir/syx', PathOption.PathAccept),
      PathOption('includedir',
                 'Installation prefix for C header files', 
                 '$prefix/include', PathOption.PathAccept))

opts.AddOptions (
   ('host', """cross-compile to build programs to run on HOST""", ''),
   EnumOption ('endianness',
               """Specify manually the endianness of the host machine (auto, big, little)""",
               'auto', allowed_values=('auto', 'little', 'big'), ignorecase=True),
   BoolOption ('shared', """Build shared library objects""", True),
   BoolOption ('static', """Build static library objects""", True),
   BoolOption ('plugins', """Build with plugins support""", True),
   BoolOption ('bignum', """Build with infinite-precision numbers (needs gmp library)""", True),
   BoolOption ('attach', """Attach a debugger for test failures""", False),              
   EnumOption ('debug', """Debug output and symbols""", 'normal',
               allowed_values=('no', 'normal', 'info', 'full'),
               ignorecase=True),
   BoolOption ('doc', """Build reference documentation (needs Doxygen)""", True),

   BoolOption ('GTK', """Build the syx-gtk plugin to support graphical user interfaces""", True),
   BoolOption ('WINGUI', """Build the syx-wingui plugin to support native windows user interfaces""", True),
   BoolOption ('READLINE', """Build the syx-readline plugin to add more console features""", True))

opts.Update (env)
opts.Save ('options.cache', env)

# My 64bit LFS keep its toolchain in /tools64 and set LD_LIBRARY_PATH for tests
if env['PLATFORM'] == 'posix':
   env['ENV']['PATH'] = '/tools64/bin:' + env['ENV']['PATH']

# Specify the alternative toolchain for Windows
env['tools'] = ['default', 'mingw']
   
# Custimize the help message
env.Help (opts.GenerateHelpText (env) + """
  Type: 'scons'               to build Syx.
        'scons doc=no'        to create disable building the reference
                              documentation.

        'scons endianness=auto,big,little'
                              specify the endianness of the target
                              machine (default: auto)

        'scons host=arch-os'  cross-compile to build programs
                              to run on the specified host

        'scons debug=no'      release build with high optimization.
        'scons debug=normal'  add debug symbols (default).
        'scons debug=info'    display more messages.
        'scons debug=full'    trace the entire execution stack of Smalltalk.
        'scons test'          to test Syx.
        'scons test attach=yes'
                              to test Syx and attach a debugger if a
                              test fails

        'scons install'       to install Syx.
        'scons sdist'         to create a directory with source distribution.
        'scons bdist'         to create a directory with binary distribution
                              (implies 'scons install').
     """)

# Configuration

def check_endianness (ctx):
   ctx.Message ("Checking for machine endianness...")
   if env['endianness'] != 'auto':
      if env['endianness'] == 'big':
         Conftest._Have (ctx, 'HAVE_BIG_ENDIANNESS', 1)
      else:
         Conftest._Have (ctx, 'HAVE_BIG_ENDIANNESS', 0)
      ctx.Result (env['endianness'])
      return True

   ret = ctx.TryRun ("""
#include <stdio.h>
int main (int argc, char **argv)
{
  static const int i = 1;
  if ((*(char*)&i) == 0)
    printf ("big");
  else
    printf ("little");

  return 0;
}
""", '.c')
   if ret[0]:
      if ret[1] == 'big':
         Conftest._Have (ctx, 'HAVE_BIG_ENDIANNESS', 1)
      else:
         Conftest._Have (ctx, 'HAVE_BIG_ENDIANNESS', 0)
      ctx.Result (ret[1])
      return True
   else:
      print "Can't build Syx without determining machine endianness"
      ctx.Result (0)
      return False

def check_inline (ctx):
   ctx.Message ("Checking for inline...")
   ret = ctx.TryRun ("""
#undef inline
inline int foo () { return 0; }
int main () { return foo (); }
""", '.c')
   if ret[0]:
      Conftest._Have (ctx, 'HAVE_INLINE', 1)
      ctx.Result (True)
   else:
      Conftest._Have (ctx, 'HAVE_INLINE', 0)
      ctx.Result (False)

def check__inline (ctx):
   ctx.Message ("Checking for __inline...")
   ret = ctx.TryRun ("""
__inline int foo () { return 0; }
int main () { return foo (); }
""", '.c')
   if ret[0]:
      Conftest._Have (ctx, 'HAVE__INLINE', 1)
      ctx.Result (True)
   else:
      Conftest._Have (ctx, 'HAVE__INLINE', 0)
      ctx.Result (False)

def check__inline__ (ctx):
   ctx.Message ("Checking for __inline__...")
   ret = ctx.TryRun ("""
__inline__ int foo () { return 0; }
int main () { return foo (); }
""", '.c')
   if ret[0]:
      Conftest._Have (ctx, 'HAVE__INLINE__', 1)
      ctx.Result (True)
   else:
      Conftest._Have (ctx, 'HAVE__INLINE__', 0)
      ctx.Result (False)

conf = Configure (env, custom_tests={ 'CheckEndianness' : check_endianness,
                                      'CheckInline' : check_inline,
                                      'Check__Inline': check__inline,
                                      'Check__Inline__': check__inline__}, config_h="syx/syx-config.h")


# Cross compiling

if env['host']:
   cenv = env.Clone (ENV=os.environ)
   print
   print 'Cross-compile to run on %s...' % env['host']

   tool = env['host']+'-gcc'
   env['CC'] = cenv.WhereIs (tool)
   print 'Checking for %s... %s' % (tool, env['CC'])
   if not env['CC']:
      print "Can't find a valid C compiler"
      env.Exit(1)

   tool = env['host']+'-ar'
   env['AR'] = cenv.WhereIs (tool)
   print 'Checking for %s... %s' % (tool, env['AR'])

   tool = env['host']+'-as'
   env['AS'] = cenv.WhereIs (tool)
   print 'Checking for %s... %s' % (tool, env['AS'])

   tool = env['host']+'-ranlib'
   env['RANLIB'] = cenv.WhereIs (tool)
   print 'Checking for %s... %s' % (tool, env['RANLIB'])

   tool = env['host']+'-windres'
   env['RC'] = cenv.WhereIs (tool)
   print 'Checking for %s... %s' % (tool, env['RC'])

   if 'wince' in env['host']:
      env.MergeFlags("-DWINCE")

# Do configuration


print 'Mandatory headers...'

for h in ['string.h', 'sys/stat.h', 'time.h', 'stdio.h', 'assert.h', 'fcntl.h',
          'sys/types.h']:
   if not conf.CheckCHeader (h):
      print "Can't build Syx without %s header!" % h
      env.Exit (1)

print
print 'Optional headers...'

for h in ['stdarg.h', 'byteswap.h', 'errno.h', 'unistd.h', 'stdint.h', 'sys/time.h']:
   conf.CheckCHeader (h)
for t in ['int64_t']:
   conf.CheckType (t, '#include <stdint.h>', 'c')

if env['PLATFORM'] == 'win32':
   have_windows_h = conf.CheckCHeader ('windows.h')

print
print 'Mandatory functions...'

for f in ['strtol', 'strtod']:
   if not conf.CheckFunc (f):
      print "Can't build Syx without %s function!" % f
      env.Exit (1)

if env['PLATFORM'] == 'win32':
   lib = 'wsock32'
   if 'wince' in env['host']:
      lib = 'winsock'
      conf.CheckLib ('coredll')

   if not conf.CheckLibWithHeader (lib, 'winsock2.h', 'c', 'select(0, NULL, NULL, NULL, NULL);'):
      print "Can't build Syx without select function!"
      env.Exit (1)
else:
   if not conf.CheckFunc ('select'):
      print "Can't build Syx without select function!"
      env.Exit (1)

if not conf.CheckLibWithHeader ('m', 'math.h', 'c', 'trunc((double)3.4) == (double)3.0;'):
   print "Can't build Syx without the math library!"
   env.Exit (1)

if not conf.CheckEndianness ():
   env.Exit (1)

"Assume we have __inline__"
if not (conf.CheckInline () or conf.Check__Inline () or conf.Check__Inline__ ()) and env['host']:
   env.MergeFlags ("-DHAVE__INLINE__")

print
print 'Optional functions...'

for f in ['fstat', 'access', 'getenv', 'perror', 'signal']:
   conf.CheckFunc (f)

if env['bignum']:
   if not conf.CheckLibWithHeader ('gmp', 'gmp.h', 'c', 'mpz_t t; mpz_init (t); mpz_clear (t);'):
      print "WARNING: gmp library not found. Multiple-precision numbers won't be supported"

if env['plugins']:
    if (env['PLATFORM'] == 'win32' and have_windows_h) or conf.CheckLibWithHeader ('dl', 'dlfcn.h', 'c', 'dlopen(0, 0);'):
        env.MergeFlags ('-DWITH_PLUGINS')
    else:
        print 'WARNING: building without plugins support'
        env['plugins'] = False

conf.Finish ()




# Flags
env.MergeFlags ('-Wall -Wno-strict-aliasing -I#.')

if env['PLATFORM'] == 'darwin':
   env.MergeFlags ('-fno-common')

if 'wince' in env['host']:
   env.MergeFlags ('-DROOT_PATH="" -DIMAGE_PATH="default.sim" -DPLUGIN_PATH="lib"')
elif env['PLATFORM'] == 'win32':
   env.MergeFlags ('-DROOT_PATH="." -DIMAGE_PATH="default.sim" -DPLUGIN_PATH="lib"')
else:
   env.MergeFlags ('-DROOT_PATH="$rootdir" -DIMAGE_PATH="$imagepath" -DPLUGIN_PATH="$plugindir"')

if env['debug'] == 'no':
   env.MergeFlags ('-O3')
elif env['debug'] == 'normal':
   env.MergeFlags ('-g -O2')
elif env['debug'] == 'info':
   env.MergeFlags ('-g -O -DSYX_DEBUG_INFO')
elif env['debug'] == 'full':
   env.MergeFlags ('-g -O -DSYX_DEBUG_INFO -DSYX_DEBUG_FULL')

if env['PLATFORM'] == 'win32':
   env.MergeFlags ('-DWINDOWS')

distdir = '#syx-0.1.4'

# Installation

def builder_syxinstall (target, sources):
   t1 = env.Install (target, sources)
   env.Alias ('install', t1)
   if env['PLATFORM'] != 'win32':
      t = env.Install (os.path.join (distdir, target), sources)
      env.Alias ('bdist', t)
   return t1

setattr (env, 'SyxInstall', builder_syxinstall)

# Doc builder

env['doxygen'] = env.WhereIs ('doxygen')
if env['doc'] and env['doxygen']:
   target = env.Command ('build/doc', 'Doxyfile', '$doxygen $SOURCES')
   Default (target)
   path = os.path.join (env['docdir'], distdir[1:])
   t1 = env.SyxInstall (path, target)
   env.Alias ('install', t1)
   env.Clean ('install', t1)

# Build

env.MergeFlags ('-L#build/lib')
env.BuildDir ('build/lib', 'syx', False)
env.SConscript (dirs=['build/lib'], exports=['env', 'distdir'])

env.BuildDir ('build/bin', 'src', False)
env.SConscript (dirs=['build/bin'], exports=['env', 'distdir'])

env.BuildDir ('build/plugins', 'plugins', False)
env.SConscript (dirs=['build/plugins'], exports=['env', 'distdir'])

env.SConscript (dirs=['tests'], exports=['env', 'distdir'])
env.SConscript (dirs=['examples'], exports=['env', 'distdir'])

# Install data

sources = glob.glob ('st/kernel/*.st')
path = os.path.join (env['rootdir'], 'st', 'kernel')
env.SyxInstall (path, sources)

if env['PLATFORM'] == 'posix':
   path = os.path.join (env['datadir'], 'applications')
   env.SyxInstall (path, 'syx.desktop')
   path = os.path.join (env['datadir'], 'pixmaps')
   env.SyxInstall (path, 'syx.png')

# Source distribution

path = os.path.join (distdir, 'st', 'kernel')
target = env.Install (path, sources)
env.Alias ('sdist', target)

sources = ['INSTALL', 'README', 'AUTHORS', 'ChangeLog', 'COPYING', 'SConstruct', 'TODO', 'NEWS', 'Doxyfile',
           'README-BINARIES', 'syx.sln', 'syx.vcproj', 'makefile.vc', 'syx.desktop', 'syx.png']
target = env.Install (distdir, sources)
env.Alias ('sdist', target)

target = env.Install (os.path.join (distdir, 'doc', 'html', 'extras'), '#doc/html/extras/footer.html')
env.Alias ('sdist', target)

# Binary distribution

target = env.Install (distdir, '#README-BINARIES')
env.Alias ('bdist', target)
