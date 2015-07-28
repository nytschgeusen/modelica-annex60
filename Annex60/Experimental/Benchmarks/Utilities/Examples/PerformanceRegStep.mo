within Annex60.Experimental.Benchmarks.Utilities.Examples;
model PerformanceRegStep
  "Testing the performance of regStep function for comparison with spliceFunction"
  extends Modelica.Icons.Example;

  parameter Integer nPar = 1000 "Number of parallel tests";

  Modelica.Blocks.Sources.Sine sine[nPar](each freqHz=0.01)
    "Sine input for function under test"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));

  Real out[nPar] "Output variable from function under test";

equation
  for i in 1:nPar loop
    out[i] = Modelica.Fluid.Utilities.regStep(sine[i].y, 1, -1, 1e-5);
  end for;
  annotation (
    experiment(StopTime=10000, Interval=1),
    Documentation(info="<html>
<p>This benchmark tests the computation time of using 
<a href=\"modelica://Modelica.Fluid.Utilities.regStep\">
Modelica.Fluid.Utilities.regStep</a>
for comparison with 
<a href=\"modelica://Modelica.Media.Air.MoistAir.Utilities.spliceFunction\">
Modelica.Media.Air.MoistAir.Utilities.spliceFunction</a>. 
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
end PerformanceRegStep;
