within Annex60.Building;
package LowOrder
  "Package which contains a low order thermal zone model based on German guideline VDI 6007"
  package BaseClasses "Base classes for the low order VDI 6007 model"
    extends Modelica.Icons.BasesPackage;
    model ReducedOrderModel
      "Low Order building envelope model corresponding to VDI 6007"
      parameter Boolean withInnerwalls = true "If inner walls are existent" annotation(Dialog(tab = "Inner walls"));
      parameter Modelica.SIunits.ThermalResistance R1i = 0.0005955
        "Resistor 1 inner wall"                                                            annotation(Dialog(tab = "Inner walls", enable = if withInnerwalls then true else false));
      parameter Modelica.SIunits.HeatCapacity C1i = 14860000
        "Capacity 1 inner wall"                                                      annotation(Dialog(tab = "Inner walls", enable = if withInnerwalls then true else false));
      parameter Modelica.SIunits.Area Ai = 75.5 "Inner wall area" annotation(Dialog(tab = "Inner walls", enable = if withInnerwalls then true else false));
      parameter Modelica.SIunits.Temp_K T0all = 295.15
        "Initial temperature for all components";
      parameter Boolean withWindows = true "If windows are existent" annotation(Dialog(tab = "Outer walls", group = "Windows", enable = if withOuterwalls then true else false));
      parameter Real splitfac = 0
        "Factor for conv. part of rad. through windows"                           annotation(Dialog(tab = "Outer walls", group = "Windows", enable = if withWindows and withOuterwalls then true else false));
      parameter Modelica.SIunits.Area Aw = 10.5 "Window area" annotation(Dialog(tab = "Outer walls", group = "Windows", enable = if withWindows and withOuterwalls then true else false));
      parameter Modelica.SIunits.Emissivity epsw = 0.95
        "Emissivity of the windows"                                                 annotation(Dialog(tab = "Outer walls", group = "Windows", enable = if withWindows and withOuterwalls then true else false));
      parameter Modelica.SIunits.TransmissionCoefficient g = 0.7
        "Total energy transmittance"                                                          annotation(Dialog(tab = "Outer walls", group = "Windows", enable = if withWindows and withOuterwalls then true else false));
      parameter Boolean withOuterwalls = true
        "If outer walls (including windows) are existent"                                       annotation(Dialog(tab = "Outer walls"));
      parameter Modelica.SIunits.ThermalResistance RRest = 0.0427487
        "Resistor Rest outer wall"                                                              annotation(Dialog(tab = "Outer walls", enable = if withOuterwalls then true else false));
      parameter Modelica.SIunits.ThermalResistance R1o = 0.004366
        "Resistor 1 outer wall"                                                           annotation(Dialog(tab = "Outer walls", enable = if withOuterwalls then true else false));
      parameter Modelica.SIunits.HeatCapacity C1o = 1557570
        "Capacity 1 outer wall"                                                     annotation(Dialog(tab = "Outer walls", enable = if withOuterwalls then true else false));
      parameter Modelica.SIunits.Area Ao = 10.5 "Outer wall area" annotation(Dialog(tab = "Outer walls", enable = if withOuterwalls then true else false));
      parameter Modelica.SIunits.Volume Vair = 52.5
        "Volume of the air in the zone"                                             annotation(Dialog(tab = "Room air"));
      parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaiwi = 2.7
        "Coefficient of heat transfer for inner walls"                                                                   annotation(Dialog(tab = "Inner walls", enable = if withInnerwalls then true else false));
      parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaowi = 2.7
        "Outer wall's coefficient of heat transfer (inner side)"                                                                   annotation(Dialog(tab = "Outer walls", enable = if withOuterwalls then true else false));
      parameter Modelica.SIunits.Density rhoair = 1.19 "Density of the air" annotation(Dialog(tab = "Room air"));
      parameter Modelica.SIunits.SpecificHeatCapacity cair = 1007
        "Heat capacity of the air"                                                           annotation(Dialog(tab = "Room air"));
      parameter Modelica.SIunits.Emissivity epsi = 0.95
        "Emissivity of the inner walls"                                                 annotation(Dialog(tab = "Inner walls", enable = if withInnerwalls then true else false));
      parameter Modelica.SIunits.Emissivity epso = 0.95
        "Emissivity of the outer walls"                                                 annotation(Dialog(tab = "Outer walls", enable = if withOuterwalls then true else false));
      Annex60.Building.Components.DryAir.Airload airload(
        V=Vair,
        rho=rhoair,
        c=cair,
        T(nominal=293.15,
          min=278.15,
          max=323.15)) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={2,2})));
      Annex60.Utilities.HeatTransfer.HeatConv heatConvInnerwall(A=Ai, alpha=alphaiwi) if
           withInnerwalls
        annotation (Placement(transformation(extent={{28,-10},{48,10}})));
      Annex60.Building.LowOrder.BaseClasses.SimpleOuterWall outerwall(
        RRest=RRest,
        R1=R1o,
        C1=C1o,
        T0=T0all,
        port_b(T(
            nominal=293.15,
            min=278.15,
            max=323.15))) if withOuterwalls
        annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
      Annex60.Building.LowOrder.BaseClasses.SimpleInnerWall innerwall(
        R1=R1i,
        C1=C1i,
        T0=T0all,
        port_a(T(
            nominal=293.15,
            min=278.15,
            max=323.15))) if withInnerwalls
        annotation (Placement(transformation(extent={{56,-10},{76,10}})));
      Annex60.Utilities.HeatTransfer.HeatConv heatConvOuterwall(A=Ao, alpha=alphaowi) if
           withOuterwalls
        annotation (Placement(transformation(extent={{-24,-10},{-44,10}})));
      Annex60.Utilities.HeatTransfer.HeatToStar heatToStarOuterwall(eps=epso, A=Ao) if
           withOuterwalls annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-46,22})));
      Annex60.Utilities.HeatTransfer.HeatToStar heatToStarInnerwall(A=Ai, eps=epsi) if
           withInnerwalls annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=270,
            origin={52,22})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a internalGainsConv(T(nominal = 273.15 + 22, min = 273.15 - 30, max = 273.15 + 60)) annotation(Placement(transformation(extent = {{10, -100}, {30, -80}}), iconTransformation(extent = {{0, -100}, {40, -60}})));
      Annex60.Building.Components.DryAir.VarAirExchange airExchange(
        V=Vair,
        c=cair,
        rho=rhoair)
        annotation (Placement(transformation(extent={{-44,-40},{-24,-20}})));
      Modelica.Blocks.Interfaces.RealInput ventilationRate annotation(Placement(transformation(extent = {{20, -20}, {-20, 20}}, rotation = 270, origin = {-40, -100}), iconTransformation(extent = {{20, -20}, {-20, 20}}, rotation = 270, origin = {-40, -80})));
      Modelica.Blocks.Interfaces.RealInput ventilationTemperature annotation(Placement(transformation(extent = {{-120, -82}, {-80, -42}}), iconTransformation(extent = {{-100, -28}, {-60, -68}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a equalAirTemp if withOuterwalls annotation(Placement(transformation(extent = {{-110, -20}, {-70, 20}}), iconTransformation(extent = {{-100, -16}, {-60, 24}})));
      Annex60.Utilities.Interfaces.Star internalGainsRad annotation (Placement(
            transformation(extent={{70,-100},{90,-80}}), iconTransformation(
              extent={{54,-102},{100,-58}})));
      Annex60.Utilities.HeatTransfer.SolarRadToHeat solarRadToHeatWindowRad(coeff=g,
          A=Aw) if withWindows and withOuterwalls annotation (Placement(
            transformation(extent={{-46,74},{-26,94}}, rotation=0)));
      Annex60.Utilities.Interfaces.SolarRad_in solarRad_in if withWindows and
        withOuterwalls annotation (Placement(transformation(extent={{-102,60},{
                -82,80}}, rotation=0), iconTransformation(extent={{-102,34},{-60,
                74}})));
      Annex60.Building.LowOrder.BaseClasses.SolarRadMultiplier solarRadMultiplierWindowRad(x=1 -
            splitfac) if withWindows and withOuterwalls
        annotation (Placement(transformation(extent={{-72,72},{-52,92}})));
      Annex60.Building.LowOrder.BaseClasses.SolarRadMultiplier solarRadMultiplierWindowConv(x=
            splitfac) if withWindows and withOuterwalls
        annotation (Placement(transformation(extent={{-72,48},{-52,68}})));
      Annex60.Utilities.HeatTransfer.SolarRadToHeat solarRadToHeatWindowConv(A=Aw,
          coeff=g) if withWindows and withOuterwalls annotation (Placement(
            transformation(extent={{-46,50},{-26,70}}, rotation=0)));
      Annex60.Utilities.HeatTransfer.HeatToStar heatToStarWindow(A=Aw, eps=epsw) if
        withWindows and withOuterwalls
        annotation (Placement(transformation(extent={{-20,72},{0,92}})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature ventilationTemperatureConverter annotation(Placement(transformation(extent = {{-8, -8}, {8, 8}}, rotation = 90, origin = {-68, -42})));
    initial equation
      if abs(Aw) < 0.00001 and withWindows then
        Modelica.Utilities.Streams.print("WARNING!:in ReducedModel, withWindows is true (windows existent), but the area of the windows Aw is zero (or nearly zero). This might cause an error.");
      end if;
      if abs(Ao) < 0.00001 and withOuterwalls then
        Modelica.Utilities.Streams.print("WARNING!:in ReducedModel,withWindows is true (windows existent), but the area of the windows Aw is zero (or nearly zero). This might cause an error.");
      end if;
      if abs(Ai) < 0.00001 and withInnerwalls then
        Modelica.Utilities.Streams.print("WARNING!:in ReducedModel,withWindows is true (windows existent), but the area of the windows Aw is zero (or nearly zero). This might cause an error.");
      end if;
    equation
      if withWindows and withOuterwalls then
        connect(solarRad_in, solarRadMultiplierWindowRad.solarRad_in) annotation(Line(points = {{-92, 70}, {-75, 70}, {-75, 82}, {-71, 82}}, color = {255, 128, 0}, smooth = Smooth.None));
        connect(solarRad_in, solarRadMultiplierWindowConv.solarRad_in) annotation(Line(points = {{-92, 70}, {-75, 70}, {-75, 58}, {-71, 58}}, color = {255, 128, 0}, smooth = Smooth.None));
        connect(solarRadMultiplierWindowRad.solarRad_out, solarRadToHeatWindowRad.solarRad_in) annotation(Line(points = {{-53, 82}, {-46.1, 82}}, color = {255, 128, 0}, smooth = Smooth.None));
        connect(solarRadMultiplierWindowConv.solarRad_out, solarRadToHeatWindowConv.solarRad_in) annotation(Line(points = {{-53, 58}, {-46.1, 58}}, color = {255, 128, 0}, smooth = Smooth.None));
        connect(solarRadToHeatWindowRad.heatPort, heatToStarWindow.Therm) annotation(Line(points = {{-27, 82}, {-19.2, 82}}, color = {191, 0, 0}, smooth = Smooth.None));
        if withOuterwalls then
        else
          assert(withOuterwalls, "There must be outer walls, windows have to be counted too!");
        end if;
        if withInnerwalls then
        end if;
      end if;
      if withOuterwalls then
        connect(equalAirTemp, outerwall.port_a) annotation(Line(points={{-90,0},
                {-80,0},{-80,-0.909091},{-70,-0.909091}},                                                                          color = {191, 0, 0}, smooth = Smooth.None));
        connect(outerwall.port_b, heatToStarOuterwall.Therm) annotation(Line(points={{-50,
                -0.909091},{-46,-0.909091},{-46,12.8}},                                                                                  color = {191, 0, 0}, smooth = Smooth.None));
        connect(outerwall.port_b, heatConvOuterwall.port_b) annotation(Line(points={{-50,
                -0.909091},{-46.5,-0.909091},{-46.5,0},{-44,0}},                                                                                   color = {191, 0, 0}, smooth = Smooth.None));
        connect(heatConvOuterwall.port_a, airload.port) annotation(Line(points = {{-24, 0}, {-7, 0}}, color = {191, 0, 0}, smooth = Smooth.None));
        if withInnerwalls then
        end if;
      end if;
      if withInnerwalls then
        connect(innerwall.port_a, heatConvInnerwall.port_b) annotation(Line(points={{56,
                -0.909091},{51.5,-0.909091},{51.5,0},{48,0}},                                                                                  color = {191, 0, 0}, smooth = Smooth.None));
        connect(internalGainsRad, heatToStarInnerwall.Star) annotation(Line(points = {{80, -90}, {80, 54}, {10, 54}, {10, 40}, {52, 40}, {52, 31.1}}, color = {95, 95, 95}, pattern = LinePattern.None, smooth = Smooth.None));
      end if;
      connect(airExchange.port_b, airload.port) annotation(Line(points = {{-24, -30}, {-16, -30}, {-16, 0}, {-7, 0}}, color = {191, 0, 0}, smooth = Smooth.None));
      connect(internalGainsConv, airload.port) annotation(Line(points = {{20, -90}, {20, -30}, {-16, -30}, {-16, 0}, {-7, 0}}, color = {191, 0, 0}, smooth = Smooth.None));
      connect(airload.port, heatConvInnerwall.port_a) annotation(Line(points = {{-7, 0}, {-16, 0}, {-16, -30}, {20, -30}, {20, 0}, {28, 0}}, color = {191, 0, 0}, smooth = Smooth.None));
      connect(heatToStarInnerwall.Therm, innerwall.port_a) annotation(Line(points={{52,12.8},
              {52,-0.909091},{56,-0.909091}},                                                                                       color = {191, 0, 0}, smooth = Smooth.None));
      connect(heatToStarOuterwall.Star, internalGainsRad) annotation(Line(points = {{-46, 31.1}, {-46, 40}, {10, 40}, {10, 54}, {80, 54}, {80, -90}}, color = {95, 95, 95}, pattern = LinePattern.None, smooth = Smooth.None));
      connect(heatToStarWindow.Star, internalGainsRad) annotation(Line(points = {{-0.9, 82}, {10, 82}, {10, 54}, {80, 54}, {80, -90}}, color = {95, 95, 95}, pattern = LinePattern.None, smooth = Smooth.None));
      connect(solarRadToHeatWindowConv.heatPort, airload.port) annotation(Line(points = {{-27, 58}, {-16, 58}, {-16, 0}, {-7, 0}}, color = {191, 0, 0}, smooth = Smooth.None));
      connect(ventilationRate, airExchange.InPort1) annotation(Line(points = {{-40, -100}, {-40, -60}, {-50, -60}, {-50, -36.4}, {-43, -36.4}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(ventilationTemperature, ventilationTemperatureConverter.T) annotation(Line(points = {{-100, -62}, {-68, -62}, {-68, -51.6}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(ventilationTemperatureConverter.port, airExchange.port_a) annotation(Line(points = {{-68, -34}, {-68, -30}, {-44, -30}}, color = {191, 0, 0}, smooth = Smooth.None));
      annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), experiment(StopTime = 864000), experimentSetupOutput, Icon(graphics={  Rectangle(extent = {{-60, 74}, {100, -72}}, lineColor = {135, 135, 135}, fillColor = {135, 135, 135},
                fillPattern =                                                                                                    FillPattern.Solid), Rectangle(extent = {{14, 38}, {46, 12}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
                fillPattern =                                                                                                    FillPattern.Solid,
                lineThickness =                                                                                                    1), Rectangle(extent = {{14, 12}, {46, -14}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
                fillPattern =                                                                                                    FillPattern.Solid,
                lineThickness =                                                                                                    1), Rectangle(extent = {{-18, 12}, {14, -14}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
                fillPattern =                                                                                                    FillPattern.Solid,
                lineThickness =                                                                                                    1), Rectangle(extent = {{-18, 38}, {14, 12}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
                fillPattern =                                                                                                    FillPattern.Solid,
                lineThickness =                                                                                                    1)}), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <ul>
 <li>ReducedOrderModel is a simple component to compute the air temperature, heating load, etc. for a thermal zone. The zone is simplified to one outer wall, one inner wall and one air node. It is build out of standard components and <a href=\"Annex60.Building.LowOrder.BaseClasses.SimpleOuterWall\">SimpleOuterWall</a> and <a href=\"Annex60.Building.LowOrder.BaseClasses.SimpleInnerWall\">SimpleInnerWall</a>.</li>
 <li>The simplifications are based on the VDI 6007, which describes the thermal behaviour of a thermal zone with the equations for an electric circuit, hence they are equal. The heat transfer is described with resistances and the heat storage with capacitances.</li>
 <li>The resolution of the model is very rough (only one air node), so the model is primarly thought for computing the air temperature of the room and with that, the heating and cooling load. It is more a heat load generator than a full building model. It is thought mainly for city district simulations, in which a lot of buildings has to be taken into account and the specific cirumstances in one building can be neglected.</li>
 <li>Inputs: The model needs the outdoor air temperature and the Infiltration/VentilationRate for the Ventilation, the equivalent outdoor temperature (see <a href=\"Annex60.Building.LowOrder.BaseClasses.EqAirTemp\">EqAirTemp</a>) for the heat conductance through the outer walls and the solar radiation through the windows. There are two ports, one thermal, one star, for inner loads, heating etc. . </li>
 <li>Parameters: Inner walls: R and C for the heat conductance and storage in the wall, A, alpha and epsilon for the heat transfer. Outer walls: Similar to inner walls, but with two R&apos;s, as there is also a conductance through the walls. Windows: g, A, epsilon and a splitfac. Please see VDI 6007 for computing the R&apos;s and C&apos;s.</li>
 </ul>
 <h4><span style=\"color:#008000\">Level of Development</span></h4>
 <p><img src=\"modelica://Annex60/Images/stars5.png\"/></p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>The concept is described in VDI 6007. All outer walls and inner walls (including the windows) are merged together to one wall respectively. The inner walls are used as heat storages only, there is no heat transfer out of the zone (adiabate). This assumption is valid as long as the walls are in the zone or touch zones with a similar temperature. All walls, which touch other thermal zones are put together in the outer walls, which have an heat transfer with <a href=\"Annex60.Building.LowOrder.BaseClasses.EqAirTemp\">EqAirTemp</a>.</p>
 <p>The two different &QUOT;wall types&QUOT; are connected through a convective heat circuit and a star circuit (different as in VDI 6007). As the air node can only react to convective heat, it is integrated in the convectice heat circuit. To add miscellaneous other heat sources/sinks (inner loads, heating) to the circiuts, there is one heat port to the convective circuit and one star port to the star circuit.</p>
 <p>The last influence is the solar radiation through the windows. The heat transfer through the windows is considered in the outer walls. The beam is considered in the star circuit. There is a bypass from the beam to the convective circuit implemented, as a part of the beam is sometimes considered directly as convective heat.</p>
 <p><br><b><font style=\"color: #008000; \">References</font></b></p>
 <ul>
 <li>German Association of Engineers: Guideline VDI 6007-1, March 2012: Calculation of transient thermal response of rooms and buildings - Modelling of rooms.</li>
 <li>Lauster, M.; Teichmann, J.; Fuchs, M.; Streblow, R.; Mueller, D. (2014): Low order thermal network models for dynamic simulations of buildings on city district scale. In: Building and Environment 73, p. 223&ndash;231. DOI: <a href=\"http://dx.doi.org/10.1016/j.buildenv.2013.12.016\">10.1016/j.buildenv.2013.12.016</a></p>.</li>
 </ul>
 <h4><span style=\"color:#008000\">Example Results</span></h4>
 <p>See <a href=\"Annex60.Building.LowOrder.Validation\">Vadliation</a> for some results. </p>
 </html>",     revisions = "<html>
 <p><ul>
 <li><i>January 2012,&nbsp;</i> by Moritz Lauster:<br/>Implemented.</li>
 </ul></p>
 </html>"));
    end ReducedOrderModel;

    model SimpleInnerWall "1 capacitance, 1 resistance"
      import SI = Modelica.SIunits;
      parameter SI.ThermalResistance R1 = 1 "Resistance 1";
      parameter SI.HeatCapacity C1 = 1 "Capacity 1";
      parameter Modelica.SIunits.Temp_K T0 = 295.15
        "Initial temperature for all components";
      //parameter SI.Area A=16 "Wall Area";
      Modelica.Thermal.HeatTransfer.Components.ThermalResistor Res1(R = R1) annotation(Placement(transformation(extent = {{-18, 18}, {2, 38}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a annotation(Placement(transformation(extent = {{-110, -10}, {-90, 10}}, rotation = 0), iconTransformation(extent = {{-110, -10}, {-90, 10}})));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor load1(C = C1, T(start = T0)) annotation(Placement(transformation(extent = {{32, 4}, {52, 24}})));
    equation
      connect(port_a, Res1.port_a) annotation(Line(points = {{-100, 0}, {-60, 0}, {-60, 28}, {-18, 28}}, color = {191, 0, 0}, smooth = Smooth.None));
      connect(Res1.port_b, load1.port) annotation(Line(points = {{2, 28}, {20, 28}, {20, 0}, {42, 0}, {42, 4}}, color = {191, 0, 0}, smooth = Smooth.None));
      annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 120}}), graphics), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <ul>
 <li>This thermal model represents the one dimensional heat transfer into a simple wall with dynamic characteristics (heat storage, 1 capacitance). Therefore, this (inner) wall is only used as a heat storage with a heat resistance.</li>
 <li>It is based on the VDI 6007, in which the heat transfer through inner walls is described by a comparison with an electric circuit.</li>
 <li>Normally, it should be used together with the other parts of the VDI 6007 model library. It represents all walls with a heat transfer in only one zone. Make sure, you got the right R&apos;s and C&apos;s (e.g. like they are computed in VDI 6007).</li>
 </ul>
 <h4><span style=\"color:#008000\">Level of Development</span></h4>
 <p><img src=\"modelica://AixLib/Images/stars4.png\"/></p>
 <h4><span style=\"color:#008000\">Assumptions</span></h4>
 <p>The model underlies all assumptions which are made in VDI 6007, especially that all heat transfer parts are combined in one part. It can be used in combination with various other models.</p>
 <h4><span style=\"color:#008000\">Known Limitations</span></h4>
 <p>There are no known limitaions.</p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>The model works like an electric circuit as the equations of heat transfer are similar to them. All elements used in the model are taken from the EBC standard library.</p>
 <p><br><b><font style=\"color: #008000; \">References</font></b></p>
 <ul>
 <li>German Association of Engineers: Guideline VDI 6007-1, March 2012: Calculation of transient thermal response of rooms and buildings - Modelling of rooms.</li>
 </ul>
 <h4><span style=\"color:#008000\">Example Results</span></h4>
 <p>The wall model is tested and validated in the context of the <a href=\"AixLib.Building.LowOrder.BaseClasses.ReducedOrderModel\">ReducedOrderModel</a>. See <a href=\"AixLib.Building.LowOrder.Validation\">Validation</a> for some results.</p>
 </html>",     revisions = "<html>
 <p><ul>
 <li><i>January 2012,&nbsp;</i> by Moritz Lauster:<br/>Implemented.</li>
 </ul></p>
 </html>"),     Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 120}}), graphics={  Rectangle(extent = {{-86, 60}, {-34, 26}}, fillColor = {255, 213, 170},
                fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{-28, 60}, {26, 26}}, fillColor = {255, 213, 170},
                fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{32, 60}, {86, 26}}, fillColor = {255, 213, 170},
                fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{0, 20}, {54, -14}}, fillColor = {255, 213, 170},
                fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{-60, 20}, {-6, -14}}, fillColor = {255, 213, 170},
                fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{-86, -20}, {-34, -54}}, fillColor = {255, 213, 170},
                fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{-28, -20}, {26, -54}}, fillColor = {255, 213, 170},
                fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{32, -20}, {86, -54}}, fillColor = {255, 213, 170},
                fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{-60, -60}, {-6, -94}}, fillColor = {255, 213, 170},
                fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{0, -60}, {54, -94}}, fillColor = {255, 213, 170},
                fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{-60, 100}, {-6, 66}}, fillColor = {255, 213, 170},
                fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{0, 100}, {54, 66}}, fillColor = {255, 213, 170},
                fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{60, -60}, {114, -94}}, fillColor = {255, 213, 170},
                fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{60, 20}, {116, -14}}, fillColor = {255, 213, 170},
                fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{60, 100}, {116, 66}}, fillColor = {255, 213, 170},
                fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{-120, -60}, {-66, -94}}, fillColor = {255, 213, 170},
                fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{-120, 20}, {-66, -14}}, fillColor = {255, 213, 170},
                fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{-120, 100}, {-66, 66}}, fillColor = {255, 213, 170},
                fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{-88, 120}, {-120, -100}}, fillColor = {255, 255, 255},
                fillPattern =                                                                                                    FillPattern.Solid, pattern = LinePattern.None), Rectangle(extent = {{120, 120}, {89, -100}}, fillColor = {255, 255, 255},
                fillPattern =                                                                                                    FillPattern.Solid, pattern = LinePattern.None), Line(points = {{-90, 0}, {-2, 0}}, color = {0, 0, 0}, thickness = 0.5, smooth = Smooth.None), Rectangle(extent = {{-74, 12}, {-26, -10}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                    0.5, fillColor = {255, 255, 255},
                fillPattern =                                                                                                    FillPattern.Solid), Line(points = {{-2, 0}, {-2, -32}}, color = {0, 0, 0}, thickness = 0.5, smooth = Smooth.None), Rectangle(extent = {{15, -32}, {-19, -44}},
                lineThickness =                                                                                                    0.5, fillColor = {255, 255, 255},
                fillPattern =                                                                                                    FillPattern.Solid, pattern = LinePattern.None), Line(points = {{-19, -32}, {15, -32}}, pattern = LinePattern.None, thickness = 0.5, smooth = Smooth.None), Line(points = {{-19, -44}, {15, -44}}, pattern = LinePattern.None, thickness = 0.5, smooth = Smooth.None), Text(extent = {{-90, 142}, {90, 104}}, lineColor = {0, 0, 255}, textString = "%name")}));
    end SimpleInnerWall;

    model SimpleOuterWall "1 capacitance, 2 resistors"
      import SI = Modelica.SIunits;
      parameter SI.ThermalResistance RRest = 1 "Resistor Rest";
      parameter SI.ThermalResistance R1 = 1 "Resistor 1";
      parameter SI.HeatCapacity C1 = 1 "Capacity 1";
      //parameter SI.Area A=16 "Wall Area";
      parameter Modelica.SIunits.Temp_K T0 = 295.15
        "Initial temperature for all components";
      Modelica.Thermal.HeatTransfer.Components.ThermalResistor ResRest(R = RRest) annotation(Placement(transformation(extent = {{-48, 20}, {-28, 40}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.ThermalResistor Res1(R = R1) annotation(Placement(transformation(extent = {{38, 20}, {58, 40}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a annotation(Placement(transformation(extent = {{-110, -10}, {-90, 10}}, rotation = 0), iconTransformation(extent = {{-110, -10}, {-90, 10}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b annotation(Placement(transformation(extent = {{90, -10}, {110, 10}}, rotation = 0), iconTransformation(extent = {{90, -10}, {110, 10}})));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor load1(C = C1, T(start = T0)) annotation(Placement(transformation(extent = {{-12, 2}, {8, -18}})));
    equation
      connect(port_a, ResRest.port_a) annotation(Line(points = {{-100, 0}, {-62, 0}, {-62, 30}, {-48, 30}}, color = {191, 0, 0}, smooth = Smooth.None));
      connect(ResRest.port_b, load1.port) annotation(Line(points = {{-28, 30}, {-2, 30}, {-2, 2}}, color = {191, 0, 0}, smooth = Smooth.None));
      connect(load1.port, Res1.port_a) annotation(Line(points = {{-2, 2}, {-2, 30}, {38, 30}}, color = {191, 0, 0}, smooth = Smooth.None));
      connect(Res1.port_b, port_b) annotation(Line(points = {{58, 30}, {80, 30}, {80, 0}, {100, 0}}, color = {191, 0, 0}, smooth = Smooth.None));
      annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 120}}), graphics), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <ul>
 <li>This thermal model represents the one dimensional heat transfer of a simple wall with dynamic characteristics (heat storage, 1 capacitance)</li>
 <li>It is based on the VDI 6007, in which the heat transfer through outer walls is described by a comparison with an electric circuit.</li>
 <li>Normally, it should be used together with the other parts of the VDI 6007 model library. It represents all walls with a heat transfer. Make sure, you got the right R&apos;s and C&apos;s (e.g. like they are computed in VDI 6007).</li>
 </ul>
 <h4><span style=\"color:#008000\">Level of Development</span></h4>
 <p><img src=\"modelica://AixLib/Images/stars4.png\"/></p>
 <h4><span style=\"color:#008000\">Assumptions</span></h4>
 <p>The model underlies all assumptions which are made in VDI 6007, especially that all heat transfer parts are combined in one part. It can be used in combination with various other models.</p>
 <h4><span style=\"color:#008000\">Known Limitations</span></h4>
 <p>There are no known limitaions.</p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>The model works like an electric circuit as the equations of heat transfer are similar to them. All elements used in the model are taken from the EBC standard library.</p>
 <p><br><b><font style=\"color: #008000; \">References</font></b></p>
 <ul>
 <li>German Association of Engineers: Guideline VDI 6007-1, March 2012: Calculation of transient thermal response of rooms and buildings - Modelling of rooms.</li>
 </ul>
 <h4><span style=\"color:#008000\">Example Results</span></h4>
 <p>The wall model is tested and validated in the context of the <a href=\"AixLib.Building.LowOrder.BaseClasses.ReducedOrderModel\">ReducedOrderModel</a>. See <a href=\"AixLib.Building.LowOrder.Validation\">Validation</a> for some results.</p>
 </html>",     revisions = "<html>
 <p><ul>
 <li><i>January 2012,&nbsp;</i> by Moritz Lauster:<br/>Implemented.</li>
 </ul></p>
 </html>"),     Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 120}}), graphics={  Rectangle(extent = {{-86, 60}, {-34, 26}}, fillColor = {255, 213, 170},
                fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{-28, 60}, {26, 26}}, fillColor = {255, 213, 170},
                fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{32, 60}, {86, 26}}, fillColor = {255, 213, 170},
                fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{0, 20}, {54, -14}}, fillColor = {255, 213, 170},
                fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{-60, 20}, {-6, -14}}, fillColor = {255, 213, 170},
                fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{-86, -20}, {-34, -54}}, fillColor = {255, 213, 170},
                fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{-28, -20}, {26, -54}}, fillColor = {255, 213, 170},
                fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{32, -20}, {86, -54}}, fillColor = {255, 213, 170},
                fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{-60, -60}, {-6, -94}}, fillColor = {255, 213, 170},
                fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{0, -60}, {54, -94}}, fillColor = {255, 213, 170},
                fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{-60, 100}, {-6, 66}}, fillColor = {255, 213, 170},
                fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{0, 100}, {54, 66}}, fillColor = {255, 213, 170},
                fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{60, -60}, {114, -94}}, fillColor = {255, 213, 170},
                fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{60, 20}, {116, -14}}, fillColor = {255, 213, 170},
                fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{60, 100}, {116, 66}}, fillColor = {255, 213, 170},
                fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{-120, -60}, {-66, -94}}, fillColor = {255, 213, 170},
                fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{-120, 20}, {-66, -14}}, fillColor = {255, 213, 170},
                fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{-120, 100}, {-66, 66}}, fillColor = {255, 213, 170},
                fillPattern =                                                                                                    FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(extent = {{-90, 120}, {-120, -100}}, fillColor = {255, 255, 255},
                fillPattern =                                                                                                    FillPattern.Solid, pattern = LinePattern.None), Rectangle(extent = {{120, 120}, {89, -100}}, fillColor = {255, 255, 255},
                fillPattern =                                                                                                    FillPattern.Solid, pattern = LinePattern.None), Line(points = {{-90, 0}, {90, 0}}, color = {0, 0, 0}, thickness = 0.5, smooth = Smooth.None), Rectangle(extent = {{-74, 12}, {-26, -10}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                    0.5, fillColor = {255, 255, 255},
                fillPattern =                                                                                                    FillPattern.Solid), Rectangle(extent = {{28, 12}, {76, -10}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                    0.5, fillColor = {255, 255, 255},
                fillPattern =                                                                                                    FillPattern.Solid), Line(points = {{-1, 0}, {-1, -32}}, color = {0, 0, 0}, thickness = 0.5, smooth = Smooth.None), Rectangle(extent = {{16, -32}, {-18, -44}},
                lineThickness =                                                                                                    0.5, fillColor = {255, 255, 255},
                fillPattern =                                                                                                    FillPattern.Solid, pattern = LinePattern.None), Line(points = {{-18, -32}, {16, -32}}, pattern = LinePattern.None, thickness = 0.5, smooth = Smooth.None), Line(points = {{-18, -44}, {16, -44}}, pattern = LinePattern.None, thickness = 0.5, smooth = Smooth.None), Text(extent = {{-90, 142}, {90, 104}}, lineColor = {0, 0, 255}, textString = "%name")}));
    end SimpleOuterWall;

    model SolarRadMultiplier "scalar radiant input * factor x"
      parameter Real x = 1;
      Annex60.Utilities.Interfaces.SolarRad_in solarRad_in
        annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
      Annex60.Utilities.Interfaces.SolarRad_out solarRad_out
        annotation (Placement(transformation(extent={{80,-10},{100,10}})));
    equation
      solarRad_out.I = solarRad_in.I * x;
      annotation(Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <ul>
 <li>Multiplies the scalar radiance input with a factor x</li>
 <li>This component can be used to in- or decrease a scalar radiance, e.g. if you would like to split the radiance, use two blocks, one with x, one with 1-x.</li>
 </ul>
 <h4><span style=\"color:#008000\">Level of Development</span></h4>
 <p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
 </html>",     revisions = "<html>
 <p><ul>
 <li><i>January 2012,&nbsp;</i> by Moritz Lauster:<br/>Implemented.</li>
 </ul></p>
 </html>"),     Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent = {{-80, 40}, {80, -40}}, lineColor = {215, 215, 215}, fillColor = {239, 239, 159},
                fillPattern =                                                                                                    FillPattern.Solid), Text(extent = {{-80, 20}, {-40, -20}}, lineColor = {0, 0, 0}, textString = "I", fontName = "Times New Roman"), Text(extent = {{-60, 12}, {-20, -28}}, lineColor = {0, 0, 0}, fontName = "Times New Roman", textString = "in"), Text(extent = {{-50, 20}, {62, -20}}, lineColor = {0, 0, 0}, fontName = "Times New Roman", textString = " * fac"), Line(points = {{54, 0}, {72, 0}, {62, 6}}, color = {0, 0, 255}, smooth = Smooth.None), Line(points = {{72, 0}, {62, -6}}, color = {0, 0, 255}, smooth = Smooth.None)}));
    end SolarRadMultiplier;

    model SolarRadWeightedSum
      "weights vec input and sums it up to one scalar output"
      parameter Integer n = 1 "number of inputs and weightfactors";
      parameter Real weightfactors[n] = {1}
        "weightfactors with which the inputs are to be weighted";
      Annex60.Utilities.Interfaces.SolarRad_in solarRad_in[n] annotation (
          Placement(transformation(extent={{-100,0},{-80,20}}),
            iconTransformation(extent={{-100,-10},{-80,10}})));
      Annex60.Utilities.Interfaces.SolarRad_out solarRad_out annotation (
          Placement(transformation(extent={{80,0},{100,20}}),
            iconTransformation(extent={{80,-10},{100,10}})));
    protected
      parameter Real sumWeightfactors = if sum(weightfactors) == 0 then 0.0001 else sum(weightfactors);
    initial equation
      assert(n == size(weightfactors, 1), "weightfactors (likely Aw) has to have n elements");
      if sum(weightfactors) == 0 then
        Modelica.Utilities.Streams.print("WARNING!:The sum of the weightfactors (likely the window areas) in rad_weighted_sum is 0. In case of no radiation (e.g. no windows) this might be correct.");
      end if;
    equation
      solarRad_out.I = solarRad_in.I * weightfactors / sumWeightfactors;
      annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), Icon(graphics={  Rectangle(extent = {{-80, 80}, {80, -80}}, lineColor = {0, 0, 0}), Text(extent = {{-40, 70}, {-22, 60}}, lineColor = {0, 0, 0}, textString = "*Gn"), Line(points = {{-80, 0}, {-60, -20}}, color = {0, 0, 0}, smooth = Smooth.None), Line(points = {{-80, 0}, {-60, 20}}, color = {0, 0, 0}, smooth = Smooth.None), Line(points = {{-80, 0}, {-60, 60}}, color = {0, 0, 0}, smooth = Smooth.None), Line(points = {{72, 0}, {82, 0}, {20, 0}}, color = {0, 0, 0}, smooth = Smooth.None), Line(points = {{-60, -20}, {0, -20}}, color = {0, 0, 0}, smooth = Smooth.None), Line(points = {{-60, 20}, {0, 20}}, color = {0, 0, 0}, smooth = Smooth.None), Line(points = {{-60, 60}, {0, 60}}, color = {0, 0, 0}, smooth = Smooth.None), Line(points = {{-60, -60}, {0, -60}}, color = {0, 0, 0}, smooth = Smooth.None), Line(points = {{-80, 0}, {-60, -60}}, color = {0, 0, 0}, smooth = Smooth.None), Line(points = {{0, 20}, {20, 0}}, color = {0, 0, 0}, smooth = Smooth.None), Line(points = {{0, 60}, {20, 0}}, color = {0, 0, 0}, smooth = Smooth.None), Line(points = {{20, 0}, {0, -60}}, color = {0, 0, 0}, smooth = Smooth.None), Line(points = {{0, -20}, {20, 0}}, color = {0, 0, 0}, smooth = Smooth.None), Text(extent = {{10, -2}, {72, -14}}, lineColor = {0, 0, 0}, textString = "/sum(Gn)"), Text(extent = {{-42, 30}, {-20, 20}}, lineColor = {0, 0, 0}, textString = "*Gn"), Text(extent = {{-42, -10}, {-20, -20}}, lineColor = {0, 0, 0}, textString = "*Gn"), Text(extent = {{-42, -50}, {-20, -60}}, lineColor = {0, 0, 0}, textString = "*Gn")}), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <ul>
 <li>This component weights the n-vectorial radiant input with n weightfactors and has a scalar output.</li>
 <li>There is one fundamental equation: input(n)*weightfactors(n)/sum(weightfactors).</li>
 <li>You can use this component to weight a radiant input and sum it up to one scalar output, e.g. weight the radiance of the sun of n directions with the areas of windows in n directions and sum it up to one scalar radiance on a non-directional window</li>
 </ul>
 <h4><span style=\"color:#008000\">Level of Development</span></h4>
 <p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
 <h4><span style=\"color:#008000\">Known Limitations</span></h4>
 <p>If the weightfactors are all zero, Dymola tries to divide through zero. You will get a warning and the output is set to zero.</p>
 </html>",     revisions = "<html>
 <p><ul>
 <li><i>January 2012,&nbsp;</i> by Moritz Lauster:<br/>Implemented.</li>
 </ul></p>
 </html>"));
    end SolarRadWeightedSum;
  end BaseClasses;

  package Validation "Validation examples for the low order building model"
    extends Modelica.Icons.ExamplesPackage;
    package VDI6007 "VDI 6007 validation test cases"
      extends Modelica.Icons.ExamplesPackage;
      model TestCase_5
        extends Modelica.Icons.Example;
        output Modelica.SIunits.Conversions.NonSIunits.Temperature_degC referenceTemp[1];
        output Modelica.SIunits.Temp_K simulationTemp;
        Modelica.Blocks.Sources.Constant infiltrationRate(k = 0) annotation(Placement(transformation(extent = {{30, -4}, {40, 6}})));
        Modelica.Blocks.Sources.Constant infiltrationTemp(k = 22) annotation(Placement(transformation(extent = {{6, -4}, {16, 6}})));
        Annex60.Utilities.HeatTransfer.HeatToStar HeatToStar(A=2)
          annotation (Placement(transformation(extent={{42,-100},{62,-80}})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow machinesConvective annotation(Placement(transformation(extent = {{10, -52}, {30, -32}})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow personsConvective annotation(Placement(transformation(extent = {{10, -72}, {30, -52}})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow personsRadiative annotation(Placement(transformation(extent = {{10, -100}, {30, -80}})));
        Modelica.Blocks.Sources.CombiTimeTable innerLoads(extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, tableOnFile = false, table = [0, 0, 0, 0; 3600, 0, 0, 0; 7200, 0, 0, 0; 10800, 0, 0, 0; 14400, 0, 0, 0; 18000, 0, 0, 0; 21600, 0, 0, 0; 25200, 0, 0, 0; 25200, 80, 80, 200; 28800, 80, 80, 200; 32400, 80, 80, 200; 36000, 80, 80, 200; 39600, 80, 80, 200; 43200, 80, 80, 200; 46800, 80, 80, 200; 50400, 80, 80, 200; 54000, 80, 80, 200; 57600, 80, 80, 200; 61200, 80, 80, 200; 61200, 0, 0, 0; 64800, 0, 0, 0; 72000, 0, 0, 0; 75600, 0, 0, 0; 79200, 0, 0, 0; 82800, 0, 0, 0; 86400, 0, 0, 0], columns = {2, 3, 4}) annotation(Placement(transformation(extent = {{-58, -72}, {-38, -52}})));
        Annex60.Building.LowOrder.BaseClasses.ReducedOrderModel reducedModel(
          C1i=1.48216e+007,
          C1o=1.60085e+006,
          alphaiwi=2.2,
          epsi=1,
          epso=1,
          T0all(displayUnit="K") = 295.15,
          Aw=7,
          splitfac=0.09,
          R1i=0.000595515,
          Ai=75.5,
          epsw=1,
          g=1,
          RRest=0.042748777,
          R1o=0.004366222,
          Ao=10.5) annotation (Placement(transformation(extent={{48,26},{82,66}})));
        Modelica.Blocks.Sources.CombiTimeTable outdoorTemp(extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, columns = {2, 3, 4}, table = [0, 291.95, 0, 0; 3600, 291.95, 0, 0; 3600, 290.25, 0, 0; 7200, 290.25, 0, 0; 7200, 289.65, 0, 0; 10800, 289.65, 0, 0; 10800, 289.25, 0, 0; 14400, 289.25, 0, 0; 14400, 289.65, 0, 0; 18000, 289.65, 0, 0; 18000, 290.95, 0, 0; 21600, 290.95, 0, 0; 21600, 293.45, 0, 0; 25200, 293.45, 0, 0; 25200, 295.95, 0, 0; 28800, 295.95, 0, 0; 28800, 297.95, 0, 0; 32400, 297.95, 0, 0; 32400, 299.85, 0, 0; 36000, 299.85, 0, 0; 36000, 301.25, 0, 0; 39600, 301.25, 0, 0; 39600, 302.15, 0, 0; 43200, 302.15, 0, 0; 43200, 302.85, 0, 0; 46800, 302.85, 0, 0; 46800, 303.55, 0, 0; 50400, 303.55, 0, 0; 50400, 304.05, 0, 0; 54000, 304.05, 0, 0; 54000, 304.15, 0, 0; 57600, 304.15, 0, 0; 57600, 303.95, 0, 0; 61200, 303.95, 0, 0; 61200, 303.25, 0, 0; 64800, 303.25, 0, 0; 64800, 302.05, 0, 0; 68400, 302.05, 0, 0; 68400, 300.15, 0, 0; 72000, 300.15, 0, 0; 72000, 297.85, 0, 0; 75600, 297.85, 0, 0; 75600, 296.05, 0, 0; 79200, 296.05, 0, 0; 79200, 295.05, 0, 0; 82800, 295.05, 0, 0; 82800, 294.05, 0, 0; 86400, 294.05, 0, 0]) annotation(Placement(transformation(extent = {{-62, 22}, {-42, 42}})));
        Modelica.Blocks.Sources.CombiTimeTable windowRad(extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, table = [0, 0, 0, 0, 0, 0.0; 3600, 0, 0, 0, 0, 0.0; 10800, 0, 0, 0, 0, 0.0; 14400, 0, 0, 0, 0, 0.0; 14400, 0, 0, 17, 0, 0.0; 18000, 0, 0, 17, 0, 0.0; 18000, 0, 0, 38, 0, 0.0; 21600, 0, 0, 38, 0, 0.0; 21600, 0, 0, 59, 0, 0.0; 25200, 0, 0, 59, 0, 0.0; 25200, 0, 0, 98, 0, 0.0; 28800, 0, 0, 98, 0, 0.0; 28800, 0, 0, 186, 0, 0.0; 32400, 0, 0, 186, 0, 0.0; 32400, 0, 0, 287, 0, 0.0; 36000, 0, 0, 287, 0, 0.0; 36000, 0, 0, 359, 0, 0.0; 39600, 0, 0, 359, 0, 0.0; 39600, 0, 0, 385, 0, 0.0; 43200, 0, 0, 385, 0, 0.0; 43200, 0, 0, 359, 0, 0.0; 46800, 0, 0, 359, 0, 0.0; 46800, 0, 0, 287, 0, 0.0; 50400, 0, 0, 287, 0, 0.0; 50400, 0, 0, 186, 0, 0.0; 54000, 0, 0, 186, 0, 0.0; 54000, 0, 0, 98, 0, 0.0; 57600, 0, 0, 98, 0, 0.0; 57600, 0, 0, 59, 0, 0.0; 61200, 0, 0, 59, 0, 0.0; 61200, 0, 0, 38, 0, 0.0; 64800, 0, 0, 38, 0, 0.0; 64800, 0, 0, 17, 0, 0.0; 68400, 0, 0, 17, 0, 0.0; 68400, 0, 0, 0, 0, 0.0; 72000, 0, 0, 0, 0, 0.0; 82800, 0, 0, 0, 0, 0.0; 86400, 0, 0, 0, 0, 0.0], columns = {2, 3, 4, 5, 6}) annotation(Placement(transformation(extent = {{-96, 68}, {-76, 88}})));
        Annex60.Utilities.Sources.PrescribedSolarRad PrescribedSolarRad(n=5)
          annotation (Placement(transformation(extent={{-60,68},{-40,88}})));
        Annex60.Building.Components.Weather.Sunblind sunblind(n=5, gsunblind={0,0,0.15,
              0,0}) annotation (Placement(transformation(extent={{-30,67},{-10,87}})));
        Annex60.Building.LowOrder.BaseClasses.SolarRadWeightedSum SolarRadWeightedSum(n=5,
            weightfactors={0,0,7,0,0})
          annotation (Placement(transformation(extent={{-2,68},{18,88}})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature varTemp annotation(Placement(transformation(extent = {{-8, 22}, {12, 42}})));
        Modelica.Blocks.Sources.CombiTimeTable reference(tableName = "UserProfilesOffice", fileName = "./Tables/J1615/UserProfilesOffice.txt", tableOnFile = false, table = [3600, 22; 7200, 22; 10800, 21.9; 14400, 21.9; 18000, 22; 21600, 22.2; 25200, 22.4; 28800, 24.4; 32400, 24.1; 36000, 24.4; 39600, 24.7; 43200, 24.9; 46800, 25.1; 50400, 25.2; 54000, 25.3; 57600, 26; 61200, 25.9; 64800, 24.3; 68400, 24.2; 72000, 24.1; 75600, 24.1; 79200, 24.1; 82800, 24.1; 86400, 24.1; 781200, 34.9; 784800, 34.8; 788400, 34.7; 792000, 34.6; 795600, 34.7; 799200, 34.8; 802800, 34.9; 806400, 36.9; 810000, 36.6; 813600, 36.8; 817200, 37; 820800, 37.2; 824400, 37.3; 828000, 37.4; 831600, 37.4; 835200, 38.1; 838800, 38; 842400, 36.4; 846000, 36.2; 849600, 36.1; 853200, 36.1; 856800, 36; 860400, 35.9; 864000, 35.9; 5101200, 44.9; 5104800, 44.8; 5108400, 44.7; 5112000, 44.6; 5115600, 44.6; 5119200, 44.6; 5122800, 44.8; 5126400, 46.7; 5130000, 46.3; 5133600, 46.5; 5137200, 46.7; 5140800, 46.8; 5144400, 46.9; 5148000, 47; 5151600, 47; 5155200, 47.6; 5158800, 47.5; 5162400, 45.8; 5166000, 45.6; 5169600, 45.4; 5173200, 45.4; 5176800, 45.3; 5180400, 45.2; 5184000, 45.1], columns = {2}, extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint) annotation(Placement(transformation(extent = {{78, 80}, {98, 99}})));
      equation
        referenceTemp = reference.y;
        simulationTemp = reducedModel.airload.port.T;
        connect(personsRadiative.port, HeatToStar.Therm) annotation(Line(points = {{30, -90}, {42.8, -90}}, color = {191, 0, 0}, smooth = Smooth.None));
        connect(outdoorTemp.y[1], varTemp.T) annotation(Line(points = {{-41, 32}, {-10, 32}}, color = {0, 0, 127}, smooth = Smooth.None));
        connect(windowRad.y, PrescribedSolarRad.u) annotation(Line(points = {{-75, 78}, {-60, 78}}, color = {0, 0, 127}, smooth = Smooth.None));
        connect(PrescribedSolarRad.solarRad_out, sunblind.Rad_In) annotation(Line(points = {{-41, 78}, {-29, 78}}, color = {255, 128, 0}, smooth = Smooth.None));
        connect(SolarRadWeightedSum.solarRad_out, reducedModel.solarRad_in) annotation(Line(points = {{17, 78}, {34, 78}, {34, 56.8}, {51.23, 56.8}}, color = {255, 128, 0}, smooth = Smooth.None));
        connect(varTemp.port, reducedModel.equalAirTemp) annotation(Line(points = {{12, 32}, {22, 32}, {22, 46.8}, {51.4, 46.8}}, color = {191, 0, 0}, smooth = Smooth.None));
        connect(infiltrationTemp.y, reducedModel.ventilationTemperature) annotation(Line(points = {{16.5, 1}, {16.5, 18.5}, {51.4, 18.5}, {51.4, 36.4}}, color = {0, 0, 127}, smooth = Smooth.None));
        connect(infiltrationRate.y, reducedModel.ventilationRate) annotation(Line(points = {{40.5, 1}, {40.5, 14.5}, {58.2, 14.5}, {58.2, 30}}, color = {0, 0, 127}, smooth = Smooth.None));
        connect(personsConvective.port, reducedModel.internalGainsConv) annotation(Line(points = {{30, -62}, {68.4, -62}, {68.4, 30}}, color = {191, 0, 0}, smooth = Smooth.None));
        connect(machinesConvective.port, reducedModel.internalGainsConv) annotation(Line(points = {{30, -42}, {68.4, -42}, {68.4, 30}}, color = {191, 0, 0}, smooth = Smooth.None));
        connect(HeatToStar.Star, reducedModel.internalGainsRad) annotation(Line(points = {{61.1, -90}, {78, -90}, {78, 30}, {78.09, 30}}, color = {95, 95, 95}, pattern = LinePattern.None, smooth = Smooth.None));
        connect(sunblind.Rad_Out, SolarRadWeightedSum.solarRad_in) annotation(Line(points = {{-11, 78}, {-1, 78}}, color = {255, 128, 0}, smooth = Smooth.None));
        connect(innerLoads.y[3], machinesConvective.Q_flow) annotation(Line(points = {{-37, -62}, {-18, -62}, {-18, -42}, {10, -42}}, color = {0, 0, 127}, smooth = Smooth.None));
        connect(innerLoads.y[2], personsConvective.Q_flow) annotation(Line(points = {{-37, -62}, {10, -62}}, color = {0, 0, 127}, smooth = Smooth.None));
        connect(innerLoads.y[1], personsRadiative.Q_flow) annotation(Line(points = {{-37, -62}, {-18, -62}, {-18, -90}, {10, -90}}, color = {0, 0, 127}, smooth = Smooth.None));
        annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), experiment(StartTime = 3600, StopTime = 5.184e+006, Interval = 3600, __Dymola_Algorithm = "Lsodar"), __Dymola_experimentSetupOutput(events = false), Documentation(revisions = "<html>
 <p><i>February 2014</i>, by Peter Remmen:</p><p>Implemented</p>
 </html>",       info = "<html>
 <p>Test Case 5 of the VDI6007: <a name=\"result_box\">C</a>alculation of the reaction indoor temperature to radiant and convective heat source for Type room S</p>
 <ul>
 <li>daily input for outdoor temperature </li>
 <li>no shortwave radiation on the outer wall</li>
 <li>shortwave radiation through the window</li>
 <li>sunblind is closed at &GT;100W/m&sup2;, behind the window</li>
 <li>no longwave radiation exchange between outer wall, window and ambience</li>
 </ul>
 <p>Reference: Room air temperature</p>
 <p>Variable path: <code>reducedModel.airload.T</code></p>
 <p><br><br>All values are given in the VDI 6007-1.</p>
 <p>Same Test Case exists in VDI 6020.</p>
 </html>"),       Icon(graphics));
      end TestCase_5;
    end VDI6007;
  end Validation;
end LowOrder;
