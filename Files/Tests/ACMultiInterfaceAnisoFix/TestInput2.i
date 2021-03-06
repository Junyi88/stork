#=======================================================
#:Global Params
[GlobalParams]
  outputs = exodus
  penalty = 1e3
[]

#=======================================================
#:Mesh
[Mesh] #Mesh: Generate Mesh
  type = GeneratedMesh
  dim = 2
  elem_type = QUAD4
  nx = 50
  ny = 50
  nz = 0
  xmin = 0
  xmax = 5.0e1
  ymin = 0
  ymax = 5.0e1
  zmin = 0
  zmax = 0
[]

#=======================================================
#:Variables
[Variables]
 [./eta1] # Liquid
   order = FIRST
   family = LAGRANGE
 [../]
 [./eta2] # Beta
   order = FIRST
   family = LAGRANGE
 [../]

 [./c]
   order = FIRST
   family = LAGRANGE
 [../]
 [./w]
   order = FIRST
   family = LAGRANGE
 [../]

 [./La_eta]
   order = FIRST
   family = LAGRANGE
 [../]
[]


#=======================================================
#:ICs
[ICs]
  [./eta1_IC]
    3D_spheres             = 0
    enable                 = 1
    invalue                = 0.01
    outvalue               = 0.99
    radius                 = 8
    type                   = SmoothCircleIC
    variable               = eta1
    x1                     = 25.0
    y1                     = 25.0
    z1                     = 0
  [../]
  [./eta2_IC]
    3D_spheres             = 0
    enable                 = 1
    invalue                = 0.99
    outvalue               = 0.01
    radius                 = 8
    type                   = SmoothCircleIC
    variable               = eta2
    x1                     = 25.0
    y1                     = 25.0
    z1                     = 0
  [../]
  [./c_IC]
    3D_spheres             = 0
    enable                 = 1
    invalue                = 0.3
    outvalue               = 0.3
    radius                 = 8
    type                   = SmoothCircleIC
    variable               = c
    x1                     = 25.0
    y1                     = 25.0
    z1                     = 0
  [../]
[]

#=======================================================
#:BCs
[BCs]
  [./Periodic]
    [./c_bcs]
      auto_direction = 'x y'
    [../]
  [../]
[]

#=======================================================
#:AuxVariables
[AuxVariables]
  [./Te]
  [../]

  [./Feta1]
    family = MONOMIAL
    order = CONSTANT
  [../]
  [./Feta2]
    family = MONOMIAL
    order = CONSTANT
  [../]
  [./FtotAux]
    family = MONOMIAL
    order = CONSTANT
  [../]

  [./FEta1a]
    family = MONOMIAL
    order = CONSTANT
  [../]
  [./FEta2a]
    family = MONOMIAL
    order = CONSTANT
  [../]
  [./AuxMob]
    family = MONOMIAL
    order = CONSTANT
  [../]
[]

#=======================================================
#:AuxKernels
[AuxKernels]
  [./FunctionAuxTe]
    function                     = '1800.0'
    type                         = FunctionAux
    variable                     = Te
  [../]

  [./TotalFreeEnergy1]
    f_name                       = FLq
    type                         = TotalFreeEnergy
    variable                     = Feta1
  [../]

  [./TotalFreeEnergy2]
    f_name                       = Fbeta
    type                         = TotalFreeEnergy
    variable                     = Feta2
  [../]

  [./TotalFreeEnergy0]
    f_name                       = F
    type                         = TotalFreeEnergy
    variable                     = FtotAux
  [../]

  [./MaterialRealAuxEta1]
    execute_on                   = LINEAR                      # Set to (nonlinear|linear|timestep_end|timestep_begin|custom) to execute ...
    property                     = FLq                 # The scalar material property name
    type                         = MaterialRealAux
    variable                     = FEta1a                  # The name of the variable that this object applies to
  [../]
  [./MaterialRealAuxEta2]
    execute_on                   = LINEAR                      # Set to (nonlinear|linear|timestep_end|timestep_begin|custom) to execute ...
    property                     = Fbeta                  # The scalar material property name
    type                         = MaterialRealAux
    variable                     = FEta2a                  # The name of the variable that this object applies to
  [../]
  [./MaterialRealAuxMob]
    execute_on                   = LINEAR                      # Set to (nonlinear|linear|timestep_end|timestep_begin|custom) to execute ...
    property                     = M                  # The scalar material property name
    type                         = MaterialRealAux
    variable                     = AuxMob                  # The name of the variable that this object applies to
  [../]
[]


#=======================================================
#:Materials
[Materials]
  # Shared Constants
  [./consts]
    type = GenericConstantMaterial
    prop_names  = 'Leta  kappaEta kappaEta2 kappa_c'
    prop_values = '0.64e15 10.0e-16 10.0e-15  10.0e-18'
        #prop_values = '0.64e15 7.91e-9  0.0'
  [../]

  #=====================================================================
  # AllenCahn Stuff
  # Swtiching and well functions
  [./switching1]
    type = SwitchingFunctionMaterial
    function_name = h1
    eta = eta1
    h_order = HIGH
    outputs = none
  [../]
  [./switching2]
    type = SwitchingFunctionMaterial
    function_name = h2
    eta = eta2
    h_order = HIGH
    outputs = none
  [../]


  [./CrossTermBarrierFunctionMaterial]
    W_ij                         = '0 2.5e-15
                                    2.5e-15  0'
    etas                         = 'eta1 eta2'
    function_name                = getas
    g_order                      = SIMPLE
    type                         = CrossTermBarrierFunctionMaterial
    outputs = none
  [../]

  [./free_energy]
    type = DerivativeMultiPhaseMaterial
    f_name = F
    fi_names = 'FLq  Fbeta'
    hi_names = 'h1  h2'
    etas     = 'eta1 eta2'
    args = 'Te c'
    g=getas
    W = 1.0
    derivative_order             = 2
    outputs = none
  [../]

  [./hL1]
    type = DerivativeParsedMaterial
    f_name = hL1
    function = 'eta1'
    args = 'eta1'
    outputs = none
    derivative_order             = 1
    outputs = none
  [../]
  [./hL2]
    type = DerivativeParsedMaterial
    f_name = hL2
    function = 'eta2'
    args = 'eta2'
    outputs = none
    derivative_order             = 1
    outputs = none
  [../]

  #----------------------------------------------------
  # Energies
  [./f_liquid]
    type = DerivativeParsedMaterial
    f_name = FLq
    args = 'c Te'
    derivative_order             = 2
    constant_names = 'p00 p01 p02 p03
                       p04 p05 p10 p11
                       p12 p13 p14 p20
                       p21 p22 p23 p30
                       p31 p32 p40 p41
                       p50 Magni'
    constant_expressions = '8.7780161556e+03 -1.2269392908e+01 -5.3974669165e-02
                            2.3795971676e-05 -7.0373969388e-09 8.5029289714e-13
                            -1.1908549357e+05 9.2784159449e+00 2.9882766850e-03
                            -1.9724115037e-06 6.1486768166e-10 1.6527400000e+05
                            -2.3628252466e+01 -3.3241082786e-15 8.1998878285e-19
                            -1.4167800000e+05 6.0696870799e+01 2.9710053783e-16
                            9.4452000000e+04 -5.0052435399e+01 1.7972457986e-09
                            1e-16'
    function = 'Magni*(p00+p01*Te+(p02*(Te^2))+(p03*(Te^3))+
                 (p04*(Te^4))+(p05*(Te^5))+
                 c*(p10+p11*Te+(p12*(Te^2))+(p13*(Te^3))+(p14*(Te^4)))+
                 (c^2)*(p20+p21*Te+(p22*(Te^2))+(p23*(Te^3)))+
                 (c^3)*(p30+p31*Te+(p32*(Te^2)))+
                 (c^4)*(p40+p41*Te)+(c^5)*p50)'
    outputs = none
  [../]

  [./Fbeta]
    type = DerivativeParsedMaterial
    f_name = Fbeta
    args = 'c Te'
    derivative_order             = 2
    constant_names = 'p00 p01 p02 p03
                       p04 p05 p10 p11
                       p12 p13 p14 p20
                       p21 p22 p23 p30
                       p31 p32 p40 p41
                       p50 Magni'
    constant_expressions = '4.0403477073e+03 -1.5383307606e+01 -5.0132828567e-02
                            2.2316045634e-05 -6.3380061813e-09 7.4811009307e-13
                            -1.3873501737e+05 4.5270933220e+01 -1.6255753482e-02
                            -7.8166312425e-08 5.7006371612e-10 5.4012870345e+04
                            1.6555043548e+01 2.2241561125e-02 -1.7709187604e-06
                            2.4341844426e+05 -1.3424422238e+02 -5.6909906122e-03
                            -2.0397528441e+05 7.8394064019e+01 4.7887120626e+04
                            10.0e-17'
    function = 'Magni*(p00+p01*Te+(p02*(Te^2))+(p03*(Te^3))+
                 (p04*(Te^4))+(p05*(Te^5))+
                 c*(p10+p11*Te+(p12*(Te^2))+(p13*(Te^3))+(p14*(Te^4)))+
                 (c^2)*(p20+p21*Te+(p22*(Te^2))+(p23*(Te^3)))+
                 (c^3)*(p30+p31*Te+(p32*(Te^2)))+
                 (c^4)*(p40+p41*Te)+(c^5)*p50)'
    outputs = none
  [../]

  # =====================
  # Mobility
  #==================================================================
  # Cahn hilliard
  # Mobilities
  [./MLq]
    type = ParsedMaterial
    f_name = MLq
    args = 'c Te'
    constant_names = 'Mag Rg D0 Q1'
    constant_expressions = '1e12 8.31451e-3 4.29e-7 36.3'
   function ='Mag*D0*exp(-Q1/(Rg*Te))'
   outputs = none
  [../]

  [./Mbeta]
    type = ParsedMaterial
    f_name = Mbeta
    args = 'c Te'
    constant_names = 'Mag kb Da0 Qa1 Qa2 Db0 Qb1 Qb2'
    constant_expressions = '1e12 8.6173303e-5 3.53e-4 3.4 1335.0 1.94e-4 3.36 1266.0 '
   function ='Mag*(c*Da0*exp(-Qa1/(kb*Te))*exp(Qa2/(kb*Te^2))+
               (1-c)*Db0*exp(-Qb1/(kb*Te))*exp(Qb2/(kb*Te^2)))'
   outputs = none
  [../]
  [./Mob]
    type = ParsedMaterial
    f_name = M
    args = 'c eta1 eta2 Te'
    material_property_names = 'MLq:=MLq(c,Te)
                               Malpha:=Malpha(c,Te)
                               Mbeta:=Mbeta(c,Te)
                               Malpha2:=Malpha2(c,Te)
                               Mgamma:=Mgamma(c,Te)
                               d2F:=D[F(Te,c),c,c]'
  function ='(sqrt(eta1^2)*MLq+sqrt(eta2^2)*Mbeta)/d2F'
   outputs = none
  [../]
[]

[Kernels]

  #==========================================================
  # Concentration
  # Cs
  [./w_dot]
    variable = w
    v = c
    type = CoupledTimeDerivative
  [../]
  [./coupled_res]
    args = 'eta1 eta2 Te c'
    variable = w
    type = SplitCHWRes
    mob_name = M
  [../]
  [./coupled_parsed]
    args = 'eta1 eta2 Te'
    variable = c
    type = SplitCHParsed
    f_name = F
    kappa_name = kappa_c
    w = w
  [../]


  #--------------------------------------------------------------------------
  # Allen-Cahn Equation
  # Eta1
  [./eta1_dot]
    type                         = TimeDerivative
    variable                     = eta1
  [../]
  [./ACBulk1]
    type = AllenCahn
    variable = eta1
    args = 'eta2 Te c'
    mob_name = Leta
    f_name = F
  [../]
  [./ACInterface1]
    type = ACMultiInterfaceAnisoFix
    variable = eta1
    etas = 'eta1 eta2'
    mob_name = Leta
    kappa_names = 'kappaEta kappaEta kappaEta2 kappaEta2'
  [../]
  [./SwitchingFunctionConstraintEta1]
    h_name                       = hL1
    implicit                     = 1
    lambda                       = La_eta
    type                         = SwitchingFunctionConstraintEta
    variable                     = eta1
  [../]

  #--------------------------------------------------------------------------
  # Allen-Cahn Equation
  # Eta2
  [./eta2_dot]
    type                         = TimeDerivative
    variable                     = eta2
  [../]
  [./ACBulk2]
    type = AllenCahn
    variable = eta2
    args = 'eta1 Te c'
    mob_name = Leta
    f_name = F
  [../]
  [./ACInterface2]
    type = ACMultiInterfaceAnisoFix
    variable = eta2
    etas = 'eta1 eta2'
    mob_name = Leta
    kappa_names = 'kappaEta kappaEta kappaEta2 kappaEta2'
  [../]
  [./SwitchingFunctionConstraintEta2]
    h_name                       = hL2
    implicit                     = 1
    lambda                       = La_eta
    type                         = SwitchingFunctionConstraintEta
    variable                     = eta2
  [../]


  #--------------------------------------------------------------------------
  # Langrange Eta
  [./SwitchingFunctionConstraintLagrange]
    enable                       = 1
    epsilon                      = 1e-09
    etas                         = 'eta1 eta2'
    #h_names                      = 'h1 h2 h3 h4 h5'
    h_names                      = 'hL1 hL2'
    type                         = SwitchingFunctionConstraintLagrange
    variable                     = La_eta
  [../]
[]

##===============================================================
##: Postprocessors
#[Postprocessors]
#  [./ave_stress_bottom]
#    type = SideAverageValue
#    variable = stress_zz
#    boundary = bottom
#  [../]
#  [./ave_strain_bottom]
#    type = SideAverageValue
#    variable = total_strain_zz
#    boundary = bottom
#  [../]
#[]

##===============================================================
##: Preconditioning
[Preconditioning]
  [./coupled]
    type = SMP
    full = true
  [../]
[]

##===============================================================
##: Executioner
[Executioner]
  type = Transient
  solve_type = 'NEWTON'  # OR PJFNK
  petsc_options_iname = '-pc_type -sub_pc_type -sub_pc_factor_shift_type'
  petsc_options_value = 'asm      ilu          nonzero'
  l_max_its = 30
  nl_max_its = 20
  nl_abs_tol = 1e-8
  end_time = 2.2
   dtmax   = 1.0e-4
   start_time                 = 0.0
 [./TimeStepper]
    # Turn on time stepping
    type = IterationAdaptiveDT
    dt = 1.0e-5
    cutback_factor = 0.8
    growth_factor = 1.5
    optimal_iterations = 12
  [../]
[]

##===============================================================
##: Outputs
[Outputs]
  interval                       = 1
  exodus = true
  console = true
  print_perf_log = true
  output_initial = true
  print_linear_residuals         = 0
[]
