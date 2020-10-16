#!/usr/bin/env python

## both for energy, edp and area

import sys, os
import itertools, operator
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np

x_axis=[]
y_axis=[]

def get_ipc_from_output_file(output_file):
	time = -999
	fp = open(output_file, "r")
	line = fp.readline()
	while line:
		if "Time" in line:
			time = float(line.split()[3])
		line = fp.readline()

	fp.close()
	return time
	
def get_ipc_from_output_file1(output_file1):
	energy = -999
	fp = open(output_file1, "r")
	line = fp.readline()
	while line:
		if "total" in line:
			energy = float(line.split()[3])
		line = fp.readline()

	fp.close()
	return energy	

for dirname in sys.argv[1:]:
	if dirname.endswith("/"):
		dirname = dirname[0:-1]
	basename = os.path.basename(dirname)
	output_file = dirname + "/sim.out"
	output_file1 = dirname + "/power.total.out"
	
	tokens = basename.split('.')
	name =tokens[0]
	bench = tokens[2]
	time = get_ipc_from_output_file(output_file)
	energy = get_ipc_from_output_file1(output_file1)
	y_axis.append(time*energy/1000000)
	x_axis.append(bench)
		
fig, ax1 = plt.subplots()
plt.grid(True)
xAx = np.arange(len(x_axis))
ax1.xaxis.set_ticks(np.arange(0, len(x_axis), 1))
ax1.set_xticklabels(x_axis, rotation=60)
ax1.set_xlim(-0.5, len(x_axis) - 0.5)
#ax1.set_ylim(min(y_axis) - 1, max(y_axis) + 3)
ax1.set_xlabel("$share$ $all$                     $share$ $l3$                     $share$ $nothing$")
ax1.set_ylabel("$EDP$ $(Joule*msec)$")
ax1.bar(xAx,y_axis, width=0.2, color="red",align='center')

plt.title("EDP on each topology")
plt.savefig('EDP.png',bbox_inches="tight")	
