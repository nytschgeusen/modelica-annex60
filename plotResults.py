from buildingspy.io.outputfile import Reader
import matplotlib.pyplot as plt
import os
import sys

o=Reader("Annex60.Fluid.Sensors.Examples.MoistAirEnthalpyFlowRate_res.mat", "dymola")

(oT, wrong)    = o.values("senHLat_flow.wrong")
(dT, hMed_out) = o.values("senHLat_flow.hMed_out")

fig = plt.figure()
ax = fig.add_subplot(111)
ax.plot(oT, wrong, 'r', label="wrong")
ax.plot(dT, hMed_out, 'b', label="hMed_out")
ax.set_xlabel("time [s]")
ax.set_ylabel('h')
ax.legend()
plt.savefig('plot.png')
