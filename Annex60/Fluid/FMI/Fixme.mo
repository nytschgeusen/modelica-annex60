within Annex60.Fluid.FMI;
block Fixme
   extends Annex60.Fluid.FMI.TwoPortSingleComponent(redeclare
      HeatExchangers.HeaterCoolerPrescribed partialTwoPort(
      m_flow_nominal=m_flow_nominal,
      dp_nominal=dp_nominal,
      Q_flow_nominal=Q_flow_nominal));

  Modelica.Blocks.Interfaces.RealInput u "Control input"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  parameter Modelica.SIunits.HeatFlowRate Q_flow_nominal
    "Heat flow rate at u=1, positive for heating";
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal
    "Nominal mass flow rate";
  parameter Modelica.SIunits.Pressure dp_nominal "Pressure";
equation
  connect(partialTwoPort.u, u) annotation (Line(
      points={{-12,6},{-30,6},{-30,60},{-120,60}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end Fixme;
