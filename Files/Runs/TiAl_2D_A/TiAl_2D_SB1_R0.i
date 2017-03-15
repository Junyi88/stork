#====================================================================
# Global Params

[GlobalParams]
  outputs = exodus
  penalty = 1e3
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
  xmax = 2.0e1
  ymin = 0
  ymax = 2.0e1
  zmin = 0
  zmax = 0
[]

#====================================================================
# Mesh Modifiers
[MeshModifiers]
  [./SubdomainBoundingBox1]
    block_id                     = 1
    location                     = INSIDE
    top_right                    = '6.0 6.0 0.0'
    bottom_left                  = '2.0 2.0 0.0'
    type                         = SubdomainBoundingBox
  [../]

  [./SubdomainBoundingBox2]
    block_id                     = 2
    location                     = INSIDE
    top_right                    = '18.0 6.0 0.0'
    bottom_left                  = '14.0 2.0 0.0'
    type                         = SubdomainBoundingBox
  [../]

  [./SubdomainBoundingBox3]
    block_id                     = 3
    location                     = INSIDE
    top_right                    = '12.0 12.0 0.0'
    bottom_left                  = '8.0 8.0 0.0'
    type                         = SubdomainBoundingBox
  [../]

  [./SubdomainBoundingBox4]
    block_id                     = 4
    location                     = INSIDE
    top_right                    = '5.0 17.0 0.0'
    bottom_left                  = '1.0 13.0 0.0'
    type                         = SubdomainBoundingBox
  [../]

  [./SubdomainBoundingBox5]
    block_id                     = 5
    location                     = INSIDE
    top_right                    = '18.0 20.0 0.0'
    bottom_left                  = '14.0 16.0 0.0'
    type                         = SubdomainBoundingBox
  [../]
[]

#====================================================================
# Variables
[Variables]
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

  [./Te]
    order = FIRST
    family = LAGRANGE
    initial_condition = 1800.0
  [../]

  [./q1]
    order = FIRST
    family = LAGRANGE
  [../]

  [./q2]
    order = FIRST
    family = LAGRANGE
  [../]

  [./LaQ]
    order = FIRST
    family = LAGRANGE
  [../]
[]

#====================================================================
# Initial Conditions
[ICs]
  #====================================================================
  [./ConstantIC_0_eta1]
    block                        =    0
    type                         = ConstantIC
    value                        = 0.94
    variable                     = eta1
  [../]
  [./ConstantIC_0_eta2]
    block                        =    0
    type                         = ConstantIC
    value                        = 0.03
    variable                     = eta2
  [../]
  [./ConstantIC_0_eta3]
    block                        =    0
    type                         = ConstantIC
    value                        = 0.03
    variable                     = eta3
  [../]
  [./ConstantIC_0_c]
    block                        =    0
    type                         = ConstantIC
    value                        = 0.4661
    variable                     = c
  [../]
  [./ConstantIC_0_q1]
    block                        =    0                         # The list of block ids (SubdomainID) that this object will be applied
    type                         = ConstantIC
    value                        = 0.70710678118                 # The value to be set in IC
    variable                     = q1                  # The variable this initial condition is supposed to provide values for.
  [../]
  [./ConstantIC_0_q2]
    block                        =    0                         # The list of block ids (SubdomainID) that this object will be applied
    type                         = ConstantIC
    value                        = 0.70710678118                 # The value to be set in IC
    variable                     = q2                  # The variable this initial condition is supposed to provide values for.
  [../]
  #====================================================================
  [./SmoothCircleIC_1_eta1]
    3D_spheres                   = 0                           # in 3D, whether the objects are spheres or columns
    block                        = 1                            # The list of block ids (SubdomainID) that this object will be applied
    enable                       = 1                           # Set the enabled status of the MooseObject.
    int_width                    = 0                           # The interfacial width of the void surface.  Defaults to sharp interface
    invalue                      = 0.03                  # The variable value inside the circle
    outvalue                     = 0.94                  # The variable value outside the circle
    radius                       = 1.84                  # The radius of a circle
    rand_seed                    = 0                       # Seed value for the random number generator
    type                         = SmoothCircleIC
    variable                     = eta1                  # The variable this initial condition is supposed to provide values for.
    x1                           = 4                  # The x coordinate of the circle center
    y1                           = 4                  # The y coordinate of the circle center
    z1                           = 0                           # The z coordinate of the circle center
    zero_gradient                = 0
  [../]
  [./SmoothCircleIC_1_eta2]
    3D_spheres                   = 0                           # in 3D, whether the objects are spheres or columns
    block                        = 1                            # The list of block ids (SubdomainID) that this object will be applied
    enable                       = 1                           # Set the enabled status of the MooseObject.
    int_width                    = 0                           # The interfacial width of the void surface.  Defaults to sharp interface
    invalue                      = 0.03                  # The variable value inside the circle
    outvalue                     = 0.03                  # The variable value outside the circle
    radius                       = 1.84                  # The radius of a circle
    rand_seed                    = 0                       # Seed value for the random number generator
    type                         = SmoothCircleIC
    variable                     = eta2                  # The variable this initial condition is supposed to provide values for.
    x1                           = 4                  # The x coordinate of the circle center
    y1                           = 4                  # The y coordinate of the circle center
    z1                           = 0                           # The z coordinate of the circle center
    zero_gradient                = 0
  [../]
  [./SmoothCircleIC_1_eta3]
    3D_spheres                   = 0                           # in 3D, whether the objects are spheres or columns
    block                        = 1                            # The list of block ids (SubdomainID) that this object will be applied
    enable                       = 1                           # Set the enabled status of the MooseObject.
    int_width                    = 0                           # The interfacial width of the void surface.  Defaults to sharp interface
    invalue                      = 0.94                  # The variable value inside the circle
    outvalue                     = 0.03                  # The variable value outside the circle
    radius                       = 1.84                  # The radius of a circle
    rand_seed                    = 0                       # Seed value for the random number generator
    type                         = SmoothCircleIC
    variable                     = eta3                  # The variable this initial condition is supposed to provide values for.
    x1                           = 4                  # The x coordinate of the circle center
    y1                           = 4                  # The y coordinate of the circle center
    z1                           = 0                           # The z coordinate of the circle center
    zero_gradient                = 0
  [../]
  [./SmoothCircleIC_1_c]
    3D_spheres                   = 0                           # in 3D, whether the objects are spheres or columns
    block                        = 1                            # The list of block ids (SubdomainID) that this object will be applied
    enable                       = 1                           # Set the enabled status of the MooseObject.
    int_width                    = 0                           # The interfacial width of the void surface.  Defaults to sharp interface
    invalue                      = 0.4169                  # The variable value inside the circle
    outvalue                     = 0.4661                  # The variable value outside the circle
    radius                       = 1.84                  # The radius of a circle
    rand_seed                    = 0                       # Seed value for the random number generator
    type                         = SmoothCircleIC
    variable                     = c                  # The variable this initial condition is supposed to provide values for.
    x1                           = 4                  # The x coordinate of the circle center
    y1                           = 4                  # The y coordinate of the circle center
    z1                           = 0                           # The z coordinate of the circle center
    zero_gradient                = 0
  [../]
  [./SmoothCircleIC_1_q1]
    3D_spheres                   = 0                           # in 3D, whether the objects are spheres or columns
    block                        = 1                            # The list of block ids (SubdomainID) that this object will be applied
    enable                       = 1                           # Set the enabled status of the MooseObject.
    int_width                    = 0                           # The interfacial width of the void surface.  Defaults to sharp interface
    invalue                      = 0.6                  # The variable value inside the circle
    outvalue                     = 0.70710678118                  # The variable value outside the circle
    radius                       = 1.84                  # The radius of a circle
    rand_seed                    = 0                       # Seed value for the random number generator
    type                         = SmoothCircleIC
    variable                     = q1                  # The variable this initial condition is supposed to provide values for.
    x1                           = 4                  # The x coordinate of the circle center
    y1                           = 4                  # The y coordinate of the circle center
    z1                           = 0                           # The z coordinate of the circle center
    zero_gradient                = 0
  [../]
  [./SmoothCircleIC_1_q2]
    3D_spheres                   = 0                           # in 3D, whether the objects are spheres or columns
    block                        = 1                            # The list of block ids (SubdomainID) that this object will be applied
    enable                       = 1                           # Set the enabled status of the MooseObject.
    int_width                    = 0                           # The interfacial width of the void surface.  Defaults to sharp interface
    invalue                      = 0.8                  # The variable value inside the circle
    outvalue                     = 0.70710678118                  # The variable value outside the circle
    radius                       = 1.84                  # The radius of a circle
    rand_seed                    = 0                       # Seed value for the random number generator
    type                         = SmoothCircleIC
    variable                     = q2                  # The variable this initial condition is supposed to provide values for.
    x1                           = 4                  # The x coordinate of the circle center
    y1                           = 4                  # The y coordinate of the circle center
    z1                           = 0                           # The z coordinate of the circle center
    zero_gradient                = 0
  [../]
  #====================================================================
  [./SmoothCircleIC_2_eta1]
    3D_spheres                   = 0                           # in 3D, whether the objects are spheres or columns
    block                        = 2                            # The list of block ids (SubdomainID) that this object will be applied
    enable                       = 1                           # Set the enabled status of the MooseObject.
    int_width                    = 0                           # The interfacial width of the void surface.  Defaults to sharp interface
    invalue                      = 0.03                  # The variable value inside the circle
    outvalue                     = 0.94                  # The variable value outside the circle
    radius                       = 1.84                  # The radius of a circle
    rand_seed                    = 0                       # Seed value for the random number generator
    type                         = SmoothCircleIC
    variable                     = eta1                  # The variable this initial condition is supposed to provide values for.
    x1                           = 16                  # The x coordinate of the circle center
    y1                           = 4                  # The y coordinate of the circle center
    z1                           = 0                           # The z coordinate of the circle center
    zero_gradient                = 0
  [../]
  [./SmoothCircleIC_2_eta2]
    3D_spheres                   = 0                           # in 3D, whether the objects are spheres or columns
    block                        = 2                            # The list of block ids (SubdomainID) that this object will be applied
    enable                       = 1                           # Set the enabled status of the MooseObject.
    int_width                    = 0                           # The interfacial width of the void surface.  Defaults to sharp interface
    invalue                      = 0.03                  # The variable value inside the circle
    outvalue                     = 0.03                  # The variable value outside the circle
    radius                       = 1.84                  # The radius of a circle
    rand_seed                    = 0                       # Seed value for the random number generator
    type                         = SmoothCircleIC
    variable                     = eta2                  # The variable this initial condition is supposed to provide values for.
    x1                           = 16                  # The x coordinate of the circle center
    y1                           = 4                  # The y coordinate of the circle center
    z1                           = 0                           # The z coordinate of the circle center
    zero_gradient                = 0
  [../]
  [./SmoothCircleIC_2_eta3]
    3D_spheres                   = 0                           # in 3D, whether the objects are spheres or columns
    block                        = 2                            # The list of block ids (SubdomainID) that this object will be applied
    enable                       = 1                           # Set the enabled status of the MooseObject.
    int_width                    = 0                           # The interfacial width of the void surface.  Defaults to sharp interface
    invalue                      = 0.94                  # The variable value inside the circle
    outvalue                     = 0.03                  # The variable value outside the circle
    radius                       = 1.84                  # The radius of a circle
    rand_seed                    = 0                       # Seed value for the random number generator
    type                         = SmoothCircleIC
    variable                     = eta3                  # The variable this initial condition is supposed to provide values for.
    x1                           = 16                  # The x coordinate of the circle center
    y1                           = 4                  # The y coordinate of the circle center
    z1                           = 0                           # The z coordinate of the circle center
    zero_gradient                = 0
  [../]
  [./SmoothCircleIC_2_c]
    3D_spheres                   = 0                           # in 3D, whether the objects are spheres or columns
    block                        = 2                            # The list of block ids (SubdomainID) that this object will be applied
    enable                       = 1                           # Set the enabled status of the MooseObject.
    int_width                    = 0                           # The interfacial width of the void surface.  Defaults to sharp interface
    invalue                      = 0.4169                  # The variable value inside the circle
    outvalue                     = 0.4661                  # The variable value outside the circle
    radius                       = 1.84                  # The radius of a circle
    rand_seed                    = 0                       # Seed value for the random number generator
    type                         = SmoothCircleIC
    variable                     = c                  # The variable this initial condition is supposed to provide values for.
    x1                           = 16                  # The x coordinate of the circle center
    y1                           = 4                  # The y coordinate of the circle center
    z1                           = 0                           # The z coordinate of the circle center
    zero_gradient                = 0
  [../]
  [./SmoothCircleIC_2_q1]
    3D_spheres                   = 0                           # in 3D, whether the objects are spheres or columns
    block                        = 2                            # The list of block ids (SubdomainID) that this object will be applied
    enable                       = 1                           # Set the enabled status of the MooseObject.
    int_width                    = 0                           # The interfacial width of the void surface.  Defaults to sharp interface
    invalue                      = 0.8                  # The variable value inside the circle
    outvalue                     = 0.70710678118                  # The variable value outside the circle
    radius                       = 1.84                  # The radius of a circle
    rand_seed                    = 0                       # Seed value for the random number generator
    type                         = SmoothCircleIC
    variable                     = q1                  # The variable this initial condition is supposed to provide values for.
    x1                           = 16                 # The x coordinate of the circle center
    y1                           = 4                  # The y coordinate of the circle center
    z1                           = 0                           # The z coordinate of the circle center
    zero_gradient                = 0
  [../]
  [./SmoothCircleIC_2_q2]
    3D_spheres                   = 0                           # in 3D, whether the objects are spheres or columns
    block                        = 2                            # The list of block ids (SubdomainID) that this object will be applied
    enable                       = 1                           # Set the enabled status of the MooseObject.
    int_width                    = 0                           # The interfacial width of the void surface.  Defaults to sharp interface
    invalue                      = 0.6                  # The variable value inside the circle
    outvalue                     = 0.70710678118                  # The variable value outside the circle
    radius                       = 1.84                  # The radius of a circle
    rand_seed                    = 0                       # Seed value for the random number generator
    type                         = SmoothCircleIC
    variable                     = q2                  # The variable this initial condition is supposed to provide values for.
    x1                           = 16                  # The x coordinate of the circle center
    y1                           = 4                  # The y coordinate of the circle center
    z1                           = 0                           # The z coordinate of the circle center
    zero_gradient                = 0
  [../]
  #====================================================================
  [./SmoothCircleIC_3_eta1]
    3D_spheres                   = 0                           # in 3D, whether the objects are spheres or columns
    block                        = 3                            # The list of block ids (SubdomainID) that this object will be applied
    enable                       = 1                           # Set the enabled status of the MooseObject.
    int_width                    = 0                           # The interfacial width of the void surface.  Defaults to sharp interface
    invalue                      = 0.03                  # The variable value inside the circle
    outvalue                     = 0.94                 # The variable value outside the circle
    radius                       = 1.84                  # The radius of a circle
    rand_seed                    = 0                       # Seed value for the random number generator
    type                         = SmoothCircleIC
    variable                     = eta1                  # The variable this initial condition is supposed to provide values for.
    x1                           = 10                  # The x coordinate of the circle center
    y1                           = 10                 # The y coordinate of the circle center
    z1                           = 0                           # The z coordinate of the circle center
    zero_gradient                = 0
  [../]
  [./SmoothCircleIC_3_eta2]
    3D_spheres                   = 0                           # in 3D, whether the objects are spheres or columns
    block                        = 3                            # The list of block ids (SubdomainID) that this object will be applied
    enable                       = 1                           # Set the enabled status of the MooseObject.
    int_width                    = 0                           # The interfacial width of the void surface.  Defaults to sharp interface
    invalue                      = 0.03                  # The variable value inside the circle
    outvalue                     = 0.03                  # The variable value outside the circle
    radius                       = 1.84                  # The radius of a circle
    rand_seed                    = 0                       # Seed value for the random number generator
    type                         = SmoothCircleIC
    variable                     = eta2                  # The variable this initial condition is supposed to provide values for.
    x1                           = 10                  # The x coordinate of the circle center
    y1                           = 10                 # The y coordinate of the circle center
    z1                           = 0                           # The z coordinate of the circle center
    zero_gradient                = 0
  [../]
  [./SmoothCircleIC_3_eta3]
    3D_spheres                   = 0                           # in 3D, whether the objects are spheres or columns
    block                        = 3                            # The list of block ids (SubdomainID) that this object will be applied
    enable                       = 1                           # Set the enabled status of the MooseObject.
    int_width                    = 0                           # The interfacial width of the void surface.  Defaults to sharp interface
    invalue                      = 0.94                  # The variable value inside the circle
    outvalue                     = 0.03                  # The variable value outside the circle
    radius                       = 1.84                  # The radius of a circle
    rand_seed                    = 0                       # Seed value for the random number generator
    type                         = SmoothCircleIC
    variable                     = eta3                  # The variable this initial condition is supposed to provide values for.
    x1                           = 10                  # The x coordinate of the circle center
    y1                           = 10                 # The y coordinate of the circle center
    z1                           = 0                           # The z coordinate of the circle center
    zero_gradient                = 0
  [../]
  [./SmoothCircleIC_3_c]
    3D_spheres                   = 0                           # in 3D, whether the objects are spheres or columns
    block                        = 3                            # The list of block ids (SubdomainID) that this object will be applied
    enable                       = 1                           # Set the enabled status of the MooseObject.
    int_width                    = 0                           # The interfacial width of the void surface.  Defaults to sharp interface
    invalue                      = 0.4169                  # The variable value inside the circle
    outvalue                     = 0.4661                  # The variable value outside the circle
    radius                       = 1.84                  # The radius of a circle
    rand_seed                    = 0                       # Seed value for the random number generator
    type                         = SmoothCircleIC
    variable                     = c                  # The variable this initial condition is supposed to provide values for.
    x1                           = 10                  # The x coordinate of the circle center
    y1                           = 10                  # The y coordinate of the circle center
    z1                           = 0                           # The z coordinate of the circle center
    zero_gradient                = 0
  [../]
  [./SmoothCircleIC_3_q1]
    3D_spheres                   = 0                           # in 3D, whether the objects are spheres or columns
    block                        = 3                            # The list of block ids (SubdomainID) that this object will be applied
    enable                       = 1                           # Set the enabled status of the MooseObject.
    int_width                    = 0                           # The interfacial width of the void surface.  Defaults to sharp interface
    invalue                      = 0.6                  # The variable value inside the circle
    outvalue                     = 0.70710678118                  # The variable value outside the circle
    radius                       = 1.84                  # The radius of a circle
    rand_seed                    = 0                       # Seed value for the random number generator
    type                         = SmoothCircleIC
    variable                     = q1                  # The variable this initial condition is supposed to provide values for.
    x1                           = 10                 # The x coordinate of the circle center
    y1                           = 10                  # The y coordinate of the circle center
    z1                           = 0                           # The z coordinate of the circle center
    zero_gradient                = 0
  [../]
  [./SmoothCircleIC_3_q2]
    3D_spheres                   = 0                           # in 3D, whether the objects are spheres or columns
    block                        = 3                            # The list of block ids (SubdomainID) that this object will be applied
    enable                       = 1                           # Set the enabled status of the MooseObject.
    int_width                    = 0                           # The interfacial width of the void surface.  Defaults to sharp interface
    invalue                      = 0.8                  # The variable value inside the circle
    outvalue                     = 0.70710678118                  # The variable value outside the circle
    radius                       = 1.84                  # The radius of a circle
    rand_seed                    = 0                       # Seed value for the random number generator
    type                         = SmoothCircleIC
    variable                     = q2                  # The variable this initial condition is supposed to provide values for.
    x1                           = 10                  # The x coordinate of the circle center
    y1                           = 10                  # The y coordinate of the circle center
    z1                           = 0                           # The z coordinate of the circle center
    zero_gradient                = 0
  [../]
  #====================================================================
  [./SmoothCircleIC_4_eta1]
    3D_spheres                   = 0                           # in 3D, whether the objects are spheres or columns
    block                        = 4                            # The list of block ids (SubdomainID) that this object will be applied
    enable                       = 1                           # Set the enabled status of the MooseObject.
    int_width                    = 0                           # The interfacial width of the void surface.  Defaults to sharp interface
    invalue                      = 0.03                  # The variable value inside the circle
    outvalue                     = 0.94                  # The variable value outside the circle
    radius                       = 1.84                  # The radius of a circle
    rand_seed                    = 0                       # Seed value for the random number generator
    type                         = SmoothCircleIC
    variable                     = eta1                  # The variable this initial condition is supposed to provide values for.
    x1                           = 3                  # The x coordinate of the circle center
    y1                           = 15                  # The y coordinate of the circle center
    z1                           = 0                           # The z coordinate of the circle center
    zero_gradient                = 0
  [../]
  [./SmoothCircleIC_4_eta2]
    3D_spheres                   = 0                           # in 3D, whether the objects are spheres or columns
    block                        = 4                            # The list of block ids (SubdomainID) that this object will be applied
    enable                       = 1                           # Set the enabled status of the MooseObject.
    int_width                    = 0                           # The interfacial width of the void surface.  Defaults to sharp interface
    invalue                      = 0.03                  # The variable value inside the circle
    outvalue                     = 0.03                  # The variable value outside the circle
    radius                       = 1.84                  # The radius of a circle
    rand_seed                    = 0                       # Seed value for the random number generator
    type                         = SmoothCircleIC
    variable                     = eta2                  # The variable this initial condition is supposed to provide values for.
    x1                           = 3                  # The x coordinate of the circle center
    y1                           = 15                  # The y coordinate of the circle center
    z1                           = 0                           # The z coordinate of the circle center
    zero_gradient                = 0
  [../]
  [./SmoothCircleIC_4_eta3]
    3D_spheres                   = 0                           # in 3D, whether the objects are spheres or columns
    block                        = 4                            # The list of block ids (SubdomainID) that this object will be applied
    enable                       = 1                           # Set the enabled status of the MooseObject.
    int_width                    = 0                           # The interfacial width of the void surface.  Defaults to sharp interface
    invalue                      = 0.94                  # The variable value inside the circle
    outvalue                     = 0.03                  # The variable value outside the circle
    radius                       = 1.84                  # The radius of a circle
    rand_seed                    = 0                       # Seed value for the random number generator
    type                         = SmoothCircleIC
    variable                     = eta3                  # The variable this initial condition is supposed to provide values for.
    x1                           = 3                  # The x coordinate of the circle center
    y1                           = 15                  # The y coordinate of the circle center
    z1                           = 0                           # The z coordinate of the circle center
    zero_gradient                = 0
  [../]
  [./SmoothCircleIC_4_c]
    3D_spheres                   = 0                           # in 3D, whether the objects are spheres or columns
    block                        = 4                            # The list of block ids (SubdomainID) that this object will be applied
    enable                       = 1                           # Set the enabled status of the MooseObject.
    int_width                    = 0                           # The interfacial width of the void surface.  Defaults to sharp interface
    invalue                      = 0.4169                  # The variable value inside the circle
    outvalue                     = 0.4661                  # The variable value outside the circle
    radius                       = 1.84                  # The radius of a circle
    rand_seed                    = 0                       # Seed value for the random number generator
    type                         = SmoothCircleIC
    variable                     = c                  # The variable this initial condition is supposed to provide values for.
    x1                           = 3                  # The x coordinate of the circle center
    y1                           = 15                  # The y coordinate of the circle center
    z1                           = 0                           # The z coordinate of the circle center
    zero_gradient                = 0
  [../]
  [./SmoothCircleIC_4_q1]
    3D_spheres                   = 0                           # in 3D, whether the objects are spheres or columns
    block                        = 4                            # The list of block ids (SubdomainID) that this object will be applied
    enable                       = 1                           # Set the enabled status of the MooseObject.
    int_width                    = 0                           # The interfacial width of the void surface.  Defaults to sharp interface
    invalue                      = 0.5                  # The variable value inside the circle
    outvalue                     = 0.70710678118                  # The variable value outside the circle
    radius                       = 1.84                  # The radius of a circle
    rand_seed                    = 0                       # Seed value for the random number generator
    type                         = SmoothCircleIC
    variable                     = q1                  # The variable this initial condition is supposed to provide values for.
    x1                           = 3                 # The x coordinate of the circle center
    y1                           = 15                  # The y coordinate of the circle center
    z1                           = 0                           # The z coordinate of the circle center
    zero_gradient                = 0
  [../]
  [./SmoothCircleIC_4_q2]
    3D_spheres                   = 0                           # in 3D, whether the objects are spheres or columns
    block                        = 4                            # The list of block ids (SubdomainID) that this object will be applied
    enable                       = 1                           # Set the enabled status of the MooseObject.
    int_width                    = 0                           # The interfacial width of the void surface.  Defaults to sharp interface
    invalue                      = 0.86602540378                  # The variable value inside the circle
    outvalue                     = 0.70710678118                  # The variable value outside the circle
    radius                       = 1.84                  # The radius of a circle
    rand_seed                    = 0                       # Seed value for the random number generator
    type                         = SmoothCircleIC
    variable                     = q2                  # The variable this initial condition is supposed to provide values for.
    x1                           = 3                  # The x coordinate of the circle center
    y1                           = 15                  # The y coordinate of the circle center
    z1                           = 0                           # The z coordinate of the circle center
    zero_gradient                = 0
  [../]
  #====================================================================
  [./SmoothCircleIC_5_eta1]
    3D_spheres                   = 0                           # in 3D, whether the objects are spheres or columns
    block                        = 5                            # The list of block ids (SubdomainID) that this object will be applied
    enable                       = 1                           # Set the enabled status of the MooseObject.
    int_width                    = 0                           # The interfacial width of the void surface.  Defaults to sharp interface
    invalue                      = 0.03                  # The variable value inside the circle
    outvalue                     = 0.94                  # The variable value outside the circle
    radius                       = 1.84                  # The radius of a circle
    rand_seed                    = 0                       # Seed value for the random number generator
    type                         = SmoothCircleIC
    variable                     = eta1                  # The variable this initial condition is supposed to provide values for.
    x1                           = 16                  # The x coordinate of the circle center
    y1                           = 18                  # The y coordinate of the circle center
    z1                           = 0                           # The z coordinate of the circle center
    zero_gradient                = 0
  [../]
  [./SmoothCircleIC_5_eta2]
    3D_spheres                   = 0                           # in 3D, whether the objects are spheres or columns
    block                        = 5                            # The list of block ids (SubdomainID) that this object will be applied
    enable                       = 1                           # Set the enabled status of the MooseObject.
    int_width                    = 0                           # The interfacial width of the void surface.  Defaults to sharp interface
    invalue                      = 0.03                  # The variable value inside the circle
    outvalue                     = 0.03                  # The variable value outside the circle
    radius                       = 1.84                  # The radius of a circle
    rand_seed                    = 0                       # Seed value for the random number generator
    type                         = SmoothCircleIC
    variable                     = eta2                  # The variable this initial condition is supposed to provide values for.
    x1                           = 16                  # The x coordinate of the circle center
    y1                           = 18                  # The y coordinate of the circle center
    z1                           = 0                           # The z coordinate of the circle center
    zero_gradient                = 0
  [../]
  [./SmoothCircleIC_5_eta3]
    3D_spheres                   = 0                           # in 3D, whether the objects are spheres or columns
    block                        = 5                            # The list of block ids (SubdomainID) that this object will be applied
    enable                       = 1                           # Set the enabled status of the MooseObject.
    int_width                    = 0                           # The interfacial width of the void surface.  Defaults to sharp interface
    invalue                      = 0.94                  # The variable value inside the circle
    outvalue                     = 0.03                  # The variable value outside the circle
    radius                       = 1.84                  # The radius of a circle
    rand_seed                    = 0                       # Seed value for the random number generator
    type                         = SmoothCircleIC
    variable                     = eta3                  # The variable this initial condition is supposed to provide values for.
    x1                           = 16                  # The x coordinate of the circle center
    y1                           = 18                  # The y coordinate of the circle center
    z1                           = 0                           # The z coordinate of the circle center
    zero_gradient                = 0
  [../]
  [./SmoothCircleIC_5_c]
    3D_spheres                   = 0                           # in 3D, whether the objects are spheres or columns
    block                        = 5                            # The list of block ids (SubdomainID) that this object will be applied
    enable                       = 1                           # Set the enabled status of the MooseObject.
    int_width                    = 0                           # The interfacial width of the void surface.  Defaults to sharp interface
    invalue                      = 0.4169                  # The variable value inside the circle
    outvalue                     = 0.4661                  # The variable value outside the circle
    radius                       = 1.84                  # The radius of a circle
    rand_seed                    = 0                       # Seed value for the random number generator
    type                         = SmoothCircleIC
    variable                     = c                  # The variable this initial condition is supposed to provide values for.
    x1                           = 16                  # The x coordinate of the circle center
    y1                           = 18                  # The y coordinate of the circle center
    z1                           = 0                           # The z coordinate of the circle center
    zero_gradient                = 0
  [../]
  [./SmoothCircleIC_5_q1]
    3D_spheres                   = 0                           # in 3D, whether the objects are spheres or columns
    block                        = 5                            # The list of block ids (SubdomainID) that this object will be applied
    enable                       = 1                           # Set the enabled status of the MooseObject.
    int_width                    = 0                           # The interfacial width of the void surface.  Defaults to sharp interface
    invalue                      = 0.86602540378                  # The variable value inside the circle
    outvalue                     = 0.70710678118                  # The variable value outside the circle
    radius                       = 1.84                  # The radius of a circle
    rand_seed                    = 0                       # Seed value for the random number generator
    type                         = SmoothCircleIC
    variable                     = q1                  # The variable this initial condition is supposed to provide values for.
    x1                           = 16                 # The x coordinate of the circle center
    y1                           = 18                  # The y coordinate of the circle center
    z1                           = 0                           # The z coordinate of the circle center
    zero_gradient                = 0
  [../]
  [./SmoothCircleIC_5_q2]
    3D_spheres                   = 0                           # in 3D, whether the objects are spheres or columns
    block                        = 5                            # The list of block ids (SubdomainID) that this object will be applied
    enable                       = 1                           # Set the enabled status of the MooseObject.
    int_width                    = 0                           # The interfacial width of the void surface.  Defaults to sharp interface
    invalue                      = 0.5                  # The variable value inside the circle
    outvalue                     = 0.70710678118                  # The variable value outside the circle
    radius                       = 1.84                  # The radius of a circle
    rand_seed                    = 0                       # Seed value for the random number generator
    type                         = SmoothCircleIC
    variable                     = q2                  # The variable this initial condition is supposed to provide values for.
    x1                           = 16                  # The x coordinate of the circle center
    y1                           = 18                  # The y coordinate of the circle center
    z1                           = 0                           # The z coordinate of the circle center
    zero_gradient                = 0
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

#====================================================================
# AuxVariables
[AuxVariables]
  [./grad_q1x]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./grad_q2x]
    order = CONSTANT
    family = MONOMIAL
  [../]

  [./grad_q1y]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./grad_q2y]
    order = CONSTANT
    family = MONOMIAL
  [../]
[]

#====================================================================
# AuxKernels
[AuxKernels]
  [./VariableGradientComponent1]
    component                    = 'x'
    gradient_variable            = 'q1'
    seed                         = 0
    type                         = VariableGradientComponent
    variable                     = 'grad_q1x'
  [../]

  [./VariableGradientComponent2]
    component                    = 'x'
    gradient_variable            = 'q2'
    seed                         = 0
    type                         = VariableGradientComponent
    variable                     = 'grad_q2x'
  [../]

  [./VariableGradientComponent3]
    component                    = 'y'
    gradient_variable            = 'q1'
    seed                         = 0
    type                         = VariableGradientComponent
    variable                     = 'grad_q1y'
  [../]

  [./VariableGradientComponent4]
    component                    = 'y'
    gradient_variable            = 'q2'
    seed                         = 0
    type                         = VariableGradientComponent
    variable                     = 'grad_q2y'
  [../]
[]

##===============================================================
# Materials
[Materials]
  # Shared Constants
  [./consts]
    type = GenericConstantMaterial
    prop_names  = 'Leta  kappaQ kappa_c
                   kappa11 kappa12 kappa13
                   kappa21 kappa22 kappa23
                   kappa31 kappa32 kappa33'
   prop_values = '6.4e2 0.09765625e-2 0.0625e-6
                  0.0625e-2 0.0625e-2 0.0625e-2
                  0.0625e-2 0.0625e-2 0.0625e-2
                  0.0625e-2 0.0625e-2 0.0625e-2'
  [../]

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

  [./barrier]
    type = MultiBarrierFunctionMaterial
    etas = 'eta1 eta2 eta3'
    function_name                = getas                           # actual name for g(eta_i)
    g_order                      = SIMPLE
    well_only                    = 0
  [../]

# ==========================================================
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
  #[./Penalty1]
  #  type = DerivativeParsedMaterial
  #  f_name =Pen1
  #  material_property_names = 'g1:=g1(eta1)  g2:=g2(eta2) g3:=g3(eta3) '
  #  function = '(g1+g2+g3)*1.0e3'
  #  args = 'eta1 eta2 eta3'
  #  derivative_order             = 1
  #  outputs = exodus
  #[../]

  # Total Free Energy
    [./free_energy]
      type = DerivativeMultiPhaseMaterial
      f_name = F
      fi_names = 'FLq  Falpha Fbeta '
      hi_names = 'h1  h2 h3'
      etas     = 'eta1 eta2 eta3'
      args = 'Te c'
      g=getas
      W = 2.5e-2
    derivative_order             = 2
    [../]

#==================================================================
# PusztaiStuff

# Angle diff
  [./HQ]
    type = DerivativeParsedMaterial
    f_name = HQ
    function = '(0.25e-2)*Te'
    args = 'Te'
    derivative_order             = 1
    #outputs = exodus
  [../]

  [./PQ]
    type = DerivativeParsedMaterial
    f_name = PQ
    function = '(eta2^2)+(eta3^2)'
    args = 'eta2 eta3'
    derivative_order             = 1
  [../]

  # Mobility
  [./LQ]
    type = DerivativeParsedMaterial
    f_name = LQ
    constant_names = 'LQMin LQMax'
    constant_expressions = '1e-4 0.64e2'
    function = 'LQMax+(LQMin-LQMax)*(1.0-(eta1^3)*(10.0-15.0*eta1+6.0*(eta1^2)))'
    #function = '0.0'
    args = 'eta1'
    derivative_order             = 1
    #outputs = exodus
  [../]

  # Angle
  [./phase_free_energy_hq1]
    type = DerivativeParsedMaterial
    f_name = hq1
    function = 'q1^2'
    args = 'q1'
  derivative_order             = 1
  [../]

  [./phase_free_energy_hq2]
    type = DerivativeParsedMaterial
    f_name = hq2
    function = 'q2^2'
    args = 'q2'
  derivative_order             = 1
  [../]

#*****************************************************************
# Cahn hilliard
# Mobilities
  [./MLq]
    type = ParsedMaterial
    f_name = MLq
    args = 'c Te'
    constant_names = 'Mag Rg D0 Q1'
    constant_expressions = '1e12 8.31451e-3 4.29e-7 36.3'
   function ='Mag*D0*exp(-Q1/(Rg*Te))'
  # outputs = exodus
  [../]

  [./Malpha]
    type = ParsedMaterial
    f_name = Malpha
    args = 'c Te'
    constant_names = 'Mag kb Da0 Qa1 Db0 Qb1'
    constant_expressions = '1e12 8.6173303e-5 1.35e-3 3.14 6.6e-3 3.41'
   function ='Mag*(c*Da0*exp(-Qa1/(kb*Te))+(1-c)*Db0*exp(-Qb1/(kb*Te)))'
  # outputs = exodus
  [../]

  [./Mbeta]
    type = ParsedMaterial
    f_name = Mbeta
    args = 'c Te'
    constant_names = 'Mag kb Da0 Qa1 Qa2 Db0 Qb1 Qb2'
    constant_expressions = '1e12 8.6173303e-5 3.53e-4 3.4 1335.0 1.94e-4 3.36 1266.0 '
   function ='Mag*(c*Da0*exp(-Qa1/(kb*Te))*exp(Qa2/(kb*Te^2))+
               (1-c)*Db0*exp(-Qb1/(kb*Te))*exp(Qb2/(kb*Te^2)))'
  # outputs = exodus
  [../]

  [./Mob]
    type = ParsedMaterial
    f_name = M
    args = 'c eta1 eta2 eta3 Te'
    material_property_names = 'MLq:=MLq(c,Te)
                               Malpha:=Malpha(c,Te)
                               Mbeta:=Mbeta(c,Te)
                               d2F:=D[F(Te,c),c,c]+1e-16'
  function ='(eta1*MLq+eta2*Malpha+eta3*Mbeta)/d2F'
  # function ='2.0e2'
   outputs = exodus
  [../]


  # Heat
  #-----------------------------------------------------------
  [./Heat1]
    type = GenericConstantMaterial
    prop_names = 'thermal_conductivity specific_heat density'
    prop_values = '1.0 1.0 1.0'
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
[]

# =======================================================
# Kernels
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
    args = 'eta1 eta2 eta3 Te c'
    variable = w
    type = SplitCHWRes
    mob_name = M
  [../]
  [./coupled_parsed]
    args = 'eta1 eta2 eta3 Te'
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
    args = 'eta2 eta3 Te c'
    mob_name = Leta
    f_name = F
  [../]
  [./ACInterface1]
    type = ACMultiInterface
    variable = eta1
    etas = 'eta1 eta2 eta3'
    mob_name = Leta
    kappa_names = 'kappa11 kappa12 kappa13'
  [../]
  [./SwitchingFunctionConstraintEta1]
    h_name                       = h1                            # Switching Function Materials that provides h(eta_i)
    implicit                     = 1
    lambda                       = La_eta                 # Lagrange multiplier
    type                         = SwitchingFunctionConstraintEta
    variable                     = eta1                 # The name of the variable that this Kernel operates on
  [../]
  [./PusztaiBulkEta1]
    Correction_y0   = 1.0
    Correction_Z   = 1.0
    Args                          = 'c Te eta2 eta3'                             # Vector of Etas this object depends on
    Qs                           = 'q1 q2'                            # Vector of Qs this object depends on
    H_name                       = 'HQ'                           # The energy constant of the non-grain boundary phases
    implicit                     = 1                           # Determines whether this object is calculated using an implicit or explicit ...
                                                               # form
    L_name                     = 'Leta'                           # The mobility used with the kernel
    P_name                       = 'PQ'                  # Interpolation function for phases
    type                         = PusztaiACBulk
    variable                     = eta1                 # The name of the variable that this Kernel operates on
    variable_H                   = 0                          # The mobility is a function of any MOOSE variable (if this is set to false ...
                                                               # L must be constant over the entire domain!)
    variable_L                   = 1                           # The mobility is a function of any MOOSE variable (if this is set to false ...                                                               # L must be constant over the entire domain!)
  [../]

  #--------------------------------------------------------------------------
  # Eta2
  [./eta2_dot]
    type                         = TimeDerivative
    variable                     = eta2
  [../]
  [./ACBulk2]
    type = AllenCahn
    variable = eta2
    args = 'eta1 eta3 Te c'
    mob_name = Leta
    f_name = F
  [../]
  [./ACInterface2]
    type = ACMultiInterface
    variable = eta2
    etas = 'eta1 eta2 eta3'
    mob_name = Leta
    kappa_names = 'kappa21 kappa22 kappa23'
  [../]
  [./SwitchingFunctionConstraintEta2]
    h_name                       = h2                            # Switching Function Materials that provides h(eta_i)
    implicit                     = 1
    lambda                       = La_eta                 # Lagrange multiplier
    type                         = SwitchingFunctionConstraintEta
    variable                     = eta2                 # The name of the variable that this Kernel operates on
  [../]

  [./PusztaiBulkEta2]
    Correction_y0   = 1.0
    Correction_Z   = 1.0
    Args                          = 'c Te eta1 eta3'                             # Vector of Etas this object depends on
    Qs                           = 'q1 q2'                            # Vector of Qs this object depends on
    H_name                       = 'HQ'                           # The energy constant of the non-grain boundary phases
    implicit                     = 1                           # Determines whether this object is calculated using an implicit or explicit ...
                                                               # form
    L_name                     = 'Leta'                           # The mobility used with the kernel
    P_name                       = 'PQ'                  # Interpolation function for phases
    type                         = PusztaiACBulk
    variable                     = eta2                 # The name of the variable that this Kernel operates on
    variable_H                   = 0                          # The mobility is a function of any MOOSE variable (if this is set to false ...
                                                               # L must be constant over the entire domain!)
    variable_L                   = 1                           # The mobility is a function of any MOOSE variable (if this is set to false ...                                                               # L must be constant over the entire domain!)
  [../]

  #--------------------------------------------------------------------------
  # Eta3
  [./eta3_dot]
    type                         = TimeDerivative
    variable                     = eta3
  [../]
  [./ACBulk3]
    type = AllenCahn
    variable = eta3
    args = 'eta1 eta2 Te c'
    mob_name = Leta
    f_name = F
  [../]
  [./ACInterface3]
    type = ACMultiInterface
    variable = eta3
    etas = 'eta1 eta2 eta3'
    mob_name = Leta
    kappa_names = 'kappa31 kappa32 kappa33'
  [../]
  [./SwitchingFunctionConstraintEta3]
    h_name                       = h3                            # Switching Function Materials that provides h(eta_i)
    implicit                     = 1
    lambda                       = La_eta                 # Lagrange multiplier
    type                         = SwitchingFunctionConstraintEta
    variable                     = eta3                 # The name of the variable that this Kernel operates on
  [../]

  [./PusztaiBulkEta3]
    Correction_y0   = 1.0
    Correction_Z   = 1.0
    Args                          = 'c Te eta1 eta2'                             # Vector of Etas this object depends on
    Qs                           = 'q1 q2'                            # Vector of Qs this object depends on
    H_name                       = 'HQ'                           # The energy constant of the non-grain boundary phases
    implicit                     = 1                           # Determines whether this object is calculated using an implicit or explicit ...
                                                               # form
    L_name                     = 'Leta'                           # The mobility used with the kernel
    P_name                       = 'PQ'                  # Interpolation function for phases
    type                         = PusztaiACBulk
    variable                     = eta3                 # The name of the variable that this Kernel operates on
    variable_H                   = 0                          # The mobility is a function of any MOOSE variable (if this is set to false ...
                                                               # L must be constant over the entire domain!)
    variable_L                   = 1                           # The mobility is a function of any MOOSE variable (if this is set to false ...                                                               # L must be constant over the entire domain!)
  [../]

  #--------------------------------------------------------------------------
  # Langrange Eta
  [./SwitchingFunctionConstraintLagrange]
    enable                       = 1                           # Set the enabled status of the MooseObject.
    epsilon                      = 1e-09                       # Shift factor to avoid a zero pivot
    etas                         = 'eta1 eta2 eta3'                  # eta_i order parameters, one for each h
    h_names                      = 'h1 h2 h3'                            # Switching Function Materials that provide h(eta_i)
    implicit                     = 1                           # Determines whether this object is calculated using an implicit or explicit ...
    type                         = SwitchingFunctionConstraintLagrange
    variable                     = La_eta                  # The name of the variable that this Kernel operates on
  [../]

  #==============================
  # temperature
    [./heat_conduction]
      type = HeatConduction
      variable = Te
    [../]
    [./heat_conduction_time_derivative]
      type = HeatConductionTimeDerivative
      variable = Te
    [../]
    [./HeatSource]
      type                         = HeatSource
      value                        = -400.0
      variable                     = Te
    [../]

    # -----------------------------------------------------------
    # Q1
      [./q1_dot]
        type                         = TimeDerivative
        variable                     = q1
      [../]

      [./PusztaiInterface1]
        Correction_y0                      = 1.0
        Correction_Z                      = 1.0
        Args                         = 'eta1 eta2 eta3 c Te'
        Qs                           =  'q2'
        H_name                       = 'HQ'
        L_name                       = 'LQ '
        P_name                       = 'PQ'
        type                         = PusztaiQsBulk
        variable                     = q1
        variable_H                   = 0
        variable_L                   = 1
      [../]

      [./SwitchingFunctionConstraintq1]
        h_name                       = hq1
        implicit                     = 1
        lambda                       = LaQ
        type                         = SwitchingFunctionConstraintEta
        variable                     = q1
      [../]

      [./ACInterfaceQ1]
        args                         =  'eta1 eta2 eta3 c q2'
        kappa_name                   = 'kappaQ'
        mob_name                     = 'LQ'
        type                         = ACInterface
        variable                     = 'q1'
        variable_L                   = 1
      [../]

      # -----------------------------------------------------------
      # Q2
      [./q2_dot]
        type                         = TimeDerivative
        variable                     = q2
      [../]

      [./SwitchingFunctionConstraintq2]
        h_name                       = hq2
        implicit                     = 1
        lambda                       = LaQ
        type                         = SwitchingFunctionConstraintEta
        variable                     = q2
      [../]

      [./PusztaiInterface2]
        Correction_y0                     = 1.0
        Correction_Z                      = 1.0
        Args                         = 'eta1 eta2 eta3 c Te'
        Qs                           =  'q1'
        H_name                       = 'HQ'
        implicit                     = 1
        L_name                     = 'LQ '
        P_name                       = 'PQ'
        type                         = PusztaiQsBulk
        variable                     = q2
        variable_H                   = 0
        variable_L                   = 1
      [../]

      [./ACInterfaceQ2]
        args                         =  'eta1 eta2 eta3 c q1'
        kappa_name                   = 'kappaQ'
        mob_name                     = 'LQ'
        type                         = ACInterface
        variable                     = 'q2'
        variable_L                   = 1
      [../]

      #--------------------------------------------------------------------------
      # Langrange Q
      [./SwitchingFunctionConstraintLagrangeQ]
        enable                       = 1
        epsilon                      = 1e-09
        etas                         = 'q1 q2'
        h_names                      = 'hq1 hq2'
        implicit                     = 1
        type                         = SwitchingFunctionConstraintLagrange
        variable                     = LaQ
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

  petsc_options_iname = '-pc_type -sub_pc_type -sub_pc_factor_shift_type'
  petsc_options_value = 'asm      ilu          nonzero'

  l_max_its = 40
  nl_max_its = 30
  nl_abs_tol = 1e-8
  end_time = 0.1

 [./TimeStepper]
    # Turn on time stepping
    type = IterationAdaptiveDT
    dt = 1.0e-5
    cutback_factor = 0.5
    growth_factor = 2.0
    optimal_iterations = 7
  [../]
[]

[Outputs]
  interval                       = 5
  exodus = true
  console = false
  print_perf_log = true
  output_initial = true
[]