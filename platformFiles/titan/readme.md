
OLCF Titan
----------

OLCF Titan is a Cray XK6 system. login/service nodes run SUSE Linux on AMD
Istanbul CPUs. Compute nodes run Cray's Compute Node Linux (see CNL in
architecture specification) on AMD Interlagos CPUs with NVIDIA Kepler K20 GPUs.

Cray and System Modules
-----------------------

Cray and OLCF staff provide a number of modules that complement some of the
dependencies required by xSDK 0.4.0. Some of them can be used directly and
results in successful builds. Other modules, on the other hand, have to be
either disabled or their environment has to be modified. The modifications are
necessary to prevent interference with Spack's build environment. See PBS
submission scripts to see how to use Cray's CMake module and modify the
variables it injects into build environment. This is described in more detail
in this Github issue: https://github.com/spack/spack/issues/7629

Building for Service/Login Nodes
--------------------------------

Compiling for service/login nodes must use different compilers because Cray
software tools try to generate the most optimal code. This will often result in
using instruction specific for the target CPU and will not run on another CPU.
Spack uses Cray wrappers for compilers and linkers and it is only possible to
change their behavior to some extent with environment variables starting with
CRAYPE such as ``CRAYPE_LINK_TYPE``.

Building for Compute Nodes
--------------------------

Most of Spack packages is built for use on compute nodes and won't run on
service/login nodes due to ``Illegal instruction`` error. This is why it is
essential to compile some packages separately if they need to execute code
during build. This will manifest itself with an error ``Compiler cannot create
executables`` during configuration of such package. The configuration tests try
to compile and run a test code and the resulting executable fails with
``Illegal instruction``. Note: it is not always possible to mark the package
for cross-compilation to avoid such issues.

Building SuiteSparse
--------------------

I had to disable deal.II when building xSDK 0.4.0 like so:

spack install xsdk~dealii

because deal.II requires SuiteSparse unconditionally.

The problem with building SuiteSparse on Titan is the following error:

    /sw/xk6/xalt/0.7.5/bin/ld: line 152: [: too many arguments
    /sw/xk6/xalt/0.7.5/bin/ld: line 175: $LINKLINE_OUT: ambiguous redirect

The Cray linker is a shell script and it has a problem with this
link line in SuiteSparse/UMFPACK/Makefile

     $(CC) $(SO_OPTS) $^ -o $@ $(LDLIBS)

$^ pulls in too many UMFPACK object files.

This failed for me with both tool chains: compute and login node.

There are CMake scripts in some locations of SuiteSparse (metis,
GraphBLAS, Mongoose) but Spack package treats the whole thing
generically and relies on the above logic.

I tried to replicate it on CentOS Linux but the issue is Cray-specific.
