#!/bin/bash

usage()
{
    echo -e "\nUsage: scripts/release.h {all|clean|binary|dist|todo}"
    exit 1
}

error()
{
    echo "ERROR: $1"
    usage
}

prepare()
{
    VERSION=$(grep syx_version configure.ac|head -n 1|awk '{ print $2 }')
    VERSION=${VERSION:1:${#VERSION}-3}
    test -z $VERSION && error "Couldn't determine Syx version"

    MACHINE=$(uname -m)
    test -z $VERSION && error "Couldn't determine host machine"

    RELEASE=syx-${VERSION}
    ARCHIVEDIR=../${RELEASE}

    mkdir -p ${ARCHIVEDIR}
}

make_binary()
{
    BINARY=syx-${VERSION}-bin-${MACHINE}
    DESTDIR=$(pwd)/${BINARY}
    ARCHIVE=${BINARY}.tar.gz
    test -e ${ARCHIVEDIR}/${ARCHIVE} && echo Binary up-to-date && return 0

    make distclean
    ./autogen.sh --prefix=/usr
    make
    make install DESTDIR=$DESTDIR

    tar -czf $ARCHIVE $DESTDIR
    rm -rf $DESTDIR
    mv $ARCHIVE $ARCHIVEDIR
}

make_dist()
{
    ARCHIVE=${RELEASE}.tar.gz
    test -e ${ARCHIVEDIR}/${ARCHIVE} && echo Dist up-to-date && return 0

    make distclean
    ./autogen.sh --enable-wingui
    make dist

    mv $ARCHIVE $ARCHIVEDIR
}

show_todo()
{
    echo "TODO:
1) Make Windows installer
2) Make Windows zip
3) Make Windows CE binaries
4) Deprecate downloads
5) Upload archives
6) Update installation instructions
7) Update release notes
8) Test downloads
9) Update freshmeat
10) Update home wiki
11) Blog post
12) Post do mailing list"
}

make_all()
{
    echo "Making all"
    make_binary
    make_dist
}

prepare

test -z $@ && make_all

for op in $@; do
    case $op in
        clean)
            read -p "Are you sure to rm -rf ${ARCHIVEDIR}? (N/y)"
            test "$REPLY" = "y" && rm -rf $ARCHIVEDIR && echo "Removed"
            ;;
        binary)
            make_binary
            ;;
        dist)
            make_dist
            ;;
        todo)
            show_todo
            ;;
        *)
            usage
            ;;
    esac
done
