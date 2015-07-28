within Annex60.Experimental.Benchmarks.Utilities.Examples;
model PerformanceSpliceInline
  "Testing the performance of spliceFunction for comparison with regStep "
  extends Modelica.Icons.Example;

  parameter Integer nPar = 1000 "Number of parallel tests";

  Modelica.Blocks.Sources.Sine sine[nPar](each freqHz=0.01)
    "Sine input for function under test"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));

  Real out[nPar] "Output variable from function under test";

equation
  for i in 1:nPar loop
    out[i] =
      Annex60.Experimental.Benchmarks.Utilities.FunctionsInlined.spliceFunctionInline(
      pos=1,
      neg=-1,
      x=sine[i].y,
      deltax=1e-5);
  end for;
  annotation (experiment(StopTime=10000, Interval=1),
      __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p>This benchmark tests the computation time of using 
<a href=\"modelica://Modelica.Media.Air.MoistAir.Utilities.spliceFunction\">
Modelica.Media.Air.MoistAir.Utilities.spliceFunction</a>
for comparison with <a href=\"modelica://Modelica.Fluid.Utilities.regStep\">
Modelica.Fluid.Utilities.regStep</a>. 
A value of <code>nPar = 1000</code> ensures that more computation 
time is used for the auxiliary code of the functions than for 
overhead outside of model.</p>
</html>", revisions="<html>
<ul>
<li>
July 20, 2015, by Marcus Fuchs:<br/>
First implementation.
</li>
</ul>
</html>"));
end PerformanceSpliceInline;
