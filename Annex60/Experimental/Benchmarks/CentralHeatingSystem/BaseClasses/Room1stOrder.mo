within Annex60.Experimental.Benchmarks.CentralHeatingSystem.BaseClasses;
model Room1stOrder "Strong simplified thermal room model"
  //Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heaCap(T(start=T_start,stateSelect=StateSelect.always),C=CRoom) // stateSelect=StateSelect.always was necessary in Dymola 2015 and earlier versions to avoid numerical problems
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heaCap(T(start=T_start),C=CRoom)
 "Overall heat capacity of the building"
    annotation (Placement(transformation(extent={{-10,-8},{10,12}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_amb
    "Heat port to the environment"
    annotation (Placement(transformation(extent={{70,-10},{90,10}}), iconTransformation(extent={{70,-10},{90,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_sou
    "Heat port to the heat source"
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}}),iconTransformation(extent={{-90,-10},{-70,10}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor heaTranAmb(G=UAmb*AAmb)
    "Thermal conductance to the building ambient"
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  parameter Real UAmb(unit="W/(m2.K)")
    "Mean heat loss coefficient of the room to the ambient";
  parameter Modelica.SIunits.Area AAmb "Surface area of room to the ambient";
  parameter Modelica.SIunits.HeatCapacity CRoom
    "Total heat capacity of the room";
  parameter Modelica.SIunits.Temp_K T_start = 293.15
    "Start temperature of the room"
    annotation (Dialog(tab="Initialization"));
equation
  connect(heaTranAmb.port_b, port_amb) annotation (Line(
      points={{50,0},{80,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(heaTranAmb.port_a, heaCap.port) annotation (Line(
      points={{30,0},{14,0},{14,-20},{0,-20},{0,-8}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(heaCap.port, port_sou) annotation (Line(
      points={{0,-8},{0,-20},{-80,-20},{-80,0}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (defaultComponentName="room", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
    Rectangle(extent={{-80,80},{80,-80}},lineColor={0,0,0},fillPattern=FillPattern.Solid,fillColor={215,215,215},
            lineThickness =                                                                                                    0.5),
    Rectangle(extent={{-58,40},{22,-40}},lineColor={0,0,0},lineThickness=0.5,fillColor={215,215,215},
            fillPattern =                                                                                        FillPattern.Solid),
    Line(points={{-80,80},{-58,40}},color={0,0,0},thickness=0.5,smooth=Smooth.None),
    Line(points={{-80,-80},{-58,-40}},color={0,0,0},thickness=0.5,smooth=Smooth.None),
    Line(points={{22,40},{80,80}},color={0,0,0},thickness=0.5,smooth=Smooth.None),
    Line(points={{22,-40},{80,-80}},color={0,0,0},thickness=0.5,smooth=Smooth.None),
    Rectangle(extent={{-50,24},{-16,-40}},lineColor={0,0,0},lineThickness=0.5,fillColor={215,215,215},
            fillPattern =                                                                                         FillPattern.Solid),
    Polygon(points={{34,26},{68,46},{68,-44},{34,-26},{34,26}},lineColor={0,0,0},
            lineThickness =                                                                    0.5,smooth=Smooth.None,fillColor={215,215,215},
            fillPattern =                                                                                                    FillPattern.Solid),
    Text(extent={{26,-76},{118,-104}},lineColor={0,0,255},fillColor={230,230,230},
            fillPattern =                                                                        FillPattern.Solid,textString
            =                                                                                                    "%name")}));
end Room1stOrder;
