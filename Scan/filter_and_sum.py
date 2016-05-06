#!/usr/bin/python
import os
import sys
import json
import time
import numpy
import scipy
from scipy.signal import butter, lfilter

sample_rate = 31250
frequency = 5000
trim = 500
duration = 10000
order = 5
start = time.time()

def butter_bandpass(lowcut, highcut, fs, order=5):
    nyq = 0.5 * fs
    low = lowcut / nyq
    high = highcut / nyq
    b, a = butter(order, [low, high], btype='band')
    return b, a

def butter_bandpass_filter(data, lowcut, highcut, fs, order=5):
    b, a = butter_bandpass(lowcut, highcut, fs, order=order)
    y = lfilter(b, a, data)
    return y

def test(filepath):
  data = numpy.load(filepath)
  avg = int(20 * sample_rate / frequency)
  x = numpy.convolve(numpy.abs(data[0]), numpy.ones((avg,))/avg, mode='full')

  derivative = numpy.diff(x)
  steploc = numpy.argmax(derivative[trim:-1*trim]) + trim
  steptime = 2 * (steploc / len(x))

  interesting = [x[steploc:steploc+duration] for x in data]
  sum = numpy.sum(interesting, axis=0)

  lowcut = frequency - 100
  highcut = frequency + 100
  filtered = butter_bandpass_filter(sum, lowcut, highcut, sample_rate, order=order)

  return filepath, numpy.std(filtered)

count = len(os.listdir(sys.argv[1]))
iter = 0

results = {}
#for i in os.listdir(sys.argv[1]):
#  if i.endswith(".npy"):
#    result = test(os.path.join(sys.argv[1], i))    
#    results[i.split(".")[0]] = result
#    print("{0}: {1}: {2:.3f}".format(iter, i, result))
#    iter += 1

jobs = [x for x in os.listdir(sys.argv[1]) if x.endswith(".npy")]

p = Pool(10)
data = p.map(test, jobs)
stop = time.time()

for i in data:
  filename = i[0].split("/")[-1]
  results[filename.split(".")[0]] = i[1]

with open("./output.json", "w") as FH:
  FH.write(json.dumps(results))

print("Generation completed in {0}s".format(stop-start))
