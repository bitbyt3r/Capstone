#!/usr/bin/python
import xmlrpc.client
import time
import sys

motors = xmlrpc.client.ServerProxy("http://derpy.hackafe.net:5000/")

def move(x,y):
  motors.move(x,y)

x = float(sys.argv[1])
y = float(sys.argv[2])
move(x,y)
