within Annex60.Fluid.FMI.Examples;
block FixedResistanceDpM "FMU declaration for a fixed resistance"
   extends Annex60.Fluid.FMI.TwoPortSingleComponent(
     redeclare package Medium = Annex60.Media.Water,
     redeclare final Annex60.Fluid.FixedResistances.FixedResistanceDpM com(
      m_flow_nominal=m_flow_nominal,
      final dp_nominal=dp_nominal));

  parameter Modelica.SIunits.MassFlowRate m_flow_nominal(start=1)
    "Nominal mass flow rate";
  parameter Modelica.SIunits.Pressure dp_nominal=10 "Pressure";
  inner Modelica.Fluid.System system(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
    annotation (Placement(transformation(extent={{70,68},{90,88}})));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end FixedResistanceDpM;
