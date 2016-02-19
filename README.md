
# Installer for the xSDK toolkit

This script will, by default, download and install
[hypre](https://computation.llnl.gov/project/linear_solvers/software.php),
[PETSc](http://www.mcs.anl.gov),
[SuperLU_dist](http://crd-legacy.lbl.gov/~xiaoye/SuperLU/#superlu_dist),
[Trilinos](http://trilinos.org),
as well as commonly needed dependent packages, 
[boost](https://www.boost.org/),
[hdf5](https://www.hdfgroup.org/HDF5/),
[netcdf](http://www.unidata.ucar.edu/software/netcdf/),
[exodusii](https://github.com/gsjaardema/seacas),
[metis](http://glaros.dtc.umn.edu/gkhome/metis/metis/overview), and
[parmetis](http://glaros.dtc.umn.edu/gkhome/metis/parmetis/overview). To prevent downloading a particular package add the argument \-\-download-xxx=0, for example, \-\-download-trilinos=0 
    
##Obtaining the script


      git clone https://github.com/xsdk-project/installxSDK.git   or

      curl https://raw.githubusercontent.com/xsdk-project/installxSDK/master/installxSDK.sh > installxSDK.sh
      
##Usage
    
      sh ./installxSDK --prefix="installation directory" [other configure options]

      [Explain xSDK here.]

##Example

      sh ./installxSDK --prefix=/usr/local/xSDK --with-mpicc=/usr/local/mpich/bin/mpicc --with-mpicxx=/usr/local/mpich/bin/mpicxx --with-mpif90=/usr/local/mpich/bin/mpif90

##Useful Options
    
    --download-mpich  Useful if you do not have an MPI installed on your machine

    --with-blaslapack-dir="directory to locate BLAS and LAPACK"   Usually you should not need this

    --with-git=0 Do not use git to download any of the packages, use the tarballs instead

    --disable-debug  Build optimized version of libraries (debug is the default)

    --with-boost-dir="directory where boost is installed"  Boost takes forever to install so this is a good option to use if you have boost installed already

    --with-trilinos=0   Intall xSDK except for Trilinos (Boost is also not installed since it is only needed by Trilinos)

    --download-xxx=/directoryname Add your own package to be automatically downloaded and installed. /directoryname/xxx.py should contain a subclass of config.package.GNUPackage, config.package.CMakePackage, or config.package.Package containing specific information about your package, its download location and dependencies. See, for example, http://www.mcs.anl.gov/petsc/petsc-dev/config/BuildSystem/config/packages/hypre.py, http://www.mcs.anl.gov/petsc/petsc-dev/config/BuildSystem/config/packages/metis.py, or http://www.mcs.anl.gov/petsc/petsc-dev/config/BuildSystem/config/packages/triangle.py This functionality was suggested by Ethan Coon.

##Notes
  
    Use a different prefix for debug and optimized builds

    Except for a couple of minor exceptions this script will NOT rebuild packages that have not changed between calls to the script, thus calling it a second time with the same prefix will be much faster.

    This script has very little automatic management of dependencies or version management.
