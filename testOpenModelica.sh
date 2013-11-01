# Run this file from a directory that contains the Annex60 directory.

##export OPENMODELICALIBRARY=`pwd`:/usr/local/Modelica/Library:/usr/lib/omlibrary
export OPENMODELICALIBRARY=`pwd`:/usr/lib/omlibrary
# 9/10/13. removed flag: omc +d=scodeInstShortcut openmod.mos
omc +d=initialization openmod.mos