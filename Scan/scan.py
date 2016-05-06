#!/usr/bin/python
import xmlrpc.client
import time
import sys

capture = xmlrpc.client.ServerProxy("http://mod.hackafe.net:8000/")
motors = xmlrpc.client.ServerProxy("http://localhost:5000/")

xstep = 1.0/12
ystep = 1.0/12
xsize = 10
ysize = 8

start_time = time.time()

print("Scan volume is {xnum} x {ynum} points".format(xnum=int(xsize/xstep), ynum=int(ysize/ystep)))

def move(x,y):
  try:
    motors.move(x,y)
  except:
    try:
      motors.move(x,y)
    except:
      pass
move(0,0)

def scan(x,y):
  step_time = time.time()
  print("Scanning at {x}, {y}".format(x=x*xstep, y=y*ystep))
  move(x*xstep,y*ystep)
  print("  Moving took {0:.1f} seconds".format(time.time() - step_time))
  time.sleep(0.2)
  step_time = time.time()
  try:
    capture.readADC(sys.argv[1], "{0}x{1}".format(x, y))
  except:
    try:
      capture.readADC(sys.argv[1], "{0}x{1}".format(x, y))
    except:
      pass
  print("  Saving took {0:.1f} seconds".format(time.time()-step_time))


for x in range(int(xsize/(2*xstep))):
  for y in range(0, int(ysize/ystep), 1):
    scan(2*x,y)
  for y in range(int(ysize/ystep)-1, -1, -1):
    scan(2*x+1,y)
