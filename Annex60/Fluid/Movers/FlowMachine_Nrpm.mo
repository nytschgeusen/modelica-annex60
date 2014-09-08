within Annex60.Fluid.Movers;
model FlowMachine_Nrpm
  "Fan or pump with ideally controlled speed Nrpm as input signal"
  extends Annex60.Fluid.Movers.BaseClasses.PrescribedFlowMachine;

  Modelica.Blocks.Interfaces.RealInput Nrpm(unit="1/min")
    "Prescribed rotational speed"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,120}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,120})));

equation
  if filteredSpeed then
    connect(Nrpm, filter.u) annotation (Line(
      points={{1.11022e-15,120},{0,104},{0,104},{0,88},{18.6,88}},
      color={0,0,127},
      smooth=Smooth.None));
    connect(filter.y, N_actual) annotation (Line(
      points={{34.7,88},{38.35,88},{38.35,50},{110,50}},
      color={0,0,127},
      smooth=Smooth.None));
    connect(filter.y, N_filtered) annotation (Line(
      points={{34.7,88},{50,88}},
      color={0,0,127},
      smooth=Smooth.None));

  else
    connect(Nrpm, N_actual) annotation (Line(
      points={{1.11022e-15,120},{0,120},{0,50},{110,50}},
      color={0,0,127},
      smooth=Smooth.None));
  end if;

  annotation (defaultComponentName="pump",
    Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{100,
            100}}), graphics={Text(extent={{20,126},{118,104}},textString=
              "N_in [rpm]")}),
    Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{100,
            100}}),     graphics),
    Documentation(info="<html>
<p>This is a model of a pump that needs to be controlled using an rpm setpoint. The mass flow rate is calculated from the pressure drop (or vice versa) based on a pump curve. Pump curves for the pressure drop and electrical power need to be provided as a series of working points for the pressure, volume flow rate and electrical power at the nominal rpm. Similarity laws are then applied for using the pump curves at non-nominal rpms. For low rpms a linear mass flow characteristic is assumed.</p>
<p><br><b>Main equations</b></p>
<p>The nominal pump curves are expressed using a series of points expressing the pressure drop dp and electrical power P as a function of m_flow at rpm n0:</p>
<p><img src=\"modelica://Annex60/Images/equations/equation-cmRgpUYo.png\" alt=\"dp_n0 = f(m_flow_n0)\"/></p>
<p><img src=\"modelica://Annex60/Images/equations/equation-x18dZPYZ.png\" alt=\"P_n0 = f(m_flow_n0)\"/></p>
<p>Similarity laws are applied for other mass flow rates:</p>
<p><img src=\"modelica://Annex60/Images/equations/equation-atqIflFQ.png\" alt=\"m_flow_n / m_flow_n0 = n/n0\"/></p>
<p><img src=\"modelica://Annex60/Images/equations/equation-3K68khAS.png\" alt=\"dp_n/dp_n0 = (n/n0)^2\"/></p>
<p><img src=\"modelica://Annex60/Images/equations/equation-n3bX8g6e.png\" alt=\"P/P_n0 = (n/n0)^3\"/></p>
<p>For low values of n/n0 an approximation is used.</p>
<p><br><b>Assumptions and limitations </b></p>
<p>The bevaviour of this model for low values of n/n0 is not necessarily correct. </p>
<p>The pump pressure curve should be decreasing to avoid the presence of multiple possible solutions for the mass flow rate.</p>
<p><br><b>Model use and important parameters </b></p>
<p>The most important pump parameter is the pressure curve (&QUOT;pressure&QUOT;) at the nominal mass flow rate (&QUOT;N_nominal&QUOT;). If the electrical power consumption needs to be computed then the electrical power curve (parameter &QUOT;power&QUOT;) or an efficiency curves (parameters &QUOT;hydraulicEfficiency&QUOT; and &QUOT;motorEfficiency&QUOT;) needs to be provided. Parameter &QUOT;use_powerCharacteristic&QUOT; can be used to choose between these two options.</p>
<h4>Model options</h4>
<p>If parameter &QUOT;motorCooledByFluid&QUOT; is enabled then electrical losses in the electrical motor (based on &QUOT;motorEfficiency&QUOT;) are added to the fluid stream as heat. </p>
<p>Similarly flow work is added to the fluid by default. Both these effects can be disabled by setting addPowerToMedium to false.</p>
<p>By default the rpm setpoint is filtered to increase the model stability and to mimic the inertia of the rotor. The dynamics tab can be used to set the corresponding parameters.</p>
<p><br><b>Validation</b></p>
<p>fixme: see wilo pressure curve validation [link]</p>
</html>",
      revisions="<html>
<ul>
<li>
February 14, 2012, by Michael Wetter:<br/>
Added filter for start-up and shut-down transient.
</li>
<li>
May 25, 2011, by Michael Wetter:<br/>
Revised implementation of energy balance to avoid having to use conditionally removed models.
</li>
<li>
July 27, 2010, by Michael Wetter:<br/>
Redesigned model to fix bug in medium balance.
</li>
<li>March 24, 2010, by Michael Wetter:<br/>
Revised implementation to allow zero flow rate.
</li>
<li>October 1, 2009,
    by Michael Wetter:<br/>
       Model added to the Annex60 library. 
</li>
<li><i>31 Oct 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br/>
       Model added to the Fluid library</li>
</ul>
</html>"));
end FlowMachine_Nrpm;
