within Annex60.Experimental.ThermalZones.ReducedOrder.Validation;
model VDI6007TestCase2Star4EL "VDI 6007 Test Case 2 model"

  ROM.Star.ThermalZoneFourElements
                             thermalZoneTwoElements(
    VAir=52.5,
    alphaExt=2.7,
    alphaWin=2.7,
    gWin=1,
    nExt=1,
    nInt=1,
    AWin=0,
    AExt=10.5,
    ATransparent=0,
    ratioWinConRad=0,
    AInt=75.5,
    alphaInt=2.24,
    RWin=0.00000001,
    RExt={0.004367913},
    RExtRem=0.03895919719,
    CExt={1600800},
    RInt={0.000595515},
    CInt={14836200.63},
    volAir(X_start={0,0}),
    alphaRad=5,
    radExtWallStar(G=min(thermalZoneTwoElements.AExt, thermalZoneTwoElements.AInt)
          *thermalZoneTwoElements.alphaRad*2),
    radIntWallStar(G=min(thermalZoneTwoElements.AExt, thermalZoneTwoElements.AInt)
          *thermalZoneTwoElements.alphaRad*2),
    T_start=295.15,
    AFloor=10.5,
    alphaFloor=2.7,
    nFloor=1,
    RFloor={0.004367913},
    RFloorRem=0.03895919719,
    CFloor={1600800},
    ARoof=10.5,
    alphaRoof=2.7,
    nRoof=1,
    RRoof={0.004367913},
    RRoofRem=0.03895919719,
    CRoof={1600800})
    annotation (Placement(transformation(extent={{44,-2},{92,34}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature
    prescribedTemperature(T=295.15)
    annotation (Placement(transformation(extent={{8,-6},{20,6}})));
  Modelica.Thermal.HeatTransfer.Components.Convection       thermalConductorWall
    annotation (Placement(transformation(extent={{36,6},{26,-4}})));
  Modelica.Blocks.Sources.CombiTimeTable internalGains(
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    table=[0,0; 3600,0; 7200,0; 10800,0; 14400,0; 18000,0; 21600,0; 21600,1000;
        25200,1000; 28800,1000; 32400,1000; 36000,1000; 39600,1000; 43200,1000;
        46800,1000; 50400,1000; 54000,1000; 57600,1000; 61200,1000; 64800,1000;
        64800,0; 68400,0; 72000,0; 75600,0; 79200,0; 82800,0; 86400,0],
    columns={2})
    annotation (Placement(transformation(extent={{6,-60},{22,-44}})));
  Modelica.Blocks.Sources.CombiTimeTable reference(
    tableOnFile=false,
    columns={2},
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    table=[3600,22; 7200,22; 10800,22; 14400,22; 18000,22; 21600,22; 25200,22.6;
        28800,22.9; 32400,23.1; 36000,23.3; 39600,23.5; 43200,23.7; 46800,23.9;
        50400,24.1; 54000,24.3; 57600,24.6; 61200,24.8; 64800,25; 68400,24.5;
        72000,24.5; 75600,24.5; 79200,24.5; 82800,24.5; 86400,24.5; 781200,37.7;
        784800,37.7; 788400,37.6; 792000,37.5; 795600,37.5; 799200,37.4; 802800,
        38; 806400,38.2; 810000,38.3; 813600,38.5; 817200,38.6; 820800,38.8;
        824400,38.9; 828000,39.1; 831600,39.2; 835200,39.4; 838800,39.5; 842400,
        39.7; 846000,39.2; 849600,39.1; 853200,39.1; 856800,39; 860400,38.9;
        864000,38.9; 5101200,50; 5104800,49.9; 5108400,49.8; 5112000,49.7;
        5115600,49.6; 5119200,49.5; 5122800,50; 5126400,50.1; 5130000,50.2;
        5133600,50.3; 5137200,50.5; 5140800,50.6; 5144400,50.7; 5148000,50.8;
        5151600,50.9; 5155200,51; 5158800,51.1; 5162400,51.2; 5166000,50.7;
        5169600,50.6; 5173200,50.4; 5176800,50.3; 5180400,50.2; 5184000,50.1])
    annotation (Placement(transformation(extent={{76,72},{96,92}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow machinesConv
    annotation (Placement(transformation(extent={{48,-84},{68,-64}})));

  Modelica.Thermal.HeatTransfer.Celsius.TemperatureSensor indoorTemp
    annotation (Placement(transformation(extent={{96,-20},{88,-12}})));
  Modelica.Blocks.Sources.Constant alphaWall(k=25*10.5)
    "Outdoor coefficient of heat transfer for walls" annotation (Placement(
        transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={30,-18})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{20,26},{30,36}})));
equation
  connect(thermalConductorWall.fluid, prescribedTemperature.port)
    annotation (Line(points={{26,1},{24,1},{24,0},{20,0}}, color={191,0,0}));
  connect(thermalZoneTwoElements.extWall, thermalConductorWall.solid)
    annotation (Line(points={{45,12.4},{40,12.4},{40,1},{36,1}}, color={191,0,0}));
  connect(alphaWall.y, thermalConductorWall.Gc)
    annotation (Line(points={{30,-13.6},{31,-13.6},{31,-4}}, color={0,0,127}));
  connect(const.y, thermalZoneTwoElements.solRad) annotation (Line(points={{
          30.5,31},{37.25,31},{37.25,30.8},{45,30.8}}, color={0,0,127}));
  connect(internalGains.y[1], machinesConv.Q_flow) annotation (Line(points={{
          22.8,-52},{36,-52},{36,-74},{48,-74}}, color={0,0,127}));
  connect(machinesConv.port, thermalZoneTwoElements.intGainsRad) annotation (
      Line(points={{68,-74},{84,-74},{98,-74},{98,26},{91,26}}, color={191,0,0}));
  connect(thermalZoneTwoElements.intGainsConv, indoorTemp.port)
    annotation (Line(points={{91,19.8},{96,19.8},{96,-16}}, color={191,0,0}));
  connect(thermalConductorWall.solid, thermalZoneTwoElements.floor) annotation
    (Line(points={{36,1},{40,1},{40,-20},{66.8,-20},{66.8,-1}}, color={191,0,0}));
  connect(thermalConductorWall.solid, thermalZoneTwoElements.roof) annotation (
      Line(points={{36,1},{40,1},{40,46},{66.8,46},{66.8,33}}, color={191,0,0}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})), Documentation(info="<html>
<p>For this example, the following boundary conditions are taken from Guideline VDI 6007:</p>
<ul>
<li><span style=\"font-family: MS Shell Dlg 2;\">Dry bulb temperature</span></li>
<li><span style=\"font-family: MS Shell Dlg 2;\">Infrared horizontal radiation</span></li>
<li><span style=\"font-family: MS Shell Dlg 2;\">Global normal radiation</span></li>
<li><span style=\"font-family: MS Shell Dlg 2;\">Diffuse normal radiation</span></li>
<li><span style=\"font-family: MS Shell Dlg 2;\">Internal radiative gains from persons</span></li>
<li><span style=\"font-family: MS Shell Dlg 2;\">Internal convective gains from persons</span></li>
<li><span style=\"font-family: MS Shell Dlg 2;\">Internal convective gains from machines</span></li>
</ul>
<p><br><span style=\"font-family: MS Shell Dlg 2;\">The guideline is also the source of the building physics, orientations, areas, set temperatures and reference values. As global and diffuse radiation are given in the guideline normal to the facades and are here used as normal to the sun, this example cannot be taken for validation. In addition, the calculation core is not configured to be exactly the VDI 6007 core. In this example, the windows are not merged with the exterior walls. The reference values are taken from test case 8. This case doesn&apos;t consider outdoor longwave radiation exchange but this example does. Furthermore, the test case considers sunblinds (closing at 100 w/m2) what is not included in this example. It&apos;s just to show a typical application.</span></p>
</html>"),
    experiment(
      StopTime=3.1536e+007,
      Interval=3600,
      __Dymola_Algorithm="Lsodar"),
    __Dymola_experimentSetupOutput);
end VDI6007TestCase2Star4EL;
