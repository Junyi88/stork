#====================================================================
# Global Params
[GlobalParams]
  outputs = exodus
  penalty = 1e3
  displacements = 'disp_x disp_y'
[]

#====================================================================
# Mesh
[Mesh]
  type = GeneratedMesh
  dim = 2
  elem_type = QUAD4
  nx = 200
  ny = 200
  nz = 0
  xmin = 0
  xmax = 1.0e1
  ymin = 0
  ymax = 1.0e1
  zmin = 0
  zmax = 0
[]

#====================================================================
# Variables
[Variables]

  [./disp_x]
  [../]
  [./disp_y]
  [../]

  # order parameter
  [./eta1]
    order = FIRST
    family = LAGRANGE
  [../]

  [./eta2]
    order = FIRST
    family = LAGRANGE
  [../]

  [./eta3]
    order = FIRST
    family = LAGRANGE
  [../]

  [./eta4]
    order = FIRST
    family = LAGRANGE
  [../]

  [./eta51]
    order = FIRST
    family = LAGRANGE
  [../]
  [./eta52]
    order = FIRST
    family = LAGRANGE
  [../]
  [./eta53]
    order = FIRST
    family = LAGRANGE
  [../]
  [./eta54]
    order = FIRST
    family = LAGRANGE
  [../]
  [./eta55]
    order = FIRST
    family = LAGRANGE
  [../]
  [./eta56]
    order = FIRST
    family = LAGRANGE
  [../]

  [./La_eta]
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
[]

[ICs]
  #====================================================================
  [./ConstantIC_0_eta1]
    type                         = ConstantIC
    value                        = 0.91
    variable                     = eta1
  [../]
  [./ConstantIC_0_eta2]
    type                         = ConstantIC
    value                        = 0.01
    variable                     = eta2
  [../]
  [./ConstantIC_0_eta3]
    type                         = ConstantIC
    value                        = 0.01
    variable                     = eta3
  [../]
  [./ConstantIC_0_eta4]
    type                         = ConstantIC
    value                        = 0.01
    variable                     = eta4
  [../]
  [./ConstantIC_0_eta51]
    type                         = ConstantIC
    value                        = 0.01
    variable                     = eta51
  [../]
  [./ConstantIC_0_eta52]
    type                         = ConstantIC
    value                        = 0.01
    variable                     = eta52
  [../]
  [./ConstantIC_0_eta53]
    type                         = ConstantIC
    value                        = 0.01
    variable                     = eta53
  [../]
  [./ConstantIC_0_eta54]
    type                         = ConstantIC
    value                        = 0.01
    variable                     = eta54
  [../]
  [./ConstantIC_0_eta55]
    type                         = ConstantIC
    value                        = 0.01
    variable                     = eta55
  [../]
  [./ConstantIC_0_eta56]
    type                         = ConstantIC
    value                        = 0.01
    variable                     = eta56
  [../]

  [./ConstantIC_0_c]
    type                         = ConstantIC
    value                        = 0.46
    variable                     = c
  [../]
[]

#====================================================================
# Boundary Conditions
[BCs]
  [./Periodic]
    [./c_bcs]
      auto_direction = 'x y'
    [../]
  [../]
[]

[UserObjects]
  [./ConservedNormalNoise1]
    execute_on                   = TIMESTEP_BEGIN              # Set to (nonlinear|linear|timestep_end|timestep_begin|custom) to execute ...
    seed                         = 201                           # The seed for the master random number generator
    type                         = ConservedNormalNoise
    use_displaced_mesh           = 0                           # Whether or not this object should use the displaced mesh for computation. .
  [../]
[]

#====================================================================
# AuxVariables
[AuxVariables]
  [./Te]
  [../]

  [./time]
  [../]

  [./CNoise]
    order = FIRST
    family = LAGRANGE
  [../]

  [./eta1Noise]
    order = FIRST
    family = LAGRANGE
  [../]
  [./eta2Noise]
    order = FIRST
    family = LAGRANGE
  [../]
  [./eta3Noise]
    order = FIRST
    family = LAGRANGE
  [../]
  [./eta4Noise]
    order = FIRST
    family = LAGRANGE
  [../]
  [./eta5Noise]
    order = FIRST
    family = LAGRANGE
  [../]
[]

#====================================================================
# AuxKernels
[AuxKernels]
  [./FunctionAux1]
    function                     = '2000.0-1709.0*tanh(9.452*t)'
    #function                     = '2000.0-1706.0*tanh(2.402*time)'
    #function                     = '2000.0-1702.0*tanh(1.111*time)'
    #function                     = '2000.0-1708.0*tanh(0.6115*time)'
    #function                     = '2000.0-1710.0*tanh(0.3942*time)'
    type                         = FunctionAux
    variable                     = Te
  [../]
  [./FunctionAux2]
    function                     = 't'
    type                         = FunctionAux
    variable                     = time
  [../]
[]

##===============================================================
# Materials
[Materials]

  [./elasticity_tensor]
    type = ComputeElasticityTensor
    fill_method                  = symmetric9
    C_ijkl                       = '175.0e1 88.7e1 62.3e1 175.0e1 62.3e1 220.0e1 62.2e1 62.2e1 43.15e1'
  [../]

  [./e1]
    # eigenstrain per Kelvin for crystal 1
    type = GenericConstantRankTwoTensor
    tensor_values = '-0.0277 0.0093 0.0828 0.1768 0 0'
    tensor_name = e1
  [../]
  [./e2]
    # eigenstrain per Kelvin for crystal 2
    type = GenericConstantRankTwoTensor
    tensor_values = '0 -0.0185 0.0828 -0.0884 -0.1531 0.016'
    tensor_name = e2
  [../]
  [./e3]
    # eigenstrain per Kelvin for crystal 2
    type = GenericConstantRankTwoTensor
    tensor_values = '0 -0.0185 0.0828 -0.0884 0.1531 -0.016'
    tensor_name = e3
  [../]
  [./e4]
    # eigenstrain per Kelvin for crystal 2
    type = GenericConstantRankTwoTensor
    tensor_values = '-0.0277 0.0093 0.0828 -0.1768 0 0'
    tensor_name = e4
  [../]
  [./e5]
    # eigenstrain per Kelvin for crystal 2
    type = GenericConstantRankTwoTensor
    tensor_values = '0.0 -0.0185 0.0828 0.0884 0.1531 0.016'
    tensor_name = e5
  [../]
  [./e6]
    # eigenstrain per Kelvin for crystal 2
    type = GenericConstantRankTwoTensor
    tensor_values = '0.0 -0.0185 0.0828 0.0884 -0.1531 -0.016'
    tensor_name = e6
  [../]

  [./func1]
    type = DerivativeParsedMaterial
    # thermal expansion at 300K is zero
    function = eta51^2
    f_name = fe1
    args = 'eta51'
  [../]
  [./func2]
    type = DerivativeParsedMaterial
    # thermal expansion at 300K is zero
    function = eta52^2
    f_name = fe2
    args = 'eta52'
  [../]
  [./func3]
    type = DerivativeParsedMaterial
    # thermal expansion at 300K is zero
    function = eta53^2
    f_name = fe3
    args = 'eta53'
  [../]
  [./func4]
    type = DerivativeParsedMaterial
    # thermal expansion at 300K is zero
    function = eta54^2
    f_name = fe4
    args = 'eta54'
  [../]
  [./func5]
    type = DerivativeParsedMaterial
    # thermal expansion at 300K is zero
    function = eta55^2
    f_name = fe5
    args = 'eta55'
  [../]
  [./func6]
    type = DerivativeParsedMaterial
    # thermal expansion at 300K is zero
    function = eta56^2
    f_name = fe6
    args = 'eta56'
  [../]

  [./eigenstrain]
    type = CompositeEigenstrain
    tensors = 'e1 e2 e3 e4 e5 e6'
    weights = 'fe1 fe2 fe3 fe4 fe5 fe6'
    args = 'eta51 eta52 eta53 eta54 eta55 eta56'
      eigenstrain_name             = EigenStrain
  [../]

  [./ElasticEnergyMaterial]
    args                         = 'eta51 eta52 eta53 eta54 eta55 eta56'                  # Arguments of F() - use vector coupling
    derivative_order             = 3                           # Maximum order of derivatives taken (2 or 3)
    f_name                       = FEl                           # Base name of the free energy function (used to name the material properties)
    outputs                      = exodus                        # Vector of output names were you would like to restrict the output of ...
    type                         = ElasticEnergyMaterial
  [../]

  [./strain]
    type = ComputeSmallStrain
    displacements = 'disp_x disp_y'
  [../]
  [./stress]
    type = ComputeLinearElasticStress
  [../]

  # Shared Constants
  [./consts]
    type = GenericConstantMaterial
    prop_names  = 'Leta  kappaEta kappa_c'
   prop_values = '6.4e2 0.0105e-2  0.0625e-8'
      #prop_values = '6.4e2 0.0625e-2  0.26e-4  0.0625e-6'
  [../]

  # Penalty
    #[./g_eta1]
    #  type = BarrierFunctionMaterial
    #  g_order = SIMPLE
    #  eta = eta1
    #  function_name  = g1
    #  well_only                    = 1
    #[../]
    #[./g_eta2]
    #  type = BarrierFunctionMaterial
    #  g_order = SIMPLE
    #  eta = eta2
    #  function_name  = g2
    #  well_only                    = 1
    #[../]
    #[./g_eta3]
    #  type = BarrierFunctionMaterial
    #  g_order = SIMPLE
    #  eta = eta3
    #  function_name  = g3
    #  well_only                    = 1
    #[../]
    #[./g_eta4]
    #  type = BarrierFunctionMaterial
    #  g_order = SIMPLE
    #  eta = eta4
    #  function_name  = g4
    #  well_only                    = 1
    #[../]
    #[./g_eta5]
    #  type = BarrierFunctionMaterial
    #  g_order = SIMPLE
    #  eta = eta5
    #  function_name  = g5
    #  well_only                    = 1
    #[../]
    #[./Penalty1]
    #  type = DerivativeParsedMaterial
    #  f_name =Pen1
    #  material_property_names = 'g1:=g1(eta1)  g2:=g2(eta2) g3:=g3(eta3)
    #                             g4:=g4(eta4)  g5:=g5(eta5) '
    #  function = '(g1+g2+g3+g4+g5)*0.0'
    #  args = 'eta1 eta2 eta3 eta4 eta5'
    #  derivative_order             = 1
    #  outputs = exodus
    #[../]


  #=====================================================================
  # AllenCahn Stuff
  # Swtiching and well functions
  [./switching1]
    type = SwitchingFunctionMaterial
    function_name = h1
    eta = eta1
    h_order = HIGH
  [../]
  [./switching2]
    type = SwitchingFunctionMaterial
    function_name = h2
    eta = eta2
    h_order = HIGH
  [../]
  [./switching3]
    type = SwitchingFunctionMaterial
    function_name = h3
    eta = eta3
    h_order = HIGH
  [../]
  [./switching4]
    type = SwitchingFunctionMaterial
    function_name = h4
    eta = eta4
    h_order = HIGH
  [../]
  [./switching51]
    type = SwitchingFunctionMaterial
    function_name = h51
    eta = eta51
    h_order = HIGH
  [../]
  [./switching52]
    type = SwitchingFunctionMaterial
    function_name = h52
    eta = eta52
    h_order = HIGH
  [../]
  [./switching53]
    type = SwitchingFunctionMaterial
    function_name = h53
    eta = eta53
    h_order = HIGH
  [../]
  [./switching54]
    type = SwitchingFunctionMaterial
    function_name = h54
    eta = eta54
    h_order = HIGH
  [../]
  [./switching55]
    type = SwitchingFunctionMaterial
    function_name = h55
    eta = eta55
    h_order = HIGH
  [../]
  [./switching56]
    type = SwitchingFunctionMaterial
    function_name = h56
    eta = eta56
    h_order = HIGH
  [../]

  [./barrier]
    type = MultiBarrierFunctionMaterial
    etas = 'eta1 eta2 eta3 eta4 eta51 eta52 eta53 eta54 eta55 eta56'
    function_name                = getas                           # actual name for g(eta_i)
    g_order                      = SIMPLE
    well_only                    = 0
  [../]

  # Total Free Energy
    [./free_energy]
      type = DerivativeMultiPhaseMaterial
      f_name = F
      fi_names = 'FLq  Falpha Fbeta Falpha2 Fgamma Fgamma Fgamma Fgamma Fgamma Fgamma'
      hi_names = 'h1  h2 h3 h4 h51 h52 h53 h54 h55 h56'
      etas     = 'eta1 eta2 eta3 eta4 eta51 eta52 eta53 eta54 eta55 eta56'
      args = 'Te c'
      g=getas
      W = 0.5e-2
    derivative_order             = 2
    [../]

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
   outputs = exodus
  [../]

  [./Malpha]
    type = ParsedMaterial
    f_name = Malpha
    args = 'c Te'
    constant_names = 'Mag kb Da0 Qa1 Db0 Qb1'
    constant_expressions = '1e12 8.6173303e-5 1.35e-3 3.14 6.6e-3 3.41'
   function ='Mag*(c*Da0*exp(-Qa1/(kb*Te))+(1-c)*Db0*exp(-Qb1/(kb*Te)))'
   outputs = exodus
  [../]

  [./Mbeta]
    type = ParsedMaterial
    f_name = Mbeta
    args = 'c Te'
    constant_names = 'Mag kb Da0 Qa1 Qa2 Db0 Qb1 Qb2'
    constant_expressions = '1e12 8.6173303e-5 3.53e-4 3.4 1335.0 1.94e-4 3.36 1266.0 '
   function ='Mag*(c*Da0*exp(-Qa1/(kb*Te))*exp(Qa2/(kb*Te^2))+
               (1-c)*Db0*exp(-Qb1/(kb*Te))*exp(Qb2/(kb*Te^2)))'
   outputs = exodus
  [../]

  [./Malpha2]
    type = ParsedMaterial
    f_name = Malpha2
    args = 'c Te'
    constant_names = 'Mag kb Da0 Qa1 Db0 Qb1'
    constant_expressions = '1e12 8.6173303e-5 2.24e-5 2.99 2.32e-1 4.08'
   function ='Mag*(c*Da0*exp(-Qa1/(kb*Te))+(1-c)*Db0*exp(-Qb1/(kb*Te)))'
   outputs = exodus
  [../]

  [./Mgamma]
    type = ParsedMaterial
    f_name = Mgamma
    args = 'c Te'
    constant_names = 'Mag kb Da0 Qa1 Db0 Qb1'
    constant_expressions = '1e12 8.6173303e-5 1.43e-6 2.59 2.11e-2 3.71'
   function ='Mag*(c*Da0*exp(-Qa1/(kb*Te))+(1-c)*Db0*exp(-Qb1/(kb*Te)))'
   outputs = exodus
  [../]

  [./Mob]
    type = ParsedMaterial
    f_name = M
    args = 'c eta1 eta2 eta3 eta4 eta51 eta52 eta53 eta54 eta55 eta56  Te'
    material_property_names = 'MLq:=MLq(c,Te)
                               Malpha:=Malpha(c,Te)
                               Mbeta:=Mbeta(c,Te)
                               Malpha2:=Malpha2(c,Te)
                               Mgamma:=Mgamma(c,Te)
                               d2F:=D[F(Te,c),c,c]+1e-4
                                h1:=h1(eta1)
                                h2:=h2(eta2)
                                h3:=h3(eta3)
                                h4:=h4(eta4)'
                                #h5:=h5(eta5)'
    #constant_names = 'Rg Mag1'
    #constant_expressions = '8.31451e-3 7.68e9'
  #function ='(eta1*MLq+eta2*Malpha+eta3*Mbeta+eta4*Malpha2+eta5*Mgamma)/d2F'
  function ='(sqrt(eta1^2)*MLq+sqrt(eta2^2)*Malpha+sqrt(eta3^2)*Mbeta+sqrt(eta4^2)*
              Malpha2+sqrt((eta51+eta52+eta53+eta54+eta55+eta56)^2)*Mgamma)/d2F'
  #function ='(h1*MLq+h2*Malpha+h3*Mbeta+h4*Malpha2+h5*Mgamma)/d2F'
  # function ='2.0e2'
   outputs = exodus
  [../]

  # Energy 1
  #----------------------------------------------------
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
                            1e-3'
    function = 'Magni*(p00+p01*Te+(p02*(Te^2))+(p03*(Te^3))+
                 (p04*(Te^4))+(p05*(Te^5))+
                 c*(p10+p11*Te+(p12*(Te^2))+(p13*(Te^3))+(p14*(Te^4)))+
                 (c^2)*(p20+p21*Te+(p22*(Te^2))+(p23*(Te^3)))+
                 (c^3)*(p30+p31*Te+(p32*(Te^2)))+
                 (c^4)*(p40+p41*Te)+(c^5)*p50)'
    outputs = exodus
  [../]

  [./f_alpha]
    type = DerivativeParsedMaterial
    f_name = Falpha
    args = 'c Te'
    derivative_order             = 2
    constant_names = 'p00 p01 p02 p03
                       p04 p05 p10 p11
                       p12 p13 p14 p20
                       p21 p22 p23 p30
                       p31 p32 p40 p41
                       p50 Magni'
    constant_expressions = '-3.1881586246e+03 -6.6454835114e+00 -5.1147191881e-02
                            2.1213860103e-05 -6.0184366866e-09 7.1930122787e-13
                            -1.2873451191e+05 9.1916785814e+00 1.6187664885e-03
                            -1.2801175881e-06 4.4575924138e-10 1.3416400000e+05
                            1.9888747534e+01 -1.0597114675e-15 3.2812054056e-19
                            6.0855776676e-09 -5.7527129201e+01 2.0964865291e-16
                            -4.8483441620e-09 2.8763564601e+01 1.4153994351e-09
                            1e-3'
    function = 'Magni*(p00+p01*Te+(p02*(Te^2))+(p03*(Te^3))+
                 (p04*(Te^4))+(p05*(Te^5))+
                 c*(p10+p11*Te+(p12*(Te^2))+(p13*(Te^3))+(p14*(Te^4)))+
                 (c^2)*(p20+p21*Te+(p22*(Te^2))+(p23*(Te^3)))+
                 (c^3)*(p30+p31*Te+(p32*(Te^2)))+
                 (c^4)*(p40+p41*Te)+(c^5)*p50)'
    outputs = exodus
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
                            1e-3'
    function = 'Magni*(p00+p01*Te+(p02*(Te^2))+(p03*(Te^3))+
                 (p04*(Te^4))+(p05*(Te^5))+
                 c*(p10+p11*Te+(p12*(Te^2))+(p13*(Te^3))+(p14*(Te^4)))+
                 (c^2)*(p20+p21*Te+(p22*(Te^2))+(p23*(Te^3)))+
                 (c^3)*(p30+p31*Te+(p32*(Te^2)))+
                 (c^4)*(p40+p41*Te)+(c^5)*p50)'
    outputs = exodus
  [../]

  [./f_alpha2]
    type = DerivativeParsedMaterial
    f_name = Falpha2
    args = 'c Te'
    derivative_order             = 2
    constant_names = 'p00 p01 p02 p03
                       p04 p05 p10 p11
                       p12 p13 p14 p20
                       p21 p22 p23 p30
                       p31 p32 p40 p41
                       p50 Magni'
    constant_expressions = '-2.1269910087e+03 -7.7644152076e+00 -5.0782482359e-02
                             2.1134355331e-05 -6.0111839349e-09 7.1457143620e-13
                             -1.4728581929e+05 3.3052339895e+01 -1.2705758576e-03
                             -1.4036222737e-06 4.3849455306e-10 1.3254392046e+05
                             -4.6607168697e+01 7.4493154748e-03 3.2820836665e-07
                             1.5834227706e+05 3.1789786285e+00 -5.4311712711e-03
                             -2.4075800686e+05 1.2564474874e+01 1.0140109227e+05
                            1e-3'
    function = 'Magni*(p00+p01*Te+(p02*(Te^2))+(p03*(Te^3))+
                 (p04*(Te^4))+(p05*(Te^5))+
                 c*(p10+p11*Te+(p12*(Te^2))+(p13*(Te^3))+(p14*(Te^4)))+
                 (c^2)*(p20+p21*Te+(p22*(Te^2))+(p23*(Te^3)))+
                 (c^3)*(p30+p31*Te+(p32*(Te^2)))+
                 (c^4)*(p40+p41*Te)+(c^5)*p50)'
    outputs = exodus
  [../]

  [./f_gamma]
    type = DerivativeParsedMaterial
    f_name = Fgamma
    args = 'c Te'
    derivative_order             = 2
    constant_names = 'p00 p01 p02 p03
                       p04 p05 p10 p11
                       p12 p13 p14 p20
                       p21 p22 p23 p30
                       p31 p32 p40 p41
                       p50 Magni'
    constant_expressions = '2.6638132921e+03 -5.9596432918e+00 -5.1919540632e-02
                            2.1787365474e-05 -6.1640114011e-09 7.3786451035e-13
                            -1.2067738847e+05 -1.6973439104e+01 2.2276568302e-03
                            -2.6513855167e-06 4.6705803557e-10 1.3085084300e+05
                            1.4329451979e+02 2.1924007070e-03 1.1798624645e-06
                            -4.0025092112e+05 -1.9871973943e+02 -2.5277310381e-03
                            7.4249390180e+05 7.3850873223e+01 -3.5744112976e+05
                            1e-3'
    function = 'Magni*(p00+p01*Te+(p02*(Te^2))+(p03*(Te^3))+
                 (p04*(Te^4))+(p05*(Te^5))+
                 c*(p10+p11*Te+(p12*(Te^2))+(p13*(Te^3))+(p14*(Te^4)))+
                 (c^2)*(p20+p21*Te+(p22*(Te^2))+(p23*(Te^3)))+
                 (c^3)*(p30+p31*Te+(p32*(Te^2)))+
                 (c^4)*(p40+p41*Te)+(c^5)*p50)'
    outputs = exodus
  [../]


#  Noise
  [./MagNoiseE]
    type = ParsedMaterial
    f_name = MagNoiseEta
    args = 'time'
    #constant_names = 'A B'
    function='2.0'
    #outputs = exodus
  [../]

  [./MagNoiseC]
    type = ParsedMaterial
    f_name = MagNoiseC
    args = 'time'
    #constant_names = 'A B'
    #constant_expressions = '0.001 0.006908'
    function='1.0'
    #outputs = exodus
  [../]

[]


# =======================================================
# Kernels
[Kernels]
  [./TensorMechanics]
      displacements = 'disp_x disp_y'
      eigenstrain_names        = EigenStrain
    [../]
#==========================================================
# Concentration
  # Cs
  [./w_dot]
    variable = w
    v = c
    type = CoupledTimeDerivative
  [../]
  [./coupled_res]
    args = 'eta1 eta2 eta3 eta4 eta51 eta52 eta53 eta54 eta55 eta56 Te c'
    variable = w
    type = SplitCHWRes
    mob_name = M
  [../]
  [./coupled_parsed]
    args = 'eta1 eta2 eta3 eta4 eta51 eta52 eta53 eta54 eta55 eta56 Te'
    variable = c
    type = SplitCHParsed
    f_name = F
    kappa_name = kappa_c
    w = w
  [../]

  [./ConservedLangevinNoise]
    amplitude                    = 1.0
    multiplier                   = MagNoiseC
    noise                        = ConservedNormalNoise1
    seed                         = 201
    type                         = ConservedLangevinNoise
    variable                     = c
    save_in                      = CNoise
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
    args = 'eta2 eta3 eta4 eta51 eta52 eta53 eta54 eta55 eta56 Te c'
    mob_name = Leta
    f_name = F
  [../]
  [./ACInterface1]
    type = ACMultiInterface
    variable = eta1
    etas = 'eta1 eta2 eta3 eta4 eta51 eta52 eta53 eta54 eta55 eta56'
    mob_name = Leta
    kappa_names = 'kappaEta kappaEta kappaEta kappaEta kappaEta kappaEta kappaEta kappaEta kappaEta kappaEta'
  [../]
  [./SwitchingFunctionConstraintEta1]
    h_name                       = h1
    implicit                     = 1
    lambda                       = La_eta
    type                         = SwitchingFunctionConstraintEta
    variable                     = eta1
  [../]
  [./LangevinNoise_eta1]
    amplitude                    = 1.0
    multiplier                   = MagNoiseEta
    seed                         = 1001
    type                         = LangevinNoise
    variable                     = eta1
    save_in                      = eta1Noise
  [../]
  #[./ACBulkPen1]
  #  type = AllenCahn
  #  variable = eta1
  #  args = 'eta2 eta3 eta4 eta5 Te c'
  #  mob_name = Leta
  #  f_name = Pen1
  #[../]

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
    args = 'eta1 eta3 eta4 eta51 eta52 eta53 eta54 eta55 eta56 Te c'
    mob_name = Leta
    f_name = F
  [../]
  [./ACInterface2]
    type = ACMultiInterface
    variable = eta2
    etas = 'eta1 eta2 eta3 eta4 eta51 eta52 eta53 eta54 eta55 eta56'
    mob_name = Leta
    kappa_names = 'kappaEta kappaEta kappaEta kappaEta kappaEta kappaEta kappaEta kappaEta kappaEta kappaEta'
  [../]
  [./SwitchingFunctionConstraintEta2]
    h_name                       = h2
    implicit                     = 1
    lambda                       = La_eta
    type                         = SwitchingFunctionConstraintEta
    variable                     = eta2
  [../]
  [./LangevinNoise_eta2]
    amplitude                    = 1.0
    multiplier                   = MagNoiseEta
    seed                         = 1201
    type                         = LangevinNoise
    variable                     = eta2
    save_in                      = eta2Noise
  [../]
  #[./ACBulkPen2]
  #  type = AllenCahn
  #  variable = eta2
  #  args = 'eta1 eta3 eta4 eta5 Te c'
  #  mob_name = Leta
  #  f_name = Pen1
  #[../]

  #--------------------------------------------------------------------------
  # Allen-Cahn Equation
  # Eta3
  [./eta3_dot]
    type                         = TimeDerivative
    variable                     = eta3
  [../]
  [./ACBulk3]
    type = AllenCahn
    variable = eta3
    args = 'eta1 eta2 eta4 eta51 eta52 eta53 eta54 eta55 eta56 Te c'
    mob_name = Leta
    f_name = F
  [../]
  [./ACInterface3]
    type = ACMultiInterface
    variable = eta3
    etas = 'eta1 eta2 eta3 eta4 eta51 eta52 eta53 eta54 eta55 eta56'
    mob_name = Leta
    kappa_names = 'kappaEta kappaEta kappaEta kappaEta kappaEta kappaEta kappaEta kappaEta kappaEta kappaEta'
  [../]
  [./SwitchingFunctionConstraintEta3]
    h_name                       = h3
    implicit                     = 1
    lambda                       = La_eta
    type                         = SwitchingFunctionConstraintEta
    variable                     = eta3
  [../]
  [./LangevinNoise_eta3]
    amplitude                    = 1.0
    multiplier                   = MagNoiseEta
    seed                         = 1301
    type                         = LangevinNoise
    variable                     = eta3
    save_in                      = eta3Noise
  [../]
  #[./ACBulkPen3]
  #  type = AllenCahn
  #  variable = eta3
  #  args = 'eta2 eta1 eta4 eta5 Te c'
  #  mob_name = Leta
  #  f_name = Pen1
  #[../]

  #--------------------------------------------------------------------------
  # Allen-Cahn Equation
  # Eta4
  [./eta4_dot]
    type                         = TimeDerivative
    variable                     = eta4
  [../]
  [./ACBulk4]
    type = AllenCahn
    variable = eta4
    args = 'eta2 eta3 eta1 eta51 eta52 eta53 eta54 eta55 eta56 Te c'
    mob_name = Leta
    f_name = F
  [../]
  [./ACInterface4]
    type = ACMultiInterface
    variable = eta4
    etas = 'eta1 eta2 eta3 eta4 eta51 eta52 eta53 eta54 eta55 eta56'
    mob_name = Leta
    kappa_names = 'kappaEta kappaEta kappaEta kappaEta kappaEta kappaEta kappaEta kappaEta kappaEta kappaEta'
  [../]
  [./SwitchingFunctionConstraintEta4]
    h_name                       = h4
    implicit                     = 1
    lambda                       = La_eta
    type                         = SwitchingFunctionConstraintEta
    variable                     = eta4
  [../]
  [./LangevinNoise_eta4]
    amplitude                    = 1.0
    multiplier                   = MagNoiseEta
    seed                         = 1401
    type                         = LangevinNoise
    variable                     = eta4
    save_in                      = eta4Noise
  [../]
  #[./ACBulkPen4]
  #  type = AllenCahn
  #  variable = eta4
  #  args = 'eta2 eta3 eta1 eta5 Te c'
  #  mob_name = Leta
  #  f_name = Pen1
  #[../]

  #--------------------------------------------------------------------------
  # Allen-Cahn Equation
  # Eta5
  [./eta51_dot]
    type                         = TimeDerivative
    variable                     = eta51
  [../]
  [./ACBulk51]
    type = AllenCahn
    variable = eta51
    args = 'eta2 eta3 eta4 eta1 eta52 eta53 eta54 eta55 eta56 Te c'
    mob_name = Leta
    f_name = F
  [../]
  [./ACInterface51]
    type = ACMultiInterface
    variable = eta51
    etas = 'eta1 eta2 eta3 eta4 eta51 eta52 eta53 eta54 eta55 eta56'
    mob_name = Leta
    kappa_names = 'kappaEta kappaEta kappaEta kappaEta kappaEta kappaEta kappaEta kappaEta kappaEta kappaEta'
  [../]
  [./SwitchingFunctionConstraintEta51]
    h_name                       = h51
    implicit                     = 1
    lambda                       = La_eta
    type                         = SwitchingFunctionConstraintEta
    variable                     = eta51
  [../]
  [./LangevinNoise_eta51]
    amplitude                    = 1.0
    multiplier                   = MagNoiseEta
    seed                         = 51001
    type                         = LangevinNoise
    variable                     = eta51
    #save_in                      = eta5Noise
  [../]

  [./ACBulk51El]
    type = AllenCahn
    variable = eta51
    mob_name = Leta
    f_name = FEl
  [../]
  #[./ACBulkPen5]
  #  type = AllenCahn
  #  variable = eta5
  #  args = 'eta2 eta3 eta4 eta1 Te c'
  #  mob_name = Leta
  #  f_name = Pen1
  #[../]

  #--------------------------------------------------------------------------
  # Allen-Cahn Equation
  # Eta52
  [./eta52_dot]
    type                         = TimeDerivative
    variable                     = eta52
  [../]
  [./ACBulk52]
    type = AllenCahn
    variable = eta52
    args = 'eta2 eta3 eta4 eta1 eta51 eta53 eta54 eta55 eta56 Te c'
    mob_name = Leta
    f_name = F
  [../]
  [./ACInterface52]
    type = ACMultiInterface
    variable = eta52
    etas = 'eta1 eta2 eta3 eta4 eta51 eta52 eta53 eta54 eta55 eta56'
    mob_name = Leta
    kappa_names = 'kappaEta kappaEta kappaEta kappaEta kappaEta kappaEta kappaEta kappaEta kappaEta kappaEta'
  [../]
  [./SwitchingFunctionConstraintEta52]
    h_name                       = h52
    implicit                     = 1
    lambda                       = La_eta
    type                         = SwitchingFunctionConstraintEta
    variable                     = eta52
  [../]
  [./LangevinNoise_eta52]
    amplitude                    = 1.0
    multiplier                   = MagNoiseEta
    seed                         = 52001
    type                         = LangevinNoise
    variable                     = eta52
    #save_in                      = eta5Noise
  [../]
  [./ACBulk52El]
    type = AllenCahn
    variable = eta52
    mob_name = Leta
    f_name = FEl
  [../]
  #--------------------------------------------------------------------------
  # Allen-Cahn Equation
  # Eta53
  [./eta53_dot]
    type                         = TimeDerivative
    variable                     = eta53
  [../]
  [./ACBulk53]
    type = AllenCahn
    variable = eta53
    args = 'eta2 eta3 eta4 eta1 eta52 eta51 eta54 eta55 eta56 Te c'
    mob_name = Leta
    f_name = F
  [../]
  [./ACInterface53]
    type = ACMultiInterface
    variable = eta53
    etas = 'eta1 eta2 eta3 eta4 eta51 eta52 eta53 eta54 eta55 eta56'
    mob_name = Leta
    kappa_names = 'kappaEta kappaEta kappaEta kappaEta kappaEta kappaEta kappaEta kappaEta kappaEta kappaEta'
  [../]
  [./SwitchingFunctionConstraintEta53]
    h_name                       = h53
    implicit                     = 1
    lambda                       = La_eta
    type                         = SwitchingFunctionConstraintEta
    variable                     = eta53
  [../]
  [./LangevinNoise_eta53]
    amplitude                    = 1.0
    multiplier                   = MagNoiseEta
    seed                         = 53001
    type                         = LangevinNoise
    variable                     = eta53
    #save_in                      = eta5Noise
  [../]
  [./ACBulk53El]
    type = AllenCahn
    variable = eta53
    mob_name = Leta
    f_name = FEl
  [../]

  #--------------------------------------------------------------------------
  # Allen-Cahn Equation
  # Eta54
  [./eta54_dot]
    type                         = TimeDerivative
    variable                     = eta54
  [../]
  [./ACBulk54]
    type = AllenCahn
    variable = eta54
    args = 'eta2 eta3 eta4 eta1 eta52 eta53 eta51 eta55 eta56 Te c'
    mob_name = Leta
    f_name = F
  [../]
  [./ACInterface54]
    type = ACMultiInterface
    variable = eta54
    etas = 'eta1 eta2 eta3 eta4 eta51 eta52 eta53 eta54 eta55 eta56'
    mob_name = Leta
    kappa_names = 'kappaEta kappaEta kappaEta kappaEta kappaEta kappaEta kappaEta kappaEta kappaEta kappaEta'
  [../]
  [./SwitchingFunctionConstraintEta54]
    h_name                       = h54
    implicit                     = 1
    lambda                       = La_eta
    type                         = SwitchingFunctionConstraintEta
    variable                     = eta54
  [../]
  [./LangevinNoise_eta54]
    amplitude                    = 1.0
    multiplier                   = MagNoiseEta
    seed                         = 54001
    type                         = LangevinNoise
    variable                     = eta54
    #save_in                      = eta5Noise
  [../]
  [./ACBulk54El]
    type = AllenCahn
    variable = eta54
    mob_name = Leta
    f_name = FEl
  [../]

  #--------------------------------------------------------------------------
  # Allen-Cahn Equation
  # Eta55
  [./eta55_dot]
    type                         = TimeDerivative
    variable                     = eta55
  [../]
  [./ACBulk55]
    type = AllenCahn
    variable = eta55
    args = 'eta2 eta3 eta4 eta1 eta52 eta53 eta54 eta51 eta56 Te c'
    mob_name = Leta
    f_name = F
  [../]
  [./ACInterface55]
    type = ACMultiInterface
    variable = eta55
    etas = 'eta1 eta2 eta3 eta4 eta51 eta52 eta53 eta54 eta55 eta56'
    mob_name = Leta
    kappa_names = 'kappaEta kappaEta kappaEta kappaEta kappaEta kappaEta kappaEta kappaEta kappaEta kappaEta'
  [../]
  [./SwitchingFunctionConstraintEta55]
    h_name                       = h55
    implicit                     = 1
    lambda                       = La_eta
    type                         = SwitchingFunctionConstraintEta
    variable                     = eta55
  [../]
  [./LangevinNoise_eta55]
    amplitude                    = 1.0
    multiplier                   = MagNoiseEta
    seed                         = 55001
    type                         = LangevinNoise
    variable                     = eta55
    #save_in                      = eta5Noise
  [../]
  [./ACBulk55El]
    type = AllenCahn
    variable = eta55
    mob_name = Leta
    f_name = FEl
  [../]

  #--------------------------------------------------------------------------
  # Allen-Cahn Equation
  # Eta5
  [./eta56_dot]
    type                         = TimeDerivative
    variable                     = eta56
  [../]
  [./ACBulk56]
    type = AllenCahn
    variable = eta56
    args = 'eta2 eta3 eta4 eta1 eta52 eta53 eta54 eta55 eta51 Te c'
    mob_name = Leta
    f_name = F
  [../]
  [./ACInterface56]
    type = ACMultiInterface
    variable = eta56
    etas = 'eta1 eta2 eta3 eta4 eta51 eta52 eta53 eta54 eta55 eta56'
    mob_name = Leta
    kappa_names = 'kappaEta kappaEta kappaEta kappaEta kappaEta kappaEta kappaEta kappaEta kappaEta kappaEta'
  [../]
  [./SwitchingFunctionConstraintEta56]
    h_name                       = h56
    implicit                     = 1
    lambda                       = La_eta
    type                         = SwitchingFunctionConstraintEta
    variable                     = eta56
  [../]
  [./LangevinNoise_eta56]
    amplitude                    = 1.0
    multiplier                   = MagNoiseEta
    seed                         = 56001
    type                         = LangevinNoise
    variable                     = eta56
    #save_in                      = eta5Noise
  [../]
  [./ACBulk56El]
    type = AllenCahn
    variable = eta56
    mob_name = Leta
    f_name = FEl
  [../]

  #--------------------------------------------------------------------------
  # Langrange Eta
  [./SwitchingFunctionConstraintLagrange]
    enable                       = 1
    epsilon                      = 1e-09
    etas                         = 'eta1 eta2 eta3 eta4 eta51 eta52 eta53 eta54 eta55 eta56'
    h_names                      = 'h1 h2 h3 h4 h51 h52 h53 h54 h55 h56'
    type                         = SwitchingFunctionConstraintLagrange
    variable                     = La_eta
  [../]

[]

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
  solve_type = 'NEWTON'
# OR PJFNK
  petsc_options_iname = '-pc_type -sub_pc_type -sub_pc_factor_shift_type'
  petsc_options_value = 'asm      ilu          nonzero'

  l_max_its = 40
  nl_max_its = 20
  nl_abs_tol = 1e-8
  end_time = 5.0
   dtmax   = 5.0e-4
   start_time                 = 0
 [./TimeStepper]
    # Turn on time stepping
    type = IterationAdaptiveDT
    dt = 5.0e-6
    cutback_factor = 0.8
    growth_factor = 1.5
    optimal_iterations = 8
  [../]
[]

[Outputs]
  interval                       = 20
  exodus = true
  console = false
  print_perf_log = true
  output_initial = true
  #print_linear_residuals         = 0
[]
