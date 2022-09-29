#!/bin/sh -e

VERSION=$2
DIR=gluegen-v$VERSION
TAR=gluegen2_$VERSION.orig.tar.xz

# clean up the upstream tarball
tar xvf $3
cd $DIR
rm -rf .gitignore .htaccess make/lib/
rm -f $(find . -iname '*.jar')
cd ..
# download jcpp
wget http://jogamp.org/deployment/jogamp-current/archive/Sources/jcpp-v$VERSION.tar.xz
tar xvf jcpp-v$VERSION.tar.xz -C $DIR/jcpp --strip 1

XZ_OPT=--best tar Jcvf ../$TAR $DIR
rm -rf $DIR jcpp-v$VERSION.tar.xz

# move to directory 'tarballs'
if [ -r .svn/deb-layout ]; then
    . .svn/deb-layout
    mv $TAR $origDir
    echo "moved $TAR to $origDir"
fi

exit 0
