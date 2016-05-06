from SimpleXMLRPCServer import SimpleXMLRPCServer
from PyDAQmx import *
import numpy
import os

NUM_CHANNELS = 32
MAX_RATE = 1000000
SAMPLE_RATE = int(MAX_RATE/NUM_CHANNELS)
CHANNELS = "Dev1/ai0:31"
PERIOD = 1

MAX_VAL = 1.0
MIN_VAL = -1.0

read = int32()
num_samples = int(PERIOD*SAMPLE_RATE)
data = numpy.zeros((num_samples*NUM_CHANNELS,), dtype=numpy.float64)

dataserver = xmlrpclib.ServerProxy("http://piro.hackafe.net:5000/")

print("Using sample rate {sr}".format(sr=SAMPLE_RATE))

def readADC(dirpath, filename):
    global data
    analog_input = Task()
    analog_input.CreateAIVoltageChan(CHANNELS, "", DAQmx_Val_Cfg_Default, MIN_VAL, MAX_VAL, DAQmx_Val_Volts, None)
    analog_input.CfgSampClkTiming("", SAMPLE_RATE, DAQmx_Val_Rising, DAQmx_Val_FiniteSamps, num_samples)
    analog_input.StartTask()
    analog_input.ReadAnalogF64(num_samples, 10.0, DAQmx_Val_GroupByChannel, data, num_samples*NUM_CHANNELS, byref(read), None)

    print("Captured {i} samples from {c} channels".format(i=read.value, c=NUM_CHANNELS))
    savepath = os.path.join("e:/scans/", dirpath, filename)
    directory = os.path.join("e:/scans/", dirpath)
    if not os.path.exists(directory):
        os.makedirs(directory)
    numpy.savez_compressed(savepath, data.reshape(32, read.value))
    analog_input.StopTask()
    with open(savepath, "r") as SAVE_FILE:
      dataserver.save(SAVE_FILE, filename)
    return True

server = SimpleXMLRPCServer(("0.0.0.0", 8000))
print("Listening on port 8000")
server.register_function(readADC, "readADC")
server.serve_forever()
