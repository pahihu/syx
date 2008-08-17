#!/usr/bin/env python
import os
import sys
import string

# Tune this

FROM_MAIL = "lethalman88@gmail.com"
TO_MAIL = "syx-commit@googlegroups.com"
SENDMAIL = "esmtp -t"

# Some other config

DEBUG = False
LASTCOMMIT = '.announcer.lastcommit'

def git (command, stripped=True):
    if DEBUG:
        print "* "+command
    return map (lambda x: x[:-1], os.popen("git "+command).readlines ())

def git_exit (command):
    if DEBUG:
        print "* "+command
    return os.system("git %s &>/dev/null" % command)

def sendmail (mail):
    return os.popen(SENDMAIL, "w").write (mail)

def error (message):
    sys.stderr.write ("ERROR: "+message+"\n")
    sys.exit (1)

class Rev (object):
    def __init__ (self, name, verify=True):
        self.name = name
        if verify:
            self.verify ()
    
    def verify (self):
        assert not git_exit ("rev-list -n 1 "+self.name)

class Branch (Rev):
    def checkout (self):
        assert not git_exit ("checkout "+self.name)

    def __repr__ (self):
        return "Branch: %s" % (self.name)

    def __str__ (self):
        return self.name

class Commit (Rev):
    email_tmpl = string.Template ("""From: $fromail
To: $tomail
Content-type: text/plain
Subject: $branch $hash

Branch: $branch
$whatchanged

$diff""")

    def __init__ (self, name, branch, verify=True):
        Rev.__init__ (self, name, verify)
        self.branch = branch

    def email_report (self):
        whatchanged = self.whatchanged ()
        diff = self.diff (self.ancestor ())
        return self.email_tmpl.substitute (fromail=FROM_MAIL, tomail=TO_MAIL,
                                           branch=self.branch.name, hash=self.name,
                                           whatchanged=whatchanged,
                                           diff=diff)

    def whatchanged (self):
        out = git ("whatchanged -n 1 %s" % self)
        return '\n'.join (out)

    def diff (self, commit):
        out = git ("diff %s %s" % (commit, self))
        return '\n'.join (out)

    def ancestor (self):
        out = git ("rev-list -n 1 %s^" % self.name)
        return Commit (out[0], self.branch, False)

    def xnew_commits (self):
        out = git ("rev-list %s..%s" % (self.name, self.branch.name))
        for hash in out:
            yield Commit (hash, self.branch)

    def __repr__ (self):
        return "%s %s" % (self.branch, self.name)

    def __str__ (self):
        return self.name

def fetch_last_commits ():
    last_commits = []
    f = file (LASTCOMMIT)
    for line in f.xreadlines ():
        s = filter (lambda x: x.strip(), line.split (' '))
        branch = Branch (s[0].strip ())
        last_commits.append (Commit (s[1].strip(), branch))
    f.close ()
    return last_commits

def write_last_commits (commits):
    f = file (LASTCOMMIT, "w")
    for commit in commits:
        f.write (repr (commit) + "\n")
    f.close ()

dryrun = False
nopull = False
if len(sys.argv) > 1:
    if '-n' in sys.argv:
        nopull = True
    if '-d' in sys.argv:
        dryrun = True
    if '-h' in sys.argv:
        error ("Use -n to not pull. Use -d to dry run")

if not nopull:
    assert not git_exit ("pull")

last_commits = fetch_last_commits ()
new_last_commits = []
for last_commit in last_commits:
    new_commits = list (reversed (list (last_commit.xnew_commits ())))
    last_commit.branch.checkout ()
    for commit in new_commits:
        print "* Sendmail %r" % commit
        if not dryrun:
            sendmail (commit.email_report ())
    if new_commits:
        new_last_commits.append (new_commits[-1])
    else:
        new_last_commits.append (last_commit)

if not dryrun:
    write_last_commits (new_last_commits)
