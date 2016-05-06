#!/usr/bin/python
import xmlrpc.server
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

currentx = 0 
currenty = 0

#distance = 10
distance = 10.333
scale1 = 105*1.5484
scale2 = 105*1.4265

currentm1 = int(math.sqrt(currentx**2+currenty**2)*scale1)
currentm2 = int(math.sqrt((currentx-distance)**2+currenty**2)*scale2)
print("Starting with motors at m1:{0}, m2:{1}".format(currentm1, currentm2))

def move(x,y):
  y = y+1
  global currentm1
  global currentm2
  print("Moving to {0}, {1}".format(x,y))
  m1 = int(math.sqrt(math.pow(x,2)+math.pow(y,2))*scale1)
  m2 = int(math.sqrt(math.pow((x-distance),2)+math.pow(y,2))*scale2)
  dm1 = m1 - currentm1
  dm2 = m2 - currentm2
  currentm1 = m1
  currentm2 = m2
  print("Destination x,y = ({x},{y})".format(x=x, y=y))
  print("Moving right {dm1} and left {dm2}".format(dm1=dm1, dm2=dm2))
  print("Destination right {m1} and left {m2}".format(m1=m1, m2=m2))
  Moving = True
  move1 = abs(dm1)
  if dm1 > 0:
    dir1 = "a".encode('ASCII')
  else:
    dir1 = "c".encode('ASCII')
  move2 = abs(dm2)
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
  return True

server = xmlrpc.server.SimpleXMLRPCServer(("0.0.0.0", 5000))
print("Listening on port 5000")
server.register_function(move, "move")
server.serve_forever()
