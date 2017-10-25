/****************************************************************/
/* MOOSE - Multiphysics Object Oriented Simulation Environment  */
/*                                                              */
/*          All contents are licensed under LGPL V2.1           */
/*             See LICENSE for full restrictions                */
/****************************************************************/
#ifndef MSKMELTTIMEDERIVATIVE_H
#define MSKMELTTIMEDERIVATIVE_H

// MOOSE includes
#include "TimeDerivative.h"
#include "JvarMapInterface.h"
#include "DerivativeMaterialInterface.h"

// Forward Declarations
class MskMeltTimeDerivative;

template <>
InputParameters validParams<MskMeltTimeDerivative>();

/**
 * A class for defining the time derivative of the heat equation.
 *
 * By default this Kernel computes:
 *   \f$ \rho * c_p * \frac{\partial T}{\partial t}, \f$
 * where \f$ \rho \f$ and \f$ c_p \f$ are material properties for "density" and
 * "specific_heat", respectively.
 */
class MskMeltTimeDerivative
    : public DerivativeMaterialInterface<JvarMapKernelInterface<TimeDerivative>>
{
public:
  MskMeltTimeDerivative(const InputParameters & parameters);

protected:
  virtual Real computeQpResidual() override;
  virtual Real computeQpJacobian() override;
  virtual Real computeQpOffDiagJacobian(unsigned int jvar) override;

  ///@{ Specific heat and its derivatives with respect to temperature and other coupled variables.
  const MaterialProperty<Real> & _specific_heat;
  const MaterialProperty<Real> & _d_specific_heat_dT;
  std::vector<const MaterialProperty<Real> *> _d_specific_heat_dargs;
  ///@}

  ///@{ Density and its derivatives with respect to temperature and other coupled variables.
  const MaterialProperty<Real> & _density;
  const MaterialProperty<Real> & _d_density_dT;
  std::vector<const MaterialProperty<Real> *> _d_density_dargs;
  ///@}

  unsigned int _Eta_var;
  const VariableValue & _Eta;
  const Real _Tmelt;
  const VariableValue & _Eta_dot;
  const VariableValue & _dEta_dot;

private:
  const MaterialProperty<Real> & _Mask;
};

#endif // SPECIFICHEATCONDUCTIONTIMEDERIVATIVE_H