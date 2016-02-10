#!/bin/sh

if [ $# = 1 ]; then
  if [ $1 == "--help" ]; then
    echo "xSDK Installer help:"
    echo "--prefix=\"installation directory\" [--download-ideas] [other standard configure options such as mpicc=  etc]"
    exit
  fi  
fi

# make directory where builds will occur
if [ ! -d xsdk ]; then
  mkdir xsdk
  printf "Creating work directory xsdk for all temporary files"  
fi
cd xsdk

# This currently requires git, for the release version it will be optional
# TODO check for --with-git=0 option indicating to obtain PETSc from a tarball and not the git repository

PETSC_BRANCH='barry/downloads'
# Get PETSc
if [ ! -d petsc ]; then
  git clone https://bitbucket.org/petsc/petsc.git petsc
fi
cd petsc
git fetch
git checkout $PETSC_BRANCH
git pull


# Install the packages
export PETSC_DIR=`pwd`
./configure --download-xsdk $*
make
make install

# the make and make install are not needed and should not be passed if --download-plotran (and hence --download-ideas) is passed

