within Annex60.Fluid.FMI;
block Fixme
  "Container to export a thermofluid flow model with two ports as an FMU"
 replaceable package Medium =Annex60.Media.Air "Medium in the component"
     annotation (choicesAllMatching = true);

 Interfaces.Inlet inlet(redeclare final package Medium = Medium)
   annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));

 Interfaces.Outlet outlet(redeclare final package Medium = Medium) annotation (Placement(transformation(extent={{100,
           -10},{120,10}}), iconTransformation(extent={{100,-10},{120,10}})));
  replaceable Sensors.TemperatureTwoPort               partialTwoPort(
      redeclare package Medium = Medium, m_flow_nominal=1) constrainedby
    Modelica.Fluid.Interfaces.PartialTwoPort
    annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
protected
  BaseClasses.Inlet bouIn(redeclare final package Medium=Medium)
    "Boundary model for inlet"
    annotation (Placement(transformation(extent={{-58,-10},{-38,10}})));
  BaseClasses.Outlet bouOut(redeclare final package Medium=Medium)
    "Boundary component for outlet"
    annotation (Placement(transformation(extent={{46,-10},{66,10}})));
equation

  connect(inlet,bouIn. inlet) annotation (Line(
      points={{-110,4.44089e-16},{-88,4.44089e-16},{-88,0},{-59,0}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(bouIn.port,partialTwoPort. port_a) annotation (Line(
      points={{-38,0},{-8,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(partialTwoPort.port_b,bouOut. port) annotation (Line(
      points={{12,0},{46,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(bouOut.outlet, outlet) annotation (Line(
      points={{67,0},{84,0},{84,4.44089e-16},{110,4.44089e-16}},
      color={0,0,255},
      smooth=Smooth.None));
 annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
           {100,100}}), graphics={Rectangle(extent={{-100,100},{100,-100}},
           lineColor={0,0,255}),
           Text(
         extent={{-151,147},{149,107}},
         lineColor={0,0,255},
         fillPattern=FillPattern.HorizontalCylinder,
         fillColor={0,127,255},
         textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=false,
                  extent={{-100,-100},{100,100}}), graphics));
end Fixme;
