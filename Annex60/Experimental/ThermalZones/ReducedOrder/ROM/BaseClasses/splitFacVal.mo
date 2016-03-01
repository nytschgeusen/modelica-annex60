within Annex60.Experimental.ThermalZones.ReducedOrder.ROM.BaseClasses;
function splitFacVal "Values for splitFactor in ROM"

  input Integer dimension "Dimension of output vector";
  input Modelica.SIunits.Area[:] AArray "Vector of areas";
  output Real[dimension] splitFacValues "Shares of areas at total area";
  parameter Modelica.SIunits.Area ATot=sum(AArray) "Total area";
protected
  Integer j=1;
algorithm
    for A in AArray loop
      if A > 0 then
        splitFacValues[j] :=A/ATot;
        j :=j + 1;
      end if;
    end for;

  annotation (Documentation(info="<html>
<p>Calculates the share of an area of a wall on the total wall area for a zone if the area of the wall is not zero.</p>
</html>", revisions="<html>
<ul>
<li><span style=\"font-family: MS Shell Dlg 2;\">December 15, 2015 by Moritz Lauster:<br>First Implementation. </span></li>
</ul>
</html>"));
end splitFacVal;