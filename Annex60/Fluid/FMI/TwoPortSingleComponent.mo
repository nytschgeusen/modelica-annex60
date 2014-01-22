within Annex60.Fluid.FMI;
block TwoPortSingleComponent
  "Container to export a single thermofluid flow model with two ports as an FMU"
  extends TwoPort;
  replaceable Modelica.Fluid.Interfaces.PartialTwoPort partialTwoPort
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
protected
  BaseClasses.Inlet bouIn(redeclare final package Medium=Medium)
    "Boundary model for inlet"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  BaseClasses.Outlet bouOut(redeclare final package Medium=Medium)
    "Boundary component for outlet"
    annotation (Placement(transformation(extent={{44,-10},{64,10}})));
equation
  connect(inlet, bouIn.inlet) annotation (Line(
      points={{-110,0},{-61,0}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(bouIn.port, partialTwoPort.port_a) annotation (Line(
      points={{-40,0},{-10,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(partialTwoPort.port_b, bouOut.port) annotation (Line(
      points={{10,0},{44,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(bouOut.outlet, outlet) annotation (Line(
      points={{65,0},{110,0}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end TwoPortSingleComponent;
