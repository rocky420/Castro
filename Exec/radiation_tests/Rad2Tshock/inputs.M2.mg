# ------------------  INPUTS TO MAIN PROGRAM  -------------------
max_step  = 3000    # maximum timestep
stop_time = 0.08
#max_step = 1

geometry.is_periodic = 0 0 0

geometry.coord_sys = 0  # 0 => cart, 1 => RZ, 2 => Spherical

geometry.prob_lo   =   -1000. 0.0   0.0
geometry.prob_hi   =     500. 93.75 93.75

amr.n_cell   = 128  8  8
#amr.n_cell   = 512  8  8

# REFINEMENT / REGRIDDING
amr.max_level       = 2       # maximum level number allowed
amr.ref_ratio       = 2 2 2 2 2 2 # refinement ratio
amr.regrid_int      = 2 2 2 2 2 2 # how often to regrid
amr.blocking_factor = 8       # block factor in grid generation
amr.max_grid_size   = 64
amr.n_error_buf     = 2 2 2 2 2 2 # number of buffer cells in error est
amr.n_proper        = 1       # default value
amr.grid_eff        = 0.7     # what constitutes an efficient grid

# CHECKPOINT FILES
amr.check_file      = chk     # root name of checkpoint file
amr.check_int       = 1000      # number of timesteps between checkpoints

# PLOTFILES
amr.plot_file       = plt_
amr.plot_int        = 500     # number of timesteps between plot files
amr.derive_plot_vars = ALL

# PROBIN FILENAME
amr.probin_file     = probin.M2

# VERBOSITY
amr.v = 1
amr.grid_log        = grdlog  # name of grid logging file

# >>>>>>>>>>>>>  BC FLAGS <<<<<<<<<<<<<<<<
# 0 = Interior           3 = Symmetry
# 1 = Inflow             4 = SlipWall
# 2 = Outflow            5 = NoSlipWall
# >>>>>>>>>>>>>  BC FLAGS <<<<<<<<<<<<<<<<
castro.lo_bc       =  1    4    4
castro.hi_bc       =  1    4    4

# WHICH PHYSICS
castro.do_grav        = 0
castro.do_hydro       = 1
castro.do_radiation   = 1
castro.do_reflux      = 1       # 1 => do refluxing
castro.do_react       = 0       # reactions?

# hydro cutoff parameters
castro.small_dens     = 1.e-20

# External source terms
castro.add_ext_src=0            #  Add external source terms

# TIME STEP CONTROL
castro.cfl            = 0.8     # cfl number for hyperbolic system
castro.init_shrink    = 0.1     # scale back initial timestep
castro.change_max     = 1.1 
#castro.initial_dt     = 0.01
castro.dt_cutoff      = 1.e-20  # level 0 timestep below which we halt
#castro.fixed_dt       = 1.e-15

# DIAGNOSTICS & VERBOSITY
castro.sum_interval   = 1       # timesteps between computing mass
castro.v = 1

# ------------------  INPUTS TO RADIATION CLASS  -------------------

##### SolverType #####
# 0: single group diffusion w/o coupling to hydro
# 5: SGFLD       6: MGFLD
radiation.SolverType = 6

radiation.nGroups = 16
radiation.lowestGroupHz = 1.e10
radiation.highestGroupHz = 2.e14

radiation.accelerate = 1

radiation.do_fspace_advection = 1
radiation.Er_Lorentz_term = 0

# RADIATION TOLERANCES
radiation.reltol  = 1.e-6 # relative tolerance for implicit update loop
radiation.abstol  = 0.0   # absolute tolerance for implicit update loop
radiation.maxiter = 50    # return after numiter iterations if not converged
radiation.maxInIter = 30      # return after numiter iterations if not converged

# RADIATION LIMITER
radiation.limiter = 0     # 0 = no limiter
                          # 2 = correct form of Lev-Pom limiter
# RADIATION VERBOSITY
radiation.v               = 2    # verbosity

# We set radiation boundary conditions directly since they do not
# correspond neatly to the physical boundary conditions used for the fluid.
# The choices are:
# 101 = LO_DIRICHLET           102 = LO_NEUMANN
# 104 = LO_MARSHAK             105 = LO_SANCHEZ_POMRANING

radiation.lo_bc     = 101 102 102
radiation.hi_bc     = 101 102 102

# For each boundary, we can specify either a constant boundary value
# or use a Fortran function FORT_RADBNDRY to specify values that vary
# in space and time.

# If bcflag is 0 then bcval is used, otherwise FORT_RADBNDRY used:

radiation.lo_bcflag = 0 0 0
radiation.hi_bcflag = 0 0 0

# bcval is interpreted differently depending on the boundary condition
# 101 = LO_DIRICHLET           bcval is Dirichlet value of rad energy density
# 102 = LO_NEUMANN             bcval is inward flux of rad energy
# 104 = LO_MARSHAK             bcval is incident flux
# 105 = LO_SANCHEZ_POMRANING   bcval is incident flux

# radiation.lo_bcval = 0 0 0
# radiation.hi_bcval = 0 0 0

radiation.lo_bcval0 = 3.27517624962438426E-014 2.82440556862939748E-013
2.42497757527818012E-012 2.06318928406580997E-011
1.72250911764424658E-010 1.38202167847469962E-009
1.01793273622194353E-008 6.19571982820059287E-008
2.42768244637479146E-007 3.56904140550843428E-007
8.25303873091818086E-008 6.56183715461762625E-010
4.87717642913733243E-015 0.0000000000000000 0.0000000000000000
0.0000000000000000

radiation.hi_bcval0 = 6.81835171549573965E-014 5.89264374490598366E-013
5.08186972919117823E-012 4.36362483925191109E-011
3.71336974330742538E-010 3.10153934709458830E-009
2.49072764340988082E-008 1.83820016696180237E-007
1.12388723649004627E-006 4.45002562914824121E-006
6.68776736496742209E-006 1.60756203455526885E-006
1.37837403056099864E-008 1.20077008435698872E-013 0.0000000000000000
0.0000000000000000

radiation.do_real_eos = 1

# Power-law opacities are represented as:
#
#    const_kappa * (rho**m) * (temp**(-n)) * (nu**(p))
#
# Since the formula is both nonphysical and singular, prop_temp_floor
# provides a floor for the temperature used in the power-law computation.

# Planck mean opacity 
radiation.const_kappa_p =  3.92663697758e-05 

# Rosseland mean opacity = 0.848902853095
# for MGFLD, kappa_r = kappa_p + scattering
radiation.const_scattering =  0.84886358672522422

# ------------------  INPUTS TO RADIATION SOLVER CLASS  -------------------

# solver flag values <  100 use HypreABec, support symmetric matrices only
# solver flag values >= 100 use HypreMultiABec, support nonsymmetric matrices
#
# PFMG does not supprt 1D.
# ParCSR does not work for periodic boundaries.
# For MGFLD with accelerate = 2, must use >=100.
#
# 0     SMG
# 1     PFMG  (>= 2D only)
# 100   AMG   using ParCSR ObjectType
# 102   GMRES using ParCSR ObjectType
# 103   GMRES using SStruct ObjectType
# 104   GMRES using AMG as preconditioner
# 109   GMRES using Struct SMG/PFMG as preconditioner
# 150   AMG   using ParCSR ObjectType
# 1002  PCG   using ParCSR ObjectType
# 1003  PCG   using SStruct ObjectType

radsolve.level_solver_flag = 0   # can be any supported hypre solver flag

radsolve.reltol     = 1.0e-11 # relative tolerance
radsolve.abstol     = 0.0     # absolute tolerance (often not necessary)
radsolve.maxiter    = 200     # linear solver iteration limit

radsolve.v = 1      # verbosity

hmabec.verbose = 1  # verbosity for HypreMultiABec solvers
habec.verbose  = 1  # verbosity for HypreABec solvers

#
# The default strategy is SFC.
#
DistributionMapping.strategy = ROUNDROBIN
DistributionMapping.strategy = KNAPSACK
DistributionMapping.strategy = SFC
