within Annex60.Experimental.ThermalZones.ReducedOrder.ROM;
package UsersGuide "User's Guide"
  extends Modelica.Icons.Information;


annotation (Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">The </span><code>Annex60.ThermalZones.ReducedOrder.ROM</code><span style=\"font-family: MS Shell Dlg 2;\"> package contains models for reduced building physics of thermal zones, reduced by means of number of wall elements and number of RC-elements per wall (and by means of spatial discretization). Such a reduction leads to a reduced order by means of state variables. Reduced order models are commonly used when simulating multiple buildings (e.g. district scale) or for model predictive control, where simulation speed outweighs high dynamic accuracy. However, you can choose between models with one to four wall elements and you can define the number of RC-elements per wall for each wall (by defining <i>n<sub>k </i></sub>, which is the length of the vectors for resistances <i>R<sub>k</i></sub> and capacitances <i>C<sub>k</i></sub>).</span></p>
<p>All models within this package are based on thermal networks and use chains of thermal resistances and capacitances to reflect heat transfer and heat storage. Thermal network models generally focus on one-dimensional heat transfer calculations. A geometrically correct representation of all walls of a thermal zone is thus not mandatory. To reduce simulation effort, it is furthermore reasonable to aggregate walls to representative elements with similar thermal behaviour. Which number of wall elements is sufficient depends on the thermal properties of the walls and their excitation (e.g. through solar radiation), in particular on the excitation frequencies. The same applies for the number of RC-elements per wall.</p>
<p>For multiple buildings, higher accuracy (by higher discretization) can come at the price of significant computational overhead. Furthermore, the achieved accuracy is not necessarily higher in all cases. For cases in which only little input data is available, the increased discretization sometimes only leads to a pseudo-accuracy based on large uncertainties in data acquisition.</p>
<p>The architecture of all models within this package is defined in the German Guideline VDI 6007 Part 1. This guideline describes a dynamic thermal building models for calculations of indoor air temperatures and heating/cooling power.</p>
<h4>Architecture</h4>
<p><span style=\"font-family: MS Shell Dlg 2;\">Each wall element uses either <a href=\"Annex60.Experimental.ThermalZones.ReducedOrder.ROM.BaseClasses.ExtMassVarRC\">ExtMassVarRC</a> or <a href=\"Annex60.Experimental.ThermalZones.ReducedOrder.ROM.BaseClasses.IntMassVarRC\">IntMassVarRC</a> to describe heat conduction and storage within the wall, depending if the wall contributes to heat transfer to the outdoor environment (exterior walls) or can be considered as simple heat storage elements (interior walls). The number of RC-elements per wall is hereby up to the user. All exterior walls and windows provide a heat port to the outside. All wall elements (exterior walls, windows and interior walls) are connected via <a href=\"Modelica.Thermal.HeatTransfer.Components.Convection\">convective heat exchange</a> to the convective network and the indoor air.</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Heat transfer through windows and solar radiation transmission are handled seperately to each other. The heat transfer element for the windows facilitates no thermal capacity as windows are often regarded as mass-free. For that, it is not necessary to discretize the window element and heat conduction is simply handled by a thermal resistance. Transmission of solar radiation through windows is split up into two parts. One part is connected to the indoor radiative heat exchange mesh network using a <a href=\"Annex60.Experimental.ThermalZones.ReducedOrder.ROM.BaseClasses.ThermSplitter\">ThermSplitter</a> while the other part is drectly linked to the convective network. The split factor </span><code>ratioWinConRad </code><span style=\"font-family: MS Shell Dlg 2;\">is a window property and depends on the glazing and used materials. For solar radiation through windows, the area </span><code>ATransparent </code><span style=\"font-family: MS Shell Dlg 2;\">is used. In most cases, this should be equal to </span><code>AWin,</code><span style=\"font-family: MS Shell Dlg 2;\">but there might be cases (e.g. windows are lumped with exterior walls and solar radiation is present) where e.g. </span><code>AWin </code><span style=\"font-family: MS Shell Dlg 2;\">is equal to zero and </span><code>ATransparent </code><span style=\"font-family: MS Shell Dlg 2;\">is equal to the actual window area.</span></p>
<h4>Design decisions</h4>
<p>Regarding indoor radiative heat exchange, a couple of design decisions simplify modelling as well as the system&apos;s numerics:</p>
<ul>
<li><span style=\"font-family: MS Shell Dlg 2;\">Instead of using Stefan&apos;s Law for radiation exchange (</span><code>Q=&epsilon;&sigma; T<sub>1<sup>4<sub>-T2<sup>4</sup></code> ), the models use a linearized approach (<code>Q=&alpha;<sub>rad</sub>(T<sub>1</sub>-T<sub>2</sub>)</code> ), introducing <code>alpharad</code>, often set according to:<code>&alpha;<sub>rad</sub>=4&epsilon;&sigma;T<sub>m<sup>3 </sup></code>with <i>T<sub>m</i></sub> being a mean constant temperature of the interacting surfaces.</li>
<li>Indoor radiation exchange is modelled using a mesh network, each wall is linked via one resistance with each other wall. Alternatively, one could use a star network, where each wall is connected via a resistance to a virtual radiation node. However, for cases with more than three elements and a linear approach, a mesh network cannot be transformed to a star network without introducing deviations.</li>
<li><span style=\"font-family: MS Shell Dlg 2;\">Although internal as well as external gains count as simple heat flows, solar radiation uses a real input, while internal gains utilize two heat ports, one for convective and one for radiative gains. Considering solar radiation typically requires several models upstream to calculate angle-dependent irradiation or window models. We decided to keep that seperately to the thermal zone model. Thus, solar radiation is handled as a basic </span><code>RadiantEnergyFluenceRate</code><span style=\"font-family: MS Shell Dlg 2;\">. For internal gains, the user might need to distinguish between convective and radiative heat sources.</span></li>
<li><span style=\"font-family: MS Shell Dlg 2;\">For an exact consideration, each element participating at radiative heat exchange need to have a temperature and an area. For solar radiation and radiative internal gains, it is common to define the heat flow independently of temperature and thus of area as well, assuming that that the temperature of the source is high compared to the wall surface temperatures. By using a <a href=\"Annex60.Experimental.ThermalZones.ReducedOrder.ROM.BaseClasses.ThermSplitter\">ThermSplitter</a> that distributes the heat flow of the source over the walls according to their area, we support this simplified approach.</span></li>
</ul>
<p><br><span style=\"font-family: MS Shell Dlg 2;\">The concept is described in VDI 6007. All equations can be found in VDI 6007. All outer walls and inner walls (including the windows) are merged together to one wall respectively. The inner walls are used as heat storages only, there is no heat transfer out of the zone (adiabate). This assumption is valid as long as the walls are in the zone or touch zones with a similar temperature. All walls, which touch other thermal zones are put together in the outer walls, which have an heat transfer with <a href=\"AixLib.Building.LowOrder.BaseClasses.EqAirTemp\">EqAirTemp</a>.</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2;\">Assumption and limitations</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">The simplifications are based on the VDI 6007, which describes the thermal behaviour of a thermal zone with the equations for an electric circuit, hence they are equal. The heat transfer is described with resistances and the heat storage with capacitances. </span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2;\">Typical use and important parameters</span></b></p>
<p><br><span style=\"font-family: MS Shell Dlg 2;\">The resolution of the model is very rough (only one air node), so the model is primarly thought for computing the air temperature of the room and with that, the heating and cooling load. It is more a heat load generator than a full building model. It is thought mainly for city district simulations, in which a lot of buildings has to be taken into account and the specific cirumstances in one building can be neglected.</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Inputs: The model needs the outdoor air temperature and the Infiltration/VentilationRate for the Ventilation, the equivalent outdoor temperature (see <a href=\"AixLib.Building.LowOrder.BaseClasses.EqAirTemp.partialEqAirTemp\">EqAirTemp</a>) for the heat conductance through the outer walls and the solar radiation through the windows. There are two ports, one thermal, one star, for inner loads, heating etc. . </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Parameters: Inner walls: R and C for the heat conductance and storage in the wall, A, alpha and epsilon for the heat transfer. Outer walls: Similar to inner walls, but with two R&apos;s, as there is also a conductance through the walls. Windows: g, A, epsilon and a splitfac. Please see VDI 6007 for computing the R&apos;s and C&apos;s</span></p>
</html>"));
end UsersGuide;