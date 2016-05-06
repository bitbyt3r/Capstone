#!/usr/bin/python
import matplotlib.pyplot as plt
import json
import math
import time

start = time.time()

with open("./output.json", "r") as FH:
  data = json.loads(FH.read())

listdata = [[0]*108 for i in range(120)]

min = 1000
minpos = (0,0)
max = 0
maxpos = (0,0)

for i in data.keys():
  x,y = [int(x) for x in i.split("x")]
  listdata[x][y] = data[i]
  if data[i] < min:
    min = data[i]
    minpos = [int(x) for x in i.split("x")]
  if data[i] > max:
    max = data[i]
    maxpos = [int(x) for x in i.split("x")]

print("Min: {0}, Max: {1}".format(min, max))
print("Min at {0}, {1}".format(minpos[0], minpos[1]))
print("Max at {0}, {1}".format(maxpos[0], maxpos[1]))

min = 20*math.log(min, 10)
max = 20*math.log(max, 10)

print("Min: {0}dB, Max: {1}dB".format(min, max))
print("Difference: {0}dB".format(max-min))

fig, ax = plt.subplots()
heatmap = ax.pcolor(listdata)
stop = time.time()
print("Generation finished in {0}".format(stop-start))
plt.show()
