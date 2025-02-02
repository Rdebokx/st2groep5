#!/bin/sh
#
# Written by Thiago Macieira <thiago@kde.org>
# This file is in the public domain.
#
# Shows the changes to the subversion repository since the local copy
# was last updated.
#

showdiff=false
showlog=true

while test $# -ge 1; do
  case "$1" in
    -d)
      showdiff=true
      shift
      ;;
      
    -D)
      showdiff=false
      shift
      ;;
      
    -l)
      showlog=true
      shift
      ;;
    
    -L)
      showlog=false
      shift
      ;;
    
    -u)
      showlog=false
      showdiff=true
      svn update
      shift
      ;;  
    -h)
      cat <<EOF
svnchangesince - Shows the changes to the SVN repository since the last update
Usage:
  svnchangesince [-d|-D] [-l|-L] [-h] [filenames]
  
where:
  -d        include diffs in output
  -D        don't include diffs in output [default]
  -l        include logs in output [default]
  -L        don't include logs in output
  -h        show this help string
  -u 	    update svn
EOF
      exit 0
      ;;
      
    *)
      break
      ;;
  esac
done

if $showlog; then
  svn log -r BASE:HEAD "$@"
fi

if $showdiff; then
  svn diff -r BASE:HEAD "$@"
fi
