#!/usr/bin/env python

import sys, os
import itertools, operator
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np

def get_params_from_basename(basename):
	tokens = basename.split('.')
	grain = tokens[0]
	input_size = 'ref'
	threads = int(tokens[1].split('-')[0].split('_')[1])
	bench = tokens[1].split('-')[1]
	return (grain, input_size, threads, bench)

def get_cycles_from_output_file(output_file):
	time = -999
	fp = open(output_file, "r")
	line = fp.readline()
	while line:
		if "Execution" in line:
			time = float(line.split()[1].split(':')[1])
		line = fp.readline()

	fp.close()
	return time

def tuples_by_bench(tuples):
	ret = []
	tuples_sorted = sorted(tuples, key=operator.itemgetter(0))
	for key,group in itertools.groupby(tuples_sorted,operator.itemgetter(0)):
		ret.append((key, zip(*map(lambda x: x[1:], list(group)))))
	return ret

global_threads = [1,2]

if len(sys.argv) < 2:
	print "usage:", sys.argv[0], "<output_directories>"
	sys.exit(1)

results_tuples = []

for dirname in sys.argv[1:]:
	if dirname.endswith("/"):
		dirname = dirname[0:-1]
	basename = os.path.basename(dirname)
	output_file = dirname + "/real_system_times.txt"

	(grain, input_size, threads, bench) = get_params_from_basename(basename)
	time = get_cycles_from_output_file(output_file)
	results_tuples.append((bench, threads, time))


markers = ['.', 'o', 'v', '*', 'D']
fig = plt.figure()
plt.grid(True)
ax = plt.subplot(111)
ax.set_xlabel("$Number$ $of$ $threads$")
ax.set_ylabel("$Time$ $(sec)$")

i = 0
tuples_by_bench = tuples_by_bench(results_tuples)
for tuple in tuples_by_bench:
	bench = tuple[0]
	thread_axis = tuple[1][0]
	time_axis = tuple[1][1]
	x_ticks = np.arange(0, len(global_threads), 1)
	x_labels = map(str, global_threads)
	ax.xaxis.set_ticks(x_ticks)
	ax.xaxis.set_ticklabels(x_labels)

	print x_ticks
	print time_axis
	ax.plot(x_ticks, time_axis, label=str(bench), marker=markers[i%len(markers)])
	i = i + 1

lgd = ax.legend(ncol=len(tuples_by_bench), bbox_to_anchor=(1.0, -0.13), prop={'size':8})
plt.title(grain)
plt.savefig(grain+'-'+input_size+'.cycles.png', bbox_extra_artists=(lgd,), bbox_inches='tight')
