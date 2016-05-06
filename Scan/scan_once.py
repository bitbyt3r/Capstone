#!/usr/bin/python
import xmlrpc.client
import time
import sys

capture = xmlrpc.client.ServerProxy("http://mod.hackafe.net:8000/")

capture.readADC(sys.argv[1], "scan")
