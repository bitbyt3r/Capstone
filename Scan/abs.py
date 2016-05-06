#!/usr/bin/python
import serial
import math
import sys
import os

serialport = ""
for i in os.listdir("/dev/"):
  if "ttyACM" in i:
    serialport = i
if serialport:
  ser = serial.Serial("/dev/"+serialport)
  print("Using serialport {s}".format(s=serialport))
else:
  sys.exit("Failed to open serialport")

dm1 = float(sys.argv[1])
dm2 = float(sys.argv[2])

scale1 = 105*1.5484
scale2 = 105*1.4265

Moving = True
move1 = int(abs(dm1*scale1))
if dm1 > 0:
  dir1 = "a".encode('ASCII')
else:
  dir1 = "c".encode('ASCII')
move2 = int(abs(dm2*scale2))
if dm2 > 0:
  dir2 = "b".encode('ASCII')
else:
  dir2 = "d".encode('ASCII')
while Moving:
  print("{move1}, {move2}                    ".format(move1=move1, move2=move2), end="\r")
  Moving = False
  if move1:
    ser.write(dir1)
    move1 -= 1
    Moving = True
    ser.read()
  if move2:
    ser.write(dir2)
    move2 -= 1
    Moving = True
    ser.read()

