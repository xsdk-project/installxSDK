#!/bin/sh

PREFIX="notset"
WITHGIT="git"
SKIPMAKE="0"
for i in "$@"
  do
  case $i in
    -h|--help)
      echo "xSDK Installer help:"
      echo "--prefix=\"installation directory\" [--download-ideas] [other standard configure options such as mpicc=  etc]"
      SKIPMAKE="1"
      PREFIX="dummy"      
    ;;
    --prefix=*)
      PREFIX="${i#*=}"
      if [ "${PREFIX}" == "/usr" ]; then
        echo "Do not use /usr as your --prefix install location"
        exit
      fi
      if [ "${PREFIX}" == "/usr/local" ]; then
        echo "Do not use /usr/local as your --prefix install location"
        exit
      fi
    ;;
    --with-git=*)
	WITHGIT="${i#*=}"
    ;;
    --download-pflotran|--download-ideas)
      SKIPMAKE="1"
    ;;					 
    --download-pflotran=*|--download-ideas=*)
      SKIPMAKE="${i#*=}"
    ;;
    *)
            # unknown option
    ;;
  esac
done

if [ "${PREFIX}" == "notset" ]; then
  echo "You must provide a --prefix=\"installation directory\" option"
  exit
fi
 
# make directory where builds will occur
if [ ! -d xsdk ]; then
  mkdir xsdk
  printf "Creating work directory xsdk for all temporary files"  
fi
cd xsdk

# This currently requires git, for the release version it will be optional
# TODO check for --with-git=0 option indicating to obtain PETSc from a tarball and not the git repository

#PETSC_BRANCH='barry/downloads'
# Get PETSc
if [ ! -d petsc ]; then
  if [ "${WITHGIT}" != "0" ]; then
    ${WITHGIT} clone https://bitbucket.org/petsc/petsc.git petsc
  else
    echo "Add code to obtain PETSc tarball"
    exit
  fi
fi
cd petsc
git fetch
#git checkout $PETSC_BRANCH
git pull


# Install the packages
export PETSC_DIR=`pwd`
./configure --download-xsdk $*
if [ "${SKIPMAKE}" == "0" ]; then
  make
  make install
fi

