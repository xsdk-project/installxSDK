
# Installer for the xSDK toolkit

A goal of the [xSDK](https://ideas-productivity.org/resources/xsdk-docs)
is to simplify the process of working with various xSDK packages in combination.
Thus, the installation script will, by default, download and install four xSDK numerical libraries
([hypre](https://computation.llnl.gov/project/linear_solvers/software.php),
[PETSc](http://www.mcs.anl.gov/petsc),
[SuperLU_dist](http://crd-legacy.lbl.gov/~xiaoye/SuperLU/#superlu_dist), and
[Trilinos](http://trilinos.org))
as well as the following commonly needed external packages
([boost](https://www.boost.org/),
[HDF5](https://www.hdfgroup.org/HDF5/),
[NetCDF](http://www.unidata.ucar.edu/software/netcdf/),
[exodusii](https://github.com/gsjaardema/seacas),
[METIS](http://glaros.dtc.umn.edu/gkhome/metis/metis/overview), and
[ParMETIS](http://glaros.dtc.umn.edu/gkhome/metis/parmetis/overview)). 

* To prevent downloading a particular package, add the argument \-\-download-xxx=0, for example, \-\-download-trilinos=0 
* To use an already installed package, add the argument \-\-with-xxx-dir=/dir, for example, \-\-with-boost-dir=/usr/local
* To install a subset of packages, you must turn off all packages you do not want.
    
##Obtaining the installation script


      git clone https://github.com/xsdk-project/installxSDK.git   or

      curl https://raw.githubusercontent.com/xsdk-project/installxSDK/master/installxSDK.sh > installxSDK.sh
      
##Usage
    
      sh ./installxSDK --prefix="installation directory" [other configure options]

##Example

      sh ./installxSDK --prefix=/usr/local/xSDK --with-mpicc=/usr/local/mpich/bin/mpicc --with-mpicxx=/usr/local/mpich/bin/mpicxx --with-mpif90=/usr/local/mpich/bin/mpif90

##Useful Options
    
    --download-mpich  Useful if you do not have an MPI installed on your machine.

    --with-blaslapack-dir="directory to locate BLAS and LAPACK"   Usually you should not need this.

    --with-git=0 Do not use git to download any of the packages; use the tarballs instead.

    --disable-debug  Build optimized version of libraries (debug is the default).

    --with-boost-dir="directory where boost is installed"  Boost takes forever to install so this is a good option to use if you have boost installed already.

    --with-trilinos=0   Intall xSDK except for Trilinos (Boost is also not installed since it is needed only by Trilinos).

    --download-xxx=/directoryname Add your own package to be automatically downloaded and  
    installed. /directoryname/xxx.py should contain a subclass of config.package.GNUPackage,  
    config.package.CMakePackage, or config.package.Package containing specific information  
    about your package, its download location and dependencies. See, for example,  
    http://www.mcs.anl.gov/petsc/petsc-dev/config/BuildSystem/config/packages/hypre.py, 
    http://www.mcs.anl.gov/petsc/petsc-dev/config/BuildSystem/config/packages/metis.py, or 
    http://www.mcs.anl.gov/petsc/petsc-dev/config/BuildSystem/config/packages/triangle.py. 
    This functionality was suggested by Ethan Coon.

#Application-Specific Installs

The script can install the 
[Alquimia](https://github.com/LBL-EESA/alquimia-dev) xSDK geochemistry package and the
[PFlotran](http://www.pflotran.org) chemistry engine.

The script can also install external packages needed by the 
[Amanzi](https://software.lanl.gov/ascem/amanzi) application.

## Application-specific installs

[examples go here]
[examples go here]


##Notes
  
    Use a different prefix for debug and optimized builds.

    Except for a couple of minor exceptions, this script will NOT rebuild packages that  
    have not changed between calls to the script. Thus, calling it a second time with the  
    same prefix will be much faster.

    This script has very little automatic management of dependencies or version management.

